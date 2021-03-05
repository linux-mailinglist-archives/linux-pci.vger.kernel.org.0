Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F7232EF07
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 16:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhCEPhU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 10:37:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:51420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230396AbhCEPhA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Mar 2021 10:37:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5713265090;
        Fri,  5 Mar 2021 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614958620;
        bh=rbMzPDjT4HmtnkJbeXK9PYCr8n58NGk1TLIuSFpw8Eo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=m/gXkHAkJUvzGM2T9xnIEc8FAETryEb4epzy7G+Arv9SWZOoKErj66y8yuyM3xJHl
         dPZyDkd2755T5pNKGi0XH6o8W3DVC7vfG9RNKg+6GNuYhHH4EmqXLNNC0UaVXu9oDF
         BAztiUdwXX6k5FWomitWLlVA4kKzmmIXa4XFUtn6rQN0EKwVoSNM2HfuGbpfNuuOXc
         +xdTE14BhKLfgqXsXG7nifm6J0fADs/BXqShOawJXr7Z0r96CmnUfv2PgbrTqmS8D7
         qX75HFPQ1iyf98NfdP3KHZu1rrKgKfarWpKJqDhWDCUMYckyujMUlD8tAnkfGFPUxr
         g/cVkZFYvw6mw==
Date:   Fri, 5 Mar 2021 09:36:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] PCI: mediatek: fix optional reset handling
Message-ID: <20210305153659.GA1098921@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305091715.4319-1-p.zabel@pengutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Ryder, Lorenzo, Rob, linux-mediatek (mediatek maintainers)]

Capitalize first word of subject per convention:

  PCI: mediatek: Fix optional reset handling

But "Fix" is pretty non-specific; it doesn't give any information
about what the change does.

On Fri, Mar 05, 2021 at 10:17:15AM +0100, Philipp Zabel wrote:
> As of commit bb475230b8e5 ("reset: make optional functions really
> optional"), the reset framework API calls use NULL pointers to describe
> optional, non-present reset controls.
> 
> This allows to unconditionally return errors from
> devm_reset_control_get_optional_exclusive.

"devm_reset_control_get_optional_exclusive()"

This basically restates the code change, but doesn't say *why* we want
this change.

> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 23548b517e4b..35c66fa770a6 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -954,7 +954,7 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
>  
>  	snprintf(name, sizeof(name), "pcie-rst%d", slot);
>  	port->reset = devm_reset_control_get_optional_exclusive(dev, name);
> -	if (PTR_ERR(port->reset) == -EPROBE_DEFER)
> +	if (IS_ERR(port->reset))
>  		return PTR_ERR(port->reset);

Before this patch,

  -EPROBE_DEFER:           abort probe, return -EPROBE_DEFER
  other errors:            port->reset = -EINVAL, etc, continue probe
                           future WARN_ON() from reset_control_assert()
  NULL (no reset control): port->reset = NULL, continue probe
  valid reset control:     port->reset = rstc, continue probe

After this patch,

  all errors:              abort probe, return err
  NULL (no reset control): port->reset = NULL, continue probe
  valid reset control:     port->reset = rstc, continue probe

So IIUC, if devm_reset_control_get_optional_exclusive() returns an
error other than -EPROBE_DEFER, e.g., -EINVAL, we used to continue.
We would then get warnings from reset_control_assert() and
reset_control_deassert() because "IS_ERR(port->reset)" was true.
Since the reset control seems to be optional, I assume the port *may*
still be usable even though we get warnings.

But after this patch, if devm_reset_control_get_optional_exclusive()
returns -EINVAL, we will fail the probe, rendering the port useless.

If my understanding is correct, this seems like a difference we should
mention in the commit log because it took me a while to untangle this
and the subject line doesn't hint at it at all.

>  	/* some platforms may use default PHY setting */
> -- 
> 2.29.2
> 

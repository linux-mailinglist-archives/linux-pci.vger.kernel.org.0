Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C34E8A7C6
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 22:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfHLUDn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 16:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfHLUDn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 16:03:43 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FA1C2085A;
        Mon, 12 Aug 2019 20:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565640222;
        bh=GE2uc8DsXU7pzt2uynwTyLx0aiMTS+SWVqK387zDgLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTxmfOEzyd/cGqq/WCxVdCV2pxwvgPKNLxH2/odHULV8Yrngp2bnELwYrHmOsovqI
         a1c/GhVq6Wa+EzK/dlwPivl64lbQ/D3TIDwm4/TivERTZS+SY4vUwt21yqvKuwSFGw
         eM9XFchK8o9kWjXK9MdOnTm3bvpgXBzpvaAHfU1s=
Date:   Mon, 12 Aug 2019 15:03:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: OF: fix a trivial typo in a doc comment
Message-ID: <20190812200336.GI11785@google.com>
References: <20190807132049.10304-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807132049.10304-1-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 07, 2019 at 03:20:49PM +0200, Lubomir Rintel wrote:
> Diverged from what the code does with commit 530210c7814e ("of/irq: Replace
> of_irq with of_phandle_args").
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Applied to pci/trivial for v5.4, thanks!

> ---
>  drivers/pci/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index bc7b27a28795d..36891e7deee34 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -353,7 +353,7 @@ EXPORT_SYMBOL_GPL(devm_of_pci_get_host_bridge_resources);
>  /**
>   * of_irq_parse_pci - Resolve the interrupt for a PCI device
>   * @pdev:       the device whose interrupt is to be resolved
> - * @out_irq:    structure of_irq filled by this function
> + * @out_irq:    structure of_phandle_args filled by this function
>   *
>   * This function resolves the PCI interrupt for a given PCI device. If a
>   * device-node exists for a given pci_dev, it will use normal OF tree
> -- 
> 2.21.0
> 

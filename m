Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23073203D25
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 18:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgFVQw6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 12:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbgFVQw5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 12:52:57 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CB7420707;
        Mon, 22 Jun 2020 16:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592844777;
        bh=t+IlrfZ0txrH96mjZ3AX99x53oPkQ0E7qqZlBrlngJI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LAOZECfRGx7DAOKstitrSP0q6DlJcu/eERuglIEQjVW8WGwmg5zZ/OIpUXPB+/zrH
         sQSBmCaBB55o5Tp/Y/FGXNl7r54HpgLlPm7aFLyDKsxjiVuPK/gsHWZQQwgMWsXzZW
         U3DK8OhlaePUrLFg0cG2NAElF+6II+P/T+2qfeEM=
Date:   Mon, 22 Jun 2020 11:52:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] pci: controller: cadence: fix wrong path in
 comment
Message-ID: <20200622165255.GA2275961@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622091520.9336-1-f.suligoi@asem.it>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please use "git log --oneline" to help construct the subject line.
Maybe:

  PCI: cadence-ep: Remove obsolete path from comment

On Mon, Jun 22, 2020 at 11:15:20AM +0200, Flavio Suligoi wrote:
> This comment still refers to the old driver pathname,
> when all PCI drivers were located directly under the
> drivers/pci directory.
> 
> Anyway the function name itself is enough, so we can
> remove the overabundant path reference.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I did not ack this.  Please don't add acks unless someone does so
explicitly.

> ---
> 
> v1: - after the suggestion of Bjorn, remove the whole comment line related to
>       the wrong path
>     - add: Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 1c15c8352125..690eefd328ea 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -276,7 +276,6 @@ static int cdns_pcie_ep_send_legacy_irq(struct cdns_pcie_ep *ep, u8 fn, u8 intx)
>  	cdns_pcie_ep_assert_intx(ep, fn, intx, true);
>  	/*
>  	 * The mdelay() value was taken from dra7xx_pcie_raise_legacy_irq()
> -	 * from drivers/pci/dwc/pci-dra7xx.c
>  	 */
>  	mdelay(1);
>  	cdns_pcie_ep_assert_intx(ep, fn, intx, false);
> -- 
> 2.17.1
> 

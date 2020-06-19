Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD1A201B4A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jun 2020 21:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388885AbgFSTbS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jun 2020 15:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388758AbgFSTbR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Jun 2020 15:31:17 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACF3321556;
        Fri, 19 Jun 2020 19:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592595077;
        bh=2vZl3YpAW0Af4EaK4iaA+JD2OKbiTxKGWLGtbaWrA4s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uZZ18+xU/JUp2i4ewDh19cMwVoZ5ejidjByHfIc5G/DlC/galABDNhx32TWKp0pqb
         m2o4TgEZGU1LkIGTpbHiWC3FTi80mB/VDVvIf+7Wgi3fJt4LFR4egGPJ+52ZsURJXg
         TVRXaeIvVEs0PeCIi2kwilYRD6K6Fz2GuINd+ruQ=
Date:   Fri, 19 Jun 2020 14:31:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pci: controller: cadence: fix wrong path in comment
Message-ID: <20200619193114.GA2187639@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619151134.29893-1-f.suligoi@asem.it>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 19, 2020 at 05:11:34PM +0200, Flavio Suligoi wrote:
> All native pci drivers are in drivers/pci/controller,
> but this comment still refers to the old pathname,
> when all pci drivers were located directly under the
> drivers/pci directory.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 1c15c8352125..2a48b34ff249 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -276,7 +276,7 @@ static int cdns_pcie_ep_send_legacy_irq(struct cdns_pcie_ep *ep, u8 fn, u8 intx)
>  	cdns_pcie_ep_assert_intx(ep, fn, intx, true);
>  	/*
>  	 * The mdelay() value was taken from dra7xx_pcie_raise_legacy_irq()
> -	 * from drivers/pci/dwc/pci-dra7xx.c
> +	 * from drivers/pci/controller/dwc/pci-dra7xx.c

I think the function name by itself would be enough, so maybe we
should remove the filename completely.

>  	 */
>  	mdelay(1);
>  	cdns_pcie_ep_assert_intx(ep, fn, intx, false);
> -- 
> 2.17.1
> 

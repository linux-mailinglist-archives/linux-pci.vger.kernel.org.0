Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2D3EFC13
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2019 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfD3PB4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Apr 2019 11:01:56 -0400
Received: from foss.arm.com ([217.140.101.70]:48710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfD3PBz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Apr 2019 11:01:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68A1D374;
        Tue, 30 Apr 2019 08:01:55 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D236B3F719;
        Tue, 30 Apr 2019 08:01:53 -0700 (PDT)
Date:   Tue, 30 Apr 2019 16:01:48 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: iproc: Enable iProc config read for PAXBv2
Message-ID: <20190430150148.GA6616@e121166-lin.cambridge.arm.com>
References: <1556270404-27058-1-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556270404-27058-1-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 26, 2019 at 02:50:04PM +0530, Srinath Mannam wrote:
> iProc config read flag has to enable for PAXBv2 instead of PAXB.
> 
> Fixes: f78e60a29d4ff ("PCI: iproc: Reject unconfigured physical functions from PAXC")
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>  drivers/pci/controller/pcie-iproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/iproc, thank you.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index c20fd6b..9d5cbc7 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1347,7 +1347,6 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
>  		break;
>  	case IPROC_PCIE_PAXB:
>  		regs = iproc_pcie_reg_paxb;
> -		pcie->iproc_cfg_read = true;
>  		pcie->has_apb_err_disable = true;
>  		if (pcie->need_ob_cfg) {
>  			pcie->ob_map = paxb_ob_map;
> @@ -1356,6 +1355,7 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
>  		break;
>  	case IPROC_PCIE_PAXB_V2:
>  		regs = iproc_pcie_reg_paxb_v2;
> +		pcie->iproc_cfg_read = true;
>  		pcie->has_apb_err_disable = true;
>  		if (pcie->need_ob_cfg) {
>  			pcie->ob_map = paxb_v2_ob_map;
> -- 
> 2.7.4
> 

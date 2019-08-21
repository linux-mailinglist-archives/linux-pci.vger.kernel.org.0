Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8FB4977C4
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 13:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfHULMX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 07:12:23 -0400
Received: from foss.arm.com ([217.140.110.172]:56030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfHULMX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Aug 2019 07:12:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26A2928;
        Wed, 21 Aug 2019 04:12:23 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5861D3F246;
        Wed, 21 Aug 2019 04:12:22 -0700 (PDT)
Date:   Wed, 21 Aug 2019 12:12:17 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: kirin: Make structure kirin_dw_pcie_ops constant
Message-ID: <20190821111217.GA30487@e121166-lin.cambridge.arm.com>
References: <20190819073946.32458-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819073946.32458-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 19, 2019 at 01:09:46PM +0530, Nishka Dasgupta wrote:
> Static variable kirin_dw_pcie_ops, of type dw_pcie_ops, is used only
> once, when it is assigned to the constant field ops of variable pci
> (having type dw_pcie). Hence kirin_dw_pcie_ops is never modified.
> Therefore, make it constant to protect it from unintended modification.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/dwc for v5.4, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index 8df1914226be..c19617a912bd 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -436,7 +436,7 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
>  	return 0;
>  }
>  
> -static struct dw_pcie_ops kirin_dw_pcie_ops = {
> +static const struct dw_pcie_ops kirin_dw_pcie_ops = {
>  	.read_dbi = kirin_pcie_read_dbi,
>  	.write_dbi = kirin_pcie_write_dbi,
>  	.link_up = kirin_pcie_link_up,
> -- 
> 2.19.1
> 

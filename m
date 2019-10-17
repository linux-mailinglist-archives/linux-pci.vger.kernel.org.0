Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E599DA9AD
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 12:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408745AbfJQKSH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 06:18:07 -0400
Received: from [217.140.110.172] ([217.140.110.172]:38140 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1731515AbfJQKSH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Oct 2019 06:18:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45FD51BA8;
        Thu, 17 Oct 2019 03:17:38 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5D2F3F718;
        Thu, 17 Oct 2019 03:17:36 -0700 (PDT)
Date:   Thu, 17 Oct 2019 11:17:27 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: iproc-msi: fix __iomem annotation in
 decode_msi_hwirq()
Message-ID: <20191017101720.GA9589@e121166-lin.cambridge.arm.com>
References: <20191015160702.9457-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015160702.9457-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 15, 2019 at 05:07:02PM +0100, Ben Dooks (Codethink) wrote:
> Fix __iomem attribute on msg variable passed to readl() in
> the decode_msi_hwirq() function. Fixes the following sparse
> warning:
> 
> drivers/pci/controller/pcie-iproc-msi.c:301:17: warning: incorrect type in argument 1 (different address spaces)
> drivers/pci/controller/pcie-iproc-msi.c:301:17:    expected void const volatile [noderef] <asn:2> *addr
> drivers/pci/controller/pcie-iproc-msi.c:301:17:    got unsigned int [usertype] *[assigned] msg
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> .. (open list)
> ---
>  drivers/pci/controller/pcie-iproc-msi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to pci/misc, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
> index 0a3f61be5625..3176ad3ab0e5 100644
> --- a/drivers/pci/controller/pcie-iproc-msi.c
> +++ b/drivers/pci/controller/pcie-iproc-msi.c
> @@ -293,11 +293,12 @@ static const struct irq_domain_ops msi_domain_ops = {
>  
>  static inline u32 decode_msi_hwirq(struct iproc_msi *msi, u32 eq, u32 head)
>  {
> -	u32 *msg, hwirq;
> +	u32 __iomem *msg;
> +	u32 hwirq;
>  	unsigned int offs;
>  
>  	offs = iproc_msi_eq_offset(msi, eq) + head * sizeof(u32);
> -	msg = (u32 *)(msi->eq_cpu + offs);
> +	msg = (u32 __iomem *)(msi->eq_cpu + offs);
>  	hwirq = readl(msg);
>  	hwirq = (hwirq >> 5) + (hwirq & 0x1f);
>  
> -- 
> 2.23.0
> 

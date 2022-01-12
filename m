Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C1448C826
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 17:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355110AbiALQUo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 11:20:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55404 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355152AbiALQUh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 11:20:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC95761A0A
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 16:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7224C36AEA;
        Wed, 12 Jan 2022 16:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642004434;
        bh=+FNF1cuhYl6ZyXtVqIjS7MAfhGFpjwVGKt0DAMMZ8QE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LZltvyh6gTOx5jcwahLm1jN6ryl7kT3RzpLNyejkglyuQQiQQ/R1JEO9WygHg1BOY
         /QeK/56H/a0K7f3jJjDTOOcq88mf1iqKZzAMYvt/22HCeUA6duiMtZce2bH1uX/AgF
         HJrVu3j/xF88wDgBLwGdkkXRFxdxu69wjRVMPig97SIJPqT5ngZzDf2xoN0vXTvTcv
         5f1wrJLw//Rjg47JU+Jsd9k/tQJco5cmqn+Zdfw2LF5Dn9YZk21WpTRN5fsRNFHuio
         a1MBJrPLYf2mQc/N5u0g2oXFKV0PsEpULSV3Z3/sGfCfoxLLbgm1Htei7YKYHCrq1i
         MKx1Xd/iXX/UQ==
Date:   Wed, 12 Jan 2022 10:20:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RESEND PATCH v2 1/4] PCI: Add setup_platform_service_irq hook
 to struct pci_host_bridge
Message-ID: <20220112162032.GA260336@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220112094251.1271531-1-sr@denx.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 10:42:48AM +0100, Stefan Roese wrote:
> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> 
> As per section 6.2.4.1.2, 6.2.6 in PCIe r4.0 error interrupts can
> be delivered with platform specific interrupt lines.
> Add setup_platform_service_irq hook to struct pci_host_bridge.
> Some platforms have dedicated interrupt line from root complex to
> interrupt controller for PCIe services like AER.
> This hook is to register platform IRQ's to PCIe port services.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Tested-by: Stefan Roese <sr@denx.de>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>

It would be nice if this included a cover letter like Bharat's
original posting did [1].  That makes it easier to keep organized.

The PCIe r6.0 spec just came out, so let's update the spec references
to that.  Conveniently, the section numbers stayed the same as they
were in r4.0.

Update the language here to use the spec terminology, i.e.,
"platform-specific System Errors"  That helps find the related bits,
e.g., "System Error on Correctable Error Enable" in the Root Control
register.

Rewrap this into paragraphs separated by blank lines.

[1] https://lore.kernel.org/all/1542206878-24587-1-git-send-email-bharat.kumar.gogada@xilinx.com/

> ---
>  include/linux/pci.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 18a75c8e615c..291eadade811 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -554,6 +554,8 @@ struct pci_host_bridge {
>  	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>  	int (*map_irq)(const struct pci_dev *, u8, u8);
>  	void (*release_fn)(struct pci_host_bridge *);
> +	void (*setup_platform_service_irq)(struct pci_host_bridge *, int *,
> +					   int);
>  	void		*release_data;
>  	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>  	unsigned int	no_ext_tags:1;		/* No Extended Tags */
> -- 
> 2.34.1
> 

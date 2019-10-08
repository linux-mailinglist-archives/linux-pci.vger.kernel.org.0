Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68F1DCFE05
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 17:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfJHPqx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 11:46:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfJHPqx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2019 11:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gu8QuxTbWjjSVfL2vy0xkXyQp8/uuH9770PDPTzotQU=; b=Ga5eC1maOxKXdSfmA8ytKWiA4
        lT6GUyZdknGGwJbGM/8ilR2SKzS3ZRaNBH1Vbb5Ev4ePpbWzD9IQzx8kg7S+gJ78j7M8KaRJQA7qP
        Em2U/RXQJHSsexcdDErqQ5JR/Vrnt+p9Cyt2URvNjUWyRRqV6t6W3KY//dy6KUaUu8LH963xeICUG
        c/YqEjaG2ClNAioC9iXyXOJCxHgqEbLneMxbsmTB8Wq/Hafrol8g0rxtHtspEnzO65sP4lDu3IWWt
        C6J2ZntBU25yE36qsKqLbYeXS0rWojUXTU4BAW36pVXFylvkN1EYIz8ts/TVVNXGxlMBd71SzqKaB
        AhTQUGPIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHrhM-0004lP-GK; Tue, 08 Oct 2019 15:46:52 +0000
Date:   Tue, 8 Oct 2019 08:46:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Kuldeep Dave <kuldeep.dave@xilinx.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>, linux-pci@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for
 Microblaze
Message-ID: <20191008154652.GB7903@infradead.org>
References: <b5959a9f6bfa65f0ae1a6a184e1b09dcec8e8f15.1570539512.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5959a9f6bfa65f0ae1a6a184e1b09dcec8e8f15.1570539512.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index a304f5ea11b9..9d259372fbfd 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -52,7 +52,7 @@ config PCI_MSI
>  	   If you don't know what to do here, say Y.
>  
>  config PCI_MSI_IRQ_DOMAIN
> -	def_bool ARC || ARM || ARM64 || X86 || RISCV
> +	def_bool ARC || ARM || ARM64 || X86 || RISCV || MICROBLAZE

Can you find out what the actual dependency is so that we can
automatically enabled this instead of the weird arch list?

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216A4C2A2F
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 01:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfI3XBN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 19:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfI3XBN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 19:01:13 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E5F32053B;
        Mon, 30 Sep 2019 23:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569884472;
        bh=1wQhhAUnUdJSkfKkK0D/npdNUFsXaYYB9Fffaj8AAI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1mlOHXf5+IX7jDSbA6BBVsD4iUXRJ5jBIo9Ge80GKQltRMtX8hDdq2/fiLiyi+mo0
         ArbkDibA72Hs84fRmj7CY9gN8kok02XvLVRCT5JV9v1+PrDf4s0g/FSDJpdB0y+Nv+
         SobMl6sF+E3Aw33SNML5dTKVT8920ieYx45WvRwc=
Date:   Mon, 30 Sep 2019 18:01:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Replace deprecated EXTRA_CFLAGS with ccflags-y.
Message-ID: <20190930230109.GA220584@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819060532.17093-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 19, 2019 at 08:05:32AM +0200, Krzysztof Wilczynski wrote:
> Update arch/x86/pci/Makefile replacing the deprecated EXTRA_CFLAGS
> with the ccflags-y matching recommendation as per the section 3.7
> "Compilation flags" of the "Linux Kernel Makefiles" (see:
> Documentation/kbuild/makefiles.txt).
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>

Applied to pci/misc for v5.5, thanks!

> ---
>  arch/x86/pci/Makefile | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/pci/Makefile b/arch/x86/pci/Makefile
> index c806b57d3f22..48bcada5cabe 100644
> --- a/arch/x86/pci/Makefile
> +++ b/arch/x86/pci/Makefile
> @@ -24,6 +24,4 @@ obj-y				+= bus_numa.o
>  obj-$(CONFIG_AMD_NB)		+= amd_bus.o
>  obj-$(CONFIG_PCI_CNB20LE_QUIRK)	+= broadcom_bus.o
>  
> -ifeq ($(CONFIG_PCI_DEBUG),y)
> -EXTRA_CFLAGS += -DDEBUG
> -endif
> +ccflags-$(CONFIG_PCI_DEBUG)	+= -DDEBUG
> -- 
> 2.22.0
> 

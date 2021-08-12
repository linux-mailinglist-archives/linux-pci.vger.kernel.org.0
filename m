Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991C83EAAAB
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 21:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhHLTNT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 15:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229847AbhHLTNT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Aug 2021 15:13:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88CD9603E7;
        Thu, 12 Aug 2021 19:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628795573;
        bh=6/6T7DxgrvSvrXd/E4zHFomaPZTuuHm7Zpts1dBdngY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LSLYLuBV1DTM+9iA+rm2kMcaiCcXOzOe1XR/Uw6IBlsXKu3CneKP1E4HpriXkM9CM
         lvTDNhfFd4TE3h0b278SdEGS/w85Rvk/q2oaX1CfHjVVgJvX9TTOPanaFv+CPNirnf
         RgYgB0iLYhMUeRi6aQ1kovJ5C8QnPVz5qV6IF3t9CePMUHEd7IM+Z6unSxKbStJ2Om
         /G8YvQBqcM7DErwACeBt0brEG5Mptz/jTf5YwiyN1Ic7gS6OSUbLunEWl8QSbmDJwT
         t7AZp0audQ8DT9GA5cuJDHQN3AesxEqljznokgHW8iYnTVyHGl4v5dYzURbjVZqF9y
         QEssZBXnMjxJA==
Date:   Thu, 12 Aug 2021 14:12:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] x86/pci: Add missing forward declaration for
 pci_numachip_init()
Message-ID: <20210812191252.GA2499500@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210812171717.1471243-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 12, 2021 at 05:17:17PM +0000, Krzysztof Wilczyński wrote:
> At the moment, the function pci_numachip_init() is defined in the
> numachip.c file, but lacks matching forward declaration causing the
> following sparse and compile time warnings:
> 
>   arch/x86/pci/numachip.c:108:12: warning: no previous prototype for function 'pci_numachip_init' [-Wmissing-prototypes]
>   arch/x86/pci/numachip.c:108:12: warning: symbol 'pci_numachip_init' was not declared. Should it be static?
> 
> Thus, add missing include of asm/numachip/numachip.h that includes the
> missing forward declaration.  This will resolve the aforementioned
> warnings.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Applied to pci/misc for v5.15, thanks!

> ---
>  arch/x86/pci/numachip.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/pci/numachip.c b/arch/x86/pci/numachip.c
> index 01a085d9135a..4f0147d4e225 100644
> --- a/arch/x86/pci/numachip.c
> +++ b/arch/x86/pci/numachip.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/pci.h>
>  #include <asm/pci_x86.h>
> +#include <asm/numachip/numachip.h>
>  
>  static u8 limit __read_mostly;
>  
> -- 
> 2.32.0
> 

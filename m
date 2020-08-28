Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFAD255F1F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Aug 2020 18:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgH1QuU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Aug 2020 12:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbgH1Qtd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Aug 2020 12:49:33 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E932D20848;
        Fri, 28 Aug 2020 16:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598633373;
        bh=2zi6kKIXNmh0npEoV6BaBE601p2nfEjXutlFE5Te2hg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SISUVkwbNHoc+gorEB9C8iSxzU/R2hRJ7EWukGp8kPYp6+N2+ibb0YB2DJKeQS7Bm
         szEqZWii3cEaraFVKqccbamfr7IGmv4flEAu9p/l1XJSjPp/QbO1qeJQ+wZ1tiy0EW
         ydsx8CEM3FgI+WzjcmiqUAwq31e2K2eFHk+m7GvU=
Date:   Fri, 28 Aug 2020 11:49:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     mj@ucw.cz, linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Decode 10-Bit Tag Requester Enable
Message-ID: <20200828164931.GA2161257@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596266480-52789-1-git-send-email-liudongdong3@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 01, 2020 at 03:21:20PM +0800, Dongdong Liu wrote:
> Decode 10-Bit Tag Requester Enable bit in Device Control 2 Register.
> 
> Sample output changes:
> 
>   - DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
>   + DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled, ARIFwd-
> 
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> ---
>  lib/header.h | 1 +
>  ls-caps.c    | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/header.h b/lib/header.h
> index 472816e..eaf6517 100644
> --- a/lib/header.h
> +++ b/lib/header.h
> @@ -898,6 +898,7 @@
>  #define  PCI_EXP_DEVCAP2_64BIT_ATOMICOP_COMP	0x0100	/* 64bit AtomicOp Completer Supported */
>  #define  PCI_EXP_DEVCAP2_128BIT_CAS_COMP	0x0200	/* 128bit CAS Completer Supported */
>  #define  PCI_EXP_DEV2_LTR		0x0400	/* LTR enabled */
> +#define  PCI_EXP_DEV2_10BIT_TAG_REQ	0x1000 /* 10 Bit Tag Requester enabled */

Looks OK to me (but I don't maintain lspci, of course).

And we have a bit of a mess in the names here.  There are a bunch of
"PCI_EXP_DEV2_*" names that would be "PCI_EXP_DEVCTL2_*" if they
followed the convention.  You didn't start that trend, so I'm just
pointing it out in case you or Martin want to clean it up.  When I add
names I try to use the same name between the Linux kernel source [1]
and lspci.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/pci_regs.h#n651

>  #define  PCI_EXP_DEV2_OBFF(x)		(((x) >> 13) & 3) /* OBFF enabled */
>  #define PCI_EXP_DEVSTA2			0x2a	/* Device Status */
>  #define PCI_EXP_LNKCAP2			0x2c	/* Link Capabilities */
> diff --git a/ls-caps.c b/ls-caps.c
> index a09b0cf..d17cbad 100644
> --- a/ls-caps.c
> +++ b/ls-caps.c
> @@ -1134,10 +1134,11 @@ static void cap_express_dev2(struct device *d, int where, int type)
>      }
>  
>    w = get_conf_word(d, where + PCI_EXP_DEVCTL2);
> -  printf("\t\tDevCtl2: Completion Timeout: %s, TimeoutDis%c LTR%c OBFF %s,",
> +  printf("\t\tDevCtl2: Completion Timeout: %s, TimeoutDis%c LTR%c 10BitTagReq%c OBFF %s,",
>  	cap_express_dev2_timeout_value(PCI_EXP_DEV2_TIMEOUT_VALUE(w)),
>  	FLAG(w, PCI_EXP_DEV2_TIMEOUT_DIS),
>  	FLAG(w, PCI_EXP_DEV2_LTR),
> +	FLAG(w, PCI_EXP_DEV2_10BIT_TAG_REQ),
>  	cap_express_devctl2_obff(PCI_EXP_DEV2_OBFF(w)));
>    if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_DOWNSTREAM)
>      printf(" ARIFwd%c\n", FLAG(w, PCI_EXP_DEV2_ARI));
> -- 
> 1.9.1
> 

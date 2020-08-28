Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC2425520F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Aug 2020 03:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgH1BBO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Aug 2020 21:01:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10288 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbgH1BBO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Aug 2020 21:01:14 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2E51C25FF269619BF69A;
        Fri, 28 Aug 2020 09:01:11 +0800 (CST)
Received: from [127.0.0.1] (10.67.103.235) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 28 Aug 2020
 09:01:09 +0800
Subject: Re: [PATCH] lspci: Decode 10-Bit Tag Requester Enable
To:     <mj@ucw.cz>
References: <1596266480-52789-1-git-send-email-liudongdong3@huawei.com>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <62cfa319-fa86-c897-3a35-4a89e1f13813@huawei.com>
Date:   Fri, 28 Aug 2020 09:01:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1596266480-52789-1-git-send-email-liudongdong3@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.235]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ping...

On 2020/8/1 15:21, Dongdong Liu wrote:
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
>


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CF6481E58
	for <lists+linux-pci@lfdr.de>; Thu, 30 Dec 2021 17:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241368AbhL3Qul (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Dec 2021 11:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240222AbhL3Qul (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Dec 2021 11:50:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F59C061574;
        Thu, 30 Dec 2021 08:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=KCIuKfYCj4UNj6Bbz3o+wzTEwkTdr3miPJh0cjsBii0=; b=PyDcTfTYoXlY89XosfCrZV15Xb
        4dgELtnkGLeUg+RtHdl+gCYTyGRsOzt3e/nu7+NApB97KfCyumzwt/OlrIpGKf7XixRZWN1HbZO76
        636OoDykHk+6GyV+WhdCb6kBaTs7A6QRzZui2+wdwYuRu9cKIO89Dc9bFR4jz8yD/CRGPyZzCHQzu
        4z2Lzol2f8mu1JdijQULmc5K9KNjSMDdZzwFzKTglrp+AlciaElI1PbnvNzPVxjtICLwX0ndfefWx
        9G2/N9gMHBfd6h/yIV2nrL8rOKvB2829tOM1dMkRwHVaGiJS/cGq9V6ugSpk6qS5K/dwUNDczBZXV
        jIpmn+0Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n2ydQ-009vPU-Ri; Thu, 30 Dec 2021 16:50:37 +0000
Message-ID: <1e32a809-013d-fea5-2f9c-eee382afc3cc@infradead.org>
Date:   Thu, 30 Dec 2021 08:50:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH] PCI: Add "pci=reassign_all_bus" boot parameter
Content-Language: en-US
To:     Yao Hongbo <yaohongbo@linux.alibaba.com>, bhelgaas@google.com
Cc:     zhangliguang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1640856613-101412-1-git-send-email-yaohongbo@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1640856613-101412-1-git-send-email-yaohongbo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi--

On 12/30/21 01:30, Yao Hongbo wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2fba824..c83a2e5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4084,6 +4084,7 @@
>  		nomio		[S390] Do not use MIO instructions.
>  		norid		[S390] ignore the RID field and force use of
>  				one PCI domain per PCI function
> +		reassign_all_bus	The OS fully configure the PCI bus.

		                                     configures
>  
>  	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
>  			Management.

thanks.
-- 
~Randy

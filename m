Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF28A4CA4BC
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 13:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbiCBMXq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 07:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiCBMXq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 07:23:46 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3095D5E6
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 04:23:02 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K7tSD6ntzz1GC1T
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 20:18:20 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 20:23:00 +0800
CC:     <linuxarm@huawei.com>
Subject: Re: [PATCH] PCI/AER: Update the link to the aer-inject tool
To:     Yicong Yang <yangyicong@hisilicon.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
References: <20220115104921.21606-1-yangyicong@hisilicon.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <0c05df5a-f0e5-b85b-5c46-03a81db6d244@huawei.com>
Date:   Wed, 2 Mar 2022 20:23:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220115104921.21606-1-yangyicong@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Gentle ping for this obvious fix...

On 2022/1/15 18:49, Yicong Yang wrote:
> The link to the aer-inject referenced leads to an empty repo
> and seems no longer used. Replace it with the link mentioned
> in Documentation/PCI/pcieaer-howto.rst.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/pci/pcie/Kconfig      | 2 +-
>  drivers/pci/pcie/aer_inject.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 45a2ef702b45..788ac8df3f9d 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -43,7 +43,7 @@ config PCIEAER_INJECT
>  	  error injection can fake almost all kinds of errors with the
>  	  help of a user space helper tool aer-inject, which can be
>  	  gotten from:
> -	     https://www.kernel.org/pub/linux/utils/pci/aer-inject/
> +	     https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
>  
>  #
>  # PCI Express ECRC
> diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
> index 767f8859b99b..2dab275d252f 100644
> --- a/drivers/pci/pcie/aer_inject.c
> +++ b/drivers/pci/pcie/aer_inject.c
> @@ -6,7 +6,7 @@
>   * trigger various real hardware errors. Software based error
>   * injection can fake almost all kinds of errors with the help of a
>   * user space helper tool aer-inject, which can be gotten from:
> - *   https://www.kernel.org/pub/linux/utils/pci/aer-inject/
> + *   https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
>   *
>   * Copyright 2009 Intel Corporation.
>   *     Huang Ying <ying.huang@intel.com>
> 

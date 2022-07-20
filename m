Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524E957B964
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 17:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiGTPRF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 11:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiGTPRF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 11:17:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF02509FF;
        Wed, 20 Jul 2022 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=07ekqc/hVm/5sdKIATW8yYEMmBgbrxHsmPCuyP7ByEg=; b=nj1vzdoeFg8xS7NXxA7LkGGJa8
        Al4JbN1rVDbihgxR34w4j3Jp7hlxHmcYQz1N5/MzEhIAHoNUsXrAYRo86IScG/PYMPYTCXbLx9tuT
        dclXlYPA/4l3MX4vkflnvRh+d6VPuxSKy9Dv+1pAQ9LFcr1P5hqhtA160NH3o2/oG7nfFiZvvaegT
        FHtc4e1a3kPdzQTZ0+Hb3bi+8mqYlOe0JMMZp2aL7HexPKUkYvfUNJn4EYm3yJf+K2Mg6h1Z46O9A
        CzDWOFauXOhTuXjvqd8xDSXoVHZ+39QBVSYaTZF7jQ4xo6jMBj69yteUN7XNlgBNc0PzNHTekzzLL
        tawPWFZA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEBRe-007RJy-MC; Wed, 20 Jul 2022 15:17:02 +0000
Message-ID: <b8f0de26-db20-2653-68f8-3822e0ea8e30@infradead.org>
Date:   Wed, 20 Jul 2022 08:17:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] PCI: eliminate abnormal characters when reads help
 information of "PCI_P2PDMA" under menuconfig
Content-Language: en-US
To:     Liu Song <liusong@linux.alibaba.com>, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1658301723-111283-1-git-send-email-liusong@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1658301723-111283-1-git-send-email-liusong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/20/22 00:22, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> Read the help information of PCI_P2PDMA through make menuconfig,
> "Enables" is partially displayed as garbled characters, so fix it.
> 
> Signed-off-by: Liu Song <liusong@linux.alibaba.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/pci/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 133c732..8102b78 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -166,7 +166,7 @@ config PCI_P2PDMA
>  	depends on ZONE_DEVICE
>  	select GENERIC_ALLOCATOR
>  	help
> -	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
> +	  Enables drivers to do PCI peer-to-peer transactions to and from
>  	  BARs that are exposed in other devices that are the part of
>  	  the hierarchy where peer-to-peer DMA is guaranteed by the PCI
>  	  specification to work (ie. anything below a single PCI bridge).

-- 
~Randy

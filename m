Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074CA37754B
	for <lists+linux-pci@lfdr.de>; Sun,  9 May 2021 06:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhEIEjl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 May 2021 00:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhEIEjl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 May 2021 00:39:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF763C061573
        for <linux-pci@vger.kernel.org>; Sat,  8 May 2021 21:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=+nSuabwDqS9pvhRbRaslGgFP4aWoEINpEjO+w1xulq0=; b=fK3HsqKLVaxXWCVepfOUkEYPyo
        Wlx0058gM5ETMI7Rn4rXKiugujxicbgHpI1Ti0TZoFwhK0x/fiY12JmsDw3VYTLG4SYVxwyjgg4sd
        ojuiwKA6CqANl6oI0keJmDCJW40gpqgTqMbm43KMG+iCve8PeJ2pp0DVB1u3ENkUqz4TGMcQdaKd/
        WXgTl+Vj91VEiyuRh+LJ2jO66Ce6hn0YToBiuflGAFMd84Ui0XPX1oi7xAM9fuTvotQz79ktnS1qY
        VezzZFDdI5b2aD0z4Op4dxjHH3gKRVTKz5XgYKZ0oLeJ2WvqBWC6TAngL23OV/UkKKqVXvvIJy87O
        g0P5FWUg==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lfbDB-007qNf-77; Sun, 09 May 2021 04:38:37 +0000
Subject: Re: [PATCH] PCI: xgene: Fix a non-compliant kernel-doc
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210509030237.368540-1-kw@linux.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c7d7a532-a3e0-e271-e0cd-b02754b18429@infradead.org>
Date:   Sat, 8 May 2021 21:38:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210509030237.368540-1-kw@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/8/21 8:02 PM, Krzysztof Wilczyński wrote:
> Correct a non-compliant kernel-doc at the top of the pci-xgene.c file,
> and resolve build time warning related to kernel-doc:
> 
>   drivers/pci/controller/pci-xgene.c:27: warning: expecting prototype for APM X(). Prototype was for PCIECORE_CTLANDSTATUS() instead
> 
> No change to functionality intended.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/pci/controller/pci-xgene.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
> index 7f503dd4ff81..8dc5140dd80d 100644
> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
> -/**
> +/*
>   * APM X-Gene PCIe Driver
>   *
>   * Copyright (c) 2014 Applied Micro Circuits Corporation.
> 


-- 
~Randy


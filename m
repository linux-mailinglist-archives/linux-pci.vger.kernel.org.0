Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8149426CDD2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 23:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgIPVFL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 17:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIPQPB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 12:15:01 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671F8C0F26F5;
        Wed, 16 Sep 2020 08:14:06 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id j11so10956961ejk.0;
        Wed, 16 Sep 2020 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MrKdeebPgiqsV3LHCmsYRKtjV10T+fGFhaSCGYDBzH4=;
        b=OVd/pTtZcQ8W+QR2Fm6UcRsMIH1L2Nf1VSJOoZvyHoL/WGbtkwmG2tBKGyjiJ2Z5TO
         sbkvWZT7gyWUQYZU0+Ho4n01FeIPlNBhea4t3VsuaoSbBrsZLBpVuI0f3R40xlTaGHdU
         OiiXAF2ZhFghx5CSCTLuTdLkQd+XdiAp7QDI7daBKeyGPdpawRCejQyJzvtJ3d4Ns6Ze
         3oQy6x/7eh+wgB+CoTEjeCxUrLR/2rLQbOPUN8DEvvadQiez55lOZFWgcwvpecHbrcvn
         LToCgjRy9dDOzXmvW8ZGpyryTKWg6YeWwcyHwRdZDk9R6H9MPoGoVakE4KZGBpqZCzUT
         C+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MrKdeebPgiqsV3LHCmsYRKtjV10T+fGFhaSCGYDBzH4=;
        b=kZqHFTkjlj5IEu2iEgC5XNQWUNNxEpFIcbJPLbMh/WXMNlNLETOIQnooVCxDADM308
         BQecBp/8igTu2RJDwqUYA39DRWqwNKHH6/JwGN06CDcZKO/0wpYOXVfqjAK5Deak5sTy
         zDIRc2+UR45afMxLpNrHdrUCAvZ16noFb5Yyigj35otysLfTRbWrvgSx1prny5oP4gu0
         zSmqEzA0nxRYO2KvJiDqrXHwyyKcVmIDnSmCHweGY0p6h0/+Cr0BBmDZuIT5eTjPwsAm
         9p60CDbqouJ+dQImKzpkm/W8pzcO+k4s+zh5e8G0DrEtD2nSAfAu209S72bp4v1ioRkY
         SkbQ==
X-Gm-Message-State: AOAM533jGjz/1mK0WIu8csZbCv+ovB8y6oqyCq78ngNEEqR46td7PDjh
        EDiT60HiumXAQ1jb48a45G3+AkRe48WCwBiW
X-Google-Smtp-Source: ABdhPJxhpzDSQgu0VmmCEKMIz8cZ5UgClo6Sc6eIE107Gwx6QNzT4NDA7RqbZ1i/BGYr40WbHVZOmg==
X-Received: by 2002:a17:906:e08f:: with SMTP id gh15mr25419538ejb.443.1600269244996;
        Wed, 16 Sep 2020 08:14:04 -0700 (PDT)
Received: from [10.8.0.6] ([5.2.67.190])
        by smtp.gmail.com with ESMTPSA id q26sm12829167ejr.97.2020.09.16.08.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 08:14:04 -0700 (PDT)
Subject: Re: [PATCH 0/2] PCI: aardvark: Fix comphy with old ATF
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200902144344.16684-1-pali@kernel.org>
From:   Tomasz Maciej Nowak <tmn505@gmail.com>
Message-ID: <3f2b0e5b-87f1-7887-4afc-77f31d56b5a3@gmail.com>
Date:   Wed, 16 Sep 2020 17:14:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200902144344.16684-1-pali@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W dniu 02.09.2020 o 16:43, Pali Rohár pisze:
> This patch series fixes regression introduced in commit 366697018c9a
> ("PCI: aardvark: Add PHY support") which caused aardvark driver
> initialization failure on EspressoBin board with factory version of
> Arm Trusted Firmware provided by Marvell.
> 
> Second patch depends on the first patch, so please add appropriate
> Fixes/Cc:stable@ tags to have both patches correctly backported to
> stable kernels.
> 
> I have tested both patches with Marvell ATF firmware ebin-17.10-uart.zip
> and with upstream ATF+uboot and aardvark was initialized successfully.
> Without this patch series on ebin-17.10-uart.zip aardvark initialization
> failed.
> 
> Pali Rohár (2):
>   phy: marvell: comphy: Convert internal SMCC firmware return codes to
>     errno
>   PCI: aardvark: Fix initialization with old Marvell's Arm Trusted
>     Firmware

For both patches

Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>

> 
>  drivers/pci/controller/pci-aardvark.c        |  4 +++-
>  drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 14 +++++++++++---
>  drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 14 +++++++++++---
>  3 files changed, 25 insertions(+), 7 deletions(-)
> 


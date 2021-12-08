Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1923D46DD85
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 22:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbhLHVWv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 16:22:51 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:54246 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbhLHVWu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 16:22:50 -0500
Received: by mail-wm1-f54.google.com with SMTP id y196so2740969wmc.3;
        Wed, 08 Dec 2021 13:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lGCJse956z74hTTB9jr5bIXKoOQXyIcPGQuNGuBUSrc=;
        b=VqwQMhE40u9oL16wH/ytk5R9G2uCa1mqzixAbEtezlUjZE2dUaEWe3uKtPxIZe3iTm
         7NmsF2sPrrILPxoJXR7bZROLVjfRqORi+4HeR5yL/54tOX9el4bF8vjb1x1PmRb6nado
         0bkRci2S9NM45JYpc4YCbEosh4excWH9T5iuDuHBBdYzlObNUkwTWdEtdRyf0U0nMF23
         ZkpwIJ9fUF2c+1lMvdCzaoCNPdPv5POvlQMybJd4s/0yVJ8z6Cb/DLqqz/JADCIsPjzZ
         fHnfDMXpxZwNYKSAq420EkdjmRmIx27B326g8clsM+8KXaZxJTXiQY8yiOGe0iqpmpeA
         lxqA==
X-Gm-Message-State: AOAM532xeL8HnfHJjx2grpv6XYZxsvqYnAdhfNmVUs5i4cNdUp54hBZ2
        b0sgZETUI4NZ19Ev3ySl5VE=
X-Google-Smtp-Source: ABdhPJxE5TjdbwCurdu70/FRp2HcLs5d8u7RmvO/weZBI7PJ6qkZyX+gZ8rmDU5YmXvXj7xM6jowcw==
X-Received: by 2002:a05:600c:202:: with SMTP id 2mr1393564wmi.167.1638998357263;
        Wed, 08 Dec 2021 13:19:17 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id r17sm8019876wmq.5.2021.12.08.13.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 13:19:15 -0800 (PST)
Date:   Wed, 8 Dec 2021 22:19:13 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Toan Le <toan@os.amperecomputing.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] sizes.h: Add SZ_1T macro
Message-ID: <YbEhUeUy7PlOk2iR@rocinante>
References: <b03f5cf556f1a89ccb4d7ae2f56414520cfd9209.1638973836.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b03f5cf556f1a89ccb4d7ae2f56414520cfd9209.1638973836.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Christophe,

> Today drivers/pci/controller/pci-xgene.c defines SZ_1T
> 
> Move it into linux/sizes.h so that it can be re-used elsewhere.

Sounds like a good idea!

By the way, there was an earlier version of this patch, did something
happened?  I think you simply extracted these changes from the other
series, correct?

> diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
> index 56d0d50338c8..716dcab5ca47 100644
> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -49,7 +49,6 @@
>  #define EN_REG				0x00000001
>  #define OB_LO_IO			0x00000002
>  #define XGENE_PCIE_DEVICEID		0xE004
> -#define SZ_1T				(SZ_1G*1024ULL)
>  #define PIPE_PHY_RATE_RD(src)		((0xc000 & (u32)(src)) >> 0xe)
>  
>  #define XGENE_V1_PCI_EXP_CAP		0x40
> diff --git a/include/linux/sizes.h b/include/linux/sizes.h
> index 1ac79bcee2bb..84aa448d8bb3 100644
> --- a/include/linux/sizes.h
> +++ b/include/linux/sizes.h
> @@ -47,6 +47,8 @@
>  #define SZ_8G				_AC(0x200000000, ULL)
>  #define SZ_16G				_AC(0x400000000, ULL)
>  #define SZ_32G				_AC(0x800000000, ULL)
> +
> +#define SZ_1T				_AC(0x10000000000, ULL)
>  #define SZ_64T				_AC(0x400000000000, ULL)
>  
>  #endif /* __LINUX_SIZES_H__ */

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D403130517
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2020 00:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgADXyt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Jan 2020 18:54:49 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46787 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgADXyt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Jan 2020 18:54:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so20376422pll.13;
        Sat, 04 Jan 2020 15:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=ck5NSDuNtKf0n476SpJREQp0JJmh7bxHMkeur8ObqbQ=;
        b=OOd4Nfk9AubWqdch0xXs7idSsl8TLsQ79l3l69zwacS4R4OP5eBKUKWG8/BhkXpEgt
         Gg/imteAnQJA0y9HBLEpGslSBhRDH60mJe2lvxQ9cO36qFGm3PXcCxDy5ZP/fuERjhE1
         HCg9vTvI/zFoX/onscV++n2DfmT90Jt3KefbaWF5KfJfjb4GdPv4coNJK2LougXkP0gV
         3MDgnk7ZqVtbbORsU3F3928KF+yApMINEbO2xdqggyE4fTdn0yJ2tERbvdVe2/NMZzwF
         98Ui+l7fIik8EO0u6FXqMcLQaOHylHWk/4fD/cWEHxTeauyoZJfYb8L5cp6ykNmgsPfq
         ZpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=ck5NSDuNtKf0n476SpJREQp0JJmh7bxHMkeur8ObqbQ=;
        b=V700LnPRXFQ+dTNxEB1acCDWr6bzHM214o+OXzoh7J8J6JOdFrOHk/hATTYoKE3ixC
         tDpM9YAJnT6GEcFGDKwe1UBLYhSI72nvo9DyeIzwp6GS/rWPXacXbLy/3HED3H0KjlbU
         iUcTwnoA0rWgyeCDcrun2q+sGbXuD8UwPuWGsVw+gwJYbUU6ocTcyMw8E7VM/npV1r1v
         4fsIHaVdICis+kapqJlVaWp0btI8ypCsoA7dTxPNHMOd1H+rF1paufJWp5cJyLwRiU1K
         m/59RQWo0kT0gjAn2qE7wsqhgjihJNNKvmY7JPw/76Le3YEfWBR6TlSnz+el+1AFQ+Ii
         4EPA==
X-Gm-Message-State: APjAAAUzSAZneJwapML3GbsNX0KleBv2Zb3ejdb3CuufVFAGmq6b6w0L
        fQBLOA4Vu251c0O/KklzGDw=
X-Google-Smtp-Source: APXvYqzA9f1bgiajXiWV8IQvWLOXbz5anxtKxoFXZXd0Lgp9xLv1iRU7s1lQ6PRHNjPC6wwtantXiA==
X-Received: by 2002:a17:902:8503:: with SMTP id bj3mr96675534plb.180.1578182088862;
        Sat, 04 Jan 2020 15:54:48 -0800 (PST)
Received: from SL2P216MB0105.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:22::5])
        by smtp.gmail.com with ESMTPSA id a17sm20053573pjv.6.2020.01.04.15.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jan 2020 15:54:47 -0800 (PST)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kukjin Kim <kgene@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH v2 16/20] pci: exynos: Rename Exynos to lowercase
Thread-Topic: [PATCH v2 16/20] pci: exynos: Rename Exynos to lowercase
Thread-Index: AQHVwxLbTWsXPMkvXkqXN+ab27j8KqfbLoPn
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Sat, 4 Jan 2020 23:54:43 +0000
Message-ID: <SL2P216MB0105B2C0657DC74FD40D5054AA220@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
References: <20200104152107.11407-1-krzk@kernel.org>
 <20200104152107.11407-17-krzk@kernel.org>
In-Reply-To: <20200104152107.11407-17-krzk@kernel.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/4/20, 10:22 AM, Krzysztof Kozlowski wrote:
>=20
> Fix up inconsistent usage of upper and lowercase letters in "Exynos"
> name.
>
> "EXYNOS" is not an abbreviation but a regular trademarked name.
> Therefore it should be written with lowercase letters starting with
> capital letter.
>
> The lowercase "Exynos" name is promoted by its manufacturer Samsung
> Electronics Co., Ltd., in advertisement materials and on website.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/contro=
ller/dwc/pci-exynos.c
> index 14a6ba4067fb..c5043d951e80 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * PCIe host controller driver for Samsung EXYNOS SoCs
> + * PCIe host controller driver for Samsung Exynos SoCs
>   *
>   * Copyright (C) 2013 Samsung Electronics Co., Ltd.
>   *		http://www.samsung.com
> --=20
> 2.17.1


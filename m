Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916E2298607
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 05:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgJZEIZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 00:08:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46484 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgJZEIZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2020 00:08:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id x10so1850759plm.13;
        Sun, 25 Oct 2020 21:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=WGPCTWXGaFEQAPnwBl3aSCOFQLjbIQTV4mrYNZQcNU4=;
        b=cO30POYX/sxN9MDmzXtb087me5okMwPuXuVbzkxYNtKc/rLmzcOCszVtrj6+smGPJe
         LEEfnZT1eNX4jNO9D7D3qkbJzkaPXPXFOokoRCKyBGZFHGNDwtsO3d34rFjOfyOg+vaW
         /brioPH9sS7g24qKl+S37+iC5Tlz4v1M4KSq8MGOh+GlFTePvDvDSzYbh6/fh2IS2aRc
         nVYLkH/xn+4EsLbzrwcuyEJmF0gQv2vBCfbbGsfYBkCdHs3qRsXThuAUpclayXRhio7n
         grY/fVWYR6MDPvzbhj08LCZG1EejT8zL20mQTBu8qpe6UidX0fQevzouc9WTAfpZw34N
         z9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=WGPCTWXGaFEQAPnwBl3aSCOFQLjbIQTV4mrYNZQcNU4=;
        b=JgherFLoUuH4AObvFUzT0IoZsocecWijmmnpdEmM6lvSxulNPLE4EzLnmibNo1QPiB
         psVCg1DQln/yPC2LjyhB2yw86CJkIu8WporAXGxiIY1qNgBdJDmNDK3yz6G879MuYQnw
         wq1YnrlVlL9GwzX5PIXlyoWvGguvz8bZiVNDCPJrwQDVsu5BxLaKWuBwuQVFpSGe7GRZ
         Jw8Rh+7noiP4omd4NKkfEYp+Y16rEdFFNwaA8gc2Z+dT2RJD/dZaP5uWNx8mK3A5jtV4
         vus5ayB0AYlbb5E6RdZ870I3Ztqt+CfEgNfQl1NZarcgRs3vJkXJwj7E0TsBznbKUUcN
         7NRQ==
X-Gm-Message-State: AOAM531VQtmYn2cXBxWxFCZFRJ0ocFy91u13Soc+3UFT4UYHPFzwq4SI
        H0oiQkExQYlxAOHN6USPri4=
X-Google-Smtp-Source: ABdhPJz4uoBcH8iQ3Jq7+hDNgHgEbVxJbHXvBh/D0NROP9jvA/n4NB2ojDnEdStx1jGXM3bhlMGCTQ==
X-Received: by 2002:a17:90a:c388:: with SMTP id h8mr14628176pjt.100.1603685304291;
        Sun, 25 Oct 2020 21:08:24 -0700 (PDT)
Received: from SLXP216MB0477.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:9::5])
        by smtp.gmail.com with ESMTPSA id x19sm10918981pjk.25.2020.10.25.21.08.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Oct 2020 21:08:23 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH v2 5/6] pci: dwc: pci-exynos: rework the driver to support
 Exynos5433 variant
Thread-Topic: [PATCH v2 5/6] pci: dwc: pci-exynos: rework the driver to
 support Exynos5433 variant
Thread-Index: ATYzNHA3LqEW/SeHeSezfbTZ8+mXqGl5LTQyaXktNDK6VWtTUoADHkoAgAAV8aw=
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Mon, 26 Oct 2020 04:08:18 +0000
Message-ID: <SLXP216MB0477275C0A8FFAE14274165FAA190@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
References: <20201023075744.26200-1-m.szyprowski@samsung.com>
 <CGME20201023075756eucas1p18765653e747842eef4b438aff32ef136@eucas1p1.samsung.com>
 <20201023075744.26200-6-m.szyprowski@samsung.com>
 <SLXP216MB047790A7FD4D1E7304493343AA1B0@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
 <29fa2071-dd4e-4528-d2db-dcd86e443794@samsung.com>
In-Reply-To: <29fa2071-dd4e-4528-d2db-dcd86e443794@samsung.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/25/20, 10:49 PM, Jaehoon Chung wrote:
>=20
> Dear Jingoo,

Hi Jaehoon,

> On 10/24/20 12:12 PM, Jingoo Han wrote:
> > On 10/23/20, 3:58 AM, Marek Szyprowski wrote:
> >>
> >> From: Jaehoon Chung <jh80.chung@samsung.com>
> >>
> >> Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("AR=
M:
> >> dts: exynos: Remove Exynos5440"). Rework this driver to support DWC PC=
Ie
> >> variant found in the Exynos5433 SoCs.
> >>
> >> The main difference in Exynos5433 variant is lack of the MSI support
> >> (the MSI interrupt is not even routed to the CPU).
> >>
> >> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> >> [mszyprow: reworked the driver to support only Exynos5433 variant,
> >> 	   simplified code, rebased onto current kernel code, added
> >> 	   regulator support, converted to the regular platform driver,
> >> 	   removed MSI related code, rewrote commit message]
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> >> ---
> >>  drivers/pci/controller/dwc/Kconfig      |   3 +-
> >>  drivers/pci/controller/dwc/pci-exynos.c | 358 ++++++++++-------------=
-
> >>  drivers/pci/quirks.c                    |   1 +
> >>  3 files changed, 145 insertions(+), 217 deletions(-)
> >=20
> > [....]
> >=20
> >> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/con=
troller/dwc/pci-exynos.c
> >> index 242683cde04a..58056fbdc2fa 100644
> >> --- a/drivers/pci/controller/dwc/pci-exynos.c
> >> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> >> @@ -2,26 +2,23 @@
> >>  /*
> >>   * PCIe host controller driver for Samsung Exynos SoCs
> >>   *
> >> - * Copyright (C) 2013 Samsung Electronics Co., Ltd.
> >> + * Copyright (C) 2013-2020 Samsung Electronics Co., Ltd.
> >>   *		https://www.samsung.com
> >>   *
> >>   * Author: Jingoo Han <jg1.han@samsung.com>
> >> + *	   Jaehoon Chung <jh80.chung@samsung.com>
> >=20
> > Would you explain the reason why you add him as an author?
> > If reasonable, I will accept it. Also, I want gentle discussion, not ag=
gressive one.
> > Thank you.
>
> It's not important to add me as author. :)
> If you don't want to accept it, i think it can be removed it.
> I think that pci-exynos was supported on only exynos5440.
> As you know, exynos5440 was not common as compared with other exynos SoC.
> After this patch, pci-exynos is re-newed.

Ah, I just  thought that you are not interested in Exynos PCIe anymore. How=
ever, if you want
to submit other patches for supporting other Exynos PCIe, adding you as an =
author is ok.
There are many Exynos SoCs that support PCIe IP. So, if someone like you wh=
o have good
experience on Exynos, helps submitting patches for Exynos PCIe, it would be=
 very helpful. :-)
Thank you.

Best regards,
Jingoo Han

>
> Best Regards,
> Jaehoon Chung
>
> >=20
> > Best regards,
> > Jingoo Han
> >=20
> >>   */
> >=20
> > [....]
> >=20


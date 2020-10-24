Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B66297A98
	for <lists+linux-pci@lfdr.de>; Sat, 24 Oct 2020 06:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgJXEDt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Oct 2020 00:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgJXEDt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Oct 2020 00:03:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D85C0613CE;
        Fri, 23 Oct 2020 21:03:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b6so122337pju.1;
        Fri, 23 Oct 2020 21:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=8b1gjZAvYNDWpjCtbAM+7Rxeawq1Vxd+qcM6g3MNCkE=;
        b=D2OrAwxaKh5Qqn+u5eLsbufnFvStYXhf3/oZjt8lI03dqDTa/Zf+L6yslax9q7WEGz
         rUkma2OqollEIj2tcTqBDnrzV3GmGKfoVOk3nsDCvtgIyqHxl49nNRAaklaXBXL0PJcQ
         /dzEzge/aR/PwEVFIGY62R2Adol76iD80EfXkEShy5TO2b4WgEPqcwqUGAWYT6iVlQeI
         hHc8ZORzsEsUMWehNvQ3Ie72NLp9rmxqf8SG60yPs9hHYWwDtCR6kqWeIsZuCDcW1nhZ
         hYieeO8gjlD5BqA6p10yqY5/KSlfLxAyNGaQsUtTmWd5c3W2+vO9zyUJdhhYeBWDaVfl
         oJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=8b1gjZAvYNDWpjCtbAM+7Rxeawq1Vxd+qcM6g3MNCkE=;
        b=O7Wcn4ydY5Xj+UG5IKFtywIfIqgzPf2DIAVgbnxZOmWFhey+5YR6u6VSGP96AA3Fng
         kRFV1Ve5eodTtPLvSRtBQeQ92l9ZfBfznPK7Ngstn1Ld1E3UjqqrWgRCdSvRTkInyJyh
         sFGqaLdbIcQ9zcqDuD1RBAMo3ZeNBWiBDAJQaUmGgwOJKAtu9QoRwWquXee7DyBvu5c5
         fvaWWNdWLcn60NTTGiipRGWLRnKpY2YA+4P73ou2v74wNnLhet/eRk9itsLa06xmbmAW
         9AOwxdcfNkp/l3cLbEU87+emswypNGg9+xST1HB8uc+hNzD1e/MBbzzvhDUzFOdqZXsH
         anOg==
X-Gm-Message-State: AOAM533WQQO7Jp3FFGigAP0yv94xInv2r8KWSgCxxPYfV7aSM/O/nxld
        0tTPCAtk4jJzGJeVPM7l+9g=
X-Google-Smtp-Source: ABdhPJwdgKMDbBGCWKPsKrJol5gWnsWL2uiqQQ+UGSn9R1RA1DhROVT2e68zqZJVVSFLSubipmjmZw==
X-Received: by 2002:a17:90a:fe8:: with SMTP id 95mr5757972pjz.73.1603512228587;
        Fri, 23 Oct 2020 21:03:48 -0700 (PDT)
Received: from SLXP216MB0477.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:9::5])
        by smtp.gmail.com with ESMTPSA id b142sm3750675pfb.186.2020.10.23.21.03.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 21:03:47 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH 0/3] Add support to handle prefetchable memory
Thread-Topic: [PATCH 0/3] Add support to handle prefetchable memory
Thread-Index: AXN2NDUx+xc4qTmAG8JdKFtMo+BvkMZnDOSK
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Sat, 24 Oct 2020 04:03:41 +0000
Message-ID: <SLXP216MB04777D651A59246A60D036A8AA1B0@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
References: <20201023195655.11242-1-vidyas@nvidia.com>
In-Reply-To: <20201023195655.11242-1-vidyas@nvidia.com>
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

On 10/23/20, 3:57 PM, Vidya Sagar wrote:
>=20
> This patch series adds support for configuring the DesignWare IP's ATU
> region for prefetchable memory translations.
> It first starts by flagging a warning if the size of non-prefetchable
> aperture goes beyond 32-bit as PCIe spec doesn't allow it.
> And then adds required support for programming the ATU to handle higher
> (i.e. >4GB) sizes and then finally adds support for differentiating
> between prefetchable and non-prefetchable regions and configuring one of
> the ATU regions for prefetchable memory translations purpose.
>
> Vidya Sagar (3):
>   PCI: of: Warn if non-prefetchable memory aperture size is > 32-bit
>   PCI: dwc: Add support to program ATU for >4GB memory aperture sizes
>   PCI: dwc: Add support to handle prefetchable memory mapping

For 2nd & 3rd,
Acked-by: Jingoo <jingoohan1@gmail.com>
But, I still want someone to ack 1st patch, not me.

To Vidya,
If possible, can you ask your coworker to give 'Tested-by'? It will be very=
 helpful.
Thank you.

Best regards,
Jingoo Han


>
>  .../pci/controller/dwc/pcie-designware-host.c | 39 ++++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.c  | 12 +++---
>  drivers/pci/controller/dwc/pcie-designware.h  |  4 +-
>  drivers/pci/of.c                              |  5 +++
>  4 files changed, 48 insertions(+), 12 deletions(-)
>
> --=20
> 2.17.1


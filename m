Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1ED1CBA56
	for <lists+linux-pci@lfdr.de>; Sat,  9 May 2020 00:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgEHWAe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 18:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727882AbgEHWAe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 May 2020 18:00:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0313AC061A0C;
        Fri,  8 May 2020 15:00:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g13so3632579wrb.8;
        Fri, 08 May 2020 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=xOmnLWYGmk7Cao6x1GQJnELOggocIQqrtI1UISSIhY4=;
        b=OG6y8Q3CTyvuqWZwebHQsVYGxzT1iEbIw7ZjLiavNWd6O1qC5eT9mYaa5IXA2e6OuD
         UIWP8uhnVLbtyTZYxhg25tXLfX3ZA05OUeuEGgHLaNCMSqYTaPfRQ2R52EE1mkPVHp+E
         CaQ7pt4ZSamjkDc1B5hdb3Mzq05xKzyQKN/njw6lTrmM6h3hLV2qOpTGCEMbHoYJYkaZ
         9vTdSYzHCokzC756OXOveAOFrBOJHn0biiNV56d4BAmHyhG/MKEk5gUkrOBb55IAHbR5
         snbB3hkG2JCbJ17Ih2L6dymj1XE3e5+FPxOV65uPNgS27sXk/cgcNcfpE4aVsioKoyV5
         HBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=xOmnLWYGmk7Cao6x1GQJnELOggocIQqrtI1UISSIhY4=;
        b=M2e0ZkQFJPJKRYDln4vGaVGePsE3KsfIdIVwp3DMwny/8xcFqd/GBanPobX9XhiVTZ
         /psov2w1ODD5mUUp30LifKlYNgB2XhuvbasTK6dlWRKWDDWdh9RcgqNDRDuuxh8ZCjYE
         r0dkkEZmR3BuUcYS9A7IkZCt1ZNjUijuGnklLhTgh4bdzNaytpD1aSfXvkwlUXTStPU4
         9i5971OXr9Wxm4dmfRBzz6em/xxpQ7ChIY1RrGgnFbRTBJqq0w+O0U+NKQpvEPj6KaEo
         EHotnIvUnvigav++vJ1Vrhuc9yCTSOvKyTZOCGBsbc6z4LeKNVtACKD91x+1N4eBWuCB
         4SnQ==
X-Gm-Message-State: AGi0Pub7aWROfepxskfyLzjWGXRAaOjdoRXUJ1LUwd1vBY16FVtEXdJ7
        H2kCGZQzhs3DWndtdqtiECs=
X-Google-Smtp-Source: APiQypLFC+sCfhEPJQKEKeZiSHIpA2zKXjg8olq2UWaEJD0i4oV9iZ7WIyEaXgleFcD72u8wfu9FfA==
X-Received: by 2002:adf:e9d0:: with SMTP id l16mr4945242wrn.69.1588975232479;
        Fri, 08 May 2020 15:00:32 -0700 (PDT)
Received: from AnsuelXPS (host186-254-dynamic.3-87-r.retail.telecomitalia.it. [87.3.254.186])
        by smtp.gmail.com with ESMTPSA id q2sm3419042wrx.60.2020.05.08.15.00.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 15:00:31 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Rob Herring'" <robh@kernel.org>
Cc:     "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Sham Muthayyan'" <smuthayy@codeaurora.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Stanimir Varbanov'" <svarbanov@mm-sol.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Andrew Murray'" <amurray@thegoodpenguin.co.uk>,
        "'Philipp Zabel'" <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200430220619.3169-1-ansuelsmth@gmail.com> <20200430220619.3169-10-ansuelsmth@gmail.com> <20200507181314.GA21663@bogus>
In-Reply-To: <20200507181314.GA21663@bogus>
Subject: R: [PATCH v3 09/11] PCI: qcom: add ipq8064 rev2 variant and set tx term offset
Date:   Sat, 9 May 2020 00:00:29 +0200
Message-ID: <012d01d62584$17658bd0$4630a370$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQH0plL6ngkayUAAEEU7BifA9vEwhgKDdr3rAmN2QquoOn3wEA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On Fri, May 01, 2020 at 12:06:16AM +0200, Ansuel Smith wrote:
> > From: Sham Muthayyan <smuthayy@codeaurora.org>
> >
> > Add tx term offset support to pcie qcom driver need in some revision of
> > the ipq806x SoC.
> > Ipq8064 have tx term offset set to 7.
> > Ipq8064-v2 revision and ipq8065 have the tx term offset set to 0.
> >
> > Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> b/drivers/pci/controller/dwc/pcie-qcom.c
> > index da8058fd1925..372d2c8508b5 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -45,6 +45,9 @@
> >  #define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
> >
> >  #define PCIE20_PARF_PHY_CTRL			0x40
> > +#define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(12,
> 16)
> > +#define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
> > +
> >  #define PCIE20_PARF_PHY_REFCLK			0x4C
> >  #define PHY_REFCLK_SSP_EN			BIT(16)
> >  #define PHY_REFCLK_USE_PAD			BIT(12)
> > @@ -118,6 +121,7 @@ struct qcom_pcie_resources_2_1_0 {
> >  	u32 tx_swing_full;
> >  	u32 tx_swing_low;
> >  	u32 rx0_eq;
> > +	u8 phy_tx0_term_offset;
> >  };
> >
> >  struct qcom_pcie_resources_1_0_0 {
> > @@ -318,6 +322,11 @@ static int
> qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
> >  	if (IS_ERR(res->ext_reset))
> >  		return PTR_ERR(res->ext_reset);
> >
> > +	if (of_device_is_compatible(dev->of_node, "qcom,pcie-ipq8064"))
> > +		res->phy_tx0_term_offset = 7;
> 
> Based on my other comments, you'll want to turn this into match data.
> 

I don't understand what you mean here. I really can't think of another way
to set this only for qcom,pci-ipq8064 as ipq8064-v2 and apq8064 use the
same get resource function. Should I create a different get_resources for
the other 2 device?
 
> > +	else
> > +		res->phy_tx0_term_offset = 0;
> > +


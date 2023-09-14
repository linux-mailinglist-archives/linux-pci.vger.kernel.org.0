Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FB47A0F7D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 23:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjINVHQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 17:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjINVHQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 17:07:16 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C69E269D;
        Thu, 14 Sep 2023 14:07:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-502d9ce31cbso2403947e87.3;
        Thu, 14 Sep 2023 14:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694725630; x=1695330430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AVJyPVKLIulflTV3/WSA+XOgCTmNY7LsZuZCObq0St4=;
        b=cuhbdK46eAz+Zi2Dp3K4FAdfmzdY0iMr7Z2faR6PLktSKl8kDQRlNRlJ8LxQW4eRUJ
         yqBKSUS0nXQ0Lm3ibQS96NV1d5OUiWZtlyTHlcP5Z4nWwlhuChsronzHl0Obdsb9kpgv
         Hs/2IdP+8Lc5daBDUExQ6UaQkbd/Eeh+WaJEs8B4SlDpsXGBeH2nh0lm9Now9LSwubjU
         599aJ2cJngQkl6TGKxHW4vHgrpwujOvO4L+I9R513U4UHUeQ8s2Mi8WxcvPYQG1gmnp4
         6T1lVgF2y8nvur9WEqB2ft+Q2vj2RI/ToFYYCxYPd9mFQfUHcpEw22woFo8iJSwS9aWd
         G3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725630; x=1695330430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVJyPVKLIulflTV3/WSA+XOgCTmNY7LsZuZCObq0St4=;
        b=Fs2DfuRpBdIfBoYgreWIUAVVR5kOBqAKJOIJ+/taUnX7YUeDvpK9lFE3UvuluJja25
         32soBSLzbueE9g9nUJEiUoRu+WBkc07y7xmp+IBieoucRIDvEnbm/799DMg5yAgOaCvS
         zC7FER3vFhGI5MjeDsqUwjO0wcDmtY7UrWtVg4rRJSv6IIPeUfs+nK7HmqGnSZQrdi+B
         4xrAJ/0oxIc6s9tzYp5mR7oBaigBshOAgKcokR6U/YneDS5H1mYUYsyqRVZkHmBQubnu
         HHsJ7dPy+rxosrkXxqsa2vDSqJgYUfaQwjVzTb+OD8UlxAVkyyhruO2qWNE3rBVRxHOQ
         L/jg==
X-Gm-Message-State: AOJu0Yykt1WUr0eb2BUxwS0X3O6D5j/0P/HUIkAbCQPDptiGSa6eTlYL
        DCKRFWjIPH3nOoC1vk5iDSo=
X-Google-Smtp-Source: AGHT+IFj1THt0saZ05dJlgfkw8bFwN8RIZCVypUymQNg4WYerxM5cSzoTS1lc/LU8mbqGyBpGhFZtQ==
X-Received: by 2002:a05:6512:234d:b0:4e0:a426:6ddc with SMTP id p13-20020a056512234d00b004e0a4266ddcmr7060798lfu.0.1694725629531;
        Thu, 14 Sep 2023 14:07:09 -0700 (PDT)
Received: from mobilestation ([95.79.219.206])
        by smtp.gmail.com with ESMTPSA id q13-20020ac2514d000000b00502e2e0fa4csm409709lfd.71.2023.09.14.14.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 14:07:08 -0700 (PDT)
Date:   Fri, 15 Sep 2023 00:07:06 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v20 09/19] PCI: dwc: Add EDMA_UNROLL capability flag
Message-ID: <vu43wsorndu6oflrubp5affridnb2j5i4j6kc6jqepg2ucybfp@qra6ztmyjlqa>
References: <20230825093219.2685912-10-yoshihiro.shimoda.uh@renesas.com>
 <20230914160941.GA32484@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914160941.GA32484@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn

On Thu, Sep 14, 2023 at 11:09:41AM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 25, 2023 at 06:32:09PM +0900, Yoshihiro Shimoda wrote:
> > Renesas R-Car Gen4 PCIe controllers have an unexpected register value in
> > the eDMA CTRL register. So, add a new capability flag "EDMA_UNROLL"
> > which would force the unrolled eDMA mapping for the problematic device.
> > 
> > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 8 +++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h | 5 +++--
> >  2 files changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index c4998194fe74..4812ce040f1e 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -883,8 +883,14 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> >  	 * Indirect eDMA CSRs access has been completely removed since v5.40a
> >  	 * thus no space is now reserved for the eDMA channels viewport and
> >  	 * former DMA CTRL register is no longer fixed to FFs.
> > +	 *
> > +	 * Note that Renesas R-Car S4-8's PCIe controllers for unknown reason
> > +	 * have zeros in the eDMA CTRL register even though the HW-manual
> > +	 * explicitly states there must FFs if the unrolled mapping is enabled.
> > +	 * For such cases the low-level drivers are supposed to manually
> > +	 * activate the unrolled mapping to bypass the auto-detection procedure.
> >  	 */
> > -	if (dw_pcie_ver_is_ge(pci, 540A))
> > +	if (dw_pcie_ver_is_ge(pci, 540A) || dw_pcie_cap_is(pci, EDMA_UNROLL))
> >  		val = 0xFFFFFFFF;
> >  	else
> >  		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index b731e38a71fc..c7759a508ca9 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -51,8 +51,9 @@
> >  
> >  /* DWC PCIe controller capabilities */
> >  #define DW_PCIE_CAP_REQ_RES		0
> > -#define DW_PCIE_CAP_IATU_UNROLL		1
> > -#define DW_PCIE_CAP_CDM_CHECK		2
> > +#define DW_PCIE_CAP_EDMA_UNROLL		1
> > +#define DW_PCIE_CAP_IATU_UNROLL		2
> > +#define DW_PCIE_CAP_CDM_CHECK		3
> 

> Why did you make the new DW_PCIE_CAP_EDMA_UNROLL "1" and shift all the
> existing ones down?  If they don't need to be ordered like this,
> leaving the existing ones alone and making DW_PCIE_CAP_EDMA_UNROLL "3"
> would be a simpler one-line diff.

The discussion in framework of which this patch was born is available
here:
https://lore.kernel.org/linux-pci/20221121124400.1282768-6-yoshihiro.shimoda.uh@renesas.com/
So the patch is mainly what I suggested back then. Though in my case
DW_PCIE_CAP_EDMA_UNROLL was intended to have index 2.

Why didn't I add the unrolled DMA-capability macros to the tail of the
list? My intention was to have the IATU and EDMA unrolled capability
flags defined nearby for the sake of having a tiny bit better
readability since functionally they look similar but refer to the
different controller modules. IMO it was better to have the flags
functionally grouped than to save several diff lines.

-Serge(y)

> 
> >  #define dw_pcie_cap_is(_pci, _cap) \
> >  	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
> > -- 
> > 2.25.1
> > 

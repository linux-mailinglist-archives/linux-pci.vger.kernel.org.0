Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753ED773322
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 00:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjHGWxV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 18:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHGWxU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 18:53:20 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81F1FE;
        Mon,  7 Aug 2023 15:53:18 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so8156543e87.2;
        Mon, 07 Aug 2023 15:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691448797; x=1692053597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B/i5I68ANU84CciIcCJAnQyqnTvXcSmGPXr0Lirbv84=;
        b=V9kkL2HEeUEqyPIZf/pjuIF6wKsQFhZNc/1RgCZPTvtSRQP3H4Z4TPU4Y37x3xfK08
         CUUfbQOj4wiIlgszuSbvM3VRzlzjPncFrTng1B579d72D4PQOKDWMBoGAw6gEyjvsyc5
         uVNFRzGeQJwzy8XvgHv9bSNFtHfi8dxwgbVHxKKktNooVEa07+na0MFjWUxeT/ccx3YL
         ImyhdFKsK/0eM6N1hSE1P/SFJe/aTCWdgKivHARn0I9rJIX7uovgZKhMURUw7bbc05tq
         lZtImb1KLbrnLDRDiVWAZ30p0P82JUFgHwPooN9sy8FM/rGLLgXr/MsB/Mn5S7yM2z80
         /YSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691448797; x=1692053597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/i5I68ANU84CciIcCJAnQyqnTvXcSmGPXr0Lirbv84=;
        b=lQQMZWAUXnlokZ6gAKm3Hzf4tzDNMh2zyJ4gNLKHtnRP0D3MdEgjp112WrFwqjpBi7
         xHB2fv4QOCg5VSc1Da9KiaMavsVeJAU/qGsaOjwSuo7RNow0Kuisyui+y/SzahXrpqQ4
         Bh+bWJW0wRL0134zeBAzPTXdBiEICsPOXkyBdpGLmnMNSm5mkKxcEAQNHNwsJpSdsfWL
         uAgI0hrTpPsqL25PWCzmijLH1TkvMeIF58K0U/12QYM/F183yi3WFJUY0u2rJmV2FsXO
         gWT7TWvKVzDbzZyinWbN2S3mDa3AJ2jVfzymTwLG9jYIqmE8x/OSG5VD9JF7hsZOabDF
         jd1w==
X-Gm-Message-State: AOJu0YwZQSlvOOWDnYlRYpXrCaJthgrnV+yp/EmMD5y4av5cFGELzamV
        0kBo2LTEupSZ7Tm2bCBfW1c=
X-Google-Smtp-Source: AGHT+IH7LyiyNaXpaMbLPQL43yfpKfdXEgx37+TsDYy8hL68teTlchwHWrUCGe3HciVCihdrj4QYPQ==
X-Received: by 2002:a05:6512:3da6:b0:4fd:c399:eb25 with SMTP id k38-20020a0565123da600b004fdc399eb25mr10132391lfv.50.1691448796598;
        Mon, 07 Aug 2023 15:53:16 -0700 (PDT)
Received: from mobilestation (89-109-46-22.dynamic.mts-nn.ru. [89.109.46.22])
        by smtp.gmail.com with ESMTPSA id g4-20020a19ee04000000b004fe3b86cfa4sm1648402lfb.197.2023.08.07.15.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 15:53:15 -0700 (PDT)
Date:   Tue, 8 Aug 2023 01:53:11 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v18 08/20] PCI: dwc: Add dw_pcie_link_set_max_link_width()
Message-ID: <o5r2uk55bchfzcz6jokxbzaxlvevwxmjkve2277tdvjmozrfhe@wxxqr7qxqpsy>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-9-yoshihiro.shimoda.uh@renesas.com>
 <4ojfda5tlfu5wnljydzg7jncaa2zmhzgaqn723sst5rp44tfbl@j6ndm27ejinb>
 <TYBPR01MB5341D7A8BF3CDFFE27E261C2D80AA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341D7A8BF3CDFFE27E261C2D80AA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Your attention is required in this thread. Could you please give us
your resolution regarding the issue denoted in my last comment?

-Serge(y)

On Tue, Aug 01, 2023 at 01:50:59AM +0000, Yoshihiro Shimoda wrote:
> Hi Serge,
> 
> > From: Serge Semin, Sent: Tuesday, August 1, 2023 8:54 AM
> > 
> > On Fri, Jul 21, 2023 at 04:44:40PM +0900, Yoshihiro Shimoda wrote:
> > > To improve code readability, add dw_pcie_link_set_max_link_width().
> > 
> > You completely ignored all my comments regarding this patch again.
> > It's getting to be annoying really.
> 
> I'm sorry for that. I completely forgot to add description even though
> I said so on the v17 [1].
> 
> [1] https://lore.kernel.org/linux-pci/TYBPR01MB5341BE7E22A0721672A0FFAFD834A@TYBPR01MB5341.jpnprd01.prod.outlook.com/
> 
> > Once again: "This patch is a preparation before adding the
> > Max-Link-width capability setup which would in its turn complete the
> > max-link-width setup procedure defined by Synopsys in the HW-manual.
> > Seeing there is a max-link-speed setup method defined in the DW PCIe
> > core driver it would be good to have a similar function for the link
> > width setup. That's why we need to define a dedicated function first
> > from already implemented but incomplete link-width setting up
> > code." This is what should have been described in the commit log.
> > If you were a side-reader of the patch could you guess that from your
> > commit log and the patch content? I bet you couldn't. That's why a
> > very thorough description is important.
> 
> Thank you for your suggestion. I have never read the description before.
> About the [1] above, you said just "This patch is a preparation".
> So, perhaps, some trouble happened when I sent an email?
> Anyway, I will replace the commit description to your suggestion and
> add your Suggested-by tag.
> 
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 86 ++++++++++----------
> > >  1 file changed, 41 insertions(+), 45 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 2d0f816fa0ab..5cca34140d2a 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -728,6 +728,46 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
> > >
> > >  }
> > >
> > > +static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
> > > +{
> > > +	u32 lwsc, plc;
> > > +
> > > +	if (!num_lanes)
> > > +		return;
> > > +
> > > +	/* Set the number of lanes */
> > > +	plc = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> > 
> > > +	plc &= ~PORT_LINK_FAST_LINK_MODE;
> > 
> > Once again: this masking is unrelated to the link width setup.
> > Moreover it's completely redundant in here and in the original code.
> > See further for details.
> 
> I got it.
> 
> > > +	plc &= ~PORT_LINK_MODE_MASK;
> > > +
> > > +	/* Set link width speed control register */
> > > +	lwsc = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > > +	lwsc &= ~PORT_LOGIC_LINK_WIDTH_MASK;
> > > +	switch (num_lanes) {
> > > +	case 1:
> > > +		plc |= PORT_LINK_MODE_1_LANES;
> > > +		lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
> > > +		break;
> > > +	case 2:
> > > +		plc |= PORT_LINK_MODE_2_LANES;
> > > +		lwsc |= PORT_LOGIC_LINK_WIDTH_2_LANES;
> > > +		break;
> > > +	case 4:
> > > +		plc |= PORT_LINK_MODE_4_LANES;
> > > +		lwsc |= PORT_LOGIC_LINK_WIDTH_4_LANES;
> > > +		break;
> > > +	case 8:
> > > +		plc |= PORT_LINK_MODE_8_LANES;
> > > +		lwsc |= PORT_LOGIC_LINK_WIDTH_8_LANES;
> > > +		break;
> > > +	default:
> > > +		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
> > > +		return;
> > > +	}
> > > +	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
> > > +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
> > > +}
> > > +
> > >  void dw_pcie_iatu_detect(struct dw_pcie *pci)
> > >  {
> > >  	int max_region, ob, ib;
> > > @@ -1009,49 +1049,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
> > >  	val |= PORT_LINK_DLL_LINK_EN;
> > >  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> > >
> > > -	if (!pci->num_lanes) {
> > > -		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
> > > -		return;
> > > -	}
> > > -
> > > -	/* Set the number of lanes */
> > 
> > > -	val &= ~PORT_LINK_FAST_LINK_MODE;
> > 
> > My series contains the patch which drops this line:
> <snip URL>
> > So either pick my patch up and add it to your series or still pick it up
> > but with changing the authorship and adding me under the Suggested-by
> > tag with the email-address I am using to review your series. Bjorn,
> > what approach would you prefer? Perhaps alternative?
> 
> I'll wait for Bjorn's opinion.
> 
> Best regards,
> Yoshihiro Shimoda
> 
> > Note the patch I am talking about doesn't contain anything what
> > couldn't be merged in. The problem with my series is in completely
> > another dimension.
> > 
> > Bjorn
> > 
> > > -	val &= ~PORT_LINK_MODE_MASK;
> > > -	switch (pci->num_lanes) {
> > > -	case 1:
> > > -		val |= PORT_LINK_MODE_1_LANES;
> > > -		break;
> > > -	case 2:
> > > -		val |= PORT_LINK_MODE_2_LANES;
> > > -		break;
> > > -	case 4:
> > > -		val |= PORT_LINK_MODE_4_LANES;
> > > -		break;
> > > -	case 8:
> > > -		val |= PORT_LINK_MODE_8_LANES;
> > > -		break;
> > > -	default:
> > > -		dev_err(pci->dev, "num-lanes %u: invalid value\n", pci->num_lanes);
> > > -		return;
> > > -	}
> > > -	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> > > -
> > > -	/* Set link width speed control register */
> > > -	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > > -	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
> > > -	switch (pci->num_lanes) {
> > > -	case 1:
> > > -		val |= PORT_LOGIC_LINK_WIDTH_1_LANES;
> > > -		break;
> > > -	case 2:
> > > -		val |= PORT_LOGIC_LINK_WIDTH_2_LANES;
> > > -		break;
> > > -	case 4:
> > > -		val |= PORT_LOGIC_LINK_WIDTH_4_LANES;
> > > -		break;
> > > -	case 8:
> > > -		val |= PORT_LOGIC_LINK_WIDTH_8_LANES;
> > > -		break;
> > > -	}
> > > -	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > > +	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
> > >  }
> > > --
> > > 2.25.1
> > >

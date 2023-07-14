Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3269753A4F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 14:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbjGNMDL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 08:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjGNMDJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 08:03:09 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D634030CD;
        Fri, 14 Jul 2023 05:03:07 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b703cbfaf5so27138031fa.1;
        Fri, 14 Jul 2023 05:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689336186; x=1691928186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZC8loUOQU4q/OG/ho7w2ktS60jwZ4RBA2CCopcQJwbY=;
        b=G5gRcFvxoRGb1hCekCqsDx61LznwAjmK5CMkL5KPzKSaxChxudz9j+NAgqcMS5j+Dw
         l7eOlWyVmG3lRfDfjW/U7vWo8VaC//lFZ+vgrK7XrVNJGbjkMb8lDwiIZS5AZzAbckRX
         GGAHGL3nUlgf9WPUKl9z6/ucYgmWTUAvkVniGmeiQeNlm9iW29TnAsdIlfL1fOi5kp9g
         lH3L+Xcwnm9XiZjBD3MQmEmobJibM+ysxFQ8u0LUOEgDa3GxKvUrxh6UElgL1SUaEqUY
         VwTERc/ov3+NtoquN3uuvo5k18YQbkRtD9HuODTHiXZZ0YMb3ELB8z0ZOf+wbGcN6oda
         yHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689336186; x=1691928186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZC8loUOQU4q/OG/ho7w2ktS60jwZ4RBA2CCopcQJwbY=;
        b=PM7YJBmO227SANQUrysB2CCaypCTkam07Pe7GYfBi4O6bgxgZyHny3H2zLn2f2jARE
         553aoMLkXmYE0KvIgOeGskTVmtc60qBWteP3nEL9rvJWbNQSFzsrUz5n9zRTCyDQX2O3
         ox6Iw984EPves0Xp63NNi6pen5wOVSeAF+KJQ6zIR51NEKnBgC5r+c5/dHcg96KINq1s
         V6LgBkLqvjySb8FyVSxY86COMsRbNDQBkXwLeAPSRjyxQ1+yZlhKSzA7WR6svSgevAlD
         srXsM9ZZwCr2Yotzhndl1xfY6bhha+ZUz6EI12jjhuR7uqrnsMxsIpnifukEkxJgMDmT
         qY6Q==
X-Gm-Message-State: ABy/qLag/iYiRg4WjIfKEqVP+zzqND/5MgHq6qd5ReC2tvc+opIbWqhn
        SQ/LfuHlktAtVkmhotlQ/yo=
X-Google-Smtp-Source: APBJJlGuIFC5pv0MS2dabp7fBSCRdrse+BOQBJxCqERkTfMHweio32XfBQS0MPBvzyjj8Aps09IXDA==
X-Received: by 2002:ac2:560a:0:b0:4f8:7807:a612 with SMTP id v10-20020ac2560a000000b004f87807a612mr3429925lfd.61.1689336185723;
        Fri, 14 Jul 2023 05:03:05 -0700 (PDT)
Received: from mobilestation ([85.249.20.77])
        by smtp.gmail.com with ESMTPSA id j17-20020ac25511000000b004fbae18984dsm1461837lfk.255.2023.07.14.05.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 05:03:05 -0700 (PDT)
Date:   Fri, 14 Jul 2023 15:03:02 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
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
Subject: Re: [PATCH v17 08/20] PCI: dwc: Add dw_pcie_link_set_max_link_width()
Message-ID: <ftqrr7hbf35egkbizl36e4r7gfaascdg3jjfuiumxltosbuppe@xrf454qjoxdf>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-9-yoshihiro.shimoda.uh@renesas.com>
 <3nldn3s27gwdsfyybgg2ady4tkgpxcvsntbpxp4vdbr4myncnc@clivb7gcds3e>
 <TYBPR01MB5341BE7E22A0721672A0FFAFD834A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341BE7E22A0721672A0FFAFD834A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 14, 2023 at 02:11:33AM +0000, Yoshihiro Shimoda wrote:
> He Serge,
> 
> > From: Serge Semin, Sent: Wednesday, July 12, 2023 5:45 AM
> > 
> > On Wed, Jul 05, 2023 at 08:41:54PM +0900, Yoshihiro Shimoda wrote:
> > > To improve code readability, add dw_pcie_link_set_max_link_width().
> > 
> > This is a preparation
> 
> Yes, this is a preparation. So, I'll add such information.
> 
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 86 ++++++++++----------
> > >  1 file changed, 41 insertions(+), 45 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index a531dc50abea..7b720bad7656 100644
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
> > This is redundant and unrelated to the link width setup. See my next
> > comment for solution.
> > 
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
> > Please pick up my patch dropping the line above
> > https://patchwork.kernel.org/project/linux-pci/patch/20230611192005.25636-6-Sergey.Semin@baikalelectronics.ru/
> > and add it to your series before this one.
> 

> I'm afraid but, I cannot pick up your patch into my series because I have a concern
> about the following comment from the PCI maintainer..:
> 
> https://lore.kernel.org/linux-pci/20230612154127.GA1335023@bhelgaas/

I don't know what particularly caused that Bjorn decision but it
wasn't the patches content for sure. Feel free to pick it up with
changing the authorship but add me under the Suggested-by tag with the
email-address I am using to review your series.

-Serge(y)

> 
> Best regards,
> Yoshihiro Shimoda
> 
> > * unless Krzysztof decide to merge it and some another patches from my
> > * series in...
> > 
> > -Serge(y)
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

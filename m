Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8F269A691
	for <lists+linux-pci@lfdr.de>; Fri, 17 Feb 2023 09:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjBQIHD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Feb 2023 03:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjBQIHC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2023 03:07:02 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBE6193C4
        for <linux-pci@vger.kernel.org>; Fri, 17 Feb 2023 00:07:00 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id h38so3911722lfv.7
        for <linux-pci@vger.kernel.org>; Fri, 17 Feb 2023 00:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+odvZ5hvt+Jzr5sXx6Suo3jssqEz7ig18BCmlAR9A4=;
        b=ctzmIg0YxKhxXFz49dM6yoTp/XdYI0IXEN7NSUjWOTq/QCovu/RZHVXvEeLuCe5ckF
         cUhheg6678BJeI8qfgZLNGXqXAZJWYM+OtBd7ooS14dVZJWH1Wuf1Yec5BC16uSQyyma
         4u7/xyBJpace+2oNtGYVV/77jXl6A26h3LYp1m2D6kHgUe/TdCEpq2hIj/+kZ04z8wEL
         1+0iss9bexmm8VLvDhi0ucKkuZmFsg5xAlv15dgSoF783KCIiB5QWZVLD4vj+zmnfKKo
         1hvAhRppFnAZpxLxucVAcXwQU6eNVrOjhJRnOq58S48F5ZnCngF+zdTrMv/MdzbsGzn8
         3iGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+odvZ5hvt+Jzr5sXx6Suo3jssqEz7ig18BCmlAR9A4=;
        b=qK6Otqgq/pVh5YhmIHZclxEQ2S0TStXuxtdNZEiMtTR3rlpcP16xu6kJbZEdQj50NI
         i5qa1ReChgPq1h4g0EvQYyB4hBbznoqZdMgFECh3zgQIdICVFjChOdecJK6u7X33v6V8
         3N2oCjB4hBNTNl6cVbMenRDTg2XUNsHp3eUMjPx0x140+iE3I6X7/iapJoa+3NK/2z5D
         iqa4kyISFeH3nOEwUAASLmIsvUsUD2CUZ065+TAAyyWpW4ng4jSEKcphO+v7tH02vhVz
         t798H8jBpqs3MiI1Ruu9JW4h6k+7p9v/bNyzEm35ocuGSKX9I2nWWeyn1/5oynVuCxQJ
         EKrg==
X-Gm-Message-State: AO0yUKW5Fw7Qi7ACXwAoK5rioc9vueRv7ZnAAKHeys73sapgvrm0KOGS
        gqppSHdS32dAFv7krSDbp1M=
X-Google-Smtp-Source: AK7set8L21Fc6GVtolhQ/1cYsH/bxfxHuBHsEfC8HkP1sHs90YnmjPN/HIoc2wN+LVC6LrXf1WA9jA==
X-Received: by 2002:a05:6512:6b:b0:4db:2ab7:43e6 with SMTP id i11-20020a056512006b00b004db2ab743e6mr209800lfo.44.1676621218871;
        Fri, 17 Feb 2023 00:06:58 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id z10-20020ac2418a000000b004d19e442d53sm602945lfh.249.2023.02.17.00.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 00:06:57 -0800 (PST)
Date:   Fri, 17 Feb 2023 11:06:56 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: dwc: Fix writing wrong value if
 snps,enable-cdm-check
Message-ID: <20230217080656.2rhkfzf7ivhrbvub@mobilestation>
References: <20230216092012.3256440-1-yoshihiro.shimoda.uh@renesas.com>
 <20230216175822.GA3321300@bhelgaas>
 <20230216204930.jvxt3ajny2eymbtn@mobilestation>
 <OSYPR01MB5334E428391F68F9CDA1374ED8A19@OSYPR01MB5334.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSYPR01MB5334E428391F68F9CDA1374ED8A19@OSYPR01MB5334.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 17, 2023 at 12:46:03AM +0000, Yoshihiro Shimoda wrote:
> Hi Bjorn, Serge,
> 
> > From: Serge Semin, Sent: Friday, February 17, 2023 5:50 AM
> > 
> > On Thu, Feb 16, 2023 at 11:58:22AM -0600, Bjorn Helgaas wrote:
> > > On Thu, Feb 16, 2023 at 06:20:12PM +0900, Yoshihiro Shimoda wrote:
> > > > The "val" of PCIE_PORT_LINK_CONTROL will be reused on the
> > > > "Set the number of lanes". But, if snps,enable-cdm-check" exists,
> > > > the "val" will be set to PCIE_PL_CHK_REG_CONTROL_STATUS.
> > > > Therefore, unexpected register value is possible to be used
> > > > to PCIE_PORT_LINK_CONTROL register if snps,enable-cdm-check" exists.
> > > > So, read PCIE_PORT_LINK_CONTROL register again to fix the issue.
> > > >
> > > > Fixes: ec7b952f453c ("PCI: dwc: Always enable CDM check if "snps,enable-cdm-check" exists")
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index 6d5d619ab2e9..3bb9ca14fb9c 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -824,6 +824,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
> > > >  	}
> > > >
> > > >  	/* Set the number of lanes */
> > > > +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> > >
> > > Definitely a bug, thanks for the fix and the Fixes: tag.
> > >
> > 
> > > But I would like the whole function better if it could be structured
> > > so we read PCIE_PORT_LINK_CONTROL once and wrote it once.  And the
> > > same for PCIE_LINK_WIDTH_SPEED_CONTROL.
> > >
> > 
> > I don't see a good looking solution for what you suggest. We'd need to
> > use additional temporary vars and gotos to implement that.
> > 
> > > Maybe there's a reason PCIE_PL_CHK_REG_CONTROL_STATUS must be written
> > > between the two PCIE_PORT_LINK_CONTROL writes or the two
> > > PCIE_LINK_WIDTH_SPEED_CONTROL writes, I dunno.  If so, a comment there
> > > about why that is would be helpful.
> > 
> > There were no sign of dependencies between the CDM-check enabling and
> > the rest of the setting performed in the dw_pcie_setup() function.
> > Originally the CDM-check was placed at the tail of the function:
> > 07f123def73e ("PCI: dwc: Add support to enable CDM register check")
> > with no comments why it was placed there exactly. Moreover I got the
> > Rb-tag for my fix from Vidya Sagar, the original patch author. So he
> > was ok with the suggested solution.
> 
> I think so.
> 
> And, I think the commit 07f123def73e and commit ec7b952f453c are not
> related to PCIE_PORT_LINK_CONTROL. So, PCIE_PL_CHK_REG_CONTROL_STATUS
> handling can be moved everywhere in the function, IIUC. So, I think
> we can have a solution with two patches like below:
> 1) Move PCIE_PL_CHK_REG_CONTROL_STATUS handling before reading
>    PCIE_PORT_LINK_CONTROL (as a bug fix patch).

> 2) Refactor PCIE_PORT_LINK_CONTROL handling to avoid writing
>    the register twice (as a patch for next).

IMO I would leave the procedure as is for now seeing you are going to
move the rcar_gen4_pcie_set_max_link_width() code to the generic part
of the driver in the framework of this patch:
https://lore.kernel.org/linux-pci/20230210134917.2909314-7-yoshihiro.shimoda.uh@renesas.com/
per Rob and my requests.

Thus you'll be able to combine all the bus-width updates into a single
method, like dw_pcie_link_set_max_link_width(). The function will look
as coherent as possible meanwhile the dw_pcie_setup() method body will
turn to be smaller and easier to comprehend. Alas that will imply
updating the PCIE_PORT_LINK_CONTROL and PCIE_LINK_WIDTH_SPEED_CONTROL
registers twice.

@Bjorn, are you ok with that?

-Serge(y)

> 
> I made patches for it like below. But, what do you think?
> --------------- for 1) ---------------
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -806,11 +806,6 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
>  	}
>  
> -	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> -	val &= ~PORT_LINK_FAST_LINK_MODE;
> -	val |= PORT_LINK_DLL_LINK_EN;
> -	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> -
>  	if (dw_pcie_cap_is(pci, CDM_CHECK)) {
>  		val = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS);
>  		val |= PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS |
> @@ -818,6 +813,11 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
>  	}
>  
> +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> +	val &= ~PORT_LINK_FAST_LINK_MODE;
> +	val |= PORT_LINK_DLL_LINK_EN;
> +	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> +
>  	if (!pci->num_lanes) {
>  		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
>  		return;
> ---
> --------------- for 2) ---------------
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -813,19 +813,13 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
>  	}
>  
> +	/* Set the number of lanes */
>  	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
>  	val &= ~PORT_LINK_FAST_LINK_MODE;
>  	val |= PORT_LINK_DLL_LINK_EN;
> -	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> -
> -	if (!pci->num_lanes) {
> -		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
> -		return;
> -	}
> -
> -	/* Set the number of lanes */
> -	val &= ~PORT_LINK_FAST_LINK_MODE;
> -	val &= ~PORT_LINK_MODE_MASK;
> +	/* Mask LINK_MODE if num_lanes is not zero */
> +	if (pci->num_lanes)
> +		val &= ~PORT_LINK_MODE_MASK;
>  	switch (pci->num_lanes) {
>  	case 1:
>  		val |= PORT_LINK_MODE_1_LANES;
> @@ -840,10 +834,12 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  		val |= PORT_LINK_MODE_8_LANES;
>  		break;
>  	default:
> -		dev_err(pci->dev, "num-lanes %u: invalid value\n", pci->num_lanes);
> -		return;
> +		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
> +		break;
>  	}
>  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> +	if (!pci->num_lanes)
> +		return;
>  
>  	/* Set link width speed control register */
>  	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> --------------------------------------------
> 
> Best regards,
> Yoshihiro Shimoda
> 
> > -Serge(y)
> > 
> > >
> > > >  	val &= ~PORT_LINK_FAST_LINK_MODE;
> > > >  	val &= ~PORT_LINK_MODE_MASK;
> > > >  	switch (pci->num_lanes) {
> > > > --
> > > > 2.25.1
> > > >
> > >
> 

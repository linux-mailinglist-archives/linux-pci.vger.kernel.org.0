Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2119F773557
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 02:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjHHAPk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 20:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjHHAPk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 20:15:40 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F41D9;
        Mon,  7 Aug 2023 17:15:38 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe3678010eso8356155e87.3;
        Mon, 07 Aug 2023 17:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691453737; x=1692058537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dy1tF31yGhLbSmYA6zal/YX5JHvJY9UfPrPDMShaJZw=;
        b=JTyik1wG/52pYcheThADg5laBswDmV0U/xrzspTpN8OiG+m+BdCtaSkIwyyIguMExO
         F87cDeFv5u7UKosE8e/8lUKDkKjiaZqAItd+JnzQ4HWvpocij/uKcYcsiqccGUe/so+E
         vZ1e2XPFDx4iXhKQFV5AxjeYikNnHEUfQRd4GcPpbaCgSGZfgrpGH6OO9qmfTMftQc+X
         5Xs39SCgxrHEV4bGLmMInbAfuB3ebwu8OtSXGisFygQ3cH8fCD8y1SJMTs7i2sSIpkkO
         Hzsj+suJ+PCRVlgkJ7cgphL2kcRrwFnuR0F0ZSWo+fL3PKVfmJSIfFyuh2t1MBrdM8w8
         szJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691453737; x=1692058537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dy1tF31yGhLbSmYA6zal/YX5JHvJY9UfPrPDMShaJZw=;
        b=fcMGg+mZV8fKQ9qP01PfvAXuAUL9Z7XkMD8AY9fl9d7Z35Gp+VgXSZ8P44QX8F4a17
         kbWx0gkDntrArDIu9pO8/v84jj43Iq4I0vWWG3pk4R+VFntI/W79B4oM2Cp7phONOsoK
         g92iLaX0E6JukzInfT85e0if3wdVekie7Bo/T5xk5+tVMFpB0TbWhJnUfxzuaXw/HY3/
         5brF8MCxwdUIOyKPOPAzLNX+dZ9iI3ImOwtiDS24fnGW75gaf92CWcBqUUpCmvjhGaKX
         2+Ls/40X4RwK8RIJJ1b2QH7WJNqPcRn50k3ucoK5k6KobtUN7oUFHlaW59zRmCoIkwkn
         a3xg==
X-Gm-Message-State: AOJu0Ywf8/tdLZ629fwBC4xZHStPtA8Gt7BHAncZnyds3IUvR0fdSTs7
        9Ybbok2XBHKBqzP18dKimkotkR9m1oE=
X-Google-Smtp-Source: AGHT+IGOVdAYR7v1G4U9NnlrDHKyPA2QywgtakPRqTA4rr1lfNk1bCgTS37z/2MvvgNY9en25Aib1A==
X-Received: by 2002:a05:6512:20d4:b0:4fb:8a90:396c with SMTP id u20-20020a05651220d400b004fb8a90396cmr6270328lfr.38.1691453736508;
        Mon, 07 Aug 2023 17:15:36 -0700 (PDT)
Received: from mobilestation (109-184-5-128.dynamic.mts-nn.ru. [109.184.5.128])
        by smtp.gmail.com with ESMTPSA id m4-20020a056512014400b004fe311cb604sm1661855lfo.196.2023.08.07.17.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 17:15:35 -0700 (PDT)
Date:   Tue, 8 Aug 2023 03:15:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
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
Message-ID: <rt2vwgmdsxvkb2jh4v6mpnjpfvql44o72nxf663wbnkcvkmift@o2dl5oa435k3>
References: <o5r2uk55bchfzcz6jokxbzaxlvevwxmjkve2277tdvjmozrfhe@wxxqr7qxqpsy>
 <20230807234034.GA276763@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807234034.GA276763@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 07, 2023 at 06:40:34PM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 08, 2023 at 01:53:11AM +0300, Serge Semin wrote:
> > Your attention is required in this thread. Could you please give us
> > your resolution regarding the issue denoted in my last comment?
> 
> Sorry I missed this and thanks for pinging me.  Lorenzo and Krzysztof
> take care of the native controller drivers so I don't pay close
> attention.
> 
> > On Tue, Aug 01, 2023 at 01:50:59AM +0000, Yoshihiro Shimoda wrote:
> > > > From: Serge Semin, Sent: Tuesday, August 1, 2023 8:54 AM
> > > > On Fri, Jul 21, 2023 at 04:44:40PM +0900, Yoshihiro Shimoda wrote:
> > > > > To improve code readability, add dw_pcie_link_set_max_link_width().
> > > > > ...
> 
> > > > > @@ -1009,49 +1049,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
> > > > >  	val |= PORT_LINK_DLL_LINK_EN;
> > > > >  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> > > > >
> > > > > -	if (!pci->num_lanes) {
> > > > > -		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
> > > > > -		return;
> > > > > -	}
> > > > > -
> > > > > -	/* Set the number of lanes */
> > > > 
> > > > > -	val &= ~PORT_LINK_FAST_LINK_MODE;
> > > > 
> > > > My series contains the patch which drops this line:
> > > <snip URL>
> > > > So either pick my patch up and add it to your series or still pick it up
> > > > but with changing the authorship and adding me under the Suggested-by
> > > > tag with the email-address I am using to review your series. Bjorn,
> > > > what approach would you prefer? Perhaps alternative?
> 

> I don't really see the argument here.  AFAICT, Yoshihiro's patch
> (https://lore.kernel.org/r/20230721074452.65545-9-yoshihiro.shimoda.uh@renesas.com)
> is a trivial refactoring to make dw_pcie_link_set_max_link_width(),
> which might be reused elsewhere later, which seems perfectly fine.
> 
> It'd be fine with me to add a little detail in the commit log to
> reference the Synopsys manual, which I don't have.  But doesn't seem
> like a big deal to me.

More details are in one of my earlier comments to this patch which
Yoshihiro promised to add to the patch log on the next patchset
revision. You can read it here:
https://lore.kernel.org/linux-pci/20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com/T/#m8ac364249f40c726da88316b67f11a6d55068ef0

> 
> Dropping the PORT_LINK_FAST_LINK_MODE mask seems like a separate
> question that should be in a separate patch.
> https://lore.kernel.org/linux-pci/20230611192005.25636-6-Sergey.Semin@baikalelectronics.ru/
> says it's redundant, so it sounds more like a cleanup than a fix.

That's the point of my comment. There is no need in copying that mask
to the dw_pcie_link_set_max_link_width() method because first it's
unrelated to the link-width setting, second it's redundant. There is
my patch dropping the mask with the proper justification:
https://lore.kernel.org/linux-pci/20230611192005.25636-6-Sergey.Semin@baikalelectronics.ru/
It would be good to either merge it in before the Yoshihiro' series or
add my patch to the Yoshihiro' patchset. But it's in the patchwork
limbo now, neither you nor Lorenzo or Krzysztof were willing to merge
it in. That's why I suggested to move the patch here with the denoted
alterations. Could you give your resolution whether the suggested
movement is ok or perhaps you or Lorenzo or Krzysztof consider merge
it in as is?

Note this and the next Yoshihiro' patches aren't considered as fixes
for now.

> 
> > > > Note the patch I am talking about doesn't contain anything what
> > > > couldn't be merged in. The problem with my series is in completely
> > > > another dimension.
> > > > 
> > > > Bjorn
> 

> Despite the "Bjorn" that looks like a signature, I did not write the
> "Note the patch ..." paragraph above.
> 
> Bjorn

Ah, sorry. It was my incomplete text. Part of it somehow was dropped from the
message so it turned out to look as a signature. My message was in
response to the Yoshihiro' worry regarding your email:
https://lore.kernel.org/linux-pci/20230612154127.GA1335023@bhelgaas/
What I was saying is that my patch didn't contain anything which could prevent
it from being merged in. So at least the patch content could be easily
copied to his series.

-Serge(y)


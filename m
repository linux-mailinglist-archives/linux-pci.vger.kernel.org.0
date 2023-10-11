Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FE87C5760
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 16:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbjJKOuW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 10:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjJKOuV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 10:50:21 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B595F94;
        Wed, 11 Oct 2023 07:50:18 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c296e6543fso86417941fa.3;
        Wed, 11 Oct 2023 07:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697035817; x=1697640617; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4hEdoIV9Vrx35zLcKUifZjIytGzkt3j9YZqzs49YGsE=;
        b=EX+S8t0ybFR+NcNM9xwez61DJb3CVTvTyv714ELSy6nVC6qCF7oiU/T0VyB+oe7I+h
         bXtvQ8C6Cnvq3TRCfGzrbxdi935QOPfwQsUMaujUZnKP+Jm5LiahFeMwRbKgyXzE7vOT
         LdrimdTHSwk8NWFFMtTzDCE9MoWV3/k7mFbmQKGToG0Jk+FVTk6t6XVnqNGtKkWRexK8
         ZtnoEoPe1qO6HhWyNb2O5oAkEHhh2uRrdpCnbW8CoVY/rkejKOTCeADjTxMEHD+xaAG8
         1jPkE0hlFBR8p2TIdkm+klb5cXHj1ZK6YIDfqMbhDA5tjGDAvx/JCGsOMDVpOplGYOkl
         jFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697035817; x=1697640617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hEdoIV9Vrx35zLcKUifZjIytGzkt3j9YZqzs49YGsE=;
        b=BPk7FI9GOL/OXVWETNwBwnS/u10VEkWrBTdcDln1JgY5Ldtp6hTJjqLYH0G1Crf71C
         4zckhQAV39MbFBnFGdGhJsTCfw/r6O2oWsxjt36/X3rgSV+BObuMfjmEflXs7L2X/vaP
         x8ebqil3x/BCNBh5y/5Y4Uif9wMDzowm77hzqSVzFekfD/AEop6gJZjoFqMWjMS1fI+a
         WhrySo/H7DuFvK0ShQMprYcdSB4ukZgckQlO2hXnYCvEtMSejrvkcl+QZ+yGeoa0kc/p
         0tRIGvwOO2GPWYGap6fhIIwh6pWQM05rcROew56Y4kAvGQwQHJHoWTO0iY7uRzOOlG1D
         Zawg==
X-Gm-Message-State: AOJu0YyBpF9CgJBE+KINhic5DgOkYUaxz7GIvqadyLx59FdeAMQYIA8M
        qpafb3F8AchrvFcXwg4nyN4=
X-Google-Smtp-Source: AGHT+IHImYkyI7ecSdkkIRLaVm8LFs3qxGXVtxdYLnIxKCUF6zOr3h8anAZaQaCDWk26XlVucQOOqA==
X-Received: by 2002:a2e:8895:0:b0:2c2:bdc2:af77 with SMTP id k21-20020a2e8895000000b002c2bdc2af77mr18225719lji.33.1697035816636;
        Wed, 11 Oct 2023 07:50:16 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id w11-20020a2e998b000000b002bffbe767cbsm3012515lji.85.2023.10.11.07.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:50:16 -0700 (PDT)
Date:   Wed, 11 Oct 2023 17:50:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        krzysztof.kozlowski+dt@linaro.org, lpieralisi@kernel.org,
        robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v24 08/16] PCI: dwc: Disable two BARs to avoid
 unnecessary memory assignment
Message-ID: <yaogf4d672yb76lbx7e7gu2ykm7shujfwgqiztfydbsodwuymr@rkffjewg6hnp>
References: <20231011071423.249458-1-yoshihiro.shimoda.uh@renesas.com>
 <20231011071423.249458-9-yoshihiro.shimoda.uh@renesas.com>
 <abf65z7xxsnd7adkg523mneccudwenvdzcw7jpblafqzvhca5n@lbpsch7ztxsn>
 <20231011130727.GA3722793@rocinante>
 <20231011131840.GB5952@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231011131840.GB5952@thinkpad>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Krzysztof, Mani

On Wed, Oct 11, 2023 at 06:48:40PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Oct 11, 2023 at 10:07:27PM +0900, Krzysztof Wilczyński wrote:
> > Hello,
> > 
> > [...]
> > > > +	/*
> > > > +	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
> > > > +	 * Rev.5.20a,
> > > 
> > > and 3.5.6.1 "RC mode" in DWC PCIe RC databook v5.20a.
> > 
> > OK.  I can fix this citation later.
> > 
> > > > +      ... we should disable two BARs to avoid unnecessary memory
> > > > +	 * assignment during device enumeration.
> > > > +	 */
> > > > +	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_0, 0x0);
> > > > +	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_1, 0x0);
> > > > +
> > > 
> > > What's the point in doing this
> > > 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
> > > 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
> > >         ...
> > >         dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
> > > afterward?
> > > 
> > > I guess if the BARs are disabled there is no need in having them
> > > touched. Am I wrong?
> > > 
> > > BTW I failed to understand why the BARs inits was originally needed:
> > > first merging the BAR0 and BAR1 into a single 64-bit BAR, then
> > > switching it back to two 32-bit BARs. Moreover here is what prior DW
> > > PCIe RC v5.x databooks say about the BARs:
> > > 
> > > "3.5.6 BAR Details
> > > Base Address Registers (Offset: 0x10-x14)
> > > The Synopsys core does not implement the optional BARs for the RC
> > > product. This is based on the assumption that the RC host probably has
> > > registers on some other internal bus and has knowledge and setup
> > > access to these registers already."
> > > 
> > > I am not sure I fully understand what it means, but it seems as DW
> > > PCIe cores didn't have anything behind the RC BARs even back then. So
> > > it seems to me that the BARs manipulation was the Exinos PCIe host
> > > specific, from which driver they are originating - commit 340cba6092c2
> > > ("pci: Add PCIe driver for Samsung Exynos").
> > 

> > Would any of the above be something we need to address before this series
> > can be successfully merged?  I am asking if this is a show stopper,
> > something we can fix later, or even something I could address once I take
> > this series again.
> > 
> > Thoughts?
> >

I can't confirm for sure that the BARs manipulations in this patch
will work on the older IP-cores (prior 5.10a) or will be required for
all new controllers (5.10a and newer). Based on the BARs description
posted in the IP-core HW manuals, the CSRs semantic has changed
between the major releases. Old DW PCIe RC IP-core HW-manuals
explicitly state that the BARs are unavailable:

"The Synopsys core does not implement the optional BARs for the RC
product"

New DW PCIe RC IP-cores manual say that the BARs exist, but are
normally unused:

"Two BARs are present but are not expected to be used. You should
disable them to avoid unnecessary memory assignment during device
enumeration. If you do use a BAR, then you should program it to
capture TLPs that are targeted to your local non-application memory
space.... The BAR range must be outside of the three Base/Limit
regions..."

So in theory it's possible to have platforms with the BARs somehow
utilized even in the Root Ports. Though currently AFAICS we don't
have such devices supported in kernel.

> 
> If Yoshihiro can confirm that his controller can work without this patch, then
> I'd vote for dropping this patch and applying the rest.

AFAIR Yoshihiro insisted to have the BARs reset because without
it something didn't work, so he added some comment to justify it:
https://lore.kernel.org/linux-pci/TYBPR01MB534104389952D87385E8745ED8879@TYBPR01MB5341.jpnprd01.prod.outlook.com/
Though based on the comment the BARs reset still seems optional.

One more low-level driver which already does what is implemented in
this patch is the Keystone PCI host-controller driver (see,
pci-keystone.c also activates dbi_cs2 and zeros out the
PCI_TYPE0_BAR0_ENABLED flag). Moreover something similar is done in
the generic DW PCIe EP driver in the framework of the
__dw_pcie_ep_reset_bar() method including the direct BARs zeroing out
(which I questioned in my initial message in this thread). So seeing
this patch would re-do what is already done for the Keystone device
and would add a partly duplicated code it would be reasonable to drop
the patch for now and get the BARs reset back to the Rcar host
low-level driver as it was in v23. We can get back to the topic
afterward and see whether the BARs reset could be done generically for
the RPs. If we figure out that it's required at least for the new
controllers then we'll be able to implement a generic RP/EP BARs reset
method, have it utilized in both DW PCIe core drivers and drop the
respective code from both Rcar and Keystone LLDDs.

-Serge(y)

> 
> This can be submitted later if required.
> 
> - Mani
> 
> > > * BTW Yoshihiro, I am sorry to see your patchset is still under review...(
> > 
> > Yes, we need to draw a line somewhere. :)  I am happy to take this series
> > so we don't miss another merge window.  We can always fix other bits and
> > pieces later and iron out any kinks that might have fallen through the
> > cracks, so to speak.
> > 
> > 	Krzysztof
> 
> -- 
> மணிவண்ணன் சதாசிவம்

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F1156C3ED
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 01:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbiGHTWS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 15:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239533AbiGHTWQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 15:22:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA7B4F668;
        Fri,  8 Jul 2022 12:22:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p4so3599444wms.0;
        Fri, 08 Jul 2022 12:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=XO0dDVXvLMfJHcLz7TRh7hxVEQMX76hwzxaBGeQY1LE=;
        b=Dl/2Xoc2hEtk1klpAb3umPD2VUpDaOFd0VOVLqOTDNQ85NUrzU62T7FukrQTNbpLXz
         h5rsN9bgAETfhHGE4FgeZgx1MDRwVzMxuDCmGMLaqU4fRsAFZALsVCfudeBCYF5Y/EG7
         BXP+tf+t9ssyzTMM3RxLCWW1c06t+vWZZfZ2TIgioHHSQFnIDjwgLY2lqKgAk2XTTpPI
         c1pt3IWSVZjgaV1iLoo7eWX9Nq5FxNxvvcGBpLLBdo56m0MBJDf2qOfrUYne78yoRZ7f
         JD+Pd0SMhj1MbL0UO0KOKjh9EgWQQ7XIP+MZW6jM8kEdvyT1s2XqQnhr0Jhe9nm/s4OT
         2LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=XO0dDVXvLMfJHcLz7TRh7hxVEQMX76hwzxaBGeQY1LE=;
        b=VjLsz2Q7VbKBaXB5UMXk6guZIUszdqpOV41iEuxqL1TmqUFftKHPzEqLZ4f4/TACMI
         CG7zY8UQXUWnOGPWzwDG+5Mx/88gtnt24Is6nZ4udSR3JRwO/Dbb6ye7BEUDoPOyF6ZV
         7UKGn8awo6YOxn0Iedl+pp/sdQKzxwajqJVYp6IRSmcwjKbw/+RAvado+OHkAx7IMsji
         QE7b8+bndezyhlUXJW7Kj7twzAvuCutytub4DZ3gos/AQD4sQU/Id0avYfpXKyvcBMjD
         xIbcnR1aqAn16DRx3VJMPEIOXV5S1rjwGBvo7bQ524w2sV4VCxHWqdY/kJNT8YKkE7xE
         eKdw==
X-Gm-Message-State: AJIora98qsyJDaH78Vnhqr6SWSBYUIh8b4mBmIKyfrlTR+wTgzWpa8Cr
        +8d4inlUqzAu1gNZFqJUkvc=
X-Google-Smtp-Source: AGRyM1uSljtqFO/IaaLPHY0FD+UPGxyaE9SL3h6zyYGH0hp98dmXwzN8FVjmDzXjBY/xIIzur06TNw==
X-Received: by 2002:a7b:cd97:0:b0:3a2:dfcf:dd2d with SMTP id y23-20020a7bcd97000000b003a2dfcfdd2dmr326174wmj.68.1657308133283;
        Fri, 08 Jul 2022 12:22:13 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600c41c300b0039c362311d2sm3318964wmh.9.2022.07.08.12.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 12:22:11 -0700 (PDT)
Message-ID: <62c883e3.1c69fb81.45d3d.7d2a@mx.google.com>
X-Google-Original-Message-ID: <YsiD4TkGIQGzrRNF@Ansuel-xps.>
Date:   Fri, 8 Jul 2022 21:22:09 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lpieralisi@kernel.org, Rob Herring <robh@kernel.org>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        johan+linaro@kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 2/2] PCI: qcom: Move all DBI register accesses after
 phy_power_on()
References: <62c8633a.1c69fb81.f15e3.fbd0@mx.google.com>
 <20220708191709.GA366918@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708191709.GA366918@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 08, 2022 at 02:17:09PM -0500, Bjorn Helgaas wrote:
> On Fri, Jul 08, 2022 at 07:02:48PM +0200, Christian Marangi wrote:
> > On Fri, Jul 08, 2022 at 06:47:57PM +0200, Christian Marangi wrote:
> > > On Fri, Jul 08, 2022 at 06:39:37PM +0200, Robert Marko wrote:
> > > > On Thu, 7 Jul 2022 at 21:41, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Fri, Jun 24, 2022 at 12:44:20PM +0200, Robert Marko wrote:
> > > > > > IPQ8074 requires the PHY to be powered on before accessing DBI registers.
> > > > > > It's not clear whether other variants have the same dependency, but there
> > > > > > seems to be no reason for them to be different, so move all the DBI
> > > > > > accesses from .init() to .post_init() so they are all after phy_power_on().
> > > > > >
> > > > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > > >
> > > > > Would any of the qcom driver folks care to review and ack this?
> > > > > Stanimir, Andy, Bjorn A (from get_maintainer.pl)?
> > > 
> > > Hi Bjorn,
> > > I tested this on ipq806x and the current patch cause regression as pci
> > > doesn't work anymore...
> > > This is a before the patch [1] and this is an after [2].
> > > 
> > > As you notice the main problem here is
> > > [    2.559962] qcom-pcie 1b700000.pci: Phy link never came up
> > > 
> > > The cause of this has already been bisected and actually it was a fixup
> > > pushed some time ago for 2_1_0.
> > > 
> > > Uboot can leave the pci in an underfined state and this
> > > writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > is never called.
> > > 
> > > This is mandatory to a correct init and MUST be called before regulator
> > > enable and reset deassert or the "Phy link never came up" problem is
> > > triggered.
> > > 
> > > So to fix this we just have to have
> > > writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > in qcom_pcie_init_2_1_0 right after the reset_contro_assert.
> > > 
> > > This command is also present in qcom_pcie_init_2_3_2 where the same
> > > exact reg is written so I assume 2_3_2 have the same regression and the
> > > write must be placed in init and can't be moved to post_init.
> > > 
> > > Feel free to tell me how to proceed if I should post an additional patch
> > > or you prefer Robi to respin this with the few lines reverted.
> > > 
> > > [1] https://gist.github.com/Ansuel/ec827319e585630356fc586273db6f0d
> > > [2] https://gist.github.com/Ansuel/63fbcab2681cd28a61ec52d7874fa30d
> > 
> > While testing this I notice something odd...
> > 
> > 2_4_2 prepare the pipe clock only AFTER PCIe clocks and reset are
> > enabled while in 2_1_0... That made me think there could be a problem
> > with the current code of 2_1_0... A quick change made me discover that
> > the problem is actually that we enable prepare_enable clock BEFORE the
> > value is written in PCIE20_PARF_PHY_CTRL.
> > 
> > By moving the clk_bulk_prepare_enable after the "enable PCIe clocks and
> > resets" make the pci work with the current change...
> > 
> > So it could be that the current changes are correct and it's really just
> > a bug in 2_1_0 enabling clock before writing the correct value...
> > 
> > Tell me how to proceed... think at this point a good idea would be to
> > create a separate patch and fix this for good.
> 
> Hmm, I think I made a mistake when I put this patch in the middle and
> applied other stuff on top of it.  I'd like to just postpone this
> patch while we work out these issues, but I think it's not completely
> trivial since it's in the middle.  I'll try to straighten this out
> next week.
>

From my discoveries it really seems just a bug in 2_1_0 with enabling
the phy clk BEFORE setting the require bit...

Moving the bulk_prepare_enable after the bit is set makes everything
works as it should... If you want I can send a patch as that is clearly
a bug and currenty we have a workaround in place...

(with the patch the workaround can be dropped aka we even remove a line
of code)

> > Also bonus question, should I drop the bulk_prepare_enable and follow
> > the pattern of 2_3_2 and enable aux, cfg, master and slave in init and
> > pipe in post init or I can keep it? (still have to test but I assume
> > that it will work.)
> 
> I haven't looked at the code again, but will just offer the opinion
> that unnecessary differences in structure often hide bugs, and they're
> always minor speed bumps for readers.
> 
> Bjorn

Considering it won't change anything and pci 2_1_0 use the bulk api...
calling each clock separately will actually makes things less
readable... Sooo think it's just a line to drop and a code move.

-- 
	Ansuel

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C2D56C379
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 01:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbiGHW3D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 18:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238810AbiGHW3C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 18:29:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DB113B456;
        Fri,  8 Jul 2022 15:29:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h17so166275wrx.0;
        Fri, 08 Jul 2022 15:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=j3LgYrBXb8Xej7w4SzEY3vle6k1E4Iga/2coehYv3mU=;
        b=Ln0Raqskc43v91bpB69fEl7WCNIqeHpX/pEQzUtNNYhPVNvxd4/dVc68WVbQsB5O5D
         82Z+lNnDaHqG/j83N8FP8uHvgQoz7KklD45IoBkViMUQn2XSqIujiPP7Cx/QFy+6+8vx
         NWbhjekgSB4HNecX7eIiqPCAszcPuO2b5M3h9d3gDy97foDANu4ZEWcgqQbN/HRH0HX6
         KJKDVJrxd6vlRw8VOQrZAH/Q+ASmdn+HXQzoHhnMW9WCqIpMNllwHl+VUbLGUWfNVPXy
         SQb6DwrjDuBQlUkqCEiZdCP6dY2EQdm7+wO1pOw8CtpCgdpSS6Jy4HY9yq2ZiDv8AFA6
         Ce0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=j3LgYrBXb8Xej7w4SzEY3vle6k1E4Iga/2coehYv3mU=;
        b=wJgJXLrkF5/F/w+nB/Iyum6T/Zkq9Sb3R/l/2qxGL+OiJpOOMFQuDo7N/D0Dje4Hhm
         dYDi1tCGC8OncuZkudW2TjmhRg3oKeS23kONTGnSGaHoh2I7WUVq7CRTAiJTV0ChPFvz
         tNagHJ3FCHRRmya7NQ/9egzB/nnCf81zRfjJUT6c2A6qoy+3IfnVh0UrTCTg4RYiyOMX
         vcmTjoDnfha1fyX3oybvmxPocx1gmnZvt5dzFo3l8YTEs+OOjWid0IA+FmGLuwiug3aK
         SpcVQEHtflJa1heIjGuM0qasp+FFz/N2QEEJOXFzEdxmwLfFQx3NCXazdX82k8KiirGD
         cUDQ==
X-Gm-Message-State: AJIora9pLdSrRIdmmKdbHbjQG1/TC7liLSR8ZjdTRXjh61xeSferwxIV
        otAWbJXkrAxpV4MVLOs5zZo=
X-Google-Smtp-Source: AGRyM1vAkR67nTSb5NgAstvrN5dvgXn24dki39JTEbusyg9Ghbd4SkYyt+EwbboDwQfj5vimgNNR2Q==
X-Received: by 2002:adf:979b:0:b0:21d:868a:7f3b with SMTP id s27-20020adf979b000000b0021d868a7f3bmr5110569wrb.451.1657319339427;
        Fri, 08 Jul 2022 15:28:59 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id u17-20020adfdb91000000b002185d79dc7fsm30471wri.75.2022.07.08.15.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 15:28:58 -0700 (PDT)
Message-ID: <62c8afaa.1c69fb81.2a871.00ca@mx.google.com>
X-Google-Original-Message-ID: <YsivqE9G6CIEhBSm@Ansuel-xps.>
Date:   Sat, 9 Jul 2022 00:28:56 +0200
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
References: <62c883e3.1c69fb81.45d3d.7d2a@mx.google.com>
 <20220708201125.GA371162@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708201125.GA371162@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 08, 2022 at 03:11:25PM -0500, Bjorn Helgaas wrote:
> On Fri, Jul 08, 2022 at 09:22:09PM +0200, Christian Marangi wrote:
> > On Fri, Jul 08, 2022 at 02:17:09PM -0500, Bjorn Helgaas wrote:
> > > On Fri, Jul 08, 2022 at 07:02:48PM +0200, Christian Marangi wrote:
> > > > On Fri, Jul 08, 2022 at 06:47:57PM +0200, Christian Marangi wrote:
> > > > > On Fri, Jul 08, 2022 at 06:39:37PM +0200, Robert Marko wrote:
> > > > > > On Thu, 7 Jul 2022 at 21:41, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > On Fri, Jun 24, 2022 at 12:44:20PM +0200, Robert Marko wrote:
> > > > > > > > IPQ8074 requires the PHY to be powered on before accessing DBI registers.
> > > > > > > > It's not clear whether other variants have the same dependency, but there
> > > > > > > > seems to be no reason for them to be different, so move all the DBI
> > > > > > > > accesses from .init() to .post_init() so they are all after phy_power_on().
> > > > > > > >
> > > > > > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > > > > >
> > > > > > > Would any of the qcom driver folks care to review and ack this?
> > > > > > > Stanimir, Andy, Bjorn A (from get_maintainer.pl)?
> > > > > 
> > > > > Hi Bjorn,
> > > > > I tested this on ipq806x and the current patch cause regression as pci
> > > > > doesn't work anymore...
> > > > > This is a before the patch [1] and this is an after [2].
> > > > > 
> > > > > As you notice the main problem here is
> > > > > [    2.559962] qcom-pcie 1b700000.pci: Phy link never came up
> > > > > 
> > > > > The cause of this has already been bisected and actually it was a fixup
> > > > > pushed some time ago for 2_1_0.
> > > > > 
> > > > > Uboot can leave the pci in an underfined state and this
> > > > > writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > > > is never called.
> > > > > 
> > > > > This is mandatory to a correct init and MUST be called before regulator
> > > > > enable and reset deassert or the "Phy link never came up" problem is
> > > > > triggered.
> > > > > 
> > > > > So to fix this we just have to have
> > > > > writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > > > in qcom_pcie_init_2_1_0 right after the reset_contro_assert.
> > > > > 
> > > > > This command is also present in qcom_pcie_init_2_3_2 where the same
> > > > > exact reg is written so I assume 2_3_2 have the same regression and the
> > > > > write must be placed in init and can't be moved to post_init.
> > > > > 
> > > > > Feel free to tell me how to proceed if I should post an additional patch
> > > > > or you prefer Robi to respin this with the few lines reverted.
> > > > > 
> > > > > [1] https://gist.github.com/Ansuel/ec827319e585630356fc586273db6f0d
> > > > > [2] https://gist.github.com/Ansuel/63fbcab2681cd28a61ec52d7874fa30d
> > > > 
> > > > While testing this I notice something odd...
> > > > 
> > > > 2_4_2 prepare the pipe clock only AFTER PCIe clocks and reset are
> > > > enabled while in 2_1_0... That made me think there could be a problem
> > > > with the current code of 2_1_0... A quick change made me discover that
> > > > the problem is actually that we enable prepare_enable clock BEFORE the
> > > > value is written in PCIE20_PARF_PHY_CTRL.
> > > > 
> > > > By moving the clk_bulk_prepare_enable after the "enable PCIe clocks and
> > > > resets" make the pci work with the current change...
> > > > 
> > > > So it could be that the current changes are correct and it's really just
> > > > a bug in 2_1_0 enabling clock before writing the correct value...
> > > > 
> > > > Tell me how to proceed... think at this point a good idea would be to
> > > > create a separate patch and fix this for good.
> > > 
> > > Hmm, I think I made a mistake when I put this patch in the middle and
> > > applied other stuff on top of it.  I'd like to just postpone this
> > > patch while we work out these issues, but I think it's not completely
> > > trivial since it's in the middle.  I'll try to straighten this out
> > > next week.
> > 
> > From my discoveries it really seems just a bug in 2_1_0 with enabling
> > the phy clk BEFORE setting the require bit...
> > 
> > Moving the bulk_prepare_enable after the bit is set makes everything
> > works as it should... If you want I can send a patch as that is clearly
> > a bug and currenty we have a workaround in place...
> 
> That'd be great!  Since it's an actual bug fix, I think it would be
> good if it were a separate patch instead of doing in the middle of a
> patch that also does other things.
> 
> Bjorn

Just sent the small fix that will indirectly make this series work as it
should. 

-- 
	Ansuel

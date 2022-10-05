Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888235F5B7D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Oct 2022 23:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiJEVNd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Oct 2022 17:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiJEVNb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Oct 2022 17:13:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE06224BD9;
        Wed,  5 Oct 2022 14:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C6BCB81F50;
        Wed,  5 Oct 2022 21:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD564C433C1;
        Wed,  5 Oct 2022 21:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665004405;
        bh=OYbdBaX1BcxB2O2zUsHIfxOhRluCA5uxN6Qber1Zx6E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JXu5JYjHdsNUl1UmbwqZ6LvAvNT7z58Y6cDuydCMl9Bh/hUEJGMoAq87alB1iLftP
         EhYh465q8wRGyxhuzKjmR1OPgSr7pFegPbjhFiPLP+1LJQYYQ/adCfAP99aglyA7+p
         H7HpXZcPs5ja0w1Y+p4CKdOeiJQV6FXMQYxMMmTpVV7xTXP46u6yo7WrNiuB+OEacJ
         Zwr3vUqE4XDxMHHRb8N/noqVDd6p80/eSiNDtCEaDW2GeIIDWe+TWEnXQ86rCkKcTy
         kaZrHe8FUDzoLpNVUOg1i6kOVJpO+lrOevJQyzm6stgqLJ6Mg1cGoY/o8Bjn5sOPFM
         0lh66u68bh33A==
Date:   Wed, 5 Oct 2022 16:13:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        svarbanov@mm-sol.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-phy@lists.infradead.org, vkoul@kernel.org, kishon@ti.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 1/5] PCI: qcom: Add system suspend and resume support
Message-ID: <20221005211323.GA2390992@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1b079c9-d0b8-6d4d-bf3d-dee45731ee88@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 03, 2022 at 05:40:21PM +0530, Krishna Chaitanya Chundru wrote:
> On 9/30/2022 12:23 AM, Bjorn Helgaas wrote:
> > On Mon, Sep 26, 2022 at 09:00:11PM +0530, Krishna Chaitanya Chundru wrote:
> > > On 9/23/2022 7:56 PM, Bjorn Helgaas wrote:
> > > > On Fri, Sep 23, 2022 at 07:29:31AM +0530, Krishna Chaitanya Chundru wrote:
> > > > > On 9/23/2022 12:12 AM, Bjorn Helgaas wrote:
> > > > > > On Thu, Sep 22, 2022 at 09:09:28PM +0530, Krishna Chaitanya Chundru wrote:
> > > > > > > On 9/21/2022 10:26 PM, Bjorn Helgaas wrote:
> > > > > > > > On Wed, Sep 21, 2022 at 03:23:35PM +0530, Krishna Chaitanya Chundru wrote:
> > > > > > > > > On 9/20/2022 11:46 PM, Bjorn Helgaas wrote:
> > > > > > > > > > On Tue, Sep 20, 2022 at 03:52:23PM +0530, Krishna chaitanya chundru wrote:
> > > > > > > > > > > In qcom platform PCIe resources( clocks, phy
> > > > > > > > > > > etc..) can released when the link is in L1ss to
> > > > > > > > > > > reduce the power consumption. So if the link is
> > > > > > > > > > > in L1ss, release the PCIe resources. And when
> > > > > > > > > > > the system resumes, enable the PCIe resources if
> > > > > > > > > > > they released in the suspend path.

> > > > > > > > > > What's the connection with L1.x?  Links enter L1.x
> > > > > > > > > > based on activity and timing.  That doesn't seem
> > > > > > > > > > like a reliable indicator to turn PHYs off and
> > > > > > > > > > disable clocks.

> > > > > > > > > This is a Qcom PHY-specific feature (retaining the
> > > > > > > > > link state in L1.x with clocks turned off).  It is
> > > > > > > > > possible only with the link being in l1.x. PHY can't
> > > > > > > > > retain the link state in L0 with the clocks turned
> > > > > > > > > off and we need to re-train the link if it's in L2
> > > > > > > > > or L3. So we can support this feature only with
> > > > > > > > > L1.x.  That is the reason we are taking l1.x as the
> > > > > > > > > trigger to turn off clocks (in only suspend path).

> > > > > > > > This doesn't address my question.  L1.x is an ASPM
> > > > > > > > feature, which means hardware may enter or leave L1.x
> > > > > > > > autonomously at any time without software
> > > > > > > > intervention.  Therefore, I don't think reading the
> > > > > > > > current state is a reliable way to decide anything.

> > > > > > > After the link enters the L1.x it will come out only if
> > > > > > > there is some activity on the link.  As system is
> > > > > > > suspended and NVMe driver is also suspended (queues
> > > > > > > will freeze in suspend) who else can initiate any data.

> > > > > > I don't think we can assume that nothing will happen to
> > > > > > cause exit from L1.x.  For instance, PCIe Messages for
> > > > > > INTx signaling, LTR, OBFF, PTM, etc., may be sent even
> > > > > > though we think the device is idle and there should be no
> > > > > > link activity.

> > > > > I don't think after the link enters into L1.x there will
> > > > > some activity on the link as you mentioned, except for PCIe
> > > > > messages like INTx/MSI/MSIX. These messages also will not
> > > > > come because the client drivers like NVMe will keep their
> > > > > device in the lowest power mode.
> > > > > 
> > > > > The link will come out of L1.x only when there is config or
> > > > > memory access or some messages to trigger the interrupts
> > > > > from the devices.  We are already making sure this access
> > > > > will not be there in S3.  If the link is in L0 or L0s what
> > > > > you said is expected but not in L1.x

> > > > Forgive me for being skeptical, but we just spent a few months
> > > > untangling the fact that some switches send PTM request
> > > > messages even when they're in a non-D0 state.  We expected
> > > > that devices in D3hot would not send such messages because
> > > > "why would they?"  But it turns out the spec allows that, and
> > > > they actually *do*.
> > > > 
> > > > I don't think it's robust interoperable design for a PCI
> > > > controller driver like qcom to assume anything about PCI
> > > > devices unless it's required by the spec.

> > >  From pci spec 4, in sec 5.5 "Ports that support L1 PM Substates
> > >  must not require a reference clock while in L1 PM Substates
> > >  other than L1.0".  If there is no reference clk we can say
> > >  there is no activity on the link.  If anything needs to be sent
> > >  (such as LTR, or some messages ), the link needs to be back in
> > >  L0 before it sends the packet to the link partner.
> > > 
> > > To exit from L1.x clkreq pin should be asserted.
> > > 
> > > In suspend after turning off clocks and phy we can enable to
> > > trigger an interrupt whenever the clk req pin asserts.  In that
> > > interrupt handler, we can enable the pcie resources back.

> > From the point of view of the endpoint driver, ASPM should be
> > invisible -- no software intervention required.  I think you're
> > suggesting that the PCIe controller driver could help exit L1.x by
> > handling a clk req interrupt and enabling clock and PHY then.
> > 
> > But doesn't L1.x exit also have to happen within the time the
> > endpoint can tolerate?  E.g., I think L1.2 exit has to happen
> > within the LTR time advertised by the endpoint (PCIe r6.0, sec
> > 5.5.5).  How can we guarantee that if software is involved?

> It is true that it is difficult to guarantee those delays. On our
> internal boards, we are able to achieve this but that is not with
> linux kernel.
> 
> With NVMe attach we have connected the protocol analyzer and tried
> to see if there are any transactions over the link. We found there
> are no transactions on the link once the link enters L1.x till we
> resume the system. As the NVMe is a passive system it is not
> initiating any transactions.
> 
> This whole requirement came from the NVMe driver, it requires
> keeping the link active state when the system is suspended.
> 
> There are only two things we can in do in PCIe suspend as we have to
> turn off PCIe clocks to allow the system to the lowest possible
> power state.
>
> 1) Keep the device in D3 cold and turn off all the clocks and phy
> etc. (It is not an ideal one as this decreases the NVMe lifetime
> because link-down and link-up is treated as a power cycle by a few
> NVMe devices).
>
> 2) This is the one we are proposing where we turn off the clocks,
> phy once the link enters L1ss.

It sounds like both options turn off the clocks and PHY.  But
apparently they do not look the same to the NVMe endpoint?  I guess
NVMe is in D3cold for 1), but it's in D0 for 2), right?

> Can you please suggest us any other possible solutions to meet NVMe
> requirement (That is to keep the link active during suspend) and the
> Qcom platform requirement (that is to turn off all the clocks to
> allow a lower possible power state)? Qcom PCIe controller is
> compatible with v3.1 specification only.

The PCIe spec clearly envisions Refclk being turned off
(sec 5.5.3.3.1) and PHYs being powered off (sec 5.5.3.2) while in
L1.2.

I've been assuming L1.2 exit (which includes Refclk being turned on
and PHYs being powered up) is completely handled by hardware, but it
sounds like the Qcom controller needs software assistance which fields
an interrupt when CLKREQ# is asserted and turns on Refclk and the
PHYs?

5.5.3 does say "All Link and PHY state must be maintained during L1.2,
or must be restored upon exit using implementation specific means",
and maybe Qcom counts as using implementation specific means.

I *am* concerned about whether software can do the L1.2 exit fast
enough, but the biggest reason I'm struggling with this is because
using the syscore framework to work around IRQ affinity changes that
happen late in suspend just seems kind of kludgy and it doesn't seem
like it fits cleanly in the power management model.

Bjorn

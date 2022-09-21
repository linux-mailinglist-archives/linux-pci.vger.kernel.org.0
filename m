Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F815C04CE
	for <lists+linux-pci@lfdr.de>; Wed, 21 Sep 2022 18:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiIUQ5Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Sep 2022 12:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiIUQ5H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Sep 2022 12:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFE5A6;
        Wed, 21 Sep 2022 09:56:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE2A763235;
        Wed, 21 Sep 2022 16:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D85C433D6;
        Wed, 21 Sep 2022 16:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663779363;
        bh=yFjh0wT5HsRYP3bLSZYhZ7J9X1Rof+k/TwTLudEJkQc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r/8WQihAogvVfN/oTI14lVFCr4f8o2Lcy3IB8ZQ1nQkVjlOfsfQiIa2LcgN4zkF9+
         FQOxulbdWKVy1dIJSo57YVMfEv91RN4I9mzNMftDqFmiBwKue1698z2sOcrUiweMLa
         kDfl3HMOQH6gcNXSJe5NX3WOgVWASaM6O3/yy5XR+vNjII/VzL1LtAlCSQnkH/0k0e
         mRQJAd7E7+snXscz2MumUfENdmjpGWO43Eb+wHOZw3QLti+CM4tvBb8Jj62uk+/bp/
         qbqHoaWPHK0sSovao42QmXyIMVkhIK6lgMj11/XSnfOcOYlRinja7xhKNTBqGG9dJI
         79BwUc+AdN04w==
Date:   Wed, 21 Sep 2022 11:56:01 -0500
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
Message-ID: <20220921165601.GA1215223@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed1a1260-0ef4-203a-f073-f5232bfc8466@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, linux-pm since this is real power management magic,
beginning of thread:
https://lore.kernel.org/all/1663669347-29308-1-git-send-email-quic_krichai@quicinc.com/
full patch since I trimmed too much of it:
https://lore.kernel.org/all/1663669347-29308-2-git-send-email-quic_krichai@quicinc.com/]

On Wed, Sep 21, 2022 at 03:23:35PM +0530, Krishna Chaitanya Chundru wrote:
> On 9/20/2022 11:46 PM, Bjorn Helgaas wrote:
> > On Tue, Sep 20, 2022 at 03:52:23PM +0530, Krishna chaitanya chundru wrote:
> > > Add suspend and resume syscore ops.
> > > 
> > > Few PCIe endpoints like NVMe and WLANs are always expecting the device
> > > to be in D0 state and the link to be active (or in l1ss) all the time
> > > (including in S3 state).
> >
> > What does this have to do with the patch?  I don't see any NVMe or
> > WLAN patches here.
>
> Existing NVMe driver expecting NVMe device to be in D0 during S3 also. If we
> turn off the link in
> suspend, the NVMe resume path is broken as the state machine is getting
> reset in the NVMe device.
> Due to this, the host driver state machine and the device state machine are
> going out of sync, and all NVMe commands
> after resumes are getting timed out.
> 
> IIRC, Tegra is also facing this issue with NVMe.
> 
> This issue has been discussed below threads:
> 
> https://lore.kernel.org/all/Yl+6V3pWuyRYuVV8@infradead.org/T/
> 
> https://lore.kernel.org/linux-nvme/20220201165006.3074615-1-kbusch@kernel.org/

The problem is that this commit log doesn't explain the problem and
doesn't give us anything to connect the NVMe and WLAN assumptions with
this special driver behavior.  There needs to be some explicit
property of NVMe and WLAN that the PM core or drivers like qcom can
use to tell whether the clocks can be turned off.

> > > In qcom platform PCIe resources( clocks, phy etc..) can released
> > > when the link is in L1ss to reduce the power consumption. So if the link
> > > is in L1ss, release the PCIe resources. And when the system resumes,
> > > enable the PCIe resources if they released in the suspend path.
> >
> > What's the connection with L1.x?  Links enter L1.x based on activity
> > and timing.  That doesn't seem like a reliable indicator to turn PHYs
> > off and disable clocks.
>
> This is a Qcom PHY-specific feature (retaining the link state in L1.x with
> clocks turned off).
> It is possible only with the link being in l1.x. PHY can't retain the link
> state in L0 with the
> clocks turned off and we need to re-train the link if it's in L2 or L3. So
> we can support this feature only with L1.x.
> That is the reason we are taking l1.x as the trigger to turn off clocks (in
> only suspend path).

This doesn't address my question.  L1.x is an ASPM feature, which
means hardware may enter or leave L1.x autonomously at any time
without software intervention.  Therefore, I don't think reading the
current state is a reliable way to decide anything.

> ...
> > > Its observed that access to Ep PCIe space to mask MSI/MSIX is happening
> > > at the very late stage of suspend path (access by affinity changes while
> > > making CPUs offline during suspend, this will happen after devices are
> > > suspended (after all phases of suspend ops)). If we turn off clocks in
> > > any PM callback, afterwards running into crashes due to un-clocked access
> > > due to above mentioned MSI/MSIx access.
> > > So, we are making use of syscore framework to turn off the PCIe clocks
> > > which will be called after making CPUs offline.

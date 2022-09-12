Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986E35B5EDD
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 19:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiILRIO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Sep 2022 13:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiILRIN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2022 13:08:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFF62127C;
        Mon, 12 Sep 2022 10:08:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A2C1ACE0F22;
        Mon, 12 Sep 2022 17:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71954C433C1;
        Mon, 12 Sep 2022 17:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663002488;
        bh=K49onmE+E2NcqJj4ukS7ZLgFzwR10wrL5ukkj1ASoOY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=q6Jmf5KBTtxkJRxCTHVLiXCCwsQvS8pGuKBKHH1VZfmD1xRn5vpY4KiPF10GNmrHZ
         3VMq/cBUN9MRDtw3X6gG9MYBlX39681Xol0yAvdETTXhpNXLvtTrD6yDjuESnNrtrN
         fYsSjvUrTfAXD6c4mY4IKu8IVK9RubbMXAVRRQnud1z7AXeGH/G4Fj0NOnimkUcqCw
         zxZsJm1zePdRp4JyXpgTN5Wx3nrY37ifsNDsWkpkU/252Pi0KrFHeXOAQyyucaZNX4
         aooA8s5d9t8BbBktQ4RMPu+ja56+vc2U+IIob/B/7nqVXFxBu6/WQq16EJ5ICRSGlx
         CUN0nmM4K02Rg==
Date:   Mon, 12 Sep 2022 12:08:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v6 0/5] PCI: qcom: Add system suspend & resume support
Message-ID: <20220912170806.GA512933@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af79fc4d-4996-bb2c-7388-2d9afd991e7a@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 12, 2022 at 09:40:30PM +0530, Krishna Chaitanya Chundru wrote:
> On 9/10/2022 1:21 AM, Bjorn Helgaas wrote:
> > On Fri, Sep 09, 2022 at 02:14:39PM +0530, Krishna chaitanya chundru wrote:
> > > Add suspend and resume syscore ops.
> > > 
> > > When system suspends, and if the link is in L1ss, disable the clocks
> > > and power down the phy so that system enters into low power state by
> > > parking link in L1ss to save the maximum power. And when the system
> > > resumes, enable the clocks back and power on phy if they are disabled
> > > in the suspend path.
> > > 
> > > we are doing this only when link is in l1ss but not in L2/L3 as
> > > nowhere we are forcing link to L2/L3 by sending PME turn off.
> > > 
> > > is_suspended flag indicates if the clocks are disabled in the suspend
> > > path or not.
> > > 
> > > There is access to Ep PCIe space to mask MSI/MSIX after pm suspend ops
> > > (getting hit by affinity changes while making CPUs offline during suspend,
> > > this will happen after devices are suspended (all phases of suspend ops)).
> > > When registered with pm ops there is a crash due to un-clocked access,
> > > as in the pm suspend op clocks are disabled. So, registering with syscore
> > > ops which will called after making CPUs offline.
> > > 
> > > Make GDSC always on to ensure controller and its dependent clocks
> > > won't go down during system suspend.
> > > 
> > > Krishna chaitanya chundru (5):
> > >    PCI: qcom: Add system suspend and resume support
> > >    PCI: qcom: Add retry logic for link to be stable in L1ss
> > >    phy: core: Add support for phy power down & power up
> > >    phy: qcom: Add power down/up callbacks to pcie phy
> > >    clk: qcom: Alwaya on pcie gdsc
> >
> > This seems fairly ugly because it doesn't fit nicely into the PM
> > framework.  Why is this a qcom-specific thing?  What about other
> > DWC-based controllers?
>
> We wanted to allow system S3 state by turning off all PCIe clocks
> but at the same time retaining NVMe device in D0 state and PCIe link
> in l1ss state.
>
> Here nothing really specific to DWC as PCIe controller remains intact.
> 
> And the Qcom PHY allows this scheme  (that is to retain the link
> state in l1ss even though all pcie clocks are turned off).

Is there somewhere in the PCIe spec I can read about how a link with
clocks turned off can remain in L1.1 or L1.2?

> Since clocks are completely managed by qcom platform driver, we are
> trying to manage them during S3/S0 transitions with PM callbacks.

I'm looking at this text in PCIe r6.0, sec 5.4.1:

  Components in the D0 state (i.e., fully active state) normally keep
  their Upstream Link in the active L0 state, as defined in § Section
  5.3.2 . ASPM defines a protocol for components in the D0 state to
  reduce Link power by placing their Links into a low power state and
  instructing the other end of the Link to do likewise. This
  capability allows hardware-autonomous, dynamic Link power reduction
  beyond what is achievable by software-only controlled (i.e., PCI-PM
  software driven) power management.

How does this qcom software management of clocks fit into this scheme?
It seems to me that if you need software to turn clocks off and on,
that is no longer ASPM.

Bjorn

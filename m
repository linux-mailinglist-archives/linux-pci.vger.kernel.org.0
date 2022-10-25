Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFC560C31D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 07:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJYFJB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 01:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiJYFIr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 01:08:47 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364A7C5100
        for <linux-pci@vger.kernel.org>; Mon, 24 Oct 2022 22:07:59 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 642EA5C0195;
        Tue, 25 Oct 2022 01:07:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 25 Oct 2022 01:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666674476; x=1666760876; bh=6BMqfrRHrq
        xbv2+PSIJ0ko1Xwo92jcNe1wu8VrnVs/I=; b=myHu1KiTEW/JxL93riFLzr0wlI
        CZDfqxUIP++6gBeeabQ+ZCnwnquy301bhjrEz/WeblREpPE+5B+PutvdTXF1374b
        2JNqndV2B9npKzPerNbmnKA1DtpcSw5XAVMZn9X4s7+c2pkw39+Xk8P/TpJtQlu2
        h/IhbdjQ12tzwQEvKAQTSCYei8sRXlinlnIk4Ctt1dSAFJja84M7xFwKCQMhh38F
        AfMKyjaqmM2gerRZdinnv3giH4Qew5LJleLHOhEcaK1RdEftSWc/sCz+1tjIyKhA
        Ug3nilz4pkGKPecwN1Ee06LW5IZLR4LLehSMvpVnEiq7ndtB1XdNHYs2lGaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666674476; x=1666760876; bh=6BMqfrRHrqxbv2+PSIJ0ko1Xwo92
        jcNe1wu8VrnVs/I=; b=D2jfRNo7RWt6oduKbEyqVCeTEDjzTGKSz8CU+mcptKPm
        KOuvIks9nDHwa1HXca1vj5CDmgftfMfPbAc/9sSNatNI2K9nQ4x723gLsLSV0HcJ
        b3U5GefeJs9zodsUlc7iXQy2HPyv4DfN4Np8SKS0QHzqkLhwVvX4m+dpLSbQjojo
        aNKjWI/5Wd63JULA3uk2N1ZeVbftqgkUf3WXHiDGUK7Hn5ChZAs4e5zmxTfZW3P1
        QifM/NdpLEzj7rcVLt9EJWSCVWW6dNYlc9qJ1iwZjDf4osNV22m9iTyTuYoKPZiJ
        7r+uBYgaAivi4l/Iyrdi837bPkSucyDcXkygP2i3Qw==
X-ME-Sender: <xms:LG9XYxUnt13rL7gJgbE89_xKOgFJvzvOc2WAKJxKnMJRrkVUVUCivA>
    <xme:LG9XYxmeavnK4hef6Dd3uYjcD505CMOZuPlPLRlShOKxGI11fuGdkNoQeDYu7DtxC
    g4icUglWK4djlnCEJ8>
X-ME-Received: <xmr:LG9XY9Ye3GD_ggMsbSWGRXXr3hIg4j9fRMLTy2EOIj9Yv5dfv41SOP8KXlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedthedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihlhgv
    rhcujfhitghkshcuoegtohguvgesthihhhhitghkshdrtghomheqnecuggftrfgrthhtvg
    hrnhepvdehvddttdfhfefhtdfgleehfeeggfdujeeuveekudevkedvgeejtddtfefgleei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghoug
    gvsehthihhihgtkhhsrdgtohhm
X-ME-Proxy: <xmx:LG9XY0XRmEcezouRWtIlMqtlqjBESxEsAM3getiEuZW_WEsnPqKUbQ>
    <xmx:LG9XY7nc9MUhLbrW8NElTdeZRsIKXZnKDBIWxCxptnw98MUZH0vUKA>
    <xmx:LG9XYxfNArGPEPtqphwUSKR-2JICCb56uA8XEyy0v7V3TRts3PPuPw>
    <xmx:LG9XY0A2Asq2YERnCZAgkwirbwxmJRjIMIn1h9oxK-UKEI41FA63-A>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Oct 2022 01:07:55 -0400 (EDT)
Date:   Tue, 25 Oct 2022 00:07:47 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] PCI: Align MPS to upstream bridge for SAFE and
 PERFORMANCE mode
Message-ID: <20221025050551.br3ewbegcpz55f5e@sequoia>
References: <20221019182559.yjnd2z6lhbvptwr3@sequoia>
 <20221020202437.GA142348@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020202437.GA142348@bhelgaas>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-10-20 15:24:37, Bjorn Helgaas wrote:
> On Wed, Oct 19, 2022 at 01:25:59PM -0500, Tyler Hicks wrote:
> > On 2022-06-10 23:01:31, Zhiqiang Hou wrote:
> > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > 
> > > The commit 27d868b5e6cf ("PCI: Set MPS to match upstream bridge")
> > > made the device's MPS matches upstream bridge for PCIE_BUS_DEFAULT
> > > mode, so that it's more likely that a hot-added device will work in
> > > a system with an optimized MPS configuration.
> > > 
> > > Obviously, the Linux itself optimizes the MPS settings in the
> > > PCIE_BUS_SAFE and PCIE_BUS_PERFORMANCE mode, so let's do this also
> > > for these modes.
> > > 
> > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > 
> > I wanted to give a little more information about the issue we're seeing.
> > We're having trouble retaining the optimized Max Payload Size (MPS)
> > value of a PCIe endpoint after hotplug/rescan. In this case,
> > `pcie_ports=native` and `pci=pcie_bus_safe` are set on the cmdline and
> > we expect the Linux kernel to retain the MPS value. Commit 27d868b5e6cf
> > preserved the MPS value when using the default PCIe bus mode
> > (PCIE_BUS_DEFAULT) and we're hopeful that this can be extended to other
> > modes, as well.
> 
> Thanks, Tyler.  I need help understanding what's going on here.  An
> example of the topology and what happens and what *should* happen
> might help.

Hey Bjorn and Keith! Thanks for both of your responses and your
patience. They spurred good investigations on my side and I'm learning a
lot as I go.

> Some MPS configuration is done per-device in pci_configure_mps(), and
> some considers a hierarchy in pcie_bus_configure_settings().  In the
> current tree, in the PCIE_BUS_SAFE case:
> 
>   - pci_configure_mps() does nothing (except for RCiEPs).
> 
>   - pcie_bus_configure_settings(bus) looks at the hierarchy rooted at
>     the bridge leading to "bus".  If the hierarchy contains a hotplug
>     Switch Downstream Port, it sets MPS and MRRS to 128 for
>     everything.
> 
>     If it does not contain such a bridge, it finds the smallest
>     MPS_Supported ("smpss") of any device in the hierarchy and sets
>     MPS and MRRS to that for everything.
> 
> If you boot with a hotplug Root Port leading to an empty slot, I think
> the RP MPS will end up being whatever BIOS put there.

I've been talking to the firmware folks on why SAFE mode was selected,
based on Keith's question from Wednesday. From what I've been told,
U-Boot doesn't seed the RP MPS with a value so the kernel sees a value
of 128 for p_mps in pci_configure_mps() when using the DEFAULT mode.
Apparently UEFI does seed the RP MPS but we don't get that with U-Boot.
Therefore, SAFE mode was selected to get an initial, tuned RP MPS value
set to 256.

> A subsequent hot-add will do nothing in pci_configure_mps(), and
> pcie_bus_configure_settings() looks like it would set the RP and EP
> MPS to the minimum of the RP and EP MPS_Supported.
> 
> Is that what you see?  What would you like to see instead?

No, not quite. After hot-add, we see the EP MPS set to 128 with SAFE
mode even though the RP MPS is 256.

So, the question is if SAFE/PERFORMANCE modes are expected to tune the
EP when it is added? We would have thought that EP's would be tuned
based on the algorithm selected as they're hot-added.

Tyler

> 
> Bjorn

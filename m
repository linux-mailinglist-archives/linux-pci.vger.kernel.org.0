Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47004A8424
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 13:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiBCMyz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 07:54:55 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:42029 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232231AbiBCMyy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 07:54:54 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0739C3201F8B;
        Thu,  3 Feb 2022 07:54:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 03 Feb 2022 07:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=sFVMbH/u61xqFO
        frYZwT67pxs+bD6FsPFRLz3xRQj1k=; b=Q7N8uWcHuMmQSRzR71SYkfcpB/3SR6
        likTgwhMVn2qVb92Ekcm8zyIR8oqpsoUPLUIZj2WD7eGh8VgSxNLXJRz/FpSMKtD
        4+MEykr1cdzzsNtisQuRafTV64awHvl6TNBuHEFtcK/Vi+4vf3hsIwvsiAHJWUZD
        fGco/4DX6gW3Fi7Kl7y7QmVHxTEcD13rsb9uh4LqON/bVAP+9LLSTAHHma5r8iWJ
        ZkxeXEbonSc+HIfyJTom42yDaVlw9QPLU43NHSu6N9NINRIbOrXzQupZifZ7fP54
        vCQmiL0BxS3xgCfA9IVEGVXhsM4qFBKE6XRqEMrHyiG5XDCca/uVhuzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=sFVMbH/u61xqFOfrYZwT67pxs+bD6FsPFRLz3xRQj
        1k=; b=cro2syQiAVfavGM07ND2ihAVvrCo1Y2/x4H/roL+001nuSHvKEtTj6VZT
        ph6YN26OxsxYKguPv+VVaYh70XgXwfR8Qc99afdLHz5SqouQHebYnMo3/DuJi8dI
        4u/R65XDe0G4AOc2VO+bCT2xSdA2LKTGlaGR0a3R14ZBe71ODccjRopYbI2rEcWX
        OZ+bWoUQMM+4u+pUbflqCGh8A9IqCbN5xIiIv6NPiwbfstDVLZ1Z3LWRfNPgY3BU
        UWnNsINHsExu12QOt95mlnh5/qVWIUgrqTVMB0K1n5sq3racSWOahokSK+WPlFqk
        PhHToJTey3OqqtJPIDmBB9IiHTPmQ==
X-ME-Sender: <xms:ndD7YWB-W8yrk57iJk11kHl2hI5-HtWyV6rn0-9vCbmI_bDa4o79Ng>
    <xme:ndD7YQgr9T4e8EOWeM0ClquzNWy43BEuXd6mdmkz_aqhgMO78LEcmiho6cZDEdyUT
    z7e4614y9KI1v_sxg>
X-ME-Received: <xmr:ndD7YZnazKXVtTfoo3vXLwhzVZ8UE4lNs0xDM_WAtySsBa74YcjGOwWvyxW4xrhO-5SWzDH2DvnQLP_1AYKXRW-qrY819w85dUIq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeejgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjfgesthekredttderjeenucfhrhhomheplfgrnhcu
    rfgrlhhushcuoehjphgrlhhushesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeekvdeifeegtddvvdduudetiedukeevffejheeufeeuueejgfettedthfevfeej
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepjhhprghluhhssehfrghsthhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:ndD7YUz1jRyfBJshT54KL963jaQp8gWVxrrSRflFoPI425aOz_8SeA>
    <xmx:ndD7YbR9J_mXDxkuiS7ztAGuLDbx3zJ4wzLGV1oUR4HFDY8rq6UP8g>
    <xmx:ndD7YfbZlgvxokqnSL35sDl__8i0nbttDJpH-XfsMCZS5hBqYZ5txw>
    <xmx:ndD7YVdICGBDVs1ZldNL0TE11WBrO2Wss_Rjfrg6O8-HmJsqPqt7Iw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Feb 2022 07:54:52 -0500 (EST)
Date:   Thu, 3 Feb 2022 13:54:50 +0100
From:   Jan Palus <jpalus@fastmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [Bug 215540] New: mvebu: no pcie devices detected on turris
 omnia (5.16.3 regression)
Message-ID: <20220203125450.umejyt5j5k2h4s4o@pine.grzadka>
References: <bug-215540-41252@https.bugzilla.kernel.org/>
 <20220127234917.GA150851@bhelgaas>
 <20220203122642.o3xlndouz46hewef@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220203122642.o3xlndouz46hewef@pali>
User-Agent: NeoMutt/20211029
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03.02.2022 13:26, Pali Rohár wrote:
> Hello!
> 
> [+ Marek]
> 
> On Thursday 27 January 2022 17:49:17 Bjorn Helgaas wrote:
> > [+cc Thomas, Pali]
> > 
> > On Thu, Jan 27, 2022 at 10:52:43PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=215540
> > > 
> > >             Bug ID: 215540
> > >            Summary: mvebu: no pcie devices detected on turris omnia
> > >                     (5.16.3 regression)
> > >            Product: Drivers
> > >            Version: 2.5
> > >     Kernel Version: 5.16.3
> > >           Hardware: ARM
> > >                 OS: Linux
> > >               Tree: Mainline
> > >             Status: NEW
> > >           Severity: normal
> > >           Priority: P1
> > >          Component: PCI
> > >           Assignee: drivers_pci@kernel-bugs.osdl.org
> > >           Reporter: jpalus@fastmail.com
> > >         Regression: No
> > > 
> > > After kernel upgrade from 5.16.1 to 5.16.3 Turris Omnia (Armada 385)
> > > no longer detects pcie devices (wifi/msata). Haven't tried 5.16.2
> > > but it doesn't seem to have any relevant changes, while 5.16.3
> > > carries a few.
>
> I'm not sure where is the issue and why it crashes. But I tested all
> sent pci patches on Turris Omnia in the past and they worked fine.

Not sure if it's of any help but I've added info to bz about specific
commit that seems to cause the regression:

commit 7cde9bf0731688896831f90da9fe755f44a6d5e0
author Pali Rohár <pali@kernel.org>
PCI: mvebu: Fix configuring secondary bus of PCIe Root Port via emulated bridge

[ Upstream commit 91a8d79fc797d3486ae978beebdfc55261c7d65b ]

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.16.y&id=7cde9bf0731688896831f90da9fe755f44a6d5e0

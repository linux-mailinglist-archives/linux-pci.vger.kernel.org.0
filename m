Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E64645602
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 10:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiLGJFq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 04:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLGJFp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 04:05:45 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB6526AC2;
        Wed,  7 Dec 2022 01:05:44 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B2C0F32009E1;
        Wed,  7 Dec 2022 04:05:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 07 Dec 2022 04:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1670403942; x=
        1670490342; bh=JFoXxMClww2l4RygoD+XW2GsjAAbe5uznYYD7nEj5+A=; b=A
        m+3Xd9pOm+9ctEko/ry4U6uTcBmcKTxoSXhrOYjFkNzs/UPFQ3eYMIW6MPgw2H6r
        W71NHDCfNlVOyxGK6QEtxyF8rdWdUjylzGuvSzy+iI1cTIyDvUZOhVgBzXAR4pdP
        zDSd0d9YPMphKkyku5QEjEG38WA26pdIxpRsHBm55ScFgaM4uCv5/xQ+rjaYprZL
        A+fvdT8D23+KOupjIeylZk5InsaqGNrVUifuJpVIM5mUkn0HoOyyvrRmtFXSq5Yl
        X1CHYaDxQcHEXMHnut+AsYWLGLPjewjytElsnMWmy1+yzdHdszmkfkCF+BE8Ba8Z
        d1Ny7AxdMcZGwGVoyRnaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1670403942; x=
        1670490342; bh=JFoXxMClww2l4RygoD+XW2GsjAAbe5uznYYD7nEj5+A=; b=o
        u/WWNWj8Jc92d/UtZbf4Nr+ZIPhRQ0768ZQ/Sf+INAMi26NBhtJLUu9aNRQpIK9I
        Dam5k6gOJvt4nfYzC9GRZMJosLhHrmL/Pm/8dRS05pKgo6R9gGptihDfIDu9dNYb
        HJvCMcVklYC9LtlK36zKlfetDEM/mF5y2GF8AGbWq1D7lUzoNiZJRbGbSlQDH9p5
        ACR3p5CiE0mnOoBA0RkzabymijwuKJmhCobq8TlPRt9je7WUgCesGxbKkEguZVG+
        l1xHMxvwWGFnyNSwJOpnHQtIhs6OMDxTKMQ74pAabh6fLRKqrS/w9WScvW5DyFCy
        4gxPK3Ki3pdCGhXaZWGPw==
X-ME-Sender: <xms:ZVeQY6JcmBl9r8UaSgPQlsL6kBpyH4upmsXGoJ4JZ0S4Apf8Uzw2tQ>
    <xme:ZVeQYyIZZ_J4e1TTTEmsSwTW5tyJbARUJ4hEG-TJP_Lki94M9bKzSpCOlPByJH2t7
    pMAV4LFMsEEUlVV95U>
X-ME-Received: <xmr:ZVeQY6uXMnU1qz7wIIZC_5ZP-dESYU4i7Aar3YknT1ZO2v4AkA5mOobw-mndir-YpJ-2wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfevffgjfhgtgfgfggesth
    hqredttderjeenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgv
    shdruggvvheqnecuggftrfgrthhtvghrnhepteegteefhefhteegleejudfffffghfekle
    eijeeugfffteeiudefvdetteeuuedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:ZVeQY_ahVbtfiYjhg_k2eYSq-uPXq1xkiFLHac3vmlI3yXJqdoKeog>
    <xmx:ZVeQYxa-BJIz-lhlN77iSktQ8_NETM1TjQY8KXMwVRQe91NiGV1Q5w>
    <xmx:ZVeQY7BP-z-UuGNNFk8YZcB2ihklL1TIm-yrdTrk8nj3ewRVuCLcJA>
    <xmx:ZleQY-QBDw9ZgrfCGBIIbxE3z6H9QizXgV3ZnQTGdJ6RWbka1UWQVQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Dec 2022 04:05:35 -0500 (EST)
Message-ID: <8b8c7ae512291532ea227b8a1c3f87c460e11e2f.camel@ljones.dev>
Subject: Re: [PATCH V8 0/4] PCI: vmd: Enable PCIe ASPM and LTR on select
 hardware
From:   Luke Jones <luke@ljones.dev>
To:     "David E. Box" <david.e.box@linux.intel.com>,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 07 Dec 2022 22:05:28 +1300
In-Reply-To: <20221103021822.308586-1-david.e.box@linux.intel.com>
References: <20221103021822.308586-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2022-11-02 at 19:18 -0700, David E. Box wrote:
> This series adds a work around for enabling PCIe ASPM and for setting
> PCIe
> LTR values on VMD reserved root ports on select platforms. While
> configuration of these capabilities is usually done by BIOS, on these
> platforms these capabilities will not be configured because the ports
> are
> not visible to BIOS. This was part of an initial design that expected
> the
> driver to completely handle the ports, including power management.
> However
> on Linux those ports are still managed by the PCIe core, which has
> the
> expectation that they adhere to device standards including BIOS
> configuration, leading to this problem.
>=20
> The target platforms are Tiger Lake, Alder Lake, and Raptor Lake
> though the
> latter has already implemented support for configuring the LTR
> values.
> Meteor Lake is expected add BIOS ASPM support, eliminating the future
> need
> for this work around.
>=20
> Note, the driver programs the LTRs because BIOS would also normally
> do this
> for devices that do not set them by default. Without this, SoC power
> management would be blocked on those platform. This SoC specific
> value is
> the maximum latency required to allow the SoC to enter the deepest
> power
> state.
>=20
> This patch addresses the following open bugzillas on VMD enabled
> laptops
> that cannot enter low power states.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D212355
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215063
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D213717
>=20
> David E. Box (3):
> =C2=A0 PCI: vmd: Use PCI_VDEVICE in device list
> =C2=A0 PCI: vmd: Create feature grouping for client products
> =C2=A0 PCI: vmd: Add quirk to configure PCIe ASPM and LTR
>=20
> Michael Bottini (1):
> =C2=A0 PCI/ASPM: Add pci_enable_link_state()
>=20
> =C2=A0drivers/pci/controller/vmd.c | 96 ++++++++++++++++++++++++++-------=
-
> --
> =C2=A0drivers/pci/pcie/aspm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 54 ++++++++=
++++++++++++
> =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 7 +++
> =C2=A03 files changed, 131 insertions(+), 26 deletions(-)
>=20
>=20
> base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740

I'd like to confirm that this patch series solves the VMD power issues
present on the ASUS ROG M16 (GU603) laptop range (PCI dev ID =3D 467f).

The difference is quite drastic.


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8051F39CDF7
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 10:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhFFIDP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 04:03:15 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49985 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhFFIDP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Jun 2021 04:03:15 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C92095C0041;
        Sun,  6 Jun 2021 04:01:25 -0400 (EDT)
Received: from imap1 ([10.202.2.51])
  by compute3.internal (MEProxy); Sun, 06 Jun 2021 04:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=nq57y
        eur5xXa0i8Ro0x7p7wYjCgiQLkC78LCIy23/6o=; b=HH/Yr3cIrnec8vs1odQi8
        /rF3YQOL8TuBbcPWWwLWlEmraUVR5NXpO+81VZQtGfWiY28vXhoDDFyP+2m64wKN
        X+kNm3lK+6RbqlZh5UbzDtT0Y0PUepmzNGw2GXCyJCqm4YsMmHsARe4DdVTvtr7c
        Zr6UGHZRneEiXopQpl1qrxJFuJDrT0xaRHP92eUMghIv2FQsj9tOUzQB/x5AfkSS
        Kriwoo0SMlyAjJgygOhC63ZiSpsqUtpsPFR+S11PUQkprj+UxHu/PjHfp+c/xFhQ
        gr/zFQ8SGTPnB9SIdWyxeB778W99lS25csl83mk35VjswjPU1u2qjeM7rjH5nvNh
        w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=nq57yeur5xXa0i8Ro0x7p7wYjCgiQLkC78LCIy23/
        6o=; b=feenwyMCIuk6MsQpjentNloWVR9n4OCcW2T4+gqoncNPHtgQxTqMg5TjZ
        e2MZ25iBndedC3a+VfXKxPkKS8NDFyPLyWbk0/JjhXnQRXyUXGviovwPa92cKMw3
        g6HfWWUa2UVP5ACJGcPe434oVdgPcsw2pz92sl9uemlkpFllPbDojbLjagVhfqrj
        2E775zFkjpQDUtffTnQEofOuhYwhXU1LEugyl1oEpZUtikRH+RQ9G9gYv0OBhc0y
        juXw+u6Ua0eJEok42mZRQcF1qydmcHhGyT1kcElffLBvGcX00ZwWlYOnqkixGaZu
        dHBedDDWLMGac15GB58wxM+W7WSYA==
X-ME-Sender: <xms:1IC8YFlgBWbXNcKEiN4gjSMrryH67SXIf0Ie7Xk1ZuekPUNbGZn-xw>
    <xme:1IC8YA0Y3Iz_RREtN9BZ2MIWzWv635LaGSX0mE0kqVyAjElpytDPc3IgCazM02XnG
    AeLGGL2YIg2Fo6Plvo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtgedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeefteegkeevfeethffgudehgedvueduvdeifedvvdel
    hfefheekteefueektdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:1IC8YLpDriAs8VvD2DPt8kGV2Sp7rezMy52bfqggXEnQMBmJTBCXCg>
    <xmx:1IC8YFleZ3v8VMVX_j3ZU3pkvaljRkasMxVbUPmNMkloigXvGmg-iQ>
    <xmx:1IC8YD3mFs7oRt3VbWZrCcfoB7dAf9saqV4bX1TWw6a9ooY2jWx0Vg>
    <xmx:1YC8YD_QgLDLRbC7Ih1rkpbVxY_huyTU4_2LKNUu_pC20JIkDdnFiQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1DC76130005F; Sun,  6 Jun 2021 04:01:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <56dcd0ca-f6c5-4653-a028-f70d274497ab@www.fastmail.com>
In-Reply-To: <20210605212854.GA2324905@bjorn-Precision-5520>
References: <20210605212854.GA2324905@bjorn-Precision-5520>
Date:   Sun, 06 Jun 2021 16:01:02 +0800
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>,
        "Huacai Chen" <chenhuacai@gmail.com>
Cc:     "Huacai Chen" <chenhuacai@loongson.cn>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Jianmin Lv" <lvjianmin@loongson.cn>,
        "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH V2 4/4] PCI: Add quirk for multifunction devices of LS7A
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



=E5=9C=A82021=E5=B9=B46=E6=9C=886=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=885:28=EF=BC=8CBjorn Helgaas=E5=86=99=E9=81=93=EF=BC=9A
> both ACPI and DT to rely on it.
>=20
> But this quirk applies to [0014:7a09], [0014:7a19], and [0014:7a29],
> which look like they are PCIe Root Ports, and your DT ([2]) *does*
> seem to describe them with interrupt descriptions.  So I assume the
> reason DT systems don't care about this quirk is because they use this=

> IRQ info from DT and ignore the PCI_INTERRUPT_PIN?
>=20
> If DT systems ignore the quirk, as you said above, I assume that means=

> that DT overwrites dev->pin sometime *after* the quirk executes?  Or
> there's some DT check that means we ignore dev->pin?  Can you point me=

> to whatever this mechanism is?

dev->pin won't affect hardware behavior. The only place that kernel uses=

dev->pin is mapping them to the actual IRQ number. For DT based system, =
this
is handled by of_irq_parse_pci.
For the present system, all four INTA,B,C,D are routed to the same upstr=
eam IRQ,
thus wrong dev->pin will still get correct mapping.

I'm unable to get my hand on an ACPI system but I guess Loongson uses di=
fferent
mapping scheme on these systems so dev->pin will matter.

Thanks.
--=20
- Jiaxun

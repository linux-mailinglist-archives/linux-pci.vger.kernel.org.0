Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C4A53A47D
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 14:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351657AbiFAMAU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 08:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238350AbiFAMAR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 08:00:17 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CDCDC
        for <linux-pci@vger.kernel.org>; Wed,  1 Jun 2022 05:00:15 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3707B5C020C;
        Wed,  1 Jun 2022 08:00:12 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Wed, 01 Jun 2022 08:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1654084812; x=
        1654171212; bh=vRdiy8zLnoAxVa/+vcYtbT+GYF2q4/9FVfuuYyjTCqw=; b=s
        EA3YA2rLRYFsLCWXIVjMCPQGEKVhzOtqRdmBKA8dsC26SVmCPyoIVnsr+e9WIdE4
        ljvsgwJ1oN9MGtutx7qmVo2DWtYhWLCvjvx1nuDebi8RNYXW91918zKvjganRzga
        kNnPKwylW/VAy3M9PhsipWuNWrgiGN08bjbCtundRTXyhrSpn4+dHwx4sVaYIw3M
        RSVIneG7WHkXyB048FDExVqYGoSAWUCSnpz+zcawU9Os/l3vHIZPVLYkQQKUmfad
        mZEsc0OlCiGxbnJ/sszw2fuPA5+c/pP842KbmxxpqR1bUoR4U2vCbV6ZVc1KYDFp
        JQqVZY27Hjfmkuitd4Fzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654084812; x=
        1654171212; bh=vRdiy8zLnoAxVa/+vcYtbT+GYF2q4/9FVfuuYyjTCqw=; b=V
        uX/gO9yREE00Xog5IVcL4DQDDqtUaYdBfKGJ0NMIIw/RTxg33ZX4TVoSXX+aZh56
        BYHyVcuOBRb5lihAWFcQypmzSt0LxlY86wro45rPzReCtI4p6tVR8zBK0E72ErAR
        7Ii4j8UPKgjAIcrV+bkbR+ws0W1xFmD3zf6TNsE5ciN/FNzR4LBQjlCg+6c/Shna
        jwozOzA3yY0XXRLlIEolZGDucrNVGSMkYd/pcI67ks0YCMJ2x+X/jnC8aK6tigFs
        toBTJUkm+NrxBvLDTeqaLJUUpDZMfl+8PQLEAP/ffO2Hl5HvJaASBnHFcBrd9Oq5
        fGvvD7Fj/nbF3k7SO7kxw==
X-ME-Sender: <xms:ylSXYoZkOpgTT7p8Oxl3Ar8X7r_zsw3gTbDes8c0e--_-8SYW2Kcjg>
    <xme:ylSXYjZNq27diZYtnKum364ohuatzaE5bl8BBaf79YL1hMa5G1r3OfC5NcJl-eB67
    zDQn8fCTjpuFqcqAJU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrledtgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepkeelveffhedtiefgkeefhffftdduffdvueevtdffteeh
    ueeihffgteelkeelkeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigr
    nhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:y1SXYi-8dv-eLATt5DvFwtnUPB2YmISQWiTHALm821yu-Xy26HQJnQ>
    <xmx:y1SXYirG1_QScb4Jf_c4NMzjf5IhRwFj6_3A-pM_niUd99B2pwjB8A>
    <xmx:y1SXYjrg5HJxY9ab_6KFc7sUELBC_ig_IROZcvadTtUTbQSg_QqEQw>
    <xmx:zFSXYkf3wZO8D6RhsQoSwGgjcFZF-UEWgiC22-naR0Ol6l2WF01Fsg>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A696036A006D; Wed,  1 Jun 2022 08:00:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <06d1f3d1-2864-458a-a1f0-ed3047b1cddf@www.fastmail.com>
In-Reply-To: <20220601022210.GA796391@bhelgaas>
References: <20220601022210.GA796391@bhelgaas>
Date:   Wed, 01 Jun 2022 12:59:50 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>,
        "Huacai Chen" <chenhuacai@loongson.cn>
Cc:     "Bjorn Helgaas" <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Huacai Chen" <chenhuacai@gmail.com>
Subject: Re: [PATCH V13 4/6] PCI: loongson: Improve the MRRS quirk for LS7A
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



=E5=9C=A82022=E5=B9=B46=E6=9C=881=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=883:22=EF=BC=8CBjorn Helgaas=E5=86=99=E9=81=93=EF=BC=9A
> On Sat, Apr 30, 2022 at 04:48:44PM +0800, Huacai Chen wrote:
>> In new revision of LS7A, some PCIe ports support larger value than 25=
6,
>> but their maximum supported MRRS values are not detectable. Moreover,
>> the current loongson_mrrs_quirk() cannot avoid devices increasing its
>> MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
>> will actually set a big value in its driver. So the only possible way
>> is configure MRRS of all devices in BIOS, and add a pci host bridge b=
it
>> flag (i.e., no_inc_mrrs) to stop the increasing MRRS operations.
>>=20
>> However, according to PCIe Spec, it is legal for an OS to program any
>> value for MRRS, and it is also legal for an endpoint to generate a Re=
ad
>> Request with any size up to its MRRS. As the hardware engineers say, =
the
>> root cause here is LS7A doesn't break up large read requests. In deta=
il,
>> LS7A PCIe port reports CA (Completer Abort) if it receives a Memory R=
ead
>> request with a size that's "too big" ("too big" means larger than the
>> PCIe ports can handle, which means 256 for some ports and 4096 for the
>> others, and of course this is a problem in the LS7A's hardware design=
).
>
> This seems essentially similar to ks_pcie_quirk() [1].  Why are they
> different, and why do you need no_inc_mrrs, when keystone doesn't?
>
> Or *does* keystone need it and we just haven't figured that out yet?
> Are all callers of pcie_set_readrq() vulnerable to issues there?

Yes actually keystone may need to set this flag as well.

I think Huacai missed a point in his commit message about why he removed
the process of walking through the bus and set proper MRRS. That=E2=80=99s
because Loongson=E2=80=99s firmware will set proper MRRS and the only th=
ing
that Kernel needs to do is leave it as is. no_inc_mrrs is introduced for
this purpose.

In keystone=E2=80=99s case it=E2=80=99s likely that their firmware won=E2=
=80=99t do such thing, so
their workaround shouldn=E2=80=99t be removed.
And  no_inc_mrrs should be set for them to prevent device drivers modify=
ing
MRRS afterwards.

Thanks
- Jiaxun

>
> Whatever we do should be as uniform as possible across host
> controllers.
>
> [1]=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/drivers/pci/controller/dwc/pci-keystone.c?id=3Dv5.18#n528
>
--=20
- Jiaxun

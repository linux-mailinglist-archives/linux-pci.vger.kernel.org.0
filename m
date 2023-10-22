Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE827D233A
	for <lists+linux-pci@lfdr.de>; Sun, 22 Oct 2023 15:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjJVNjA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Oct 2023 09:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVNi7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Oct 2023 09:38:59 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BED9DF;
        Sun, 22 Oct 2023 06:38:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id EFAC0320029B;
        Sun, 22 Oct 2023 09:38:56 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Sun, 22 Oct 2023 09:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1697981936; x=1698068336; bh=wH3Vt951/DMMbekXvIko30IMJg8aJNBVPTI
        gR0Q6vgM=; b=e1F56EfPAF9aj0uN+eX9z1JJtGmyz6F+SDmDjE+Z9SRnLFHrPNW
        x+strqlDwZoNOTPr47jhndbnGwBrPnYzieP965AznZWHB6lovZwV1vMjh3lWglzm
        E/sPwUMF+B+QHu71/DwhuIwv53DCs5b2o1lL/pjt4my7cfpH0SVAua+TKZJlhcoA
        idZZ4tDt6C+BAJbZt6unzCD5/DUPqI4aM+BXIVg5aa9Hj267hRV2CBxZElH9MNQa
        5KostnayvikAG671aK1LRcwa8le6rCn5BS5kC3VdAHJmnCJObnGKujrQ/1+P+SQT
        vlldwOUrSaZ+BL/vyYqoPKaNPKSSUogDN0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1697981936; x=1698068336; bh=wH3Vt951/DMMbekXvIko30IMJg8aJNBVPTI
        gR0Q6vgM=; b=BOlC0cN5VJljng7KXQB4UYUq83/vkjxiXLaQHNKT9gAOIfU9lxy
        TeN59hnUEUDu1q6ULPEOFNx23Kh5L/6GKUEjwXTO4LvKqKE3EEoKcXPsktwemNfD
        0eAaQet3EiMwFRaGERxCkYERL+sJqrpdQLBHuWqTxEpzglhi3w8BWHXDOEAJtVzP
        asJV0DM9k+vQjza/pUjOBPjXAGYl9bYro9qLvDS/ZXrTfX3o2MrEYb+d5QyESSeb
        Ef2+yq1k+D5uo6xMJtryJtRklfqh2rq1RbvFKV5RTaslFJJ75HanbLLp0+k8htwG
        6/ePsyzRlRpr7fB9pTg1ELtCkQ+FrqmAgFA==
X-ME-Sender: <xms:8CU1ZTP-V0X3yNIBwYuMV6gSSRVYMODrVOLlqFKKd9wXNIjBvw3Izg>
    <xme:8CU1Zd8p023PAYW0e3s7KD0DKKCSQQl4CQV6tmYVvVUVpuD9sXw8tUd5ZeaN0pCtf
    p4S6M2KI_sS_RJqOfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeefgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
    geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:8CU1ZSSGe20bDi3pcriFX-gssx75PxxCIMSjtOscTL_mzP4XvDRpiQ>
    <xmx:8CU1ZXvhL75wv-KqimA1g3dg3jVCsW76kSosRZfnIAAjiEpJlJM79A>
    <xmx:8CU1ZbdHn8LCN5vSTwoDWyXFelJUdd53X_0BHl4JNlmqpKJ-wsxDOw>
    <xmx:8CU1ZcGJ3YLDf_nYu4ecdN49vub0HXy9_O5qCv_TMm1u9-VcUKkLtQ>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 34AC236A0077; Sun, 22 Oct 2023 09:38:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <30afffac-b470-43ce-95cd-7bc72bf1752f@app.fastmail.com>
In-Reply-To: <20230907050805.GA3218@thinkpad>
References: <20230725061008.1504292-1-jiaxun.yang@flygoat.com>
 <e9c103dc-98ac-9a51-7291-f5da1467b2ff@flygoat.com>
 <CAAhV-H7_OjTaU_wn6mUW0-JSrXS+=A2rXCiBc8cyce5ob49BLg@mail.gmail.com>
 <861a809d-3df1-327e-e033-87506f6d89e5@flygoat.com>
 <20230907011828.GA2865@thinkpad>
 <6e1bdebf-f335-23a5-c79f-d603c5d0150c@flygoat.com>
 <20230907050805.GA3218@thinkpad>
Date:   Sun, 22 Oct 2023 14:38:30 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>
Cc:     "Huacai Chen" <chenhuacai@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] pci: loongson: Workaround MIPS firmware MRRS settings
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



=E5=9C=A82023=E5=B9=B49=E6=9C=887=E6=97=A5=E4=B9=9D=E6=9C=88 =E4=B8=8A=E5=
=8D=886:08=EF=BC=8CManivannan Sadhasivam=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Sep 07, 2023 at 11:13:00AM +0800, Jiaxun Yang wrote:
>>=20
>>=20
>> =E5=9C=A8 2023/9/7 9:18, Manivannan Sadhasivam =E5=86=99=E9=81=93:
>> [...]
>> > Why do you need to walk through every single device instead of just=
 bridges?
>> > I'm not the maintainer, but my suggestion is to go for Huacai Chen'=
s solution.
>> Hi Mani,
>>=20
>> Thanks for your reply, unfortunately Huacai's solution is impractical=
 in
>> this case.
>>=20
>> The problem we have, is firmware (or BIOS) setting improper MRRS for =
devices
>> attached under those bridges. So we have to fix up MRRS for every sin=
gle
>> device.
>> We can't iterate child device in bridge quirk because there is no gua=
rantee
>> that
>> bridge will be probed before=C2=A0 it's child device, partly due to h=
otplug.
>>=20
>
> Okay, this clarifies and also warrants improvement in commit message.
>
> You could also use pci_walk_bus() after pci_host_probe() to iterate ov=
er the
> child devices under root bridge and set MRRS. IMO that would look neat.

This won't work as disabling device will reset MRRS and you have to set
it again, while pci_host_probe will only run at init.

So quirk at device enablement is still the best solution.

Thanks
- Jiaxun

>
> - Mani
>
>> This quirk has been in tree for a while, until Huacai refactored it a=
nd
>> broke some
>> systems in 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases"=
).
>>=20
>> Also to note that ks_pcie_quirk in drivers/pci/controller/dwc/pci-key=
stone.c
>> uses similar approach.
>> > This avoids iterating over bridges/devices two times.
>> >=20
>> > Also, please rename firmware to BIOS, as firmware commonly represen=
ts the
>> > software running on PCIe endpoint devices.
>> Ack, will fix in next reversion.
>>=20
>> Thanks
>> - Jiaxun
>> >=20
>> > - Mani
>> [...]
>
> --=20
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--=20
- Jiaxun

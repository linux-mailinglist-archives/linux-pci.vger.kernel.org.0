Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D3D7D2337
	for <lists+linux-pci@lfdr.de>; Sun, 22 Oct 2023 15:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjJVNgj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Oct 2023 09:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVNgi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Oct 2023 09:36:38 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFD4DC;
        Sun, 22 Oct 2023 06:36:36 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id BF08C320046F;
        Sun, 22 Oct 2023 09:36:33 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Sun, 22 Oct 2023 09:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1697981793; x=1698068193; bh=3+zHI5XxJ0GdEW2zOOWUQBzlNnmU90B1H+l
        bgNRgITc=; b=mdb3o1qiwZJ7GziAMlEdciFjbuylXPyQzJ281BNLoD/GOCCb8oA
        sMvcaI7+VmGgsqxp4HC1e11OvGBFvr49S234RVIfFcFhWlM/FUA2BVzrCgRKqGOm
        51xN5BM4jO/0G/qU77ca3pSGs8P5QNfmfLUbr036rDmLx7EYzrMSZ4QhuQCyEL04
        +o9040SJQAavBbcmzb3OIZlY7qrLvMFdasKZMvKDvceMBM3HdtLVea25/Ttl0PKS
        VBgVM+ZvDJhsSihHxg5qq+mebdwn3N1mVFVgs8wjnGJrzgCAxMRnS6DXehTj/u46
        c+riAcCoHRHlqpuX2RLHWfAAUn9YkvovHFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1697981793; x=1698068193; bh=3+zHI5XxJ0GdEW2zOOWUQBzlNnmU90B1H+l
        bgNRgITc=; b=NPOGMiwB0Xz18tHXSfDKOzkvPdCOzD5F2v1MpDWpZ2SKr+/paOz
        NkegnWTgcdFqlTevmFoFroBVjh7v2XAImNk8Gst9vpS8HbfoJQ8HA63wutgLrJ+D
        nqppOUEOWIO0YGtwqv0QegXTdYO1fVN8RHSyFvgekJOa3V2TADNInH/VMxW804Go
        a3OPyzSW7Y5NcxQnohNyOUw+UT6x6jagH0EFKJhB1zbZ6BOwhSNu7BZAMUIKZ1hW
        hurATdBsyHKrBZDp9D9MHhkoBbpKGDarPGeAePv6ZRcZABnetjiNgfTKa7huxdzd
        a3Q5FwbLWmooJzehGhf+8bQWclJ+O6YzOCA==
X-ME-Sender: <xms:YSU1Zdko4eyVyDV1GyUNkEmDsi5tOA5PNTr3eymu5JXeKQxKOgvkiQ>
    <xme:YSU1ZY12k0TtNJl7LZyPnedeBLbSXkvFt1X3S-pLRBuKfes-TQVPqor-9CXWiWOwV
    kL4F15oLzrUFRGkKlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeefgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepteduledttdelgeejfeejffeihfelhffgteetudfgkedt
    tdfhkeehtdekjeefgeelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdplhgvvghmhh
    huihhsrdhinhhfohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:YSU1ZTqAqDZhnbnmHdCoArEOY-IgQOeNKZb77Tcw9btK6WS4ZA5vsg>
    <xmx:YSU1ZdkgTm8H5JIungjwQiwFX1hphYAPnr9mQN0NM0RGOvRTXIo2Ag>
    <xmx:YSU1Zb22FkhT2LU8UZqN2ZqCV94BjbwR90D3wxhC0EmxOsFus_Tm4A>
    <xmx:YSU1ZVp2PnUiOHlxYUUsAsi4i33ekrz6E9QRLrPtgj4W4EGyM53rVA>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D9A5136A0077; Sun, 22 Oct 2023 09:36:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <52ec45eb-6633-4d51-96ff-d29d1743e1aa@app.fastmail.com>
In-Reply-To: <c9a99e29-1a16-4b46-8e3a-afd0aae5b76e@leemhuis.info>
References: <20230725061008.1504292-1-jiaxun.yang@flygoat.com>
 <e9c103dc-98ac-9a51-7291-f5da1467b2ff@flygoat.com>
 <CAAhV-H7_OjTaU_wn6mUW0-JSrXS+=A2rXCiBc8cyce5ob49BLg@mail.gmail.com>
 <861a809d-3df1-327e-e033-87506f6d89e5@flygoat.com>
 <20230907011828.GA2865@thinkpad>
 <6e1bdebf-f335-23a5-c79f-d603c5d0150c@flygoat.com>
 <20230907050805.GA3218@thinkpad>
 <91336c97-0831-3ce3-5ff0-54344f18e065@leemhuis.info>
 <c9a99e29-1a16-4b46-8e3a-afd0aae5b76e@leemhuis.info>
Date:   Sun, 22 Oct 2023 14:36:13 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Linux regressions mailing list" <regressions@lists.linux.dev>,
        "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>
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



=E5=9C=A82023=E5=B9=B410=E6=9C=8820=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=
=E5=8D=8812:04=EF=BC=8CThorsten Leemhuis=E5=86=99=E9=81=93=EF=BC=9A
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
>
> Just wondering what's up here. The patch this thread is about afaics w=
as
> supposed to fix a regression reported in July
> (https://bugzilla.kernel.org/show_bug.cgi?id=3D217680 ), but has made =
not
> steps closer to get mainlined during the past few weeks. Is there a
> reason, or did it maybe fell through the cracks?
>
> Jiaxun Yang, from it quick look it seems like you wanted to post a v3,
> but never did so; but I might be mistaken there.

I just figure out the problem of this implementation.
Will resend and explain.

Thanks
- Jiaxun

>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' ha=
t)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot poke
>
> On 20.09.23 14:33, Linux regression tracking (Thorsten Leemhuis) wrote:
>> [CCing the regression list, as it should be in the loop for regressio=
ns:
>> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>>=20
>> On 07.09.23 07:08, Manivannan Sadhasivam wrote:
>>> On Thu, Sep 07, 2023 at 11:13:00AM +0800, Jiaxun Yang wrote:
>>>> =E5=9C=A8 2023/9/7 9:18, Manivannan Sadhasivam =E5=86=99=E9=81=93:
>>>> [...]
>>>>> Why do you need to walk through every single device instead of jus=
t bridges?
>>>>> I'm not the maintainer, but my suggestion is to go for Huacai Chen=
's solution.
>>>>
>>>> Thanks for your reply, unfortunately Huacai's solution is impractic=
al in
>>>> this case.
>>>>
>>>> The problem we have, is firmware (or BIOS) setting improper MRRS fo=
r devices
>>>> attached under those bridges. So we have to fix up MRRS for every s=
ingle
>>>> device.
>>>> We can't iterate child device in bridge quirk because there is no g=
uarantee
>>>> that
>>>> bridge will be probed before=C2=A0 it's child device, partly due to=
 hotplug.
>>>
>>> Okay, this clarifies and also warrants improvement in commit message.
>>>
>>> You could also use pci_walk_bus() after pci_host_probe() to iterate =
over the
>>> child devices under root bridge and set MRRS. IMO that would look ne=
at.
>>=20
>> Hi, Thorsten here, the Linux kernel's regression tracker. What's the
>> status here? The regression that was supposed to be fixed by the patc=
hed
>> that started this thread was reported 9 weeks ago[1] and the culprit
>> made it to many stable kernels as well. Would be really good to final=
ly
>> fix this, as a regression like this should ideally be fixed within 2 =
to
>> 3 weeks (in both mainline and stable). With a revert if necessary -- =
is
>> this maybe still a option, or would that cause more trouble then it
>> solved (I guess that's the case).
>>=20
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217680
>>=20
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' h=
at)
>> --
>> Everything you wanna know about Linux kernel regression tracking:
>> https://linux-regtracking.leemhuis.info/about/#tldr
>> If I did something stupid, please tell me, as explained on that page.
>>=20
>>>> This quirk has been in tree for a while, until Huacai refactored it=
 and
>>>> broke some
>>>> systems in 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increase=
s").
>>>>
>>>> Also to note that ks_pcie_quirk in drivers/pci/controller/dwc/pci-k=
eystone.c
>>>> uses similar approach.
>>>>> This avoids iterating over bridges/devices two times.
>>>>>
>>>>> Also, please rename firmware to BIOS, as firmware commonly represe=
nts the
>>>>> software running on PCIe endpoint devices.
>>>> Ack, will fix in next reversion.
>>>>
>>>> Thanks
>>>> - Jiaxun
>>>>>
>>>>> - Mani
>>>> [...]
>>>

--=20
- Jiaxun

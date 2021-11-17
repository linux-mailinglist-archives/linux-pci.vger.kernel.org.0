Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF5E454AE6
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 17:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238538AbhKQQ11 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 11:27:27 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52827 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238476AbhKQQ10 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 11:27:26 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A828A5C02A7;
        Wed, 17 Nov 2021 11:24:27 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute5.internal (MEProxy); Wed, 17 Nov 2021 11:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=BxgWljCO9iWSFwR2i7hIe4GXp2Gld1dyRvcvcgoOH
        MU=; b=Bnpx2e9VSEw49a2vBXxiGlXpnnsiDhWiEqJ0MEHtr6QKZ0nDq/hn2xURy
        EMakTIV9SoTjN9a5Q8pC6DkilhmVlajjyvnKtDL8BzmSe/QKzojmIWrMjmgqG0NL
        km93hJQ/C8hbmpBo3M+nbVz9aifDLRAQCQKsd8OyV1JJE/InFFg87YaWS0GL0Uqp
        5Vq1LLDMf4ckXPEtJwQ0lqlUmFj4dZA9de9L6RhZUjz7aQHdrmiFdf3mwMNMd+Oi
        g9Qv5XaT+CjEf0xHtV+CYwRchDhsQecMd1XIf63D0UvrObckz0aRa39fjw9r8ZYg
        O26uIzXvV/MrTmQdf4RfFX5GTWglQ==
X-ME-Sender: <xms:uyyVYSOI0ujxNzNGB8C_mxxXLWvmS47hEt5tDu3zTEuw8Vm_A-vWZQ>
    <xme:uyyVYQ-FLWrZ5VYx6UrCRCgUgI05CAmk1nueguVI93YgJgK6aBUwoLHP_59fDy79V
    fCJwx-UrpWoAzIVuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeggdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdflvghr
    vghmhicuufholhhlvghrfdcuoehjvghrvghmhiesshihshhtvghmjeeirdgtohhmqeenuc
    ggtffrrghtthgvrhhnpefggeejleffkedtieehgefhteetgeejhffhfefgueejffdtheev
    leefhfegkeehgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgvrhgvmhihsehshihsthgv
    mhejiedrtghomh
X-ME-Proxy: <xmx:uyyVYZR5Ib601l9ZgD2HnJSP19p4Js4bUFZa5ocKka9S9bhS1UXTLg>
    <xmx:uyyVYSsoz7jdzxjx9DUIn-Y6BJgD5swYFZB53ei7HP31gC9d6t0xsQ>
    <xmx:uyyVYaeAMlyohsJH_6-QAlCAKH-Q2IiFQSWRVmjfI7a4EORaZ3jjvg>
    <xmx:uyyVYSQ8zj0RXvbErYKKTiKS9ukQocGC5dwrvUNcEkZuGdOwUdSNFg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1637BFA0AA6; Wed, 17 Nov 2021 11:24:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <a13f0106-a2b2-430d-8143-86eb03e7a667@www.fastmail.com>
In-Reply-To: <YZREq6jQOhyKIHk0@rocinante>
References: <87h7ccw9qc.fsf@yujinakao.com>
 <8951152e-12d7-0ebe-6f61-7d3de7ef28cb@opensource.wdc.com>
 <YZQ+GhRR+CPbQ5dX@rocinante>
 <26826c5d-2fa6-9719-be2a-5a22d1e9abc0@opensource.wdc.com>
 <YZREq6jQOhyKIHk0@rocinante>
Date:   Wed, 17 Nov 2021 09:24:06 -0700
From:   "Jeremy Soller" <jeremy@system76.com>
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     "Yuji Nakao" <contact@yujinakao.com>, linux-kernel@vger.kernel.org,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        ". Bjorn Helgaas" <bhelgaas@google.com>,
        "Marc Zyngier" <maz@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
        "Sasha Levin" <sashal@kernel.org>
Subject: Re: Kernel 5.15 doesn't detect SATA drive on boot
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We are using 5.15.2 right now on Pop!_OS 21.10 but have not seen SATA is=
sues yet. I'll look into this,
and hope it makes it into a 5.15 release soon!

--=20
  Jeremy Soller
  System76
  Principal Engineer
  jeremy@system76.com

On Tue, Nov 16, 2021, at 4:54 PM, Krzysztof Wilczy=C5=84ski wrote:
> [+CC Adding Jeremy for visibility]
>
> Hi Damien,
>
> [...]
>> > The error in the dmesg output (see [2] where the log file is attach=
ed)
>> > looks similar to the problem reported a week or so ago, as per:
>> >=20
>> >   https://lore.kernel.org/linux-pci/ee3884db-da17-39e3-4010-bcc8f87=
8e2f6@xenosoft.de/
>>=20
>> Thanks. I searched this thread but could not find it in the archive.
>> Early morning, need more coffee :)
>
> No worries!  Got you covered!
>
>      )))
>     (((
>   +-----+
>   |     |]
>   `-----'
>
> Enjoy!
>
>>=20
>> >=20
>> > The problematic commits where reverted by Bjorn and the Pull Reques=
t that
>> > did it was accepted, as per:
>> >=20
>> >   https://lore.kernel.org/linux-pci/20211111195040.GA1345641@bhelga=
as/
>> >=20
>> > Thus, this would made its way into 5.16-rc1, I suppose.  We might h=
ave to
>> > back-port this to the stable and long-term kernels.
>>=20
>> Yes, I think the fix needs to go in 5.15, which is latest stable and =
LTS.
>
> On the plus side, not everyone is on 5.15 yet, but those who are using=
 it would
> have some issues.  Albeit, with it being an LTS release, the adoption =
might
> increase rapidly.
>
> For instance, I believe that Pop!_OS already ships kernels that are ve=
ry close
> to the upstream, which would hit their current user base.
>
> 	Krzysztof

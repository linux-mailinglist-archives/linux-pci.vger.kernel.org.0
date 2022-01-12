Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587F948C446
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 13:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbiALM6I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 07:58:08 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:42809 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240649AbiALM6H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 07:58:07 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 04DC45804F4;
        Wed, 12 Jan 2022 07:58:07 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Wed, 12 Jan 2022 07:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm1; bh=+0OhM
        YrRQ9jLMWXZW2QfIppEObFYwHFLD0nH1qOBcOg=; b=tJSSVXQqInVYxygG3AuiK
        RVrRdS/RSsOcfUg/lAYvld/rzNyFpuYTbpG1/NlhnLxxf0+18PAuI7WULIdW+2V9
        6ET8iQIcdtWRHyoWLI4n5W5X5JlUDY9Gt5DGniyFftiiOlwZYZ9sC3Qw4mXAjgW7
        kTf5Rq8hZnX+1Vbz7qYTXy+irbwPojreCbthG/RZyn9o3+SaPIMJ7/eiHkUMSefj
        f/g4gYb4LSKkdUtB788MxfezKteguiTGTBFOWEbB/H7HG4wzl9G66sou93Xl5rZC
        1yME/kTeHJJ6QX0/llug5XFTBmUmmr0HUuZ89+/163evgEusIZgzX2+hSWHI1XrQ
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=+0OhMYrRQ9jLMWXZW2QfIppEObFYwHFLD0nH1qOBc
        Og=; b=W8AnzRS4W6cAnLeRkQURPoHp1hmAbZljojEtySbLWzv/QP+cVc9p1VrLB
        Ptb95z9oiolFGcagJP5Yydd9p1+pRJreeCFd1gETYIT+Glv8Leo45uX3wPTOGqrk
        JBfrDxiPnCbIF2FlP/RXyRZ4ia0YOqoupO+K47MC0Zn1mFcMxRpIFoK3Hl+o+YI+
        HBvmt+WlD2IFVVr1ZLs/PXOx7wR8AdoGtVV/QAEBclVYizLWwrJJ9zSnD9Ougonr
        dldGRnlifk3TEw0fOj7x5zN02jb84yt+pwy+1KD8x1FBLGEP6XRDiY638hTZXvaf
        AcXazUmzYxtt/W6QvctJ6OBVYje/A==
X-ME-Sender: <xms:XtDeYQANFXZjh4Iy74aHVwqMjQQOJbOyjDTJ3XYNR0KuK6JtA8iKgA>
    <xme:XtDeYSilmnRc943u5TLFdIlIDieo4DkOxewqUL9ZRN-a7K44v26BOybYjV_HQvcCF
    5Mx2a0DdV1Die0oSXo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtddugddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdflihgr
    gihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeefteegkeevfeethffgudehgedvueduvdeifedvvdelhfef
    heekteefueektdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:XtDeYTmaen5eNJxFkbrcbkEMhLaUbiiV55tnth5EFuGa-ahzsAQ3Bg>
    <xmx:XtDeYWxMMuCdaXgY_UpZLsMYJR6eKcRqTELl9W-bEht3xQe1V9X4LA>
    <xmx:XtDeYVRW5_2Hv1oFQortdWrgBIksbx6ORsFEH7TRrkEOfW4CC4OgvQ>
    <xmx:X9DeYVaaFYeVy3ZPWBLP-3jhTpWsedUu7hd3HfP59VNWLW-2rJ6Zow>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5A413FA0AA7; Wed, 12 Jan 2022 07:58:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4569-g891f756243-fm-20220111.001-g891f7562
Mime-Version: 1.0
Message-Id: <013cc25a-d460-49eb-8cc0-8f59a0c5a45e@www.fastmail.com>
In-Reply-To: <20220111214608.GA169999@bhelgaas>
References: <20220111214608.GA169999@bhelgaas>
Date:   Wed, 12 Jan 2022 12:57:44 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>,
        "Rob Herring" <robh@kernel.org>
Cc:     "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Tiezhu Yang" <yangtiezhu@loongson.cn>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Ray Jui" <rjui@broadcom.com>,
        "Scott Branden" <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 19/19] PCI: Set bridge map_irq and swizzle_irq to default functions
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



=E5=9C=A82022=E5=B9=B41=E6=9C=8811=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=E5=
=8D=889:46=EF=BC=8CBjorn Helgaas=E5=86=99=E9=81=93=EF=BC=9A
> [-cc many, +cc iproc, loongson, tegra maintainers]
>
> On Tue, Jul 21, 2020 at 08:25:14PM -0600, Rob Herring wrote:
>> The majority of DT based host drivers use the default .map_irq() and
>> .swizzle_irq() functions, so let's initialize the function pointers to
>> the default and drop setting them in the host drivers.
>>=20
>> Drivers like iProc which don't support legacy interrupts need to set
>> .map_irq() back to NULL.
>
> Probably a dumb question...
>
> This patch removed all the ->swizzle_irq users in drivers/pci/, which
> is great -- IIUC swizzling is specified by the PCI-to-PCI Bridge Spec,
> r1.2, sec 9.1, and should not be device-specific.  I assume the few
> remaining arch/ users (arm and alpha) are either bugs or workarounds
> for broken devices.
>
> My question is why we still have a few users of ->map_irq: loongson,
> tegra, iproc.  Shouldn't this mapping be described somehow via DT?
>

Hi all,

For Loongson we are describing IRQ map in DT for newer platforms.
But for legacy platforms (AMD RS780E North Bridge) with i8259 irqchip,
we need to read PCI IRQ registers to get mapping information.

It is not known until boot time, so we have to use map_irq callback.

Thanks.
- Jiaxun

[...]

--=20
- Jiaxun

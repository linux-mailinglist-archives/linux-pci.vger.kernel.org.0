Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADE03B5CCC
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 12:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhF1K76 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 06:59:58 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:58957 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232614AbhF1K75 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 06:59:57 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3A27232007E8;
        Mon, 28 Jun 2021 06:57:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 28 Jun 2021 06:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=i
        44yOBTBX/vyWAA4JUgHFd2BT6mpSEt5PeqeW4yz96g=; b=IQ861eI3L83F1yKth
        pAZiT36GOT/iynCEDQzKex1OZJOubb/wbiFLSdqNRJ8mceF4sEsnFnQQYHuHqnVw
        LXX4FpEOTcMFVtPRLgC2UnEkb7o59TVfN5/yEOR4pOR4P2h8ic11y3MA8d+t1sjG
        vYZe0qyTPs2KaoNuxvW20/mxIM8igUvx2IYg9MhdhIrGcOBpgrqdCDrQpgYUFPOD
        0O4zJ+QirHl6LiFvK/3rCyAWLgbh91vkSdcwm3DZechw2jaiia0VqqDYm8f6WRya
        6YAJiLjaLkyjLSsrAd1D/3BMOAlyb1CXnakFlJ+I1KfyrCAL8FU26OU5frLro7NK
        EIRQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=i44yOBTBX/vyWAA4JUgHFd2BT6mpSEt5PeqeW4yz9
        6g=; b=IWoky98+qd9CkPqFQpd/Bo3tuuFKMUF4X1li8Rd1G3LhoX/mmOb498ooO
        V+m9Y94ji68LrAwqBRnW13IQl5XcMO6hJVma3Zr0KdKEmx8Py2xmRSb6uIM5xOQH
        Qe3t5pqy3LWmuZqGVBU+Vo+6lBDb4ji4Mux39W0E+svwl5uTdivul1h5jnVk8xEa
        OAFaW665BgroSGYc2g7BDtDFFwT+AGLjag3aX9HziQLsR63HaR7wtUWNEqGzBbBf
        5ZNuQ/vUi6JJ0bzxMmj9z5q8x1yJFbEjxE+kV1j/t3Ix+P38xmn1fYGU5gZ4FC1q
        QnJNuz/4dTmrB1eJi0dbI1olQyv3Q==
X-ME-Sender: <xms:GqvZYF1acv6rr249HiziGj0cHLLvH46Y8CodKSSwJEX_IuAgZxX_Zw>
    <xme:GqvZYMEjkk_OxwlNR6ZlbXDfRRdv_0XebkQD4c893mvcTurPMSr1f2B-OR8DMAlgs
    iP2I7eW7SetoruxLTM>
X-ME-Received: <xmr:GqvZYF73pHgGnmT3RgV1GKZ_MvFGyoVI2K2nlfxSWRHlGFPvjzdTENDMNh5m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehgedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeekieeghfffhfeuuddtvdegleeltdejgeevfeekteetheefhffg
    vefhueetkeefieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:GqvZYC0zB2hfRhILuYAwvAa5nR-L4gK-o--eGYOsYp1KoYzKDBLg7A>
    <xmx:GqvZYIH8yjJF4SSXwv-WX5uxHRkhj-4F-6uEMxyW13NiFJvkEhhtwQ>
    <xmx:GqvZYD8FHCX7VchiCTLMPiqJ5svM_wY7thpfEQ4U0M-_qmxv_kOXWw>
    <xmx:G6vZYMAzovi6RTj1yIbpn2H51QdN_EhhwHUmUdf6633252Of2x5eKA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 06:57:28 -0400 (EDT)
Subject: Re: [PATCH V4 2/4] PCI: Move loongson pci quirks to quirks.c
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
References: <20210628101027.1372370-1-chenhuacai@loongson.cn>
 <20210628101027.1372370-3-chenhuacai@loongson.cn>
 <bcde3fa6-9292-3f59-cb39-30ed0f311291@flygoat.com>
 <CAAhV-H4rK5uGtDDJDg02i-gNpMSzYLGO5pLUsAYfjUWYtJPi3w@mail.gmail.com>
 <1b42d46f-8332-204e-62d6-d0903d5a0af7@flygoat.com>
 <CAAhV-H524hSStZRzO2Nsthi86mHu2e4dernPM8_bX+zEN5qiKQ@mail.gmail.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <896f834f-887b-4216-cdcc-cd5eaba6717c@flygoat.com>
Date:   Mon, 28 Jun 2021 18:57:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H524hSStZRzO2Nsthi86mHu2e4dernPM8_bX+zEN5qiKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2021/6/28 下午6:55, Huacai Chen 写道:
> Hi, Jiaxun,
>
> On Mon, Jun 28, 2021 at 6:41 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>>
>>
>> 在 2021/6/28 下午6:38, Huacai Chen 写道:
>>> Hi, Jiaxun,
>>>
>>> On Mon, Jun 28, 2021 at 6:13 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>>>>
>>>> 在 2021/6/28 下午6:10, Huacai Chen 写道:
>>>>> Loongson PCH (LS7A chipset) will be used by both MIPS-based and
>>>>> LoongArch-based Loongson processors. MIPS-based Loongson uses FDT
>>>>> but LoongArch-base Loongson uses ACPI, but the driver in drivers/
>>>>> pci/controller/pci-loongson.c is FDT-only. So move the quirks to
>>>>> quirks.c where can be shared by all architectures.
>>>>>
>>>>> LoongArch is a new RISC ISA, mainline support will come soon, and
>>>>> documentations are here (in translation):
>>>>>
>>>>> https://github.com/loongson/LoongArch-Documentation
>>>> Probably you should guard it with CONFIG_MACH_LOONGSON64 now and add
>>>> CONFIG_LOONGARCH
>>>> once LOONGARCH code is mainlined.
>>> These quirks won't match non-Loongson platforms (because they are
>>> matched by pci ids), so I think that is unnecessary.
>> Are you sure?
>> As I saw
>> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID
>> It will slow down boot progress on all systems.
> This ANY ID matching is only used by loongson_mrrs_quirk(), but the
> next patch will rework loongson_mrrs_quirk().

Oh I see. That seems better.

Thanks.

- Jiaxun

>
> Huacai
>

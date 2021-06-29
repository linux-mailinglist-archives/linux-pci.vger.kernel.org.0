Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441A03B6D13
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 05:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhF2Dke (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 23:40:34 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:50257 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231987AbhF2Dkd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 23:40:33 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6B517320090C;
        Mon, 28 Jun 2021 23:38:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 28 Jun 2021 23:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=d
        qpn/fmvVWCMAYk8AIQPEFy8tN/mnM6VCFO8jIZ3UnI=; b=ird2bN7JQCC27X0N8
        jCcdcVJB9SelDmuF24APcPNuQR/vX794Ozmpilfipu76TaIiWYEYR8At9gUiDmi1
        B4Kj3HRTX2aGtn77NNtisOQhjm5kD/FoygrcouOyGKG7TynTuJDonyZTR0ozpvbf
        ElkiM9xW4FFqrTY2TPJ9BMZ3GqYuiUg3SpzTQrsP+PpD4Bpo05Ch3AXPigSa/4mc
        3FaL3LbP7pJms/B/6nZOIqRL2+p4usEqWtxHe9nGR5V9EBDSHTkbgIA1ozDgBLiY
        Ju6r7LWW2ZtxHRuPijqFaiUECSGv80uBolDyPtY6JlZShUJmUek6nPjWEieHU84o
        HXnlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=dqpn/fmvVWCMAYk8AIQPEFy8tN/mnM6VCFO8jIZ3U
        nI=; b=XcSjYYNFREHpkeJ4iBiOpOfynv5zGzf4pkV7F7zirUMOc9zDBOK3wO8/+
        u6jErEzbf6TdpnvQMgWXkvoLBu1YmgDMI48is4uH3vm+mnlTCZaCQT34WEkNwhda
        noV366PKLV+a4NUJk0rsHCiPpshcH5uS9TYEou7B+PJQU+GffbH4cTI4DXQBjbyb
        ZwOJb0Sn2vqlFxJysqNDAdwJI30DJVoF+QArs+8PVJvYMTKrIKv9G2xwaPAO4CD3
        nfgjAY2WHA+gD3FAXntUuOZiSPMcbcMBnAHdEUR7lvvXu4UOmBqyttIRGq9sbAzb
        QJtjgn9szKAK8NKQA5pqeJQvunwwA==
X-ME-Sender: <xms:nZXaYOJIihUQiZWmokmSOsw20F83g0d6M_N8Zm0DiOvyaldop-v46Q>
    <xme:nZXaYGIwqt30P3ED9L7w7jur2ya8QvGFuVSes_Uk4RSbt_0L4_7KD4jb5mE7dIDdw
    LHUMNMYA5iAGobpiNs>
X-ME-Received: <xmr:nZXaYOv9pta_qV8Ol8hO7_1D8KZ1Oy_T_ym0B7MXg2QFHXnOhOqGOmGm1q3y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehhedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeeihffghfeikedugeejvefgffevgeevgeehfffhudeiieffffev
    ffeugeevfefgfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:nZXaYDarwpD8b0wfUXUmbJ0kdaPW0rTTtsTlib3HKkvmzDtjgVutog>
    <xmx:nZXaYFYuwW7ULvej88-hFLGyhs3Mv-_aVGIeETfQH5wWjFxLf09HYg>
    <xmx:nZXaYPCaEISrTT90FiKtOrPaMbKSTEWVC0Ojhv3pyrmPd7tS6V64Lw>
    <xmx:nZXaYEX5r49MhpAkXaE6hRgjVDa0yfTQX9dgzROnPSB0zsDc5koIsw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 23:38:02 -0400 (EDT)
Subject: Re: [PATCH V3 3/4] PCI: Improve the MRRS quirk for LS7A
To:     Huacai Chen <chenhuacai@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
References: <CAAhV-H6rmQjfeOhoLDUu_rCBGLUrL_Vi4wRAgNzSjEdOjSjUmg@mail.gmail.com>
 <20210629021231.GA3982831@bjorn-Precision-5520>
 <CAAhV-H4FaV0PK-cy0dzzWxsHW2QM==HUoydz0oQAh042EHo_TQ@mail.gmail.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <4f15b7a5-14ec-7f06-75c6-b970a08f84fc@flygoat.com>
Date:   Tue, 29 Jun 2021 11:38:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4FaV0PK-cy0dzzWxsHW2QM==HUoydz0oQAh042EHo_TQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2021/6/29 上午11:32, Huacai Chen 写道:
> Hi, Bjorn,
>
> On Tue, Jun 29, 2021 at 10:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> On Tue, Jun 29, 2021 at 10:00:20AM +0800, Huacai Chen wrote:
>>> On Tue, Jun 29, 2021 at 4:51 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>> On Sun, Jun 27, 2021 at 06:25:04PM +0800, Huacai Chen wrote:
>>>>> On Sat, Jun 26, 2021 at 6:22 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>> On Fri, Jun 25, 2021 at 05:30:29PM +0800, Huacai Chen wrote:
>>>>>>> In new revision of LS7A, some PCIe ports support larger value than 256,
>>>>>>> but their maximum supported MRRS values are not detectable. Moreover,
>>>>>>> the current loongson_mrrs_quirk() cannot avoid devices increasing its
>>>>>>> MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
>>>>>>> will actually set a big value in its driver. So the only possible way is
>>>>>>> configure MRRS of all devices in BIOS, and add a PCI device flag (i.e.,
>>>>>>> PCI_DEV_FLAGS_NO_INCREASE_MRRS) to stop the increasing MRRS operations.
>>>>>>>
>>>>>>> However, according to PCIe Spec, it is legal for an OS to program any
>>>>>>> value for MRRS, and it is also legal for an endpoint to generate a Read
>>>>>>> Request with any size up to its MRRS. As the hardware engineers says,
>>>>>>> the root cause here is LS7A doesn't break up large read requests (Yes,
>>>>>>> that is a problem in the LS7A design).
>>>>>> "LS7A doesn't break up large read requests" claims to be a root cause,
>>>>>> but you haven't yet said what the actual *problem* is.
>>>>>>
>>>>>> Is the problem that an endpoint reports a malformed TLP because it
>>>>>> received a completion bigger than it can handle?  Is it that the LS7A
>>>>>> root port reports some kind of error if it receives a Memory Read
>>>>>> request with a size that's "too big"?  Maybe the LS7A doesn't know
>>>>>> what to do when it receives a Memory Read request with MRRS > MPS?
>>>>>> What exactly happens when the problem occurs?
>>>>> The hardware engineer said that the problem is: LS7A PCIe port reports
>>>>> CA (Completer Abort) if it receives a Memory Read
>>>>> request with a size that's "too big".
>>>> What is "too big"?
>>>>
>>> "Too big" means bigger than the port can handle, PCIe SPEC allows any
>>> MRRS value, but, but, LS7A surely violates the protocol here.
>> Right, I just wanted to know what the number is.  That is, what values
>> we can write to MRRS safely.
>>
>> But ISTR you saying that it's not actually fixed, and that's why you
>> wanted to rely on what firmware put there.
> Yes, it's not fixed (256 on some ports and 4096 on other ports), so we
> should heavily depend on firmware.
>
> Huacai
>> This is important to know for the question about hot-added devices
>> below, because a hot-added device should power up with MRRS=512 bytes,
>> and if that's too big for LS7A, then we have a problem and the quirk
>> needs to be more extensive.
>>
>>>> I'm trying to figure out how to make this work with hot-added devices.
>>>> Per spec (PCIe r5.0, sec 7.5.3.4), devices should power up with
>>>> MRRS=010b (512 bytes).
>>>> If Linux does not touch MRRS at all in hierarchices under LS7A, will a
>>>> hot-added device with MRRS=010b work?  Or does Linux need to actively
>>>> write MRRS to 000b (128 bytes) or 001b (256 bytes)?
> Emm, hot-plug is a problem, maybe we can only disable hot-plug in
> board design...
in ACPI?

Thanks.

- Jiaxun
>
> Huacai
>>>> Bjorn


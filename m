Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD080773B50
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 17:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjHHPss (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 11:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjHHPrZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 11:47:25 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58326422A;
        Tue,  8 Aug 2023 08:41:33 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D169132009E6;
        Tue,  8 Aug 2023 03:38:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 08 Aug 2023 03:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1691480307; x=1691566707; bh=Knybq0RB1LVNGAjxl9LcbJ93Kivqg2gX18/
        gaDHnUT4=; b=wKwgJyj+XdyQxhTGqdq1f6STJef87fhs6sTGy1m4KcjrYCeQr2i
        tKfaZbnPrlTlT7m3pLz9z0kgMfN7x1NPSMFK7nrltjAuGCNKZYjCmN7NJoNS6Tnl
        22PRM/jyOjkhXJs4qdHz9GHOMzGmSoBMzqvbX0X1mt/mgeEMD+7Ue96YDAkqox0e
        xYtpPvrEZXLeVkUoNOVe+RcNZBJOrnUVeYDlzJ7HLuu0im3l2T637ddBW/Pw8EBV
        j7pKv56W86TaZg/K6nVzytDomVNjlvBptY+zMttM2Rw2k0PNehDxHJMFsvYZ79PL
        aUfZcG1FcH0g73iuI96Qltq+hC6NzIGRSZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691480307; x=1691566707; bh=Knybq0RB1LVNGAjxl9LcbJ93Kivqg2gX18/
        gaDHnUT4=; b=q4NoRkO8hJPfXI9TmnCEcSVHA9e7/4PRO2jsKwuSQSSW+tnUA13
        2lZ92ehFtjH+BI7bZfMk8RMT++2RRks2PRD1489w1DYLUTc2lr0QC3ivj1jFLrM8
        8+lA/oNmaqtk6Q+Dpb8x0LmD2vojMOuUN6YhCTZdcPmmt5UsYi0o1vlihesykGML
        XP48J5s9iZfAkQoWBYNvShHDtUgLJ4I0TlpAgGMak6S5ncv3wDQSym4/LQXZt5J1
        vdkq0lvvkVJXEsl3S3SRo95DG4et760hvE+0Ktw7AMuVgP0epOkDzXVOGP+6bYxP
        N6IQkay+7poe4Cp5BYDE/+DzvskoOvlGvnA==
X-ME-Sender: <xms:8vDRZAMzVpimbWrVMf8_G8Pm73wSK-w5Ass3aqlnTHFwHlPIJiLmcg>
    <xme:8vDRZG-GQjd7Sr5XWXzutuW_63DBEI0yjtm0CHq0RtLpHPngkqLKOmfY-y6UhdVnG
    1K0VcM04S5pI1wegTk>
X-ME-Received: <xmr:8vDRZHRPz3OuYhiAoHJ_oPMmg5r5889qtqN1LEz-_qHW8-4qQxyK2gzXaO--g_JaBn_b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledugdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepffeltdeggfdufffhfeetleevueduuefghfelveeukeejleeu
    heevgfevieeiudfhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:8vDRZIt4eqxTNDVzypSHF0-y0myy1VcNCc-3jvDPnutLcGheea2S1g>
    <xmx:8vDRZIf52V521I36ksXU975qyQnMtEck1NDU7odZdcASaUwrH9J85w>
    <xmx:8vDRZM0kWdTEl_dLE-eFa7yqRoWXhVGh4eGjRUz0Y8SOfWR1sruhWQ>
    <xmx:8_DRZNFzYUUSYy_2OOmbAg9rIz5fARB6gI5GWr9PhNR2mxZyQe7j8Q>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 03:38:22 -0400 (EDT)
Message-ID: <861a809d-3df1-327e-e033-87506f6d89e5@flygoat.com>
Date:   Tue, 8 Aug 2023 15:38:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] pci: loongson: Workaround MIPS firmware MRRS settings
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, kw@linux.com, lpieralisi@kernel.org,
        stable@vger.kernel.org
References: <20230725061008.1504292-1-jiaxun.yang@flygoat.com>
 <e9c103dc-98ac-9a51-7291-f5da1467b2ff@flygoat.com>
 <CAAhV-H7_OjTaU_wn6mUW0-JSrXS+=A2rXCiBc8cyce5ob49BLg@mail.gmail.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <CAAhV-H7_OjTaU_wn6mUW0-JSrXS+=A2rXCiBc8cyce5ob49BLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/8/6 22:30, Huacai Chen 写道:
> Hi, Jiaxun,
>
> On Sun, Aug 6, 2023 at 10:20 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>>
>>
>> 在 2023/7/25 14:10, Jiaxun Yang 写道:
>>> This is a partial revert of commit 8b3517f88ff2 ("PCI:
>>> loongson: Prevent LS7A MRRS increases") for MIPS based Loongson.
>>>
>>> There are many MIPS based Loongson systems in wild that
>>> shipped with firmware which does not set maximum MRRS properly.
>>>
>>> Limiting MRRS to 256 for all as MIPS Loongson comes with higher
>>> MRRS support is considered rare.
>>>
>>> Cc: stable@vger.kernel.org
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217680
>>> Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> Ping?
>> I expect this patch to go through PCI fixes tree.
> Can we do it like this by modifying the existing loongson_mrrs_quirk()?

Hmm, I'm not sure this will work, since loongson_mrrs_quirk only run on 
bridges
but the old quirk should run on every single device.

Thanks
Jiaxun

>
> static void loongson_mrrs_quirk(struct pci_dev *pdev)
> {
>          /*
>           * Some Loongson PCIe ports have h/w limitations of maximum read
>           * request size. They can't handle anything larger than this. So
>           * force this limit on any devices attached under these ports.
>           */
>          struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
>
> #ifdef CONFIG_MIPS
>          set_pcie_ports_to_mrrs_256_to_emulate_the_firmware_behavior();
> #endif
>
>          bridge->no_inc_mrrs = 1;
> }
>
>> Thanks
>> - Jiaxun
>>
>>> ---
>>> v2: Rename quirk name to: loongson_old_mrrs_quirk
>>> ---
>>>    drivers/pci/controller/pci-loongson.c | 38 +++++++++++++++++++++++++++
>>>    1 file changed, 38 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
>>> index fe0f732f6e43..d0f68b102d10 100644
>>> --- a/drivers/pci/controller/pci-loongson.c
>>> +++ b/drivers/pci/controller/pci-loongson.c
>>> @@ -108,6 +108,44 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>>    DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>>                        DEV_LS7A_PCIE_PORT6, loongson_mrrs_quirk);
>>>
>>> +#ifdef CONFIG_MIPS
>>> +static void loongson_old_mrrs_quirk(struct pci_dev *pdev)
>>> +{
>>> +     struct pci_bus *bus = pdev->bus;
>>> +     struct pci_dev *bridge;
>>> +     static const struct pci_device_id bridge_devids[] = {
>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
>>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
>>> +             { 0, },
>>> +     };
>>> +
>>> +     /* look for the matching bridge */
>>> +     while (!pci_is_root_bus(bus)) {
>>> +             bridge = bus->self;
>>> +             bus = bus->parent;
>>> +             /*
>>> +              * There are still some wild MIPS Loongson firmware won't
>>> +              * set MRRS properly. Limiting MRRS to 256 as MIPS Loongson
>>> +              * comes with higher MRRS support is considered rare.
>>> +              */
>>> +             if (pci_match_id(bridge_devids, bridge)) {
>>> +                     if (pcie_get_readrq(pdev) > 256) {
>>> +                             pci_info(pdev, "limiting MRRS to 256\n");
>>> +                             pcie_set_readrq(pdev, 256);
>>> +                     }
>>> +                     break;
>>> +             }
>>> +     }
>>> +}
>>> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_old_mrrs_quirk);
>>> +#endif
>>> +
>>>    static void loongson_pci_pin_quirk(struct pci_dev *pdev)
>>>    {
>>>        pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);


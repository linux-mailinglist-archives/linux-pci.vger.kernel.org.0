Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A480A78E9E1
	for <lists+linux-pci@lfdr.de>; Thu, 31 Aug 2023 12:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244357AbjHaKEv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Aug 2023 06:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjHaKEv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Aug 2023 06:04:51 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A45CEE;
        Thu, 31 Aug 2023 03:04:48 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id CC4595C0094;
        Thu, 31 Aug 2023 06:04:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 31 Aug 2023 06:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1693476285; x=1693562685; bh=3Bxg+078KgJz5tyNgD/JmbFy76+3swKXt6B
        GQD9tQ3o=; b=xQaKSO/slhT3iA6z7K5DoGuYaIFmdHmzjpEo0OmEiUFCe4VqLi1
        xU6xeQdztTvQFeaH/AfVmqolCmgFZvEOTNITKudVAa956Q/5yA6eGWh41wiMOI8x
        gT5YyXsGBaGDCRgfSY2z5Y1LoiotjF5ZEroa5bW/lTJNwMKXey5sce2CQ+BGsk5c
        vulklhbn4WCP1/koVDm3jTQn9SeX2QG6kRNkfzCm0ixri46ljbKecFa4U3faxS7X
        I6MYBozS+vrqSgIgqruc58RES+kXRq0+heaBLB3gQ8bZ8m25KIzn5t6OlYvEMYVk
        wP8OwtVgbC4lfhTwDAzNdfwP9PJyui/efGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693476285; x=1693562685; bh=3Bxg+078KgJz5tyNgD/JmbFy76+3swKXt6B
        GQD9tQ3o=; b=iZqLyH1wWf1q38vMPMgm18pJKTKFDes4WE2z36cbp7XPNyN3mct
        GRyOX2+EibJYON8+OHzOfQ0apZwy2Uaf6mPPF+AQERGPw4grTA7Cizk8ElpHqipN
        F/Pb9CW11XMYHBRnMLIlctSYfR7JkiE1i4epHorM/+59Ff1uZR175D3+ufl+RGml
        r3ooSFRWDc93kxePIDZEWICdYBGsCZ3bJ11sesWxIDJULk0mwyKLufcCA5MTCPNv
        HzffujUf7yeB2lwlE1ZgsujxWUiUJf03Wm1Tb1wiVz8U2YpcJByPwwNouVdTq4wN
        G7kCrdApfeVAVUtbHtmZh9jz+uX3nlfuubQ==
X-ME-Sender: <xms:vWXwZC5R80CMhc2NqPXLLWQmCsYNIZAMB4INNYpn5kJ-UpevC4-Q4Q>
    <xme:vWXwZL4A50RvpyCJNS9k6Kcioso7gByj0B5sIALzPowYUAxlE83F7fUCDWWImWT-m
    h3SPYXIOWmMqu_J9I0>
X-ME-Received: <xmr:vWXwZBddjksLpDu2OdNMJIyjlB7hnFN8M70VruPerbW6mLhPvZkPoLmTVf4Ql4C7ogI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegtddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepudfhkeevvddtueekfeefgfetlefgueegueeltddtieejgeei
    heevgfehgfdvfeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:vWXwZPK4VxsqzirdmzYzIkS3ak87x8UypnEQwm_vi_LtHzhqKqtpQg>
    <xmx:vWXwZGLv3gtGxxurFIh3H3zHTuBlvjCpi1nsfEDSlxC0nxInnEgcEA>
    <xmx:vWXwZAyVPITB9rQZ-eY82o6uN71I1q-xhzMzrk_jW64_q8WyAybPKA>
    <xmx:vWXwZIh3luAq_2MkqKsF5ZB-PFtgOUw2yOa8J2EGDHr4SlEjo6E2qg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Aug 2023 06:04:43 -0400 (EDT)
Message-ID: <c2bdde51-4dcc-59ac-5f54-bcf43152fc92@flygoat.com>
Date:   Thu, 31 Aug 2023 18:04:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] pci: loongson: Workaround MIPS firmware MRRS settings
Content-Language: en-GB
To:     Huacai Chen <chenhuacai@kernel.org>, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, lpieralisi@kernel.org, stable@vger.kernel.org
References: <20230725061008.1504292-1-jiaxun.yang@flygoat.com>
 <e9c103dc-98ac-9a51-7291-f5da1467b2ff@flygoat.com>
 <CAAhV-H7_OjTaU_wn6mUW0-JSrXS+=A2rXCiBc8cyce5ob49BLg@mail.gmail.com>
 <861a809d-3df1-327e-e033-87506f6d89e5@flygoat.com>
 <CAAhV-H67ehyqtm4ocOTWQPGBioWjQjLoyN5H9hALdq0oXdzWVg@mail.gmail.com>
 <62a7b292-ea1e-fb88-79cb-e7968d350a5e@flygoat.com>
 <CAAhV-H4DRFrsWOusyVPo5U_F-fwcfUUktGe31x9S3=E7vci=pQ@mail.gmail.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <CAAhV-H4DRFrsWOusyVPo5U_F-fwcfUUktGe31x9S3=E7vci=pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/8/31 17:42, Huacai Chen 写道:
> On Thu, Aug 31, 2023 at 4:58 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>>
>>
>> 在 2023/8/31 14:22, Huacai Chen 写道:
>>
>> [...]
>>> But it is worth to try, and you can walk the children to set mrrs when
>>> the quirk runs on bridges, I think.
>> No, this will break hotplug, I had managed to get hotplug work on 2K1000.
>> Also we have no guarantee on order of discovering devices.
>>>> but the old quirk should run on every single device.
>>> Your current patch has a drawback that both quirks will run for MIPS,
>>> and their order is random (though it may cause nothing, but not
>>> elegant).
>> Actually loongson_mrrs_quirk is declared by DECLARE_PCI_FIXUP_EARLY but
>> loongson_old_mrrs_quirk is declared by DECLARE_PCI_FIXUP_ENABLE,
>> which means loongson_old_mrrs_quirk always runs after loongson_mrrs_quirk as
>> expected.
> Then I think it is better to put this quirk in arch/mips/loongson64/,
> just as pci_fixup_radeon().

Hmm, spiting two quirks with similar functionality into two places 
doesn't sound
like a good idea.

PCI folks, what do you think?

Thanks.
- Jiaxun

[...]

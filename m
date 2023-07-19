Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FA575902D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 10:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjGSIYK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 04:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGSIYJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 04:24:09 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52691B6;
        Wed, 19 Jul 2023 01:24:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B3F163200946;
        Wed, 19 Jul 2023 04:24:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 19 Jul 2023 04:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1689755047; x=1689841447; bh=yj5ZNyx3bJGO8fextcCvMTuJb3vFCBIZNLI
        tIYuSUIY=; b=n/uyu36t7GewOebMFc3M/kLb+5zUMoGZUF6TGjRXkMa+IwGp6V0
        cDaX4s4cBFcGSsMatKHCx8/ESQpK/xl9EhBoG5jSWfOoI7P4uA5CrHyY71OY1H2x
        uxydK9cffT+Qne5t4tN1tKhYPrQuLMQwrMHDykNruS9IUre4wbElq/7mdt5rW0zj
        +YsnE8RZhai0DdcygqnXo+6L1hBsbWQvvRSqF2dw/MPe0LCIVuXdk2vgz0HyVkFZ
        3cWlxSv67nzy4hjVNldnNlLbDYAN/W/JZ2iEs/GikxbhoQYfSdXZCMmqAIw9fBn/
        vpFsCkAndHADBTL+mA4EXv1OmFA5ZhXtdpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1689755047; x=1689841447; bh=yj5ZNyx3bJGO8fextcCvMTuJb3vFCBIZNLI
        tIYuSUIY=; b=Syv7JxWMCh5h7FiUzDJqvXCKDZmV2xr+z82JFI6lWMk2/a0NZI2
        60NLjKRDnFHtj/CQy2094/kpbXUD1t9VtL0GI9OHpwOmSJBdxwgCIwqDQt1Q/DCn
        TA2IU4CDiifdTdGmjQOfT0hy7pCVpTKhJbzz2N7jWo47i4Xyv7TonN4dJfm+iBxq
        ynG/4I2n1NQMezR5rlYtu15gZqGaQJuc9BXxhbMBkJ6efwEdXYNFMyQtZFvGvkVz
        SDeFVU4jdNrQmET/ssSi05Y5Uq1i2XJrlQEMGlpieIJhV0Ahk/VngDXMEthu3+mh
        DB4+K/haVxsZea00s6hKYQdPO8s+XpQp3sA==
X-ME-Sender: <xms:p523ZKDxKad-GxOkS2KAk0ONJ-vzL5fIFBnzIQvgK5Y6S-BbPGB_Wg>
    <xme:p523ZEi9Z6N5eZeZXHF_SSvkT6Q84zILtT7HS5lbgWTr486Efig_X6lS__1gZGFRL
    AaJyIjyeobVUFOkKxw>
X-ME-Received: <xmr:p523ZNmf-qyhnAX8FUqcYzFib4KlN0jRl7vbvqLQzszbTf6Ol41difYZZQ4Ssp1zC2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeeigddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeffledtgefgudffhfefteelveeuudeugffhleevueekjeelueeh
    vefgveeiieduhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:p523ZIxxQqGpIuuCodUtdWecoQibXmfRII1iHmc50A5xMVq561hslw>
    <xmx:p523ZPTkoazrWAzS_nLyAgE855L_oARIiwzdr_iIMTKFzqXneycecQ>
    <xmx:p523ZDZQeB6SDdMp1SLv3h453--2iu_Bm20qjjzOa_YxxG4WqDYacg>
    <xmx:p523ZNNXUwUOz1Hho9oeNY-bQ0MH8_lvxoQ7Ilfnv_I8dedFTaGvKQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jul 2023 04:24:04 -0400 (EDT)
Message-ID: <c01c0138-70a5-f2ce-e99e-fa1a76e04cb2@flygoat.com>
Date:   Wed, 19 Jul 2023 16:24:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] pci: loongson: Workaround MIPS firmware MRRS settings
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, kw@linux.com, lpieralisi@kernel.org
References: <20230718133259.2867432-1-jiaxun.yang@flygoat.com>
 <CAAhV-H7bv1OmzT0E-SEF6w83gPYrTwnZfc0WpWMUmBB1T1MmqQ@mail.gmail.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <CAAhV-H7bv1OmzT0E-SEF6w83gPYrTwnZfc0WpWMUmBB1T1MmqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/7/18 22:46, Huacai Chen 写道:
> Hi, Jiaxun,
>
> On Tue, Jul 18, 2023 at 9:33 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>> This is a partial revert of commit 8b3517f88ff2 ("PCI:
>> loongson: Prevent LS7A MRRS increases") for MIPS based Loongson.
>>
>> There are many MIPS based Loongson systems in wild that
>> shipped with firmware which does not set maximum MRRS properly.
>>
>> Limiting MRRS to 256 for all as MIPS Loongson comes with higher
>> MRRS support is considered rare.
>>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217680
>> Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   drivers/pci/controller/pci-loongson.c | 38 +++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
>> index fe0f732f6e43..1cc3a5535dac 100644
>> --- a/drivers/pci/controller/pci-loongson.c
>> +++ b/drivers/pci/controller/pci-loongson.c
>> @@ -108,6 +108,44 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>                          DEV_LS7A_PCIE_PORT6, loongson_mrrs_quirk);
>>
>> +#ifdef CONFIG_MIPS
>> +static void loongson_firmware_mrrs_quirk(struct pci_dev *pdev)
>  From my point of view, loongson_old_mrrs_quirk() may be better.

Make sense to me, will rename in v2.

Thanks
- Jiaxun

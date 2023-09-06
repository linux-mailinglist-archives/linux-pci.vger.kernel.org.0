Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655C279413E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 18:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242390AbjIFQMS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 12:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241875AbjIFQMR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 12:12:17 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1EF1981;
        Wed,  6 Sep 2023 09:12:10 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5E91C5C0109;
        Wed,  6 Sep 2023 12:12:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 06 Sep 2023 12:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1694016726; x=1694103126; bh=PDsWyZ1OtV7q37pB2ldP/+uk/pTRCDAceza
        sAlKiBEo=; b=NlN0XnNXLB+QlOdjP23UHlJGBw4E4qmFCpXjF3NEcc+ZeEQBzuo
        aBokvneuw1h5R7UibZIiDuNuX9YVzej6NFgsVbnMF0FcGZtyPtz7L5+p+gxHo2Gh
        MYQ5XfsKigjKGA5ZdGhKdqsQOWUcf6xL6sdHWDy/hRXxHpg8KDjwt2EJm1W9qgQ6
        /Le+lLhJja3Z2E7NXHPf0MRZzM7EWwdGO7jIA64PGzTAjUbBNXuFf+GPdnjwmcxV
        DmH6zhZPrv4jQpz7e+Ly1UHl0otln3XqlnP56XfHGzcB/X9dBjMCJg56bXwpJ/eG
        x61Y5VYuodu+iSe8V10Z/cH848ZKWKP0JOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694016726; x=1694103126; bh=PDsWyZ1OtV7q37pB2ldP/+uk/pTRCDAceza
        sAlKiBEo=; b=KArhhK8bOWX21kk9EkV4H3RRgrn0a7odD3yfLaPf3f0nDfBUNzt
        Z4nmxaFbYF+/F6uk1yvZhZq5nLrKbr+peBOE/qX98XK3qRUWz6ncU1O/T6GUuWV5
        8IjZETxqwOlIOk7i67XHQCnI1GRMz7PSoNJlR9qDEL+ztU00mW/3C1XFklRj/n3O
        RDqAGZYOK2N/zPK5pQyNQ5VsAMbynkuNbDAaSz7yRUxqYuB5Ri9cZ43CkAzR2mAt
        xxJERcokaHEP2fPNG9SFjSztd0HMg4XcOZ6ziZjh9v9tNtvPZVYVIr15sK6v3z8I
        LcdntpRp2EFK8Fh1T74Y8hhuORYfti7BRYQ==
X-ME-Sender: <xms:1qT4ZAhqFQJYs9GxFl9AOpo-Td3i3bsvmh1T_gK6IIXmwyBa5UHo5Q>
    <xme:1qT4ZJBxtxfnykMVgSvGZg9eBpeLhsplj850KH_k_-RlbTg3GQApc0LxmLX4SWlyP
    nMPfrcpOIjk098jj1M>
X-ME-Received: <xmr:1qT4ZIESQ3F8gCGdjjxdfSWcv5CnFTN1DmywxoXdOM-KCACe4bJkNumPqYgDb9zh0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehfedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffhvfevfhgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepgfejfeegtdehudeiudeifeefkeeigfelueeuvdeihfejudel
    heetvdehheffjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:1qT4ZBQz_q28aZOsyC4Zne9ysEf9NzyJE5qf1nssMaBVm-bwNfoiDw>
    <xmx:1qT4ZNx70yHr8qamJ9wLQbA5jglaqQGPQhJq1Bi8JSQWezJTdatriQ>
    <xmx:1qT4ZP4ACuB4C8gPwACpHPfHAc2nijdyBjUse-7AMgVe8oT7m-uTdg>
    <xmx:1qT4ZAp4H12Y32INuVD0Tqpxb_UrZfwl4iitTaryQeUgFCvRsfM6rA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Sep 2023 12:12:02 -0400 (EDT)
Message-ID: <8c598a6f-98fc-c769-cbcb-90820a4a4872@flygoat.com>
Date:   Thu, 7 Sep 2023 00:11:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] pci: loongson: Workaround MIPS firmware MRRS settings
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Huacai Chen <chenhuacai@kernel.org>, bhelgaas@google.com,
        kw@linux.com, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230725061008.1504292-1-jiaxun.yang@flygoat.com>
 <e9c103dc-98ac-9a51-7291-f5da1467b2ff@flygoat.com>
 <CAAhV-H7_OjTaU_wn6mUW0-JSrXS+=A2rXCiBc8cyce5ob49BLg@mail.gmail.com>
 <861a809d-3df1-327e-e033-87506f6d89e5@flygoat.com>
 <CAAhV-H67ehyqtm4ocOTWQPGBioWjQjLoyN5H9hALdq0oXdzWVg@mail.gmail.com>
 <62a7b292-ea1e-fb88-79cb-e7968d350a5e@flygoat.com>
 <CAAhV-H4DRFrsWOusyVPo5U_F-fwcfUUktGe31x9S3=E7vci=pQ@mail.gmail.com>
 <c2bdde51-4dcc-59ac-5f54-bcf43152fc92@flygoat.com>
Content-Language: en-GB
In-Reply-To: <c2bdde51-4dcc-59ac-5f54-bcf43152fc92@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/8/31 18:04, Jiaxun Yang 写道:
>
>
> 在 2023/8/31 17:42, Huacai Chen 写道:
>> On Thu, Aug 31, 2023 at 4:58 PM Jiaxun Yang <jiaxun.yang@flygoat.com> 
>> wrote:
>>>
>>>
>>> 在 2023/8/31 14:22, Huacai Chen 写道:
>>>
>>> [...]
>>>> But it is worth to try, and you can walk the children to set mrrs when
>>>> the quirk runs on bridges, I think.
>>> No, this will break hotplug, I had managed to get hotplug work on 
>>> 2K1000.
>>> Also we have no guarantee on order of discovering devices.
>>>>> but the old quirk should run on every single device.
>>>> Your current patch has a drawback that both quirks will run for MIPS,
>>>> and their order is random (though it may cause nothing, but not
>>>> elegant).
>>> Actually loongson_mrrs_quirk is declared by DECLARE_PCI_FIXUP_EARLY but
>>> loongson_old_mrrs_quirk is declared by DECLARE_PCI_FIXUP_ENABLE,
>>> which means loongson_old_mrrs_quirk always runs after 
>>> loongson_mrrs_quirk as
>>> expected.
>> Then I think it is better to put this quirk in arch/mips/loongson64/,
>> just as pci_fixup_radeon().

Huacai, if you are happy with changes in this patch, do you mind to give 
out a
conditional R-b tag?

Since this regression is in tree for a while, I really don't want to see 
it lapse into
next release.

>
> Hmm, spiting two quirks with similar functionality into two places 
> doesn't sound
> like a good idea.
>
> PCI folks, what do you think?
Bjorn, Lorenzo and Krzysztof, do you mind to give some input on this fix?

Thanks
- Jiaxun

>
> Thanks.
> - Jiaxun
>
> [...]


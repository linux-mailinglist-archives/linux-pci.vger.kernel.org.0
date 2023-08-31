Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8440578E8EC
	for <lists+linux-pci@lfdr.de>; Thu, 31 Aug 2023 10:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjHaI6l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Aug 2023 04:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjHaI6k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Aug 2023 04:58:40 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1E8CE6;
        Thu, 31 Aug 2023 01:58:38 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 445505C00EF;
        Thu, 31 Aug 2023 04:58:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 31 Aug 2023 04:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1693472317; x=1693558717; bh=GO+RB/XjbQvZQe1MEUlBwDOw8njnoFbRMlk
        s6o1U5dw=; b=n2qaDeb/UbimrdbrMvWZDVeSrHCybiKua/Ds0tnvtcnDD+fAU/H
        MLidxqDFUemvZt4Nef/MLcJbsRAXEk7gKZfq8R+XW1DGiVlp8A9M1UDv1igiNpzD
        mxaEiSdHC36/jxKMc6Qt7QWGaw8ad0QQRpI5C0bjNYBFJBlE4x2LsCqZmW8oBM0y
        aYBIkoiTEwoNDmx25o3vSFTBvLKB+vW4QwqJe75TWM393SyWPgbzVhi2ANIBybGi
        MnI+stDpGYR+tsIdesb92RarDs2XNvYBweyn8Ma5I3zQ9vB73N2HSqIOQWslTfhy
        YR9JdbCkRPolC0nlqBiV6fvZ4OfGHTIf1Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693472317; x=1693558717; bh=GO+RB/XjbQvZQe1MEUlBwDOw8njnoFbRMlk
        s6o1U5dw=; b=wWCYcoiHIWSq6hvrKzB6e7q/Au0spKWXt3QQFGqdXB+iKS7I5q0
        YAD+isxn3z2fvMaAMJoaO9dQ0DaDikza3c2HMz85dr2RtQJfPq7pIo4MctLzdSPo
        jX2EJ1uWH1nd3KGi+A0PNhe/kFOTUrp8HAdwsve/bCxDHCSeL2X/GFhX5BwdAxXZ
        AJfOOW8xb1pXyNuxe/P2RkSM8hDFd/LawAjpnB/Ly3Lh6qoP8RLyco7YnI5BINaE
        nYx0YokHgRvzh/h28BNST9da5SzbDnQUXX4lViJ0+a2K6r+7YUqToiwAEktU6a5F
        wfcIiDfwQdSYS0AJXtCDhcYd89mrKWFe93Q==
X-ME-Sender: <xms:PVbwZPBZQcINLZAud8gAT3wGw16aUcZAiqu7F-TuunQNL81YnV-dvQ>
    <xme:PVbwZFgH171shnitFFRpMjcdhFaN5icYBNPXlKIVZG0hEnFeEM87oReuA09_vdvQk
    rGEc1KuDPrsiwIiUI8>
X-ME-Received: <xmr:PVbwZKmIpxGdxy7a3OeTqXWTnX8eMJ52WNpo8yytOSgWfnOp97pZWMu6TbRJq2gYOnI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegtddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepudfhkeevvddtueekfeefgfetlefgueegueeltddtieejgeei
    heevgfehgfdvfeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:PVbwZBxyzNeDwwFLAuITfW_174_Sjg1Q03UsPYOkL1jeAZc4sNXHHg>
    <xmx:PVbwZESCpUZsAgxq4gR_dHFZOfwKLHZJPQKf32YtegEp6CjasFPKPg>
    <xmx:PVbwZEYrGFf-4w_aacbqYwOqS6Xfhy3vK_OVftGcoMXEJmBX0PU_iA>
    <xmx:PVbwZJIIkHoosWFpMmksaFrfEfNg2SeL7N6PgOBB__S82vWtp5K6Mw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Aug 2023 04:58:33 -0400 (EDT)
Message-ID: <62a7b292-ea1e-fb88-79cb-e7968d350a5e@flygoat.com>
Date:   Thu, 31 Aug 2023 16:58:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] pci: loongson: Workaround MIPS firmware MRRS settings
Content-Language: en-GB
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, kw@linux.com, lpieralisi@kernel.org,
        stable@vger.kernel.org
References: <20230725061008.1504292-1-jiaxun.yang@flygoat.com>
 <e9c103dc-98ac-9a51-7291-f5da1467b2ff@flygoat.com>
 <CAAhV-H7_OjTaU_wn6mUW0-JSrXS+=A2rXCiBc8cyce5ob49BLg@mail.gmail.com>
 <861a809d-3df1-327e-e033-87506f6d89e5@flygoat.com>
 <CAAhV-H67ehyqtm4ocOTWQPGBioWjQjLoyN5H9hALdq0oXdzWVg@mail.gmail.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <CAAhV-H67ehyqtm4ocOTWQPGBioWjQjLoyN5H9hALdq0oXdzWVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/8/31 14:22, Huacai Chen 写道:

[...]
> But it is worth to try, and you can walk the children to set mrrs when
> the quirk runs on bridges, I think.
No, this will break hotplug, I had managed to get hotplug work on 2K1000.
Also we have no guarantee on order of discovering devices.
>> but the old quirk should run on every single device.
> Your current patch has a drawback that both quirks will run for MIPS,
> and their order is random (though it may cause nothing, but not
> elegant).
Actually loongson_mrrs_quirk is declared by DECLARE_PCI_FIXUP_EARLY but
loongson_old_mrrs_quirk is declared by DECLARE_PCI_FIXUP_ENABLE,
which means loongson_old_mrrs_quirk always runs after loongson_mrrs_quirk as
expected.

Thanks
- Jiaxun

[...]

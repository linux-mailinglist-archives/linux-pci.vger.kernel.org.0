Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FAB652889
	for <lists+linux-pci@lfdr.de>; Tue, 20 Dec 2022 22:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbiLTVtG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Dec 2022 16:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbiLTVtC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Dec 2022 16:49:02 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C521F2CB
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 13:49:01 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3F86D5C012E;
        Tue, 20 Dec 2022 16:48:59 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 20 Dec 2022 16:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1671572939; x=1671659339; bh=qFNrjE+MU/
        aHWOuwaY9sLeM6ocoYDHmnOKkYGdXz6Ks=; b=lTBbHcgYoQZEGGaHuIbvpX/x5t
        hpxUG4HobRHjPfpEBI9DUySOvbUPDku7Wdt/wacxlVuGwVSrr4HpiLOTswIFvGvv
        zXjbpD/jHf9suSmuS/FxM4YTTJ0J6nZHxsax8WjD/n/LtCsHEU+CTKR7Xk+nw+NJ
        cNqaHe2XPeEWXdZxm3eSN3h4GnEKp7QDd+ozIzZoEL4W0UOpJcA0a3+5SCFTaJDg
        5K7eCkEF8+/9EtivlEZitdhH67d49cb5OxNB50Iq7He64JaU3wo2kSRXRXsAgFYT
        /SjccVLz5mfgtsV39n+U5AMhcyzL3mAHe2p2EHDmaHbmbHQhBPC0oKLAIy4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671572939; x=1671659339; bh=qFNrjE+MU/aHWOuwaY9sLeM6ocoY
        DHmnOKkYGdXz6Ks=; b=JQ5P4EjydGRaa0w/hRPrIdAv/wgWy64UiIDbWtDzaR2e
        pBXzhTfcpJfIjKSJrXSGMpSLy3+P8p9r2MB0euBqrWX2V1qSaUyFDHRppNzbmCvC
        hAiotAmG8w2fbqsqzJ6QWg19M3tB01FMOZovi32UWH7nR5EcSOuAX2fTuVkgHkS3
        wU4XM/hV5453CJn3dX/qJwDHVr9whriM6vDPmDCG3oxTtK390/54mX66vk3pY2f0
        ZrSHAs5Ga0hYosGJ9UHGIM3IwPvN2tOPIEdQ0B2VrKfo1AHcjY23wRazpLlraetN
        fDKBlCHKHRSnfXo/zIl8hVtj/C7QQFclx6W/Sr9W6A==
X-ME-Sender: <xms:yy2iY79pVamm-m8ywGcXVF805qhm7i3uHm3QlguahNKqOvUmT17YTQ>
    <xme:yy2iY3u8aTyAjI1HnJp68fzyOpDB5TFuJz1XNhn6nN1n93ragUdebZ1Kvh0Xzo0pr
    MEt0VL8rHgIBnSsIlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeigdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:yy2iY5AaIBsZx-7oZGK7mbEXiy3jlmxKNWgrVWJwSFVDMye9fKpvDA>
    <xmx:yy2iY3cbLAZVNxZQI0J0Tb-rB4KfPsxJwB1hqx1dwBGdpGNUpyPTYQ>
    <xmx:yy2iYwNgbAGE4f8PZjjWejpxx4eANgO2CDhkuFyp-zK29Psrarb6YA>
    <xmx:yy2iY3dbd6Sll9_DW01LQJ7bK8SLbR81gccc8ZtfKMlS06Tc39WkyQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 004BDB60086; Tue, 20 Dec 2022 16:48:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <ee60ef99-b09c-4ed7-ab8e-5df97037cad1@app.fastmail.com>
In-Reply-To: <CAJs=3_B7WoERAiXPyvz=6d7O5rcwXMfWZJFsi_ds-OAemvfcgQ@mail.gmail.com>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
 <Y6HjpvDfIusAz2uS@dev-arch.thelio-3990X>
 <CAJs=3_B7WoERAiXPyvz=6d7O5rcwXMfWZJFsi_ds-OAemvfcgQ@mail.gmail.com>
Date:   Tue, 20 Dec 2022 22:48:38 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alvaro Karsz" <alvaro.karsz@solid-run.com>,
        "Nathan Chancellor" <nathan@kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jason Wang" <jasowang@redhat.com>,
        "Jean Delvare" <jdelvare@suse.com>,
        "Guenter Roeck" <linux@roeck-us.net>, llvm@lists.linux.dev
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 20, 2022, at 17:46, Alvaro Karsz wrote:
> Hi Nathan,
>
>> This does not appear to be a false positive but what was the intent
>> here? Should the local name variables increase their length or should
>> the buffer length be reduced?
>
> You're right, the local name variables and snprintf argument don't match.
> Thanks for noticing.
> I think that we should increase the name variables  to be
> SNET_NAME_SIZE bytes long.

If you can show that the string fits into the current length, it
would be better to keep the stack usage low and just adapt the
length to be sizeof(string) instead of SNET_NAME_SIZE.

    Arnd

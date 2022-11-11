Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632406261B4
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 19:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiKKS4w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 13:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKKS4w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 13:56:52 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9632A71F28;
        Fri, 11 Nov 2022 10:56:50 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2D9025C00AB;
        Fri, 11 Nov 2022 13:56:48 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute5.internal (MEProxy); Fri, 11 Nov 2022 13:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1668193008; x=1668279408; bh=sZ
        nlr/hRQupQXvXt4IW1vs60z2riRmemioARd1D/gO4=; b=ZrrwOctX5eIYzJn1bU
        fYGpI8KeH5Pkv1JpSS3fSxZ76+5mhH+ejG4OPWU2F8Hvsj6uAW7DeVKcM6uR9uml
        G3iynlovi6mGI53/jCfQCmTFmxovQWUl8cm6mRjfflheEymyoLe7mjIMJLSgYWse
        25u0lKqyr0YJOSzb5GRbNp/roPsiXJwPW2DMQT0llUScQYitf42vr6mZV2xbFliy
        q0+P3u0bMbbgG/76P4JW8TtIOw8M/XZCqi7L+Trv3hKM7qhNF1Cm6XAXL9d2erwl
        kun2qIX4w6aU5dXadjH8vHAUJzYyx5amioL9UrLaKX3rGELBitLZQWKywGnvW/un
        +u8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668193008; x=1668279408; bh=sZnlr/hRQupQXvXt4IW1vs60z2ri
        RmemioARd1D/gO4=; b=YRar+X8Tqtg2N7smwupOrZpOwtIAgn9ZZmO453vvJB0U
        u6waDefwAuJQ1saK7Q7ZZmSjXf7hoUbVfrr1QsSBbL3l9bzpW/JxxSJ9fK9jizTu
        eyDyuyuRxQ4h/rEt8fgi6eSEz+t5BwmF8zMJULBWI+gEgxUbj1GOJi+MsF6+PjNS
        j9lM6wEgPghxw4C3r5Hh2JjFWGutMGR/ZeyT1mCOOI26t+tVJ+YAwioMmnhkw0wO
        z4RmxD7HXT48J6tilNAX4g6/D7KDErCcj6gTP4HEmB3AW9uWJ7RUQIa5T1p+O++x
        r4OQFTzexV7bV339jrSviTzwZpwqo15skkfRsK3sag==
X-ME-Sender: <xms:75puYzt8UvOudHjr4oMqDLcpI-fyEpW05FdO40CDTKYnqdIF_ErRHQ>
    <xme:75puY0cDFq6mAIk1gLi3Y2_uWB0EGNcA9CDv7-Z49FC1ik8_mwYPADQE647Y2FMva
    mXE3dkC9yCYK1g0EQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeeigdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedflfho
    hhhnucfvhhhomhhsohhnfdcuoehgihhtsehjohhhnhhthhhomhhsohhnrdhfrghsthhmrg
    hilhdrtghomhdrrghuqeenucggtffrrghtthgvrhhnpedvgffgjeettdeifedvfedvheeu
    tdeitedthfetudfffeeuvdfhkeelleffgeeivdenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ghhithesjhhohhhnthhhohhmshhonhdrfhgrshhtmhgrihhlrdgtohhmrdgruh
X-ME-Proxy: <xmx:75puY2yHJXUgu1yBQ8ym-gOer1XHMAVxXxNP5VAsr76pCusAnzUcnA>
    <xmx:75puYyMdGV2v2Xh3zVgkHq_sXSxDKqNSoPtQ1ZZ2Me6OT_AayT137w>
    <xmx:75puYz-eZqapWUkqo4WcSck2e8QFJ5nZoT4k8zFcKyGerXIux9ce4Q>
    <xmx:8JpuY0PtMm4pnhi4Gg0Y7GpfROo7tYxFf6T_caZuoezlrlK92cXKdg>
Feedback-ID: ic081425d:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D7D522A20080; Fri, 11 Nov 2022 13:56:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <d9b2102a-5a10-4c81-8baa-5f68218419fb@app.fastmail.com>
In-Reply-To: <20221104205242.3440388-3-git@johnthomson.fastmail.com.au>
References: <20221104205242.3440388-1-git@johnthomson.fastmail.com.au>
 <20221104205242.3440388-3-git@johnthomson.fastmail.com.au>
Date:   Fri, 11 Nov 2022 18:55:29 +0000
From:   "John Thomson" <git@johnthomson.fastmail.com.au>
To:     "Sergio Paracuellos" <sergio.paracuellos@gmail.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "John Thomson" <git@johnthomson.fastmail.com.au>
Subject: Re: [PATCH 2/2] PCI: mt7621: add sentinel to quirks table
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 4 Nov 2022, at 20:52, John Thomson wrote:
> With mt7621 soc_dev_attr fixed to register the soc as a device,
> kernel will experience an oops in soc_device_match_attr
>
> This quirk test was introduced in the staging driver in
> commit b483b4e4d3f6 ("staging: mt7621-pci: add quirks for 'E2' revision
> using 'soc_device_attribute'"), and the staging driver was moved in
> commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host
> controller driver") for the 5.16 kernel
>
> Link: 
> https://lore.kernel.org/lkml/26ebbed1-0fe9-4af9-8466-65f841d0b382@app.fastmail.com
> Fixes: b483b4e4d3f6 ("staging: mt7621-pci: add quirks for 'E2' revision
> using 'soc_device_attribute'")
> Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
> ---
>  drivers/pci/controller/pcie-mt7621.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-mt7621.c 
> b/drivers/pci/controller/pcie-mt7621.c
> index 4bd1abf26008..ee7aad09d627 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -466,7 +466,8 @@ static int mt7621_pcie_register_host(struct 
> pci_host_bridge *host)
>  }
> 
>  static const struct soc_device_attribute mt7621_pcie_quirks_match[] = {
> -	{ .soc_id = "mt7621", .revision = "E2" }
> +	{ .soc_id = "mt7621", .revision = "E2" },
> +	{ /* sentinel */ }
>  };
> 
>  static int mt7621_pcie_probe(struct platform_device *pdev)
> -- 
> 2.37.2

Ping for the PCI change.
Original link: https://lore.kernel.org/lkml/20221104205242.3440388-3-git@johnthomson.fastmail.com.au/#t
I would like this pci controller patch applied before we fix the MIPS mt7621 early kzalloc boot failure.
The phy-pci patch was accepted.


Cheers,
-- 
  John Thomson

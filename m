Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CF06BD370
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 16:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjCPP0X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 11:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjCPP0W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 11:26:22 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C46612BE3
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 08:26:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id F107B5C0167;
        Thu, 16 Mar 2023 11:26:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 16 Mar 2023 11:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678980379; x=1679066779; bh=hD
        aewbyxbYnheSxYIyArYNDSD6iitWoLHl5Lpyt0KTg=; b=k/7/bAvWmYKrwWPqem
        tZ9Bwl6E/D9e+RRFOJX5i+AIm3UAC2oMfkAIYJgwhK/9a0WY8e4o5ni8v25oyndj
        HDxVHSFWY7U+1FCwbp2jH2dc509sM5qnuH8lTxcOQbxAeQ0kzKJxMc6KRzY+gt6j
        eEEc3D/6f/ima5Z9kLc2oLeTo0S/1Kf5jgswmp1dV+BasrEdvjSPoZ7i+hVIBFCp
        ZK1wo11fnJYhLLWEvTdyM48LAZrBfo7DKdynA/+9VuoPYN+4aLrjJ/rRFhQyTLzD
        zUNsU4ECGWr/J45pDFfb8bashT93xZNnun5aTZbIGzy3eIkmIVQCS9OC1I95zMIn
        ZZWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678980379; x=1679066779; bh=hDaewbyxbYnhe
        SxYIyArYNDSD6iitWoLHl5Lpyt0KTg=; b=JUuJkrS7/AS4BaxjDXs92bKNe2jAr
        oJAO/3LCNfJaJJi9n1xuUSrgOvH9IFFxs3e7xUCkyHWLRWMtREVnNxk2Qr4PRh8b
        KteFn1QB7zMRUBINRDCCnU9HaHVJsZ6ZK95LsgXKJY8bCZb2GVoX/3g5vkWMFFO3
        vNlpz+jKtUtHHnrHZKAIujlZcnD6vNwlWphS5KrWNwK0Ab6LzOEWw2m2GsVT7IQi
        W9WGe2GEMLvb9CW+coKwq14GaBlDnGoq8QXXLzh9qsqbQRQKjNmENnp/XQ1eekZA
        i635B8ylVRyy8lZwsdHnLHP/RbHxlGSEjHH0FuJMsrwCx2pGhgmCdkcDA==
X-ME-Sender: <xms:GzUTZEXgH2nsn0QC0Dzpom9TTGtGgJ-AwXb2ui4qFJteeQN9HSVPhg>
    <xme:GzUTZImXokPCtxa1XHTJ_Zro2_hCGCKiUSuEIOoiJpUPY-1LbaN-twsvMwM-HTco3
    AAPlMacf6cjrF3A3B0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeftddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:GzUTZIbzC1ihPCLeCC_1HeWe7uRWfpQl4JAaa1_VQeRCl_5s_ee4Zg>
    <xmx:GzUTZDWATDIU71NC8AR3NlcrV-m9KPWUW73Hlawl1PoBwJw4n4OMQg>
    <xmx:GzUTZOn44YgEVQgUcvxNxWpY4xB9RZY02SdmD0lTYui5QDrkgnK9sA>
    <xmx:GzUTZMbgiRud0TONHJoLslWYxpvbiJWMRNObq723e1j5MlvpWO5DyQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B823AB60086; Thu, 16 Mar 2023 11:26:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <d2f42b13-3d1e-4fb9-8b03-b32b7a9845a9@app.fastmail.com>
In-Reply-To: <20230315155119.GK98488@thinkpad>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
 <20230308090313.1653-10-damien.lemoal@opensource.wdc.com>
 <20230315155119.GK98488@thinkpad>
Date:   Thu, 16 Mar 2023 16:25:58 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Manivannan Sadhasivam" <mani@kernel.org>,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     "Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rick Wertenbroek" <rick.wertenbroek@gmail.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 09/16] PCI: epf-test: Improve handling of command and status
 registers
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 15, 2023, at 16:51, Manivannan Sadhasivam wrote:
> On Wed, Mar 08, 2023 at 06:03:06PM +0900, Damien Le Moal wrote:
>> +	/*
>> +	 * Set the status before raising the IRQ to ensure that the host sees
>> +	 * the updated value when it gets the IRQ.
>> +	 */
>> +	WRITE_ONCE(reg->status, status);
>
> For MMIO, it is not sufficient to use WRITE_ONCE() and expect that the write
> has reached the memory (it could be stored in a write buffer). If you really
> care about synchronization, then you should do a read back of the variable.

This is not MMIO, this is the local access to a variable that is accessed
through MMIO from the remote host. Reading it back would not change anything
here as far as I can tell, 

      Arnd

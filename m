Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D3B5B69A0
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 10:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiIMIfx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 04:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiIMIft (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 04:35:49 -0400
X-Greylist: delayed 374 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Sep 2022 01:35:48 PDT
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E3141984;
        Tue, 13 Sep 2022 01:35:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 50155580C8B;
        Tue, 13 Sep 2022 04:29:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 13 Sep 2022 04:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663057769; x=1663061369; bh=xKaS3qcdyI
        pLMDP6PxAbEzVODr2BdJywglsILCX5fgo=; b=LtCr8MPS+qDZ4VeZgJ48KDXBir
        4YErqxguk+UXugHrUdWpH3OrsZaN0x+mpG6kcyx583QjKJ2KeEdQXCfo7ob23CNO
        y7ZGeokdTOZyquVra1dWA923vL1CRpHLA+ryqPEDVUqc09/cn4ROhXnRFMkua8Bj
        ZV8Goj3iBCLBkGwVlSflk/Q+LAhdWV4mAEeyUxJZiYbF/UM65VFt3b+RvJRPWCdS
        uHK6zu3fgHCUzCVtjwEhFUy3YRlR/Pcz/aiAXuvyMIUCajHKngiAIoj/AgOggQmW
        BZKnGEvFMk8h2fvy5aKycPcw9QjiT636M7BZHN6rTJ5J/8EQ0d2wIbf57WWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663057769; x=1663061369; bh=xKaS3qcdyIpLMDP6PxAbEzVODr2B
        dJywglsILCX5fgo=; b=vczuyfQxl4/I6U8nbllWGt2X7SK85Cz9Tj7oWiJcJNuM
        Bhk+thM4forH6SU4bBB7vjdG5RoCGI+3nJI1noQuFfxRajxHG0zphEQHzn7HR83x
        PWz9IM+UO9MZTD69cZu9pmPmOuvBgyArc8Rw+S73DUZ2AUPP1XD5VNIpHhMMr6Ts
        2tnEHDNWUIgRxhB4f23KOaE5gQh6FTNJN7h31p3qVvm4iLsOaE4MONrR5yPVBGax
        pXmi4uE2vRLOVP8fJUr+U4X6fyr7SEV9vtmdXHeMx2jrUpBNTAQHh3yTXDc86rqb
        vXKZUBF3uoQ3xnOb/DRsd9oNi2PSiqSP7JMsAFV6Ew==
X-ME-Sender: <xms:aD8gY2PKbvM7QVGR-135n_yNJmd9aI5EK2GZpIXUTn2FiH3kZsp3kg>
    <xme:aD8gY086O-V-HOEukY-7V1X9QrYrkkUfct7A1AsTzHl4vi9qEpthfXUJTxBszbynS
    GXeVBgfYmc8_5hANz4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedugedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:aD8gY9QlzworIgwfFLA80kv_q88lp_h1eXqzoO_9weGItu_iMtorwA>
    <xmx:aD8gY2v_grI0heg7xHkko3P-jecq5b5ieLYq-x_8F_urxXaxJA0V2g>
    <xmx:aD8gY-emKDANxGZvtJgUztZDD17ZX8eajKTk-S2upt_aMyzgDUAnsQ>
    <xmx:aT8gY1_nRSWQ5yNSSQDIJICGBNlAZKTDBpd2DFSfPvLlvSjwBp1EPA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B92E9B60086; Tue, 13 Sep 2022 04:29:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-929-g09f3e68182-fm-20220908.004-g09f3e681
Mime-Version: 1.0
Message-Id: <91244c88-d909-4e19-a058-b4f110e42ed7@www.fastmail.com>
In-Reply-To: <YyAx17VNvDMyvgBV@shell.armlinux.org.uk>
References: <20220913065910.15348-1-tangbin@cmss.chinamobile.com>
 <YyAx17VNvDMyvgBV@shell.armlinux.org.uk>
Date:   Tue, 13 Sep 2022 10:29:08 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Russell King" <linux@armlinux.org.uk>,
        "Tang Bin" <tangbin@cmss.chinamobile.com>
Cc:     hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>, robh@kernel.org,
        kw@linux.com, "Shawn Guo" <shawnguo@kernel.org>,
        bhelgaas@google.com, "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: imx6: Fix wrong check in imx6_pcie_attach_pd()
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 13, 2022, at 9:31 AM, Russell King (Oracle) wrote:
> On Tue, Sep 13, 2022 at 02:59:10PM +0800, Tang Bin wrote:
>> @@ -352,8 +352,8 @@ static int imx6_pcie_attach_pd(struct device *dev)
>>  	}
>>  
>>  	imx6_pcie->pd_pcie_phy = dev_pm_domain_attach_by_name(dev, "pcie_phy");
>> -	if (IS_ERR(imx6_pcie->pd_pcie_phy))
>> -		return PTR_ERR(imx6_pcie->pd_pcie_phy);
>> +	if (IS_ERR_OR_NULL(imx6_pcie->pd_pcie_phy))
>> +		return PTR_ERR(imx6_pcie->pd_pcie_phy) ? : -ENODATA;
>>  
>>  	link = device_link_add(dev, imx6_pcie->pd_pcie_phy,
>>  			DL_FLAG_STATELESS |
>
> This change is unnecessary. If dev_pm_domain_attach_by_name() returns
> Null, then device_link_add() will also return NULL, and the check for
> a NULL link will then succeed. So the NULL case is already cleanly
> handled.
>
> So overall, your patch is unnecessary and introduces a bug rather than
> fixing it. Therefore, you can discard the patch in its entirety.

Agreed. On top of this, I would argue that any use of IS_ERR_OR_NULL()
is an indication of a problem. If an interface requires using this,
then we should generally fix the interface to have sane calling
conventions, typically by ensuring that it consistently uses error
pointers rather than NULL values to indicate an error.

Some interfaces like this one return NULL to indicate that there
is no object to return but there is no error. This is a somewhat
confusing interface design and users tend to get it wrong the same
way. It is probably a good idea for someone to go through
the users of IS_ERR_OR_NULL() and see how many are wrong, and
improve the error handling, or if they can be expressed in
a more readable way that avoids IS_ERR_OR_NULL().

     Arnd

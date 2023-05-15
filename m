Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62048702C9F
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 14:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241822AbjEOM03 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 08:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbjEOM00 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 08:26:26 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846CD10F3;
        Mon, 15 May 2023 05:26:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E40AA5C00EC;
        Mon, 15 May 2023 08:26:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 May 2023 08:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1684153584; x=1684239984; bh=FS
        hj9jhaCJscn4VhLGeY2HLL/OvONSHw3LtQ6873UHU=; b=bDn/R9R8UiUb1g96qU
        s+BUMqi4w9X4MLqr/g66nNXkUHJb5Urp1qbIoZIC785Oye4Wnmb3At4gt6DQEvls
        iPbBgS2vyJShq0orBrjZpdCLA77U3y2zBPQqTTFuH7VW40jCDOZic2FtVTVSMeC/
        NMgvz2+Wwcq1+UbUWNenbsdUev+qHTLSsx+fHCKRlKEzDDqSHnqPR+lecFQqUlyW
        Z1DNL5jAoSAnBaznrg9gSrLI+Zhg11uKMHPx3v6x6QN2CSqnCsTCe5WCyYvfsohT
        JH/89wdHigdYyKAD+zi3fFiSYCnbezyBWLBWImJOU8/1BA4uNVxokvxNICxjCuGI
        +Ulg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684153584; x=1684239984; bh=FShj9jhaCJscn
        4VhLGeY2HLL/OvONSHw3LtQ6873UHU=; b=gBpqrQuF+8pxllcGPFkkD3GSCz2FO
        EE3r2LuO4J9FF5K2optxIWEyx5d6X/xjJXrdyEGSObRu26TxH3bhmIjo4EUn8Vut
        hTpZGnor3W/21sNv1fjfXIvQL6DHA9K9lsVLYNC+6aiKkR2U9M3v6EH6GTPf/hom
        hH4uTbLc3sG4bVovoWiBxAWQB7Ori0a4yF98Ylo9xf1lc5aXiI1YNRdBaWfBbeuZ
        x/VlRrsHhgcaNdi7x2oy03OvN7WoYKUK7gZhGQxXw7H8wYLug+FaSxrAHPmtJcL6
        aZu1YClcYlBko77gQWgxVJcu+40QswikFkdjUYscgahiLUg5Cr2vLIyaA==
X-ME-Sender: <xms:8CRiZFrfwhwajeZFioYSVAGnYub6dqDlmm-62eSXWs53CI4tOXS2nA>
    <xme:8CRiZHoRko6houI2cfdSdLHQCaiVVb3HANDGtt_BqdU0Vv2qEGFA65pJ_Yl-ZWUuP
    Zc1BiPzXM9lng>
X-ME-Received: <xmr:8CRiZCNlvc9XxVVLnttcSWqxzwJyuJGTGivNjHawZ8kzjeb523F8q_T4tWxrIbVwDRzmQCC6AeHgvPxDs8seZ7YvORsPrICfhZT8Hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:8CRiZA7uqHeMKjthjza3RwkPFFhVppxNQImtfSey6HkV0b8u4GQHTQ>
    <xmx:8CRiZE60-Y2lbAJTsCnqIxjuq5S7lmImGlDCkSNaRu-lTohSmoWXNQ>
    <xmx:8CRiZIh1HihDM6eDV9i30eenngYlQasZz0VWY3MauP0NiFpYqjERng>
    <xmx:8CRiZCZ5Ou2kkYhgzqRl7F09D5fGbR8bV9ENmqsf7t5w2xIzrvE6Yg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 08:26:23 -0400 (EDT)
Date:   Mon, 15 May 2023 14:26:16 +0200
From:   Greg KH <greg@kroah.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Goswami, Sanket" <Sanket.Goswami@amd.com>,
        "Gong, Richard" <Richard.Gong@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Guenter Roeck <linux@roeck-us.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] amd_nb: Add PCI ID for family 19h model 78h
Message-ID: <2023051505-bright-armrest-028e@gregkh>
References: <20230427053338.16653-1-mario.limonciello@amd.com>
 <20230427053338.16653-2-mario.limonciello@amd.com>
 <7b74c389-97b7-4f56-851b-6ce17950a4d1@roeck-us.net>
 <f2b81356-e702-3026-660f-d9a88edff632@amd.com>
 <084837c4-72c8-be92-fd1c-5ccbd805c559@leemhuis.info>
 <20230508112543.GBZFjcN2oxk4do31w4@fat_crate.local>
 <a8b29619-f1da-4cb9-a5bd-a396b52e159f@roeck-us.net>
 <20230508134414.GCZFj8rieNwF1AOerB@fat_crate.local>
 <MN0PR12MB610132F2277B0F1DB1039A15E2749@MN0PR12MB6101.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB610132F2277B0F1DB1039A15E2749@MN0PR12MB6101.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 11, 2023 at 07:51:42PM +0000, Limonciello, Mario wrote:
> [AMD Official Use Only - General]
> 
> +stable, Sasha
> 
> > > Together with this patch there are now at least two regressions if
> > > -rc1 whch could have been avoided and may impact testability on
> > > affected systems.
> >
> > Are you saying that this patch which fixes s2idle on some random box
> > should've gone to Linus *immediately*?
> >
> > And read my mail again:
> >
> > "Some fixes need longer testing because there have been cases where
> > a fix breaks something else."
> >
> > So yes, I disagree with rushing fixes immediately. If they're obvious
> > - whatever that means - then sure but not all of them are such.
> >
> > --
> 
> Unfortunately, it looks like the broken commit got backported into 6.1.28,
> but the fix still isn't in Linus' tree.
> 
> Sasha,
> 
> Can you please pick up
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=23a5b8bb022c1e071ca91b1a9c10f0ad6a0966e9
> for 6.1.29 to fix the regression?

Now that this is in Linus's tree, it's queued up, thanks.

greg k-h

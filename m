Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3E156CEBF
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 13:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiGJLVO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Jul 2022 07:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJLVO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2022 07:21:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B240110557;
        Sun, 10 Jul 2022 04:21:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BEF1B80A2A;
        Sun, 10 Jul 2022 11:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D177CC3411E;
        Sun, 10 Jul 2022 11:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657452071;
        bh=5uITWZquRRBcqDlzB/zUCCPE4YzYa5fd6bNu3wtmZGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UIQ5lTDSpwFwN08bX/O+t8D/Z934ZXNM47vJjvBpI4cW09VrOG6kTaOEWoI5eRgbT
         mXvnKwWgZNephw5pJ8gY2OfZfxkLhW/e0Asgn7UOROu1ZCrrHK3AcYQe8ZxJvNqEr3
         4AFCkMtrqiZx39OgAQkRigUEB2FxbRAsWx+DYCftynHloaWYGHazfkxNOsdYKCKISG
         0GqtOfUYARvK7foAq2rbwOga12mC/4GYdYpSpDUT98tblZEPH6dhNkknQetVaN9Dg1
         0cFmGGfNJCD6XMIRJQ6BmQEcK+5PtA2GKedk5XW9vQROO4xLPqaMbl0ZB3vVEBJjep
         oZIeOXByM2LLw==
Received: by pali.im (Postfix)
        id 3785877C; Sun, 10 Jul 2022 13:21:08 +0200 (CEST)
Date:   Sun, 10 Jul 2022 13:21:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Elad Nachman <enachman@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Arun Easi <aeasi@marvell.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Wojciech Bartczak <wbartczak@marvell.com>
Subject: Re: Issues with A3720 PCIe controller driver pci-aardvark.c
Message-ID: <20220710112108.jegpz4khfsrb4ahd@pali>
References: <20210723221710.wtztsrddudnxeoj3@pali>
 <20220216200940.fwdwk5rcb4zq6dyg@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216200940.fwdwk5rcb4zq6dyg@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ Other people from Marvell active on LKML.

Could you please look at this issue and give us some comment? It is
really critical issue which needs to be solved.

On Wednesday 16 February 2022 21:09:40 Pali Rohár wrote:
> + Bharat, Veerasenareddy and Wojciech from Marvell
> 
> Hello! Could you please look at this email and help us with this Marvell HW issue?
> 
> On Saturday 24 July 2021 00:17:10 Pali Rohár wrote:
> > Hello Konstantin!
> > 
> > There are issues with Marvell Armada 3720 PCIe controller when high
> > performance PCIe card (e.g. WiFi AX) is connected to this SOC. Under
> > heavy load PCIe controller sends fatal abort to CPU and kernel crash.
> > 
> > In Marvell Armada 3700 Functional Errata, Guidelines, and Restrictions
> > document is described erratum 3.12 PCIe Completion Timeout (Ref #: 251)
> > which may be relevant. But neither Bjorn, Thomas nor me were able to
> > understood text of this erratum. And we have already spent lot of time
> > on this erratum. My guess that is that in erratum itself are mistakes
> > and there are missing some other important details.
> > 
> > Konstantin, are you able to understand this erratum? Or do you know
> > somebody in Marvell who understand this erratum and can explain details
> > to us? Or do you know some more details about this erratum?
> > 
> > Also it would be useful if you / Marvell could share text of this
> > erratum with linux-pci people as currently it is available only on
> > Marvell Customer Portal which requires registration with signed NDA.
> > 
> > In past Thomas wrote patch "according to this erratum" and I have
> > rebased, rewritten and resent it to linux-pci mailing list for review:
> > https://lore.kernel.org/linux-pci/20210624222621.4776-6-pali@kernel.org/
> > 
> > Similar patch is available also in kernel which is part of Marvell SDK.
> > 
> > Bjorn has objections for this patch as he thinks that bit DIS_ORD_CHK in
> > that patch should be disabled. Seems that enabling this bit effectively
> > disables PCIe strong ordering model. PCIe kernel drivers rely on PCIe
> > strong ordering, so it would implicate that that bit should not be
> > enabled. Which is opposite of what is mentioned patch doing.
> > 
> > Konstantin, could you help us with this problem?

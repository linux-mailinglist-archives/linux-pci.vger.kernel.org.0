Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA724B921D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Feb 2022 21:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiBPUJ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Feb 2022 15:09:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiBPUJ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Feb 2022 15:09:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D4E24465E;
        Wed, 16 Feb 2022 12:09:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1533D619CF;
        Wed, 16 Feb 2022 20:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544A0C340E8;
        Wed, 16 Feb 2022 20:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645042184;
        bh=FZsG08s2jZREpEvg+n1BCb14zspDJP7SeZOU8KKwmPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aR9wl8EEQMY1ExwThfaFzqZhg+Dv1btyPtFNbk42KkY1o7OrEbkddH0NQcG0Jg9Ev
         MQZ+HmsS2fwdFuoMpCwDEIeOXdMW3L5l4WRcB0QeBp4ip/HIV+lYrTDFoD42vTQoy8
         /G8ZRI7l9HFaVTbe5YIV68Q8A04Fo0ECzOiIEATsGOKS7cQalq9ar9UtE0CX6bJ4QW
         dpv32IDntntkCvexnyXKUlCUkPV8xjyV46OQwSDAV/mumc++wr0FtJo01hIEft13vB
         q0nMIOAOw6dFU9DSia4vATTQm+Ne009bqaYZ8m5uZHLm/uS5xoiE1SsDr7cUK8LB9V
         vFO9WdLruLOWg==
Received: by pali.im (Postfix)
        id 023E37F4; Wed, 16 Feb 2022 21:09:40 +0100 (CET)
Date:   Wed, 16 Feb 2022 21:09:40 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bharat Bhushan <bbhushan2@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Wojciech Bartczak <wbartczak@marvell.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Issues with A3720 PCIe controller driver pci-aardvark.c
Message-ID: <20220216200940.fwdwk5rcb4zq6dyg@pali>
References: <20210723221710.wtztsrddudnxeoj3@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210723221710.wtztsrddudnxeoj3@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ Bharat, Veerasenareddy and Wojciech from Marvell

Hello! Could you please look at this email and help us with this Marvell HW issue?

On Saturday 24 July 2021 00:17:10 Pali Rohár wrote:
> Hello Konstantin!
> 
> There are issues with Marvell Armada 3720 PCIe controller when high
> performance PCIe card (e.g. WiFi AX) is connected to this SOC. Under
> heavy load PCIe controller sends fatal abort to CPU and kernel crash.
> 
> In Marvell Armada 3700 Functional Errata, Guidelines, and Restrictions
> document is described erratum 3.12 PCIe Completion Timeout (Ref #: 251)
> which may be relevant. But neither Bjorn, Thomas nor me were able to
> understood text of this erratum. And we have already spent lot of time
> on this erratum. My guess that is that in erratum itself are mistakes
> and there are missing some other important details.
> 
> Konstantin, are you able to understand this erratum? Or do you know
> somebody in Marvell who understand this erratum and can explain details
> to us? Or do you know some more details about this erratum?
> 
> Also it would be useful if you / Marvell could share text of this
> erratum with linux-pci people as currently it is available only on
> Marvell Customer Portal which requires registration with signed NDA.
> 
> In past Thomas wrote patch "according to this erratum" and I have
> rebased, rewritten and resent it to linux-pci mailing list for review:
> https://lore.kernel.org/linux-pci/20210624222621.4776-6-pali@kernel.org/
> 
> Similar patch is available also in kernel which is part of Marvell SDK.
> 
> Bjorn has objections for this patch as he thinks that bit DIS_ORD_CHK in
> that patch should be disabled. Seems that enabling this bit effectively
> disables PCIe strong ordering model. PCIe kernel drivers rely on PCIe
> strong ordering, so it would implicate that that bit should not be
> enabled. Which is opposite of what is mentioned patch doing.
> 
> Konstantin, could you help us with this problem?

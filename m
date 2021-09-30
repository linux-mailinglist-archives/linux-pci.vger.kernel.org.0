Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AB341E012
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 19:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352555AbhI3RYp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 13:24:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352459AbhI3RYo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 13:24:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B919613A0;
        Thu, 30 Sep 2021 17:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633022581;
        bh=9rag8usx11vrfz5n1Alc5CNlxdSu7yLNHJusXs6H3Xc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=smT4INWHGimM8VYsC/zVfp5QMujuZ5U21z40UH9cFM5G70cYo0d2lKW1axqmPFwHK
         ednwMaotuLnaClhXaxpoP0e43qc2gnvXfAoSltS7tmKX1wnMxutMJZyInXZ9oQe9PO
         WMSJJUTDb+GcvMDiKZnoUeotF/c021KEkYFZ7lsWtyAMhLQK0L3KjY25ce6PyXZlWy
         ykexidoxN/DmaHtSawowBwieM1XQwlvGiaHPW63tTlSBD1/M+Pq62kQsVruaiP22/N
         +yQQ6zqMPlT/5OSWAuqq8x1OwRG/YVzL09M/fYfc59mLMNcgd/nbzQJJztM5SpEjWk
         3IA6zqn6gfoIg==
Received: by pali.im (Postfix)
        id 7D7BEE79; Thu, 30 Sep 2021 19:22:59 +0200 (CEST)
Date:   Thu, 30 Sep 2021 19:22:59 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stefan Chulski <stefanc@marvell.com>
Cc:     Konstantin Porotchkin <kostap@marvell.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Issues with A3720 PCIe controller driver pci-aardvark.c
Message-ID: <20210930172259.gdz75oxz7doqrvna@pali>
References: <20210723221710.wtztsrddudnxeoj3@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210723221710.wtztsrddudnxeoj3@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Stefan! Could you please look at this email and help us with this issue?

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

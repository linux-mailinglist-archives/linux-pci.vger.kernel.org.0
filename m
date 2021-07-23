Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A623D42C0
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jul 2021 00:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhGWVgn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 17:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231940AbhGWVgm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Jul 2021 17:36:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7283F60EB4;
        Fri, 23 Jul 2021 22:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627078635;
        bh=bq4JdDIUwR2jdW1CIzrz8wTbXk1FyGIyb5cx66NndWY=;
        h=Date:From:To:Cc:Subject:From;
        b=tlTWopemPANHbd/9dEO+NBWCwg5KMoDp/6mTRW90N6VLr2phy52L4vmmc9Q3RphFT
         o8uMmVQAeC5W6K3PrEQpe8GAq2a6hZhHYSPY+7BJkhMx6zU3w+DFjdNistEAw7oac1
         XM0Lv5hdLl2N5g2X0zbHI3le10NVa5M8YBC8Djpnb34Rr7RFzypI26GXWkzeRg7Ly3
         QfHUKbZ0n8CuXEpARcxHE/8scEe/Oh0/csS7TOQ9wd5rzoP02AYhHYVLOIr2euUH/6
         yij5RLPFuI16NO8i9UBzPLVtGFLX889PIyLwcsMoCfSec2G4FJJh3OHhIF5+ZLeINz
         RVylMYdfAgg0A==
Received: by pali.im (Postfix)
        id EDCC0881; Sat, 24 Jul 2021 00:17:12 +0200 (CEST)
Date:   Sat, 24 Jul 2021 00:17:10 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Konstantin Porotchkin <kostap@marvell.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Issues with A3720 PCIe controller driver pci-aardvark.c
Message-ID: <20210723221710.wtztsrddudnxeoj3@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Konstantin!

There are issues with Marvell Armada 3720 PCIe controller when high
performance PCIe card (e.g. WiFi AX) is connected to this SOC. Under
heavy load PCIe controller sends fatal abort to CPU and kernel crash.

In Marvell Armada 3700 Functional Errata, Guidelines, and Restrictions
document is described erratum 3.12 PCIe Completion Timeout (Ref #: 251)
which may be relevant. But neither Bjorn, Thomas nor me were able to
understood text of this erratum. And we have already spent lot of time
on this erratum. My guess that is that in erratum itself are mistakes
and there are missing some other important details.

Konstantin, are you able to understand this erratum? Or do you know
somebody in Marvell who understand this erratum and can explain details
to us? Or do you know some more details about this erratum?

Also it would be useful if you / Marvell could share text of this
erratum with linux-pci people as currently it is available only on
Marvell Customer Portal which requires registration with signed NDA.

In past Thomas wrote patch "according to this erratum" and I have
rebased, rewritten and resent it to linux-pci mailing list for review:
https://lore.kernel.org/linux-pci/20210624222621.4776-6-pali@kernel.org/

Similar patch is available also in kernel which is part of Marvell SDK.

Bjorn has objections for this patch as he thinks that bit DIS_ORD_CHK in
that patch should be disabled. Seems that enabling this bit effectively
disables PCIe strong ordering model. PCIe kernel drivers rely on PCIe
strong ordering, so it would implicate that that bit should not be
enabled. Which is opposite of what is mentioned patch doing.

Konstantin, could you help us with this problem?

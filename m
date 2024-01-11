Return-Path: <linux-pci+bounces-2056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8109882B05F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 15:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916A31C2107A
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 14:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282D33C46F;
	Thu, 11 Jan 2024 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="iGT8QY7r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B253B198
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202401111413418d12d14e4f58e46eb4
        for <linux-pci@vger.kernel.org>;
        Thu, 11 Jan 2024 15:13:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=d8P5SF5niklck9uG6u8e0iLUYDzwhhYqU5LhoJl31Ws=;
 b=iGT8QY7rW2ewIQSYYXQwZwhs3xejTEGZKgyOHU0CF2n0zQth5OiZS9aRsuVfNsV9wzViKh
 ewJ+DYgDzwBgowFFoLnCeJ34qkh2YAkQtlbi3k4DkBNCe0GhxQ/Ukb+8voumQC5AbJ5j7j+V
 BlAc7SvPkzvRwFXp9pRVJBTWvVBmg=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	linux-phy@lists.infradead.org,
	tjoseph@cadence.com,
	linux-pci@vger.kernel.org,
	ylal@codeaurora.org,
	gregkh@linuxfoundation.org,
	regressions@lists.linux.dev
Cc: diogo.ivo@siemens.com,
	jan.kiszka@siemens.com
Subject: [REGRESSION] Keystone PCI driver probing and SerDes PLL timeout
Date: Thu, 11 Jan 2024 14:13:30 +0000
Message-ID: <20240111141331.3715265-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Hello,

When testing the IOT2050 Advanced M.2 platform with Linux CIP 6.1
we came across a breakage in the probing of the Keystone PCI driver
(drivers/phy/ti/pci-keystone.c). This probing was working correctly
in the previous version we were using, v5.10.

In order to debug this we changed over to mainline Linux and bissecting
lead us to find that commit e611f8cd8717 is the culprit, and with it applied
we get the following messages:

[   10.954597] phy-am654 910000.serdes: Failed to enable PLL
[   10.960153] phy phy-910000.serdes.3: phy poweron failed --> -110
[   10.967485] keystone-pcie 5500000.pcie: failed to enable phy
[   10.973560] keystone-pcie: probe of 5500000.pcie failed with error -110

This timeout is occuring in serdes_am654_enable_pll(), called from the 
phy_ops .power_on() hook.

Due to the nature of the error messages and the contents of the commit we
believe that this is due to an unidentified race condition in the probing of
the Keystone PCI driver when enabling the PHY PLLs, since changes in the
workqueue the deferred probing runs on should not affect if probing works
or not. To further support the existence of a race condition, commit
86bfbb7ce4f6 (a scheduler commit) fixes probing, most likely unintentionally
meaning that the problem may arise in the future again.

One possible explanation is that there are pre-requisites for enabling the PLL
that are not being met when e611f8cd8717 is applied; to see if this is the case
help from people more familiar with the hardware details would be useful.

As official support specifically for the IOT2050 Advanced M.2 platform was
introduced in Linux v6.3 (so in the middle of the commits mentioned above)
all of our testing was done with the latest mainline DeviceTree with [1]
applied on top.

This is being reported as a regression even though technically things are
working with the current state of mainline since we believe the current fix
to be an unintended by-product of other work.

#regzbot introduced: e611f8cd8717

[1]: https://lore.kernel.org/all/cover.1699087938.git.jan.kiszka@siemens.com/


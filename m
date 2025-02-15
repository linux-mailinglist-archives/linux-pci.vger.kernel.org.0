Return-Path: <linux-pci+bounces-21533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB984A36942
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 01:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12EF27A2EFB
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 00:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA66623;
	Sat, 15 Feb 2025 00:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLWwr8Ak"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148374314B;
	Sat, 15 Feb 2025 00:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577787; cv=none; b=ZdwOQxKXR3f2Wg9u5wMNitAIgMdmfsuddlVy6/uY38zqB4f9Yz1a4V5ouggKLRVgGV0i2BglPnapwOlw8cIB5AIIC6FzGXpE4Hp1o2amYwIUwaiR6HgUlKWoa+BGh6jHQAuKMcIA/KoRwDVUP3PW7l4kuRRMoUWqmTbPYgcXVwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577787; c=relaxed/simple;
	bh=iW+MrykrbylejRiXBKBgkl6Powy5HIH+S5gFCuZLyVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=L6zkvOScdglOGxPAnqTImojCmcS/pSXgk01cd9P0GnN4KGWJ/+tdnx2Sc7p//jl3KRueHl4d3MTF2AZvPE3O1GwK9Qj4w1NI4d3JMZwGsTWQPaoE9Ev2Z/Y3M5kYMH2xuu4tDJLxutga/sbNR4yoKggy6WxAotqYEEKMrPC89Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLWwr8Ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D330C4CED1;
	Sat, 15 Feb 2025 00:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739577785;
	bh=iW+MrykrbylejRiXBKBgkl6Powy5HIH+S5gFCuZLyVs=;
	h=From:To:Cc:Subject:Date:From;
	b=TLWwr8Ak+yHpQXmV8oiHcRD+47G1BLf07aoQVkikjMA72aBAwkZJITIQ+jcFTdmfA
	 /RG8icY28pYhn1QOZfTqROOQRSGpDzBXcFmSoFwYot7M53hHcvIcA/rDz69K/zZrp5
	 JwcPtgYm1XadasqBmQmX74FLT2MklAB3gBJm00LECDippkJmOkWYugqNsRMgkyrnDk
	 MLNoUpK58pPMdyKFtaKa4ZRo+lsth8/Vw6xuUtwXq21y+n3aO8FGy3IpCJEAGtQ2O4
	 dlUaXL+pp4+qyIgAd0da8K3ZubyRqG0M6elI9PzrTaaYPIQMPG3RIXmZmtTTPE1g3t
	 VE6naDRcodJyg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/2] PCI: Avoid capability searches in save/restore state
Date: Fri, 14 Feb 2025 18:02:59 -0600
Message-Id: <20250215000301.175097-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Reduce the number of times we search config space for PCI capabilities when
saving and restoring device state.

Bjorn Helgaas (2):
  PCI: Avoid pointless capability searches
  PCI: Cache offset of Resizable BAR capability

 drivers/pci/pci.c       | 36 +++++++++++++++++++++---------------
 drivers/pci/pci.h       |  1 +
 drivers/pci/pcie/aspm.c | 15 ++++++++-------
 drivers/pci/probe.c     |  1 +
 include/linux/pci.h     |  1 +
 5 files changed, 32 insertions(+), 22 deletions(-)

v2 changes:
  - Drop VC change that broke saving state (thanks, Ilpo)

v1: https://lore.kernel.org/r/20250208050329.1092214-1-helgaas@kernel.org

-- 
2.34.1



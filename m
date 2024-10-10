Return-Path: <linux-pci+bounces-14135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87975997CD5
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C45D1C222D6
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 06:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FD81A01BE;
	Thu, 10 Oct 2024 06:11:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EA919ABD8;
	Thu, 10 Oct 2024 06:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728540677; cv=none; b=eimsiVhxR64t4DZ6z8YanNGrwTB2G6LXH6ltoUoZV1gYoxJlKkiPWkmu6N9iCk7Yoi5+GZtJHL7tBAJ2tzPez6oCApkqzqSp7tkKvm0PlPVFOLxMZaBCWHLS1V37hDLgnQzedBv0zoZihnYt4VLL3Nu4Ymg+74v5GPvAs/+Os7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728540677; c=relaxed/simple;
	bh=zdDSlWIVp+0RqFGuz/t8Xe3qKegz57MXBjABF3Guqhc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=g8iSrHnhakoRUNXUVqmH3LGqRnIo0a4kbdacpljbbi3Bf8zLZEWfLK3SJd28LYQxvMByDTLnReFMBt9T/ZrewJRO6JOkqvyJCJFLGytOU6D45bAlHWIEEhxhHXD/K9pPF10gusRHjrh6OreFD6KiOW0xtq5R/CgrQNfSMnA9WkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BA2281A175D;
	Thu, 10 Oct 2024 08:11:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 88EED1A28B1;
	Thu, 10 Oct 2024 08:11:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 05EDC1846660;
	Thu, 10 Oct 2024 14:11:12 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	frank.li@nxp.com,
	robh@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 0/2] Bug fixes when generic suspend/resume functions are used
Date: Thu, 10 Oct 2024 13:47:47 +0800
Message-Id: <1728539269-1861-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Two bug fixes when dwc generic suspend/resume callbacks are used.

The patch #1 is issued before, but it's not applied yet refer to [1].
Combine these two bug fixes into one series and send here.

[1] https://patchwork.kernel.org/project/linux-pci/patch/1721628913-1449-1-git-send-email-hongxing.zhu@nxp.com/

v2 changes:
Thanks for Manivannan's review.
- Refine the subject of second patch and add
  "Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>"
- In first patch, update the commit message and move one comment into
  proper place.
  BTW, Manivannan found another potential issue that suspend is entry but
  the link is in L1SS stat in v1 review. This is a new story. And it's better
  to be verified and fixed by another commit later.

[PATCH v2 1/2] PCI: dwc: Fix resume failure if no EP is connected on
[PATCH v2 2/2] PCI: dwc: Always stop link in the

drivers/pci/controller/dwc/pcie-designware-host.c | 31 ++++++++++++++++---------------
1 file changed, 16 insertions(+), 15 deletions(-)


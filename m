Return-Path: <linux-pci+bounces-13486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 522B09852C4
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 08:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D4E1F21105
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 06:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C38155303;
	Wed, 25 Sep 2024 06:11:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1182AE6C;
	Wed, 25 Sep 2024 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727244681; cv=none; b=txtLpjAVDAg3pVfe+G+1S229hUkYd6bQmcmN8DdREQCrFHHpYKiT34zSocSEsqQz4RBq7AVGlh3T667dN8nUj/2C3sXKR9lDjdW0SuVkf6+3E/Ne5BL23t80ljWUkfIJDIeSxiGyZdyoOm7rYFLeQ11sysC65CbTp0vGQPR0n0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727244681; c=relaxed/simple;
	bh=baM9HjeqwvVdEQ+R+/2xqWkWEJPW7mlAMefzFNiLkEE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=D3CB1DX8MT6T/q3GQ7Fz9t5Luly22P/mSDXqg+5Tfts0seK/yzhnWwnC8IhCqnY4tSbcd2VvhH/sK4SES5FtP2IxbCVDbUlTn3J+9TQMeuyOCw07p+o7v5lMq8q0EJjhn+Kul39zi/WEVjtjncwVRRy6sTVfd3VDUmjhI7pR8bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 31E6C20059A;
	Wed, 25 Sep 2024 08:11:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BDEB8201FF5;
	Wed, 25 Sep 2024 08:11:11 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B51EE183AD44;
	Wed, 25 Sep 2024 14:11:09 +0800 (+08)
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
Subject: [PATCH v1 0/2] Bug fixes when dwc generic suspend/resume functions are used
Date: Wed, 25 Sep 2024 13:48:35 +0800
Message-Id: <1727243317-15729-1-git-send-email-hongxing.zhu@nxp.com>
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

[PATCH v1 1/2] PCI: dwc: Fix resume failure if no EP is connected on
[PATCH v1 2/2] PCI: dwc: Do stop link in the dw_pcie_suspend_noirq

drivers/pci/controller/dwc/pcie-designware-host.c | 31 ++++++++++++++++---------------
1 file changed, 16 insertions(+), 15 deletions(-)



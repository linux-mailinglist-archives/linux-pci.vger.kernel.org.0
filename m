Return-Path: <linux-pci+bounces-22351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE16AA443CD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 16:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056A63A59CB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 14:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E1221ABAF;
	Tue, 25 Feb 2025 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWEIy07g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F4121ABD3
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495437; cv=none; b=deS0pjrQKCZwz0Z5tDEv1MEsAGMsQJHdswUqAL5nxvsxNOIZoXXdnlZgTSGe3e0KlNe1GyKQiDrjqKKzx74WyLamSbmRzJmm0eceARm9n0tqxFVutmd/2+ewpxZXNYcr1+2TJyM5OY8+FtwuZOW1dcDYcgEnnonulhPLAozVs6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495437; c=relaxed/simple;
	bh=8/fxHy0dn4u8BOt5ffA3rD0pB83XVye2ACOK9BDup7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EiU7rJ10sH7gDLKLbv4LTMB32b05W6dfWuxJ7iFhxMZ8B5iqLSAyM/xxXpJY7p0mvP5RglS7kvnH9oufhgdzWrSDgOMa4tlG+oAYOlYF+BZooTUGGhRXx44rrxcOirravIF2aVosdUcGwps1wtoYmIVjTCqO9veAaZxIygPaBIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWEIy07g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D09C4CEE6;
	Tue, 25 Feb 2025 14:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740495435;
	bh=8/fxHy0dn4u8BOt5ffA3rD0pB83XVye2ACOK9BDup7k=;
	h=From:To:Cc:Subject:Date:From;
	b=FWEIy07g/UgGXRJbMFabXu0rNJpCpwUc/GOGZG0Fb9x4j5EAlNeikw97l3C6+tiN3
	 lY0mY9RTIjESVaPZLcBvDQ7n4rHPNqI/tb5SL5cLiwX96BrVqe2GtUXyOTsSgtwzvX
	 iTOSsRe1YYJhe1uRzNcHwrN1l98OIcQI2z3ssPAQJW+3r7JTwrs3nZPNPZAMDe+fRX
	 syvZZMyWiXWpaYsFRwSY+yTreCW+pj1u95vBtWqLG52O2uFZf0xbL3RtFRt67RSvZd
	 nRYgNpqjNETmuiTU/2XsMllDZ4MXug/hrHOpBAeU1Tf2KO4IFk//I5njP+P7PQpehI
	 1I+fCV6+D2Y2Q==
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: dwc: Add rockchip to the RAS DES allowed vendor list
Date: Tue, 25 Feb 2025 15:56:58 +0100
Message-ID: <20250225145657.944925-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=cassel@kernel.org; h=from:subject; bh=8/fxHy0dn4u8BOt5ffA3rD0pB83XVye2ACOK9BDup7k=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNL33rJk+9y5e39v9377Ko21xZs4ve1qnJNOlBd9vu7ne lJO/NK2jlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzkmhIjw4QNdbIHraz8w+59 2dpgc2yCdGPQqe0fIl0DCvY7bOYoDWRk6GU4/Eo/6ur+VftZDx2zP/i4fpPG3Em3d9psvWpwb9E NKW4A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add PCI_VENDOR_ID_ROCKCHIP to the list of RAS DES vendor specific ids.

Tested using the RAS DES DWC debugfs changes that was merged recently.

drivers/perf/dwc_pcie_pmu.c driver has not been tested, but considering
RAS DES works in DWC debugfs, I see no reason why RAS DES shouldn't work
in drivers/perf/dwc_pcie_pmu.c.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Note: this depends on DWC debugfs patches that are queued up in branch
      controller/dwc and the PCI_VENDOR_ID_ROCKCHIP patch on branch
      controller/rockchip.

 include/linux/pcie-dwc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
index 6436e7fadc75..15d27a509769 100644
--- a/include/linux/pcie-dwc.h
+++ b/include/linux/pcie-dwc.h
@@ -28,6 +28,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{ .vendor_id = PCI_VENDOR_ID_QCOM,
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_ROCKCHIP,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{ .vendor_id = PCI_VENDOR_ID_SAMSUNG,
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{} /* terminator */
-- 
2.48.1



Return-Path: <linux-pci+bounces-24614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A8CA6E9EE
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 07:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C392316B481
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 06:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDADC1F4C83;
	Tue, 25 Mar 2025 06:58:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBE21FDE2B;
	Tue, 25 Mar 2025 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742885881; cv=none; b=sfgM01nS5BgDkXxPV3HNJIdxiSMt7j1MrLH3VaxCF/CQcwprnDiTfIjwe9mAxAG5hJe2qE4C6+GGIBFFqA1LpLa3A2VkNtRZIXEIjeOBXtIisigXXLQ3K0tafTEiz+kzA3aJwmZhElJ2D4Eu30mFUd/Tw0avuLhPcCfJ0QBaa4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742885881; c=relaxed/simple;
	bh=IqmayMFbaRwfa6pOBja6MsbI3Ce21MRioKUeoVKU8zI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aGNrnay1y6cttJyYxdV04NRWEZ3EokHM/vjxs4jynODqKrmPMHotNJjtGpd2fSPGHcpNcAXQOFuDGz7W5pz/V9LeURwzIxMSoGKFrBGCwT+MTtVj+iaTQo2raLpEf5nI7JNRYQS++T6JxsKpju4dTJA6JuA7rLONzMSvNFcCNsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: bizesmtp85t1742885851te2pfnrf
X-QQ-Originating-IP: sjFDA/nHGtsSLioS6p2O0oBNw02XrOBVBE+trc+Mp3I=
Received: from localhost.localdomain ( [103.233.162.252])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Mar 2025 14:57:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4388623427805967701
From: Yibo Dong <dong100@mucse.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Dong <dong100@mucse.com>
Subject: [PATCH] PCI: Add MUCSE vendor ID to pci_ids.h
Date: Tue, 25 Mar 2025 14:57:18 +0800
Message-Id: <20250325065718.333301-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NTHY/YkN8c+x8xr/rvf5Bm4wCgCJCv9en+3UN/p8ZfCGP0Z8PSUS5ivv
	XEet8FMx0fe72nGfQNgNgKpj26zmaO3++k53b0DlZaAg1Cz0UQI4HjL8hc0pI4ps9sWCZT+
	Gx9p6DPMIAFfF7LPPc6Rkx5m7j29Zcmi7xNN3cX6NclCh+GbFZD7iij7Pc4C/bk+NzVxY2J
	fpFzInqmxSTR2v0+vRALg3wOpXQiWZwLKkYgrckbvu+6W0Bu9UdJynXSW2wtRYLZ7D481PD
	wdpQfagvshRi/4utmXA1JEyzlIB/++4NUw5T+E86zfvdis6S3l01n0vUrDFxo9qx7W81peV
	PjSIMln9GP9FgHh1DwuJYUefPbrPh8TKyDZFPR6VnzmZPAd7fo1q+0UgxntBwYEpkWpFASu
	PF6tauibCg8RHvUWCj1sxsa6VUe6pxBpbzllryR3RtacQQhpKswRlAkVsNnvGb9XoSxybJi
	EtDwL3lfjIk3k+MOP74GAacoXr4FWF5h41f3Zn9oWE8/vfCrTA2MrM2yHRxtjeMVBfaSyXC
	B4TUBdzDyx5FMVL5iStrwRe+62jUx8o+cO7XV+ZAFBVVjm/iYZS4wTNiWiNzv1uLB+B2cs8
	YNhjfLhbk+NVIDzm5n808LAH9BMn6BG0bds0mcbXCUhbyx00mGFhDty7pcIbPYqcXkrX5BW
	i1bcfMmLiVjnvQdhkdW5d2IpTvkolPZe2DT9u0oQMLNTIPkjxwrew/PpkbY5U2M3uMdGqYp
	4ntF9MaATLCTDrXaQh0MqE0IkG+XJpHUycgweVReS7j+h8RripQAiLAA5nFtxTRAN8wmsnY
	gg0gzf53kPNr1f1NoAEb8VOcue+1lCMG44MvrbjXwzLuNfLc0MGCEYdLYuXMwf31v3wBy0N
	JbINqJlrPuYUsq/KMlQbdDbueAoTwKQbiQU1L37q25DNc1CLAD7sCwbWrOUV/GZSuANKi5S
	cDQ2VU9VASKu4SA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Add MUCSE as a vendor ID (0x8848) for PCI devices so we can use
the macro for future drivers.

Signed-off-by: Yibo Dong <dong100@mucse.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index de5deb1a0118..f1b4c61c6d3c 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3143,6 +3143,8 @@
 #define PCI_VENDOR_ID_SCALEMP		0x8686
 #define PCI_DEVICE_ID_SCALEMP_VSMP_CTL	0x1010
 
+#define PCI_VENDOR_ID_MUCSE		0x8848
+
 #define PCI_VENDOR_ID_COMPUTONE		0x8e0e
 #define PCI_DEVICE_ID_COMPUTONE_PG	0x0302
 #define PCI_SUBVENDOR_ID_COMPUTONE	0x8e0e
-- 
2.25.1



Return-Path: <linux-pci+bounces-1134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D7B81652F
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 04:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B42F1F219D6
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 03:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AF123DE;
	Mon, 18 Dec 2023 03:04:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC03C0C
	for <linux-pci@vger.kernel.org>; Mon, 18 Dec 2023 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1702868675-1eb14e538d375e0001-0c9NHn
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id l2Uw6D7LSDFlAqTa (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 18 Dec 2023 11:04:35 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Dec
 2023 11:04:35 +0800
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Dec
 2023 11:04:32 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
CC: <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>,
	<LeoLiu@zhaoxin.com>, LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH v2 0/3] Parse the HEST PCIe AER and set to relevant registers
Date: Mon, 18 Dec 2023 11:04:27 +0800
X-ASG-Orig-Subj: [PATCH v2 0/3] Parse the HEST PCIe AER and set to relevant registers
Message-ID: <20231218030430.783495-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115091612.580685-1-LeoLiu-oc@zhaoxin.com>
References: <20231115091612.580685-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1702868675
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1278
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.118228
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

According to the Section 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI SPEC
r6.5, the register value form HEST PCI Express AER Structure should be
written to relevant PCIe Device's AER Capabilities.So the purpose of the
patch set is to extract register value from HEST PCI Express AER
structures and program them into PCIe Device's AER registers. Refer to the
ACPI SPEC r6.5 for the more detailed description. This patch is an
effective supplement to _HPP/_HPX method when the Firmware does not
support the _HPP/_HPX method and can be specially configured for the AER
register of the specific device.

---

v1->v2:
- Move the definition of structure "hest_parse_aer_info" to file apei.h.

LeoLiuoc (3):
  ACPI/APEI: Add hest_parse_pcie_aer()
  PCI: Add AER bits #defines for PCIe to PCI/PCI-X Bridge
  PCI/ACPI: Add pci_acpi_program_hest_aer_params()

 drivers/acpi/apei/hest.c      | 69 +++++++++++++++++++++++-
 drivers/pci/pci-acpi.c        | 98 +++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |  9 ++++
 drivers/pci/probe.c           |  1 +
 include/acpi/apei.h           | 17 ++++++
 include/uapi/linux/pci_regs.h |  3 ++
 6 files changed, 195 insertions(+), 2 deletions(-)

-- 
2.34.1



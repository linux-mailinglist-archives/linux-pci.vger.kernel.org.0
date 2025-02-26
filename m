Return-Path: <linux-pci+bounces-22480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD7DA4707E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 01:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82EF516D3D0
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 00:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906712837A;
	Thu, 27 Feb 2025 00:48:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163EC7462
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 00:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740617311; cv=none; b=qGDUZChIo2Lc78BArrKUcQi/Lp21WFOL5C25fjzgBrbiH6CxMywWcr7dRzaznBMub2lj3elQYh4QDDiNtn8PaUDbfM8iEDk6Ky2cUQTe5YUVRfcDKImjKgK+jF2eE5xTW+zpvabixhN8xz72VJcWKu37iLtTG6UHX7yu2kIPES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740617311; c=relaxed/simple;
	bh=qF5gZmW0JLCR9LhRYrfGiGmhHEed336IGVYFp0nZRuY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PyN07uwbrNIgPcmlnH/Bi4ekydEzhiqtiMfWkVJZhcVLSNL2gnGBN9OpHhYwra7RYp6dqvgZEmggtuTp/7TPhEnsDSp4p3fkeEjaSbc/+R+ETxIseOmAxuss52lfiyu9Dk7ruFtOw6jdwoa2RZQOuR1NOW6oCo6n+BeTdML5Ggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1740616658-1eb14e79fd31330001-0c9NHn
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id ymFLplNQY0D8ibWL (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 27 Feb 2025 08:37:38 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 27 Feb
 2025 08:37:38 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::4dfc:4f6a:c0cf:4298]) by
 ZXSHMBX2.zhaoxin.com ([fe80::4dfc:4f6a:c0cf:4298%4]) with mapi id
 15.01.2507.044; Thu, 27 Feb 2025 08:37:38 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 26 Feb
 2025 20:18:39 +0800
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <yazen.ghannam@amd.com>, <avadhut.naik@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <acpica-devel@lists.linux.dev>
CC: <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>,
	<leoliu@zhaoxin.com>, LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH v5 0/4] Parse the HEST PCIe AER and set to relevant registers
Date: Wed, 26 Feb 2025 20:18:34 +0800
X-ASG-Orig-Subj: [PATCH v5 0/4] Parse the HEST PCIe AER and set to relevant registers
Message-ID: <20250226121838.364533-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 2/27/2025 8:37:31 AM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1740616658
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1962
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.137756
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

According to the Section 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI SPEC r6.5,
the register value form HEST PCI Express AER Structure should be written to
relevant PCIe Device's AER Capabilities. So the purpose of the patch set is
to extract register value from HEST PCI Express AER structures and program
them into PCIe Device's AER registers. Refer to the ACPI SPEC r6.5 for the
more detailed description.

Changes in v2:
- Move the definition of structure "hest_parse_aer_info" to file apei.h.
- Link to v1: https://lore.kernel.org/all/20231115091612.580685-1-LeoLiu-oc=
@zhaoxin.com/

Changes in v3:
- The applicable hardware for this patch is added to the commit
  information.
- Change the function name "program_hest_aer_endpoint" to
  "program_hest_aer_common".
- Add the comment to function "program_hest_aer_common".
- Remove the "PCI_EXP_TYPE_PCIE_BRIDGE" branch handling in function
  "program_hest_aer_params".
- Link to v2: https://lore.kernel.org/all/20231218030430.783495-1-LeoLiu-oc=
@zhaoxin.com/

Changes in v4:
- Fix some compilation warnings.
- Link to v3: https://lore.kernel.org/all/20240718062405.30571-1-LeoLiu-oc@=
zhaoxin.com/

Changes in v5:
- Optimize the code according to the suggestions.
- Link to v4: https://lore.kernel.org/all/20241205114048.60291-1-LeoLiu-oc@=
zhaoxin.com/

LeoLiuoc (4):
  ACPI: APEI: Move apei_hest_parse() to apei.h
  ACPI: APEI: Add new hest_parse_pcie_aer()
  PCI: Add AER bits #defines for PCIe to PCI/PCI-X Bridge
  PCI: ACPI: Add new pci_acpi_program_hest_aer_params()

 drivers/acpi/apei/hest.c      | 54 ++++++++++++++++++++-
 drivers/pci/pci-acpi.c        | 90 +++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |  6 +++
 drivers/pci/probe.c           |  1 +
 include/acpi/apei.h           | 13 +++++
 include/uapi/linux/pci_regs.h |  4 ++
 6 files changed, 166 insertions(+), 2 deletions(-)

--=20
2.34.1



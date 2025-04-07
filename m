Return-Path: <linux-pci+bounces-25353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAA0A7D1EA
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 04:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BB73ABECA
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 02:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D21F212D97;
	Mon,  7 Apr 2025 02:07:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182FF212D6A
	for <linux-pci@vger.kernel.org>; Mon,  7 Apr 2025 02:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743991645; cv=none; b=gXcQV4C6auZQ5NVPhAC13x/4CmQLmXYZRsL/c6MaprScVd393BCA+5PCNqIPVtirZIaX/reBEEKiIWVpC4si3Ml5KhY7rlg9XTGX06DzPCjQXksnAtenLC+f5g9F+CeEIvrVxp0tV+VZI/hpE4LSu/JWh6SIom9oxjnv1kvNe/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743991645; c=relaxed/simple;
	bh=TTpNxi60rOS9cwxZpQdBYdmkZyVazYfR2C92mh+98r8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KYRBoZnBrVSBwrzuaH0f0G9qKxZvju2MIZGpUrJ74YkdcUXjDOysuPWMe2xE8AK9aMNT9m4cbb43pOfALnwff3LdJwCD26hkIIrOAUPGIOSl8d9ifMKwlXDxYOsQ3zUgEAtmkk+Rut4QhpVCxdIVUhhzqFpfbnKl5UzOIrBWWEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1743991630-1eb14e119c07020001-0c9NHn
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id 11kl4D0J42PEHCEC (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 07 Apr 2025 10:07:10 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX3.zhaoxin.com (10.28.252.165) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Mon, 7 Apr
 2025 10:07:10 +0800
Received: from ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2]) by
 ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2%6]) with mapi id
 15.01.2507.044; Mon, 7 Apr 2025 10:07:10 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 7 Apr
 2025 10:05:58 +0800
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <yazen.ghannam@amd.com>, <avadhut.naik@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <acpica-devel@lists.linux.dev>
CC: <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>,
	<leoliu@zhaoxin.com>, LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH v6 0/4]  Parse the HEST PCIe AER and set to relevant registers
Date: Mon, 7 Apr 2025 10:05:53 +0800
X-ASG-Orig-Subj: [PATCH v6 0/4]  Parse the HEST PCIe AER and set to relevant registers
Message-ID: <20250407020557.1225166-1-LeoLiu-oc@zhaoxin.com>
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
X-Moderation-Data: 4/7/2025 10:07:08 AM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1743991630
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2157
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.139598
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

Changes in v6:
- Fix the issue that the first patch in the patch set fails to compile indi=
vidually.
- Link to v5: https://lore.kernel.org/all/20250226121838.364533-1-LeoLiu-oc=
@zhaoxin.com/

LeoLiuoc (4):
  ACPI: APEI: Move apei_hest_parse() to apei.h
  ACPI: APEI: Add new hest_parse_pcie_aer()
  PCI: Add AER bits #defines for PCIe to PCI/PCI-X Bridge
  PCI: ACPI: Add new pci_acpi_program_hest_aer_params()

 drivers/acpi/apei/hest.c      | 54 ++++++++++++++++++++-
 drivers/pci/pci-acpi.c        | 88 +++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |  6 +++
 drivers/pci/probe.c           |  1 +
 include/acpi/apei.h           | 13 ++++++
 include/uapi/linux/pci_regs.h |  3 ++
 6 files changed, 163 insertions(+), 2 deletions(-)

--=20
2.34.1



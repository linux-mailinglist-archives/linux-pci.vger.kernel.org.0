Return-Path: <linux-pci+bounces-17821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEAA9E62DE
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 02:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFE22814D1
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 01:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D7D13A27D;
	Fri,  6 Dec 2024 01:01:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F977112
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 01:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446874; cv=none; b=fpJ0mbIbDCf63mdpk+h6gGFCtL+19byrx9Mm/xo1ARn8gwobsrzU3jMsL/VLr3Oxk/DoK8yvuOhVbDRyUHMj2XmQsyhoUMGaiEg+AfjUoPqZb2bm6DqFWWvVosr+ZWbOxCzVinnNstIf4Cv+bxzvQu1uZZmagNKEZ+Uw/2JaOUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446874; c=relaxed/simple;
	bh=varYe/nsgd0jqbA8BxodQaB5K8QTJcOOiIbwkknH2VY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bcGinmitjmClIMbLEJxTeJqEg0VQpshxVLV91TTtRa9VKt5Fr2FPW712/lA0dLR1DrvT9HSCk+M8FT/xtcjwlj4Bu+Fs2yIlpjsaqS3oor7iHkh0BSN9MBY888eVE1Sod/XFnJxtp6lpdzsScCCXOyh307vgDSP7x0U1h5JR7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1733446117-086e2312d5235a0001-0c9NHn
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id bQJAFLG4DCETpKhv (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 06 Dec 2024 08:48:37 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 6 Dec
 2024 08:48:36 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264]) by
 ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264%7]) with mapi id
 15.01.2507.039; Fri, 6 Dec 2024 08:48:36 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 19:40:48 +0800
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <avadhut.naik@amd.com>, <yazen.ghannam@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <acpica-devel@lists.linux.dev>
CC: <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>,
	<LeoLiu-oc@zhaoxin.com>
Subject: [PATCH v4 0/3] Parse the HEST PCIe AER and set to relevant registers
Date: Thu, 5 Dec 2024 19:40:45 +0800
X-ASG-Orig-Subj: [PATCH v4 0/3] Parse the HEST PCIe AER and set to relevant registers
Message-ID: <20241205114048.60291-1-LeoLiu-oc@zhaoxin.com>
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
X-Moderation-Data: 12/6/2024 8:48:35 AM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1733446117
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1755
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.134151
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

LeoLiuoc (3):
  ACPI/APEI: Add hest_parse_pcie_aer()
  PCI: Add AER bits #defines for PCIe to PCI/PCI-X Bridge
  PCI/ACPI: Add pci_acpi_program_hest_aer_params()

 drivers/acpi/apei/hest.c      |  77 ++++++++++++++++++++++++-
 drivers/pci/pci-acpi.c        | 103 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |   9 +++
 drivers/pci/probe.c           |   1 +
 include/acpi/apei.h           |  17 ++++++
 include/uapi/linux/pci_regs.h |   3 +
 6 files changed, 208 insertions(+), 2 deletions(-)

--=20
2.34.1



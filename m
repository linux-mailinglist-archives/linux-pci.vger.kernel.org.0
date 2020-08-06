Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAF223E3AA
	for <lists+linux-pci@lfdr.de>; Thu,  6 Aug 2020 23:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgHFV6A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Aug 2020 17:58:00 -0400
Received: from mail-dm6nam10on2136.outbound.protection.outlook.com ([40.107.93.136]:4449
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725272AbgHFV57 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Aug 2020 17:57:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rn0CWI6fW2UVj7bmSnHRyvIc6oieuJz9T2oGNwWjdrdAcZ8lTdkUEpentwPOtIylXZUUAGI4MbyrTkdVpkEAC8litX/dPsr0FwkhtE3Unp5LIvFnKxwy9cAFmgaoxMGtghBvnvilBDnQfCko4tfj6z/mq9X6NuH+w3HAXt1yKLTAfZ66QFp9cElhUWOkoWXFkG7kkZuFp4d+52JbZx1eXDelKPrHPOM70YPfvrooQqDDFetDcT0uP+ojVin6LPuig34DTnIQnMywq64omMreNfxXsFurnNRnaCVytas8z6jJYdFST8WNGS3DktDC49dm5V63iqzbcTItTWuuW7hJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIfwYrYDzIWceZfK2gzbHqPrxAG7Rqcb8WQWvEMOmBU=;
 b=Dhb8hTgBAn4RqYPXA/Jx+PGiBnaSBxU5zVLbGWwEUVLr7RWGqOO6oYfx2dcpYdJfaUreA9NwyJE9J/H2JdQtnT6sSGofQyr4WD5Ni8AB9JwIShItg0NnMrW62Kc5rT49pvX7YkHNdLxKXMMWPmbq9QleMwfU/2LNizsl6O96JXHHXQuFYJySSBvuJt3NX2yEIfvX4TBa8jGklk2+CpQDjIYBihwgivE86Hh0ezYxneDdtQ7dqE13VQU6j+4oNzxiDseNnZ0tckA912MVi4XsdVUSM80RksYo8vtluhn3RuBRp9ZR+8YobKQmV61fzxK6G5N4/XY3XahxnwyOIHQyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIfwYrYDzIWceZfK2gzbHqPrxAG7Rqcb8WQWvEMOmBU=;
 b=BCikZEcMu0uZU8njLqG1q4HEl+MbO9K7I047jbUlb0oNddlieg1xWQnHRAQ9hk9W6KqRW/tIebmigVgEImboC+iOEQ+bMVD/KYR4JZNDTW4zL79WSJMhnv/PWMPDY3xnlzkXB+yPtiYmBN8xvsao0fkdrtT4m+bjQbuIOIIC8cw=
Authentication-Results: amperecomputing.com; dkim=none (message not signed)
 header.d=none;amperecomputing.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB4997.prod.exchangelabs.com (2603:10b6:a03:7d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Thu, 6 Aug 2020 21:57:52 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::5c26:c6ca:c444:e947]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::5c26:c6ca:c444:e947%3]) with mapi id 15.20.3239.021; Thu, 6 Aug 2020
 21:57:52 +0000
From:   Tuan Phan <tuanphan@os.amperecomputing.com>
To:     patches@amperecomputing.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/ACPI: Add Ampere Altra SOC MCFG quirk
Date:   Thu,  6 Aug 2020 14:57:34 -0700
Message-Id: <1596751055-12316-1-git-send-email-tuanphan@os.amperecomputing.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aptiov-dev-Latitude-E7470.amperecomputing.com (4.28.12.214) by BY5PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:1e0::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3261.18 via Frontend Transport; Thu, 6 Aug 2020 21:57:51 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [4.28.12.214]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcf446a2-577a-4f97-2f40-08d83a53c427
X-MS-TrafficTypeDiagnostic: BYAPR01MB4997:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB49979F85BF7BAD4DB86636EFE0480@BYAPR01MB4997.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UAcOX+gtHl913z7jKanQygdG5ZfefDbxvRGAc+9ocmW/NUqaXT8qE7P9YsPKrzEzTbzUkEaHML+Qz5mUb88lKJ7cbpVnSfyTHrxXtLr592eUzHp3DxvyJXZeutpYYQFg6Q30lJnmbypXxctnVKC+HhqPNSbKhN/wNSX3omOHe4U7HcBqV/BwbRg2D9hdWYhYrA7lhgOJPGrpjy9b412z5Tt2SkIHTWOdGF6qj9hDjL5VMS2lzluyAZXjznmsN7Xp79YhgNGlfnMrLZM4STj1s54WoXiGWVsLSTW7KWYjiL4+QYz0Td2QKE9+a1jjFu3d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(396003)(39840400004)(366004)(86362001)(478600001)(5660300002)(316002)(2906002)(66946007)(54906003)(83380400001)(66556008)(66476007)(8936002)(6666004)(52116002)(4326008)(6512007)(6506007)(6486002)(16526019)(186003)(956004)(8676002)(26005)(2616005)(34206002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: kS1Ylp+6qLiujKl38o8g+No6kARbpejkvqFV443gnA68BXEjUK2kT3u4N2n57Cq29/HJeldMGMDui5sF3SfPW6CRDHQyQ6J4Dtsktw6+mb/W0KF8Pffjb7d9Sxg3KRP37hqZD1kmT8voXFbPPS4/BnsxZcoZ6tJkcgCFvMZc1UrJgopjMZ20DT1cQxssQyq6htcioPzw/gnfXxWmDi15DeQW0et77rtTXTgSRjvTQL+DmH5RC9HEDR2zc9P9zs13iFEYQu1sJsP1p6SbvivC++zxHnYw4xvNf6F2RoCXhUN1Mc1yLbSsUjAs4syqa3WpZfg/RDw1EVbukxiVjWMiros4FVu7fZltofOj8GhIH+3St3BaRmvRqQrLa8BafOEK+6DSR5aYgcmiEZADrVyyf9wO1lpKgCojG0pRDYpfm2OpPjR1c5TOPb1joMEaitW5Jjhsx/1q8Zu0rQHyPnZAYlFDO2UMxB0Bmu5/ybxFA6huWPDkhsAJbyzWhpXVF95JUpM+ZJ5p7UKAqgxKb5dLqDlJqIHMR/tNgX0Qvh5skva6mJrWGSay2YypVo4TnMt+WFbNF8jwRF+Rr71sfb0nnFfbnUtGYWERr2xTBSl4LI6E02DQQfE7IE8J/ySwgmQkyrmaq+6fbDir4xJqZQ2UzA==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf446a2-577a-4f97-2f40-08d83a53c427
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4598.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 21:57:52.5691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSgXLZzBpdVAqB8SGDwnVmeHCrZu7+zCsvtC1XQr+QRSNFL51IwZuMwrJ51iepKEMm7Dfea0tMm/92TLoFkbeSMnKBau7iBuYtDVy2QR7j6riTmpTHKPgmz9NkgwRQuz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4997
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ampere Altra SOC supports only 32-bit ECAM reading. Therefore,
add an MCFG quirk for the platform.

Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
---
 drivers/acpi/pci_mcfg.c  | 20 ++++++++++++++++++++
 drivers/pci/ecam.c       | 10 ++++++++++
 include/linux/pci-ecam.h |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 54b36b7ad47d..e526571e0ebd 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -142,6 +142,26 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	XGENE_V2_ECAM_MCFG(4, 0),
 	XGENE_V2_ECAM_MCFG(4, 1),
 	XGENE_V2_ECAM_MCFG(4, 2),
+
+#define ALTRA_ECAM_QUIRK(rev, seg) \
+	{ "Ampere", "Altra   ", rev, seg, MCFG_BUS_ANY, &pci_32b_read_ops }
+
+	ALTRA_ECAM_QUIRK(1, 0),
+	ALTRA_ECAM_QUIRK(1, 1),
+	ALTRA_ECAM_QUIRK(1, 2),
+	ALTRA_ECAM_QUIRK(1, 3),
+	ALTRA_ECAM_QUIRK(1, 4),
+	ALTRA_ECAM_QUIRK(1, 5),
+	ALTRA_ECAM_QUIRK(1, 6),
+	ALTRA_ECAM_QUIRK(1, 7),
+	ALTRA_ECAM_QUIRK(1, 8),
+	ALTRA_ECAM_QUIRK(1, 9),
+	ALTRA_ECAM_QUIRK(1, 10),
+	ALTRA_ECAM_QUIRK(1, 11),
+	ALTRA_ECAM_QUIRK(1, 12),
+	ALTRA_ECAM_QUIRK(1, 13),
+	ALTRA_ECAM_QUIRK(1, 14),
+	ALTRA_ECAM_QUIRK(1, 15),
 };
 
 static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 8f065a42fc1a..b54d32a31669 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -168,4 +168,14 @@ const struct pci_ecam_ops pci_32b_ops = {
 		.write		= pci_generic_config_write32,
 	}
 };
+
+/* ECAM ops for 32-bit read only (non-compliant) */
+const struct pci_ecam_ops pci_32b_read_ops = {
+	.bus_shift	= 20,
+	.pci_ops	= {
+		.map_bus	= pci_ecam_map_bus,
+		.read		= pci_generic_config_read32,
+		.write		= pci_generic_config_write,
+	}
+};
 #endif
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 1af5cb02ef7f..033ce74f02e8 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -51,6 +51,7 @@ extern const struct pci_ecam_ops pci_generic_ecam_ops;
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 extern const struct pci_ecam_ops pci_32b_ops;	/* 32-bit accesses only */
+extern const struct pci_ecam_ops pci_32b_read_ops; /* 32-bit read only */
 extern const struct pci_ecam_ops hisi_pcie_ops;	/* HiSilicon */
 extern const struct pci_ecam_ops thunder_pem_ecam_ops; /* Cavium ThunderX 1.x & 2.x */
 extern const struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
-- 
2.18.4


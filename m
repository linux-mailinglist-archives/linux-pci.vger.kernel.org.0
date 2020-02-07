Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA8215610D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2020 23:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgBGWMo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Feb 2020 17:12:44 -0500
Received: from mail-co1nam11on2044.outbound.protection.outlook.com ([40.107.220.44]:41792
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727032AbgBGWMn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Feb 2020 17:12:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLRNWMxrS1v5gw047qhUO9SehBIokdqhusLkLZPEtmTVzJnRbrHo93rwIgZXuy1P44+R/XQyKsR0ExSyMVGjvTXwaqC5hP+BsI/rxon9bxw6nL2nrb3PAtrBXk6UKSmlR00YVDUEbFxw0p6pfxPqx7czlTxt3x3LJ5+817j/qzrBJD7fLQ3HH/DFBvgJOqnqgJKuMp/pdCW4NzEjmIjIMQtaqmXf2ilhOS79DarrtPDDflYdmMCzF0I9boRozDMnzA9oBW9YaiwrdxAkAtdidkJesEzWcQ/W2hU4z2Xdk/7nbBsOAr5Xw/1l2I2rsd6mdmI+1U3Fxywu2M2zIaic5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sb+bkDHA2leFR1FYDKieFFOtyL9iI3x0I/A/TmKafE=;
 b=DOn8iY0rxWH9PbrDW8TV1EqZCnJk9iPa9pf5fPJpM5sQItbIak5sg4TXBY5Ju9b8DjDOx8BqSdsQE8wTJuFoPOGy3+WqZpxDcV4bHAwxABbkvv0TPMC8Tb+1HCpCpWqzMAXZa48I+HcUDjljBc6pzIVdib9GPMAUOMRoGWuYFXgOzJyaGuPe67+GpxCRwyMPcaqwmdklGRL0Me7mW/t/IrR9jEkX1EXOq5b+IGBCkT3P/flBR5Y7Vw901gIWmrx9lyIMwHjgxtAKqmAZkrTP09q/Pm3NbKWyKvq2knHM0CeYuISZoi/4vJQU9OKDaOE83wIS2mxnMUtYcRNVZEnrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sb+bkDHA2leFR1FYDKieFFOtyL9iI3x0I/A/TmKafE=;
 b=hQhQDQuiwz3AQRIKuh2zDnBueQTEsx2NeroA7gwIO8skE5saI86qrauY7tPy0Uxqp5I4ltqt9tQE9xDK61z8Vf6f86LEeCIVkJtXmAwSNg5lrORPmUmep/AUl5ZaMokz2BaSMwt05JxgcpvyPpN7PIueqBKGvXM6UP2zWqllsnQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrew.maier@eideticom.com; 
Received: from MWHPR19MB1103.namprd19.prod.outlook.com (10.173.120.23) by
 MWHPR19MB1136.namprd19.prod.outlook.com (10.173.124.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Fri, 7 Feb 2020 22:12:40 +0000
Received: from MWHPR19MB1103.namprd19.prod.outlook.com
 ([fe80::1df3:7110:c934:6549]) by MWHPR19MB1103.namprd19.prod.outlook.com
 ([fe80::1df3:7110:c934:6549%8]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 22:12:40 +0000
From:   Andrew Maier <andrew.maier@eideticom.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     logang@deltatee.com, Andrew Maier <andrew.maier@eideticom.com>
Subject: [PATCH v2] PCI/P2PDMA: Add the remaining Intel Sky Lake-E root ports to the whitelist
Date:   Fri,  7 Feb 2020 15:12:19 -0700
Message-Id: <20200207221219.4309-1-andrew.maier@eideticom.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CO1PR15CA0062.namprd15.prod.outlook.com
 (2603:10b6:101:1f::30) To MWHPR19MB1103.namprd19.prod.outlook.com
 (2603:10b6:300:9a::23)
MIME-Version: 1.0
Received: from odin.Eideticom.local (70.73.163.230) by CO1PR15CA0062.namprd15.prod.outlook.com (2603:10b6:101:1f::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.24 via Frontend Transport; Fri, 7 Feb 2020 22:12:39 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [70.73.163.230]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a8dc6f9-e43a-4e74-e2fd-08d7ac1ad8c2
X-MS-TrafficTypeDiagnostic: MWHPR19MB1136:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR19MB11362DB87BEA834221DC0208931C0@MWHPR19MB1136.namprd19.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(396003)(39830400003)(199004)(189003)(2906002)(86362001)(81156014)(8676002)(6486002)(6666004)(8936002)(6512007)(81166006)(52116002)(1076003)(316002)(6506007)(36756003)(4744005)(66946007)(4326008)(186003)(16526019)(2616005)(956004)(508600001)(44832011)(5660300002)(66556008)(66476007)(107886003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR19MB1136;H:MWHPR19MB1103.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: eideticom.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJXRvm62+hn90Hm6lUYqqp/lPpZpiNTPnGqjifQLbdBfq1STIPNRRpdlBZqPo9mH7bgWzbo1D7a7LszVozG5VYZIDNyZWA3L0ufWkc3zsTkTNY7/LeOxZ2CgbwmpLHMT7uP9yr+BRG9THVGAmXZ65z4cWSCmz71aj0KHFup/gD/Rt5ynQV4jj4j8k2Eetz9XXLmPvnn7TaRXj0aLS8lqdOelJSUrN+P1lkT5lwxboRz83CwNm2jO56DBMhpevrWiXdMOW1RLNoPNpsg2l73WxlDvM85bV3xOykH5i3rk9veyz7bgOXhgoyrAI5TIMONxaBwomOb/vVrpJUCCchvJKxXGzgYClkDRrbPGaUgyV0HHPZme7tud4KLQjgY4QjU1RUGQSlZvPySeNDNYFLOyEijPU6KbQNN8SmNnxxsFJWPaqD9tH5BtXKYBNq48Um47
X-MS-Exchange-AntiSpam-MessageData: WCOi63zsYouioK52p00tDjvtP+bVam8588APH+LgQeOYIg0LIwVYjJJjHAK140kW20VncKSVH812WOe4iIlqHqeld1sqfEmRLl7x54u3qu11T46rbO1PX0dj2ISPYNTFDw1hzEjY7GwfljavioEO7Q==
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8dc6f9-e43a-4e74-e2fd-08d7ac1ad8c2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 22:12:40.3761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcYIHKa4f+/pIAzK1q6pam3pTBNMdwZYg2orys7MWOG0WXhSYMmF91IQpN7n5OiYZdIZTxKeGRZ+iHat/h+Zfvmn7x0IMkCx3YAK/Pp27YA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR19MB1136
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the three remaining Intel Sky Lake-E host root ports to the
whitelist of p2pdma.

P2P has been tested and is working on this system.

Signed-off-by: Andrew Maier <andrew.maier@eideticom.com>
---
Resending this as I rebased it onto the latest patches.
 drivers/pci/p2pdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 9a8a38384121..b73b10bce0df 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -291,6 +291,9 @@ static const struct pci_p2pdma_whitelist_entry {
 	{PCI_VENDOR_ID_INTEL,	0x2f01, REQ_SAME_HOST_BRIDGE},
 	/* Intel SkyLake-E */
 	{PCI_VENDOR_ID_INTEL,	0x2030, 0},
+	{PCI_VENDOR_ID_INTEL,	0x2031, 0},
+	{PCI_VENDOR_ID_INTEL,	0x2032, 0},
+	{PCI_VENDOR_ID_INTEL,	0x2033, 0},
 	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
 	{}
 };
-- 
2.17.1


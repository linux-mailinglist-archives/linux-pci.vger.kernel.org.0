Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538E63DF442
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 20:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbhHCSAw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 14:00:52 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:58144
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238413AbhHCSAv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 14:00:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRWDvYbRHSb2BuxLAANN1U+xZ5xQ/kd1oIYVsgJTrkbkNHl/I0PL3UOvNSMdZOT9WT0hY2D/GifvhWutjavmAY6sehzyylxRT0/ezxucD8gakt6MKOW5I/SrPG8vGLCwTtb9nYFDw05kX1/kLnQyOJARoejyYs73R3HLnTVfRFfLCO/4bvb7lkzBASR5r13uj4IS1mwkXt01jupczk1c9SNpk14Vtmq7qYNHYnsudTxmYNXmg3yX3ePWMsyXbqcxhPqyTpkl4DseyO1klfAHRPat4S+ssO/XaOZJCnYG0Ub5e6x3RB+i/BWFPd7QrvqmvrTEkeU0R0i3nNamgHql6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ftwba2j0byOUMR9/sNwJ2/JC4dK9cPCsG+biBSKA7U=;
 b=cywW/46V9nbv230EWCOosRRrAwIzwe/z179x32lESp+hMNiJYlNTG/BBGHNtlnQRGadGvTxtgKRbzZ7be/rXyx/M8YIM2/gZwagMq8R4GsWJe4IOAmvcRicLempSd8pRutAa8iaw4yFKbrxxiel+OhQMALeTeWK15XwO42jQF2ecCLLGNGyDlklsFwLlgJknRBTjBDm1gx88oSD7E7jd1hlNZB8iWHS6kFESrCnxSu3eKvukhjizxEOnypmOOe5tVeS6iqabZQMMEygMa1qMyeQxi1qSTmCtEU3XLgzkYSkkc1WV5lWA2pvI9+JO/MctT79SGVUCC1/asia/V1dXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ftwba2j0byOUMR9/sNwJ2/JC4dK9cPCsG+biBSKA7U=;
 b=JKhUYBUwMQEcP7Kl7Zl9A+EZg+Ff8k2nNa/vY1JlTNgRGHK36cLYIZYN5/BfAkCPxZj8vjO9drRiPzAxxrCpC7ALn1ex70QdqBGJLWxObjBt5dHTiSJ6iIrb9+hdDREVLBoR3jchOZYwv2IcPiwDfqXRc33WuwhOKvMLSo8nTX0=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9)
 by DU2PR04MB8646.eurprd04.prod.outlook.com (2603:10a6:10:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 18:00:38 +0000
Received: from DU2PR04MB8726.eurprd04.prod.outlook.com
 ([fe80::e50a:234a:7fb7:11d4]) by DU2PR04MB8726.eurprd04.prod.outlook.com
 ([fe80::e50a:234a:7fb7:11d4%9]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 18:00:38 +0000
From:   Wasim Khan <wasim.khan@oss.nxp.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     V.Sethi@nxp.com, Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH v3] PCI: Add ACS quirk for NXP LX2XX0 and LX2XX2 platforms
Date:   Tue,  3 Aug 2021 20:00:21 +0200
Message-Id: <20210803180021.3252886-1-wasim.khan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0143.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::48) To DU2PR04MB8726.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv05369.swis.nl-cdc01.nxp.com (92.121.36.4) by AM0PR06CA0143.eurprd06.prod.outlook.com (2603:10a6:208:ab::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 18:00:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61856a97-1007-44d8-f2b6-08d956a89950
X-MS-TrafficTypeDiagnostic: DU2PR04MB8646:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB86469033AE674267B6476955D1F09@DU2PR04MB8646.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:270;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lab8A77cu3RdaENEmQOUZ0ymu43/eZXUR8HBhdAHu1H129bvUBun21LQh8fdPIRHZQHjb+hRNvnunZ43vB+Jfv/yCrn8kwqYdpPft7nKCuFrpNdkTcr4gAI00qg8Inpl/NzemCUlkEEQwFr9T/e9pCST4MLVRAcnt/iFBkyhR62jx9M0cIYqDR6Tkx8q9kdO0ZsAiZehhUu2ryzA3GMEE4v1C2eMyT4PT8WtLBbbkzASbRRhMuRnoptEZsl+5TgYHjGdD+5/2whzchZvaoNgosd6kuUl0WIeurej5Z8nfUHgp2y//FVGHSKCy1saCGcCbPVED97vmqrmLoruc2PrGPetdgtaCTknNiLsQlGk+Lk8/LvJSzndqoREOUV8tAvVFpVdfTV11sVnuFL9VflityfXwhjuz/j1BIz12083EDM/2mGJCcPEuVHH6OmoT5C1tiK5ioT2r0QUdkBV0f0BHs0vXm/JpHbfQZU7xp+H9uVf3QiRcGPH5bGuzkZWkch/YQqQHe24+hmQbgsdDAZjn9Faww3R2zuCg6gkqg3xBR22kDhxstYM9BiV+jSsFVVpwoV0waBNRWUDpmOJWm41EkBN7TNnxOA6jLNnNO+SIZw/9YQlZ+YNXrmlccgh6K+CMAeZXd7EAEKojdR4eqD2KPpzTPybSSncv9LArJtIUX8mPq6DxkBFGTIldzyksRM5MsnQFCjsNxHpeZTRx5NWcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8726.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39850400004)(52116002)(6512007)(2906002)(478600001)(1076003)(2616005)(956004)(6486002)(38350700002)(38100700002)(44832011)(6666004)(5660300002)(4326008)(86362001)(316002)(186003)(66476007)(66556008)(8676002)(6506007)(8936002)(66946007)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/GtOvhRqBeznMOZujlprSfjdWCMV+sWispgoM8Dz+faAWmurB5XKNWAdUXm1?=
 =?us-ascii?Q?AL2yevf5sZcZx11Mbyd2hwHMnmGBbf8eXK6N1KyWnpw1UNQDSki9oNphhsXB?=
 =?us-ascii?Q?LQM49WU28mxZCK4lWStOg8lGlNS77tMS+OKwJKto9fq8IR9PwSq1VfEw4Xk7?=
 =?us-ascii?Q?Hdga5YmvUXMTQmoCZGfvsPk3/YUZoJKGwdR6KcmzgDHq0EsudDfIZhFa0MAN?=
 =?us-ascii?Q?iEHIEOwSuWzPJm/1iC6g6UWXI7nMzGa7zrc/y9uRM7xnF95omxjv/Ni4QPPp?=
 =?us-ascii?Q?PV3qYMvUTdlrlhG+ZEjIaUZaJz18mLsNieDrkbxQLJ1jPtFqmyuJOAt8dq2D?=
 =?us-ascii?Q?D+STHsAiI/zozUgnEaJFKXcb9kCJXzvbIolI65zLCNoGZcIcWpKUQxKftSsf?=
 =?us-ascii?Q?H0Wa/Qhj5cYa9pseUQhV10ZNf3i8D/sxRSjHmNuF2Iz7CFIF1457Ph4H6mCe?=
 =?us-ascii?Q?s3wmQ/esi03N8eCqdVTY4pswcCpzYf04kfwYIhzunEZBVjdo3T6stz6zjvai?=
 =?us-ascii?Q?hefOMDVeOxIVkt/zOa6Umq+ArOhYWXVZLSmUPY0G3ewBtoILTLKjuH0Hchut?=
 =?us-ascii?Q?45t+L1N+Fz3txAmKB094+KfBX5SSxWgaBdN+DKHs3B8XZJb/YGOHPLxlwsla?=
 =?us-ascii?Q?XqBX3paMZsiVMpo+ELwLXxsojplT6DHEQDmSbba6Rr52ypc9+jPLFM0UPmV1?=
 =?us-ascii?Q?F8mMEW7TV3eYcjLpBiC6NaNLLlMgTraD0asLCdBo49uf2t6G/PbXlyNs5KhB?=
 =?us-ascii?Q?CjOS7DE4OzbyQKRdong27DPQyAeJmxC9aCC9NMGX/gG/oiO2sJ6ZAhvSc/V9?=
 =?us-ascii?Q?5r2mZeX8jvltg8MhruvRiPxRaYgm4iWuN0Nl+SafR5Mwb3V23jLkJptQ5zeL?=
 =?us-ascii?Q?kNU8dwCh41eR4ijHq6iGmmtpOK2DoMR/m0ke7oKbM9EhUidXzatlaBzz78fS?=
 =?us-ascii?Q?aZcrIGXlEjan2hukkblhmXLl9ZrxrTaStXIN6Ble0tQ8xluRbwVWJPrk+AB0?=
 =?us-ascii?Q?ZqhKOzXTbS7PTeoSfIH05sH0P1jRO9LL1yHeRoi34RDXlVgjHfbEokf97/nn?=
 =?us-ascii?Q?KJr/cKHoLqiQmZpZoOgI4hVLrnPbpx3JTpYGiWMkfbzzGmslOrA86PqgDOx6?=
 =?us-ascii?Q?9trdURFQEULY4RlNjia0b7oQSgGvZmWDIm2AoFidveWy+we6fzBWcsninOnk?=
 =?us-ascii?Q?N8EpDP2rQux8YKBZ1+aGUNCDjpJTmYkg86BjEZu7Cxrh/jRfhlGF89Ss5vHc?=
 =?us-ascii?Q?K9wdWyTelA6hwYyzjPp9qW8sGT+KsyV4KXVpCbQrqqMm146WuNGjVBhke4iW?=
 =?us-ascii?Q?xFGhWzqUGv1PjBYjbk7Ix/rq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61856a97-1007-44d8-f2b6-08d956a89950
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8726.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 18:00:37.9963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCrBi3RhPh0mJS1w7eRZZrvfGt24Ek11YLSR0ECEgPMkh+2AGbOC78tfLvGnXxU2lM0miKzJZ8dax2/HEPx+PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8646
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Wasim Khan <wasim.khan@nxp.com>

Root Ports in NXP LX2XX0 and LX2XX2 where each Root Port
is a Root Complex with unique segment numbers do provide
isolation features to disable peer transactions and
validate bus numbers in requests, but do not provide an
actual PCIe ACS capability.

Add ACS quirk for NXP LX2XX0 A/C/E/N and LX2XX2 A/C/E/N
platforms

LX2XX0A : without security features + CAN-FD
	  LX2160A (0x8d81) - 16 cores
	  LX2120A (0x8da1) - 12 cores
	  LX2080A (0x8d83) - 8  cores

LX2XX0C : security features + CAN-FD
	  LX2160C (0x8d80) - 16 cores
	  LX2120C (0x8da0) - 12 cores
	  LX2080C (0x8d82) - 8  cores

LX2XX0E : security features + CAN
	  LX2160E (0x8d90) - 16 cores
	  LX2120E (0x8db0) - 12 cores
	  LX2080E (0x8d92) - 8  cores

LX2XX0N : without security features + CAN
	  LX2160N (0x8d91) - 16 cores
	  LX2120N (0x8db1) - 12 cores
	  LX2080N (0x8d93) - 8  cores

LX2XX2A : without security features + CAN-FD
	  LX2162A (0x8d89) - 16 cores
	  LX2122A (0x8da9) - 12 cores
	  LX2082A (0x8d8b) - 8  cores

LX2XX2C : security features + CAN-FD
	  LX2162C (0x8d88) - 16 cores
	  LX2122C (0x8da8) - 12 cores
	  LX2082C (0x8d8a) - 8  cores

LX2XX2E : security features + CAN
	  LX2162E (0x8d98) - 16 cores
	  LX2122E (0x8db8) - 12 cores
	  LX2082E (0x8d9a) - 8  cores

LX2XX2N : without security features + CAN
	  LX2162N (0x8d99) - 16 cores
	  LX2122N (0x8db9) - 12 cores
	  LX2082N (0x8d9b) - 8  cores

Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
---
Changes in v3:
- Updated PCIe ID for LX2XX0 and LX2XX2 A/C/E/N
  platforms and arranged then in order
- Updated commit description and included
  device to ID mapping
 
 drivers/pci/quirks.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 24343a76c034..d445d2944592 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4784,9 +4784,38 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_ZHAOXIN, 0x3104, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_ZHAOXIN, 0x9083, pci_quirk_mf_endpoint_acs },
 	/* NXP root ports */
+	/* LX2XX0A */
+	{ PCI_VENDOR_ID_NXP, 0x8d81, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8da1, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d83, pci_quirk_nxp_rp_acs },
+	/* LX2XX0C */
 	{ PCI_VENDOR_ID_NXP, 0x8d80, pci_quirk_nxp_rp_acs },
-	{ PCI_VENDOR_ID_NXP, 0x8d88, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8da0, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d82, pci_quirk_nxp_rp_acs },
+	/* LX2XX0E */
+	{ PCI_VENDOR_ID_NXP, 0x8d90, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8db0, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d92, pci_quirk_nxp_rp_acs },
+	/* LX2XX0N */
+	{ PCI_VENDOR_ID_NXP, 0x8d91, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8db1, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d93, pci_quirk_nxp_rp_acs },
+	/* LX2XX2A */
 	{ PCI_VENDOR_ID_NXP, 0x8d89, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8da9, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d8b, pci_quirk_nxp_rp_acs },
+	/* LX2XX2C */
+	{ PCI_VENDOR_ID_NXP, 0x8d88, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8da8, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d8a, pci_quirk_nxp_rp_acs },
+	/* LX2XX2E */
+	{ PCI_VENDOR_ID_NXP, 0x8d98, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8db8, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d9a, pci_quirk_nxp_rp_acs },
+	/* LX2XX2N */
+	{ PCI_VENDOR_ID_NXP, 0x8d99, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8db9, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d9b, pci_quirk_nxp_rp_acs },
 	/* Zhaoxin Root/Downstream Ports */
 	{ PCI_VENDOR_ID_ZHAOXIN, PCI_ANY_ID, pci_quirk_zhaoxin_pcie_ports_acs },
 	{ 0 }
-- 
2.25.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B04C11E8
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 12:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiBWLvG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 06:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiBWLvF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 06:51:05 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF761AF0E;
        Wed, 23 Feb 2022 03:50:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieXsO+lYjBeqNA3hShIlDEx+04h6WXOcsiGsyoamVsOcNRCECRVnQogcbOkiEXIBzKrPvPuFlrBE6dnab91rNn/1unQNh/UTIMbRSjFgysCfOFhrIyLSPsFIu1oVFSkchuuIOVfcVsQe2og/89M/UBI73ZOziUnG9+0R7wghZBle9vEhfvoX20GaaXuYbtGMiws/m/dWhzVQ5zL2ZM6F6UR7hHxYUIbVd2bwe0jy55L1hT9WHvGXktK6v9z7gL85d2OOkBqk2UDVoESic4BFT6W5Ead3yvjhnjc+MyffFKnAOMJa2egySRc5hHD91S6UMc6exRyJ3IRhPGax48etJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPC/EgDMOuWG6uRddOz4O1nXHYa+YUbVbblyqLylidI=;
 b=h6GgujRwvcYcPvBW/VCKKUQPz/kFHOOgEqc2fOVeFSbkFGn+v+lnk4pTmygVoA/AtkELkCMc/L8kWLEON7kIWYMJ7jo91XOxtzvP7qNqqyBokEmO2F7JBTc8m/URffmAaDIILZpitbEfj+AFs2FcRAVdCUidsIfrELyOdd75lUxHgzQzUWLbmlm7tMoQr4F2U/zKXByftBAzgKn1peESAgfRTXCpbv+8JL/iIK+ut7EinIENhFs+5VSwCgLK0o+DngZFblY4x+hID7b4z8mW6bofvZJEPn7PGi17vAE9T60rST6wMV953dGZn4AYAD8nG8tOL+4cZIvZ9PDKzfgSmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPC/EgDMOuWG6uRddOz4O1nXHYa+YUbVbblyqLylidI=;
 b=ZLrwy84WGHCQL6M9HHQq/POg7myFbksSDEeF7+wBuFoXVuZa8VcIPazI2Wdot/AReBua9q6KeLhZ35SaMGgagCuzDxgDrFAmRcH/Ok+cifpIr1cTiw6hJgOyuWGdX8T4l/idgTo72fJ/Vk60eAY4sOzNeJ6MmkwodkRcrzX7XoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by DS7PR05MB7334.namprd05.prod.outlook.com (2603:10b6:5:2c3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Wed, 23 Feb
 2022 11:50:34 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::f523:9ce4:3c1c:1eb4]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::f523:9ce4:3c1c:1eb4%6]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 11:50:34 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     bhelgaas@google.com, helgaas@kernel.org, gregkh@linuxfoundation.org
Cc:     ymcavikas@gmail.com, akaher@vmware.com, amakhalov@vmware.com,
        anishs@vmware.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, srinidhir@vmware.com,
        srivatsa@csail.mit.edu, srivatsab@vmware.com,
        vsirnapalli@vmware.com, Vikash Bansal <bvikas@vmware.com>
Subject: [PATCH v3] PCI: Speed up device init by parsing capabilities all at once
Date:   Wed, 23 Feb 2022 17:04:09 +0530
Message-Id: <1645616049-19712-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <6827AF44-4412-4ABA-A66B-562D7E86C847@vmware.com>
References: <6827AF44-4412-4ABA-A66B-562D7E86C847@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::26) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 763720c7-54ba-4c96-6a5e-08d9f6c2b33a
X-MS-TrafficTypeDiagnostic: DS7PR05MB7334:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <DS7PR05MB73340852FE660FE175BA3D69BB3C9@DS7PR05MB7334.namprd05.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ft7BFDgZz1OX862ozXkUD+XtXfrcseWFkFO/+Wj89QUV5AfvN+SsIqSK0ui7tGv22DvgrdjwhdWBOqqefP0DS1uoCsDfFGiSs/994TlwjMP9RS6mPKmaEmM+9eVsp7uvcD4smx8KPl9GpHr5LFddR6Q+qqF5jZkpCbeNoOi1536IYEo6W+RT39zT2KYMpkPsH0Jt6YjrK3+2tpcmuOStb8TBvUj1wPOigkDrtsZTB9EJcHB24uypCDQ8Fl2WgG0Kps6l7Ig80r0xhI/eACGmfqr3Wi/3TshjB6jMGvODD/8hvyGOAmOSGPh8H7MYUtlZFtXpNMgGVQ6iu029cVUCLPyYlgP/APwBxMXtT5gAdhPRIw76O+GZ7tiR2sYLrbTT1WVxPhdRzPAGh8ZkUZh/NzvYeBMBuOs2/iKbzhYI5TRI6WscHyzIFtLAAPs6E3ieh48jHmlMmZGs3xn/DJSA9Xn2g25QVuqvArnD2+yACtIUNvYy5cO3NxFKHcxExAY8Q3uRucke7rST0/Ap1Wc4VB3RTJXPc34Cf1pkb/ZVtXTF0eJ6HupMO4rsaXRXbyz0igyRt79/ZEA1QdQ+oY7pv7kN4aw/HyNv9oB6V+U8oaSaQJ80MT7a2YjWd40Xycl3fKoRonMKAJKKCSRLwgnKvp46qdzkBl8/0/7pyPGsbuvStfuQNck+eaBWNxMOzSXPboepj72KmtXYvD5RAgTYnKNyBsvQLln/CFitPU6BJx7F/MzPTQ7YJXiZOqg4h1zZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(8936002)(5660300002)(86362001)(66946007)(38350700002)(2616005)(83380400001)(107886003)(36756003)(8676002)(4326008)(66476007)(66556008)(186003)(26005)(2906002)(6666004)(6506007)(52116002)(6512007)(6486002)(316002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?83ammAkQQzD4LgmC/nFOYJiRS9gxLSsClB2UzVHtrdIxZBSVNGY5Ye4NaTzd?=
 =?us-ascii?Q?OzqIt8h0EvaqSMFQtw1KoIkaFsHUn93BQzgkwv+fQ+bmx3USpwiKnqRQiJfl?=
 =?us-ascii?Q?9ezDhBO3cNePQK//OQBlgkSNtogucSq/3vNVnYcgySSMH8+oNs0XVoJILWi3?=
 =?us-ascii?Q?JYe9RQ3o5bhzz27cuWYvj9sKohZ2p2RNRyzw1QsdoVJ85nnhJKE1C+pAlpW3?=
 =?us-ascii?Q?kv6cwHJblEWsj0Ds4PhOEvNo6y39jCn8VqRlxrQCZjWZ+gwY8eFv9/iM78D3?=
 =?us-ascii?Q?/gFAWCKPdAbky//3lGblXKCjHyHydnQA5gzfn5Es2e+vGSnSDpERclVY6apA?=
 =?us-ascii?Q?E+aZZEZlWifwyvpz8Ybc6SbMdUd5s+0zoPKIEEluHS6LnnQ+NW2tAwq6GuTJ?=
 =?us-ascii?Q?Ui/JnPNCZoAUSnaKBPGG1CVC9bocEiZe3ZNMqq+kUl+fn0zD3YN1GdoGo85y?=
 =?us-ascii?Q?srul0rO8iyb8ozdAgukTgMvcjPAaW2+jCzzXh8XGP8LOJbxbLAi3FNO+EWVR?=
 =?us-ascii?Q?cORZGyznGnCGnqTLIAFgtaCZw0HdCa5uJ26LhQgEATnWQW86XXQqWqTqFXhy?=
 =?us-ascii?Q?vANs4z3nQjZNFIb2muREcnt+iinZVB01wx+0jSti4nQDa+NML6z8+tHvXP2t?=
 =?us-ascii?Q?TyUI10iltYF4fxu1olWoUlz73mFCnrucmcPOjEFGx9neR/ADbd9NlQxNo90Y?=
 =?us-ascii?Q?pTUV6sRE2Bi3lwL2MSblOS9u8VFPBpKGIz5bAbBn1RyWnqisB3TGfn/lW/C3?=
 =?us-ascii?Q?HD4R4hbtPhhN0oCK7QTFa+KFz+Y9vfyEdvyPzYUranARAoww7tVOu2Xu3MWA?=
 =?us-ascii?Q?zHHhFk5CsZEaHOq1Tfrf2ahWlmNrunWaQWv3sBB2I/Z1H7AH6U7vN9pIV+7L?=
 =?us-ascii?Q?KrOaORpPc+BJedkp4M6rLVHPzWwz5SU3qYTm0IbB3nb315yAYszHW6nOYk+a?=
 =?us-ascii?Q?qP1psNt9aJhe4nkqat2colaQsc9s1POliA+1jF+6qBHXBnGTP7aOp9/211BQ?=
 =?us-ascii?Q?n2hvhfDPGkeJONMraNv6z87jtRL++rqeEqiw7CahQdD/X8G44HSwJB1Y9OQH?=
 =?us-ascii?Q?IPzdbG23rTwJkK2hH9UCW98bbc1EA6+aBQXIZkP3mt2qDe9dd+5o1DdFvjmW?=
 =?us-ascii?Q?sKsf/9CqJh75Zpt7pWIojYF1yCuIqwnzj2Ako5LzSaqT1+hjPoBTnDHN4uqr?=
 =?us-ascii?Q?nCH0oe33vyIxQXpcbqLtRU9Zi0E7k9pJMVdxwxF/X3VvIkmu3Gd+m2TwHLcd?=
 =?us-ascii?Q?1tPo/hHk/R6BTkXOhO+neU05Y0PnwM4fuGaltbonJAQkQBBf2yMNQB7tH+Bl?=
 =?us-ascii?Q?scFgDLf39bLcjWDoAapjl15O84vZLXaq2JEy+Erkhz/lqbbGA3vbzzsiFI1D?=
 =?us-ascii?Q?kOw2swSWLJ6JrJ6omMHtIcPJps9lYygmclXD4Up//U9eCiMoPD0XCt0C2jp8?=
 =?us-ascii?Q?+hn6VEEvDuWnuhvfLicXNlqa8wk1IlRsP2Dfoqn5mKCBszzJHfGsZFHewi42?=
 =?us-ascii?Q?DT6z6AR6YJt+Jq32hFwKvT+07NE+d6w8AjMBmN/beV/Zj/V+rkHEmACgYi4b?=
 =?us-ascii?Q?GZfOBbC9LeVxdNSOJx1VSbL1VqCC2wDeRhbOM3Ynq+tX5UTwmVTjjkfa9Jzh?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763720c7-54ba-4c96-6a5e-08d9f6c2b33a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 11:50:34.2392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3zZi3iOT/iSsd023DCJG+tPM8HGo7O4S+UAB3vAtBypbX8KtWDI+QqNSUH0Po7p3jjqje7s1/oR2xKQFeNYow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR05MB7334
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Vikash Bansal <bvikas@vmware.com>

In the current implementation, the PCI capability list is parsed from
the beginning to find each capability, which results in a large number
of redundant PCI reads.

Instead, we can parse the complete list just once, store it in the
pci_dev structure, and get the offset of each capability directly from
the pci_dev structure.

This implementation improves pci devices initialization time  by ~2-3%
(from 270ms to 261ms) in case of bare metal and 7-8% (From 201ms to 184ms)
in case of VM running on ESXi.

It also adds a memory overhead of 20bytes (value of PCI_CAP_ID_MAX) per
PCI device.

Ran pahole for pci_dev structure. This patch is not adding any padding
bytes.

Signed-off-by: Vikash Bansal <bvikas@vmware.com>
Signed-off-by: Ajay Kaher <akaher@vmware.com>

---

Changes in v3:
  - Added check before access cap_off from pci_find_capability().
  - Moved declaration of pci_find_all_capabilities() to drivers/pci/pci.h.

Changes in v2:
  - Ran pahole tool.
  - Modified comments to add "clock time".
  - Removed comments before call to pci_find_all_capabilities.

---
 drivers/pci/pci.c   | 44 +++++++++++++++++++++++++++++++++++++-------
 drivers/pci/pci.h   |  1 +
 drivers/pci/probe.c |  1 +
 include/linux/pci.h |  1 +
 4 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3d2fb39..cf54811 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -469,6 +469,40 @@ static u8 __pci_bus_find_cap_start(struct pci_bus *bus,
 }
 
 /**
+ * pci_find_all_capabilities - Read all capabilities
+ * @dev: the PCI device
+ *
+ * Read all capabilities and store offsets in cap_off
+ * array in pci_dev structure.
+ */
+void pci_find_all_capabilities(struct pci_dev *dev)
+{
+	int ttl = PCI_FIND_CAP_TTL;
+	u16 ent;
+	u8 pos;
+	u8 id;
+
+	pos = __pci_bus_find_cap_start(dev->bus, dev->devfn, dev->hdr_type);
+	if (!pos)
+		return;
+	pci_bus_read_config_byte(dev->bus, dev->devfn, pos, &pos);
+	while (ttl--) {
+		if (pos < 0x40)
+			break;
+		pos &= ~3;
+		pci_bus_read_config_word(dev->bus, dev->devfn, pos, &ent);
+		id = ent & 0xff;
+		if (id == 0xff)
+			break;
+
+		/* Read first instance of capability */
+		if (!(dev->cap_off[id]))
+			dev->cap_off[id] = pos;
+		pos = (ent >> 8);
+	}
+}
+
+/**
  * pci_find_capability - query for devices' capabilities
  * @dev: PCI device to query
  * @cap: capability code
@@ -489,13 +523,9 @@ static u8 __pci_bus_find_cap_start(struct pci_bus *bus,
  */
 u8 pci_find_capability(struct pci_dev *dev, int cap)
 {
-	u8 pos;
-
-	pos = __pci_bus_find_cap_start(dev->bus, dev->devfn, dev->hdr_type);
-	if (pos)
-		pos = __pci_find_next_cap(dev->bus, dev->devfn, pos, cap);
-
-	return pos;
+	if(cap >= PCI_CAP_ID_MAX)
+		return 0;
+	return dev->cap_off[cap];
 }
 EXPORT_SYMBOL(pci_find_capability);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3d60cab..3cb70d5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -87,6 +87,7 @@ bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
 void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev);
 void pci_bridge_reconfigure_ltr(struct pci_dev *dev);
+void pci_find_all_capabilities(struct pci_dev *dev);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
 {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 087d365..d75e1fa 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1839,6 +1839,7 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->hdr_type = hdr_type & 0x7f;
 	dev->multifunction = !!(hdr_type & 0x80);
 	dev->error_state = pci_channel_io_normal;
+	pci_find_all_capabilities(dev);
 	set_pcie_port_type(dev);
 
 	pci_set_of_node(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 18a75c8..bd61cee 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -326,6 +326,7 @@ struct pci_dev {
 	unsigned int	class;		/* 3 bytes: (base,sub,prog-if) */
 	u8		revision;	/* PCI revision, low byte of class word */
 	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
+	u8		cap_off[PCI_CAP_ID_MAX]; /* Offsets of all pci capabilities */
 #ifdef CONFIG_PCIEAER
 	u16		aer_cap;	/* AER capability offset */
 	struct aer_stats *aer_stats;	/* AER stats for this device */
-- 
2.7.4


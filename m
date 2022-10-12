Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751915FCA48
	for <lists+linux-pci@lfdr.de>; Wed, 12 Oct 2022 20:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJLSOk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Oct 2022 14:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJLSOh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Oct 2022 14:14:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025F5FE750;
        Wed, 12 Oct 2022 11:14:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxclKlW2hA182K/bRU5tjKfNdXUIQvqy3dBIyOQKRUPoa7ry7TyFQsmhbAmtU/HRnlh3k/k3v7q8NpslA7ra4oLmVbRA0XCes60WQXhlZOO5HkTqWGgf+F+Q+zL6qvsNbBDcUFp3F8GxUxlMuIATNTwAA/JYxYWxsb67eod/C60tvyjGYfaD//Dnd3RQ/bvu1kt35dW6e0FVMol+OMD1snL96/CU2kNjxVGoXTVye0Gk/rBgWbDdl3W/BEfI53t+g9qSkgYAk2Dm4mslI7gRIXkwKZp2czJypCv+lY1X5K2xYsCdM3nFp8C4aI9s/7s1MSddnghMKpQkuxGKYUMOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6ckbe4rVitzLrY6iyJ2lmey+Bxaz72/a+CjZ7YJfzk=;
 b=Q2nNMxT3to1AWHzdVvMUFjcemKp1hA18bFdoa4uYJzumEByD82/oR/0B81HPaXe+vR0BfbwCDXGf1mx/hTmy+AQOCXfMhLzoIq/sfNqG3W1tSG9hba0/y9G5MTeRRrV+e/bPTqzzTpOOv5l0QAlZ5cmtViAFBrWy5nhVUnidKi7BwKzVPp7+yuxnyrxEmD0GZC5FNV9fBBuSfsPMAD2n8nUHXrMedN/ByHQZ0t/pur6gnDReANlZ6eZ7sv1NC20wFB4NG+regZHlgw6K682smBtsgN71hcr8NbqNsBS8Hl3HpVnvsFdnAEVmuKEkh3iGe/B903wRgQveZfz1I5s1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6ckbe4rVitzLrY6iyJ2lmey+Bxaz72/a+CjZ7YJfzk=;
 b=DFD2G4XqVgYYXiS+P3KdqcRc8uRtbpbr75VeCX7DAa+Xd5oFUNPIKmzxOsONelKo0hWwBdVg/R2IrVmD4jp4v95sYhTqBzVGvrTqLMPx3r1+pIp67tuYA5Mw+cRlKdq8RkxG++YAubj+2c/FyqZU5+k0u8GKYnPoqjCbiSG/PFM=
Received: from DM6PR21CA0019.namprd21.prod.outlook.com (2603:10b6:5:174::29)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 18:14:31 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::91) by DM6PR21CA0019.outlook.office365.com
 (2603:10b6:5:174::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.1 via Frontend
 Transport; Wed, 12 Oct 2022 18:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 18:14:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 12 Oct
 2022 13:14:30 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 12 Oct 2022 13:14:29 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH RFC V2 1/3] of: dynamic: Add of_create_node() and of_destroy_node()
Date:   Wed, 12 Oct 2022 11:13:58 -0700
Message-ID: <1665598440-47410-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1665598440-47410-1-git-send-email-lizhi.hou@amd.com>
References: <1665598440-47410-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT026:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: c3082ea0-b394-43e6-bbec-08daac7d9bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Z1eegtTTxN2IVnqeZQvvIf+IT/pSM+Crg4Oq2CrFeJBd8C75posUIdoO+CIufOn+aqlHxnfh5Lvta0txE2K1XgjdZhz65kDURyeTgBx40RijsJ3G4HfOJN0TA1I4D3PR51Yildc6B/gKTLoi2rwZGwA+6Ie3xYMALkho7nF/HzyKx6awhjIa3rr4li1QPpnqIIYzJJs9kvfEL+3y8Vzrd0qLWVqj8Q4krwOmyIqwNmF56QscGhhImtRsLl0SVro6+I0ujOvFkD5CQPlk6vkvoL+pVkdyNSJZvR1S9XQqEmM/etratkXBRcMIazDFuuQadUykGjHdkTn6uMjqrwJx8SxAQrYjeMBy1tYsk+YrRC70rYpJFQrGETpw8jqZHIV5A5wCbqhYQeriYYTyJo3VYwkNKxCmsrkWixe5TkRSG1BiSUmT2vQ2EK/Nu5DcwK/8UHpIdbgA4aIjc0k1f2cyRA2zwgIMjUJO22ff+1dl8EiFg1hEaKKPWVIpBDFHWztcthaGxS66DQdAcuk//V6D9sJW/LBSp9lNbydW/WwEQFVT/BYDrOg9f0CH9pUYY/Ac/rGRasV25YJWRMuTJvNDN0Q117/Q0M4i6gzzttMvpP9d8DChlH7uttcP/21DfU9MxUEP0mWXLtz3pSIZmw0aS6qRcyWn8Fyo8bosKcxnareV9/0rgUA5ZdQf6PyjN0UX2Sutx3TyVT2yvmBllJEfXcQeUym7X9dhoa/FdWjoQMBt8OpWHdlJ+fSn6RGsgP2kUgc7gsQMf3P1/5vowq8ULq8eC9Ln4nCgPQRoNPcBZaxAldWcVX04jasNmhZdiUr
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(81166007)(36860700001)(4326008)(86362001)(40460700003)(5660300002)(82740400003)(36756003)(40480700001)(356005)(316002)(478600001)(110136005)(8676002)(8936002)(2906002)(82310400005)(41300700001)(70206006)(336012)(2616005)(426003)(47076005)(44832011)(26005)(186003)(70586007)(6666004)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 18:14:31.3027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3082ea0-b394-43e6-bbec-08daac7d9bf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

of_create_node() creates device node and apply to base tree dynamically.
The parent device node and full name are required for creating the node.
And the caller can also provide a property array for the node.

Inside this function, it creates a changeset. Then the new device node
and properties are added to the changeset and applied to base tree. The
pointer of this changeset is saved in device node private data.

of_destroy_node() removes the node created by of_create_node() from the
base tree and free it. It gets the changeset pointer from device node
private data and call of_changeset_destroy() to free everything.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Sonal Santan <sonal.santan@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Brian Xu <brian.xu@amd.com>
---
 drivers/of/dynamic.c | 80 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h   |  4 +++
 2 files changed, 84 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index cd3821a6444f..eca28b723706 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -934,3 +934,83 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_changeset_action);
+
+/**
+ * of_create_node - Dynamically create a device node and apply it to base tree
+ *
+ * @parent: Pointer to parent device node
+ * @full_name: Full name of device node
+ * @props: Pointer to property array
+ *
+ * Return: Pointer to the created device node or NULL in case of an error.
+ */
+struct device_node *of_create_node(struct device_node *parent,
+				   const char *full_name,
+				   struct property *props)
+{
+	struct of_changeset *cset;
+	struct property *new_pp;
+	struct device_node *np;
+	int ret, i;
+
+	cset = kzalloc(sizeof(*cset), GFP_KERNEL);
+	if (!cset)
+		return NULL;
+
+	of_changeset_init(cset);
+
+	np = __of_node_dup(NULL, full_name);
+	if (!np)
+		goto failed;
+	np->parent = parent;
+
+	ret = of_changeset_attach_node(cset, np);
+	if (ret)
+		goto failed;
+
+	if (props) {
+		for (i = 0; props[i].name; i++) {
+			new_pp = __of_prop_dup(&props[i], GFP_KERNEL);
+			if (!new_pp)
+				goto failed;
+			ret = of_changeset_add_property(cset, np, new_pp);
+			if (ret) {
+				kfree(new_pp->name);
+				kfree(new_pp->value);
+				kfree(new_pp);
+				goto failed;
+			}
+		}
+	}
+
+	ret = of_changeset_apply(cset);
+	if (ret)
+		goto failed;
+
+	np->data = cset;
+
+	return np;
+
+failed:
+	of_changeset_destroy(cset);
+	if (np)
+		of_node_put(np);
+
+	return NULL;
+}
+
+/**
+ * of_destroy_node - Destroy a dynamically created device node
+ *
+ * @np: Pointer to dynamically created device node
+ *
+ */
+void of_destroy_node(struct device_node *np)
+{
+	struct of_changeset *cset;
+
+	cset = (struct of_changeset *)np->data;
+	of_changeset_destroy(cset);
+	of_node_put(np);
+	kfree(cset);
+}
diff --git a/include/linux/of.h b/include/linux/of.h
index 766d002bddb9..493ef957c1a8 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1475,6 +1475,10 @@ extern int of_changeset_revert(struct of_changeset *ocs);
 extern int of_changeset_action(struct of_changeset *ocs,
 		unsigned long action, struct device_node *np,
 		struct property *prop);
+struct device_node *of_create_node(struct device_node *parent,
+				   const char *full_name,
+				   struct property *props);
+void of_destroy_node(struct device_node *np);
 
 static inline int of_changeset_attach_node(struct of_changeset *ocs,
 		struct device_node *np)
-- 
2.17.1


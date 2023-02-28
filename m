Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CB26A524A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 05:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjB1EWA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 23:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjB1EV7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 23:21:59 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2116.outbound.protection.outlook.com [40.107.244.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEA7265BD;
        Mon, 27 Feb 2023 20:21:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhCOoGoS062MXqexnIUacdbTttlCWhWuxEcI7rQP7lJseuM4hzEoyUFvWNa6UmkDR7vZaHCas0mJf98UHKJx3UnrCqUH0WWck3hVrBeArC34jQmaemKNGYitkGbcNT9PZqGY8t80XNEWKNFLH+tUPRHb5XKYO606pU08wa0OU5l+0lbDCuBW7arF2hwBGk2hyGcXJFBq0seQdUTA+k6bn+7Bz47bEz/MAtgOY7HurDkeRzn0CkqNnB3xkTd9CJd5BDgVyd1tC63unj3mo+BXX3ftasMd1DflSB8izClMfII0/UjV+5Q/8WFjYgf9W1n3yUBtww9tFBK4Pyv6nsUBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdyHm+N58UlbZO7Gmi6onc7rUlBRHFd8CHGNB8G2p8I=;
 b=SyJus1RS3EsbK0pKT0fJbdSHy3d+xBK5Gaw35PiMQnIJYZineVnvU/4kU/FYMMySZJ0kNQzxvy59bVHnuuCCICQWXqdpP7i5a7EXsucCE9pMWGJeDu2AaTFzCAUi7WgSIWdSmogI86+81jRC+5X28JuEha4vhJzb86I2G6HcoonBlM0Zri174U5Hm18RmhiFlC8QPqUl3I5XMKrnLMe9X+KXQ/DFvpmmCmdFgn6o8NMrxDL6LZxKCx2H2ZMvEnpbbGtDK8s6qo89LMO9VzC6vDrLsEc6GROaoAotkNnHN9ZKjOzVQ6ewIjBGqJval9GSAQeAoABIVS3f3X7GWo/Z3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdyHm+N58UlbZO7Gmi6onc7rUlBRHFd8CHGNB8G2p8I=;
 b=W9DjsTcyIqbem95FUShNmVvei6ZCT0alGebxHZxeWu3KIHcLJxiAlp0r7NNOcrbmgJQSSeAsaZDLudBQ8NuAWoeDlsQ2UtfWhU7BxGE5H/I3C847IWeS2OIzAEY/hfhDAAKagxhyjaIwOCAFnOBFfssQOI9C5sz7yXF8hk2/ge8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 DM6PR01MB4700.prod.exchangelabs.com (2603:10b6:5:65::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.25; Tue, 28 Feb 2023 04:21:53 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a%6]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 04:21:53 +0000
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org
Cc:     jean-philippe@linaro.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com,
        gankulkarni@os.amperecomputing.com
Subject: [PATCH v2 1/2] PCI/ATS: Add a helper function to configure ATS STU of a PF
Date:   Mon, 27 Feb 2023 20:21:36 -0800
Message-Id: <20230228042137.1941024-2-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230228042137.1941024-1-gankulkarni@os.amperecomputing.com>
References: <20230228042137.1941024-1-gankulkarni@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0109.namprd04.prod.outlook.com
 (2603:10b6:610:75::24) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|DM6PR01MB4700:EE_
X-MS-Office365-Filtering-Correlation-Id: a962cd65-22f7-48e2-c64b-08db19435232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9dpGATL/ylPETjt2LQFOPFoQBqo5TSnCRFM/UwjMeFaVy4aHLgZnK0teURnX7GKGGpvA0GFX5PdA16ZGJ73ChKoPdMcPc5kx2vYdF5Qqp21ksRvv7WURmFAzFFucKzHDw+/V4EXSk1YqDe/2lnAggyL+SvPf3dKDizl/2seSvqPAcuyRQ4Y/1nANNBg6GuhV2ELL/Z4qdPl0BrDIdQntGJq7/xS/31FQV2qhMzy1D+YnhO5IgFQ7fD8W9cDJJkzs4W52jLsQ8K4sTMIKTZa6NlM5HWmtkH1+TOyRB4Okg4Lt0wJpQ2+6S8E8+5w1HeXmowja1n/AmG+9jubXuuvkn+S14v51zqZp+8luQHmwtEVgt6fg6wG21QQku/0e7J2H2M1z9w4V4ovNk5lIJbdoCsJzYya52McCCRrnezJAT6EyIFVINwsx0kbn+Bf5mcTsRt91KiGVZvh8DdmavD2krtY1l1QNWDpeGedRdEgzkITXxyI/qKmqUcR3SNZNzNswFdTxT9e5isMRxw8LxC/MoPJz2G/02+Q3y3PBRBct8fq/1covXN9Xyn/6NuaCliIrAl36qxVWMyb4pH9PLj4S+O8Q9hQpJPbFNui7XPeJ50RUUL2HNDVVjcoMnCo/5ort5V2NZE/gzAQTK0djx61w1ibU1DyYexq6x72A2t9Fz6qx8V4ORDQl2QRQ5IhPZm/7HUkDBYmUVJZ+Bx6uHqVPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39850400004)(396003)(376002)(136003)(451199018)(86362001)(316002)(6486002)(186003)(8676002)(7416002)(66946007)(41300700001)(66556008)(6512007)(4326008)(8936002)(478600001)(1076003)(2616005)(6666004)(26005)(5660300002)(107886003)(6506007)(66476007)(52116002)(38350700002)(2906002)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/j9GOjpUcozFwNSp2aA4l2zd4PSOXc/7YKj1/RGG8uGE32RVVBs8OWYlBFFI?=
 =?us-ascii?Q?d4sPnvojP0QfYj8n/IN6n/Gspe3fOjA28Kq53BEq2fKX4Aw2W87b90ZBMGhD?=
 =?us-ascii?Q?/ENKvwt0wwe3hRC2mY0JFEM7K1Ag2iQDAWZ4cYMy9K/Klwcb/WjD5BD++QH/?=
 =?us-ascii?Q?Y2dAP4+pqrZkhxQDFgUjSRMsobBXFtKKwNiXW4NK2af81mWM6iQt5w+WPgZn?=
 =?us-ascii?Q?0IWeW7tfnTl1o/q2T6ZJAcPuMD+n3A7Dmn1UmdvKOhbVHjzzi+vkZZKRP/2F?=
 =?us-ascii?Q?CfJ9Q7EkX648qqhu5BQjWXXtMM6F21IySpKuuwyLMDRPoahhhDQPm5XQgZOl?=
 =?us-ascii?Q?Gu8anB0VkFYRQp2r+8pdtmpWre5jBzeeNIh6m9Kee+6w3lmFoldR8DJL/s7S?=
 =?us-ascii?Q?eZ45EBIPbQbfy3k34qlCZXpDTeN9YTq7riYgLBFK5L5uJOv1egLALDNF0ZRU?=
 =?us-ascii?Q?bFbcoN9omKIedVnTUpU74dhTrUMH2AKif0WEEjm2pkX0HZxrLXPj5xl+ZpKT?=
 =?us-ascii?Q?4qBzMbf2NXUEL7kSF7UTNsAyGufb0FjMxKS7rqC3zXKVblwCbpnIdNHVRZ/y?=
 =?us-ascii?Q?HSZVQ2Ol8n1JLqpM78fLVpUzJ9Slg4d50WcyABic4gWqJUngInDGOoE3mYPb?=
 =?us-ascii?Q?6GgukyImRD8YLN+AjnketimYnCTiysoDvh97sbRdPA2B8Ta6+BjS01Vwqxnf?=
 =?us-ascii?Q?kOBB9R5ivWhGK2E5ao+kDORsOVXiXmux2ShbGiKfCAFcZp0zdEb2haOprb3s?=
 =?us-ascii?Q?jwbmbuxcRt2El7tAGs+8BGDYN8qcJQynrjWBMPVlV1Iy52D1DORBWhcwR/Cb?=
 =?us-ascii?Q?xojgHpIt41MEDZhx0JrqbGlfcvuJxrH4Q95gpJnBi3CDlZIDWgPuAs1FJH95?=
 =?us-ascii?Q?kycaSFW0YSQkY3umdf3EQrElJdxX8eSDZ43VDrxel5uQcoHS5nTYdXeM8p1n?=
 =?us-ascii?Q?QIrd+/MamDRy5FMDLFLOD86Z3ZlfRIksx6SHwehYKGp3ZTja5QHgLCXKZIpd?=
 =?us-ascii?Q?bEryLXnVVjzBgDcKEDyWpwsBNJGVtsZDAvcsG/GZPqfFQwUT2DtwUhzTYN3s?=
 =?us-ascii?Q?XrxJZ/7njoC2COrfQ6nKz5wUp42OldEW5jW/BHLKM0ksGQ6iwJvRQJBVxCtv?=
 =?us-ascii?Q?Qv2HMJ1XGr4DKTcRGAzoZ49lhyJOeQo6FewnjLCchdseDYUGwC09hBF6kICd?=
 =?us-ascii?Q?V1DcnWQWABRXkivUTFaSOBFlWSdYDdYLEI1bPbI3Wv+LxOdHqTS5wdWAXI8w?=
 =?us-ascii?Q?Ty3hXPQbcmwrzhKqN2o5DGDDc9PKycDkJh+8DcL2vGGTiap/IFUJxZ2ITWwj?=
 =?us-ascii?Q?paHbXYMsmj9IRqjrXvaIqUHZ9gPAT7zar25En3Sk+00C7y1YqRfz08tM7Nxq?=
 =?us-ascii?Q?3D2xMcA6+8Fpuu1V/g5DD3SiB1RnS1XyyW9XfG6Mu78YV34jjXj+1atSUSNf?=
 =?us-ascii?Q?1zNhZLpPc52zSzWYJEFY4+pdTtgL74t1sNc+BHgTfES/y1xIpeeZajBXTOxg?=
 =?us-ascii?Q?+8BJxdHD6Oy0OIGedvpD6N2X5aDHfjCZT8rtpW/sSxvENHvFIxvdG8kvxrDb?=
 =?us-ascii?Q?Qks8R2yPzVhbBrMi0ORnjMt/DEwHnllhMF/94LYcE7Pqmb+q5ZxnqrhoZqnG?=
 =?us-ascii?Q?3gfB8QiAl2pbyfuGw4QxlqA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a962cd65-22f7-48e2-c64b-08db19435232
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 04:21:53.6869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtkrA5WqKV9fGSlsuWS2l1Ta4B29MZsGp44AH1lB0cWlUvvgxM63ItBZfB7prfKQC0w6ouaMzyyKRHYsqf4C0IwipgBk5hKHQR/5N2oCgeBE+bMc3h6b84OOU7kiZvKw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4700
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As per PCI specification (PCI Express Base Specification Revision
6.0, Section 10.5) both PF and VFs of a PCI EP are permitted to be enabled
independently for ATS capability, however the STU(Smallest Translation
Unit) is shared between PF and VFs. For VFs, it is hardwired to Zero and
the associated PF's value applies to VFs.

In the current code, the STU is being configured while enabling the PF ATS.
Hence, it is not able to enable ATS for VFs, if it is not enabled on the
associated PF already.

Adding a function pci_ats_stu_configure(), which can be called to
configure the STU during PF enumeration.
Latter enumerations of VFs can successfully enable ATS independently.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 drivers/pci/ats.c       | 33 +++++++++++++++++++++++++++++++--
 include/linux/pci-ats.h |  3 +++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index f9cc2e10b676..1611bfa1d5da 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -46,6 +46,35 @@ bool pci_ats_supported(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_ats_supported);
 
+/**
+ * pci_ats_stu_configure - Configure STU of a PF.
+ * @dev: the PCI device
+ * @ps: the IOMMU page shift
+ *
+ * Returns 0 on success, or negative on failure.
+ */
+int pci_ats_stu_configure(struct pci_dev *dev, int ps)
+{
+	u16 ctrl;
+
+	if (dev->ats_enabled || dev->is_virtfn)
+		return 0;
+
+	if (!pci_ats_supported(dev))
+		return -EINVAL;
+
+	if (ps < PCI_ATS_MIN_STU)
+		return -EINVAL;
+
+	dev->ats_stu = ps;
+	pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
+	ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
+	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_ats_stu_configure);
+
 /**
  * pci_enable_ats - enable the ATS capability
  * @dev: the PCI device
@@ -68,8 +97,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 		return -EINVAL;
 
 	/*
-	 * Note that enabling ATS on a VF fails unless it's already enabled
-	 * with the same STU on the PF.
+	 * Note that enabling ATS on a VF fails unless it's already
+	 * configured with the same STU on the PF.
 	 */
 	ctrl = PCI_ATS_CTRL_ENABLE;
 	if (dev->is_virtfn) {
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index df54cd5b15db..7d62a92aaf23 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -8,6 +8,7 @@
 /* Address Translation Service */
 bool pci_ats_supported(struct pci_dev *dev);
 int pci_enable_ats(struct pci_dev *dev, int ps);
+int pci_ats_stu_configure(struct pci_dev *dev, int ps);
 void pci_disable_ats(struct pci_dev *dev);
 int pci_ats_queue_depth(struct pci_dev *dev);
 int pci_ats_page_aligned(struct pci_dev *dev);
@@ -16,6 +17,8 @@ static inline bool pci_ats_supported(struct pci_dev *d)
 { return false; }
 static inline int pci_enable_ats(struct pci_dev *d, int ps)
 { return -ENODEV; }
+static inline int pci_ats_stu_configure(struct pci_dev *d, int ps)
+{ return -ENODEV; }
 static inline void pci_disable_ats(struct pci_dev *d) { }
 static inline int pci_ats_queue_depth(struct pci_dev *d)
 { return -ENODEV; }
-- 
2.38.1


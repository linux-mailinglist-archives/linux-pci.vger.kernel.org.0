Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7826A4289
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 14:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjB0NWb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 08:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjB0NWa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 08:22:30 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2094.outbound.protection.outlook.com [40.107.93.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0962C1DB85;
        Mon, 27 Feb 2023 05:22:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of/38FpxvJudbDV+xnBelDTY/5eYUo9z985lmPk7Eqr4bMRMmROCyIhMOWT8APsiJ3D8DBzzDtemguN2Vj5AmbR94/V7THJxpRHiVq8qH2mvunNXVv+zkj+0gX4FN32ouEO2Ezf/93q6ebvSlNKGmDw7Y3j8fmDSZ1HY149MGZL7TX2Ll6eNAvuQHmIBqI8kwBE7XyMUGayUQPj964tphjO76DPtn0W20/YOOdd/lD7KfNF00NMUK4VpL3kTXX29dpLR6zQxjUAyKDUI2rc/RuwRHL7NsjFaD1pDmoCRuOIDI4kRL9pdgrVBARNFX6JMBLlcX+yNrytDy4NvdMY2oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQ2KRr9Ghve1sjeFkGepMy25F0bIUg6LHFHFozopTew=;
 b=lIib8MG3zGtv1KwbBdefuVxJ2XDExJFXezDj118AFde7tlhNsG8/nK6UoeQUWTH3Pq7QSl2K7QfUci4pItMkOiDRjedxqyhISiPzGuW4vNKVKEiTG7ej67bzTCjd7c2sD4BXv/crlCtdsn0Q8Xs8T7yeZNEyHVaMYI/wBTJW/mWAIi3+DdLmTBo4/KE0YiZhLBhqLZi5N922kkUL0kb66ghWpgaCpm+jazarREBBpQtAjYipjSXl/rAJswiMxhLr7XyO+EqdN1I4XK4rRfw8toA9uEcOToZhC8wmNh90FX24ZcgnplqPBGbctqtj+qoVNLTEkzL4aYZUHNiJnY62wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ2KRr9Ghve1sjeFkGepMy25F0bIUg6LHFHFozopTew=;
 b=k7RL8aPLyv9cC/sSviSxfGhYqf8C3D09hzQyAsFgpwUVEcQgMseBUMgJuZrMRRprzdBeHItYiZXk67eLEjGDUfAAy34rJqDNVBXYzBmktrJmrfQ2ZHwCvfRk54SlTP+UOGcQvFX3spNX94l5QsKD8TVrK7nbtvVHS4P2s6a+lc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 MWHPR01MB2719.prod.exchangelabs.com (2603:10b6:300:f8::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Mon, 27 Feb 2023 13:22:10 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a%6]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 13:22:10 +0000
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org
Cc:     jean-philippe@linaro.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: [PATCH 1/2] PCI/ATS: Add a helper function to configure ATS STU of a PF.
Date:   Mon, 27 Feb 2023 05:21:50 -0800
Message-Id: <20230227132151.1907480-2-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230227132151.1907480-1-gankulkarni@os.amperecomputing.com>
References: <20230227132151.1907480-1-gankulkarni@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0013.namprd05.prod.outlook.com (2603:10b6:610::26)
 To DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|MWHPR01MB2719:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b2b6d8-83ac-4931-0ec3-08db18c5a18c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3T3QlPI94M+YGeJBZGOLjybR3CZtM+TmDEHcoCc0HuWfYxd7No9sQRnqYTcUkxS+HOoMtWOXnvV/50KMtynaouqgz1oVm4OwExltBd7EeCBMez7j7W8I574RL0EYwm0xGoZspBcJDO5rSVUmK8CvmUWfCyK48ZUKnc4M+CQ9bTQ17egIZJF1xH8TDI1aKnGfarFQAJSuFUOvbfJZgGYhh1vgOaszHunqUfusdHm1P839j5vZIEqP51I2af/6ca8ee0XW6lVzwi8dqCl3th+KW+Tn1rXjTVNXbfMbBmm+1nW/tGz2c1i8N2zT/rIkv4o2QID9sBCgHglzrbskcO0s3KTKmMYFDEMkAv9TlNUMYszLmPFB0sS8Xu45nGnmJ/1JNaW3rqsK6ClrDRn4ZAGIQZZaN4sOzShNxUXXJz9EiSeeOsGJ0Nag8ER4gh1HqklTCYm8ulO0l6W4zMl7gEgdDlXhn5ce7vgDbVBKX2xdYtciNnwvp151VR0unNVKBQWUjtw8ZGqeXk7rTENJlijVUTipXgq07S0deRffYr4E3l/g7dHrdNHj5o4eMGRfLb3AaoyUCh2oer1zfd/qKfvw36jeKp7YU/CXjOJjuUFLlSHRWwXjPZFU9QNUnfUT8C95gQQwHDQy2AJ82TBx8AhiFoLhR2FhfV1l4Gk5YVRlOa67IGKo3xjVtM433SpZFcwublgZe4UhAK6t0mAosVCUeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(376002)(366004)(346002)(136003)(396003)(451199018)(8936002)(2906002)(5660300002)(41300700001)(66946007)(66556008)(66476007)(4326008)(8676002)(316002)(478600001)(6486002)(52116002)(6666004)(107886003)(26005)(6512007)(186003)(1076003)(6506007)(2616005)(86362001)(83380400001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A9/fO0bkSHhbdc0wxkgEGC5gVKHSxm6WCSBlZ4pq1WVmMS2XacF0sa/MjtST?=
 =?us-ascii?Q?lLwBiXLu0ffBN84xrqPlncOtP40Pk0nwSd6AV0fz49uZGnnSLgm6nNPrTGO0?=
 =?us-ascii?Q?ztrf8c7vzCF4ji2jZPBuu299yznhLnLsSWi3dHiawuvkyZZiegaKNE994Ugi?=
 =?us-ascii?Q?aJlug1wOESPgeERjItldsTV8S48bHQLECfagcUwr5vGVbzq2AleTcxkFoAfa?=
 =?us-ascii?Q?3qSdRaquJcu1252f8fskeN2hFXED1R1PwLw/FktADuTyk38cmtlUpJ50n3Eh?=
 =?us-ascii?Q?/OsQyahdDUqhjwy8trFqECWvgjHDzITdJngICBl9192cbp7nh4ofTBufRkfz?=
 =?us-ascii?Q?emhaXViERQ8qJ+f5fd30jUfJ7d8FS1E081V81tjm6RA2L+PSrj0optwIViUi?=
 =?us-ascii?Q?qjFzQ2q1cMGeSnuyi79LKWXwLHc2ALOQy9rWSJSWUsGImw/MnvYIR9xXCL4m?=
 =?us-ascii?Q?b1mhL6Ng12qho5hZttZaP0H4CXBsG+RWouJMpAgvCJOs4l2NS1IuaRWDj/XW?=
 =?us-ascii?Q?HvZsYZcTJlMmDucgpFHCt/ge+brY3zq6iw1aIdt7WkBKFJ4LugM+R7qbbO5E?=
 =?us-ascii?Q?vtjY5hQQr8zLLO6cPOI2iSEdzZmrAILskAXMuSxMIGFHfE2B6jev2r0UTXZt?=
 =?us-ascii?Q?BYy1QuLbMZ70YDyz2HZUdm9F1Ea9y7lmfCYg0W1wnlMEBJAHwQ0wb9W+Fy6M?=
 =?us-ascii?Q?oVnMlDtXEs0hmHQxh4E6OKHFYQSCemI7OA6y4ULfLeCL4LSASrmwYiBiSUL2?=
 =?us-ascii?Q?bj5hu0p7KgP2WHN+vZOLRJ8J2lADjEw40lj4K2JEgqMKfZ9MK1ddECD+YC0x?=
 =?us-ascii?Q?CuL+wrszVVsJLu7njZ+3YacUy2GyQ+Njmvg5A+1VZHxmMB+PY+VSTFt7gEVo?=
 =?us-ascii?Q?RBNS0oeNkm8+ii2uVUX5aFbiSlm/h3TonIa988AG6iqvDEVuzkXnMpqHCoJs?=
 =?us-ascii?Q?hWbDsR+FCJmufNtmVwGYtKo+WU367iW/B5JnvfpvHdN5ymVuLjacfcT239Qu?=
 =?us-ascii?Q?Py4x9Zhug6ztQyGJ5Ytf5DcI0rA0h5MO3yeJwYJEMj3G5wT7iC8X3BUGgYTc?=
 =?us-ascii?Q?EKepUt9Jjxt3ifd1qEPO54fy2DKnJSaowHWEZ9BBlxCTYYThQ84Z524Eeb0o?=
 =?us-ascii?Q?dB549qAn4ULrZoS0twKeh9DRjJbFdYxRYx84ahD6AMqaXakd9mdbTYQMPEF1?=
 =?us-ascii?Q?G3ongCjCrMEl2I8KKOJU/O2phplwjHD+u7YDCjT5Ri/rNNCklOECtUrK1yLM?=
 =?us-ascii?Q?d4U0zXvFCMErKrkepNUMIWiTaTnMuoGYw2cheGHflB8cnTC/sDn1x062S3OR?=
 =?us-ascii?Q?rAsruy6sFjOyueJoD/uzRTT3V1wDu6mRp5clvN0oyW2KrI+ri035eRLN8dx2?=
 =?us-ascii?Q?v+ZcSGI5HeiXnYGE4vNh+9Tw73g9YEBepDpqQ0QQ90N+EOKzrwTVZ/zJspy6?=
 =?us-ascii?Q?ndasAv0Z0d0cIZkisY30mRzHSvdnKF0a36FyYtcmKM47f4cgEFYdfyUjNjpm?=
 =?us-ascii?Q?IKEZjRUVsT3myBQ+t3HsIESZnqhNPlPm+JKNE0K6vS4yhufue7CmfnRZM6k/?=
 =?us-ascii?Q?HY1jcne3EHMdGS1ZRvqy4IFNYfIyXNv7sFcA9OJIquhOKZXgNO80W6Llyyju?=
 =?us-ascii?Q?botPAIHhgrFRqI6fDDEXd7k=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b2b6d8-83ac-4931-0ec3-08db18c5a18c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 13:22:10.2553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2c9dg2mrrpPrdZrr3qBX3s7UPFKTMLgMYMDIwPnJaBjZKKI3jv9NJuMwKW1JlpeSPS54d88COSkV/F/HOAU86qVQ7guuxqLSARzBLKnBKYZdYToY8HC9Wgd+LF2xNiVY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2719
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
 drivers/pci/ats.c       | 32 ++++++++++++++++++++++++++++++--
 include/linux/pci-ats.h |  1 +
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index f9cc2e10b676..70e1982efdb4 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -46,6 +46,34 @@ bool pci_ats_supported(struct pci_dev *dev)
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
+	ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
+	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_ats_stu_configure);
+
 /**
  * pci_enable_ats - enable the ATS capability
  * @dev: the PCI device
@@ -68,8 +96,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
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
index df54cd5b15db..9b40eb555124 100644
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
-- 
2.38.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0664332FB
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 12:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbhJSKCN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 06:02:13 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:17570 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231652AbhJSKCM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Oct 2021 06:02:12 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19J9fJuc029874;
        Tue, 19 Oct 2021 02:59:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=A9G2cgHCgbx95s20um1cDePzJ6fjoOXyem0svIJe99A=;
 b=g4et5rmTvIchNih2hyL8QJBdE3v+RhnFuH3H8/Ao6STUxu6Aut/ekPQofV5/zyjTdVxG
 Nbq4iJ0sgb2idLj7gHP3V3wrLCxb5Fh/ecVkRo7dxSzmLu/J5pSZVcxbDqadCQxSzTDr
 XmIqNEdemfan7Rpe2OBaYisK+65yogOkf7jr4oM/m7b6kJ8/Op+ecc4EsCKmJyrt70VM
 xp7r7g4TF32AP8ZJKJ4jk5BrHkRpqXTcXXbDCfA4cbNtZYn8QobMQ1cpbh8Uw8iQmshR
 xsCNhTYYtovw9tKY+vD9wiNRH2Heu3LGYbR6dRorPnWVxs3VhrFEuOmfVUvKhUmzyeuA TQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bsmtb096q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 02:59:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWOstYI/5UxS1mMIuZlOT2gfDRsReK4tjSd+kXaHokBM1ZHvQfLLeOn+Rx+s09jFy1V3RaMQgDGgc/x2uDzz8Y2Y1obz2ExUdSAVoTdIQLF2mm318SPUpXUjc0h71u7f3XojNeSdhDZpxRrwoJDm01oy2i6/MOvklCLxoVu2MR/n6ZTt2ej4BYuI6NsNxLITF0/uT7Dwm4Q+7p/mPUzwgC4Z+yaDvtkOwrBmSyyeCdGrPCTSX/S3QuO7NpsKPR6I1ojlQXcQ3bDatZJZc1mQyVCa+jeB4F+0e31TrzS1nWbI445rFhmx7oSAn7fOAheQO2/PhOmG2YHdVsOw5H0Npw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9G2cgHCgbx95s20um1cDePzJ6fjoOXyem0svIJe99A=;
 b=E5uPSvyJO2jTi7aiH8zR6e8H4PzB8rodmy5wtEJRzcXvmCRUQdKfbm+MHEPvOm+bvRHqb5krJif5+roqaAzL/O3sLsKy79o3vtKnGvApej4FEFeCJIWSN4YOFxJZ5jLApyD2Uo6frQZXK0smxYDSOzT/33s2a0BlMULDgqg6+OxQoqHP8CUgcZATvgkNoqYbSBfje/vUfYHl1Cn5mo2yEMWXNKOLgUZ+IoCscmLEznmtQtz9lfhxoNfAns2tytZumfGesLBNqaW25+Pn6sqX8Bpn2BLHixyPPuEa/ValC0yoskYP6v9J3LJqTyiQy5moNMDIEvNnEYTseRvQ7bnf4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: glider.be; dkim=none (message not signed)
 header.d=none;glider.be; dmarc=none action=none header.from=windriver.com;
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB5207.namprd11.prod.outlook.com (2603:10b6:510:32::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Tue, 19 Oct
 2021 09:59:40 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::c11a:b99e:67ce:4a14]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::c11a:b99e:67ce:4a14%8]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 09:59:40 +0000
From:   Meng Li <Meng.Li@windriver.com>
To:     geert+renesas@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        lorenzo.pieralisi@arm.com, kw@linux.com, bhelgaas@google.com,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        meng.li@windriver.com
Subject: [PATCH] pci: pcie-rcar: add regulators support
Date:   Tue, 19 Oct 2021 17:58:58 +0800
Message-Id: <20211019095858.21316-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0175.apcprd02.prod.outlook.com
 (2603:1096:201:21::11) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
MIME-Version: 1.0
Received: from pek-mli1-d2.wrs.com (60.247.85.82) by HK2PR02CA0175.apcprd02.prod.outlook.com (2603:1096:201:21::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Tue, 19 Oct 2021 09:59:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b97633b2-d3ed-4562-0da4-08d992e72a9a
X-MS-TrafficTypeDiagnostic: PH0PR11MB5207:
X-Microsoft-Antispam-PRVS: <PH0PR11MB52075668475FBCB2B4A02474F1BD9@PH0PR11MB5207.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SlpVccZtSoQVffAUlmiKOkarA+BEkSygo4EpZyWQeuqHIAKpWnYT/9viKyvQdYRwm3k9WXDGw81fxUSud0YDUvQMEwBXtVN4Mt+swxrYtJxK4I6djrnw2WKM8D+K01lFHi4JIbRJ0MQnhcARUf3zHc21XsSId2DuYv5tegiZ3Z43AjznTeXYg7+2p39C/9+aDVS1uj3QYG8QdRsanGCqYimTVuBNvIqvqbZTPrSS13Y7j9uuC4p6cAfQvDl0kd9DCHVszGCnYphVRW8nZ2u7GRtaJ1r6ubBVbMZ4Hh/iweUTHIVBrWGIb9n6nTEHZi4bGpaWuAUDJm3HEYhbrBUsAiTGaQEH1VOCpgpJ9GZMA7+G/CIRz10QD/8/5XGyOC1dj21clTalOdNMn72gDwPzHV9zh3rKRw3dhYRxrXXiyFidF3buWUyescZjTBW70PSxEEk3/pcx7BOmhOxOXBmoNZQM8A4UAAxoZ7auTip2c3EXYEt42NRPwjaYAU4ti3OAHBO95rIjmKpUP6QUXY3RsSzhLcHpC6yDMTyEVZGImDThqlbDdfx7vGPvh3k93bNfJeO/JFA4teH6buAF7jP2Hxy0XPqMtvXtI6PaTE8dpaLoay1uzSTBwcsQ7oMvKNUqG5pKmu2XY0lvjkVwbUfvOlgzDyDGslPbdxZ3XR5xSdELw1p6vAsqCmSk+3LmvbVWqzM8dwqxYTlbc7Gfz5z5LuX2Q/2zst6HP07+zMS0EbA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(186003)(6512007)(52116002)(6666004)(6506007)(4326008)(38100700002)(38350700002)(26005)(36756003)(8676002)(5660300002)(7416002)(6486002)(316002)(107886003)(921005)(8936002)(1076003)(66946007)(66476007)(66556008)(508600001)(956004)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dYxJgUwrHc0NnSqU+oMFbhpPECiQoH+3kXhnlmT6/B0qW6f93VcGtmHR1QOk?=
 =?us-ascii?Q?UmdqoqZ5BNNS9TojzhvlEDGCJuDu0TXJuRsNbTpbx2OPn73kNC1ZrruYqx/7?=
 =?us-ascii?Q?+00Vi3DjypEK54fuJhfISkc4g/YxZaLM7SNRt7Xr2VsY0+97PXDaIL4hiB2Z?=
 =?us-ascii?Q?FRM46kOTrtT9PQdYf21OyfOkihTyBh0EzTF2CTbgnk7xjZKhWO1mwcgBLI9l?=
 =?us-ascii?Q?2Pe88bFxPC8dh9nhk+1bKMSJM5WfeckDzjFe/hSNevxS/Od+cgWe61aawvf9?=
 =?us-ascii?Q?3okjKO3clGOilqmWllsoSicmy3Ny3xRXOUlLqM6rAEyZb+o3P6ghSVb7cujR?=
 =?us-ascii?Q?/Z7D4dzReHMBX6xB0cdfUKPIHkOlbIZhalm8nYGaysCj/JO8/A/AZ6QigeKL?=
 =?us-ascii?Q?3/0XtXUDJ1qVInSVOETtFoLKEunyxbsst1phG61Fz5z7nC0tyJJTfy4OL5MH?=
 =?us-ascii?Q?oqHHWkvE1Zg7TbGCCEFnKX9ADl6nLBhYudkKlMPj+5aUgIK94vo6MvvZxtkz?=
 =?us-ascii?Q?DBKigWMpfUQRFbdh2/FDAcXwy/OqLp+88q1DsX5o2XOtQCU8qeYrznbuOJ9W?=
 =?us-ascii?Q?D80JoNOFVVn9hVx1xO9JTUJGwgd3nDr7JWcodcOcUYWwlqX+8Tdq2y/3YKeI?=
 =?us-ascii?Q?d6AE57zIlNkRmIiZ6NIXlfUCcbQ0lRH70Qf36DtunMxrEajz1/baOMRi4vM2?=
 =?us-ascii?Q?05MTJn37Yju9SI6WFiwECh/hB6w8HCpkzTB2/F92gfYLPG9oqgLZJX/zkftN?=
 =?us-ascii?Q?wmYKCoM2tuURjgPyM4e3p3cQaK/rtRhUsfFZK/Q5iWYi/0qHOpHtLDMEAUP9?=
 =?us-ascii?Q?QsZYtCXdHMEaFOFSz55drpJKcajtqZLmpKQWT4e9LhjURhRGdZTxfRy8dChg?=
 =?us-ascii?Q?h6ZCIQrcLnSseyd8RdcBKGwrPRDRwy+Y6dnv+6Eg1sR8jsDg37JiZ0m/o6IB?=
 =?us-ascii?Q?ZpO/WIqTadlAmK6gE6U6mFfIYzd706I14J2d6BKLjV/c0Ss1Oo64ZP6yfOoV?=
 =?us-ascii?Q?jBiaIKRPonPsLvkSTeDE0yzDHRnHPxkwGrjgyyyhV+njmBUkJiRXNApaOITW?=
 =?us-ascii?Q?XrsUQLr+xECgE/sQc4W+OxNoj2x6M/3e8QC/lJmTL/c4UXCXjjx0aOdS7tUi?=
 =?us-ascii?Q?TuaZfm9CCqwuzag621e7VlqShgY8fjxn/v++iRhH/6Sdb2oN7pKomwAOT/51?=
 =?us-ascii?Q?HaWkEeuyFSFIRr7cQeDtt+zeXB/9u+m2WzRMIoi2Rl6CcuAv/yccboYYTbjG?=
 =?us-ascii?Q?y0uRVSwPUpnZbS9in5WVqf0EHgkCzAVuy7yZ1ykZJZmbCobgIGW9l8HuUTCI?=
 =?us-ascii?Q?0XDexOYViNjVGka0ikHPmpGRNQjuDHBqYNgwXaRPKmUyuXPZljecLXVP7+RQ?=
 =?us-ascii?Q?Ci93vn8geqOGUB7p+CeTE2bMaQrlZgO47UvCsKu1o4WYnQa42bjItw8TGz2a?=
 =?us-ascii?Q?3RlUeX83DY+TM4S4E0ATHcggSkhJzawPL+9tTkXvMwyj6w9vRV4TL99KGvd6?=
 =?us-ascii?Q?Tr+o/bUbVHpRUHWSdmXU+BalJablOZ51bM38qOCCbKuQdwXXA7zWimhRBL5y?=
 =?us-ascii?Q?phAfb2UbE4SD67SJoLWfDXXnjgDyeTqr/ioH10x9nP1T3M7eSkagxyRrUDEY?=
 =?us-ascii?Q?15U0PvECWf9U3Jb0fHqlcS0=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97633b2-d3ed-4562-0da4-08d992e72a9a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 09:59:40.0879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUjKgrt8g+7H0c9eLBtKLYDRU7fN+yRu2XiR8+lpMKrMbKV2CbXD5GkZyhBBqkHjEJ7YSRUmcRXpVBjtoMw7lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5207
X-Proofpoint-ORIG-GUID: Bcvibt58hRD-FO_5oU71IoBeQEQZ2tYj
X-Proofpoint-GUID: Bcvibt58hRD-FO_5oU71IoBeQEQZ2tYj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_10,2021-10-18_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=974
 impostorscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110190061
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>

Add PCIe regulators for KingFisher board.

Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 47 +++++++++++++++++
 drivers/pci/controller/pcie-rcar-host.c  | 64 ++++++++++++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 8986a7e6e099..82e463c32a37 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -50,6 +50,25 @@
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
+
+	mpcie_3v3: regulator-mpcie_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "mPCIe 3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio_exp_77 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	mpcie_1v8: regulator-mpcie_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "mPCIe 1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio_exp_77 15 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <200000>;
+		enable-active-high;
+	};
 };
 
 &can0 {
@@ -241,6 +260,31 @@
 		interrupt-controller;
 		interrupt-parent = <&gpio5>;
 		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+
+		mpcie_wake {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "mPCIe WAKE#";
+		};
+		mpcie_wdisable {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "mPCIe W_DISABLE";
+		};
+		mpcie_clreq {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "mPCIe CLKREQ#";
+		};
+		mpcie_ovc {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "mPCIe OVC";
+		};
 	};
 };
 
@@ -259,6 +303,9 @@
 
 &pciec1 {
 	status = "okay";
+
+	pcie3v3-supply = <&mpcie_3v3>;
+	pcie1v8-supply = <&mpcie_1v8>;
 };
 
 &pfc {
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index cdc0963f154e..bf1e4007876e 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
+#include <linux/regulator/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
@@ -54,6 +55,8 @@ struct rcar_pcie_host {
 	struct rcar_pcie	pcie;
 	struct phy		*phy;
 	struct clk		*bus_clk;
+	struct regulator	*pcie3v3; /* 3.3V power supply */
+	struct regulator	*pcie1v8; /* 1.8V power supply */
 	struct			rcar_msi msi;
 	int			(*phy_init_fn)(struct rcar_pcie_host *host);
 };
@@ -893,6 +896,36 @@ static const struct of_device_id rcar_pcie_of_match[] = {
 	{},
 };
 
+static int rcar_pcie_set_vpcie(struct rcar_pcie_host *host)
+{
+	struct device *dev = host->pcie.dev;
+	int err;
+
+	if (!IS_ERR(host->pcie3v3)) {
+		err = regulator_enable(host->pcie3v3);
+		if (err) {
+			dev_err(dev, "fail to enable vpcie3v3 regulator\n");
+			goto err_out;
+		}
+	}
+
+	if (!IS_ERR(host->pcie1v8)) {
+		err = regulator_enable(host->pcie1v8);
+		if (err) {
+			dev_err(dev, "fail to enable vpcie1v8 regulator\n");
+			goto err_disable_3v3;
+		}
+	}
+
+	return 0;
+
+err_disable_3v3:
+	if (!IS_ERR(host->pcie3v3))
+		regulator_disable(host->pcie3v3);
+err_out:
+	return err;
+}
+
 static int rcar_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -911,6 +944,31 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	pcie->dev = dev;
 	platform_set_drvdata(pdev, host);
 
+	host->pcie3v3 = devm_regulator_get_optional(dev, "pcie3v3");
+	if (IS_ERR(host->pcie3v3)) {
+		if (PTR_ERR(host->pcie3v3) == -EPROBE_DEFER) {
+			pci_free_host_bridge(bridge);
+			return -EPROBE_DEFER;
+		}
+		dev_info(dev, "no pcie3v3 regulator found\n");
+	}
+
+	host->pcie1v8 = devm_regulator_get_optional(dev, "pcie1v8");
+	if (IS_ERR(host->pcie1v8)) {
+		if (PTR_ERR(host->pcie1v8) == -EPROBE_DEFER) {
+			pci_free_host_bridge(bridge);
+			return -EPROBE_DEFER;
+		}
+		dev_info(dev, "no pcie1v8 regulator found\n");
+	}
+
+	err = rcar_pcie_set_vpcie(host);
+	if (err) {
+		dev_err(dev, "failed to set pcie regulators\n");
+		pci_free_host_bridge(bridge);
+		return err;
+	}
+
 	pm_runtime_enable(pcie->dev);
 	err = pm_runtime_get_sync(pcie->dev);
 	if (err < 0) {
@@ -985,6 +1043,12 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	irq_dispose_mapping(host->msi.irq1);
 
 err_pm_put:
+	if(!IS_ERR(host->pcie3v3))
+		if (regulator_is_enabled(host->pcie3v3))
+			regulator_disable(host->pcie3v3);
+	if(!IS_ERR(host->pcie1v8))
+		if (regulator_is_enabled(host->pcie1v8))
+			regulator_disable(host->pcie1v8);
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 
-- 
2.17.1


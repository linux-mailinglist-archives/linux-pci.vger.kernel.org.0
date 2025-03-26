Return-Path: <linux-pci+bounces-24722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C85A70FD2
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 05:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63863BF072
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 04:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AD5184540;
	Wed, 26 Mar 2025 04:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zhQJ98KM"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3338F17A2F8;
	Wed, 26 Mar 2025 04:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742962522; cv=fail; b=TxQ+zKftaPx3Bughuz3b34flw5va1BDNb9S/sj3G1KSIoNbd1DL9GrriRQ1zki55T3OSqXYaDM7jGMatw3w48WN6xX7ANd3HeG76BNyJJRFNVi/2j+eW6XEilIxn4xTQZmGI2KbrZAL/AwSReFFkM785XC4hOc0x9Y2+U1FK54w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742962522; c=relaxed/simple;
	bh=6njdWkK7wWc65nyPZClYiCZwrFq4dAi5h5KyxgZKjrA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a87kxKoVFUxU35wltpajiVbwMqETGBpVzlc+l8oN8KFbX7xhkb3NNUDIoNOmPJsju0iwNEau5k0zAopHTA0pAfe5Oa1uudeQhLiX3yKjDyoo+QMYCh4/EIk4REhvfO43EOraHt6f1prfZScnl5TXS4aSb8GAxQeQhwHMhjDan0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zhQJ98KM; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ojgcv1A2gHswKpzR2sU6FDkqx5mVP3LZlMLXhLh/ISUQW8qlmdwUq7H/1ObcMTRCOdKthdWOsoQzg7Q0Ts32ABgaJiWXakJESNzGXOZHNH8Xog3tk6WmuKb6Z+FiNn7Iy/o1Xj75Xb1vlql1ROVPe03qBSn00zNFRlgu2VHFNS8/3D4Sh/2VeOt7P6kmdi823zwMTj5kQVLtDhQyUOTXE3DJXOuPR94ZwATUSVR6IOjJi7eBF/JWyaTkN3OE/rr1fD2uMaggSu8mc6x1+BxE0j+voZuSioB1sl7FpuwXsfYIuCirGi542lll5cUOqE608Sn7VTQxa8qNHGMEBVGnpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mmZY3CKZFaKfcsgOIJB6Xo6mIt9fX9RUJaE1V8uxWA=;
 b=Q5coaBnnUJ0kiinLHjZmYST4DrdoqVQRnQRGwtusxTTSfXUZDLvgepsokU+Di7LSFYBALZlNafVAUBAQ0v7735MSQ1S8e4WMrMHr2H0k9DLXgSrfxo3v10xRGF2aXK7bhEzpYax/J2yayYVwgWFaDISipEeCLVMj6a8WOWnSO4/+I7DzzOVkZuD1Xx7oWCxL7Di5wVdu+9H6L+Uu9ZITVEMoWkR6KMtMry5ArreTklITPmUikESjraKUfudY3gptW2tKoutZeBGnLLyNaya9bK5vSlsbeaYPUBSd6goKTDlj3Pic5127zMKHDe8r0DJoi7lLh6PhYea/o8gWAQL9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mmZY3CKZFaKfcsgOIJB6Xo6mIt9fX9RUJaE1V8uxWA=;
 b=zhQJ98KMVZVEsyYVfW9BaXbtuJNgNC3uZNUJjklsaJka2HV+w8rmWhlknFc/K07JDZGRNixHmO4OTbU0E7WX1hAmTshObzsi0X2NosR2CbOfeJVcm2ZTXRvyDJUc6P8DexnCiG84wcly+zVrqny9D66Scrm5v+jvuh99ATtquyo=
Received: from BL0PR1501CA0028.namprd15.prod.outlook.com
 (2603:10b6:207:17::41) by IA0PR12MB9047.namprd12.prod.outlook.com
 (2603:10b6:208:402::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 04:15:18 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::10) by BL0PR1501CA0028.outlook.office365.com
 (2603:10b6:207:17::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 26 Mar 2025 04:15:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 04:15:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 23:15:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 23:15:17 -0500
Received: from xhdlc190412.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Mar 2025 23:15:13 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH 1/2] dt-bindings: PCI: amd-mdb: Add reset-gpios property to handle PCIe RP PERST#
Date: Wed, 26 Mar 2025 09:45:06 +0530
Message-ID: <20250326041507.98232-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250326041507.98232-1-sai.krishna.musham@amd.com>
References: <20250326041507.98232-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: d22e644c-a78e-425e-3189-08dd6c1cd148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rpfs/rVLAo1je3L5wTaiyL9DxsNV4sL8CDBjVkI5z6kXQMSBy7ZNR0QQr51a?=
 =?us-ascii?Q?ZtBuSORHwmkJuGuu37lWVtpwUklL/4KoNw44E8GfnqE8McbYly/4gKQeAAI+?=
 =?us-ascii?Q?NDv1SsjLTktPFjP7vh5SdFDXa/uICcQ97D9UXZo6U2kbc6risN253HE+vY9g?=
 =?us-ascii?Q?34ykCDtukOf/0Q2fhPJzy2M24oETwlHaTtd1WBq3yw88sYZmuXaMKj21J/Km?=
 =?us-ascii?Q?YiCzI3ytTiWgfBXy1IOoF3ivHXpumwU0oaTvVLfmf9lEMrxiNAdWPsM9Ka94?=
 =?us-ascii?Q?VWbPDzYPL1dDY9Ev/TvuRV6JwW6693Gmq1RzwLF+xV2+Mx9H3TNKPDrR12dO?=
 =?us-ascii?Q?dOAUmuszAHG7Vw/JQGypfUCt8aqv3xIgHIGA5pefwrjmdGAhuLQdFlKmiGMa?=
 =?us-ascii?Q?heD2UuE8Wie/mt9CGqbnpGKzEHOScQQzvse6xlQ0IevTsKU2gnBdRSqOkRtg?=
 =?us-ascii?Q?/EjWkF1DS1YtbbB5JV3q2moFgP4CbahiQ6SH+d8SCSdNc0I3qOEIzn4d9jpB?=
 =?us-ascii?Q?ztgWv8zsKiwqjBp1E9KA65C/X6wTg+EaeYh9QxDZuVufZQ4VmAxZKcZ0810y?=
 =?us-ascii?Q?WSiTb3of5GK67b/mDSdrN6yHlvVGS6QA5Fbfsm2MqygErXppkL/NoihJXV7G?=
 =?us-ascii?Q?ThopnR9TdjR/8apFUUTl1fXsbxDiyCuMHMjv8B81gtO8XrecsUHFaeCWut9c?=
 =?us-ascii?Q?Lk5ITj+uqXH1pLzUwazrmHm4+2qD5AF+xdLMU3a23Pmqhl2kXuarTk3Yvtut?=
 =?us-ascii?Q?nXA07s4pUKHosseAft68Fc3+4Du6SBITmG7Wo1Q/u8fqazBXdDzWXios/c4u?=
 =?us-ascii?Q?WZwACmcb4jWigz5uIpz+jzDTi6Bf9b9e/qVpDS+RWD2L0wqO99mFpndI6eCM?=
 =?us-ascii?Q?aZsu0BVwpqgF3YfWQrSrV0HNAd3hAivHyCBylA2mMI5yvL5VHz/GrVfUEbZj?=
 =?us-ascii?Q?bUUiFQl9/YtTj5CTtA/Z53aHnIxgpkOLBZyKVUtf3EU04OFmH5n6uMUz5oG6?=
 =?us-ascii?Q?TgKSwB8ZezD6q7InCopWwJzWcckEtuDDtZ4umDoeyeVDUXuIwDByju16eOrL?=
 =?us-ascii?Q?W9KIKPhNJAIjCCKkey+3rWVEggg6RcYgYxmlAAf9MR6SiLFPEeRBXTNnZFYS?=
 =?us-ascii?Q?y45afvl6tf2lYoZ5ejVSnGvAGq6Ylo+J88FfFFzgHbYD/BJH97dLqriSUUul?=
 =?us-ascii?Q?WH6Y3tjZxFXpE4dHmk5+enbRxPrsAS99pcO5dxVN2HXoy6PE9nCy8QpRTd05?=
 =?us-ascii?Q?fhCn7Bvtmgle63gL+PgQF5l5i0wIblLH6uxaB1BFFn2gOAWcI94cCW6NAexl?=
 =?us-ascii?Q?xY0fjVxGDO3FL1PxxWYypEQOKTC9l0Fq9/IYNYus43VMdM7Oyu6D1GlIQTk6?=
 =?us-ascii?Q?JmduD1hl5HhagdwBz6npj1dIEHtJ8n15DNtETsNIHWX/EbloUdQLzq8qUZOG?=
 =?us-ascii?Q?qG9cEhw5n6KvglpXDqomao8LZh6F/8Ol6upQR9GmNf+QU4iLKXx5ybhdetzP?=
 =?us-ascii?Q?OaYe+KqMZMOHnUw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 04:15:18.2063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d22e644c-a78e-425e-3189-08dd6c1cd148
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047

Add `reset-gpios` property to enable TCA6416 I2C GPIO expander based
handling of the PCIe PERST# signal.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
index 43dc2585c237..e6117d326279 100644
--- a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
+++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
@@ -87,6 +87,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
 
     soc {
         #address-cells = <2>;
@@ -112,6 +113,7 @@ examples:
             #size-cells = <2>;
             #interrupt-cells = <1>;
             device_type = "pci";
+            reset-gpios = <&tca6416_u37 7 GPIO_ACTIVE_LOW>;
             pcie_intc_0: interrupt-controller {
                 #address-cells = <0>;
                 #interrupt-cells = <1>;
-- 
2.31.1



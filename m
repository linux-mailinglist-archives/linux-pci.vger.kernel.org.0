Return-Path: <linux-pci+bounces-34331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C6AB2D1DB
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 04:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92AA5847F9
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 02:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5962230BE9;
	Wed, 20 Aug 2025 02:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PXgyr7V8"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011053.outbound.protection.outlook.com [40.107.130.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90DD22B8B6;
	Wed, 20 Aug 2025 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755656636; cv=fail; b=SSCJxmaz/G9R7f5ScpjUsUQNw0linsKgVe5H36aeQqf8Cu0Gs4jVe8ciBkxJeQlfY/gWFivMxyFuC0dyHIdIjWBoVQkeFIFGOSrXA3U3v+6M79g4rd97eERMDTix7hImguTkGTmlMEI/p0W9orfBgOdOMwNYz7cxTVE5lMXHDuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755656636; c=relaxed/simple;
	bh=G5cdayNo9AGPevBIAlp3FDnwRUhkOuur625qP5Qru+s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iAiWGT4WY8F0GtYkGIu42zAc8MQW5zKWFnU8qntaajn4FAdVQ+ld0c4LVCgF7054Qexi9+K5KYWb44nxJZCg/FB8IrkfdSTmiBofBuM6dnmP5DD3vxeQSoyGDBRqt0hgQ0tb8Th6+M1A/9MCiCbJmheR+ltLZf15Fyf41X7s+EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PXgyr7V8; arc=fail smtp.client-ip=40.107.130.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnctmhu/2w8o3IhMWzfFOlv95USIpe8SQ98qak+WYvnLSAn0lit+lkaTnHGmPoK/cMGyxEE0iY/lpvhdF58+v+kNbe85jO88eHpw5Ydjol7qsCy8PQkErEUdGZfEE2AanenhI+jrcBP61NQgaseyXrXwI0XjB93jh8ppff4GfWGLnCZRIvpiQzzMpxEehcMzn5ajccUZlv0xIMJlKFLPiXHXA5MBAf7r0K+2jbUoPZLj5XKP7vZJZUtdVZOpzCzY/RyHD/uPP1MQluT/uyaQYR7s1vSBLZhR9Qdch6swmuUl5pl6bjuLMtKic9HGESBxTlPHEmiM/TIFiw8TZ+xCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucBLATrnSgVVYyyoqu6UkbzSswL8MHW1HZE4XpGkc34=;
 b=t2c8R6lrYB7ArdAq0R+t2uT15b9NlMi5BiU6xqbLJfv3lfAIINYd/JHybDzC1xZ8uVKNL3USxHG/qzOERJaDl4HErmaIskgrZAiWpS9MLC12B7VMAQHoqcmwJYk1OG9I8yFkKw7ltI4jc9aFDb1i1LTj9V0IilmcPT0qWDS0OquqiuEIERAEVCYjPT0qiPnlcL/APYtWWT9T5rFu8puUq/QBprGuualpJHcPeUHZd3fjN8AD77sqs+Fg95CrooTdYFzFDN27BDeHl01Kv0pUe2GRY0Ob7IYz4yrV50fqk6eEY4lnfzq0DV0uA19x0ZTslN7uqucmtz0au1s6QNbdsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucBLATrnSgVVYyyoqu6UkbzSswL8MHW1HZE4XpGkc34=;
 b=PXgyr7V8xOZ90Umrq46UnxiQcABz6j8bTpqjjjMMr25nfgUxLK/1CfN64F4ZybIHo1Jk2cGcte0zlw0BSVjCskmEm1m2QKxHTCUTmQxWD+9QXlHJ/pN89Ekgbs5F50V6+2VoIRaGkeTQk6vP4E1Ze4XcQmXnOnplrzg+CEvXn98tAnwOqmkqmJDzsLW381mYIkYAteZCUlm3IeZP/2mvID4u+ZHe3AcIMzC2nzwIrMYbj5RwUlgr1G57S7+4vuBqmZBVlFdrObfSfkDQgwxBXixyzqk4njYAVuPsTw2hJJKV4Jok4PWXWvfrji9PCK5DTL7Hs5W2QSWFhTLENDLAKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU2PR04MB8871.eurprd04.prod.outlook.com (2603:10a6:10:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 02:23:52 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.011; Wed, 20 Aug 2025
 02:23:51 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v5] PCI: imx6: Enable the vpcie3v3aux regulator when fetch it
Date: Wed, 20 Aug 2025 10:23:28 +0800
Message-Id: <20250820022328.2143374-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DU2PR04MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: e06a56b1-4515-4043-3fce-08dddf909a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u4P2VS8Bj0VuEtRAjpiiFUJhxF1LGqKjw/wlMwfOUi4DD7jNmNDxjbRG4rvN?=
 =?us-ascii?Q?Uzo12DPPGyO8tyJYyIxLRCaRJxU0Hvmg8QIJvI4FDCz8MLeCyu5AM19rSBS0?=
 =?us-ascii?Q?Bf0l/4+DfnE8R901bd6LIjzy71u/HNsRl99NIA7A5i0XoH824VrruhdlXoIW?=
 =?us-ascii?Q?/Z7JXXqhhXqFJZ+Exjnzd2YJjGSIsuIqnJ2MS8Wedok74m8Fp7YO1+l8C+LH?=
 =?us-ascii?Q?OZxxP32w4iinCpgSlvPuh7YwFmgwKjymz9QmhUwvkmGs6tSrjYi0SjrwWVdK?=
 =?us-ascii?Q?xgSsBt+XUHcc+q7T4rGAdvZtUSnu7CwOBhOk/uE3YTThVD/xDPtEshyGryvh?=
 =?us-ascii?Q?gkz8AjsC6FJEXpwfG0fJ8YvMU3futAvytZE2X1Q4nkesXNMbVtv88p7VPalL?=
 =?us-ascii?Q?Zy076WjkOu1z+S4FtLGyvGgJYdEWeeWvtMWm5k6X5ogfMsibEdLI7NWwJceg?=
 =?us-ascii?Q?aGqNSi7pyNKbiXidIGuEmHEcsLW1SPzplMKcwJkeMJwF28pSWQ1RRZcqRq+V?=
 =?us-ascii?Q?5ZAlqv7Y3QZz4kvwXLxSsOtvIffAiCdZgEpHXjQXThvIltBmGTVOBwq+LJGZ?=
 =?us-ascii?Q?lWkbNV7aFmPmOkus2E3BsL5fHI/501tAeAPE40x5T5iO8QUulHrb4PaOLCOo?=
 =?us-ascii?Q?fEClP1PVIriu0TtBpKlUJz26fETXREBicQqdVRBijFoeGP3SnDwVkSrYyG2l?=
 =?us-ascii?Q?RMouUdsGCMuRMr2cQsyzzLCGx0YNM8NFJeO2wcUTucaYVqD06Mo/yh/3y0F5?=
 =?us-ascii?Q?/PrTlmj4ABPHJLE+W9XGNXVP/tgV32mo9Rl2am+bXMrEVgFdjRGuzkh7U63p?=
 =?us-ascii?Q?sHtAhNW2uNvSb+MXSlnrL74dpHo9CxIZNzvpgt+55pb4DzTtFUKlC4klVW/e?=
 =?us-ascii?Q?O8KveMCPgNaRJq/mR+YwYwjmJT19wZZx7i4gV9K6KOg+2LxEjZ77pqw7gvQ4?=
 =?us-ascii?Q?h95aRj2PNepPjrlWTKZUPFP8CL5aya2W9T+FKKkqafs+J6tUVkxgPu71wsNx?=
 =?us-ascii?Q?JvgIUzGH5Ze05shwWiKkM4UlxgdbA8Lup+ejzuiaR/etJggbui/zmaeVqqoQ?=
 =?us-ascii?Q?aTy4+NcrC7ikm53f3WSK7nnjDfswjj2I4QVkbD6fBFJj13jyB6888uTmG9Ez?=
 =?us-ascii?Q?mkH/cOX2QJwin5QIl4FT2GZ8rDv93CGigfuN37ocTJDKKSsMjX12CLfYXdmH?=
 =?us-ascii?Q?4mvdvDGRBjI5wLWxk+nGZeo/LaZrM4PBnWl0qTO12GOAWZvodxUmuegHaRTm?=
 =?us-ascii?Q?MGdEVlK7SpIcmTmc7XIL9xhiejSuLuh0M15XBQdYy9Qvd7svSc3cHin1i8GZ?=
 =?us-ascii?Q?8ZV+oHv8v16UprKRGeyKnONvP6UQdEMhqyfzaCI36TyuZS3X9TJHzIf3suM2?=
 =?us-ascii?Q?kyXUTlWf8tUwP5fwpYmu8yJcOVrDxdq1T9wrDzWnb6lDXMd2MX6bdlmIgfRO?=
 =?us-ascii?Q?Qek1kjC4ECsz9SFx5FSWPmZrM71yq1kOlp5Xu7MEw1sEHByLU39hdebZE0QR?=
 =?us-ascii?Q?858v2B+K+Z1UG0rVNzijIsBtoiTHdawspsaD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l7keHSOg5FlmboA4RTXZ53X7NyIiSsBnVPS8O4wwjzlt8S3uHwIJTWVmERwn?=
 =?us-ascii?Q?I3XoqwLSI8KETPWKBaYTHP3ooQ4n/P8Uz3IqG9v2ieqx6R3KoE+hVIM5D47h?=
 =?us-ascii?Q?Whp9TEmdy+F6qXClx+7S3h484GuCaQgI4bZeGikkRfm93k6DgPjdJGmo8OEI?=
 =?us-ascii?Q?CgHaEMu+zi7GuGMDYtuPz2w3PyjiEjEXD5XUJs+xa/tXLnmcqEhAoeqKhTzj?=
 =?us-ascii?Q?GixFHMYfsQ7TwMHVRON8iT1Np6kfItTBuz4+Mb8eR3t89FnjVXk9mamXuOhg?=
 =?us-ascii?Q?m2RiAnQ9JZFmeE4AMlKfRiqAjwtRonifnNpJWSRGFKedBfNuZLdA4UNJKHNr?=
 =?us-ascii?Q?lM7/XEwqj6nwn96WiivvaUTf4W6R8nzPB4tpdNgchxQuUHpdPlE2QLklIrZi?=
 =?us-ascii?Q?b9805aPLUKszn2YsEYGWfSb9qdYGO7ZRLvk3P2nMMWO8oG4/AaAJ4gVk3Kbo?=
 =?us-ascii?Q?r3EFX8i1ijRVyLRuktAMxcP7C144A2ItOzJzrO25U89nnZ2sIxk7ywawJKuK?=
 =?us-ascii?Q?UkxtiezLt/sbPIgYK6+GTh1xSg1MErAcPNsFaZ32DPlhYOT0HBfh4DyLmWMm?=
 =?us-ascii?Q?JdUTPQXY+r+Ojv7SjyuI7cgaTTP+gQhO/CvqLzo0x2M9+NYXpMwZFCS65jdO?=
 =?us-ascii?Q?Q6gy3IBZI1yYp6iep3ZFfGoGgYcCS+4AZffYnO0dwOf+COteadDwP4U4Nw+o?=
 =?us-ascii?Q?rzoRvMA3SowwvAnLy7EuB9gGUOJGoDNQkvHcy8sxysOvUKFtpQ3qC6ZmOY3D?=
 =?us-ascii?Q?N/1iZqS2K8/9gS1GvIRxd4+apJvXGEc2kENnfygvWoiK+KZv6sIt3eLNfrcU?=
 =?us-ascii?Q?C32M9PnPaxIg3y46fWzkxHxWFL7RHCerDoFsfGkQ2PFY1rcLKuLXyJV1AudP?=
 =?us-ascii?Q?WdOVpzD2z+uPzm4GUHmLxnmF3eHTErj1t0U4kq+RCA/FIqTXsq6BOQR/6EXo?=
 =?us-ascii?Q?BaDdVW+aflt7SG9fT+ptXqCcPXgZM9E9asjC7OmnB3PqLdvrNVpPrWaajtL2?=
 =?us-ascii?Q?wSm0ChREi9bQINfXZ/10JCQp7RSUqosBvo7zAFbFhLT5xp6w9pyIr1mXkrYf?=
 =?us-ascii?Q?V0PcfP3QCMeIRrGxBySY+O6tRjw9w0tSWVnCbimZZ9C95ys7jwqUsxVpT6wd?=
 =?us-ascii?Q?CwhdOW9u30NUwt5G+jOpN6aILINFXSTEcQtnmfH9B7MepCVhSW44h1izYf/y?=
 =?us-ascii?Q?KSFXl51WOMEeiXQqQXHR4HKp8pIWaOUHDcYp6ikavinmSJfC9eaKDJCXzC2d?=
 =?us-ascii?Q?h9dWSIe9qpN7DMtvbhVPC8+fKDZQGvSRuFUcjjxfj+TLKO5hqaB1T9N+UjOg?=
 =?us-ascii?Q?gaqrxI9mL8L+ZtQkk3SIq9FFy00/RvhGDxaB0YjPfNL10KRryg7Ju465gE28?=
 =?us-ascii?Q?7qX0hlTslY17ztCgdutgB5kwUcW0X/yFa62Y+u72lAvgEBKaa/GNKISVjrWr?=
 =?us-ascii?Q?xzctrtiVINnEYzpY99jNfPpwmRHfqaMN3pYznUiJqaFEmwy+uDSs8boPfa2v?=
 =?us-ascii?Q?zKuG+3cL5tUq3Ncg2PxR8QIHxyohu/C95tNp/kyx2MmHSOFoomBBVcq8rf2K?=
 =?us-ascii?Q?mrs302y7OcgfOgrb6NB3Lf84nVDEvZ462oga9i0m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06a56b1-4515-4043-3fce-08dddf909a5f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 02:23:51.8841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BllQ5Ti0LzH7X0G8XSCP5eenDRtED3MB1132bm+6tS8153Ep2XKW6NjytTnRoRkEsk1RPxjBGV+YMN7OFATUrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8871

Refer to PCIe CEM r6.0, sec 2.3 WAKE# Signal, WAKE# signal is only
asserted by the Add-in Card when all its functions are in D3Cold state
and at least one of its functions is enabled for wakeup generation. The
3.3V auxiliary power (+3.3Vaux) must be present and used for wakeup
process.

When the 3.3V auxiliary power is present, fetch this auxiliary regulator
at probe time and keep it enabled for the entire PCIe controller
lifecycle. This ensures support for outbound wake-up mechanism such as
WAKE# signaling.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
v5 changes:
- Use the vpcie3v3aux property instead of adding a duplicated one.
- Move the comments from the code changes into the description of
  commit.

v4 changes:
Move the dt-binding to snps,dw-pcie-common.yaml.

v3 changes:
Add a new vaux power supply used to specify the regulator powered up the
WAKE# circuit on the connector when WAKE# is supported.

v2 changes:
Update the commit message, and add reviewed-by from Frank.
https://patchwork.kernel.org/project/linux-pci/patch/20250619072438.125921-1-hongxing.zhu@nxp.com/
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5a38cfaf989b1..5067da14bc053 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1739,6 +1739,10 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	pci->max_link_speed = 1;
 	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
 
+	ret = devm_regulator_get_enable_optional(&pdev->dev, "vpcie3v3aux");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to enable pcie3v3vaux");
+
 	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
 	if (IS_ERR(imx_pcie->vpcie)) {
 		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
-- 
2.37.1



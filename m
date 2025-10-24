Return-Path: <linux-pci+bounces-39230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FA1C04310
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 04:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7AB94F2A07
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 02:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E0726E6F3;
	Fri, 24 Oct 2025 02:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D16VkxnJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9DC2749F1;
	Fri, 24 Oct 2025 02:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761274636; cv=fail; b=UgnfOlJRKm9Au2kL27Em1Lo2RPAoUdjUkeU48ZviZPz1CPY6T2n9WZPOdO3elt5oKYGCqw3JWU0NhdPrNzRyJblMsCh7C+/irkZ5cJl9iCxR3IuvoI+hbnJLYkX34BgHjLrhe4d+1TFNX2LFxeejmJ2P6UwiF6UG2lmaeV5Ii/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761274636; c=relaxed/simple;
	bh=xhC3P74Meawgu5MoTaF419L4JH85igeLovCcDliHylo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A5B4Jv1viO0zO+gT/VgM7pCCKRN1HjlORLZ1xvGTz0wwB4u7k0XezmjEywlkIGJUIbOXxPQJ0f2zoz2IzWYbAIMOhbREMHnM7SKaa3kvm7qeh2ptNT0rLzzuIg/62mviPAA9qJNeftSZka8pbw2v2vVxNmCPceNO/ROLaqdGKlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D16VkxnJ; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKbdywvkhT4L+s9s4FqlKgysD6Tk7GaDHbmxcwjBpFOzPtfVEvTZn16yIMTGZTnWT170fMAorD1/N1zb580/wCScn9RkmQ8LsybGEDPoaY3aP3uiiQXxb0PHPFetO2d8PUj/9R73VBzPqbmqjtgQ/XScDG2HiRPHL8YCbn6U5GUghKPPm2PcQZGIne6X3fE5IMZcDiQuVwCfzpmj5gSq++tkWKuIx5UQ3fi+P6NCWwOot76NKR30CDvj6SDsVa2xvnhQk0nuuwYctgQFnhwlvK0SsiR7zSMarPrR+8cJgxvE5kGpp8iwtIRwj16TQItYW5KJ6cS4dZgWLg56pm+j/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaLasptCbiT+suvWJgOpDem+6iVKTnkvWo82N9MLLuI=;
 b=urHDeLiKmQEuI6oPhP3D3J1WXHweS4O1qsnxCFDaIJQ9cptRdhE6Jg4acwUuvdFkS9X9q2G/V0CA5XZIq7sgU3Qw74yUIjSdQ9HCghfpDv3Ix1Lp2UTrtFuyhWCGQECz+sjC63PNh4oYfthgAucezme6ScgGZVJJfOihze+aNNJSIoRNnoK6Nioy/IErStXSthqLozhwAQ0Yr4MYz68goCFUw7+Fq2USY1fqusl0hUSCjh0an13vS9w7ZMgApdhb7FroSDT2TW7ssd3e7XLGWrvZwIMi/tK1MTMIxnRFOtuaARIYboNpx5ZxI6wnEYccvmwHopmBimIdR/ZliZo6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaLasptCbiT+suvWJgOpDem+6iVKTnkvWo82N9MLLuI=;
 b=D16VkxnJqvXsjlEx0JHT7dKKyn8tpBwfF+IqVUQ1+Aw2Vwc5jJTWsB9xfgd/LDi8Fmjcyfr7efFIk1rAtqrgtKy7DU97vE4U//A6yp2Owd0J6jK2/LhfgCZ/rkAmjuYLOcYYldm/88RdF0kmWB/wlUox3C+BNr0I5ZTI99nrrZP4W3zazBZN7GPx4PCQA/vaRNDJq6Pg4u7Kcx54JN1CVecqqAeOlSKC8s5NqdooYEUcddX+dpUGEhmNyy4tjft98wo02tQqjR24WsYmhSBzRbKQJ+2X9PVwCfuiq1RrFpTSrcMboZHddtT25f4RDROZCq9JE7DoNaT+DURhuYAuBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by FRWPR04MB11150.eurprd04.prod.outlook.com (2603:10a6:d10:173::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 02:57:11 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 02:57:11 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v7 3/3] PCI: dwc: Don't return error when wait for link up in dw_pcie_resume_noirq()
Date: Fri, 24 Oct 2025 10:56:27 +0800
Message-Id: <20251024025627.787833-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251024025627.787833-1-hongxing.zhu@nxp.com>
References: <20251024025627.787833-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|FRWPR04MB11150:EE_
X-MS-Office365-Filtering-Correlation-Id: 840df296-207b-4790-a9bc-08de12a906db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UQaxzgNX51RumYU0aFwVEAonF01j9w6YzWivbPuV8QmZeGsBFdoDZKQN5QYz?=
 =?us-ascii?Q?jykwoqloWIkAsB8ofqm2EzmF2/aUt33bohBa2oNp4bXnOuzlxVY3AwoYTpW6?=
 =?us-ascii?Q?PQFFZTCRn9vtHXZRfzxiooYVQBTvPMtQD5YqDnWcdbPQJmhYiJolbk9CFjpT?=
 =?us-ascii?Q?txgYhVR5wCRPXFJkG9n+2Maja9QnXFx5wcuBnBlnICFOeqdpSVZ1dM+EjUIU?=
 =?us-ascii?Q?vThHEM2SrkVpN1g6miyRoJNxFW8n2nPEWoF6L0RqX8wpUtfSNWYUkOsx9mnT?=
 =?us-ascii?Q?t87uFZYw0DULBBxgw4zYBqOXF7h+oIe/qQnokWtFLg22weS1q8Dqgodg6c3u?=
 =?us-ascii?Q?t5qTJ3XyuMI/6aifoaWTOgeIHTZskPY/GVl97mWomjgOWVpMwPaK14IeEFr6?=
 =?us-ascii?Q?j0R3rtStOP5coSFAlvGeVMyJ2VFaaZfra4S6QuuPKE/MMKAtSZsrhol0dcAe?=
 =?us-ascii?Q?2TsdZJDYwml8oUAw1V4u4WvpSRVK0Z0IqPkkJLFIYzYaQjK6mWb02m1eNuIN?=
 =?us-ascii?Q?c3V4EGRP9qIXS7nzlDlJYG7NqwE9VVZI0acAYRgQHolJ/TeTa41k1fhHih1Z?=
 =?us-ascii?Q?evP8o9RCVvgBs4arc5YVnAN9MfcKghkXylpZYQrN6QUgrRmEA2UKey6ejGeY?=
 =?us-ascii?Q?nYSEMIJJOh2pHFWE8Q+x3nG80P6zPCDHhAJRqHm1BvXH5mCTlAJ+TOkXzLo6?=
 =?us-ascii?Q?7OK7BN+fdBXuFrQTstlRWsgZU1TguskM7mXcScHvHolu4wz5Uoh/9xOXUNYx?=
 =?us-ascii?Q?/xQ5omU9u8DLjRvEBUAFvS/FtDDxOFHrxi8hoQaZzOfUzXPURSKy5GviXypX?=
 =?us-ascii?Q?HtgDftl93teIvnK62tlC8a+kKTYJtLJuX5MTwqGz0xcyjBzP8l0hwVJVzAST?=
 =?us-ascii?Q?9vN6UbfRlyT5H/IHHuRGe3Ut7BvLXIDY2XzmSY552NRkOnmAM+7vOOo1J4K3?=
 =?us-ascii?Q?5jxutaQZ+SruRopVPKTnRGvRbDPJInxHZzdAOY0UdF4ntsCF4zBSr/cQMQES?=
 =?us-ascii?Q?8+YlynOpWkjCE01AfHVZGdSHXWWyedFSApEfQ6CcWDH7ZqdGrWvYWsaM2gj6?=
 =?us-ascii?Q?fUyzKYFRm8S67J7C2bF7LgpUPat/QXi4QN+CCMo52yRUgl3Y18z49+ulmG3c?=
 =?us-ascii?Q?ijhsPENre448XCgW/B19RsX6sp4RihbyeFaLDltJkj3IgWbUFdltB4pNoUVl?=
 =?us-ascii?Q?EPo6qfsbTzsYpNGap+IYUvehM6MpNgIycXipS5WWnt44vAMf9ZaFMrK6CYnO?=
 =?us-ascii?Q?viVcGah7B2SlsIl+x/F2fbu0eknjvvSf5Ko5UEcGglzlfm3vxvH39oAfYC6T?=
 =?us-ascii?Q?2kMFnL85a4UNWumCAdipGMtgWjRrBHuHJZU9FWOAyW8R7s46Jb5VSOf1cSoA?=
 =?us-ascii?Q?hjbo/EQuMf6yWA1s7utRnoESJmDPvP60DUywDPrb8E+HRhkYWkDhPwWbhczA?=
 =?us-ascii?Q?XhVL9q+2SNJ23+Ja+tzJKRtrSRAwjecCQN3ttpLV8q2yhnAd+7F7G1zixr95?=
 =?us-ascii?Q?x9UpJV6uZAcPiajPF0nrCQ8gsuVwij6O9PbdNWGvmVSvucTfUvOpGil+7A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D13DR3H5j0HoTC3lrhUD8lRqE4+CSfBgaMYsZLib7VkYIRjtWvfMUZgFjgmM?=
 =?us-ascii?Q?T6wXeZgs9XbHuWkMnKDrarjP/nF0w7ti7VueBiGfuY8xn6hLApuNsil9U4gk?=
 =?us-ascii?Q?xWKYGOU4vZf3QKH3G+rmWyt+cXYFG56COoQlHPlcP5zJZwV9ZPLc+hbpMjZV?=
 =?us-ascii?Q?2w1tWuKH4w4odI8DLbXvrifpUMGxyidAIdPPn+nF6PGnxEgDKh0Pax+Y4649?=
 =?us-ascii?Q?NiPr2iAzyNTFP1dQifJ3b9gfAIv1CeQO7XhL/DHU51+vxTbrAbTBZj1pIC3A?=
 =?us-ascii?Q?hSVPvhNOV5LnYnFF5WSpTnb9z2LlvTWwUyjb8JXj5RMUlx1SGv13Jm1ClfnP?=
 =?us-ascii?Q?IJA8q33m7M18oDQ/jlh/2VZVgzSfrNF8uyi+y7m/uu1rk5HaZo3cVoodE/hG?=
 =?us-ascii?Q?0jYhbI4/7mNfUXqXNQbHNGkfNqCcxCs0s6Q9W+Vd5uN970zeLk4I5m0o6Tlt?=
 =?us-ascii?Q?v+zVYDbWP9+mSVa0Yt4xkTugePOkPzFB+pEq0yeNVdlRbbj8D64G/cW1yqbe?=
 =?us-ascii?Q?bRTXaAahndGh3R8HV49y27Z7RbF7Kft7vDBh3Uizv4KT5s0/fe1ndnfRMoCg?=
 =?us-ascii?Q?x3+/u53hiZk9yj7WfNRg9spEDWbEG5/OJR2VsIa2Ku2HshLqGrCqJ7upN9AO?=
 =?us-ascii?Q?h7dcweeYVI4hir6iF5LpFKZLRNMaEHvpWvqqmTBmCcaEULsfr5CSKozJDopw?=
 =?us-ascii?Q?hwlb21pA47oT3udYTyjLFFXB3OZdxCPOB+EkiunW0/SoxMJ0ruLCHWYJ9ZB8?=
 =?us-ascii?Q?b1lvHtmP0TYuvgdDwG9FPbC5lhsoaTR9iHsRGM4gg2lxohd2oaVO7vWj8/i4?=
 =?us-ascii?Q?wabgGAcmGYIjGTUp3PLGvDPaLZV7HWEPxXthM/3JD83JewzYsxnobOt6r5rM?=
 =?us-ascii?Q?o5WxIppQlQnbG+mbIj4XFb3IhwJYvaVXrQG0RuC3T4o+FMJkxOxkuASPxvwm?=
 =?us-ascii?Q?lkhHjbDpfOgozpPRf68veSVER7qfb2TJxDc2JESbZRFhHXMotLoUOntL6QPw?=
 =?us-ascii?Q?31M2uIwzIZYbZwTT2uXDGeNz1VvP4Oy8pcw5hE53/Gw3NjvKDTPPZ1u+8rCJ?=
 =?us-ascii?Q?jXMpbuVqdD/cs6IUWdQdj0ggVOnb+buTgMZ+tbHXvoGeBlux4HzVv/OID2JK?=
 =?us-ascii?Q?xprpR67ibrFhdoqXdBdSbgAPWQpQnZ7uDDtmxH19ptt5Gpoc2mgUCKTpwnq5?=
 =?us-ascii?Q?pylQq2YQ07bAiSk/oWDuBNEvMU06Kv/cXTfcP6E7HZPQafdaWEPBJkqiNc0u?=
 =?us-ascii?Q?HfTfgNSJ1ijcP/yiHN2EI3UdyXuzZsbv+mHkdo+KwZv90yZ61M84frugr9+6?=
 =?us-ascii?Q?a/bFFr9JRVvY9/ucduj93rVUG+RCFpCWN97LvjKk28EyPgHd+Bq/8/otaldK?=
 =?us-ascii?Q?t8Q70Gv+HwjJDUgDHRbLJDtkvrKEP4myqk0MmN637RAkYZCnmjMvU1PoBot8?=
 =?us-ascii?Q?e/LiQLGNpG9Cwl5rjJ4TEdniNsxa2/BmGeKm5zRRrhJH4/JgsN0zPYmPpbFd?=
 =?us-ascii?Q?3Cnrye+lknISjFCQbuwg5rilFY4LBe2TO/sgqSETk/nzGNfOWcSct4EAs0nN?=
 =?us-ascii?Q?Y+IkVH/M/bc4b8r+6j8viN8QcwKSuUpf9etSvgxb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840df296-207b-4790-a9bc-08de12a906db
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 02:57:10.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENiq/NLCsdwgQrCouqtFIoZLYjLbkfjKg880QUhxbH92I4NisOwRvgN1aVF6qMGdKsjsaBevoRd+XcrcANE/kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11150

When waiting for the PCIe link to come up, both link up and link down
are valid results depending on the device state.

Since the link may come up later and to get rid of the following
mis-reported PM errors. Do not return an -ETIMEDOUT error, as the
outcome has already been reported in dw_pcie_wait_for_link().

PM error logs introduced by the -ETIMEDOUT error return.
imx6q-pcie 33800000.pcie: Phy link never came up
imx6q-pcie 33800000.pcie: PM: dpm_run_callback(): genpd_resume_noirq returns -110
imx6q-pcie 33800000.pcie: PM: failed to resume noirq: error -110

Cc: stable@vger.kernel.org
Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index a4d9838bc33f0..8430ac433d457 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1212,10 +1212,9 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
-	ret = dw_pcie_wait_for_link(pci);
-	if (ret)
-		return ret;
+	/* Ignore errors, the link may come up later */
+	dw_pcie_wait_for_link(pci);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
-- 
2.37.1



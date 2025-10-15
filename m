Return-Path: <linux-pci+bounces-38120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D60CBDC47A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 05:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF553E2E4E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 03:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE826289358;
	Wed, 15 Oct 2025 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SK1LXEPJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8EA2E2DFE;
	Wed, 15 Oct 2025 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760497572; cv=fail; b=cbWJrYlkrO6rs8S2OXj0XDdyB0cgWG3k/OSaIQ86HWlImj/sRs0FWXMzvEs3AU70jAdqZTNF3MhW20lyqJbfJNFpw2BJ+0GTfy5kIrAGIqsoNu6KsS8wNmkgfvLoJDW2+i52fqVe2ySooMVmrWihJYh5B0ewW+MvbyGMaLsWy2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760497572; c=relaxed/simple;
	bh=HM95+yFHN1nEVhy7zOJLu7BnBu5eCEEA2rjpy4zWhu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sdbwsBxqIuTyLepri0dewZBjkU6mbITjq2d5hDGmG9iHRbvLgembT/ZsQhaSADZhhpnXKIqBJIBp4nlTLoLA5dm4JMHTihbPq6YAv+C+8S2F7JmxE/PVhLHFnRRW2dC7X5iMldzcyhJkPdCmBlPU96krTJ8sm2WzEPdpHqdk76Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SK1LXEPJ; arc=fail smtp.client-ip=40.107.159.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+nWUO8APIfKD2KkvqICivmxHWLJgAKJK/W7D5xjZbzwjgNcjTfkqRYtHHk8TGf9mKaYxi6Bcl4G2WSby3YbrS+8E6JcBt8+/0G9R/fhTcoDh/PiTPo1tA0vGMzOj0L1XZeIcn5xQhMmmpsQ7eRQD65AkoRTqqTUwDCFs0ysEJx2obwjKUTxpFXSt3iI48O5qachLfj3ebpoy6Y0tuOI0T1MzXVrNFjQ6V6Lfl0cOktCGVc3wvqjs0ZOZNZhJzXIN5YH/MSe6Xtqo3/ZiX9GD7D4rDVIcoEWcxGJLqEOL+a6TYm93ICuOlbLjDgdxVNUOoMYll2vqMYdghdiMLxlbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQ9+FrUOLU6xs3hDj3/iLJUXMSzokLF5kMjQJ6ztkh8=;
 b=J2hRKcekQn1QUfq/sjWnMO1zIXJcuzfW7kz//e/AZuLRaH3YFhy9yUYoMVAS4n1EAX/e5Fb3V0bbl34klU/mNQ2votEvAqorVbssWfeIENFh4eJXQgqfyvVmOg95R9vctTnrNLTYsxrCigU7g2KcfPh9Bi6/s1IIqmt6cmXdqjkhNhCWELiq5ry++Yspf7VyQJ5UlV7YTrSM3opIU45HzGveluZkPoyLgEvEM1k4pfZYXHllO9fiQgmNJN6dqOD6YzaJiRn9fWPX7dRB09hgx0mpIRH6JIzqTzPvKumSe85MUVgfN/5SWLHkPDPKPgXTZs3uDzxstIf2exA0M9Ajvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQ9+FrUOLU6xs3hDj3/iLJUXMSzokLF5kMjQJ6ztkh8=;
 b=SK1LXEPJLOAgKJP22dXvNVt6zuQFBOW+9hyLtVNCSC03PJYxF51QjbbJRJxAe+T8Kdhg3L+takWm74wtQHBCpv2P1j3lSmDcko3IyEiQmZxaiU6nDl1kpj5WzyHokeXjdgPVNWsT92wRcaHxytHoIwEXolNuoABbRvKUeN981O1fgwEUYQ3ENul63k8a3FYwzANGztPE6HwgLWY3TaGeQesT8bU9tD8rK1EtkZdxsGCT0E9leHjgarqMlSwkb/jvndpwFm0yreiun7hlDDHxsvZxa0+mUzrkZ4CyL4IxB1SLnrp5W/k/iPXKuNRZtDEbm66IqAtHRchU1JnHi/AJ1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by VI1PR04MB7006.eurprd04.prod.outlook.com (2603:10a6:803:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 15 Oct
 2025 03:06:07 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 03:06:06 +0000
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
Subject: [PATCH v6 11/11] PCI: imx6: Add a callback to clear CLKREQ# override
Date: Wed, 15 Oct 2025 11:04:28 +0800
Message-Id: <20251015030428.2980427-12-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DU2PR04MB8840.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8840:EE_|VI1PR04MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d760969-7c38-4292-3cd0-08de0b97c8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0CXfbYm8gYv1Snmh+0GUsZi2JC6SNxzdV9tQUqlKgGeOUNWL8pjBvKa2FJQ9?=
 =?us-ascii?Q?+64PvapPIbBPSLeGirP+aa8GeX02AdrH9k7VMXZMbIkPp93l+TzDgwa1QXyQ?=
 =?us-ascii?Q?bGA8zeMj7ZuqsJS/KzWgC7EgKwP3mMwA+BofTwnbHVOmlGBo1zIQSulH7i8m?=
 =?us-ascii?Q?wqSgWLZOl1PwZ362HpWDNHSP4jixPvx1C/QuUNtEG+LQUbJiar7VJQ4MVKrz?=
 =?us-ascii?Q?7nxyv5X0K6/3rwk80J7e2EUlvNeha1F2zE9i07OfGB4aZsEgQvi7P3IRzgcw?=
 =?us-ascii?Q?FEg4wXWsLoJeZbsvMswY0UcNwrNXgrrSr9Ug3wJDz9QaTmKEH3is46GuK0ak?=
 =?us-ascii?Q?pFGRh7AAPY3hT1xt+w/ZaTV0MarU4280sdR9e130dcheitLOCRiJ/aQ5SFDX?=
 =?us-ascii?Q?hbjcZsp50ALbxowlEIpGdH9oMXj9fPgnQEcCCJPHHItOQKibrr6JuOqNCGfr?=
 =?us-ascii?Q?c7yPcwEmnNRBTpA+D8Yk238/hvMgzkYJ1MNS/lc5QeiyOzWXC+K1t52uQw7c?=
 =?us-ascii?Q?d6GKVYK8HYSkGjBIaSDn/GvH7atXxOqGrq3fAh+9Z6d0mCJJswdvzMvKHrQR?=
 =?us-ascii?Q?IW3K77qx9h45zJ3/I+i4e0bS2W8eij1nhP+f81YNVix2Fso4sVAF1iF2G4pn?=
 =?us-ascii?Q?F4Z3ziU0EqILN4MgMP2ud7xrWovyOtG7zctGwnOxEKCYdL209yewmmEG2uww?=
 =?us-ascii?Q?Uzibe/FvHw0FtzBmMPPEFpJ5jseKyzdF1nu/lccqCDxtMamE36ilhnnuxGeI?=
 =?us-ascii?Q?O7os0MIp6MYzENY7YER7Qvq6AnaKvuWbMtvKlZZIetmEMs61JFFVClbQG07p?=
 =?us-ascii?Q?KHnErc2idlvtrVw0kwhUByoDWTf+YYfFNZSoxFvjl5jk1kXdSsHtanjf5/aD?=
 =?us-ascii?Q?PH8uZIhffLP7rQ+B4oAM1AucuGvo0C0Njug2KvjUB2EyS1CuynjXLB5h7FJb?=
 =?us-ascii?Q?bGp4IJKDszxp9EP6t6QslUCWJxA4amPtZ+dIDRe43BACkZstaiH0NapVRpLH?=
 =?us-ascii?Q?+Wfiwzh6Sz/uNBMuwkvY/mIBWdCHux/sObqraLsl0OsYYUXU7B43jOfYmW4B?=
 =?us-ascii?Q?762mqDCEnqUq7cfqoJ/vP6bObQqJ/LWvuHbIkvJYB0loaxXyMobDhMRGishJ?=
 =?us-ascii?Q?kRywdxK1cSC0aIKPvJ+UYLuKM7z6MKYDHAhtsDCCOYzVpFFLCU/EY/J9GOyO?=
 =?us-ascii?Q?UkS1CcS6gezU0ySLyFmurnZGkPvEdK4Ia1RrALpQvjsq0Mk/4tK3lRTVHOu5?=
 =?us-ascii?Q?zGjxv8srfrJbEhjuGmFdDPdFSNyN70sIVLNSq81uiJny60OjaDgw8EJhJO46?=
 =?us-ascii?Q?Fq8V5OEl8aVKPyG2xxRingg9nTd3adtlU0Chmgj1G6meyG+NiNt4+jHREQ8U?=
 =?us-ascii?Q?rwonhGw9ylhwYoqe3IDJ3y3uP3+kjgnFw4tbh1eZVtPJhD/Z9jSPiRFsMNUj?=
 =?us-ascii?Q?MwWJFfN3jDPVtUEFshS3TIWJZ2peAfsNOmGadUyduCqGWeFN/Eoe3of38VZ3?=
 =?us-ascii?Q?hr9yldRdvxF6E64hKX2nIMl0tOatmpiCOvaCW5pzaY59w1DWFgfuWzz0Kg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UAxU847J2Mr3T+GspjPDB8Q3TX0j4iNMtiX44Q8ZqIuAoEDx6Ecmf0ExDwa8?=
 =?us-ascii?Q?oz7iks1cSuHIVonxgnBmYYNVh5z9nfn+4sQKqXwfLj0q2tjqxpWYRkQtuCrU?=
 =?us-ascii?Q?/R5jCa8X3lz++UIu9z9B78X41ca8TRunhg+x1iRTCd1ClpIH0oVxoXt+HA96?=
 =?us-ascii?Q?m8gkdVyFhLSCBWoUh/9MW71maoTMw8j8eqaA1YvgeusEKW+27KXqSlriihB+?=
 =?us-ascii?Q?7sGlPO/+PDbrpw4hr27nNKXUEQ0l0JImcLNKncvL+o9959PTj6qYcLBeXIYp?=
 =?us-ascii?Q?+JQ2VQaEAWBcPU7AOjbS6t5QfgCfusIE2mhrzapkXiMtn8wnTHjYNHXnFhcZ?=
 =?us-ascii?Q?N/LdBkxF/m2ZhvrNulad/pSu5vvb8uTDthVkiUPjOmzl25hfMEgQ7zhJ6Sna?=
 =?us-ascii?Q?zQmbAcl9d7H/J/lYiTkpsJYzI9Jlc8q5Dd8pNzX0aYgA/YgW8JFAOJcabt7i?=
 =?us-ascii?Q?XxSUGNd1vHcv0rcUw6lWLfMDlotGQ8I5RfH7LCfTH79fDKmBs+stY4w6/Bo6?=
 =?us-ascii?Q?mv/aKecbSgkzSAd9ovAeOtfrZ+jGjL6TKygbNG6n4c9SFtJqyean+IR9M5Wo?=
 =?us-ascii?Q?hkdn/GJxDaJGxSbVzHU0HCt/KERV5b2EXxDd9OT5iQ2D9OsSlaA0F/Fmij2N?=
 =?us-ascii?Q?LgFi9QWHDVlscwrJdZai9dm2/dPCQwGH5ATJSuCTK9B+tCCvGIO4d1NodbRZ?=
 =?us-ascii?Q?Cwf6Tu8yEGRJ+hrY2jurGpFXh6ynuQHMKMssy8Lyw99y01eM1hrwwa8POx76?=
 =?us-ascii?Q?hH6243U1UZC8naoZMjKfcfoo8TtrVG/ainW65OQ2apwsZJwp375iPM28gU+C?=
 =?us-ascii?Q?+ozbH3fVCMHPeuFgCfrWAHtOuebRUYjRNglzvU5o6t+03313VxH3gzWhNf8A?=
 =?us-ascii?Q?yN4h8KC52SnlgYu70vCSl5LEVhXPY4WcfOcqE6tUcLv4Pqlo8OEsTnkKVfDp?=
 =?us-ascii?Q?QqdWlWRfFs7cAnTfq3tCyL6M1GST//KMxiYwl6c/txR5ag8PGBPZY+uPk6sH?=
 =?us-ascii?Q?ueejcGf7Z9Mlmk3xNPIfb33SNDLOUl0Pdu37tXUce8/mYWs+vJefiVMjanUi?=
 =?us-ascii?Q?CDz1uXJw+iDBiu6lzNE3JFM87A8Lr2YYVbqNw5RPiXPgJRt3lg/M6AhI6slj?=
 =?us-ascii?Q?+GPIqYQ3b7hv8aRys3P9qJaDEeIWZADOCYhGU7GuT+hZP7WSf1R97KPpbTKR?=
 =?us-ascii?Q?+oXvz0gYsNOQbptwen2ZssQS1ZRaWw4ZcOUj9dOjMsqcieXeQl2K0aZmI39z?=
 =?us-ascii?Q?W+Bhjt/Zzi3qHI1zV9+mfAlBj2lGs0qJ0i1yiM0a+GPIpjd5lUreTkSGb2Pg?=
 =?us-ascii?Q?5pSeWh6gy+8jHvj3iBSzBCqoKwZPL7sJsB1fKFV9z/S0guVG1rPtX0cfx1j5?=
 =?us-ascii?Q?TA2y8ZJviTA7RDCI2CqRhIZqBDIqyQxnDs1LXua0HJSfd1Yh1NucAOPCv2Xe?=
 =?us-ascii?Q?/bqvZOOuG4PMan19IwMKj5TG4LIfw/GEI5wNKrbiSfA8EiGAfKv/EgSjNKh8?=
 =?us-ascii?Q?xMTvCnUyC84GX1Nr7wlLhq+ejZ6IsKS8XR3FXof+Lmj2xD4dzDIbOWa1IdpA?=
 =?us-ascii?Q?bVWAlYaSmL819ht9iZtCLi3TX4jNIOMTIhmGdqac?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d760969-7c38-4292-3cd0-08de0b97c8ac
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 03:06:06.8921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3G0Nc6yZl7ptj2SUMhGJ2CSiOuMnhP9JlhC6tsPCwAdKBo64l49T6MymgOyZlSqKAG1/NEnwMyLd3zGkY3/nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7006

Clock Request is a reference clock request signal as defined by the PCIe
Mini CEM and M.2 specification; Also used by L1 PM Substates. But it's
an optional signal added in PCIe CEM r4.0, sec 2. The CLKREQ# support is
relied on the exact hardware board and device designs.

To support L1 PM Substates, add a callback to clear CLKREQ# override on
the boards that support CLKREQ# in the hardware designs.

The CLKREQ# override can be cleared safely when supports-clkreq is
present and PCIe link is up later. Because the CLKREQ# would be driven
low by the card at this time.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index aa5a4900d0eb6..7cd0dc62ffd3b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -138,6 +138,7 @@ struct imx_pcie_drvdata {
 	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
 	int (*core_reset)(struct imx_pcie *pcie, bool assert);
 	int (*wait_pll_lock)(struct imx_pcie *pcie);
+	void (*clr_clkreq_override)(struct imx_pcie *pcie);
 	const struct dw_pcie_host_ops *ops;
 };
 
@@ -151,6 +152,7 @@ struct imx_pcie {
 	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
 	int			num_clks;
+	bool			supports_clkreq;
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
@@ -729,6 +731,16 @@ static int imx95_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 	return 0;
 }
 
+static void imx8mm_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
+{
+	imx8mm_pcie_clkreq_override(imx_pcie, false);
+}
+
+static void imx95_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
+{
+	imx95_pcie_clkreq_override(imx_pcie, false);
+}
+
 static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 {
 	struct dw_pcie *pci = imx_pcie->pci;
@@ -1345,6 +1357,12 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
 		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 		dw_pcie_dbi_ro_wr_dis(pci);
 	}
+
+	/* Clear CLKREQ# override if supports_clkreq is true and link is up */
+	if (dw_pcie_link_up(pci) && imx_pcie->supports_clkreq) {
+		if (imx_pcie->drvdata->clr_clkreq_override)
+			imx_pcie->drvdata->clr_clkreq_override(imx_pcie);
+	}
 }
 
 /*
@@ -1763,6 +1781,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	/* Limit link speed */
 	pci->max_link_speed = 1;
 	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
+	imx_pcie->supports_clkreq = of_property_read_bool(node, "supports-clkreq");
 
 	ret = devm_regulator_get_enable_optional(&pdev->dev, "vpcie3v3aux");
 	if (ret < 0 && ret != -ENODEV)
@@ -1896,6 +1915,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.init_phy = imx8mq_pcie_init_phy,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1906,6 +1926,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1916,6 +1937,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
 	},
 	[IMX8Q] = {
 		.variant = IMX8Q,
@@ -1937,6 +1959,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.init_phy = imx95_pcie_init_phy,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
 		.enable_ref_clk = imx95_pcie_enable_ref_clk,
+		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
-- 
2.37.1



Return-Path: <linux-pci+bounces-14069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205C9996685
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3814428A818
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CC418BC1F;
	Wed,  9 Oct 2024 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MJtvXnJB"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676B7191473;
	Wed,  9 Oct 2024 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468413; cv=fail; b=mSFaGbxI1zgGTopHvgLyFa6q1lU8vrseNKjPf5/iypi8mAm99GotIHeP4kuDLFTLK4mXDS5KPB5DuNdDWC1W0zk5Aug3uSsXxnqCbt2DxABG50Tx5c40VlXjPchE25PMNxhHCnJauEBjnvxoD33LIB8yFOJYXlKs0K8v2PQnzw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468413; c=relaxed/simple;
	bh=vHTo+gaCL8dEEkDBk+6Dc48jwI7Zon6gjkRf2kpYt2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XzMO/TEe77Qg84FYyoBViMO5kgvOepjg7OVk+j1eGTzxDpk6KHbJubbJi+rVQEsoccptkPhNUto9JsJ4eM/bWotrI0gbD9vcoHXlKYmLEqT4HDPYGVg3fCYETa+rU++jRpMI+y7dixz19zJ+bR0x8HmnOk1TeOf2c6P/rdrFtmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MJtvXnJB; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozIZlqb24hfykFHk9IwAVqImhIlUg9f/ttzn0uZM8Mfw263vGhMoiQdUZWe2yTD0x/tH9koOFC6rHwaUmuaPfkDdnCwW1mzI6+kMLBg0hs/DC09Rsba2pLlJGbFw2XETwOl6XxLRkCkuTjN8reoP/I9vs9fsSjpTGYQ2xPSEETlyuNyBPQb+TpU6NgfM14E4sZ1voTVDAmxVLgwRvOLKtxDAACzMHGYRQ9SZFcnmdMxKCZrnsYowDRcRNvIogHCOyI45caSLMoV4hP1gw+5IIHjzOiUWw1dEYu7GbojnFMtASUe6oIRYRpakuh4RRFEBkRPis+hrkmly5Q/rWM7/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCbdjvFGHrXrYZNOMDAbRaTbjL+J0xtXKV4QP/8PAw0=;
 b=ZaXILWFpMMc/Y+bPR43Wq946n2mEE02bxee6kW8mPGDmcjksou6NTwa4Jv0PE6K+M9vDu7Is1NNxhwox5jAiFAoyQEp6peD+KIQP45dn72hm3pNKRhxS6vMvRCTr9VqWlfdQAsLSeW/9gWJfn9WQBEiO0CJAzQS5fqHTlxe3AanZcomLZs+4VfkugmXk6LpwX89ykerxua3gyv/oNg//bwhl+uOWfuMUlYLUFQKEyo9qL5B/iDcrx6Dzygx4f4/hltUBkRMQ4eK4kqfo2ryrJbsCFDrikIpo4jLa3gAGZGzWvzdEbeFVP4UbnRd1Vc5x6btdDsGZdsRoAaFf/xTUqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCbdjvFGHrXrYZNOMDAbRaTbjL+J0xtXKV4QP/8PAw0=;
 b=MJtvXnJBnBiizPty4MiV+PB4HbmGfnSzRyXE8Rsh0u4CzcizEdC/1yUlNKuuvJUWc4rKPWEV5HVC2ubGniQT8APYX8TomBxwfIkbNv5b+Lzf9rA2go2NOFhCQ8TY6nrnbReUomCzttJ4vcODl7VcEwbP++8+Ep+3BHXyROOGfw99ngzjmsSoFv1GtybAgUdFz3iByva27iIUtrgylkL7cgig2sm/n8QULBYdCrihopA3NrcWlDVbmyckKiL682P6U/h8tz74fYkyyo6qHILfXhFzDWY7AuHH49cMprdX6mckloYaTGJr1xupWX3gH9vDfel/nyrjj/g9NTRaquGWeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB9933.eurprd04.prod.outlook.com (2603:10a6:102:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 10:06:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 10:06:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk,
	bhelgaas@google.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH net-next 05/11] net: enetc: add enetc-pf-common driver support
Date: Wed,  9 Oct 2024 17:51:10 +0800
Message-Id: <20241009095116.147412-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009095116.147412-1-wei.fang@nxp.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAWPR04MB9933:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f892e5-ebcf-4363-b1a5-08dce84a14ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jOQur7ZwsCZkFkl+NiSj+x+edTajucrojknzXXizDj198EinfAgQNlnWaz6E?=
 =?us-ascii?Q?oYAppB9vR5Ur2SmtR1lq+9ZoGx2QCTTsYmhGSC/bYO7KVnXdk/sxwVkhPPZr?=
 =?us-ascii?Q?M+IdBaeCLaFoaPCsoruIb52yDrdPeQGSIE40YJEeQrfzzYE/8Pv3O6BeyquI?=
 =?us-ascii?Q?K3xbqzRJsCNHM2raxKU2bANsShyAjy4v9Isn6S2vs90Hs/488KmsR5NSKs1p?=
 =?us-ascii?Q?V8xDuKO86uZsIXbK5HbRjnZCfao5Kyn3/SGU3+Ogf20BpyRMr7koZdrBni15?=
 =?us-ascii?Q?b2Oq1nPLBvSIWcOUDbe3aZSjhAKNEmcMA4sKd2spzjtX8wl+G1oo+SDXSfOO?=
 =?us-ascii?Q?x8E6tvx58jbrddULV7F8wPav6aCCkF0i9hFRFvP8jpTSySS1oUj2lF+14ilP?=
 =?us-ascii?Q?tYwZ60sZQGJu+OC9+6WfRgf/dQCs6qkIB8aEr/VR90evKtZ+L/NDLak3xdcz?=
 =?us-ascii?Q?OAQxfmMG32kd/sVMeI9L9/vm/XMRDU2QFTTl1yUGi44ISuNAARwS36wOLEFZ?=
 =?us-ascii?Q?KWfAPs1y+EgeFEKWRklAzMRhh1kuJnw1m4QgUq1cw1/npuBuzOYACCe3yuqh?=
 =?us-ascii?Q?aOXkkF4seW3acA5DI1yvdLnerjtMg7WfcTmiUrP+GbhEGtEymXuNynTZfNgT?=
 =?us-ascii?Q?D6d22w2cUBL+x3kA/h81MoCAlXQxdIEQpgw6ZlaRgzXCpvbI7si+OtdKLt+8?=
 =?us-ascii?Q?La/6uSBX9AX7JRMM54LRxaQP9iMPbacQRa97iV25/z9PKf2+GgNQessvyl1l?=
 =?us-ascii?Q?chKO6gW4j+XYYNXjybY/V9r+GZTWd04QDbCDO6r1wwWiH4qYqJgwBIhjLAJW?=
 =?us-ascii?Q?E1jYLzTs94ToHpYLPJ/boJawze9P4JwP5u4g6T1Q+g2Y1L78GgDbs2IiiRM+?=
 =?us-ascii?Q?lC/ML7J4dKDaMCbNdMxIRXEWqZm1ZTV5pOcfkeqYh1qZ4xVAXDh6plojOK5o?=
 =?us-ascii?Q?5PISwl2eYZ4FSdIzT1RjsPPnigAC4KBZG3FGjBA2GHJWZVpul1RldxUm2dD6?=
 =?us-ascii?Q?uE2KZ5rzJGXjiy0Osi9MI0hlO8UPOWF6IRjmGSBLi/IK16XTbIqsGTjJgtGy?=
 =?us-ascii?Q?b2ahOTUd/f8idqcg8SlNKYvMIfdu+dQbpdQJba665BVULl3TfGUUqf/SejDm?=
 =?us-ascii?Q?mS3azgO/xEoTiEqcoDCp+LHKzhB62mbo5ykFuaysC+tvBi6hpdiSiEOuXfa6?=
 =?us-ascii?Q?GRy9ccnV33k4snZOiLQirLTqZN6Y3mBWa1mBHPne4heIIGupCqIbva+Jz4Ib?=
 =?us-ascii?Q?4ELAr2lLIk8VgidV0dlJbENrn6vIgopc1eQXCMg1WoLrp0bt+DDI6SEwU1cl?=
 =?us-ascii?Q?NXTxZnj2TEYenGTxTM7/RH12lNfQY5cA8OGPxnyLjkApqwC2aFI+uRQQQjzx?=
 =?us-ascii?Q?8RSgD60=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oh88tQ7twIBj7m0jufHui4NuvQujwEKzoMWqCCUk7IOPP40XZMf3mqqugiMT?=
 =?us-ascii?Q?uU6GhBn83zLBvge0Lj6OWVd+7UA+yiCR30hJ3IN2mW00TOqzIs8lVbph5Fl9?=
 =?us-ascii?Q?iyX3cj8xNn+6lzN6Lac0IU3q96Vn55Ii4bbtnUlNaBZkoMMjCYwCtkg7S/6v?=
 =?us-ascii?Q?cL8g0RplgCKfYvwrnsvzfm7b85zGTd7LQvkEnbUMK1Ibqsl22NRwmH1OBqUe?=
 =?us-ascii?Q?WbIp1Eq0UxyWE0DEK5gmv9xNXV+farhzHgrdwXsaB4p+Tn3EwgvO+vQzgh6r?=
 =?us-ascii?Q?Mt82X5c7QFtgmjHu7/0xSdrEtsOlbTIaC/QT1bN5hrm6TELFaUl9vGyGKIqs?=
 =?us-ascii?Q?S8IxPzWiEMr6eTmktbcFfr6bFQR74ESd2K75kPScc6xFYjfG3FoLCi9vQlLX?=
 =?us-ascii?Q?K1lZT8S+LdATSyRRvRmvynx6xqarhTRivkcL1/qbEnAxrJwAB7vxBcRFwlYA?=
 =?us-ascii?Q?gpDfEnyQfPU6lwLxBE9IW6oKimoueVTIem7ETQaRd/IahqrIXP+4vSOGB2qO?=
 =?us-ascii?Q?XmJEJFun8xEtitISmB+9TwGPuDbvZaVidPrFs1eZ0/mzAVYTlPD7ZbhRgduk?=
 =?us-ascii?Q?Glfe1Wf9e+FQ/tUUCkjDUxFbnmXIwmkvmj4HyDJdBKcWfBTFcnoanntr7XlL?=
 =?us-ascii?Q?KYq3oSrh3Rrnmcz/zpsnU0iDk6ItEKgjyB4DSrCdIoNL8mpWQEX/C5+1AsbV?=
 =?us-ascii?Q?/1Q0M/oqfUdCt5Gynw3VYklDdaPehqGdrUM1BfhsIOsFCC+cH8zpspHD4Ct2?=
 =?us-ascii?Q?MKtKHZ2+B4McZ3jGTKozovyscdtFc1Y6udr6MNKclChiUY41mOE5PhR5aUx0?=
 =?us-ascii?Q?y6c7rNodq4JkiZ6RgYkGIdBpg+BZ4x6ipuozp6YF1rkih0pKAX9tV2pcI9jF?=
 =?us-ascii?Q?w1u77yGDUHAyM0kr6y4wslOeHwrXEBvVRQNj0/7oGPWnw1+uDxHni1eLQ4Jh?=
 =?us-ascii?Q?89VjBvlHxPMEg4nL1VXQJrEDTh0ae80Cy4riUFSoLJB8uvK0fCltxOZpKA/f?=
 =?us-ascii?Q?RMl2rUS3rNR8GLrlETsSGjgxVVvsMhx4DnsjMeFwMZuW0P34i3lcx4VjBE2v?=
 =?us-ascii?Q?5ihs8aRpU4Hd1DPbGtSLj3WtvHa63y6kUo01OtLh26UfjTb2lpafOXPTzY3i?=
 =?us-ascii?Q?mvA/ejxuAak3bGJCbi+WXt2oNkl7u8GjMv2rb62RnYGp2aGAkgJtgwsRUDnt?=
 =?us-ascii?Q?GzvqU3h6m7lo0q8Io6YIV3qShJKH87Pe6OtS6Nlr0VStfIjor2T+lLbvaUjQ?=
 =?us-ascii?Q?aCCugEcz3na6lw1qPV1E66kX4hIz02Qxwq1ilmmmJtcSk/tuJRmyOTh/fYMN?=
 =?us-ascii?Q?JVRCNimn8pMSh03POergjYcx+HfjeBus5lI0Jnxk2x97qsJ3V8rXnTEJfgZa?=
 =?us-ascii?Q?mCU2fozcRYCv5Vtob2r4dOwlGl/IDVnknyCdtWq3FO9qCzvZx0McZrbpg3q/?=
 =?us-ascii?Q?ICt3j9HIXBjNhIPVva12qNTeTb7SKV6tUfgS5IXaVNwrAiLSzjL7vJKWtRF/?=
 =?us-ascii?Q?UjiaNGE7zgCQlzVbf7SAwhuHegd59qZG6Qw4vvWZtUmsat77dp885E4jIs9T?=
 =?us-ascii?Q?1CE7JmAEoyp4/c6Y/I+gqpxo/Ol1mg2ZhCDFx+R4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f892e5-ebcf-4363-b1a5-08dce84a14ee
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:06:45.9285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvYLBAnd97WVc+28ua+CbryBX/YwYBqsDhtRM2LJv9WF+h+ukP1IJcATUsnc4s8nzJBZBZYtUqUcg4t3lIuN1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9933

The ENETC of LS1028A is revision 1.0. Now, ENETC is used on the i.MX95
platform and the revision is upgraded to version 4.1. The two versions
are incompatible except for the station interface (SI) part. Therefore,
we need to add a new driver for ENETC revision 4.1 and later. However,
the logic of some interfaces of the two drivers is basically the same,
and the only difference is the hardware configuration. So in order to
reuse these interfaces and reduce code redundancy, we extract these
interfaces and compile them into a separate enetc-pf-common driver for
use by these two PF drivers. Note that the ENETC PF 4.1 driver will be
supported in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |   9 +
 drivers/net/ethernet/freescale/enetc/Makefile |   3 +
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 350 +---------------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  28 ++
 .../freescale/enetc/enetc_pf_common.c         | 375 ++++++++++++++++++
 5 files changed, 431 insertions(+), 334 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 51d80ea959d4..6f3306f14060 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -7,10 +7,19 @@ config FSL_ENETC_CORE
 
 	  If compiled as module (M), the module name is fsl-enetc-core.
 
+config NXP_ENETC_PF_COMMON
+	tristate "ENETC PF common functionality driver"
+	help
+	  This module supports common functionality between drivers of
+	  different versions of NXP ENETC PF controllers.
+
+	  If compiled as module (M), the module name is nxp-enetc-pf-common.
+
 config FSL_ENETC
 	tristate "ENETC PF driver"
 	depends on PCI_MSI
 	select MDIO_DEVRES
+	select NXP_ENETC_PF_COMMON
 	select FSL_ENETC_CORE
 	select FSL_ENETC_IERB
 	select FSL_ENETC_MDIO
diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index 5c277910d538..b81ca462e358 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -3,6 +3,9 @@
 obj-$(CONFIG_FSL_ENETC_CORE) += fsl-enetc-core.o
 fsl-enetc-core-y := enetc.o enetc_cbdr.o enetc_ethtool.o
 
+obj-$(CONFIG_NXP_ENETC_PF_COMMON) += nxp-enetc-pf-common.o
+nxp-enetc-pf-common-y := enetc_pf_common.o
+
 obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
 fsl-enetc-y := enetc_pf.o
 fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 8f6b0bf48139..dae8be4a1607 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -33,18 +33,15 @@ static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
 	__raw_writew(lower, hw->port + ENETC_PSIPMAR1(si));
 }
 
-static int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
+static struct phylink_pcs *enetc_pf_create_pcs(struct enetc_pf *pf,
+					       struct mii_bus *bus)
 {
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct sockaddr *saddr = addr;
-
-	if (!is_valid_ether_addr(saddr->sa_data))
-		return -EADDRNOTAVAIL;
-
-	eth_hw_addr_set(ndev, saddr->sa_data);
-	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
+	return lynx_pcs_create_mdiodev(bus, 0);
+}
 
-	return 0;
+static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
+{
+	lynx_pcs_destroy(pcs);
 }
 
 static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
@@ -393,56 +390,6 @@ static int enetc_pf_set_vf_spoofchk(struct net_device *ndev, int vf, bool en)
 	return 0;
 }
 
-static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
-				   int si)
-{
-	struct device *dev = &pf->si->pdev->dev;
-	struct enetc_hw *hw = &pf->si->hw;
-	u8 mac_addr[ETH_ALEN] = { 0 };
-	int err;
-
-	/* (1) try to get the MAC address from the device tree */
-	if (np) {
-		err = of_get_mac_address(np, mac_addr);
-		if (err == -EPROBE_DEFER)
-			return err;
-	}
-
-	/* (2) bootloader supplied MAC address */
-	if (is_zero_ether_addr(mac_addr))
-		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
-
-	/* (3) choose a random one */
-	if (is_zero_ether_addr(mac_addr)) {
-		eth_random_addr(mac_addr);
-		dev_info(dev, "no MAC address specified for SI%d, using %pM\n",
-			 si, mac_addr);
-	}
-
-	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
-
-	return 0;
-}
-
-static int enetc_setup_mac_addresses(struct device_node *np,
-				     struct enetc_pf *pf)
-{
-	int err, i;
-
-	/* The PF might take its MAC from the device tree */
-	err = enetc_setup_mac_address(np, pf, 0);
-	if (err)
-		return err;
-
-	for (i = 0; i < pf->total_vfs; i++) {
-		err = enetc_setup_mac_address(NULL, pf, i + 1);
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
 static void enetc_port_assign_rfs_entries(struct enetc_si *si)
 {
 	struct enetc_pf *pf = enetc_si_priv(si);
@@ -656,55 +603,6 @@ void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id, u16 *status)
 	}
 }
 
-#ifdef CONFIG_PCI_IOV
-static int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
-{
-	struct enetc_si *si = pci_get_drvdata(pdev);
-	struct enetc_pf *pf = enetc_si_priv(si);
-	int err;
-
-	if (!num_vfs) {
-		enetc_msg_psi_free(pf);
-		kfree(pf->vf_state);
-		pf->num_vfs = 0;
-		pci_disable_sriov(pdev);
-	} else {
-		pf->num_vfs = num_vfs;
-
-		pf->vf_state = kcalloc(num_vfs, sizeof(struct enetc_vf_state),
-				       GFP_KERNEL);
-		if (!pf->vf_state) {
-			pf->num_vfs = 0;
-			return -ENOMEM;
-		}
-
-		err = enetc_msg_psi_init(pf);
-		if (err) {
-			dev_err(&pdev->dev, "enetc_msg_psi_init (%d)\n", err);
-			goto err_msg_psi;
-		}
-
-		err = pci_enable_sriov(pdev, num_vfs);
-		if (err) {
-			dev_err(&pdev->dev, "pci_enable_sriov err %d\n", err);
-			goto err_en_sriov;
-		}
-	}
-
-	return num_vfs;
-
-err_en_sriov:
-	enetc_msg_psi_free(pf);
-err_msg_psi:
-	kfree(pf->vf_state);
-	pf->num_vfs = 0;
-
-	return err;
-}
-#else
-#define enetc_sriov_configure(pdev, num_vfs)	(void)0
-#endif
-
 static int enetc_pf_set_features(struct net_device *ndev,
 				 netdev_features_t features)
 {
@@ -775,187 +673,6 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_xdp_xmit		= enetc_xdp_xmit,
 };
 
-static void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
-				  const struct net_device_ops *ndev_ops)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-
-	SET_NETDEV_DEV(ndev, &si->pdev->dev);
-	priv->ndev = ndev;
-	priv->si = si;
-	priv->dev = &si->pdev->dev;
-	si->ndev = ndev;
-
-	priv->msg_enable = (NETIF_MSG_WOL << 1) - 1;
-	ndev->netdev_ops = ndev_ops;
-	enetc_set_ethtool_ops(ndev);
-	ndev->watchdog_timeo = 5 * HZ;
-	ndev->max_mtu = ENETC_MAX_MTU;
-
-	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
-			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
-			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
-			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
-	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
-			 NETIF_F_HW_VLAN_CTAG_TX |
-			 NETIF_F_HW_VLAN_CTAG_RX |
-			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
-	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
-			      NETIF_F_TSO | NETIF_F_TSO6;
-
-	if (si->num_rss)
-		ndev->hw_features |= NETIF_F_RXHASH;
-
-	ndev->priv_flags |= IFF_UNICAST_FLT;
-	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
-			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
-			     NETDEV_XDP_ACT_NDO_XMIT_SG;
-
-	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
-		priv->active_offloads |= ENETC_F_QCI;
-		ndev->features |= NETIF_F_HW_TC;
-		ndev->hw_features |= NETIF_F_HW_TC;
-	}
-
-	/* pick up primary MAC address from SI */
-	enetc_load_primary_mac_addr(&si->hw, ndev);
-}
-
-static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
-{
-	struct device *dev = &pf->si->pdev->dev;
-	struct enetc_mdio_priv *mdio_priv;
-	struct mii_bus *bus;
-	int err;
-
-	bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
-	if (!bus)
-		return -ENOMEM;
-
-	bus->name = "Freescale ENETC MDIO Bus";
-	bus->read = enetc_mdio_read_c22;
-	bus->write = enetc_mdio_write_c22;
-	bus->read_c45 = enetc_mdio_read_c45;
-	bus->write_c45 = enetc_mdio_write_c45;
-	bus->parent = dev;
-	mdio_priv = bus->priv;
-	mdio_priv->hw = &pf->si->hw;
-	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
-
-	err = of_mdiobus_register(bus, np);
-	if (err)
-		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
-
-	pf->mdio = bus;
-
-	return 0;
-}
-
-static void enetc_mdio_remove(struct enetc_pf *pf)
-{
-	if (pf->mdio)
-		mdiobus_unregister(pf->mdio);
-}
-
-static int enetc_imdio_create(struct enetc_pf *pf)
-{
-	struct device *dev = &pf->si->pdev->dev;
-	struct enetc_mdio_priv *mdio_priv;
-	struct phylink_pcs *phylink_pcs;
-	struct mii_bus *bus;
-	int err;
-
-	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
-	if (!bus)
-		return -ENOMEM;
-
-	bus->name = "Freescale ENETC internal MDIO Bus";
-	bus->read = enetc_mdio_read_c22;
-	bus->write = enetc_mdio_write_c22;
-	bus->read_c45 = enetc_mdio_read_c45;
-	bus->write_c45 = enetc_mdio_write_c45;
-	bus->parent = dev;
-	bus->phy_mask = ~0;
-	mdio_priv = bus->priv;
-	mdio_priv->hw = &pf->si->hw;
-	mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
-
-	err = mdiobus_register(bus);
-	if (err) {
-		dev_err(dev, "cannot register internal MDIO bus (%d)\n", err);
-		goto free_mdio_bus;
-	}
-
-	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
-	if (IS_ERR(phylink_pcs)) {
-		err = PTR_ERR(phylink_pcs);
-		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
-		goto unregister_mdiobus;
-	}
-
-	pf->imdio = bus;
-	pf->pcs = phylink_pcs;
-
-	return 0;
-
-unregister_mdiobus:
-	mdiobus_unregister(bus);
-free_mdio_bus:
-	mdiobus_free(bus);
-	return err;
-}
-
-static void enetc_imdio_remove(struct enetc_pf *pf)
-{
-	if (pf->pcs)
-		lynx_pcs_destroy(pf->pcs);
-	if (pf->imdio) {
-		mdiobus_unregister(pf->imdio);
-		mdiobus_free(pf->imdio);
-	}
-}
-
-static bool enetc_port_has_pcs(struct enetc_pf *pf)
-{
-	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
-		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
-		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
-		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
-}
-
-static int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
-{
-	struct device_node *mdio_np;
-	int err;
-
-	mdio_np = of_get_child_by_name(node, "mdio");
-	if (mdio_np) {
-		err = enetc_mdio_probe(pf, mdio_np);
-
-		of_node_put(mdio_np);
-		if (err)
-			return err;
-	}
-
-	if (enetc_port_has_pcs(pf)) {
-		err = enetc_imdio_create(pf);
-		if (err) {
-			enetc_mdio_remove(pf);
-			return err;
-		}
-	}
-
-	return 0;
-}
-
-static void enetc_mdiobus_destroy(struct enetc_pf *pf)
-{
-	enetc_mdio_remove(pf);
-	enetc_imdio_remove(pf);
-}
-
 static struct phylink_pcs *
 enetc_pl_mac_select_pcs(struct phylink_config *config, phy_interface_t iface)
 {
@@ -1101,47 +818,6 @@ static const struct phylink_mac_ops enetc_mac_phylink_ops = {
 	.mac_link_down = enetc_pl_mac_link_down,
 };
 
-static int enetc_phylink_create(struct enetc_ndev_priv *priv,
-				struct device_node *node)
-{
-	struct enetc_pf *pf = enetc_si_priv(priv->si);
-	struct phylink *phylink;
-	int err;
-
-	pf->phylink_config.dev = &priv->ndev->dev;
-	pf->phylink_config.type = PHYLINK_NETDEV;
-	pf->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
-
-	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_SGMII,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_USXGMII,
-		  pf->phylink_config.supported_interfaces);
-	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
-
-	phylink = phylink_create(&pf->phylink_config, of_fwnode_handle(node),
-				 pf->if_mode, &enetc_mac_phylink_ops);
-	if (IS_ERR(phylink)) {
-		err = PTR_ERR(phylink);
-		return err;
-	}
-
-	priv->phylink = phylink;
-
-	return 0;
-}
-
-static void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
-{
-	phylink_destroy(priv->phylink);
-}
-
 /* Initialize the entire shared memory for the flow steering entries
  * of this port (PF + VFs)
  */
@@ -1259,6 +935,13 @@ static void enetc_psi_destroy(struct pci_dev *pdev)
 	enetc_pci_remove(pdev);
 }
 
+static const struct enetc_pf_ops enetc_pf_ops = {
+	.set_si_primary_mac = enetc_pf_set_primary_mac_addr,
+	.get_si_primary_mac = enetc_pf_get_primary_mac_addr,
+	.create_pcs = enetc_pf_create_pcs,
+	.destroy_pcs = enetc_pf_destroy_pcs,
+};
+
 static int enetc_pf_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *ent)
 {
@@ -1286,6 +969,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	pf = enetc_si_priv(si);
 	pf->si = si;
 	pf->total_vfs = pci_sriov_get_totalvfs(pdev);
+	enetc_pf_ops_register(pf, &enetc_pf_ops);
 
 	err = enetc_setup_mac_addresses(node, pf);
 	if (err)
@@ -1338,7 +1022,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_mdiobus_create;
 
-	err = enetc_phylink_create(priv, node);
+	err = enetc_phylink_create(priv, node, &enetc_mac_phylink_ops);
 	if (err)
 		goto err_phylink_create;
 
@@ -1422,9 +1106,7 @@ static struct pci_driver enetc_pf_driver = {
 	.id_table = enetc_pf_id_table,
 	.probe = enetc_pf_probe,
 	.remove = enetc_pf_remove,
-#ifdef CONFIG_PCI_IOV
 	.sriov_configure = enetc_sriov_configure,
-#endif
 };
 module_pci_driver(enetc_pf_driver);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index c26bd66e4597..ad7dab0eb752 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -28,6 +28,15 @@ struct enetc_vf_state {
 	enum enetc_vf_flags flags;
 };
 
+struct enetc_pf;
+
+struct enetc_pf_ops {
+	void (*set_si_primary_mac)(struct enetc_hw *hw, int si, const u8 *addr);
+	void (*get_si_primary_mac)(struct enetc_hw *hw, int si, u8 *addr);
+	struct phylink_pcs *(*create_pcs)(struct enetc_pf *pf, struct mii_bus *bus);
+	void (*destroy_pcs)(struct phylink_pcs *pcs);
+};
+
 struct enetc_pf {
 	struct enetc_si *si;
 	int num_vfs; /* number of active VFs, after sriov_init */
@@ -50,6 +59,8 @@ struct enetc_pf {
 
 	phy_interface_t if_mode;
 	struct phylink_config phylink_config;
+
+	const struct enetc_pf_ops *ops;
 };
 
 #define phylink_to_enetc_pf(config) \
@@ -58,3 +69,20 @@ struct enetc_pf {
 int enetc_msg_psi_init(struct enetc_pf *pf);
 void enetc_msg_psi_free(struct enetc_pf *pf);
 void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
+
+int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
+int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf);
+void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
+			   const struct net_device_ops *ndev_ops);
+int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node);
+void enetc_mdiobus_destroy(struct enetc_pf *pf);
+int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
+			 const struct phylink_mac_ops *pl_mac_ops);
+void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
+int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs);
+
+static inline void enetc_pf_ops_register(struct enetc_pf *pf,
+					 const struct enetc_pf_ops *ops)
+{
+	pf->ops = ops;
+}
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
new file mode 100644
index 000000000000..bbfb5c1ffd13
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* Copyright 2024 NXP */
+#include <linux/fsl/enetc_mdio.h>
+#include <linux/of_mdio.h>
+#include <linux/of_net.h>
+
+#include "enetc_pf.h"
+
+static int enetc_set_si_hw_addr(struct enetc_pf *pf, int si, u8 *mac_addr)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+
+	if (pf->ops->set_si_primary_mac)
+		pf->ops->set_si_primary_mac(hw, si, mac_addr);
+	else
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct sockaddr *saddr = addr;
+	int err;
+
+	if (!is_valid_ether_addr(saddr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	err = enetc_set_si_hw_addr(pf, 0, saddr->sa_data);
+	if (err)
+		return err;
+
+	eth_hw_addr_set(ndev, saddr->sa_data);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_pf_set_mac_addr);
+
+static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
+				   int si)
+{
+	struct device *dev = &pf->si->pdev->dev;
+	struct enetc_hw *hw = &pf->si->hw;
+	u8 mac_addr[ETH_ALEN] = { 0 };
+	int err;
+
+	/* (1) try to get the MAC address from the device tree */
+	if (np) {
+		err = of_get_mac_address(np, mac_addr);
+		if (err == -EPROBE_DEFER)
+			return err;
+	}
+
+	/* (2) bootloader supplied MAC address */
+	if (is_zero_ether_addr(mac_addr) && pf->ops->get_si_primary_mac)
+		pf->ops->get_si_primary_mac(hw, si, mac_addr);
+
+	/* (3) choose a random one */
+	if (is_zero_ether_addr(mac_addr)) {
+		eth_random_addr(mac_addr);
+		dev_info(dev, "no MAC address specified for SI%d, using %pM\n",
+			 si, mac_addr);
+	}
+
+	err = enetc_set_si_hw_addr(pf, si, mac_addr);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
+{
+	int err, i;
+
+	/* The PF might take its MAC from the device tree */
+	err = enetc_setup_mac_address(np, pf, 0);
+	if (err)
+		return err;
+
+	for (i = 0; i < pf->total_vfs; i++) {
+		err = enetc_setup_mac_address(NULL, pf, i + 1);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_setup_mac_addresses);
+
+void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
+			   const struct net_device_ops *ndev_ops)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+
+	SET_NETDEV_DEV(ndev, &si->pdev->dev);
+	priv->ndev = ndev;
+	priv->si = si;
+	priv->dev = &si->pdev->dev;
+	si->ndev = ndev;
+
+	priv->msg_enable = (NETIF_MSG_WOL << 1) - 1;
+	ndev->netdev_ops = ndev_ops;
+	enetc_set_ethtool_ops(ndev);
+	ndev->watchdog_timeo = 5 * HZ;
+	ndev->max_mtu = ENETC_MAX_MTU;
+
+	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
+			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
+			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
+			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			    NETIF_F_GSO_UDP_L4;
+	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
+			 NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
+			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			 NETIF_F_GSO_UDP_L4;
+	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_TSO |
+			      NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4;
+
+	if (si->num_rss)
+		ndev->hw_features |= NETIF_F_RXHASH;
+
+	ndev->priv_flags |= IFF_UNICAST_FLT;
+	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
+			     NETDEV_XDP_ACT_NDO_XMIT_SG;
+
+	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
+		priv->active_offloads |= ENETC_F_QCI;
+		ndev->features |= NETIF_F_HW_TC;
+		ndev->hw_features |= NETIF_F_HW_TC;
+	}
+
+	/* pick up primary MAC address from SI */
+	enetc_load_primary_mac_addr(&si->hw, ndev);
+}
+EXPORT_SYMBOL_GPL(enetc_pf_netdev_setup);
+
+static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
+{
+	struct device *dev = &pf->si->pdev->dev;
+	struct enetc_mdio_priv *mdio_priv;
+	struct mii_bus *bus;
+	int err;
+
+	bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "Freescale ENETC MDIO Bus";
+	bus->read = enetc_mdio_read_c22;
+	bus->write = enetc_mdio_write_c22;
+	bus->read_c45 = enetc_mdio_read_c45;
+	bus->write_c45 = enetc_mdio_write_c45;
+	bus->parent = dev;
+	mdio_priv = bus->priv;
+	mdio_priv->hw = &pf->si->hw;
+	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
+
+	err = of_mdiobus_register(bus, np);
+	if (err)
+		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
+
+	pf->mdio = bus;
+
+	return 0;
+}
+
+static void enetc_mdio_remove(struct enetc_pf *pf)
+{
+	if (pf->mdio)
+		mdiobus_unregister(pf->mdio);
+}
+
+static bool enetc_port_has_pcs(struct enetc_pf *pf)
+{
+	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
+		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
+		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
+		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
+}
+
+static int enetc_imdio_create(struct enetc_pf *pf)
+{
+	struct device *dev = &pf->si->pdev->dev;
+	struct enetc_mdio_priv *mdio_priv;
+	struct phylink_pcs *phylink_pcs;
+	struct mii_bus *bus;
+	int err;
+
+	if (!pf->ops->create_pcs)
+		return -EOPNOTSUPP;
+
+	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "Freescale ENETC internal MDIO Bus";
+	bus->read = enetc_mdio_read_c22;
+	bus->write = enetc_mdio_write_c22;
+	bus->read_c45 = enetc_mdio_read_c45;
+	bus->write_c45 = enetc_mdio_write_c45;
+	bus->parent = dev;
+	bus->phy_mask = ~0;
+	mdio_priv = bus->priv;
+	mdio_priv->hw = &pf->si->hw;
+	mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
+
+	err = mdiobus_register(bus);
+	if (err) {
+		dev_err(dev, "cannot register internal MDIO bus (%d)\n", err);
+		goto free_mdio_bus;
+	}
+
+	phylink_pcs = pf->ops->create_pcs(pf, bus);
+	if (IS_ERR(phylink_pcs)) {
+		err = PTR_ERR(phylink_pcs);
+		dev_err(dev, "cannot create pcs (%d)\n", err);
+		goto unregister_mdiobus;
+	}
+
+	pf->imdio = bus;
+	pf->pcs = phylink_pcs;
+
+	return 0;
+
+unregister_mdiobus:
+	mdiobus_unregister(bus);
+free_mdio_bus:
+	mdiobus_free(bus);
+	return err;
+}
+
+static void enetc_imdio_remove(struct enetc_pf *pf)
+{
+	if (pf->pcs && pf->ops->destroy_pcs)
+		pf->ops->destroy_pcs(pf->pcs);
+
+	if (pf->imdio) {
+		mdiobus_unregister(pf->imdio);
+		mdiobus_free(pf->imdio);
+	}
+}
+
+int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
+{
+	struct device_node *mdio_np;
+	int err;
+
+	mdio_np = of_get_child_by_name(node, "mdio");
+	if (mdio_np) {
+		err = enetc_mdio_probe(pf, mdio_np);
+
+		of_node_put(mdio_np);
+		if (err)
+			return err;
+	}
+
+	if (enetc_port_has_pcs(pf)) {
+		err = enetc_imdio_create(pf);
+		if (err) {
+			enetc_mdio_remove(pf);
+			return err;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_mdiobus_create);
+
+void enetc_mdiobus_destroy(struct enetc_pf *pf)
+{
+	enetc_mdio_remove(pf);
+	enetc_imdio_remove(pf);
+}
+EXPORT_SYMBOL_GPL(enetc_mdiobus_destroy);
+
+int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
+			 const struct phylink_mac_ops *pl_mac_ops)
+{
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct phylink *phylink;
+	int err;
+
+	pf->phylink_config.dev = &priv->ndev->dev;
+	pf->phylink_config.type = PHYLINK_NETDEV;
+	pf->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
+
+	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+		  pf->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_SGMII,
+		  pf->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+		  pf->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+		  pf->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_USXGMII,
+		  pf->phylink_config.supported_interfaces);
+	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
+
+	phylink = phylink_create(&pf->phylink_config, of_fwnode_handle(node),
+				 pf->if_mode, pl_mac_ops);
+	if (IS_ERR(phylink)) {
+		err = PTR_ERR(phylink);
+		return err;
+	}
+
+	priv->phylink = phylink;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_phylink_create);
+
+void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
+{
+	phylink_destroy(priv->phylink);
+}
+EXPORT_SYMBOL_GPL(enetc_phylink_destroy);
+
+int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	struct enetc_si *si = pci_get_drvdata(pdev);
+	struct enetc_pf *pf = enetc_si_priv(si);
+	int err;
+
+	if (!IS_ENABLED(CONFIG_PCI_IOV))
+		return 0;
+
+	if (!num_vfs) {
+		pci_disable_sriov(pdev);
+		enetc_msg_psi_free(pf);
+		kfree(pf->vf_state);
+		pf->num_vfs = 0;
+	} else {
+		pf->num_vfs = num_vfs;
+
+		pf->vf_state = kcalloc(num_vfs, sizeof(struct enetc_vf_state),
+				       GFP_KERNEL);
+		if (!pf->vf_state) {
+			pf->num_vfs = 0;
+			return -ENOMEM;
+		}
+
+		err = enetc_msg_psi_init(pf);
+		if (err) {
+			dev_err(&pdev->dev, "enetc_msg_psi_init (%d)\n", err);
+			goto err_msg_psi;
+		}
+
+		err = pci_enable_sriov(pdev, num_vfs);
+		if (err) {
+			dev_err(&pdev->dev, "pci_enable_sriov err %d\n", err);
+			goto err_en_sriov;
+		}
+	}
+
+	return num_vfs;
+
+err_en_sriov:
+	enetc_msg_psi_free(pf);
+err_msg_psi:
+	kfree(pf->vf_state);
+	pf->num_vfs = 0;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(enetc_sriov_configure);
+
+MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.34.1



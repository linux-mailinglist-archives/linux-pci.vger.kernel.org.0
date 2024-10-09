Return-Path: <linux-pci+bounces-14070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306B4996688
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5375D1C20A02
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3A0191F79;
	Wed,  9 Oct 2024 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZBYtOyxS"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C571917E9;
	Wed,  9 Oct 2024 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468416; cv=fail; b=itBVbD5odOLy0jRedK0Za6tA0EsJW3xdd7Ob7iV88gKLDeT6DmO7Q8I6t8Z+nzfmoFxEd7Ua7rHc646ebU25Ti4tHzloVvXYJoihFt0VBlIOUZHfrueJhbg0GCjB55gk4GMNzVKkjRd04fGIk8bvy5gnUVaMQPBBrf3TOYFCMYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468416; c=relaxed/simple;
	bh=XTi9Up4PRSEaUoK9K7iQF+uFrIWBJZ0jgJcB+HtQvpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TTBeYpdIt4LX7IUDFV5swvpCQeQ01+krB4GE21/bJkLJh9p908WdimFTwHwNzV0YFMm5AocEhEjpPU5flhMtc9lZchWSmtpqD4NE/ezbotKCmoMMarH7UjUic1pVnl6z6IWsaKbGkS9akVlyG5nIq8QsSCsZ+naSvbVHpwA0E40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZBYtOyxS; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTfPGNJbZDt6YCuQBufQwCbCG2Ka6dA+04GA+AHtv1jmYNQ6jtUH7LPiWfYd2QZjvqhSTvkhjXx9ctw/TF+2sjCPJId2uorDi/oagqLrXyT/Dn3wjBSOx3k+i8ijad+VcAO+jQ7gipp8MI9DD1WMqae+90FbUYhbULqU3kvTD/VKk17r4XDAsn7ff4Ns6pbK/1MKC8A7aUoRtUnYZ+iVEk836hr80eduDL9Ai/qZA2fb6lCyd+19efiiLpiEIpn0K2j+R0qlYEa/ixWVGOiC+pNiCYixSmPOuHOraqhkvQ30u2CJ0yqQzWuJcRY0NyRbY+bZlH1Af/V2hcUaQFtzfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKDZa1Ot52gYjDanyl3kPaluXq5pJJ0Vixrqz2nTD/I=;
 b=hFbeiHJrdUem8roarNiv5cQwqJ6Nj8cnU9sRccT3QzJj4iq3em9wyMm5GPVi+Hr0M5s1q6OfOuiRDCsPgIakbzny2s3ZP6Vvhlhvge2l0LbSx6netRXtZ00F76ddlY86dkCElJPF8MzOT9iZyXePOCMOp7hKf6375eMej0YX2rJHv5fAgnvQW5wnyZMxaStKL4DrdFSuhZ1Au37yUdZxq/asnL2FtrbFZCs9a3SOgiGcwhW7bEFz4p//P3ZG/ucOOtK+/tQlYLVod3I+vXHGTLxmb4TJG3eGZMUkEJIoJhtqs+l6RXw8w8rdSoyj+Rxf5MFj2ac86OI7XN8gcHVd7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKDZa1Ot52gYjDanyl3kPaluXq5pJJ0Vixrqz2nTD/I=;
 b=ZBYtOyxS6sxROPWsPi4LIavOFC4w+vdro102rpHnIz7yZyul3OQDPzPkp7EGNW5o+8a/fShbWamghaYzsWI+PKYjyenjwU+SkPQdvBsnl07FBjVzoxBI/L+L1IQhVPnTdp3KWJ1c8L55UHG6jTz5oePDZSEtBQOz36qu8eINfA5yWdoyobG6bP1/0R9EzOxDmNcixtcxzoaLBXQVhFNbYVIWIX53dWRvfZ+Dwt4v8vuc+GTBMrzYjWe8BY/7wdvu3fpWmFo+AVbLiuyWEZR7QLgKzXnR8shZWeBrfmDurM13PnXitrlmxoIxiayz2tcNRuW1L59oOJ3+l24V7vrCbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB9933.eurprd04.prod.outlook.com (2603:10a6:102:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 10:06:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 10:06:51 +0000
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
Subject: [PATCH net-next 06/11] net: enetc: only enable ERR050089 workaround on LS1028A
Date: Wed,  9 Oct 2024 17:51:11 +0800
Message-Id: <20241009095116.147412-7-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a1f64e84-d373-4035-79c7-08dce84a181d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uND/B+NKxQTVBe1JeQd6e51oQVdcIkLzl8DCuzKCvkRWcoqGoXVTJKCkUBsG?=
 =?us-ascii?Q?Cn55NyJxQpa6hWoldDDZKNYplcvDZRUWJulNy3wLx71037uS5k+jgVCmmhZX?=
 =?us-ascii?Q?EIaBBsArzojvz8SKcfP//8LWMOuTrJU9BUVCjRlsQwQYOixdbL9skuUZkiyC?=
 =?us-ascii?Q?S76O8TcJgwjyugJBJh+YKK31rBSvLl/39iUJoPRWjHEhZDGALZG0N+wks6jh?=
 =?us-ascii?Q?lqa3uTSI0meFRmh3fJynttKZKQtqcUYfRnQjHVXD5+GHembYjt0awnKzuPMp?=
 =?us-ascii?Q?y8+lac3iZpjwI8p/4YmWHui4+Th/k2peZdttPHQDYg6k21iYevUsrC3lbN69?=
 =?us-ascii?Q?4n34RVCTvLLwotvQRa7pfjnmaT1oL6rdFkPPwN4WNpG7L9w/o4i9BXnaZce2?=
 =?us-ascii?Q?fGDHkZYcXJLw3zeO2jbCn39hY8TN/qJ/vfPRy2Ws0qhMZ7p7YmrEoam968X/?=
 =?us-ascii?Q?Evw2K13AqLsfUon3/RV5N1TXC5B7Ui2VWORv16Km5clz6GKgUin1C8Gfi5rs?=
 =?us-ascii?Q?jWGizwmgrIlqr0VuDQ2UnWr2F2zL8tapAknd9beA1esEhNpDZtGdHh8DTuAu?=
 =?us-ascii?Q?JN4tigarF0Exp0xaecNBMUM3AbSzE1W0RD25mLTI8P87aZ2lvMW9LZ5tzjzg?=
 =?us-ascii?Q?QQS0OJsqntPfAgIN07blBGEHIRcfuBxUj2A28VHxA8C73nZu3gDuHePl5VUd?=
 =?us-ascii?Q?NO7LLvDn1fBQhMmeO9B2X5tsVaL2vX2pTTAJ4+VSAU4P1Np0Vm5P+9xK8saj?=
 =?us-ascii?Q?MQ9yPncwV/FLvQEXk8VduFkvka9VjCPZ8NzmGhknrNkh3ILVQ1dutFPa67DE?=
 =?us-ascii?Q?y+RITMyiyxRcHsygL/ih2gvOc+lckTrJdx80nJzxD4fCrv4YtQmFCmAxOunm?=
 =?us-ascii?Q?knvjvywj9RhmHmzVx7VAvKm1elTRAKTHbzNF/ywJ9YKDq63vfZx8QKg5cGUU?=
 =?us-ascii?Q?HKEmE44+cecl9R6ehUZJuxgf1y27cV0DVIBwaA/cLMLKPqKS00CrIB7GfH+N?=
 =?us-ascii?Q?frW+z0lgqfD8PwvgH2cpNM3l+EFXtNMEZcndsHPwdW86xThVZGUGSz+odmHf?=
 =?us-ascii?Q?XfO1WUcIH1A85AWEXu7e0VHqSXoW3I4OfHPWiaX1PaFOhn47ZpPgzAigg75r?=
 =?us-ascii?Q?o8o6wIeDyusJkbARvgQnWQ+Sfe23pHFHYc5swXdtpJBMp6d839j6SsSOopvS?=
 =?us-ascii?Q?+AlgoAXsHrNJHUMZSEvqHFyDi3N+4qw/kpBli53hXySYEqfBZ+QY4Xwx3A+8?=
 =?us-ascii?Q?RGbskROEzvFfbIH5QRGHON5edxz366Jw8I/j/X/6hivVomoXjGlydwA9DZTL?=
 =?us-ascii?Q?qsR5GUo3bSAoRj7Sxalr+lq6u0yTPyxDXMOb3XEITOAvXiIs2chJ+GSEHZpw?=
 =?us-ascii?Q?5TnJ9Bs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tjE5RtltYoJJs81NX6s5aL684ljrswgT/vQWqVzxQx2fXmy04aVoaleqiIb4?=
 =?us-ascii?Q?LS1dA7aTcbn9jJ0i/cYZZ26Rk+kvoW8sJlkUhtUDi6jqiosdcR+ptmnBI3Jv?=
 =?us-ascii?Q?OtyYyWBW+EtjAcHkQHaxR4X3nSQBDWoT9w0zX6SUZfwVsFcCySn73kHW+9Kt?=
 =?us-ascii?Q?+r+A/uyeomGCzPKyiUz37Yo1SCsbBuub+WZmVmCBaIzXi0I0NvOS1ASMdA40?=
 =?us-ascii?Q?8oZlJ9uUhZQBq1i4crAVDRjw6oUeKrxkGxWNSGyW/Jjb3vC9CfCzmHPZ8sHl?=
 =?us-ascii?Q?R0vk2StwJFLEKf4qtOVmXKZKhalKQlupE/dxD+rj5UDE7335Xz89ysS2lcLE?=
 =?us-ascii?Q?dY89E6qwFDqQ/mxuJVIYDE3h64Bdu4mVq+PVuNRrZQIX/7+me/lj6LL91473?=
 =?us-ascii?Q?wmC3NRey2fQzUxj+kXphklhB6EgQBEjuUz1NEvsWBOcvtciFTNcdc1dN6PFi?=
 =?us-ascii?Q?VuZoc+nqAKULedEZDRDfcu8zJFF0Sp4mR4Kkn5WhZojP0C8dXzZ0V3tbG+fs?=
 =?us-ascii?Q?72BjZ5KKb/xa7vNJPAOA+En8WIZDzRLqfjgGgGMrpisCNMuVmyrxYpgsnwZ3?=
 =?us-ascii?Q?JMw9vqdI67lcy7B5cMQJEPG7znXzhenpZzd/IBWQVhC6a2fjeAV8vxGyLee7?=
 =?us-ascii?Q?QXxIG4w3UiDeVTwVxpgguc3yXQm4skoL3Pd5XN4PGX7FVr4XbmtGB7XTU/bw?=
 =?us-ascii?Q?PgUXlG4QzwOHgC8vwoAaG8ShGK/6q+k/bWWlbb308GxB/WKGSplS2S18Emap?=
 =?us-ascii?Q?znOIHAZ20koD1P0oZ4+Wnsyc5ZyIUHNERbRkzXMtYpJsknQvV6SdaCVgTLgC?=
 =?us-ascii?Q?gVXqb6lNzt2eQ0XHsxDutfHmLn0QIko9AK4SWDQC7xEOXg6B21qoPDYRIZDT?=
 =?us-ascii?Q?YEY+669lrYrRJkvEQ3/VWrSuCkJrzdeGzWQNHlbTDLqYVE6uG//IvRPDq5/S?=
 =?us-ascii?Q?QrFuvYr/Y7OB0+nl5vsFyOG89jSuK8LYiRXeNmK7S4eXuuYHLEkfKgBDtUFs?=
 =?us-ascii?Q?ZbyswYix5nbP3S03WbcGv/sDydfCuVEv896Ty3GdB4CSVMKq5XayIFxPs9AN?=
 =?us-ascii?Q?ypcbbsuus1HFfEAZjOv9JMcUGw5UrgRhEor4rzHq8Hj8rqr++8q7OIGRRMXB?=
 =?us-ascii?Q?c0+CGFbld/ijIc9yGjUXtB1J9Ka5+zNP5BbRUM3ye6oNUElqZWVeAw0+SiVO?=
 =?us-ascii?Q?RFWaG8gtQ7ayOb9P2J18+BJnKYYIiJVM5JoErYjgaypgp7xgJzLZh9mvw3Tw?=
 =?us-ascii?Q?wqnyn8rTJd2oID6K2e9ZaoeAnQ+AvjMCmVSMqqncQ0xc3rwSPBUMnRLv9dJA?=
 =?us-ascii?Q?W1y9L3tEPldYUkcdo1+fyEPCwQTcLN07eRtJbh5rNkR6urXmt3sdSyZpK16j?=
 =?us-ascii?Q?5eHkBCkcYDI5dcd8NunW8ttHbPqqO+ejd96ZO3xhnMNMYaZpOdgCR0jjlebq?=
 =?us-ascii?Q?G4gSBaPrMBQ+uBKTRZjj52t06xKJRGb9a9v70g8Pz/XQPNKg3mJ1vW6jal9w?=
 =?us-ascii?Q?G9jMkMRMn+euzVf+/+JyWDumCCC/NOTePmMMqFdjha2Of5KqJDxcaJhqKZQF?=
 =?us-ascii?Q?wbFwQRVPshdx5qOzOY50XZvntBLpd6dfjZq1ZGjW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f64e84-d373-4035-79c7-08dce84a181d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:06:51.1352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y45zNK/s/JAPB7QaydjJV5+rOzcm7YdPUTrnSjAN7olrHreGxhd9DbA2To3qJPKosHfXj1S2Y9cj5shM7vV++w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9933

From: Vladimir Oltean <vladimir.oltean@nxp.com>

There are performance issues associated with the ERR050089 workaround,
as well as potential functional issues (RCU stalls) under certain
workloads. There is no reason why new SoCs like i.MX95 should even do
anything in enetc_lock_mdio() and enetc_unlock_mdio(), so just use a
static key so that they're compiled out at runtime.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 34 +++++++++++++------
 .../ethernet/freescale/enetc/enetc_pci_mdio.c | 17 ++++++++++
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 1619943fb263..6a7b9b75d660 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -396,18 +396,22 @@ struct enetc_hw {
  */
 extern rwlock_t enetc_mdio_lock;
 
+DECLARE_STATIC_KEY_FALSE(enetc_has_err050089);
+
 /* use this locking primitive only on the fast datapath to
  * group together multiple non-MDIO register accesses to
  * minimize the overhead of the lock
  */
 static inline void enetc_lock_mdio(void)
 {
-	read_lock(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		read_lock(&enetc_mdio_lock);
 }
 
 static inline void enetc_unlock_mdio(void)
 {
-	read_unlock(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		read_unlock(&enetc_mdio_lock);
 }
 
 /* use these accessors only on the fast datapath under
@@ -416,14 +420,16 @@ static inline void enetc_unlock_mdio(void)
  */
 static inline u32 enetc_rd_reg_hot(void __iomem *reg)
 {
-	lockdep_assert_held(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		lockdep_assert_held(&enetc_mdio_lock);
 
 	return ioread32(reg);
 }
 
 static inline void enetc_wr_reg_hot(void __iomem *reg, u32 val)
 {
-	lockdep_assert_held(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		lockdep_assert_held(&enetc_mdio_lock);
 
 	iowrite32(val, reg);
 }
@@ -452,9 +458,13 @@ static inline u32 _enetc_rd_mdio_reg_wa(void __iomem *reg)
 	unsigned long flags;
 	u32 val;
 
-	write_lock_irqsave(&enetc_mdio_lock, flags);
-	val = ioread32(reg);
-	write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	if (static_branch_unlikely(&enetc_has_err050089)) {
+		write_lock_irqsave(&enetc_mdio_lock, flags);
+		val = ioread32(reg);
+		write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	} else {
+		val = ioread32(reg);
+	}
 
 	return val;
 }
@@ -463,9 +473,13 @@ static inline void _enetc_wr_mdio_reg_wa(void __iomem *reg, u32 val)
 {
 	unsigned long flags;
 
-	write_lock_irqsave(&enetc_mdio_lock, flags);
-	iowrite32(val, reg);
-	write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	if (static_branch_unlikely(&enetc_has_err050089)) {
+		write_lock_irqsave(&enetc_mdio_lock, flags);
+		iowrite32(val, reg);
+		write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	} else {
+		iowrite32(val, reg);
+	}
 }
 
 #ifdef ioread64
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index a1b595bd7993..2445e35a764a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -9,6 +9,9 @@
 #define ENETC_MDIO_BUS_NAME	ENETC_MDIO_DEV_NAME " Bus"
 #define ENETC_MDIO_DRV_NAME	ENETC_MDIO_DEV_NAME " driver"
 
+DEFINE_STATIC_KEY_FALSE(enetc_has_err050089);
+EXPORT_SYMBOL_GPL(enetc_has_err050089);
+
 static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
@@ -62,6 +65,12 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 		goto err_pci_mem_reg;
 	}
 
+	if (pdev->vendor == PCI_VENDOR_ID_FREESCALE &&
+	    pdev->device == ENETC_MDIO_DEV_ID) {
+		static_branch_inc(&enetc_has_err050089);
+		dev_info(&pdev->dev, "Enabled ERR050089 workaround\n");
+	}
+
 	err = of_mdiobus_register(bus, dev->of_node);
 	if (err)
 		goto err_mdiobus_reg;
@@ -88,6 +97,14 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
 	struct enetc_mdio_priv *mdio_priv;
 
 	mdiobus_unregister(bus);
+
+	if (pdev->vendor == PCI_VENDOR_ID_FREESCALE &&
+	    pdev->device == ENETC_MDIO_DEV_ID) {
+		static_branch_dec(&enetc_has_err050089);
+		if (!static_key_enabled(&enetc_has_err050089.key))
+			dev_info(&pdev->dev, "Disabled ERR050089 workaround\n");
+	}
+
 	mdio_priv = bus->priv;
 	iounmap(mdio_priv->hw->port);
 	pci_release_region(pdev, 0);
-- 
2.34.1



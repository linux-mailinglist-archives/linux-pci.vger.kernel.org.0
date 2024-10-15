Return-Path: <linux-pci+bounces-14563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762FF99F381
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 18:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438552816DE
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 16:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4331F76B4;
	Tue, 15 Oct 2024 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XTCoOWFa"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F91CB9E2;
	Tue, 15 Oct 2024 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011513; cv=fail; b=RIethl7WcpslKKAowCy8ALd8pdOtjvy4RA52YVoL/e73qo0y/HpKYl1hMej+0x+h91hyPlDllcp6Rza/6qHtbTt+9PxUojo+tLyMgzaZU68pv78C+L0nBCf2h1jcHkwaoc/xu5i9dL/ka7oz+PEpzl2qq4B9en2jWIspgCMwpqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011513; c=relaxed/simple;
	bh=mUr90TeLgR/uCobxGMSnbcYQ/KqDbhwA6QI4jjnfK6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u/kfwLnkwh2U7sOAe34LUH+9SytzKCGxa5MAcLY6BdDg6ZgSzMVYgXRhc11Rvth//HAbmRsjeTF4p4zvOnKHxHFrmjLrOzXS7Gi2DED21ZZIA/2du6A4hfmbx938AXW6YFz5D9DdwI2r+cw3ZaTbCA/YVYqs7moKsWVkqzR6SDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XTCoOWFa; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0ME/AtqwC2ReN5rBG3fEIhYno6ML3luS5H023Fg3r1f9oKIRqyg7b1Z2csTvFwqEW6E9iAHDFpYR1HRlfTbGEFwrUsZwNxa3ujgPV4+C4C3s/fVnSApRB5boA4zVLMM1j42gr5GD1VDsclgmuHQo+bK/7pCu/1hMamhpd770khqMMorycKu6bheg/O/zEGpQ/n7CqhpvfxpF9z63IIILe8xi2+OAeZKirovIr1slGHCABcgsVXbioboH3u29HV7EcPFWm8SbZPvTTopCQQtUPJ8SwGEO0spX9S1lHogH1a6ES4FZqsQ5o/ekTOu0NdZktuDgV3IBCsQ5+u7lJad7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5Mq8EaQWcWqM5uqCN4TI82PbONubJ6vNR5ZK/3YJ7c=;
 b=wKVCcxzrWMSdq+UoiHCAuNfj1C0Q5wcyfXFegAhkbRFf4MC/iKw1lILmbl2yAShJpbFHA3T+FBuGRQF+Ooz1xnyWMB/wKD+HjhvariGouo1ihN1TVj6xgEep3hrHvCK2yOrZHnQBSmpB/CqDB4DU1gSzRBi3Jaxo9r1QmmeADni/n0QyFkN1NLeOltpH1K4F+VX/lyvcYBuR3IW6G5eGQWb4FQvZu1nAts/jdbYor2kRZkzZU1lgstbNwdIoSgn/luyoyPgU+jrdu9POlIhFuFUxd6JSWcUEToGUTaDeEuaoR7I6I0nOEnZPAiFXK/63m8JyN7CzTsRgqT/zmSqEww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5Mq8EaQWcWqM5uqCN4TI82PbONubJ6vNR5ZK/3YJ7c=;
 b=XTCoOWFamzpV8jfB+s67y03qL5sNJUoovbXBbr/th6KvwHmoaDWsIM7AIhNEYF9jXABauooIgXnUEEd76kPxzDXmillVz8XO02F9x+Z5FtiGpHdudlZZrF64qFLkJvI/XCZFDpAUgjPawUDQHJ3vsjFH74RyXBkcdU8/gxnwcv1o2RAwZGjqu0wX4F/Gte/VxpD9Oh5qH/kL9HLe255wzECmlptnUch/QcvrIq/qH9HRRZK6Eq+qlTQhnM8dqp3fIzAj15Zt+ir43tO9UDtbTbwZtVpxUOhx8uPHJRlJ105aSdGAmCJb4mIx2+Pb1wMgYT1UmhQH/UgX5avR8uhPrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10828.eurprd04.prod.outlook.com (2603:10a6:150:227::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 16:58:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 16:58:26 +0000
Date: Tue, 15 Oct 2024 12:58:16 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 net-next 11/13] net: enetc: optimize the allocation of
 tx_bdr
Message-ID: <Zw6fKHOXbQsoV4MV@lizhi-Precision-Tower-5810>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-12-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015125841.1075560-12-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:334::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10828:EE_
X-MS-Office365-Filtering-Correlation-Id: db91f4a7-ada5-4b70-e2d5-08dced3a9614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pQZTAcpBVe+kuZUbF18LBhqzJIsg8RVvWMDkuHwUxcjV9f++9/478gpFWw8t?=
 =?us-ascii?Q?9Q9EsDNPDeZeEaSyU6yGwYJ9hU9gHPX0ibzwXGc3bbXZACHBgjIMoRIwKz7F?=
 =?us-ascii?Q?l4otpcKLXg5umlDqWQafBMZ8nzM4oUbWP8dsfnM7nPo84cV8+TkHqF8hUrcs?=
 =?us-ascii?Q?vNP94G61m2oe2QXryhLaBqots2YBzO/LvFxXcO9BYQSU4WLrOE2vACh36W07?=
 =?us-ascii?Q?I9mn0QVSF8OQMnuAmXSgApCyAXUedJhP10ttBnshzp82HB+2H8xN6ErtDWr7?=
 =?us-ascii?Q?Pd9S5mknJmNVRM/K097G9iWEQuO7SvYZ3cdExZ47ttgok9p+RbJvzOS3nT8B?=
 =?us-ascii?Q?RyPIDfUYmK5PGaS+zWdeK5KMknI/AHMF9UvjS8DwxpeQ9JNrinjODzPMtkSj?=
 =?us-ascii?Q?yVIwhRMeJ2XYbYAs5VfxBVAmcsD1Y4VZ+JyN2qjjwW8wZwdc6x5wt5aiSPST?=
 =?us-ascii?Q?p1tS8TUEUrg9y8da1+w4Yv9k2+iMQEC1aFCZG4EWN6keAHUEP1xD9YEEiX1h?=
 =?us-ascii?Q?9lct6sod7Qem9hDDZ2KBM7lxHkgv4hguk3mX2pc/QDdGuUziV4Thwe+1pk3l?=
 =?us-ascii?Q?4hQfEPsihhNREEeFKk2nyBb0SghYChvKP3rd6hcjwg0sks3F7RfLAqMCM93V?=
 =?us-ascii?Q?UjLk3Eh6XtuMR13cz1LWqEveKaQt4lRD5HuNL7+INJmWJvGY/sSp7kpXPYZj?=
 =?us-ascii?Q?3RVhRKHKvBwJrsggBmYjONYAkSQmNkZvmipcObqtF/gSnVpLHQfg/luAyyqr?=
 =?us-ascii?Q?iKWJyJ4SPPlTrA3BYQDvVEUWTjL7LQHHX7x/yDjg6wV5bAXUhaBOapHtTl0R?=
 =?us-ascii?Q?AuskI8T/md8sKs0MK3tLLydhkjnOQaHakmWvSgZybNWTMWDtIfvb5e+hOCQP?=
 =?us-ascii?Q?8eyPH1XhPpqC2UbPy7Dy/UpVu5YzPMJQ4F3YdonMeyZIYy9rX1tfXgObX20+?=
 =?us-ascii?Q?kcl0OadATBEj9ZxAJFU5PV8hJiJ2iL3aWcQkHr+yf4HvF4hGAeoJg64jE4Mu?=
 =?us-ascii?Q?mj3OXJwbx433Jz8kVoAwi0BD8XiZw1l2wsCmfzo8d+2ilv2merC4B0lCP91r?=
 =?us-ascii?Q?kAdknlhncnKAg4YI9pJRX1n69VXQyN+lrGMHh7OrF7lMW0DquOmGi1kQcRFc?=
 =?us-ascii?Q?w0aDDhtuJfDb5el74/iTHe6Mzq8T7sUjvKEAyn7BTZyqZGMFgvzrsiPADhSy?=
 =?us-ascii?Q?C17HEjgoDfa+Rv/fTAgs5XfEF7Z/Uk/uJA24bSL5BuwcN650OPkCLai0a6dZ?=
 =?us-ascii?Q?jpm9NbxdtFK9azaEAScLl17HIhQWPAsTPvTspfknWsSDUttEuG/V0WsXFMT8?=
 =?us-ascii?Q?INXoD8wnTQOYuqpRgmonOPYc5Aj1ZY1HZPekHV7wozerUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Br0HKFPaHg91cQirdhubgD95KSCv0VQIrquOb2O4dvjtUH2nMpnGCwsxJC+?=
 =?us-ascii?Q?lIImql+L3jcgmKNQUL7nK8cmAQQC1GUkTj15utBHtemofSm58albC7Z7lukK?=
 =?us-ascii?Q?SAmSd0qGzU0v8prkaOcATumGUN+E74S35t/vTCJanfTgtywkkeRLZ4d4h5dY?=
 =?us-ascii?Q?w5QShD2cDRFrKg6msaaGB7NrSu58GMaGSax8KsG8AKSJwP51fgPA2+QW/X0y?=
 =?us-ascii?Q?atP3bdpJY2oO3d7ww+C8qns0jTR+zoMBn+o2y3oa/efv2uXuyRsoOnShLLKG?=
 =?us-ascii?Q?XN8+93MVHxjIDapPvUjEF+TH4CtUmdSHW0wxXQVSpipHpVJHCXGuTlM/Scrd?=
 =?us-ascii?Q?fTwzk0stGjhVE214X4LMqiZh/xJLK0PqsU/0l+yUvSah/IBXZ1hFndAQayX3?=
 =?us-ascii?Q?hcWhRlBXKvv7kaSJLTJ4N1qCFximTGURy7ZK2KJpa4akemqMED73g7bM+xLI?=
 =?us-ascii?Q?s+gm8DvtDsJK/UDuAelIA2Z82HnrxzOB3M2J4cEUziQw+Hrq/7oJU2lB9BwL?=
 =?us-ascii?Q?/tX+a4MaaGF9Ns/zXKOpZHvVJy7QhyRteOJIINLLR1thJ9ps3Ugu8X9El+RX?=
 =?us-ascii?Q?ktdjoEoXBGM0Y1PkrlhzfcUc5iUxvIUJJmc6Q2hlI237BHvQPPNnC0QPEi2o?=
 =?us-ascii?Q?JbblypBm9qDfpOh9HlO8o10DzMZsfsDWVi9TH++xr/ZVWuw6TTmms9Sl/dSG?=
 =?us-ascii?Q?xAw+/SPZ2zItMhSUjqpWaypIuTOIb4RGcm55SonORRA2ivpx5PB1bdHU+MZK?=
 =?us-ascii?Q?uecjiqkvsc106cDSR8upEiyISGEVJx2HJ+oXsGUrsD6HUT6Fvc7cb/TxOJ/H?=
 =?us-ascii?Q?K0BqqMtu982BE3+oMEcQfru9QB+qICrhaJ5vlmNsDw5pGSs8hPUsw9Do5tsl?=
 =?us-ascii?Q?gcqscK11I6r79kC8CJWTlqM5mJfTieIHvZBKpb/R4BswaWaqduHtazYe6e49?=
 =?us-ascii?Q?/PCKO9AB+CyLuJ4s/87rNTsJ8MZXlk3k9D0aA0pf0JYhPfKQAxNnQw54KaQk?=
 =?us-ascii?Q?wNGgnoZap8jjCuQ1Bj/zhpW/r4XtdHdQWWyHfVtjr9o47O8tpU2jwz8/VVmi?=
 =?us-ascii?Q?LGjLMZ53g0g8o7s9nzWfejR/xSJPtxC/lHWsMTi1AdKewdapEs8UqfXJrl2z?=
 =?us-ascii?Q?OSFNI7RjVjONuDTCQu+Gz79piRdhqW5FJ30N1R16RaMiyBlSdk8p0sMSXrUR?=
 =?us-ascii?Q?nA81ShCIYcXWNZ8nGLg5zs+6XXknfA83egwlcCkdJO3P41cBQ8wIApo8z5aA?=
 =?us-ascii?Q?TKPpkfocVetE0qIa/pL966aEf87ep0bF3ePHcwtHuiipyhfPICy7BiiFITwe?=
 =?us-ascii?Q?tq3cjEgQJAADVOSF1Y2U1fDr7wRImbp/YEDhBIoinnz3VQ7CeXKZJzpYA8qH?=
 =?us-ascii?Q?8LLMZojBe4lZNcbmEUYQxhyR1l1YKqA5bNFmdVhNU5jXHunJjCFsGLJizwlw?=
 =?us-ascii?Q?Dhw7T1559ZMpgcSwAMUbF95vXI3wJIpwdOdq93JNL5q/mEeklX9Gddie+NU1?=
 =?us-ascii?Q?CXvfGxAkegp73L9HLdd9a3YJaVhfzHdjpj70Awu15czpZWC525gztIjTt7Zm?=
 =?us-ascii?Q?ajT+RXvemFR8eSUx2Bk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db91f4a7-ada5-4b70-e2d5-08dced3a9614
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:58:26.3138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kvr7LiG3wfh2y6G891aYwwRskRBowdz6eeHomR/4ePQhvV4MXm1o5MzyATHWK/D4gKxB8puxDr1I7Xc4AR9/JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10828

On Tue, Oct 15, 2024 at 08:58:39PM +0800, Wei Fang wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
>
> There is a situation where num_tx_rings cannot be divided by bdr_int_num.
> For example, num_tx_rings is 8 and bdr_int_num is 3. According to the
> previous logic, this results in two tx_bdr corresponding memories not
> being allocated, so when sending packets to tx ring 6 or 7, wild pointers
> will be accessed. Of course, this issue doesn't exist on LS1028A, because
> its num_tx_rings is 8, and bdr_int_num is either 1 or 2. However, there
> is a risk for the upcoming i.MX95. Therefore, it is necessary to ensure
> that each tx_bdr can be allocated to the corresponding memory.
>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes:
> This patch is separated from v1 patch 9 ("net: enetc: optimize the
> allocation of tx_bdr"). Only the optimized part is kept.
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index d36af3f8ba31..72ddf8b16271 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -3049,10 +3049,10 @@ static void enetc_int_vector_destroy(struct enetc_ndev_priv *priv, int i)
>  int enetc_alloc_msix(struct enetc_ndev_priv *priv)
>  {
>  	struct pci_dev *pdev = priv->si->pdev;
> +	int v_tx_rings, v_remainder;
>  	int num_stack_tx_queues;
>  	int first_xdp_tx_ring;
>  	int i, n, err, nvec;
> -	int v_tx_rings;

Nit: Needn't move v_tx_rings.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
>  	nvec = ENETC_BDR_INT_BASE_IDX + priv->bdr_int_num;
>  	/* allocate MSIX for both messaging and Rx/Tx interrupts */
> @@ -3066,10 +3066,14 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
>
>  	/* # of tx rings per int vector */
>  	v_tx_rings = priv->num_tx_rings / priv->bdr_int_num;
> +	v_remainder = priv->num_tx_rings % priv->bdr_int_num;
>
> -	for (i = 0; i < priv->bdr_int_num; i++)
> -		if (enetc_int_vector_init(priv, i, v_tx_rings))
> +	for (i = 0; i < priv->bdr_int_num; i++) {
> +		int num_tx_rings = i < v_remainder ? v_tx_rings + 1 : v_tx_rings;
> +
> +		if (enetc_int_vector_init(priv, i, num_tx_rings))
>  			goto fail;
> +	}
>
>  	num_stack_tx_queues = enetc_num_stack_tx_queues(priv);
>
> --
> 2.34.1
>


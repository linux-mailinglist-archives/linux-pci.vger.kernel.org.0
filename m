Return-Path: <linux-pci+bounces-34906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3331AB37F72
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 12:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8908206AC0
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 10:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0272F9C38;
	Wed, 27 Aug 2025 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jpwupz7O"
X-Original-To: linux-pci@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF6219E975;
	Wed, 27 Aug 2025 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756288811; cv=fail; b=uZB/Jg8H/FGotnGtyVhK8Wi/25AYFjDe0/wz1bxtxelpucjQ2un+dVZPPpdIUsDGV3lA1KKcyGUrCmQErkJkwZQD/Vr3fUshmPSJ84kORjJ5N63S4JpHC/LJhtkgtBnFo0l4O6I9RH5wPLqIIJTUMNhaqcPUN0VnBIJ+5U8BFB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756288811; c=relaxed/simple;
	bh=210//JJnZcLWJ9i9fo7kNbyDAiWF4HmAARnA/2WOveg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rY1QWG95ewWgFHVUy8wlbZKB0eO/IUzVCdGs9vB7aTBptuhbEL1j3tPHHXRdjjEIDFYxehtA98bTTs/BKQnClIORB3FTbN/Rm7BPEo5TSK+DL/78w1gz8MQ3A648hi/PpnoCrXopvVuXr98JDgUOJRTxabVvHeTanX3r70k8qw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jpwupz7O; arc=fail smtp.client-ip=52.101.83.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GF4dM+nuMoa/fC3kY8OazbSFnnHWZmMdLt3tTWa2yxsNITDCG6Yd+OUpP5KVcl7csfLDcQMpCyQsI5abEX/p6cOKul59GLz3JOq2gu7HwfnNVkL47Cn68PuVjGNIKkAZoOvICs4VOPzYkKE1DPF6JF5/ECfAyGbUnB6ktwdQsZhwf1kX1Ji7Tn1GkytmWCAzZx7El2VUuudKXncWDLnQzth0HQ0BYcKLlaTc2loWW3sQqw93TpqN2xxw2TqUqgRxa5pRjAG+b0+Qncyd6dd3v0uh7jqJMY0Uowfl4ZWy4mutxHZWkwSrK9/qfBMKDcSZoS802UbKBPXf0ORzrcgTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXHaGC7RC2zU14CI1SS+z8QHmh0+tDZD7OtEX+I4dlg=;
 b=DyvrS8QbcimZosPJmZGGW1huuXfIWSGY6gZEk1zc1oVTZ0UbwUpgIWm5J+8J3EaAesx4qSjvwYETIRLYFY+S7GaHmq7cuCEUN6j9JcDHRaC4Ne9Rz+gbnm5tgyRk6YvoDR75tcWp3gCotoi0KYMGjOPTyhM6ERYyYqIJcay7Lh3qyZ+IF+k8VTLahqQ1BMZcOYO3RQDJM6riNCuM4rlOakH9izkRvHxf90R9vODWOriWPFBJqOHpac1CNviarhH2NkFHntW28+BmkIPxYfj4pSccsrRANVGvczVpLPkMYlHgQYs9o5p6JHYJndd4NdJoO/6Se9WgomuIGGaIUAzORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXHaGC7RC2zU14CI1SS+z8QHmh0+tDZD7OtEX+I4dlg=;
 b=Jpwupz7OlAWYPV1Q0glHb2dgdpAzSv4SDnWulgKQ3UWN4i2vZfotUe2VtshWRhQeWeADFOJ/ZpU3U6MuCN1GIoPX5HoDRCcJz4hMpl9+8glrIHz42poKuHo5Ahuv8N7C7ijdR9Ac/y4Oe6z7lNS1LF4PVZrcCDlJj2cgRXWdmuc038lgAi3tVNIE2Jt2Des9pXeS2AeAzW5XrQoQSYXL2zFxl3DsoRF3Jjg5VORGIE4dbQ3xtqq/FaGFTjAiv62xvlAYmyaNsyZEhwM6IUahsbFF1CuGYe7/bhFYJRsH24jayLrxWS3CxqOBoE6oYPmYC7As3cexKmVY5GTsZaQdSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8754.eurprd04.prod.outlook.com (2603:10a6:20b:42d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Wed, 27 Aug
 2025 10:00:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 10:00:03 +0000
From: Wei Fang <wei.fang@nxp.com>
To: inochiama@gmail.com
Cc: Jonathan.Cameron@huwei.com,
	bhelgaas@google.com,
	dlan@gentoo.org,
	haiyangz@microsoft.com,
	jgg@ziepe.ca,
	jgross@suse.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	looong.bin@gmail.com,
	lpieralisi@kernel.org,
	maz@kernel.org,
	nicolinc@nvidia.com,
	shradhagupta@linux.microsoft.com,
	tglx@linutronix.de,
	unicorn_wang@outlook.com
Subject: [PATCH v2 2/4] PCI/MSI: Add startup/shutdown for per device domains
Date: Wed, 27 Aug 2025 17:39:11 +0800
Message-Id: <20250827093911.1218640-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813232835.43458-3-inochiama@gmail.com>
References: <20250813232835.43458-3-inochiama@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 1230bbf6-6c18-4354-c673-08dde5507dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EcctPLSss24zCkCXUcJTdiizO8mRhljv1qWUZb3R9W62A+BJY8V0KNcnoHbH?=
 =?us-ascii?Q?yucBbkc7MX72lQnndxHLb9OIaXDs7RYQYWdCyBj9sHTTCGNyXfZFlEeI1qjJ?=
 =?us-ascii?Q?ziEFyu0bCis+1sotn/iDnSvAZMJacPwVMfw7mAOOSBt3E3og0BTzLp9Ecl6m?=
 =?us-ascii?Q?v/rWHvHnEGINWxAAL3m8IZ5FJ+7FoMD2wNQaKEM7K7sZWJu5c+xp5vULTO1V?=
 =?us-ascii?Q?EZ6GMtrRDPiZWg28RBsp+1Sa2MyuKebUG1zMU0oP6UKOxXOeDSIMr2afDmWr?=
 =?us-ascii?Q?HXMh1FAlhrRzSJlsrswzDtXjMO/LAPSgsSThM5cgFjAlUP8bacGWUOe0LY6y?=
 =?us-ascii?Q?4IBB/Zxco9IMq/16tMVwHoGPUEB4sJ/67I0gi3Gfj+vxv8QKQ8jySSNGaGbw?=
 =?us-ascii?Q?kFGPlszXs+V7YR+IlbFZJogh5RunXsK4CZvAZ96mce4EQzpPN+Qefm64uY+c?=
 =?us-ascii?Q?/LmMiW1opLMA7J3qT+QiQlY9W4zEYjyw55wJDQfr/dci5eDB7cuDEtZg9UJb?=
 =?us-ascii?Q?gmoJmF4YjyWvIol1/2VNWLQ8RlRcLawL8EPZlCRdxesp2kOmbtSFc4/bElnv?=
 =?us-ascii?Q?QH6lKYJ6QO/aYhk1G3TxNOO8q38y0pI9JrSOu8RcAFs4qSHP6s4gaQmA49Tc?=
 =?us-ascii?Q?1x8vK3u3c4aye0FbizJQ/RESu/8npeUAGno2Q0Ckds0P5nE4UAViVn3blFxh?=
 =?us-ascii?Q?7DbT45Mjemi82auKL8aFSUdp3Wdz/kb8TRWisb043WR4rZDzBtDyPBH9vxRY?=
 =?us-ascii?Q?DUUTbCZOr6hw+7dNd762Wx2zsiIaTuAjI3oOI2UhI5Jzfh5GsJ8bjYLhETTX?=
 =?us-ascii?Q?lKvhQUX8HoUaDH2JasR7CaDfI0s7hYTivt/edYUQu/uZdiP9tq1xmBXzMCP+?=
 =?us-ascii?Q?D3scgW6zlTbyk6M+cbegc4X7BaPd9R9sD80mmjF1LbhpGSNj37DxhPlL3b1u?=
 =?us-ascii?Q?a7H0pwubDHGmISTtRY9IsGMiSMkRZmwTb0/IwTR983ZExB8/umAp1nbx/t1t?=
 =?us-ascii?Q?6K/G+h2Ea9Kx8Z9gvMPXdxJii1p2EmzhXRrqb6nPE7yBFWAEl3U7DOwSj05j?=
 =?us-ascii?Q?rhnFJX1ILcCdOmYbgpagnwNzCTfBJNkdfOKLs0Z9Xnx6DXCYvQoQFchmkPZX?=
 =?us-ascii?Q?Ft/rx1HkOz/93QWTZWmMAU+RTtENlp+oevpoJBOkd/bOv2AUcUGCtKBkJj+F?=
 =?us-ascii?Q?WBczO8H9CaIQjIa+2490o0mE0btAnoB5y40Fry5BQAp8CfGjKUxDTtEM6cqQ?=
 =?us-ascii?Q?PoKQduoJM9XbL8GKeEBCJIW2nojB/UGm9LbcNaFxzed0fGZ3BvkyK26yb9gO?=
 =?us-ascii?Q?CpO/aTIz3rntnkNXIdk4MF8qI7Vb8nFlDCsP6yMlGVEvkB0svKpywNIHvVho?=
 =?us-ascii?Q?d6B+0NSIz9keA5YOxpaGpuhrDKUZENnhI/iX8HBSmoxyp7VqJ6icKIebNq+M?=
 =?us-ascii?Q?hDicjZosPqEK+GFnMPc4XR0lTtWee/HewRRrekjsNWN7Qs0+8l992A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QZRggGAtg9xlVRpQdeMIqJURBj30X90Jhv4wPzicZbyLkhqVe7Yi068W+mDU?=
 =?us-ascii?Q?s83+n1qqIbXRnRyxdSLCl3TzdUaPB9J+esR34Qu5sFcYUTKXrDQd17X2LLQ0?=
 =?us-ascii?Q?lM1R/NBmn/IpFFQ0Z6WteQXQiKeQbIu+eyX3ieoJPHimjgdK97B+zydaDLPI?=
 =?us-ascii?Q?2yb1udc1nW0hixnjtgA4uzJSKNi68veg4Wau6qy+2A4rlLJm1D4PwQKU7aos?=
 =?us-ascii?Q?WFDVzzAztttHFbybmE0SpWT+51nXOsq2zz0yhzpzWqfPvl2bnwHMAQvlK96h?=
 =?us-ascii?Q?edcl98aoYOKmNe7lTG+9RkS+7taQXnQy+Iiekef/Vm39mdOea6vh+jRl1gLt?=
 =?us-ascii?Q?g+ZvMBwBhcpmWsfmHsQsIutkp+UFxp6gZi2UyvJPs2wICrUhYblmvHVJZu02?=
 =?us-ascii?Q?2SIznK3w2y44eDOlylZz3qqYVyaJxkMRaRA6z5gn/pGmWaKYf073sjAmMPaN?=
 =?us-ascii?Q?uvPWGsNU3RTG5oQBJC3T9YFzl5G0Ui9gOkOta72d4yRa+91lILQGbtC66Z89?=
 =?us-ascii?Q?eygRMTZpSGF2q5Tuq4bJVll3TTWy+9fvd/e8YFYmRbRILSuGq0ZJ4AaP8YnN?=
 =?us-ascii?Q?n+sIgQkZORaRn9vlmDDtlEc7sY1FZDLMcLuncIz/fRIcxSNyfXcE8bA1qeqj?=
 =?us-ascii?Q?+EimB33rSJUN7YBNwdD1Hz/clgBKwSZ0yes34OrIQCao2cbnVQrJKu3Dste0?=
 =?us-ascii?Q?i4IL7oHJMLLMZAezb4poUXBMIcTQ1EJvtvFPnXENFi8pfp45p+K/5gzvfCRJ?=
 =?us-ascii?Q?D7PflF8qmyZj/14t/SRIe33Scd4kvYbDpno8VUkMkEPGMnV3B7zCs713Co84?=
 =?us-ascii?Q?4fZHnVgMCTKLGeEHh72x+zIzvrIT+Qf5o+TY4SFao/NcD6fOqUA2DRr39vON?=
 =?us-ascii?Q?XiTX+T5WLRvHZfsmRQd0E2g7p618IghLglWDYmFHAy74Dc0Hy5qxDS9C929V?=
 =?us-ascii?Q?dcvlbXqCPV8971fdNuznFyjtGNwcBGNHDHbpIbH7Niy3NFDk7SXQkGl4rt36?=
 =?us-ascii?Q?yKU2wqg69yhMYvOzP9TLQuCPMzAx2h0MEL26/PwHmZsd4cPOe2Z/lHMs5tg7?=
 =?us-ascii?Q?rLADHUQsl+zYRWFljnvYjQBMH4XezbCbA+Tnm0k4ts+l3oC6eAGpTrU/TeYg?=
 =?us-ascii?Q?+G+ZDZtS7ZRJJm3NZvpuVS/K/FHCSy5/feIAg2P64UfJtCuO5mB7YwFQqHFB?=
 =?us-ascii?Q?w+kEnQkg9MfWVYIoRdWuyFU66Ug8eZQ8gviv3X3wK0ZxX0GAxVhDeU0OcG5F?=
 =?us-ascii?Q?Xl5LhHG6ZpwE2Rjh537qkQ2gdxIFn2AxqwJLdRefRiDvEGmEP882S5yfguhu?=
 =?us-ascii?Q?2AIdk6M+7dtHenDn0P+We3JFECpEo+2LjoJBK2rdttRgZ+tmY05tcWe+3umn?=
 =?us-ascii?Q?EOqmtx/vOHOCSrQasubLuVpc6PfOKLKPrd7Lu6OODt+AZK+MvbwSLHHtKgys?=
 =?us-ascii?Q?Oa+QhEa4ENj0QxEQsBPgBmbXtUHb2Gg6X8QPA4Pufd1pPS1qbz6VfiLkSmoc?=
 =?us-ascii?Q?vWiwciSzZzs2Wksw/txaIyJNsIZkvjSxyxZq2xscKO1ZPemxNK9myhnxlEfe?=
 =?us-ascii?Q?t2WrjwFstEKhxv4obrIMrj6RuaGRpSNlRbzGgTRV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1230bbf6-6c18-4354-c673-08dde5507dca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 10:00:03.1182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmhyggNlxB1FG8QYHt3W7eiHQQf78Q0R7QLlZ1Bjm7VZo6yyo3EyMj72+aQHe/Z4AzkPzUFSoF5kCd27O06eeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8754

We found an issue that the ENETC network port of our i.MX95 platform
(arm64) does not work based the latest linux-next tree. According to
my observation, the MSI-X interrupts statistics from
"cat /proc/interrupts" are all 0.

root@imx95evk:~# cat /proc/interrupts | grep eth0
123:          0          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   1 Edge      eth0-rxtx0
124:          0          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   2 Edge      eth0-rxtx1
125:          0          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   3 Edge      eth0-rxtx2
126:          0          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   4 Edge      eth0-rxtx3
127:          0          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   5 Edge      eth0-rxtx4
128:          0          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   6 Edge      eth0-rxtx5


So I reverted this patch and then the MSI-X interrupts return to normal. 

root@imx95evk:~# cat /proc/interrupts | grep eth0
123:       4365          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   1 Edge      eth0-rxtx0
124:          0        194          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   2 Edge      eth0-rxtx1
125:          0          0        227          0          0          0 ITS-PCI-MSIX-0002:00:00.0   3 Edge      eth0-rxtx2
126:          0          0          0        219          0          0 ITS-PCI-MSIX-0002:00:00.0   4 Edge      eth0-rxtx3
127:          0          0          0          0        176          0 ITS-PCI-MSIX-0002:00:00.0   5 Edge      eth0-rxtx4
128:          0          0          0          0          0        233 ITS-PCI-MSIX-0002:00:00.0   6 Edge      eth0-rxtx5

It looks like that this patch causes this issue, but I don't know about
the PCI MSI driver, so please help investigate this issue, thanks.



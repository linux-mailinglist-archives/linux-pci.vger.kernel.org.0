Return-Path: <linux-pci+bounces-24501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2B9A6D6D5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 10:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7120016A1DE
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 09:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0733925D55A;
	Mon, 24 Mar 2025 09:01:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2521818A6D7;
	Mon, 24 Mar 2025 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806908; cv=fail; b=FUdjEu9zTFMwYys0mFmGQOVeH8k2qKE+bnvU+b+RjiwV+8dLbaA8vQZLdqM1cP2kW5EYCVsF7kl3znOe7kUutPL3ZitmUUDXY+rkKAWz7YRRkTZEh5uFK2Xr/HOfD1uzBjmTqib8GfKCqx/fESxKlBbTt56macLfbIzYOo/+gCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806908; c=relaxed/simple;
	bh=qWLhrexz3kdoUxVyL5Qibz7Gwj5+bzvcDETDX/x9nkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pg1R/pXWx6g5IwmsdO0kqMrPoobTGECE4Dvcx9HgPHYyQ5fYTk06yAlFf5vQUAEIQLSeT0fJpuJdioUjuDXRtRabIQ0YKH4N0gXhJ1Q1npIwumWD89FnHLrqvCX3v66riJVYb7PB2Lpx51Ezct1K4d8lr+Aj5pDVxom15N2IvqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O6MvZW012667;
	Mon, 24 Mar 2025 09:01:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hm68hv7j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 09:01:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrSUD/+a9JOTx1Akfo4n3oxzij23Y6WUgQkSN8md2IwjDozXIpjYmPjKAAFyEPui2Y2jTcRCioefJDPw5C5f7D4B0BXLllIC9iFeDoMMxfgjSQ6J1ruf1fK6q1u4HRc4Of9Dr0O1iprQf4rxsgQp1RSpNWmE2ru6QgO8qNbbajQdwdetvfW9XQx/Y/a+HuIQIb8UD3yiAsexQGEkVN4J+U1lhnhSX0bzXKadczw43ueLu8oPyEqgKo6517D6MvNBKSyJqxhiIUrYDC430XU/S12UfNv6FoHigKvWPTA2pF8ICIiTJA0SbGwbvO7wZQeyeQwPg0vmssKXO2nWjUAldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VL9A2sednc4xWhODgaxwba8U0hOVoij2m10cT69k3bw=;
 b=gzoQZZ9KqEAHD9w+7+1fHLiyGsWkvwxcw8htfC4jsbVdukriPKdA+YN9ZP2RzsE8VKQUtxFAnqQp8qaQol+Mvd+BBm8K5WLFzqw97YZp76QnyfGvSxZjCVXu+L4zATuQacZd3Y0HKmvaQSA+dglRvZ5QwNEG7wiaBK9JOQ1ikUyeJogvr1TbHXA/GuZKhi7ty6wNzqU2vCt8qKFlk7nfce8XqZbf4T+/c7SFR9kJ1AmXZtXcD8ogoeaC0Dq4FSO62aMr3fNWgFZZ4KyZZvqVRsWlBZivQs+7QQuI/YghR2Vj1o4D36OJBjKlIL64uOx27a/nVG8rSENhR85S7pfwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by PH0PR11MB4901.namprd11.prod.outlook.com (2603:10b6:510:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:01:39 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:01:39 +0000
From: Bo Sun <Bo.Sun.CN@windriver.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hao <kexin.hao@windriver.com>
Subject: [PATCH v3 1/2] PCI: Forcefully set the PCI_REASSIGN_ALL_BUS flag for Marvell CN96XX/CN10XXX boards
Date: Mon, 24 Mar 2025 17:01:07 +0800
Message-ID: <20250324090108.965229-2-Bo.Sun.CN@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324090108.965229-1-Bo.Sun.CN@windriver.com>
References: <20250324090108.965229-1-Bo.Sun.CN@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To SJ0PR11MB5866.namprd11.prod.outlook.com
 (2603:10b6:a03:429::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5866:EE_|PH0PR11MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d02486-0fbd-43b2-b980-08dd6ab27d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kuk7G8EYzVpBcaPEC02W3JX1oaxV+2qNX2NAbJdDkBamieLGtQjlC8AQQZuV?=
 =?us-ascii?Q?CDN1GuO6C1bzKex+k0kWCVbIUjDuHuL1JiCeQuPZXn8HO9insdGi4rM6eQQk?=
 =?us-ascii?Q?WB1l8Fn6tjgoinmsaOlgRVzJNW1cJjiYwwy4kP1vwI9X6qdHMMLsioRw0NLY?=
 =?us-ascii?Q?KlRetoFk9MdX6auMtaFFsQQ/JerzU77nkqAfDs4BCr/+LSHrxCCJoArnKqee?=
 =?us-ascii?Q?7ED0NcabliOdsly2J6tDh7npxiP4NOWJNRm6K122/Dspt83zqPx/8ja2lE49?=
 =?us-ascii?Q?gDtC8SPuql2h6b+K6Sq1EtzM1Mozpf3HN0OkACQ6NI0Q74wwF3/gr47fc59j?=
 =?us-ascii?Q?/kqlGyhu/a5AtphLF4t8tCSgpIOCtHDXWoOKTaiRkD0bnXPG6wht+vgjhgNu?=
 =?us-ascii?Q?eJ11lRWpkrKFClJrBpGMW1BUv5n55ye/FIjqdFgn2AqAiDmnSJcSewsgwyM9?=
 =?us-ascii?Q?fxfJYjD+rU3AcpvxDAcbR/tLiamrfolLAz4zUazPmPINveuFUqJd5xUqHNc6?=
 =?us-ascii?Q?6Vag7qSGliA60YSRfMHFt5e0OHYd/E4+KYkDMhUuO2GAhQirKaAIzVUVTUei?=
 =?us-ascii?Q?zMcxEv2domfhn0kf2XaV5BBHg5H7Lef5K2d7S+vwKMa+Bzgtow4X5wP2grN0?=
 =?us-ascii?Q?DlLsPYBaL/XP0v7CQvBsGkc5ziCiZMvREYuj2z+xVNVMBC5D/TPkI05t4ghw?=
 =?us-ascii?Q?wuaqZTRoA8hJz49JSASoIJbIShC83dV3XDZthsSEw3UNsqN1Iv5nACwHTBWe?=
 =?us-ascii?Q?oOJCkGVk/KH+d464V3vFSt7J97iI+6k3404V6GufvOs+nUKRgOYANibUOcRj?=
 =?us-ascii?Q?dUnKSIkNHBujzOhCjp74nkr9rmuYs8VFYG5kKyzUhCxliNvo55n7nhjfp8m5?=
 =?us-ascii?Q?Lv6r1W7eeE/bMDpeb8WSR/MOduR+I6wAdah/LnENqA7PPH7MyqvxsN505XyT?=
 =?us-ascii?Q?5pKkiMsEOdVS6qmIcBahe7rKjb+hSQKST5NfMFbbGYJE4BnD8szZRr4FvecG?=
 =?us-ascii?Q?zcxwX6/Yn+WEaU7YlawAiLNT3TOq1NYbh07PbnBM+Oqpe9wKA9zgE3nJB0iU?=
 =?us-ascii?Q?wU9GhBU+SliukxfhJzr03MajsnLF7W9kdUts+p9UJjAdIWEW5R3SRMk6Dry8?=
 =?us-ascii?Q?TwhXfLahaWJvSTXNtoG2qeKagMScpWHboLKrmMuHVz7nHmgifE/8T/iE56A8?=
 =?us-ascii?Q?YdLMYWdUMr9T1z9aUeMHSpasqsJwaTrEsvijiocuHDCteWMvHT/np18669u6?=
 =?us-ascii?Q?FWPVCKwnCykZDcssQXM8LgCknfntlbsItrnDj9fOtzttyEvEbcJPVFmHpLD9?=
 =?us-ascii?Q?x1bZqX/uKYg5UQwYa8QPH5n2xzdOMZneg7/f1hoaRpVAU6pU9XiBlEijETP6?=
 =?us-ascii?Q?trekyAHCDYTCEf7lAEagTyChuKZlaqKGeBNxK3807qywYYFiJgVqA+5bi0QF?=
 =?us-ascii?Q?XLT+ea7vO46KY7TKjzjcrR10VtQy5jit?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tt1hydCnq9tltNkuHMRKSWwYAPZwowvReuAvU/69tyW9aiP2cPM97mK6wMnw?=
 =?us-ascii?Q?MIZ4Ql/WkJVhQXODFhpt2dd8Y3hrStpHjMB9llEbjEJ69RHsO0rS7ZEznBAb?=
 =?us-ascii?Q?exm9W02ufK3Io8zl1tq2VtdHL27Z6iQN23GpLawpj83UBUJxml98OYus8zwT?=
 =?us-ascii?Q?hmZ8gpTfFF6WSuet5550Dq0bwuyTrjgrig2rHN4vidMKjjdUMNh8tLsQjmPM?=
 =?us-ascii?Q?HLiQcZfTI1IHuCTPWcJ5kGpLjtWdiEmmZqSKlc3sTCxcCtSyyQtGYeXbD8cF?=
 =?us-ascii?Q?QZNnyJSkG2+7ThFQ7crWrNQkTLMZX3e3a9ULKDThHHdEi1l7/f4Wu2paL3Aj?=
 =?us-ascii?Q?+TNnm4HTNYCD0pGWSrrRUgincI26xhvgeQTAzEZyRKvcBdqGCSdGiEQGCshh?=
 =?us-ascii?Q?yus06jQhh3Adci1Bzhac/CU2EqibzS9cWeKnwptdx0FRWX1Y7F23eJPiGsH8?=
 =?us-ascii?Q?l/YC/GI8qWJbPcsMBW20eBEeB4zKowudpDZXLeeuxvndD5pYBtJ2xlE8gIt7?=
 =?us-ascii?Q?EI7QKTeGYCSJ0LdH5PSZ2NWxuJq3nB7aJrE5yBIrhydF9b0Py+G25vdRiE3D?=
 =?us-ascii?Q?dvJeqsWyY4q1t9qaHEBdKuv7MAdiIxqROL+JWMrPk/1PtNSuM7VU3o4ck6hv?=
 =?us-ascii?Q?S+FpqdoCRn9r3Vy1ieOSDnyYmzdhYpNPgy59ENXxD4Q4uPLx9s+Yl6H+PlR7?=
 =?us-ascii?Q?9pe/3KVudOvblpgOEDfF0ZuObxt7nPdNbES5ky7hJ95AHLUoRvzNaIDyk+1F?=
 =?us-ascii?Q?GT0TxEyclyjc2x4tFjxc5Y760nDDDkHxq60HpqF86cGyTaSSBJMI3XLJMBQS?=
 =?us-ascii?Q?NoJjLifNnc2oV1HhVeWvlGfF2AupwrR6lg0BZGNiDVV/xrFCEuPhQtgk6tKm?=
 =?us-ascii?Q?6B9mSkcqqDWSHE//9+A+ijaU3L5eHJR1j0dWE9by95UxRYGiE1pRAX85iVi5?=
 =?us-ascii?Q?NUSObEfM0z3/t3tUtE4Sh4s8LLKlxo0kFI/TlC4cyxp9WVfJHgUS3QQ9rOac?=
 =?us-ascii?Q?xeXd2hN7UCJqBNS9xn7viWzVDWUvv2P0oyKe9u9+Gh9BSLxmWC09QwEgiUcq?=
 =?us-ascii?Q?hVboFuGm+CggRMQHvHrKqDojz0ZZuOCLNbejO4ulbRf+q2bTwsCeK3Mt2Pxh?=
 =?us-ascii?Q?hDARgQWuPkTZ4F3p8Yovj0dcIgPIOYXEukFVjyi21U7muW350mFBwP259nIj?=
 =?us-ascii?Q?ntfdg2BOTGepagOyzkoRfM7OaTMxhUMLeNiDnMBs/IFwcNfch+qjiCX39MZU?=
 =?us-ascii?Q?X2ZBkTPnDCrRkMM5DSrhvt5yokUHPNHfyFlNNbGvrLoC9AmifrJbwCyH5uIj?=
 =?us-ascii?Q?0TpZGw3uc035AQi5ESUmkrCsT60w4SY+RknM3OTg4E5dX5FyouyzZj0ejOVy?=
 =?us-ascii?Q?oAwaCtEKzVwVjC+f7jSRtwNU12utoFF/MpUWsWGpGw8gYvsAXkHPg49o/xDH?=
 =?us-ascii?Q?FQ5/5rE9RPYIDFpcr9e46I2PqnDrFo7hWOtfiOS4pTQZYwS51iOdmJaY6uKL?=
 =?us-ascii?Q?9jW/Ry9JYViZEFHvX54XAFo79Rnm6orSNbv1g+gsWaQdeHi5JC3H2wFuhy6r?=
 =?us-ascii?Q?jmTILJNNh2bPZKpS9Ymrg/QdxaHCh7vEZqB5WP2rDSDfqgwIDXQcYpqghzuD?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d02486-0fbd-43b2-b980-08dd6ab27d43
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 09:01:39.7633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8tv//hVLLQPbi6SBkoF/p/5NoJH9X6OflMU8gaimsvFram8E/gddht5YMQ3yyO4UaD48xyDWcl98sm8Une0Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4901
X-Proofpoint-ORIG-GUID: Q98rKHeBesDLVbTPxT9i1oHN-6xQGbuc
X-Authority-Analysis: v=2.4 cv=etjfzppX c=1 sm=1 tr=0 ts=67e11f75 cx=c_pps a=clyc6YhGvfCRRXf4btgSWw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=0TxMByYiQ_oXCgWiJkQA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Q98rKHeBesDLVbTPxT9i1oHN-6xQGbuc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503240065

On our Marvell OCTEON CN96XX board, we observed the following panic on
the latest kernel:
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
CPU: 22 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc6 #20
Hardware name: Marvell OcteonTX CN96XX board (DT)
pc : of_pci_add_properties+0x278/0x4c8
Call trace:
 of_pci_add_properties+0x278/0x4c8 (P)
 of_pci_make_dev_node+0xe0/0x158
 pci_bus_add_device+0x158/0x228
 pci_bus_add_devices+0x40/0x98
 pci_host_probe+0x94/0x118
 pci_host_common_probe+0x130/0x1b0
 platform_probe+0x70/0xf0

The dmesg logs indicated that the PCI bridge was scanning with an invalid bus range:
 pci-host-generic 878020000000.pci: PCI host bridge to bus 0002:00
 pci_bus 0002:00: root bus resource [bus 00-ff]
 pci 0002:00:00.0: scanning [bus f9-f9] behind bridge, pass 0
 pci 0002:00:01.0: scanning [bus fa-fa] behind bridge, pass 0
 pci 0002:00:02.0: scanning [bus fb-fb] behind bridge, pass 0
 pci 0002:00:03.0: scanning [bus fc-fc] behind bridge, pass 0
 pci 0002:00:04.0: scanning [bus fd-fd] behind bridge, pass 0
 pci 0002:00:05.0: scanning [bus fe-fe] behind bridge, pass 0
 pci 0002:00:06.0: scanning [bus ff-ff] behind bridge, pass 0
 pci 0002:00:07.0: scanning [bus 00-00] behind bridge, pass 0
 pci 0002:00:07.0: bridge configuration invalid ([bus 00-00]), reconfiguring
 pci 0002:00:08.0: scanning [bus 01-01] behind bridge, pass 0
 pci 0002:00:09.0: scanning [bus 02-02] behind bridge, pass 0
 pci 0002:00:0a.0: scanning [bus 03-03] behind bridge, pass 0
 pci 0002:00:0b.0: scanning [bus 04-04] behind bridge, pass 0
 pci 0002:00:0c.0: scanning [bus 05-05] behind bridge, pass 0
 pci 0002:00:0d.0: scanning [bus 06-06] behind bridge, pass 0
 pci 0002:00:0e.0: scanning [bus 07-07] behind bridge, pass 0
 pci 0002:00:0f.0: scanning [bus 08-08] behind bridge, pass 0

This regression was introduced by commit 7246a4520b4b ("PCI: Use
preserve_config in place of pci_flags"). On our board, the 0002:00:07.0
bridge is misconfigured by the bootloader. Both its secondary and
subordinate bus numbers are initialized to 0, while its fixed secondary
bus number is set to 8. However, bus number 8 is also assigned to another
bridge (0002:00:0f.0). Although this is a bootloader issue, before the
change in commit 7246a4520b4b, the PCI_REASSIGN_ALL_BUS flag was set
by default when PCI_PROBE_ONLY was not enabled, ensuing that all the
bus number for these bridges were reassigned, avoiding any conflicts.

After the change introduced in commit 7246a4520b4b, the bus numbers
the misconfigured 0002:00:07.0 bridge. The kernel attempt to reconfigure
0002:00:07.0 by reusing the fixed secondary bus number 8 assigned by
bootloader. However, since a pci_bus has already been allocated for
bus 8 due to the probe of 0002:00:0f.0, no new pci_bus allocated for
0002:00:07.0. This results in a pci bridge device without a pci_bus
attached (pdev->subordinate == NULL). Consequently, accessing
pdev->subordinate in of_pci_prop_bus_range() leads to a NULL pointer
dereference.

To summarize, we need to set the PCI_REASSIGN_ALL_BUS flag when
PCI_PROBE_ONLY is not enabled in order to work around issue like the
one described above.

Cc: stable@vger.kernel.org
Fixes: 7246a4520b4b ("PCI: Use preserve_config in place of pci_flags")
Signed-off-by: Bo Sun <Bo.Sun.CN@windriver.com>
---
Changes in v3:
 - Make 'PCI_REASSIGN_ALL_BUS' unconditional, as suggested by Mani.
 - Update comment as requested by Mani.

 drivers/pci/quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 82b21e34c545..787a5e75cd80 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6181,6 +6181,19 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
 
+/*
+ * Quirk for Marvell CN96XX/CN10XXX boards:
+ *
+ * Adds PCI_REASSIGN_ALL_BUS to force bus number reassignment to
+ * avoid conflicts caused by bootloader misconfigured PCI bridges.
+ */
+static void quirk_marvell_cn96xx_cn10xxx_reassign_all_busnr(struct pci_dev *dev)
+{
+	pci_add_flags(PCI_REASSIGN_ALL_BUS);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_CAVIUM, 0xa002,
+			 quirk_marvell_cn96xx_cn10xxx_reassign_all_busnr);
+
 #ifdef CONFIG_PCIEASPM
 /*
  * Several Intel DG2 graphics devices advertise that they can only tolerate
-- 
2.49.0



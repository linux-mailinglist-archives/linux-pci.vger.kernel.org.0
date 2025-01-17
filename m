Return-Path: <linux-pci+bounces-20032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C393A14B16
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 09:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3613188B864
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 08:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A181F869C;
	Fri, 17 Jan 2025 08:26:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC61F869B;
	Fri, 17 Jan 2025 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737102389; cv=fail; b=cG0H+lJI7LkMhiFvzoU+hgYPCc1UG1sn/dJ3pLIv6aJJjjERSSPlLUA+/T9Xe1AG3AS+kVpmJyLHgyv89MjWjT/2dtBFKpDDjgr+0Mq+LpydsGnXXOOBQZyFdsMuG0vnSRis/3Jj76XnFbc8M9GiqlghGFzrXXG+Gfz0/rYg/jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737102389; c=relaxed/simple;
	bh=ayd+JBbvot0OXs4NxQtanOey8jyw0YpOPbcno6Jtm7g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ifr4g3BHrnvqZqXcaahPgqHLfT4Uj8vRmFSUCaXl+7rnRoQn67g/cMFEfmv5ISrU/w5kMvI7CEY122f0pX2z/bq/7Qf4FJuMBlR+T/aJAMZd9xWlaswEiEUbuMFXFbjJYx8amgNyftMLYfYhJ5zdRTlpc7ju53BaPpfcHDHQtAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H7nrF5011256;
	Fri, 17 Jan 2025 08:26:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 446wf7ha7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 08:26:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzpcz4O9r5rAGRa3DMtvPuJzFLj1XEqzGsXRK2jY+xAf+wRYIB4J99+262wZ/6P55QDBqGSPHqZnxSPOXmW2seZzFAD3nRuMqIZx+CThbla4mp7+ikOP9HHENUOV0C3o5yxCWx5tBk6SU7wOTGfqNV1pYndTzM8M+HTtMqJdtaUMJei4G+/FrQdBwDrEdPYtZJZmjWuxl09WRD9RTwMmggpqsdo0vtVqKFqL6PoA0t5LuPz/LftMjeqKOy+Y2leYloWhInDnqpn102Cl3+YwYVqj92C682kW49JGgYJh40Qr8TFM3AkwPOgoGy3yjXemmjor6+Cd7+8p1GmZrRFKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCDbXpqYM8nhmhb87vm0V5SADenvt0EOWS1eWZ/zgx4=;
 b=EnjY9htA5XK4Xf3U/oCKSVLPEAgXn/d9EqI1AP1q63EnWgeD69oTOQi7BmmAHlENCk7EKyUdYc8wxOFfBZvdOLDpm94E82Xx6paxRbIBflgub2myGoFGhmltwt0NEYUnvuw4i/7c02xDJUEb+UlMThpw5UzKsbCOzqaqhGktUsuKqAaYE0Ck+30/C95jChT2Fj8Y7J8BVly2dUASIlayql0IlCzns8fGKsLqktNeloYg+xTq/6uP1dOelUZHdiHgTD5cMracJs0Xa85rMIHdLvB0hgEavbip3z/bGHUb/PGX2FgkomsOj7XN5D6F5Qm7SQOoCUSgUeJaCf5Yo3j3dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by SN7PR11MB7707.namprd11.prod.outlook.com (2603:10b6:806:322::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Fri, 17 Jan
 2025 08:26:06 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%7]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 08:26:05 +0000
From: Bo Sun <Bo.Sun.CN@windriver.com>
To: Kexin.Hao@windriver.com
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>, Bo Sun <bo.sun.cn@windriver.com>
Subject: [PATCH] PCI: controller: Restore PCI_REASSIGN_ALL_BUS when PCI_PROBE_ONLY is enabled
Date: Fri, 17 Jan 2025 16:24:14 +0800
Message-ID: <20250117082428.129353-1-Bo.Sun.CN@windriver.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To SJ0PR11MB5866.namprd11.prod.outlook.com
 (2603:10b6:a03:429::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5866:EE_|SN7PR11MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9ed0b1-1b3a-4f36-1dbe-08dd36d06446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KI2S12yS+LqHceY7PhldDtWXz9R/ReAYmh+OI38s03tMRTEtpydoRelGz8/u?=
 =?us-ascii?Q?hxCUGnUfnaSFTaX0K37rBgRAUzoFSlKZbK7Ru2Xs+3ZMiU7MzMNf+M2YxfPt?=
 =?us-ascii?Q?IaZu8Q9QjR0fbWXOs56Vjj1THa9F0DUOVFHbBjzAevVUVwWFf0dZD1AHsKz+?=
 =?us-ascii?Q?oLn8duEC3wOuKe6oFch6amXfRXFPLdQvJVg5fDGHOZEMcwZdBazHK8l5B4j/?=
 =?us-ascii?Q?cEFBD7VAE/9VE+CPwXizceDvqScRZ944QuljFqPIG0Lu1BQhexVuXHkgsAkj?=
 =?us-ascii?Q?P91yM21+rur6WlF0OW3Kbn35tvoIFNK2WnkHJIUQTsS7vQ7zGAwzV6sWjQtm?=
 =?us-ascii?Q?aocKxk4lprQCj/iTKP7nxz+/RgaBRo8Ppp0T9ArZ/5tjv84/o8jAQCwQbYlN?=
 =?us-ascii?Q?l6hCBacnvlW94zn6iiZP+zQVkh5cILVbK0LGT1RrTEgLQS18wj/Qo24iKcar?=
 =?us-ascii?Q?H/F9C/Us0K2s/tv+UIR6mkD/CEpPVPR7LYRbETrRkCXxFV6TXxsazgLwCTX7?=
 =?us-ascii?Q?2c3At63Vpka+kQRL+nYmp0DPziJNjyrN0UZw6QuFhaUBAb1nQQXORloIACqG?=
 =?us-ascii?Q?Es51w2AzvcjCLNFI/14TQqBgOJlwf2VhWoSzGX2j8ndo9C3M04fo10Rol3hU?=
 =?us-ascii?Q?yQGYWHvvnCgC3oox9HBdsa5/nEySK0fFy4AugEsAArJj+p1gMcdq2iaSkWpP?=
 =?us-ascii?Q?nC90cf8ZQAehAHqdjl0yqbwJHSRy5Pjq4VBcyn30gHNhnFNEYKg32OTx2XWE?=
 =?us-ascii?Q?PuQ7jczqeLRS47S9NAO3VTvhO5sGZzrpPgSCiGyI2Cf6+1FA3VgMwTagxOzp?=
 =?us-ascii?Q?+y+fEKzdloriaTQEKY6dV7oaLMGQrjQhjIXqPq8QCRQHcuNFAE1IjTaknw9D?=
 =?us-ascii?Q?dRW+n3l0lslQ0tW6hsQQeaIemb7mdqGsPHd7rbiBgY5Rf43WNEBcwn+GBIn0?=
 =?us-ascii?Q?e/tWZOkje57zgamKclRRRe+XIIGaiwgdwLbj6dK704IL0Diad9X9YpclE/7V?=
 =?us-ascii?Q?3FvY89fs3o8+0inwSD/XjoazHAbXDXpSwB14fWSLi8Q7Oc3l9dfIEj28VFwC?=
 =?us-ascii?Q?TOYQCPq9bL+8U7HumWYLQVcPUHFed7cLcMwbTrv7spV83klFRLZV3TAhcv+G?=
 =?us-ascii?Q?rhPcEBGGMg3KeowvsEcqQW62xb/c9w9mRnUvWaIHdVvM7fzZ3BT3jn/P5Uq4?=
 =?us-ascii?Q?lqHhYfRORW7TXG87yKwWZ40bdKfMVX2QoMG5r0w5aBgwsf0DUIbc8tvxfc2I?=
 =?us-ascii?Q?nh/bi8Sj0eARlTiRgnolkiwKtyXDMkElnwT1PoDOGVSVWbVBv9THLptR6cR9?=
 =?us-ascii?Q?471jJKNRZ1uSNjGLmLN836xfMAl3gn1UJl2TgnOLj3CF+sQXHlGodmVPQL/O?=
 =?us-ascii?Q?1QsibE7Z9t6z97xFAs0Q08eqjMTVHYItbDb6r/UZKUJXQ/6Bbz6bzhqukRi8?=
 =?us-ascii?Q?oQBh3I1ezz1WO3FXLyjL1XfxOnXfI6Gi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ci8hxaAl1RsgTapEEu0eAz4huqFocNwn6wLZChsfAKvLTu5Sije4pQXmXwsb?=
 =?us-ascii?Q?gNGhGqGVR8JMVEBS6ysE++WUr1PqEWYIOkIyHRSw7yRFRDXzn4/ffaX8sMch?=
 =?us-ascii?Q?vWEwmUNBqsOWVRP5cp5VeRVvPqNIKsWTDI4aX2HvDyFy6iOJv15eZrUiziU4?=
 =?us-ascii?Q?SmE/UrCFgG0ou3Gb5G3Gpxc9AVr3toqIXaMrLLrTTUSN1flLMKwl9PPvihEd?=
 =?us-ascii?Q?E5bH5TP0cuvaptEvfI/pRvdwwgsnKDUhllzXIAL65pTaPt9AIPynyOYhDLMZ?=
 =?us-ascii?Q?iKYOH678SRZENi5VIHVZB3Lfq/7/yKKEtX0KFaAb4UiESAwF1N7JZqi3YRQt?=
 =?us-ascii?Q?+MKwpGx87bRKwAISJbrtGHkpl8xFwkw8jtSZbZ7ahwV6IBBEYYLpVTRb7ZPu?=
 =?us-ascii?Q?fVSdXhDpUuvXxyPCmGQq4hsAk1IBT0sWZfOz9x9EIPlFpLCa6quXP0qFmJhA?=
 =?us-ascii?Q?yF9MZg04QfQmny/h3BDR6gBdW7WjECVwAAa4PQIXgCiXJWQ8F+qwQPS7pkJK?=
 =?us-ascii?Q?wH9zpPY0v91X+RxA2h2rx85RCY7YquLOqULg6lpHAXEC8lxsc/WXftaY0MeW?=
 =?us-ascii?Q?VEWiG1hi7kj7UznXolQIdtFMk5XGX9Rb5N+tIsB/yInegrG4jnCkmozCJ5NJ?=
 =?us-ascii?Q?miDjmNSHhRdFVCpqQVYiMxyjbTi+oqHtqmIxcRTkA2INPY/JvEVTPFqredBO?=
 =?us-ascii?Q?vW3dq2RcDKn7PInXCLvo4xitwOEewvGqEo1UBX/pfa4Q7yg6TLNzi4Sb1raP?=
 =?us-ascii?Q?5wW9Uf4ugTwQdk8qR8UjASHEQwHquq0r8p8obMtuAvH4VS/wEkpuq4CmXzL3?=
 =?us-ascii?Q?R7Lqz69mwcnQYHbgW3Xs0U2m/9pf3nyFtS//Kb4tFTzEU3GtMZ8LGj9JVQ+8?=
 =?us-ascii?Q?+QGryH+ZRq0cT755qb0Ua5rhlcUlTu8Petp648kEDMusq89GYSFPnabfOgu/?=
 =?us-ascii?Q?cnLGl06ngYGeXHh2pq3IQ3ltxDYtNjYhAAiUH5fkHjCSDz7v1luINB43yhap?=
 =?us-ascii?Q?psPQ//qaq/ynU+GrBX8uzjHHUByVBzuK6UTFwKkEhVzNlp8Myr7EUg5BbiZF?=
 =?us-ascii?Q?ICgDC3GCb2+WVAUlxLyXmHlF224vqSx4JsUCBT1dSbRD56K1OPSWu/Bd3V3a?=
 =?us-ascii?Q?RzflYVVOY60gLrU5LNwZCpLaczi2ET4VztjtShzS9uY+1BNrtSXW4urFhQJs?=
 =?us-ascii?Q?2+gkb4FAD0ZUqnmWoBzvXSV8UWeW9n76DDmpLcnP01M4IbtWblRdDRk2Uo3P?=
 =?us-ascii?Q?/MTnx8wwLUUzGDEv+Fjn8Th32ngrZBZBXRO/b8gokiSqFVYeHbcHWH26pX8W?=
 =?us-ascii?Q?4GpEFKhwnin2C8FsvP/8BajlnoqUeQ/ticQNk8vl2oNy+JyOEB8IOCGuJMLn?=
 =?us-ascii?Q?oFs/jAER/gDVpwWLtwts/eAww1lOkvE4r2pPfXM44EsN9iX4TuS4l0FyHxTY?=
 =?us-ascii?Q?AuDBTaWeYKZvuzvrEgbqsMOWAvMOLB7SofrrUlbqX+KdRktrF0D7y9vM1znL?=
 =?us-ascii?Q?aUEIIAopOKzx2iUD63U/qpyUJF3ZMY+iYevQFIexntgfCsOKQwcYqdHX4gSV?=
 =?us-ascii?Q?DclBqp/9cFLOjkOwOuBceZKF18oUF4nlv/fc1oqfPobn8Tleq3Sn6fqUgdqk?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9ed0b1-1b3a-4f36-1dbe-08dd36d06446
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 08:26:05.7914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZWsLnlx89suzhkM5m5p+Uo1GlQGXsSnGdU/Ee0YR9FnW3jSaYkvCzkdtWevBl89HQyVngaOXz+4RzqV9ZWOBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7707
X-Proofpoint-ORIG-GUID: GsYV8nRlNHnYQkhirI9Cy64LFEHqaMWN
X-Authority-Analysis: v=2.4 cv=X8moKHTe c=1 sm=1 tr=0 ts=678a1420 cx=c_pps a=+hq7TYb7Jqj0EztKBnUMzg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=OQzckKujYBuisFixx9sA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: GsYV8nRlNHnYQkhirI9Cy64LFEHqaMWN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_03,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2501170066

On our Marvell OCTEON CN96XX board, we observed the following panic on
the latest kernel:
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[0000000000000080] user address but active_mm is swapper
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 9 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc7-00149-g9bffa1ad25b8 #1
Hardware name: Marvell OcteonTX CN96XX board (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : of_pci_add_properties+0x278/0x4c8
lr : of_pci_add_properties+0x258/0x4c8
sp : ffff8000822ef9b0
x29: ffff8000822ef9b0 x28: ffff000106dd8000 x27: ffff800081bc3b30
x26: ffff800081540118 x25: ffff8000813d2be0 x24: 0000000000000000
x23: ffff00010528a800 x22: ffff000107c50000 x21: ffff0001039c2630
x20: ffff0001039c2630 x19: 0000000000000000 x18: ffffffffffffffff
x17: 00000000a49c1b85 x16: 0000000084c07b58 x15: ffff000103a10f98
x14: ffffffffffffffff x13: ffff000103a10f96 x12: 0000000000000003
x11: 0101010101010101 x10: 000000000000002c x9 : ffff800080ca7acc
x8 : ffff0001038fd900 x7 : 0000000000000000 x6 : 0000000000696370
x5 : 0000000000000000 x4 : 0000000000000002 x3 : ffff8000822efa40
x2 : ffff800081341000 x1 : ffff000107c50000 x0 : 0000000000000000
Call trace:
 of_pci_add_properties+0x278/0x4c8 (P)
 of_pci_make_dev_node+0xe0/0x158
 pci_bus_add_device+0x158/0x210
 pci_bus_add_devices+0x40/0x98
 pci_host_probe+0x94/0x118
 pci_host_common_probe+0x120/0x1a0
 platform_probe+0x70/0xf0
 really_probe+0xb4/0x2a8
 __driver_probe_device+0x80/0x140
 driver_probe_device+0x48/0x170
 __driver_attach+0x9c/0x1b0
 bus_for_each_dev+0x7c/0xe8
 driver_attach+0x2c/0x40
 bus_add_driver+0xec/0x218
 driver_register+0x68/0x138
 __platform_driver_register+0x2c/0x40
 gen_pci_driver_init+0x24/0x38
 do_one_initcall+0x4c/0x278
 kernel_init_freeable+0x1f4/0x3d0
 kernel_init+0x28/0x1f0
 ret_from_fork+0x10/0x20
Code: aa1603e1 f0005522 d2800044 91000042 (f94040a0)

This regression was introduced by commit 7246a4520b4b ("PCI: Use
preserve_config in place of pci_flags"). On our board, the 002:00:07.0
bridge is misconfigured by the bootloader. Both its secondary and
subordinate bus numbers are initialized to 0, while its fixed secondary
bus number is set to 8. However, bus number 8 is also assigned to another
bridge (0002:00:0f.0). Although this is a bootloader issue, before the
change in commit 7246a4520b4b, the PCI_REASSIGN_ALL_BUS flag was
set by default when PCI_PROBE_ONLY was enabled, ensuing that all the
bus number for these bridges were reassigned, avoiding any conflicts.

After the change introduced in commit 7246a4520b4b, the bus numbers
assigned by the bootloader are reused by all other bridges, except
the misconfigured 002:00:07.0 bridge. The kernel attempt to reconfigure
002:00:07.0 by reusing the fixed secondary bus number 8 assigned by
bootloader. However, since a pci_bus has already been allocated for
bus 8 due to the probe of 0002:00:0f.0, no new pci_bus allocated for
002:00:07.0. This results in a pci bridge device without a pci_bus
attached (pdev->subordinate == NULL). Consequently, accessing
pdev->subordinate in of_pci_prop_bus_range() leads to a NULL pointer
dereference.

To summarize, we need to restore the PCI_REASSIGN_ALL_BUS flag when
PCI_PROBE_ONLY is enabled in order to work around issue like the one
described above.

Cc: stable@vger.kernel.org
Fixes: 7246a4520b4b ("PCI: Use preserve_config in place of pci_flags")
Signed-off-by: Bo Sun <Bo.Sun.CN@windriver.com>
---
 drivers/pci/controller/pci-host-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index cf5f59a745b3..615923acbc3e 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -73,6 +73,10 @@ int pci_host_common_probe(struct platform_device *pdev)
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
+	/* Do not reassign resources if probe only */
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_add_flags(PCI_REASSIGN_ALL_BUS);
+
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 	bridge->msi_domain = true;
-- 
2.48.1



Return-Path: <linux-pci+bounces-23427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2976BA5C30C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 14:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDC6188046A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 13:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE11F1D5165;
	Tue, 11 Mar 2025 13:53:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27851C5F1E;
	Tue, 11 Mar 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701237; cv=fail; b=eVb6fSa4PWmPT2r7uUx2JgvOOBMWYltU6xCghroNtw9NoA8BErKIJ1ZlT248x4ARmkIp3hrNeoL7nelbRMZeYiDh7BE5fUiwy/8olOPCbVldwEE5d2jK3+TMic4141HdiSvDkYHkG2lVo2F9Sr6p90HrVd1aGR2ZdalVsrV9pHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701237; c=relaxed/simple;
	bh=Xn0AL7F+ripJ/IDZyUuNpjBPHOE0G1RMbQWHX6TLTKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MoDj8WNlS3UNZCTceaXKqfddTIMtWVUXc+bbVKBPtlmJhzuoaqIzsjhS5SDhXG22wYhbpRBYQND7Q0wAK16lNkDac+GPNjE7+ue6ife14FuZFtvcm0Ww7lpefwqbsx1WSoU0Pj3AOrLphw5IraRQNTqWb8hzbLanChanyyIRrac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B8fYLZ027970;
	Tue, 11 Mar 2025 06:53:50 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 458j27b8mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 06:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOdy7t2K9zZJI6gmDX0FfxJPhNbdSCv7A3XDWuHRxPE12bz7DMgNlvGCqsoRsZt2lYBo8NkMPEpTKDScp9r3JYdg052xz41pmd8PJM4CeNQnW+L/2tQ8amkaSkQF0QsDkqrTXvwfEURyhq6k1GF369f1jvCzeacz27osnvWNVa3Io7IiWr77/hsbLc9osdl/RCnWDogOi5jVWZN5aLst2DDDxwFD12i14vpJ8+7L1V7KM0WiLLvHNG5Pe1jXLBJ5pD0s8Slt3430fJbjD4JY4a1Uzipo9pZZ67PwRC9mcGNSKgneA72qdL45rpcOy6StdsohphMbKT/jFYkX1ubvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ut37gaPhimBBslwQEq5xdZKhJCOW0Jf9hs57tgZs6I=;
 b=u3CEEd9fMwBJdKz/Dld7hIjLs/9jed+wE0qTwAEaPmAXCUA6KAvbm2sjT56Cqyz8NzhOofo63n8DZ37cmaBEtN+buoA+UfCNnS+OeGuh8gXZ1PZs0s6ZJ0plJgPhVOEYGqVIyv0loadk9OpHIDO3w6HAeemmjxeF6lAkXHN5ayYSfokaXk7iuwnxTOOsOi6ODIinvzNZ0Hg8Jdjjv0TJ2D/NghMOsxaH52SSjJrnkqhTHeHNe5TT4kwBiZkid4NA1roXw9avIZVvZBlO+1SDfbI2UPA9RSt2GlyF4yeg8rvbwYGPikIPKmSGBFv7pGtag66v+uM4kmVDgVMqU1/GJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by DM4PR11MB6454.namprd11.prod.outlook.com (2603:10b6:8:b8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Tue, 11 Mar 2025 13:53:46 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%4]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 13:53:46 +0000
From: Bo Sun <Bo.Sun.CN@windriver.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hao <kexin.hao@windriver.com>,
        Bo Sun <Bo.Sun.CN@windriver.com>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] PCI: Forcefully set the PCI_REASSIGN_ALL_BUS flag for Marvell CN96XX/CN10XXX boards
Date: Tue, 11 Mar 2025 21:52:28 +0800
Message-ID: <20250311135229.3329381-2-Bo.Sun.CN@windriver.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311135229.3329381-1-Bo.Sun.CN@windriver.com>
References: <20250311135229.3329381-1-Bo.Sun.CN@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0140.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::32) To SJ0PR11MB5866.namprd11.prod.outlook.com
 (2603:10b6:a03:429::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5866:EE_|DM4PR11MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 5326a812-8d5a-4935-7cbd-08dd60a424d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CksSrSG2CjJrBU9HHGdAJEQ1iKJ6hIhZsI4IP3LUgUCdj+ep33I2SH/QSheB?=
 =?us-ascii?Q?P0BAZRx7Rf04QwpafrbRQ5vTvgqGWK5wdQMR1zOEhY2PJPmranAqfkr3ozlz?=
 =?us-ascii?Q?ov2ybHehvg0CdrZPNvBvTdr9sKGgJLPD3PM8At6Ha81aRg+jJMsRHN0EknKA?=
 =?us-ascii?Q?6n03ljjaZ2oE3UUiBLJzxdRM4SUmCzD3TNYnBU+66zS9+n/sE6TqaSX/wRIQ?=
 =?us-ascii?Q?UeCwuTxvBNHK+6KcsigsbgHdANREXKorQRjE0K8JkGDN/eI/r1AJnIxcZEdm?=
 =?us-ascii?Q?KZzKCHsyQFhBUTx8JRrgrWKqaAF0uAlVm8X2NBxfjuZH0UWzc5swg8oECxEX?=
 =?us-ascii?Q?NO/sSpyXqUAKiZ3LjHQ9VtPwQa+2XORJBZLByTN4DKEoIiqLzfV/ryRh1LSz?=
 =?us-ascii?Q?Kwyg2SjF419hWGxqueKw1LLUqJDmU7BtgDCbiRidYdcKNo+oepwDG4hgdohO?=
 =?us-ascii?Q?RRKkFSabfvuuwmIo8rBfcASHF05v+p1j+JZ4enr7x00SXDqiBzgK9SMos6Uy?=
 =?us-ascii?Q?hHnBRHvWg59OH/SgtSWMiNmCuQ8VmrK7pwV8SUGWijJEPoopedD/WRZnfJN5?=
 =?us-ascii?Q?3BR7bNOX+ZHwLtCnUu1cpyy5Yxq2mLpT1+7e4H7HUXfN12VOzuZJ06RIAHFP?=
 =?us-ascii?Q?UiKRJM7i26G8gtv+RqBDf51mw5sSdgsTZqba6HCgZeqB8uXBY0Ic/Of/Wr0i?=
 =?us-ascii?Q?ChUqvns5mRHLrQuOMEEG8ahuGCSCYiD/8I9gdBvzuQ1kiYUQzdnncAj42RB0?=
 =?us-ascii?Q?COP4RGqPmwucREuzrXz0GBT7qplYG2g9QeX0eB2iuYbim2r8Z9lPj890HCEj?=
 =?us-ascii?Q?NckrVJ8whAlYrEYwFW5na1Zvzcqnfap07SR5HmGGKQmba6248fjjmosPev1r?=
 =?us-ascii?Q?oR5kbBCNya/iNZj0Ml6KyYfkZRiH14uqY0Kb/t+C7oZ/w3tlO2BYTxwCwCwc?=
 =?us-ascii?Q?dbr4s1DkgDuuEf3DUzBvEFejSAdmTnUiZaNvuvRiDtJ92ouPAgBJgFeWnEAC?=
 =?us-ascii?Q?yjvQJ0w+PI0OwSN0INEexsqIyahnR/nn5fIw5g/CUA72vyhlBwbIvZevycG6?=
 =?us-ascii?Q?fKO2O8qVXfzIJkNoO1GfedbYGhOuEhOOjoUk7onDHUjh7DFfhRsxeOrjlLg0?=
 =?us-ascii?Q?8rS3yl82LLJbJolKjZb+XbT8nh0Rr5RxMGl4V6/MSB1xozMR7+3cPwkFWYsl?=
 =?us-ascii?Q?x3zomRzp+r7WmGUwrYHHv6sNSbx/Wb6Me6BOkxI5FZ/LVhk9D6PROBrqYyXB?=
 =?us-ascii?Q?wa3RsVYr+tQFGKQNYFSxPwqBypLgCLnzAr8mr3cwL94ZrNlh8s5e4omzECBo?=
 =?us-ascii?Q?TvnTsc1FwAy86DpggMGrZrbv1yH+X46rZ8a07dHbv1hoTfcY7WaPyLTr9Hgq?=
 =?us-ascii?Q?RBSw0HaCv5l5dpHOkuODOMOo35m69LQ/9kb2XwnYCDuBPvktDxUWgR7qaCZC?=
 =?us-ascii?Q?B/ki3XnIWrZ95ndH2qnWtHjo1SVZY81r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m/2DS3ZlI+5vPyIbyHIv3hOCuBcABdJY59vKEzC+7ThprPx2P0pKC+qbrMv5?=
 =?us-ascii?Q?RF71IGc04ZWcK+qv5JicWbluZg+DJ6GaUmXeI/fmaiRCLw7eza7oWdKvIbgk?=
 =?us-ascii?Q?dQmihJLM2Lrjq4crN9L/at11LF8WvMCP4RCmREx/Xz3w/LS6BA0md/aNJK0V?=
 =?us-ascii?Q?zqisByZMoQ3+n32CGwkqJe5G0Rq4Bf1S4ZeSVVgTi8V4htczHtDwlijF5fXw?=
 =?us-ascii?Q?RP3lGrGm94oE4BbF2QgI2+b3sCsyRR5NIOUzpAO1Hu9F6y9KAZAeiZ0ja+Vw?=
 =?us-ascii?Q?d0CODpXf3KRQQbHQbRAsR4Ie712E7eSfyfzUcaIsWNZIePqNOS1RjlWqb6a4?=
 =?us-ascii?Q?HDMLieJmcjMHIpQhp2599vu/CZselV782AI5Rf4mTQAWfN0TSq2P3/uIBsFL?=
 =?us-ascii?Q?o3R+acXtdqq+NQmIS7tD77yyK6rDWPLcPFFkhkHL23c5SfCOdJRVuwsfZWk2?=
 =?us-ascii?Q?O+TeuDA/c7PUGwDWiIwqa7vGhqeFN8J7DsEu3Gd/YKJ6e5wVKZQ6+eh7AjQc?=
 =?us-ascii?Q?lyFYYW/E62r+zLdsNgRiJD04qatEI5Um4eATLVZVpFUvv3JE6Eo1F8D8kY9Y?=
 =?us-ascii?Q?B3rQDqHXJ9/5CDFh+XA/nSSnzNm6GnsXIwevQWDXnZgCcuRyznfArXMP1vAK?=
 =?us-ascii?Q?dCzqmkrAeZczAsyNYzZPEpq9WUXMeazYR/8HnI3oJt8p4SWmeyhAF0VNfoJs?=
 =?us-ascii?Q?jtX+hLjWmhW4dUjA4K8Uq9hoV24At8rZKFmeRCzp7H0jWrKRfa7IXbAFBeAd?=
 =?us-ascii?Q?iR8pSSS2kcyPI2AeWcsO6frGo4mqNnTzaxbH448u16RS4zrHuCER+1K+txnk?=
 =?us-ascii?Q?FEPzwxoNf58GimgbMRCJZrI64m4Qup8vuOZ90n+aUySY/ZZDCFPEG1alqxL6?=
 =?us-ascii?Q?7z9K75iye4Yt2/jOXcBUElxw1mqGRfxZteMF3se2Mmg8LVM53ysd0Wi/UErB?=
 =?us-ascii?Q?tNNjIoQvbKu5IJxkA1PU5bkuRMNspGtBbUvye+VnnVWyh99xNg3UpRvmGPud?=
 =?us-ascii?Q?iN0SwZc1h5Vn5C+UhwsK076FE/hE3emw4gJA2mHvV4n3cBvpCQY6QVl91ZOZ?=
 =?us-ascii?Q?mPUwurOuZyfh7fexazKZ8esoQUsyfjWNb9rsQT+wjMoFiAkdx8FLkufhMsVb?=
 =?us-ascii?Q?2Aodr4FPSA9jMdZrBjuayspSsCU3H+BvVZMA/bQU9Yb6F51YWrcOEEQfGEtQ?=
 =?us-ascii?Q?d3uKdfAqssyKIgompKcPH+EySV+m4xCX3QElex1ltP1r+FAbIk4QkLQ4HWOY?=
 =?us-ascii?Q?Q8LU1sQqiMbrLIFP9J9WzScu1o5ywU5e12g2axjql/AyAow9a5WMlA/qyR21?=
 =?us-ascii?Q?C99j0O3BjyX3f9MP4SLleLIyo3EXTbQ8n999doWqsufywNW2OqTjIh9SGF6e?=
 =?us-ascii?Q?rdyi3KqbqPLxJx7/kCL5c37jNvBe4e6zyhj01+SL4v28Mre4OaMK84OAgU1y?=
 =?us-ascii?Q?W9i4vIYqq1QfQLs2KsN34IxbBkf7+y595jdd/puayHLrL85BwJU+rpibYoGC?=
 =?us-ascii?Q?XmOb/V1PHeC28nD1MZXqXPnjQvSMt+yEfjleJyke1QfDGJGtk9jn7sg9+WFC?=
 =?us-ascii?Q?cUGiOJ01uBRLVyxbQZuJ5swqTfve+O6ZzB104Qeyc8NgySGwLgjq3gvLzA27?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5326a812-8d5a-4935-7cbd-08dd60a424d0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 13:53:46.7222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1ANTqBoK+Sf1y1B9B5CBC2uSPE4mDvNxrAMCNuTm6R2H0ug1y0ApT7N6B2h4bVUci20ZQQj3LVSwf+W2LltHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6454
X-Proofpoint-ORIG-GUID: w6gOm9KBmF6LVGw4C5eZhf_a6rgRxdo8
X-Authority-Analysis: v=2.4 cv=WNuFXmsR c=1 sm=1 tr=0 ts=67d0406e cx=c_pps a=GoGv2RwMe+/7w9MjyR+VRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=d4GDFFIL-j1JmWKAxmIA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: w6gOm9KBmF6LVGw4C5eZhf_a6rgRxdo8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2502100000 definitions=main-2503110088

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
assigned by the bootloader are reused by all other bridges, except
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
Changes in v2:
 - Added explicit comment about the quirk, as requested by Mani.
 - Made commit message more clear, as requested by Bjorn.

 drivers/pci/quirks.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 82b21e34c545..cec58c7479e1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6181,6 +6181,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
 
+/*
+ * Quirk for Marvell CN96XX/CN10XXX boards:
+ *
+ * Adds PCI_REASSIGN_ALL_BUS unless PCI_PROBE_ONLY is set, forcing bus number
+ * reassignment to avoid conflicts caused by bootloader misconfigured PCI bridges.
+ *
+ * This resolves a regression introduced by commit 7246a4520b4b ("PCI: Use
+ * preserve_config in place of pci_flags"), which removed this behavior.
+ */
+static void quirk_marvell_cn96xx_cn10xxx_reassign_all_busnr(struct pci_dev *dev)
+{
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_add_flags(PCI_REASSIGN_ALL_BUS);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_CAVIUM, 0xa002,
+			 quirk_marvell_cn96xx_cn10xxx_reassign_all_busnr);
+
 #ifdef CONFIG_PCIEASPM
 /*
  * Several Intel DG2 graphics devices advertise that they can only tolerate
-- 
2.48.1



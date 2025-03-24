Return-Path: <linux-pci+bounces-24502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322EAA6D6D8
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 10:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B2D16A982
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 09:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7A925D91D;
	Mon, 24 Mar 2025 09:01:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45425D54D;
	Mon, 24 Mar 2025 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806910; cv=fail; b=SR+vuqhDV9F2sK9AuWhpDk0qtygk00V7pmHaunHV25bKrKJAg3YqHsejizGYjvfLMW7Jf7Cnpw4S/eo8I14/BNu0m6BlNimxBD5qky4bgbLi0Ht8duLbZJMOBG5Rrp+JBqaVeN8Iq55bkwnsYEDlyuZF6PslqccCm5zUTUVAG6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806910; c=relaxed/simple;
	bh=IZNTYTolslKjobQO9xER/RrHVYxmkomFqu2XNJhhq8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MaC39Y8zJpwy+oia7qzuYvA8L6lEH0XjEy/qAzdNw3w52m6jCcvoCsFTljO0R/QZLC7K8ejV1eITePVPX3ImClZgEXgit3URSHSJ5yR42NX9e1afUfdnckFu/OEkEaHYtASgsVAWydJuaHyi2fnZcSuAGJESj89hEa+2gWf6im0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O5dDDn012498;
	Mon, 24 Mar 2025 02:01:44 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hvqk9j4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 02:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLeWSugo0e/sbuZGLmUJ+h9GlNLKdi1RD51E1JkURNmY8veicDVuVWyBPiCvVfzufE/42PbBllCrNQd1uzTg8Ql4YND+ZrfHuPHtjMGxGwWPczs/reNTw/ysBZILssQ637WF1Q9BxDK8+3NA7jgGIBa5w9TL+lEpJ9nWySAuRN9hIbwQvu0ahsTYqgIBqD/UhiRK53Vu3vzm3HcMJMBLfghpgBr+WiYGj6NdWj9PM7kuahd8B68lGlC4xioWD9OYt1O0bUf3mBckaC2bTkNIT1BEKkfuXje2HKSGIgnYgcPqCkpGwCCeEJkOuFRUSHdwmdRrigQF6k9BryALpfqVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUTD/gAL//c4CLCOpXwg7lyl3ChL9ebT+NAChU63Oh0=;
 b=Vczc1gGjqryjx/qYLBUj+oCmlC+xfiWTEPAwrjKINKWhFxq6YX/KSk3fh/vuXweenpVMGKS/mPfE8fX0AU/dcfYPdSp8vzvUehMCyWOlLofvgTzfohyjvZI9j34ULP+k4WdOQ9o1wh0TT9vMgywoWB+KH7MrqF3lbia65vysl1P+/XDu3CsGPFMXIMAqDPW4br3KjMdlqza5X1tIkkQnm/FyYQbKEX+SywFH5YHNMYZAQb8CrulI96geBc1jlNQhyU/upmJL3MUPt/OsCSrnVJuPETBbPA8Ph5u48lQFkAHA5UrmSzVsgixCkyYdFPggfXckqJ0ohUzdiUHhTS3Ikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by PH0PR11MB4901.namprd11.prod.outlook.com (2603:10b6:510:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:01:42 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:01:42 +0000
From: Bo Sun <Bo.Sun.CN@windriver.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hao <kexin.hao@windriver.com>
Subject: [PATCH v3 2/2] PCI: of_property: Omit 'bus-range' property if no secondary bus
Date: Mon, 24 Mar 2025 17:01:08 +0800
Message-ID: <20250324090108.965229-3-Bo.Sun.CN@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: fdd0652d-24b1-43f3-4432-08dd6ab27ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N/zeDXZ1CsHljC0jedPZjNZtvBNpGYrVjfC1pAa8quvJ2iS14JhjQWyPhcZ5?=
 =?us-ascii?Q?2dAkTQU+bgbfRTUgwjBOPAYdf84fUtzrhOz3AblOc86yFn5P1JVksosHr6/N?=
 =?us-ascii?Q?O7k5s3bb26Cz45C1CFAt0ot/mrgDpL+F7GCB8V3btd13V+WPxLOnaaFCPwCo?=
 =?us-ascii?Q?7pBxZw8aQ/g/V9SrYltNIno6f6RAu/7V7nizF9cs8Zm492DpxJnvqh7tsLsc?=
 =?us-ascii?Q?oHDrmUz6p4LDqR8NUu0G/G+1DZAuvfMDNk0/rF7kOJjLRrRm2Y3XDxmOvtCF?=
 =?us-ascii?Q?BZMJxSyBI7srzhpnTwI1jwbHzeFWl4FbqFmCS4/q0/lMKScXdrfTto7zDbfA?=
 =?us-ascii?Q?jh1CSxKc1Erk8jCrLmyA7fFQQH089+JaIREjba/Lm8BfeDh5+V+QHlpOXyyz?=
 =?us-ascii?Q?impB5M53a5MgQdaxzwGg63v+Sr1IdCcwA61V9Vz+jF2mxo9fVcV+1erz2MD7?=
 =?us-ascii?Q?/jfEcIviJ6tTUtbWiWTZH4YNEqVvqJAAR2dq9CvwtxC6N+taLjBlZgeFYqfg?=
 =?us-ascii?Q?iuPP+IQI7qKU3hj0qp3j7a4gFIQVv1uQ7S+5btn4FVCjNK0MXk2sd0p1MCry?=
 =?us-ascii?Q?e8wzoOrJDxNPpD8QB5vwvI7NgDpyUwUefed/NdO52+bqUIU1p3GJV0+1Bo50?=
 =?us-ascii?Q?ZZzvIe84zriJTjhPUQPgMOa0rrFZ+vNnRelUkmc3GbuVlktZ7W3qtfob8bFs?=
 =?us-ascii?Q?nfvMvRP3DKpuYbUGXo/CPRngTVxTwejidp1D6D3lds0WN9yRog/bVWC1MT5X?=
 =?us-ascii?Q?5JapgjwgkiUUbQSONS1fcJX2S7kEDvRY2F5442Mq85IG+jEuop6hBArztL3D?=
 =?us-ascii?Q?0zYzQEJAja7GAsBPqsIAYt5OSZqeSdvfz9b1pbyyT5J0nHeSZCFQpluLOagl?=
 =?us-ascii?Q?sIgSF2QAOt5i0sLCc3sX1qMzMaM0tgDG8uIZAr2PlyCFq7qXCjIP98HNXZp2?=
 =?us-ascii?Q?GPuOCY50frRugpw+4jxlOGhl+cueNT0nA71P0oHv+C7G++HJaRA9TglgCOBe?=
 =?us-ascii?Q?vRMYwOkEAcp/a38py6IgZPANAloLjq/2eaXXqKjA/XmDMtZoQJIuu6/FtYeh?=
 =?us-ascii?Q?vYDy3D0U/y7u++Z9vTauGZaTSDlzNvOBR3giyzX0YcreB8N4n6WrnCL+F9mr?=
 =?us-ascii?Q?+Om+W2iOpN0k+W4m8Kmc/oW38Z2uhRr5Iwi7ZUPkyqvFI30IfTbLGfpMLPXF?=
 =?us-ascii?Q?vPWbRFEKpK8zcx8nNb4WHBaZwVzphUOkUyyPOz2EbfKGxS4ES1ITFiqJ29dD?=
 =?us-ascii?Q?4QJasdoNuy448M0r5yzoHb2VIM5/El3qjGejs9Y27a44wU0KOBoNaVQ696MO?=
 =?us-ascii?Q?fu0viWw6vm3ZoB3+saQhxsGmOyXdTp3g3G0+cV+zq1B/gh90Q9Qc63yN7t9y?=
 =?us-ascii?Q?ElVACz4bUuw9zEZ8P5SbqOpzksSx+8ARAAibnyMDxes1gLHvfr61dU+ZzezI?=
 =?us-ascii?Q?YoDNYsP+E8iZ1b01aEZX6IW/a00oviQP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OKgcMdaVRO8slLxgycTtbghmDxLTURXuAKgxRe87MAxR+Q3jXd0n3acIWw8H?=
 =?us-ascii?Q?LQpcVHFAkUrlu/BIOQjwE2Rn7bh3m09UJeWNN65cup/NgX37Q2dJ5D8E5BYb?=
 =?us-ascii?Q?o1AfDkYbZIj/n3DfMUpO4PKrHX/eKYOORax3aZbpwwf4DvoiVgup9WjtzuXZ?=
 =?us-ascii?Q?IrJvlttUvE006MXWb9nvC2S3V0Q7hOMU2lgEKw9kRjAjSFVLHf3/qiJ0Ei6h?=
 =?us-ascii?Q?Yv66RokVQP/xg4MpGLydzRqFhfiqNoRGDaPGQydg1mXA+RWNI3P4g5Slqunu?=
 =?us-ascii?Q?II/KywvsJXT36ZZBMv/2yWJgDm0G+W2zxRVeMQupaQzim/0MYh5yPkNyRq/b?=
 =?us-ascii?Q?dqNM+XeOzNCFiWrZo8lpRzfutZzyT7yX1JfQMWmYDUs3H9gKrvFLZBTYhtJc?=
 =?us-ascii?Q?Lb+FaQGTdYEfZjIcn5/e58LSSdlk/DepazrHBjLQD1OgW3orJpab+y3UANTT?=
 =?us-ascii?Q?8O9Kt4BJEJTT8gNOMTKgCk+MLpCSejGoP1XPB+IW335zgioXhx81BHn9jk/7?=
 =?us-ascii?Q?gxsz1Fuutq81vcOWfvoji0JFYqXbBtohQdBPiy1OzUBLfm7JyXP/7rtem45p?=
 =?us-ascii?Q?mpwWgtnPfv9Oe7Qbkg/8slpxchMHCjQBaHJpcY+S4MhU6BNBn1LqB02rm5bg?=
 =?us-ascii?Q?L2649WGKmk3VesD0PGFyCFdPW4PYaidfbgT7/4r0QuikolQtE4qiEaAEAXOa?=
 =?us-ascii?Q?ixWSHemkBlDPVukNkHK0LNJG/16/BfayIUH+3jhSHpXyk976X/BhDhcSEwUs?=
 =?us-ascii?Q?ChTgcFdvCJwEdtY68Gfkp36VZ/m/ffKrvFr4IJqNNaYN/kg8qXJKCW4qUNkZ?=
 =?us-ascii?Q?KlXW1uh1ssAZKYrZNs4rDyM7Uki1Y5lZRSmE59N9/BkNkGrtCcGLlkzU5EaS?=
 =?us-ascii?Q?Jb9UGGI3S7HwxrLpNsQ2dxL3ywC+3x7xm043Dg6y0zvWxan7oyZQBl6CAH1g?=
 =?us-ascii?Q?jj26QO6ssLWdNM9hpfl1ZYcC5Ubcs+iTuEnA9E+8Fd2jmc5RatzZWt4OvZE6?=
 =?us-ascii?Q?4JH3LrM7qSiA6sXrz5xFYB3FGV9wgdrASoSbn1AV9lG4vsZ243IGZhsYX1Fe?=
 =?us-ascii?Q?tRVWOgs05qARlFE1GnFVXj3UWzK13ay0C7i7qJNNkd6vembJA2vh7hDyMb/2?=
 =?us-ascii?Q?Pd+pVkmYqYBTGQShxqKUyieHi8vuEyKkZntG1nbawfFXRDo9byBfvCxspLaw?=
 =?us-ascii?Q?nrBuZnaVCaAef/9qzfsASyVlbGqKmvjlN/3YUQswe+s1GmkTPT20HC4milqn?=
 =?us-ascii?Q?y/9vZN9cM3K0SybaEmrSKeLRu/n+sHWvGCuESPHJxSKfttmId4XcIrQNhjuY?=
 =?us-ascii?Q?G1HRWTi/zs1dqzp6ZTLEcskqLr2exxrdssU11i5Ky4sTWmix34P2zSNY9/Aj?=
 =?us-ascii?Q?PsLira0GVDhl8WEKU+LmSLl1z1xT1E0YBSKsfcS2EmsIF7d85HFWAE9WSUzr?=
 =?us-ascii?Q?yLs/K9fuAw3SOHkQVbunXzhpyUEMQuaLdksHo3tFCMjsO/uW0yuWvbm3sM+T?=
 =?us-ascii?Q?SnOOuR+RIQqO8DM3BVF3VRGWvJmhNz/yFaNluyd00oTtyuDrqJzsSJPc3spV?=
 =?us-ascii?Q?ADCgMIIstwL4007WQ0GZnAOHdc/TcmJ5JQhQx9V2CrwCwKUlEWsEfo4swhvp?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd0652d-24b1-43f3-4432-08dd6ab27ece
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 09:01:42.3775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6yFZwSBVL2hTBr9dav+h1YZ6RVb9RKCdubDHkabuGuB1FCZ9cOX1xulaLAzg4kP2ixDlkTCVTfwkyqlMv8uPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4901
X-Authority-Analysis: v=2.4 cv=XNkwSRhE c=1 sm=1 tr=0 ts=67e11f78 cx=c_pps a=hHPfuxNGWHHq0fQgDGst2w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=UaaBw9Nihny3kgCARB4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: HjFyHkCPylYchiD-WRIba8NrabJayCSs
X-Proofpoint-ORIG-GUID: HjFyHkCPylYchiD-WRIba8NrabJayCSs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503240065

The previous implementation of of_pci_add_properties() and
of_pci_prop_bus_range() assumed that a valid secondary bus is always
present, which can be problematic in cases where no bus numbers are
assigned for a secondary bus. This patch introduces a check for a valid
secondary bus and omits the 'bus-range' property if it is not available,
preventing dereferencing the NULL pointer.

Cc: stable@vger.kernel.org
Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Bo Sun <Bo.Sun.CN@windriver.com>
---
v3: Add 'Fixes' tag as requested by Mani. 

 drivers/pci/of_property.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 58fbafac7c6a..792b0163af45 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -91,6 +91,9 @@ static int of_pci_prop_bus_range(struct pci_dev *pdev,
 				 struct of_changeset *ocs,
 				 struct device_node *np)
 {
+	if (!pdev->subordinate)
+		return -EINVAL;
+
 	u32 bus_range[] = { pdev->subordinate->busn_res.start,
 			    pdev->subordinate->busn_res.end };
 
-- 
2.49.0



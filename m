Return-Path: <linux-pci+bounces-23428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77095A5C312
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 14:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520101641F5
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 13:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAFD1D54F7;
	Tue, 11 Mar 2025 13:54:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F1C1E260A;
	Tue, 11 Mar 2025 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701248; cv=fail; b=Vyeda1VQ992UFA9HWt1iWd2pO52eD/fBkNsJ4V4hv1JvOWyrmvBpJMwJkWhTRLiSlIYAcRyH3wkDCRYqxi8d8OsMxPxI85M/bMHDRpBsp0OwIrUq9E5DkXm9mwxEIb6fh272/uWUrVLyCwdZl4dV3YvLz3KoKneJrhc4iJ57CQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701248; c=relaxed/simple;
	bh=rpSuvwx9MPS494S2GT+nieGQcOyykndaYQ1uf5RjXnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dNCSfcKu3pezGUOF8mGo6OCWVxQhcYE6nYZiZiAXQFAtEJyFfXT+7CoNQpuWEb4AGVs0TJaS2WGsL+zT/Cx8cboa8eyNVlDJAbL9cxqCa3u8nrIrDJyMmSz3/hT/pwY6L1tt2NH/nvSGVjgU2XZ8VoQTRgdKRCH7NYZPsJYu03o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BBh3M2017197;
	Tue, 11 Mar 2025 13:53:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 458b413gsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 13:53:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jm8u48utoxmDlJeKPtXccoyDOcUn01YWG+PhAqJOMrseRaPMHWkkwrIvsWEIAt7uiLLgjLd79burc7kKm0FD4EqGJgayPGpNHUO3ZEeuKAiGVOycScZakFctQEHmF7NQyzjwtx0t+6ktij3greg1A8grQrZd2hFeSYBRlA5sLhPDtXwU8I8k+w819r3GDCG+nqedd5kREuwFuHO3S8qm41yM+o9tynJVNBGpmMdJeMU6R6C29qkVhYCHY3tc9UXSS2P+KK8Pze7HDvsYEhC53BzlbVGL24ns+Kgrj46/U+7FSxmJGdhKvYqUtzcCRDyLVBDqwnE4JXTS2C35uK/UiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cuy6yDIGgB4FkRjtcjNCLWK4aO3/8HrKM1dxZNMw4n8=;
 b=i9Q8zxLTGLolktOn0W9TZgDw4jGFQRCbU1ZSvpnRkEdRN35WbTbsyU3yzVv29avrHxfWSkVtnNTzIqx9eKEjyeY/FlvT5MW919DdX5xncNJA6i/LEhM3PYoewSEaJoFMgVzrwNE5rxM2VIU/PDAmo6G01kzfvZKcX9hLzHUXDnNkBS8VGbulYLyGBg7zOXkQRnPxWseGIEZHyHqTM6ZSLN9lgOiZxowO1p1iYXFZk7hbVQGVYScMigThnRYULsN5T2LIMWCZqk7PeLAdW9adMWT2/4hGpSLNZapYwPl3tp60zRq+4+cBQQdHewcTpaDEJmVbyEoIyU+ZIhYg/Rvfmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by DM4PR11MB6454.namprd11.prod.outlook.com (2603:10b6:8:b8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Tue, 11 Mar 2025 13:53:51 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%4]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 13:53:51 +0000
From: Bo Sun <Bo.Sun.CN@windriver.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hao <kexin.hao@windriver.com>,
        Bo Sun <Bo.Sun.CN@windriver.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v2 2/2] PCI: of_property: Omit 'bus-range' property if no secondary bus
Date: Tue, 11 Mar 2025 21:52:29 +0800
Message-ID: <20250311135229.3329381-3-Bo.Sun.CN@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 71f800ea-d42a-4acc-6167-08dd60a42753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1cN6yib1uBH6jY/xjZ+onI5p674a0G61/oN5ts43K0FZXcJHK94OJ+omIFRG?=
 =?us-ascii?Q?dTGgs3ozZ0077T78GkDXMLpfU+UsO0f5ihGjfbQkXgNE4RDOaGieADB0kuk/?=
 =?us-ascii?Q?5Rz3ijFRnEF0js4mBhSDW10pZdDDSqVl+JJbkMDkPH72QEMa3+Vu3fd3x/+M?=
 =?us-ascii?Q?cy3coyyL4mk7wPqd5W4WgmWf66TZtufYXNPIRotXqxOjfT0CxhA1H5GzRW3Z?=
 =?us-ascii?Q?OEhAQgChihF284PE367oTLC+cDPJoFXQPFYb3/AwhfrS+hdggZYpB46NdkQ+?=
 =?us-ascii?Q?DXP/0+qEWl9Z9dvpTyUkdT4JD6hBmc9iOL/p6QK3C3tyMEPoqxdN3nTdxbOw?=
 =?us-ascii?Q?1HES2FxYjzmkxGJFMP2FpwN/d5dZWYiY82Fc0bWZU1y2O2jQjYQ8/TQQ9zuu?=
 =?us-ascii?Q?l9LDQ+Ge4qrrZqCWzkCXVZawyPxD78yQVaNBgZ1CYIbKBfthU5JUHsCLD1ef?=
 =?us-ascii?Q?vgsqeUnvGlWaajxiINa4L1cZxY+pCQqbF5Ew6wy/dlo/yGBYD22ARangmeiE?=
 =?us-ascii?Q?9Vr3aaxQGm7K2c50JeMje6isx1yiSWMfntfa8YN0k5hicynuOYmRKxsSYoyC?=
 =?us-ascii?Q?Z9YurzptbmkpyNwIht2nhakrx2EfyqP/ewB3qMCGQQOK3/XKpwB8jIsPVtWn?=
 =?us-ascii?Q?vkR4nv/QRqXSAJWhIB+WjJ3AmHbFVlVIXJszOGMVDPBraQ01ktLAFTbZ2jXx?=
 =?us-ascii?Q?wIm+EnHyMok9bhvCiZkA3tc516W7hq08ku6J3Bfpr2PnGoZmGCBVAOzm+sQG?=
 =?us-ascii?Q?e09EwwHaW6MAo32fHwH+lZzSUb1l+6594bdGaUfj84L1L5af1S7pAC3QGIqJ?=
 =?us-ascii?Q?6pVp9WykvDZ0er0Q0F7FRGzVEgzAcMWlr3JmPtWD3iuaDygitiPQXSiP0J8k?=
 =?us-ascii?Q?9IoxuM+qKCsp932PoIoLDD/rKA1eSWyUe9d1LdlmTs/rEVdkc9VmADOTzbqH?=
 =?us-ascii?Q?u6EYaF92rHBSMmQDv8r8IabrWsVioU+jD3W9rpKiCJfAzTlGuWt6gyLV7mlX?=
 =?us-ascii?Q?wc0wMT7uuuBqZ+0kLdAPBUdZCa2ybmDEJXB+IuKvbCTxSpAOskEl8p1XBGcI?=
 =?us-ascii?Q?Arm2idbljdouRz9yzsXrApcA3TrZ3ZYzCW24fp4BaxBh6YwKxByvHmA2d7y/?=
 =?us-ascii?Q?ziebvjvO3bLbBXtirpduzZqkeybZwiJZRkUmybWke4596+N/gzWAfQcH1yc1?=
 =?us-ascii?Q?J9aNps4baeD5If7Ze/nGicMWWJfIkttyLrWvSS/YoHjJoxDjMV512nnWnqCi?=
 =?us-ascii?Q?ezzYnZ85Cq3CKAnvfmTcTtKi/vi7hQGBiha5hU/4KndnCXlyZ9u6WnsSZtDJ?=
 =?us-ascii?Q?2O7UhiDU32SUDpkD8L85rNOWPowFR1XA5aII3VRTSKa6ptfXrZt9Nx9n4rOe?=
 =?us-ascii?Q?faYCvgid0sTC5hQDk57vWw0DnBLJiTfzKExerubhJvPuC51OEEFytTlfTFy9?=
 =?us-ascii?Q?0PqDSjGCJjZVAunjBocw6ys/oPJb6cLn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1D/ck6zoSb4vmexGGDLD9sUeOaXk54D7582zEUlU8gieIvRu8FYalJ19oz9F?=
 =?us-ascii?Q?lSF8oH30uibp5Czff8Auym4ZueQpTrwVZV769BoS4MJB80dtXszW+kH9u9Ji?=
 =?us-ascii?Q?KO6Xvm4fg0PgLy8CN6z9bMu5QYdTbBX1XV3hBWYpvWJWsX1y7NvEkJxUFiV5?=
 =?us-ascii?Q?RuwdihskedT6TgspmGjueXdNljDvRUzjSPBWXJ8qu3umMDsgykBULj55cyEf?=
 =?us-ascii?Q?R+nwO7o2ePexm1SoTkUuQhLPpP9SvnoKiYkvzMIxVBDqCGUmRJK6DUdWksdP?=
 =?us-ascii?Q?hmAG6NlBN6A//rUud9AGdVZF4txlKGxwu7G50g0x6+h4yTYByl7HsR6fWDGu?=
 =?us-ascii?Q?WE2Bl1hBiLFdzywpi5I5eVP5Kirc8qJu5ADaFJ9b9x/ivNieLNDQCVgFR+qS?=
 =?us-ascii?Q?F2EgovoSjy8Mm6kRJBYp/RkTn01ZnIC9E8Es0YTRN7jsExFjpoTHsc2QmxO/?=
 =?us-ascii?Q?SRjl3FKbABYLy4qUVx+B82aX2/hlV6uPNwduPuwMO0sBlv2iR2G5u/Dx5i++?=
 =?us-ascii?Q?pHgjCfB9218K4lTH8HKHg6UpyBdzIaZqGgB8FA/2Zd8O2acXOYiuFhuCTNgh?=
 =?us-ascii?Q?AuXeyiZ/kMvD1zJL2r6v8In9RgvR9B1DLvZfOANj+WA6bzaxYoL1tDde4iOg?=
 =?us-ascii?Q?SPXft7iQSS4jcCF492Mc/NzOF6v86EisEQbs7s+h6pcr52sglyhSxnvEyhtV?=
 =?us-ascii?Q?drWD/MfN7+K2PSrgV5F7SwoiJOOiDV6jdU27XB/YWmRzHq/INPkrbxPC0ZmO?=
 =?us-ascii?Q?nWknAbBjB3e6peV9vPpkDP99C9AULWG23vvrrdrYqxxUEl3ajTc3q685oucs?=
 =?us-ascii?Q?0ieQ/FrKcq9b3+32YEvZ/gfMwAqnzWTqwbNIxFrviUQQeVFFYuLYqHonGy5b?=
 =?us-ascii?Q?8nw+I+xwWGWR1bkGEb1SrVhdO1Af7Aueiyb5+EnE4/EA8w0MyOM9XMWyVJhX?=
 =?us-ascii?Q?VqL3d+v7ZiKMQ/9FCLd1HITYEuW7QF6SgEthrYUBI6JXM197cVGErewxoRqY?=
 =?us-ascii?Q?BE0lEis7XCoa1XfCSRasIDcJgTdZ8HfxtuAjSlNoe4SAGjAFoG72PQ92GiQE?=
 =?us-ascii?Q?jw/VNrR6Eam0gp63F1fzbLQ/AuIHlkOuihhf1MD8GbXLC+LxhtEVDvgQSgXJ?=
 =?us-ascii?Q?5SX5eBm0eViYD+y0qA5RMe06s303t0rUpkBkiio1GQGgiDlghKHduM9zLPnK?=
 =?us-ascii?Q?+suq8jaCr8AR1cyWRxFe5rtsxdHMWKOuI5KV2a9IqEpso5Ld0dvgXfi3Ki4t?=
 =?us-ascii?Q?PnedWxzPJrvNZV9WCMIw3PZGRAIkAkzMia2phkkSF/I6IABw0p6My7DyjwTu?=
 =?us-ascii?Q?qNj8FSYdD77gdF0+2buueBBEwFYJhDKHW/n26m8AqMOQ6Ytgkrj51eIlToGT?=
 =?us-ascii?Q?TZ12P1Zjz7v9vsMUFHKKDW+pxS1gpkb1RuHWR/F4xw1xB+pUuCFRlam3rK0E?=
 =?us-ascii?Q?TGBOnfVEQXD1XSjJSEXaNY7CBmF/B5WmehASWYtGQHdzZz254DI/YP3iDcxi?=
 =?us-ascii?Q?IV/KPOAMGLktRgGR27YkrMoQzmRyYJGjfqANfrJ8biCWnGPgk8VgQ23pyABl?=
 =?us-ascii?Q?SLJ4Vp//wBKTOfKN/PAvjiLgbOTCuRtTGfmfU+LBAdkkRNk0XQ7nJinqui1q?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f800ea-d42a-4acc-6167-08dd60a42753
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 13:53:50.9836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6XPE1cYPWI5Q3B3cDbiHcDYOwqmlpup+VL6IApafrYojAPQcWL40ZktDUl2PpQccgQzaEVNfTcHBWQAxawSUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6454
X-Authority-Analysis: v=2.4 cv=JYNGrVKV c=1 sm=1 tr=0 ts=67d04071 cx=c_pps a=R19XVbJ/69TrMGWtO/A4Aw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=UaaBw9Nihny3kgCARB4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 4JRK82gFdIN3Mrzq2EKQnBV9wqpSGwUz
X-Proofpoint-GUID: 4JRK82gFdIN3Mrzq2EKQnBV9wqpSGwUz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503110088

The previous implementation of of_pci_add_properties() and
of_pci_prop_bus_range() assumed that a valid secondary bus is always
present, which can be problematic in cases where no bus numbers are
assigned for a secondary bus. This patch introduces a check for a valid
secondary bus and omits the 'bus-range' property if it is not available,
preventing dereferencing the NULL pointer.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Bo Sun <Bo.Sun.CN@windriver.com>
---
v2: New patch.

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
2.48.1



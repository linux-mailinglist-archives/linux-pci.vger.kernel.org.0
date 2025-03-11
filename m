Return-Path: <linux-pci+bounces-23426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3CBA5C30B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 14:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8BC176996
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 13:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FA51D47AD;
	Tue, 11 Mar 2025 13:53:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605731CEEBE;
	Tue, 11 Mar 2025 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701228; cv=fail; b=tzQACOgrPFimBqStJR5Ch+NVx7/+pCm6DZwtSngaT4M7n5uQFjhAqqiefPpUcO/EmZN3bfxIr8zYkQPP0PPoGL+qlmTsB1TCJUNV3Girtq/3QaFlz/I1ICZcJpyL9b0m7Gjo8CvAcc9UajX/ewFmAxLK5JdNltH8v16dhBOVvQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701228; c=relaxed/simple;
	bh=KGXfFgr2YZKTW2CNH/BReUa8AKRNAZQsOzYFwDgbDIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NVcxBG0w6ux/2I955vV3p6rY2ydY6ZG6gZ2uI3thRDqZNumTLxW796iAg+/08Agw1f8NUje8rAIaa7G709t0ftCilTdUxn02dxZ156KZFbwDqLMgw9n5aAbge++AY/Xpva57tBkkgLCwjQLh1UaQlJNDiTv685r73QI6IpmUL+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B81Wwp027492;
	Tue, 11 Mar 2025 06:53:40 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 458p9qk3j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 06:53:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gm0r5cXkBBJjZWWIrDVHiyCjyF63eGgqcGdMJ/jHOG3yeoo5qBEPL+TXnKyPwKkbHLhKbipSS4YuBHtU0eV0xaYij3+Py8noOzIT5HvReO3IRfMhj/SeRe8wjAbKHAGsuFhwqFdcc0BzEnAmRFVvWBfYX+oFpUZVvjeQ0kGKrf04BHfV5ydL02XZkL4CM/D60Mc69hljOLYs8G7wx/h90mtsY9hkC28PE8SiYV1+AKJDZTS+7WDvc7hbMDONEI3xCqNuUwVfSFWBTPE2lcAAlehe7lRFaz3tIfFxkLh+RoGep1ZKIZYqj+5kkk5ooLeBnVvz41bq+P0nDMnsMy8oGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fN5iCFptWd9vfLCOcdCfCzkpcC/t12Nxz45m1VxZ5Gs=;
 b=Au23MZfIfacypHWWwolQZT3hMQDrHIELZ6oSOw8J7L76oYE3IYggoaJBENEMTYVN6zU0R3pxlzGhP5C0bF/ORFpB1LVBguu0Q+1Y8nuQWArEHm/oaLNV4YIa3m4LsgXMfxa5N7bULGQQZJ/QCZL0xMT8uO3um0uiWCtq2FeWPzefo5UGRVg2CL49EWG6dpCGftMfZR0HuA2fyVoPQxk+0J/DfAW5i3jJq3VsWqyDEms5Yy1sKbLbKjlRnLr01g7zITDIdfR8DuWLKlLrrR8j+uBTBo14TbP702G4WSCd4PXu9W0/8GRQrel05MiZBX7cRj95UH7MMHsoZj3DwkaTnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by PH7PR11MB6553.namprd11.prod.outlook.com (2603:10b6:510:1a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Tue, 11 Mar
 2025 13:53:37 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%4]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 13:53:37 +0000
From: Bo Sun <Bo.Sun.CN@windriver.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hao <kexin.hao@windriver.com>,
        Bo Sun <Bo.Sun.CN@windriver.com>
Subject: [PATCH v2 0/2] PCI: Marvell CN96XX/CN10XXX quirk and bus-range omission
Date: Tue, 11 Mar 2025 21:52:27 +0800
Message-ID: <20250311135229.3329381-1-Bo.Sun.CN@windriver.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5866:EE_|PH7PR11MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a05c0ee-92c7-4a18-a937-08dd60a41ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g0gQdMqulMB7+RNviQzsLisMh++wvoNJAC5aK3wfH9QicUIYPIowJDg2NhvK?=
 =?us-ascii?Q?sM4KbIjuKcjh/T0kmwxWZK8sAGS9XaO5FO8XGMA3wBcruJTzj5Mzl7/xr/bY?=
 =?us-ascii?Q?ReZCS96bd/BGsZO8QKIIwM1Gl2Wv2eNvYQDsOAEO3cwNudwX5TYAxtzzoaFO?=
 =?us-ascii?Q?9x6MIPQt7ZYnqWOq57NbBuUmecH/uxeC2YQNz8Uva28TfdR9dKL4nJ8f3pwy?=
 =?us-ascii?Q?4u4xHuMqiYG18rHmX19MGtrcHGycABaDXx1N2P5SpclTyR7ntc0sR9f1qmv5?=
 =?us-ascii?Q?NDQb8RF9YO+5eBi5ZVUUgZ/VU6xPKlZOmX94D6mIrTLXikuGh4/83Z+wtimA?=
 =?us-ascii?Q?x3RT/dhtqYmw+HSIiqf6HXjydYfp1l419wYR/ibRlD2pKXD5hBK7LKrE5S7D?=
 =?us-ascii?Q?8RqOE9bRLrIAPTQFvuEHtdoTx9HjuxR9/f5pjxXSwnxnrcqHi8GXpmJ30QVA?=
 =?us-ascii?Q?PWQcQsFMOmXgDBqioVcNPXhvbAz/0rgXn9UZmDO9ixei2HY8miPTTeUkHPUn?=
 =?us-ascii?Q?3D/YbAjv3iVafbQaZ3viXlnAILqIZ65+oWCQTHpKyELVIBpEYAz4my6U+tbC?=
 =?us-ascii?Q?7P4w9Vhy7kLkcYPnqq1i+tE6QlM205BTyjdNaViLsc0cZdOrhTeCKqY03m3P?=
 =?us-ascii?Q?rQutLymRauaswuOX1bwVLAMZPxKTOfnu3uRQ6VCbodi7uYBM8RWpPNM7vzi8?=
 =?us-ascii?Q?EhLGRWW43bGWhcrciFcMflB5kfyTOyzOYBVC8fIGzn7V69WXG3q1xQ6o4ipz?=
 =?us-ascii?Q?xXyTkOBHhFk1kKAqMd8h0ZCwKrFqIWLcNXBhyxgtAZAVAhcMr6zUAglpyOtu?=
 =?us-ascii?Q?b+waRBaxaaI8+7EyIyAa/6KVShOTVrvuS0KCe+piPRcchp59JTEiVopACtAG?=
 =?us-ascii?Q?DegWB0iOMgoM3rM3/JuXygYVjjwavKtD0JZ2TyeH2o86+gkj9dL7czoDYrXx?=
 =?us-ascii?Q?ZZLqxuNF0R9NXZqpmvOosYo/K5iSE458tN6mWaBdPaQya1KLU9CwJOQtmdCr?=
 =?us-ascii?Q?bHDw/lezLh9kg+bvao/Fb3IXoYrIB3QUlvu1C6wXDxwXJ73pKF7+KKVDgV82?=
 =?us-ascii?Q?wUJVQeeTXrVfTj5yiChDCTw1TxA4qY4oPN+X16aoEGzCyTlPdMuMO6FprS+R?=
 =?us-ascii?Q?J/EsJ27l9Z/4N6IhL2ny6xzSFVP/2Jt5hKNfq0EIrL7CX0xhbGgXrX2OR4qb?=
 =?us-ascii?Q?9huCm/PZJR1B1ZBRDkc6m2zpyMXmqRj1BrA4e6SCQx9K7SVPxaPAuBkIGrI+?=
 =?us-ascii?Q?i1AmNxXvh6cPmtMQGuFW0mQAY9cQhmB4Dtb99xzDMC9IxNmPRtsN6RRr7QJz?=
 =?us-ascii?Q?Or76XU3+LT94/VK1ZTyPDEziorsTHSFKNEuP4QU/Q1YrEKuyYsZ7o4ffN5In?=
 =?us-ascii?Q?6Ymy3Xw/cO9l2rePxG093c/Zz0DSUIhu7o00eEZZSzTl3E7FVGsa+2TN5w32?=
 =?us-ascii?Q?mAJDxuoMaoMUbgLbpYwF/sB0jzRKpDxg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hyiH4RV8CP04sF+G3qArJxBIJ74ADttNW+uUmh8WxXLHePjM8CJyrgrSRZNs?=
 =?us-ascii?Q?FBy6y8CLln9RUQfhd/3btRxyn4pTh/ugAO7kCw5yZfN8jgswrcxEPFiuGO73?=
 =?us-ascii?Q?FT1tt+/kyno84DSzZtJ18NzognhEUk5KbQ20kTuT8wp9/E7BSgN+X2ozSRAa?=
 =?us-ascii?Q?AdrRgiSpTnff3c2dWdfAR7PIhSyckOtdct6Tz1+aDvBWta55Hr23m1BMJ5dm?=
 =?us-ascii?Q?y+mIiNh8vETq1lKLpq33SEQEM8PlItaYg3oUK3qp+AGMkjy4EKgGNtPfj4mf?=
 =?us-ascii?Q?4lhiQGCzzEIjx6kBPtB65vAdq/y6I5XkqUCxI6pjgXd+mKO3en0n8ppjJscf?=
 =?us-ascii?Q?EWwrxkGBshaXdChx5F6BanEPGAkp1EBLLv4atWYgI72PbwnCnnuSJxb2rtAn?=
 =?us-ascii?Q?ggnhGywT7DQmAdA+c6yIHtyb7b+/EQLAWLSuiQzXcxu98jPLfJBGcViQ00I5?=
 =?us-ascii?Q?t/u76Sh1zjONPqCJFCw/O/RcVkqCCFyfh82M5m0sZmGkNoyQRTVpov9sXPKx?=
 =?us-ascii?Q?At/FmhzIzIVTTdXJ3cYsbvT9n7IwUnlznZj2TD8KZkAtYo8iZ8R6aK60P6v9?=
 =?us-ascii?Q?2d3s5i6FDIUpEkW2YCeEn8Y18NNGgNsOO/POWlPzZcAPgydix8wi16x0q0qL?=
 =?us-ascii?Q?eCrnREOO+PsKb0jk/Em+vnahmDFNToQpAIA0murKWNcKUH85mV/7vfTDZlB+?=
 =?us-ascii?Q?Uson8N+TnM9+wTmsBnrrjvX+ApRYC0Lu6QNJl2txaYeB4m1Q5BWLGTvziogl?=
 =?us-ascii?Q?ZREJg2P1XwPiuVomCTVI0TluIZCXXfixjpOe5JvCSD5PyhyNCP9HQ9DpZbxt?=
 =?us-ascii?Q?6nzsV1DPIx+V7X6Jw3PrCYX+ogpVPXeC2oq5WFWc83H2qR5kATfEQMkdbiwc?=
 =?us-ascii?Q?8r/JzDiu2sSBMUA+NoZtReYiE0uK+otzB12IrtA6lXz0jHb1F+aVjqgZVieq?=
 =?us-ascii?Q?8WHnm4qSev85YKhcrFg26eOzhpXKrI+zIW9vR8FpWWIPwSV3838GGh0xCyNW?=
 =?us-ascii?Q?Q6WqwWjz2lIAMyYC2MqEL/q+oYm654ZnbyxhHnoo4KkrzkQh/YPS6SBFHLbg?=
 =?us-ascii?Q?CJ/XH1YBI+S9JJpflejc3qCmRBtfjvEfyEmJaojYVhuRNm4FK1hlab+A7bRN?=
 =?us-ascii?Q?qpTs4X/gVz7PI50MKOCfjwu3nQ8f5nObTK8gUeyZ8MZwjdfFQ/fT2/Y4tbgd?=
 =?us-ascii?Q?/xJHyB92zaH5tvbAuRyGrqs5lzdPy0tY4RPXeBhE2Ug8/QUBjkKOqblVjISH?=
 =?us-ascii?Q?sh/lYYzZw9HnR0JM2iLbgLA4ZY2Arqg3kjoJ0jNUxhfuJ7H+Fewl/+XHyRMo?=
 =?us-ascii?Q?cDkR9sFIFW5WCmDnK+tBa/XnZPFavL5BnqJlcwWTdn5os6NH6254iK3vesMA?=
 =?us-ascii?Q?Sr7cxQygzCgBCz0/9tIii9Bfv1Ec+fMu22AcMzpp359u0wmEKFAaRlQIeQHn?=
 =?us-ascii?Q?5oHPPu/eGHYtbtvstrK7dGDrfGyEs8VtcOYKWWWY+b9LPIB3CEUz0W5CAnTp?=
 =?us-ascii?Q?aQ4PI3U1pM+QAfKE/Izb9sjnFPYqP8DvlFiczxNpzQcCMLYrVaL3aZ74ZKVV?=
 =?us-ascii?Q?m80QtrCd9oIsIudlfDKMCXFPAhQQjeDl8qSOH+QazXXmQw6BQF58yF8bO1fE?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a05c0ee-92c7-4a18-a937-08dd60a41ef2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 13:53:36.9627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4Y2/2Abw5FdPzQxbKwzaxiAttijpw7F+8piF7A6nUyaMkcr5usuXHLUOtJUfLApmeBq1bf9YZgTtkJ1DK6LqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6553
X-Authority-Analysis: v=2.4 cv=QNySRhLL c=1 sm=1 tr=0 ts=67d04064 cx=c_pps a=19K1aDEwnJ0RahI1emVHDw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=O86CxsPCvL5fKE_taz8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: GR5HJPf4ijgKPfttg7GGJo39x4PMIr-R
X-Proofpoint-ORIG-GUID: GR5HJPf4ijgKPfttg7GGJo39x4PMIr-R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 clxscore=1015 adultscore=0 mlxlogscore=950 suspectscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503110088

v2:
This series addresses reviewer feedback:
  - Patch 1 sets PCI_REASSIGN_ALL_BUS for Marvell CN96XX/CN10XXX to fix bus numbering. 
  - Patch 2 omits 'bus-range' if no secondary bus exists as suggested by Bjorn.

v1:
https://patchwork.kernel.org/project/linux-pci/patch/20250117082428.129353-1-Bo.Sun.CN@windriver.com/

Bo Sun (2):
  PCI: Forcefully set the PCI_REASSIGN_ALL_BUS flag for Marvell
    CN96XX/CN10XXX boards
  PCI: of_property: Omit 'bus-range' property if no secondary bus

 drivers/pci/of_property.c |  3 +++
 drivers/pci/quirks.c      | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

-- 
2.48.1



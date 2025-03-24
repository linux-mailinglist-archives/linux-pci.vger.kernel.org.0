Return-Path: <linux-pci+bounces-24500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CB4A6D6D4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 10:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319A016A23F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 09:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9642E197A68;
	Mon, 24 Mar 2025 09:01:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7DEBA36;
	Mon, 24 Mar 2025 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806908; cv=fail; b=IUdmYL+FM3RdyPgSwG8UGGOpF3+F3G7KTmn+VxrahqhypRxeVO+YPUTCDdzAfQA9OpjFLVzgCZNVyza5cep5x9Za2Sks9Tct/StVXO5mGo5u3i7+wzZk8SH4NJ2wwxarP8rKfDNLMuRHxmTDqCTNg8Pw4+GBvEVNHvBYdDPcpfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806908; c=relaxed/simple;
	bh=niZhuM1WVwUtRuzm8CdaarUJ8Z6ViMkf4wh4UZjCVWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gfkgZ3/CM2TTjNWF7vqWUqcZ8VPfryCRWd7BJoc5cvmnMoiZMX+IkPN+8DmoWRziUvn0Qrd0SBSXRn6h7baLOhKwcsxYjViaUYi3wPuLUtxDDdnKEm5LQxQWSn+Pk3DzfHcCSnNMH7MQfqRCaLUscV1aGoMNI6cprjxrKq+CikA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O6MvZU012667;
	Mon, 24 Mar 2025 09:01:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hm68hv7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 09:01:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=picC4XvwJpEzO9f6mOArRa/208P9HKdlMkkvzYgIt/U67xlOYqBHaSK2Rkw+DWp5n6EB2eAgtCjp9Ri+87s29AL68WBUo1XHhzO/o96pumKzbJP5B6yqBcMbDyOCXGQRxHSJe6agmFMvh7XxpCfbrnwFA8sk2sdZa7wByinxnSu8gXe0qT5CQEGrUf7v1zYEtbJ0IInqr7IOw0qlXAvkht7SGaPMOTfgNmUNXE2KjNqmxXBFfjJ8o9K1zUnkxlkndNYpKKG4bThj3mxzrUUiDRl/TaNWcVGhoZwfegHyxphdouh4aONd6Aeo6JMxiCfVFPT7x04b1OV0KeQdl/MD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fn6IhjCpw6twSAYj2EErxT6RxkuzMzrex1wwN+TK7Q0=;
 b=qLpwAs7te7ll2cz8a4kw1kG4nR5Guf85Of+K5C3R3jG+u9yNcvLRbIl3qd24jRgIIueWJsR2FFA12R5lVDf9CWXG+joesMupP7SKRnogJm9yxCPqED7A8bBb6aHDj6zmP0po/pE9pltYRND4mz3UsQ/6fP3W1EslDYNBnU8MCm7LV9V/jg574DP2Qd15UVauojc5yp6vXk41F7ZKs6a3+tzu3M6+MuzueOYHHgF6iHgEc97qAt6AJMhyK65sv6RDb/A95eQnq4aOQPDahJboJfO6KNvXoxUlbyEVFA073Kbm2uPJUETLk7q3MF92NNkj9ded+TnyleDjZuRdCLHVnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by PH0PR11MB4901.namprd11.prod.outlook.com (2603:10b6:510:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:01:37 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:01:37 +0000
From: Bo Sun <Bo.Sun.CN@windriver.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hao <kexin.hao@windriver.com>
Subject: [PATCH v3 0/2] PCI: Marvell CN96XX/CN10XXX quirk and bus-range omission
Date: Mon, 24 Mar 2025 17:01:06 +0800
Message-ID: <20250324090108.965229-1-Bo.Sun.CN@windriver.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-Office365-Filtering-Correlation-Id: beff5dc5-5156-4fba-3ea1-08dd6ab27bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aSM6SK9foVNh0YXRF+nN8S/d2+hdPQ8sQXqUw+cTbpc8CTbePLMzpN+Q6HT+?=
 =?us-ascii?Q?3kYhGjRfmciqFjIyrlIt9i8sun2lHdJL0iA3sLmGBaTxxKDVNWdgbbN/nLs2?=
 =?us-ascii?Q?j9riVnQbkLkQUy2l7iXkFwoOENpRsK+c7YQi2zGzLiefUYgxIcvW0/RzdLno?=
 =?us-ascii?Q?TW5JZ74EPca8OUYKrJhShSp76bJ/p0WWrUAEXWOBauO93fjLlkn1nFAqgdCK?=
 =?us-ascii?Q?ADiJYKKWi5Df6tRxK5bX/j2wVRUxwH5w1+7v5AqRHqV5WZqshySuE2TE4xBE?=
 =?us-ascii?Q?eVRb9S+OQbF/D1/ct4s3fZQafQD3BT1HER5DzJ7nyb5rBq8atmo3tNRV9uGT?=
 =?us-ascii?Q?wyMam01ykvD6GDxzQh32pK//rUUnuV2Io7duSgtVZG8ez8tRKR8pD2LuFrMn?=
 =?us-ascii?Q?ARCQPPgsgrenBOm0h7HKr+dWjImFN1UK7tVtKXa8Hf/H4de/4SrKwMKnRg7w?=
 =?us-ascii?Q?Zfe3KsNuPmlzvu/Dv3CwqPjpAb/SUrFMEERTWDbMg5gDOi8k3sPYX/c7oPO7?=
 =?us-ascii?Q?Lfn5AOX5dzAdif2wp/zfTllRSIahcGcapJeJO47DseQ1uc+8H5zcoWs1tgs4?=
 =?us-ascii?Q?UMlpqxlTjPQ3+hsnC3eY5xQLdHKdG9qeOBjKm4NgERIp1GKoh37isMjOSWjj?=
 =?us-ascii?Q?Fw/zBLaqU+i+9PLPRfwlM8iC+7ZHblFLdnH+JcUc72JYEO9ll2ULpr2NGiRS?=
 =?us-ascii?Q?sBsSmXYaarkVD+scU6IHJlHL5KbjHOBjX6u5ed497CvHY7h2fCmMOnDdQtfy?=
 =?us-ascii?Q?9aaBBXPS6TKKFJqCt+9LxNwg059k3QJCyRfMtzFG2NZ074X+W8LjwklfKDMf?=
 =?us-ascii?Q?x2pSRGl+QtiUtsGBZRlwXxifXmULDCdQgfo0dbfRUHdOEgnzKRa5WFxuHcj0?=
 =?us-ascii?Q?c5fz0FMtYDCNInWJMDEK0icEvvu06JpLhsR/tTBjWD9+KUsddS+07KKp2XqB?=
 =?us-ascii?Q?1841gik01+cy7vTWerZj1ruzSt4KdOJAOHUmH8RfbVYG/MEfLAaxMKpfyt66?=
 =?us-ascii?Q?T+CmCdHnsg1QpAmjMReP0lsux/g2XpJnEkYWw/ycJXpSdPz1/wDEChhPVb26?=
 =?us-ascii?Q?Qd+iCw4SBYoQwQni5f33gsxkesxtlMbtYW3YnQMe7k6KwNZaDXoPyVOn7OTP?=
 =?us-ascii?Q?OsyrMCCRr5lSI80GBNdTFyXbixbBCObI9aBKcQMqvSgW9epUAutD8xOcYQz+?=
 =?us-ascii?Q?TXOWGoh0AZfNRPk3gvicrSwsMqymCQAw/ezKUV9Iif3qdTSwtLAjjValxfwT?=
 =?us-ascii?Q?Amge1B3PKVcLLbiBYLayotk2QhvS9VqV99NT3lJ4GSUlWSHMElnR9xwRDTAj?=
 =?us-ascii?Q?U8ZeCg/lihgtNqMelrEmf0B0R5d4IrkDLf5JN3HX9dmzXc0X4Aq5zKFt521e?=
 =?us-ascii?Q?LoeZfXtdmt6pZ0vZmzRnt4n8pHgjMfsTnYW3dmdGnJlgqiVQCa3vmJmihZ1B?=
 =?us-ascii?Q?+Q9JCOvIRe2CfGJMa1/tfAtI69G92z5voKV+eTtdHmIWvVX5IJjfnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zpf+bveCQU0pvOi91ln2cL8idKss0pLP7rQyoGCg+2+Jvjoq8jMohDkOy7Bl?=
 =?us-ascii?Q?l8tkKykWHiY28IRJAuOrNNojTolb8078cWB80DMtxVNw6X5vFpJy0uvI5xbK?=
 =?us-ascii?Q?NQuSVtoLACGuqt46uLzw8gC/k/fwxE+SHI7a9ufjhNeVxrVI3Jt8/ct2u0ml?=
 =?us-ascii?Q?6ZsGIDdUjMORwjgEwGRPBEogWm0OcQ98NBIPsFrtAbSL2fIlZEMfhILSTjtw?=
 =?us-ascii?Q?9iKmUstiyVU76GPQazoVQ+XVFJk5jIY+PCGybAlCcaiKde9htj6LNqEgCaUI?=
 =?us-ascii?Q?ezc/7JbrtjIaMilpBOOuVRo3QLVWD77T5mU9ehN5L01fa9E3zd23gmq5jG+e?=
 =?us-ascii?Q?RTmbDky5ZSfQHfvMPkt4D6eVU8SJkrUElW4LVgrQNIxx09dZsCuzoXJCsxZw?=
 =?us-ascii?Q?I3Bzgdzuv4uhWURK8KlK3d8F0MKR6Cat1MXVITdEsopm3JwD96a0WxFKeq2j?=
 =?us-ascii?Q?tE7AyvsXXmu7zNvWQKDkUwdz2dd54hS9xDzWwGWEsoPu+nMxeTBET2Xlyl5N?=
 =?us-ascii?Q?kG0LzObDJP7nhLSWt+RUlnzr8BEUZCw4vfy4ph/ry9cyCy7oX2Pb1bxQZVji?=
 =?us-ascii?Q?QXQViamhckwJXNulKolLphtuBsmRLuOpnB40/BC8JiJDMPCbhAsRlt8JmqDw?=
 =?us-ascii?Q?VZUXq6y96+wrOxtMIehrwXq5zRkOFp5RZHVVO2sO8d1bK/6+QsZgES1N4O+o?=
 =?us-ascii?Q?NL8qdrOoRCisdQMdZjo07RCtPh6gvuHO1Dbr3WAW+exE0H/4pvQ+RJsE0fe+?=
 =?us-ascii?Q?DK6cAYBWRYb4gkQm5GWmDtAnrol7RkvPXYa1azcz6YG41x+XqSd0u7Bx7nQy?=
 =?us-ascii?Q?znYgQ5DhmD4YbeVc4UzoahBK/K6OxHLHTXuZI5UoCQJCOEC7mTNxJPTZlxVf?=
 =?us-ascii?Q?oZVVftML6J/09C/lvneoIVDRrvUveoYXeoYkg8Dt6xCtI+6EiY389Bcw/aln?=
 =?us-ascii?Q?iSgO0NsfMzFg8hQYMb2v0vXYSMGSicYPD6z7MamYWUwG6HlUi+pKB1OleON+?=
 =?us-ascii?Q?EfH5+Q/ifzV4yhHNt15QVgJIhcw3wPWPsCbHlgbMBhvBBMAABsKXxO8gA9Cz?=
 =?us-ascii?Q?1/uZaQNWGYWuXnyN1K3uG4Roi59TQEzW+WCXtFVmpRuKBx7T4JVdPMO9uukT?=
 =?us-ascii?Q?t1+f0FDqY4c0q5tXKIphgRkuO8H39p6M+qgISBaPiFuWujMRSomcDWHCeuth?=
 =?us-ascii?Q?ay+sYno4rQev4TZ9iDc+/ZElwaRMWg5bo5RRj1A3B5hk0B7xKCVkPYKoAgFy?=
 =?us-ascii?Q?FLEfiaz4SkJr22hbU/jzhn6Akw2gTj0oKNN6N3ZDn5hBWjwR4IQ7KjLZLp1Z?=
 =?us-ascii?Q?sPst+WOcUWp5s0jyekT6Nq34ad/WHo8yGGsVETR2gcLVqh4XQMufM4Oie9us?=
 =?us-ascii?Q?WLEi1j1Sxlhgg2E08UcMu1jTfJPAwM/RljX4LcvNEuupSq31OGUVV8WLpF0d?=
 =?us-ascii?Q?hodLifEm/sBNoMtX/CjF/y6XlS62hKUVS9ZeF1kIVnkP6xetQbBZ+vYPhfQi?=
 =?us-ascii?Q?RZr5JAsh28MgUxn5WSrPTj5L8YUOvTLtPU8FvvFL1WjOgpgPwWhcsKuB69pn?=
 =?us-ascii?Q?GXbq0qA0ZkjqdXsb49sKwQ7g0O/t7MiwsKjGR7kXJvQU9Rxw7i3NeH0Rj48F?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beff5dc5-5156-4fba-3ea1-08dd6ab27bae
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 09:01:37.1619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vi+OXlW8nsXB6kekdYAg5wI4oY+ZaI/fd1M52MbV14ehywZdTv6LGiuJIKeq+P5EmwAZ9IogmXoYRbrKIkryXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4901
X-Proofpoint-ORIG-GUID: effCVvokM0K7weMpwEn4vGlwTsufM4Up
X-Authority-Analysis: v=2.4 cv=etjfzppX c=1 sm=1 tr=0 ts=67e11f75 cx=c_pps a=clyc6YhGvfCRRXf4btgSWw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=9F5BmnXGMGVVssWPhu8A:9 a=ZXulRonScM0A:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: effCVvokM0K7weMpwEn4vGlwTsufM4Up
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=660 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503240065

v3:
- Patch 1: Unconditionally add 'PCI_REASSIGN_ALL_BUS' and update the comment, as suggested by Mani.
- Patch 2: Add 'Fixes' tag as requested by Mani.

v2:
https://lore.kernel.org/linux-pci/20250311135229.3329381-1-Bo.Sun.CN@windriver.com/

v1:
https://lore.kernel.org/linux-pci/20250117082428.129353-1-Bo.Sun.CN@windriver.com/

Bo Sun (2):
  PCI: Forcefully set the PCI_REASSIGN_ALL_BUS flag for Marvell
    CN96XX/CN10XXX boards
  PCI: of_property: Omit 'bus-range' property if no secondary bus

 drivers/pci/of_property.c |  3 +++
 drivers/pci/quirks.c      | 13 +++++++++++++
 2 files changed, 16 insertions(+)

-- 
2.49.0



Return-Path: <linux-pci+bounces-45207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1834D3B7EF
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 21:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0B4E30050AD
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 20:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE65D2DEA94;
	Mon, 19 Jan 2026 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bEXk+DLe"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010037.outbound.protection.outlook.com [52.101.193.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7900923FC54;
	Mon, 19 Jan 2026 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768853192; cv=fail; b=f+lzz1i7WS1HS9I1HvcpGajNW+YVth3a288kWyBP3sP9KUtNFXzQJkoTRMpAI1XyOq7e/dXxGKM3rio6SAH561NKEBZ3FLKPkClbdS1usrX9eGGCZhk5IiRiHK0PbrITbZpB2uIw8jbTEPjvvNnzaS+pmvYLGyo/HBq5WMI2lYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768853192; c=relaxed/simple;
	bh=0lKfT5F/Z5emCxmBRn8AUieIMnzilKAcK/wmf7Jj834=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sO6uaA73Y9P8SPGii95o1wmYOLTPblQ197JeBe1ZXGyjqFfCz7Yojm63+1rLDB66fafyaASqVLvbC0YTKAvAzgriHV4ZNSyXH6+5tlCBkq7vMKQDvN6gx9AkyFqNWTUqACmZpW7bWfsYCQLCaDDVIKz2ryXDZEiSTjFyWaN7xsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bEXk+DLe; arc=fail smtp.client-ip=52.101.193.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2jaGqPtekO7LBgtslie2eJwrt1DyXf3Av9eEpI5RLjqqs+TT0Fq08qElYUPjGAzM/CYOiGRV8Xum+5JMkJ2OGgD6AbK3xJ0wyfXDsjogbd24l3ckp32AaDlx1iUDlXfN9ME4LnNDCPTEociaNS+MJaKK1rVNg0mVh5kk9t5mVsSsP8pcGCBxxxVQ4rZhl42IpxPrie0EPlfmZLDx1loK2k3hRCMM2dooOtVc8E1HiHX8fJIsFkV8rXPtBe9386+iv/xSChAmzQs6vcglhaLyMVpuYE4aAp+utloKANYXe7qNpA/f3jWyNrti8ZIxnKTzzLBMe1HNVmo0QAwFQCHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmUGiKsumeYPDRR0l7osfilaRutk1kOLjkFCp8LfNFU=;
 b=RN5BatPFtApFvJRvW+NNm+nRZ8JULVtq+7TOJfH7kbAqqiHWDFQoz8Q99SPUz5hDdAgai4LRbvBDn2OYZ/Rm2IonQcOU9o94fDzowkWARwlQ2NQWnkDO2Zpa0NY3Hrb46ncIgddnxLPzU4+pCNIdzPvff6LLQR5tFIp1PcX6AFXEjANnG8uJFUlzEDR+kXS8OZ0svLQiPdpA+a25rUDVOY5j6UW3pqAtcd7xIzksIWEHoxWKL9lmNYNHxMOxum/j0C+1SKqilOYJUl6ZAAXsGECwLOim/riOcvjZRvWEzitJuJI1H9JEig4UiVZzrWATdw1yKR2F0aMs0kkz9jfuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmUGiKsumeYPDRR0l7osfilaRutk1kOLjkFCp8LfNFU=;
 b=bEXk+DLeuUD7nGGFHPnea9nwH85h6VsaN9wxoyP07m99NT/Z9MvBHDOqSj3Cuzl0zOUvr3jat+S2ZmA9lUDgQeHAKpzP5ksgrb193i2yGmazwefjIH4Sjc801WDnymvm6AZYzXDBFY1IkqDGwWU81YuLIInWW2uTLQf3ugfGYdP9vvwr+Vun7+KE0hAGiNkdsBWLefnZggU39zHzyWgt5LzdP/+A+lW5Q3tk6ai4x6xSNeCgX6m5oB4JaBdsYJxagmpB2yjxx3xrqo/edZxM8xZE0SK/zDLIcm6zjYM7thHSHK4sQWx4SgH1fQXsSur0+vXS60drWgLq3qIty+kSLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 20:06:26 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 20:06:26 +0000
Date: Mon, 19 Jan 2026 16:06:25 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
	joro@8bytes.org, praan@google.com, baolu.lu@linux.intel.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH RFCv1 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <20260119200625.GP1134360@nvidia.com>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <09cb6be1f8f7472a2f1ccab72154cc6e22cf570b.1768624181.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09cb6be1f8f7472a2f1ccab72154cc6e22cf570b.1768624181.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL0PR01CA0036.prod.exchangelabs.com (2603:10b6:208:71::49)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 691a0759-b9da-4b72-b047-08de579639ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tYaY8QGr31t1cEwAY7nvwgbIRSA9uoa4HFyv0cGSDEXzHSxQLqJjjm2JHP7t?=
 =?us-ascii?Q?f916+OkQ+NAy0JuzzGyGuitK6MrUlmK27d+dYXExA7faGPp32/0u2EPOVpsB?=
 =?us-ascii?Q?jebr0e+Uj4W60hUtPTOCnIPWH3t7xD8k40BDFsXAqhiDcw8R5ebJkE+uqyis?=
 =?us-ascii?Q?oUrvViuCdfEgdc0d+jNis9oFDZdH1aJ+ms+NX4K4y2m43oGNo4sYUmjN73jz?=
 =?us-ascii?Q?uy67/tuM5o8IyWNoQFwdHC4kCMW8peNB4vh0LmbtcS6OqfKou4BC7q/SlIqu?=
 =?us-ascii?Q?g12HZJyYKBExaOP1aerKJWV2SuUlaVnZOsbkkqwqXotrXbRmN+X9VaHgMnZk?=
 =?us-ascii?Q?zinuUgboo5qpd+TGAnzOXyECoQFE5wkcCr8zY48/LuajeVSSAs8c/T8xi6f5?=
 =?us-ascii?Q?6qHeXByMKQVDqn1mN7vOXUWNmbFFk1hQOHUdAe2a/Pf45GgjSWzgaGQ+4QI0?=
 =?us-ascii?Q?2KwrOmsS1m2ggC0iMLb+fy63gF2epBOTGegyVKn3WQEUPr/4eCLoeKjDNask?=
 =?us-ascii?Q?dnY4wda8TaXpP7oIh2AX7UpGBQw2bNDAAEYbVG73MMCSnQePfthRecK/07jr?=
 =?us-ascii?Q?4vdFVL6YuXUSScCJdIsiOV1fjTDQ0OVrukCShNFwCQOuGy85YxQneLVJ/PY7?=
 =?us-ascii?Q?DNp5Fg4EGXiYWlnjd65Ks73A3n2g1NMYzVkjzgdJ3ekRNfeL5nGxOnyJlLN/?=
 =?us-ascii?Q?a2TLZYbbLgeKyvqm3vuBNU6DZX1pwVenP5pL0pE92EqxsyEvfeK9xAWIjV9B?=
 =?us-ascii?Q?FIUJvT7R/eg5qciXks3ifb0h88uOCsHzkCAO0Fh4PfcthUocpieZR/wSNMCp?=
 =?us-ascii?Q?wYdbZs9qARvWtwBJ8ZosI/mJuuCiSbs+oyiwAR0M16teKJWEVjQog/NktFma?=
 =?us-ascii?Q?UHwdJZ3ZeVnnXGwEuGPtv5whUd73yRAqCy7D/YRK3HeH8EBkVLPlrMzuawJ3?=
 =?us-ascii?Q?Raa/BdlyTXnXkbkZxyqNoFMfr3yItet7Id7/esoVrWajUXfLQKMC0TKhxrXy?=
 =?us-ascii?Q?PVdEMT2ZS0/bpHb9B21iWIwKaSKVxlpeZNWpYkUM3Pa7Mt0ilgtoc/FFKNR7?=
 =?us-ascii?Q?OJV4o3ZGQDA3HKaiyK7qNe/MHIIlWNLBRkuQKBmEVqmAJeS1eCf15kp5L/5T?=
 =?us-ascii?Q?fIPCT9sY1fAeUkTg+pod/26muQuoKfS5izXIz9avnKgr5vVsO+fHujDtAz4v?=
 =?us-ascii?Q?y2qrh9upnGt53humSQC6PAIXY2THs/gCyw4hNhsJjLIxMx8BeUJycXDdMReQ?=
 =?us-ascii?Q?UpocA+hY3fIMkyNC+85CqIIGlVpzi4dz4b2Nzqddz59P73q5iPLoXlu7mlK7?=
 =?us-ascii?Q?DPbHQrbpwVHgeFg3EZ2028lBjebMjnH4E12aPxrClJxgc8nXpfPe0SLo41UH?=
 =?us-ascii?Q?5ho/iuE17LiQr3P8bWlrYumrGpLh0P3koL2osEARxY6j4b0Q7A2taq3Mc8OJ?=
 =?us-ascii?Q?Djgq/dT+2ic2uJeA9OS0Bvu7H3g7mdGOgG2O1w3FdPjQDzoIIc+4h48AcEf7?=
 =?us-ascii?Q?RtGDCrM10sKwpD29f4XuMi5Smnvgn7at4phvwzd25uiT8g93p8K7dF1Cz8Hq?=
 =?us-ascii?Q?FUZokMUfrt+LdMRq/LM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bVLg0UuR463XLZCrT1qh5YFsRQTEyflavrCmGFyydhCVy+w9DkJ/ltbSsppR?=
 =?us-ascii?Q?i8/nLfVyancSERD5qtV5MPvirtlyBvd/fcw634IH8KGCB2FXKBPtfr/xY+XE?=
 =?us-ascii?Q?TDftacnAIexs3DIZTkETMMa0GDLYw2546YO/0/9BTsOuAE5/7ppXiMHE4BEk?=
 =?us-ascii?Q?NxADnf4afdIk2t0V+EmGj+wdYoRMz3Pc6ZNMDEh83QhENRZ3BGCpxmLAPuZx?=
 =?us-ascii?Q?qgd/As8AFErT2ZjFg5rMmmAmt5va6HVt0nE+VBcaxsa34TcM6+QX1ErHlRQk?=
 =?us-ascii?Q?+66ZxmkfNf0Cp5m7KvlDardOeLfTlQjuzt6c9spU7WQ2xdEKR256wEn342Gg?=
 =?us-ascii?Q?GwlXVhUEw8eDnV36NbDxrQvgxp9IDGIN2mhqRvjXHa5SvC8jIQd7oBEdoAjW?=
 =?us-ascii?Q?QW+018kaYrk72BQLhcFOsbKFCkM4S25ZXBzfVSMwc6zwuNgohR0C8usn8jo6?=
 =?us-ascii?Q?GCXjEIfR94kMDQSLfcDh6psCcUqF5aULicgv1ahsnM967okxUI09+Pqr3Y/F?=
 =?us-ascii?Q?rHNn2xkGVtWErjQZ/32k1pRouUSOB/wBeijz2kpHA3bnqTYCo1ElJG++0tfV?=
 =?us-ascii?Q?Jl2mJd4NrnGVuVQH/EuEumSLU5nCZfN4GJ+m3HAR6qZamsicxDdlWPgYpDoV?=
 =?us-ascii?Q?Jd6QJnTUfDY8YtG9VnDo7kvsXKh8c4uVHf769YxXmuM4ZT+liO9QKWyeWIDy?=
 =?us-ascii?Q?OtvOf07X8BRtUu/pg3+3HIpSuwXQQ6WXfAIbFgZlZoMcC/csA2pQhnAPHDFW?=
 =?us-ascii?Q?493mXFYktvkiycLWrRXoK75qPcPspmX6KNESpE4xe2iKZejFyv7NkeIrx93I?=
 =?us-ascii?Q?Rgk8n/g1VQF+7HRLogAxeAD4ZkSlor4mmOT9NjesM1zjjEArimxOOgYcfe95?=
 =?us-ascii?Q?9sEE2yTFqS6AlCeAmiztu16jPgnn6v2fEfsAplHlzeaycQ1xbTdJotm4QHzs?=
 =?us-ascii?Q?/BUHLj8y4Tka84AiyyoiHyhRvbtqs6Jmn9vdGATw8OxzciKAgAyRW/MX5/6t?=
 =?us-ascii?Q?mexEnGvP5ZZTltCU8M2xP8RYurvqDJQjOeyMr8te6Gm9PRDsi/btpQuEI2gT?=
 =?us-ascii?Q?3VJGpHrjHsiOT2u2lSdcwnhGI3hdy6g6B8r8nsHxQnGxmvwg1NNN8HsmzQCY?=
 =?us-ascii?Q?xBv5Ny+V3K5egoAc+DT8gDDP1DXQ0dP8cpo3RWI1EbbfxK+bcwjldicNlhtI?=
 =?us-ascii?Q?v5+4hMoIPW0H1qlqi0bXooqGfX9c+Jx5tQGHKjaanm5HLgDWKljJx0k+yC+y?=
 =?us-ascii?Q?IU/m82lXpoDvAlOxTlTeCvdmpqkLUmwZZlWUQuciqpmqHyx9cG8iKnLXWa6c?=
 =?us-ascii?Q?GQ1dS7g9TJAjHYPOJwLoSe63RAwqC8Mrg3b/u4oswM5aYxea2gnZEsd53Dzq?=
 =?us-ascii?Q?zZb8PMZ5+Ptvlwp50BmDBUIcTMyHpdOI7bMJasZff2407h82V4dVdrXUVcZN?=
 =?us-ascii?Q?F57evSI0rEazi+F1UlBDP0NspIaH7385frNUza/sQ3LDojx6uCHnp1HdLCuT?=
 =?us-ascii?Q?8RfoxwYRkD3fvrBjyjkedjoKxhfyVFKvieQ5pgB1M0gMpTM7uWCQCRnL1o4V?=
 =?us-ascii?Q?9CWr+i3QgSlSbK8lWNSVxbniFcApaaopXMY368Dji34aRTkGIYHXFHdcBAAu?=
 =?us-ascii?Q?VD+EYqTWdDKLkX7WHdWOPDUc4d3ZchBA4P7tGrkSNzLsef1lHuhSSfcjyJj7?=
 =?us-ascii?Q?LJ1HKFiCTc4kpB2YQ3KX/l/Hl1167pmILrTe35jjCxVAf5gUnjTu+h9svDbN?=
 =?us-ascii?Q?DinEPP5mWg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691a0759-b9da-4b72-b047-08de579639ea
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 20:06:26.3014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wCKbX09FcSPxBJnKjmEiTQVtk5WkZngZ//ViL5Pnzjd1l7U6zSzwnbMrdjz4Dh+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174

On Fri, Jan 16, 2026 at 08:56:42PM -0800, Nicolin Chen wrote:
> +static int arm_smmu_master_prepare_ats(struct arm_smmu_master *master)
> +{
> +	bool s1p = master->smmu->features & ARM_SMMU_FEAT_TRANS_S1;
> +	unsigned int stu = __ffs(master->smmu->pgsize_bitmap);
> +	struct pci_dev *pdev = to_pci_dev(master->dev);
> +	int ret;
> +
> +	if (!arm_smmu_ats_supported(master))
> +		return 0;
> +
> +	if (!pci_ats_always_on(pdev))
> +		goto out_prepare;
> +
> +	/*
> +	 * S1DSS is required for ATS to be always on for identity domain cases.
> +	 * However, the S1DSS field is ignored if !IDR0_S1P or !IDR1_SSIDSIZE.
> +	 */
> +	if (!s1p || !master->smmu->ssid_bits) {
> +		dev_info_once(master->dev,
> +			      "SMMU doesn't support ATS to be always on\n");
> +		goto out_prepare;
> +	}

It looks right, IDK if Will would prefer a formal ARM_SMMU_FEAT_S1DSS
though.

Jason


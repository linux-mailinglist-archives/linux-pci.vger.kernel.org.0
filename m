Return-Path: <linux-pci+bounces-37589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DBFBB80D3
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9701B2077C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB48285CB6;
	Fri,  3 Oct 2025 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rddBEDyy"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5512417E0;
	Fri,  3 Oct 2025 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522385; cv=fail; b=tyOYOPQf0Uf8H5Pmew5gI2wi1STXNsA95tUWX7aYNo7M+3tFKemTeEe0rlDLi8n7YY+WhjBPsxvsOAWDgJMV/FEHcvWpWBQJtUBttamCiHf3S7v1E4uwpNWIS0LVt4ErFzLfmaxkwzSvx87meDwQB/v8Ub5PLeIPQSrZ/Dg+miE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522385; c=relaxed/simple;
	bh=R2qcFHdtnqOgg6UX3w/NRX/07onLcgLWOAiZ4Vpej1g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=U3vLN2vo/RJRnzbp8rfvVX/uE6T3g75kfFOiyBwX4ynOC/rqI1E6EKNm4wuZXJUh4GO9gI5v+epwKAI01vkXwUIpha9bHCcZAuvV9YSnZIIKxqN9lsjDCPtDAB2hD9NpI4YGP7d8bKlu/QU5QaQxLLxpZPBQZ0tMzkeSeUIRlKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rddBEDyy; arc=fail smtp.client-ip=52.101.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzXrUkZeggxzxC3G/6upRI8QJ7eVolqavMXsHN+KqsTIfCay2yNjULtH7kKlmH4Xg2MavwNGLQ/12XNvDkplaIXryDOrykfXX90VsQHzOcXCHR/YPxXJ3gUX8UYI3zbvtgBOnZr1aFo3cH5jK9Pg4X5WfMdi/1b3YF1rDwSafDaTC5YHuWXKNEuythBsNvwIA8z66+zqsVAaUf4Ak62KCmUyG5C7EJZoHkACrKe2beTe3CBFgF5wFMfgYNJk6+oU3dk7K9o2czF1Am8P2Dm5nGLcYhoynpqCKL4tR7kLoPB/gCi5CecIk6DMEHtUc6Lg3GxNiwuIZncF4SW6tOE7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ednOycrJvr31ZtNus36kPuF+6RBVvqSqOyjL5QtwaTA=;
 b=fA6gukptC84lhV6L1lqVxDyMLxCxQe9xgTwxbsqcNWULR0UwhkIbHRxuLJaHfRBm6MeKXVoucSO1cV5zxbP0oBV5jHiUh5cmkPpY/gxtVvPrKnpE1fYI66OVqwK0CjCQ5wiCxuSW8+NrK37PHYOK6pJFW/8K3sijE6Eyl5DCapE6o0djGUKGfDxWXn+JYduAa1FIJtiP5yno8dblaPRRiCh4vS/6hk6e/rTkNrl4STfFO6rmKQ5AA7PU1iu5jjCfs/hctZ1fybss0RHtwpbVGFGEV9pQDJblYpLAiApittVbGiNQBAQtmWDcIG53niEvbNNUG3q3N4D3TjbYETe/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ednOycrJvr31ZtNus36kPuF+6RBVvqSqOyjL5QtwaTA=;
 b=rddBEDyygUGP6teqVo8lo6vaddxBvz6q9qJeFEl7SH89xluZeBtn/id+DuplfCiXU5W15KL04jMp1PBOP5Ccxb96zS0U4wJ6M57RzqDTEdUIq5Ine9edaviU41Q6qhzpoZA9m8NOZgwWIV+BAD+k8J6bJQXusvwGto/CU/fkJBs=
Received: from DSZP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::17) by
 BN7PPF62A0C9A68.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 3 Oct
 2025 20:12:52 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::51) by DSZP220CA0011.outlook.office365.com
 (2603:10b6:5:280::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.16 via Frontend Transport; Fri,
 3 Oct 2025 20:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:12:51 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:12:36 -0700
Message-ID: <6dfabc9f-4244-4f8f-9bff-434b5758cd4a@amd.com>
Date: Fri, 3 Oct 2025 15:12:30 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 18/25] CXL/AER: Introduce aer_cxl_vh.c in AER driver
 for forwarding CXL errors
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-19-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20250925223440.3539069-19-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|BN7PPF62A0C9A68:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a94c49-4058-4f51-e3ef-08de02b93b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2FSTW1aRkF6OXJZQVhaSDd4blY4NVNRdTNWMEVwVTF0NFRYVE9GcjRhaDJQ?=
 =?utf-8?B?QjNLZnFRZXRDQmNKT05iMzVrNWNycmg5UitYQXZaVFllL2JKbzJTMjhwZy9X?=
 =?utf-8?B?a084dXUzWjNJSVhOZHZhd3p3Zk5SWVB2d1d3ZDFHWTd5QW0rWXdxcktJLzlp?=
 =?utf-8?B?ck9vWmtmZm5ZcWtObGN6cjgvYmdaUTFteHRNWm1sY2dWaC9EelE2VGpNU2hm?=
 =?utf-8?B?SnNuUERHbDFOU1V5bGc0OFNGVTRYVTF3SlZDYThNNlltcjZTZTlJY3hvYkV1?=
 =?utf-8?B?WTc1eit1a3R5VC9mbW5Nb0sya1ZsTDlkbUprSUptckJySHB3TTFMeml3bDRP?=
 =?utf-8?B?YllUWWxqUm5Oa0V0ZG40SlRueEZ2NHNYV0tsTXZMdzJldExMNTFkQ1NUdVIz?=
 =?utf-8?B?c0VPanZPUEhGZFhUeFFnVmVPTVNXOXhpSUt1ajFHL3Q0NS9uVHZsTDlOYkIx?=
 =?utf-8?B?ZnRaNlRyRk1ibUdvUmxDQmlZU3NCNVJKTFllNVNSaThrc3FtZkZ1L05PRWQ3?=
 =?utf-8?B?UTJReFRKdTRZUmphOS81TDBjazg2VW5SZmthc0JPOVFyQm1ZSm1BNElGWEh3?=
 =?utf-8?B?Z0NlSi94ZDUzdlJnVTlsUXJ3MVRad2lrWFpjSXEzQ203NWtsNXM1OFJrSC83?=
 =?utf-8?B?T0dxRDdwYkg3c2JWYkJrQ3l0K2EzbnpDWkszOUc5YTY1VjF6QXpJOXNhRHhU?=
 =?utf-8?B?YXBkU3JLSEFEeTNFOWFOeHFVY1h6VnUrUTJYSnZGZ1JNR1ZzZm90ZkVoNXJB?=
 =?utf-8?B?UFV0dHR1bXNLTDV0OGt2eU9lMkNKeUkwdlFxWW1TMjZFR3ZmVC8wVC9jUzVt?=
 =?utf-8?B?allESk9WZjFUbStSY2ZTWDNHKzU1S2NTSzd4dURjVHlCQk84L1g4UDNqYWxq?=
 =?utf-8?B?eTh6eVdFSlBUR1JsaGhodzJZcFFCNUY3RlI3dkRvd01zT21VeGh4T3dmQU1W?=
 =?utf-8?B?OUZkWXVmUmNvUmZDOUsxT09JcGZTbGNwb2g4azI3UzlTdDA2Q1RVam9FT1c5?=
 =?utf-8?B?bFA0N2JGajV1bHZ4S3FlVFcvRlFhZ09vQkVaam95Zmg2b3lGSWxWOU9sSExm?=
 =?utf-8?B?OStBeUxwMkFIMFpuaTEzMUVBSk54cmpTb3RGUWQzMytXeHlTQ2VXdFo1TXox?=
 =?utf-8?B?Y0h5S2xPaG5NUHNHNUV6NUIxa2RVN0M0eXVyZnpYV2ZpdDFmRFRZV2wyc2Fj?=
 =?utf-8?B?YzI1anJaa2x2Y2FPbStuWEwxSE85aXhDNDNyQUNER0c4S3cvdmJUTTkzL2k4?=
 =?utf-8?B?b2pmKzEyenJ2L0RReGhrZXpEdS83MmJkd2w2MUtKalgzcmtLb0ZYWXlkWDBq?=
 =?utf-8?B?ZmJiSEJJWHFQWHN0TG40NWpnUmtZWmJ6MEtGWkp0RDhwWGZNbzQ1ZmxoUWpn?=
 =?utf-8?B?UEhTUHVUWXl3S2QwUmVUdXYvUnFOaVUxTTl2djJiZHFRd2NkRWF1bVU1Mmto?=
 =?utf-8?B?NHVUN25IcFlINjcyeXJLQzVhWkFCUlVna0xWN2Vka3MzUmk4UjNlUTdsY1F3?=
 =?utf-8?B?TUVtYTJCMVl3a3hUT1poRG9qVHNxVDNrQlVmWDBNUXBKbDNvSUNzVHlhRGZK?=
 =?utf-8?B?RHBGeTdLRDE4MkgwaHpwdzJKNVFlQW5PbjREZmU1YkNmanBWQjR3UXpyeXZ0?=
 =?utf-8?B?ajZVUkVGalNTV0hlTkhRV01SSzN0cFRTUXBNRjJkeXJocWtQMVhaWVRITGxq?=
 =?utf-8?B?bUJkSm9mRmVwSll2V21kc1VQU3VrVUtzT29RbFBRTFQvdDhrZHFwYytRNjZV?=
 =?utf-8?B?ejZCcGJXR01ybEV0cnA5Z3R0ckNySHFtODhxbiswaFN6RCtCbDA0czhXNisz?=
 =?utf-8?B?U1YweUpVdmF1ZExUczB4bWNvdWh3RktFZXhHa2NlaVY5Tk1jNG90M3pSa1Zh?=
 =?utf-8?B?MGE4aExTMjh3aU9GcFpsbnZveldXNzE3MnFlRnVlUitYVDllelZvQ0xMRm5U?=
 =?utf-8?B?UUJmNlJzbEVCUGxZS3YrcXFNTFVTNkphVHdDaXova09zQUx4RHFRellySEFR?=
 =?utf-8?B?TTBrWkh4RXdtd04wNkovTEF1WTFLVnRVaGd4ZFkrK0luMjZpVzdDNUMzcUh1?=
 =?utf-8?B?eFJnc1Ryb05QUlByZTNmTi95QU1XWVYrR2RMOFNaYXQ5engvMHBkaXc2T0d4?=
 =?utf-8?Q?jL8M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:12:51.4551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a94c49-4058-4f51-e3ef-08de02b93b00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF62A0C9A68

[snip]

> +
> +void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	struct cxl_proto_err_work_data wd = (struct cxl_proto_err_work_data) {
> +		.severity = info->severity,
> +		.pdev = pdev
> +	};
> +
> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rw_sema);
> +
> +	if (!cxl_proto_err_kfifo.work) {
> +		dev_warn_once(&pdev->dev, "CXL driver is not registered for kfifo");

I don't think this is a very useful error message to an end user. Maybe something like
"CXL driver is not registered for error forwarding" instead?

> +		return;
> +	}
> +
> +	if (!kfifo_put(&cxl_proto_err_kfifo.fifo, wd)) {
> +		dev_err_ratelimited(&pdev->dev, "CXL kfifo overflow\n");

Less sure about this one, since it's an actual error with the kfifo. May want to mention
it's the CXL AER kfifo just in case another kfifo comes along in the CXL driver.

> +		return;
> +	}
> +
> +	schedule_work(cxl_proto_err_kfifo.work);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_forward_error, "CXL");
> +
> +void cxl_register_proto_err_work(struct work_struct *work)
> +{
> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rw_sema);
> +	cxl_proto_err_kfifo.work = work;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");
> +
> +void cxl_unregister_proto_err_work(void)
> +{
> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rw_sema);
> +	cxl_proto_err_kfifo.work = NULL;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_proto_err_work, "CXL");
> +
> +int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd)
> +{
> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rw_sema);
> +	return kfifo_get(&cxl_proto_err_kfifo.fifo, wd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_proto_err_kfifo_get, "CXL");
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 2ef820563996..6b2c87d1b5b6 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -10,6 +10,7 @@
>  
>  #include <linux/errno.h>
>  #include <linux/types.h>
> +#include <linux/workqueue_types.h>
>  
>  #define AER_NONFATAL			0
>  #define AER_FATAL			1
> @@ -53,6 +54,16 @@ struct aer_capability_regs {
>  	u16 uncor_err_source;
>  };
>  
> +/**
> + * struct cxl_proto_err_work_data - Error information used in CXL error handling
> + * @severity: AER severity
> + * @pdev: PCI device detecting the error
> + */
> +struct cxl_proto_err_work_data {
> +	int severity;
> +	struct pci_dev *pdev;
> +};
> +
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> @@ -68,8 +79,14 @@ static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>  
>  #ifdef CONFIG_CXL_RAS
>  bool cxl_error_is_native(struct pci_dev *dev);
> +int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd);
> +void cxl_register_proto_err_work(struct work_struct *work);
> +void cxl_unregister_proto_err_work(void);
>  #else
>  static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
> +static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
> +static inline void cxl_register_proto_err_work(struct work_struct *work) { }
> +static inline void cxl_unregister_proto_err_work(void) { }
>  #endif
>  
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,

Feels weird to add all this plumbing and then it goes unused. Assuming it's not a heavy lift,
I would like to see at the CXL driver register stubs at least.



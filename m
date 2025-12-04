Return-Path: <linux-pci+bounces-42650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06896CA5143
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 20:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF992307E363
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 19:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8494347BC3;
	Thu,  4 Dec 2025 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zBsxKUAq"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013049.outbound.protection.outlook.com [40.107.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCE3491D6;
	Thu,  4 Dec 2025 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875403; cv=fail; b=tQB7cNRI7SCaMOJkXU4bPYUjK9kx6R4OPYkAeBB+ulOQmJaSJdAprY5+a2Jaf3o+CVwQPWij1YDoxj6IzkZfbW1+luPVdhQ8B7mFVEUDKbTi4qWV5a6xAjMqvBvLAJpaU06KLsf6gd5Y+I76ybejYztL+V3+s4wDR1W0XDs08pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875403; c=relaxed/simple;
	bh=7axp6Hdv51/Z3Cf9vMAe4RFbELq9M1rQ632JGekGBZ4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=MHlkgMekLZ19Wv1mKi0tOpwU6rlDrkFLlkWaHl/dCy1Yd8lTC+a+6sJxO200EYD1XsVP5AEvw61UG24GhZUX7WP3gWnYRV2UpE9ctPeDtaUNOvO/BWd4XH2Bj7iCLpUd3ojuzRRSQLP/pMqQTIvB7ZAFFl+gnI+DKY8s5GD8oDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zBsxKUAq; arc=fail smtp.client-ip=40.107.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDSxqS6VUF4T+Ki7tU9qiK7v/G5SQ5wXhdxCGYq+KJoaPepBhWWPCZkVvW1CDNXWHglahztmF5ABPOYCuDFLtGP1lW6f3mYGhu3jk3/zv6WDirFffq3feCzQLOzp8FCecq8t3QamypEfmlFNlP8uNxRdAwoTZ1LveIvQS69HKMqins0Kbl+MUtcWcumkhnGobXKljBtfN5Xf7ifkorrrLx71wh+RqvDFA6wx8OwYeHaOsJNp5v6FMAEk+gHBHUsVaGNRRfxo0JsJhJFMEh04xdn0YIfT/kOjoWGtizkl/V2knEZbEcyUiAb2lCcoMZJy9iSZvHPnMxMaszymDrJAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1nLtNMbDjGoLZ65vrcSAFRKgm6F3oyT+Wv0tYtE96Q=;
 b=NhdPUiELGZiJn8iNFamYxntQwkBSdeDEijARZHCVyzypL5GlRip1mMUVBnre+efO/6iRcKT1U6EyrRCWjE5OzjhiQJZhO4DgAgu8AyLHx6EvfXQB/YmxvdJ5kiXXpK7hBKTVSM/f+FVOhYPs7wIbPqq99AwDeoIPZncw4ULfryNDnbCWpVGHZEvDlEr/yUJ4m9uHtj3bAzB+mpWrabLvlEyV6DqtrJmjc7GLXPbUqAOKmInQE8YCaj76l/2/8Oj8kNf3/X9+KAWtvPJE0O8bKI/B4RDHncrfsVRvsP2jBNk/Y0JZN/OBS8ChMz4OACfcPA02yWwL2s6qTGfWkVF1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1nLtNMbDjGoLZ65vrcSAFRKgm6F3oyT+Wv0tYtE96Q=;
 b=zBsxKUAqRN67CNPJxEU2RgPJr0iXwztQRxXepkW9QeTqE8w+TqO25WZxGsSxH3sT3KycNPxRrlVeaeku1pZxkri6BpCiy2hhZ9ki0JbD2O6C9u+v17+R7sYm+8gTXHT4zwjD5s6SZsPAMds6RAbHxUwmVT5GAHk5xzzPjVpScLI=
Received: from CH5P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::17)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 19:09:56 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::6f) by CH5P222CA0008.outlook.office365.com
 (2603:10b6:610:1ee::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Thu, 4
 Dec 2025 19:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 19:09:56 +0000
Received: from [10.236.179.173] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 4 Dec
 2025 13:09:55 -0600
Message-ID: <4e4e19e2-8aff-44a1-ba4d-2a4519745a3d@amd.com>
Date: Thu, 4 Dec 2025 13:09:54 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 4/6] cxl/mem: Convert devm_cxl_add_memdev() to
 scope-based-cleanup
To: Dan Williams <dan.j.williams@intel.com>, <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <alison.schofield@intel.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Alejandro Lucero
	<alucerop@amd.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-5-dan.j.williams@intel.com>
Content-Language: en-US
In-Reply-To: <20251204022136.2573521-5-dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e78932-9b4d-4fee-cfca-08de3368b658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a085WmJNN25GMmNyQkZWOEtrVytIKzBacWVGb1JldVg2NTdjMkV6OWFkYllE?=
 =?utf-8?B?OEVVRngwK2dFZVRGbHlNRWZXcmoxZi9iZlBEcm9yVDZBYkRnWWhwWVdKaE44?=
 =?utf-8?B?NHJOblJHNnpUYVJkc2pPNW0zL0hZRXg2VmwxZkorWXh6bk9IdktiQVROM1ow?=
 =?utf-8?B?bGF1MnBqVFRCSGlSSy9DTVFhTDdkbmFid05uRkV5dUZCeXJXMmFRWGNDczl1?=
 =?utf-8?B?ZnVpaFJ0MHozU1A1aVNZZnZqdGpoOUVFRFEzVUVQMUpDSVVrNkRIbE4vV0M4?=
 =?utf-8?B?ajNrbzJ4bVNXZzNvTlorVko5UjhCSTR4cXMxaDlLVExsTzZDdWNlOStxZm5V?=
 =?utf-8?B?NmtLdHVZcTR1a0UzYVlnakpKZUdyS3h6bjduRTVVU0VhNk9LRmlyNDVOdlR5?=
 =?utf-8?B?K09qcnNyK0I2TkhiVWJ0WVFabXU2WDdIZk9LQWJOYW9PNzRJVWxBVmkrcThk?=
 =?utf-8?B?M3ZZOWFNTlNzWHhZbldBZWg2NGJ4clFYMU5ERHQ3L2NJYjlsSWpEWWRXYlow?=
 =?utf-8?B?RFZGL09XZGw5R250dDlzc3lLU2hzWlRHbzA4cjJzM2ROdmFiaEZRQnlUb3ZG?=
 =?utf-8?B?Q2orYWhzYWdiMSt5czdKOVlCZk9JNnZLa0NmNm81V1dNL0dqU1VzUjVyZW9q?=
 =?utf-8?B?VmRINmRiMXhUU09wU1M5Mjh5Sms1VkV2RGN2cmJNU1pKOVlaenhoelR6bnln?=
 =?utf-8?B?T1Z4b0FsUUkxU01STnE4SFI1VUxHZytNR212VkJ1SlR4U2k2a2lGVHpnWXlV?=
 =?utf-8?B?OFBjNlFQQVNsN28reGJaTTRBaS9TeiswTU5YdDRmMkFraUIrYXhZYWZMekpK?=
 =?utf-8?B?Qkx0WU9lMlJscHJKYlQrVTF4YVRmOHN3Ri9mMUE2OXlCOWI4MlhoZFZ1VmFV?=
 =?utf-8?B?dVZsNjRHTnoyYXhEZGpKSFkrU2tSa25FcyttUk5BSHJXSUQ5SFcrMmpJaCt6?=
 =?utf-8?B?b2JCTUdSK0dFZXlVeXlwbmw4OVdhS2RmUDh4bkhCQTQ2dFZmaW1ZMyt0NWNx?=
 =?utf-8?B?WWFDZXZhYVozTldYWWJiV0tzYkJTeGFJZWVGSkk2ODdJZWwzK052UGNQSUtS?=
 =?utf-8?B?bXQxRXJ1cDB0eXgrZ2dianJrWGQ5Y0U2ait2NWRWOFRISThabnZ1VG95SHlI?=
 =?utf-8?B?bkx3UkFzYldYOEdWeDdtTVVLM1lZZmxKeDRSbXVualN5bDEyYlNLZDE3dXVT?=
 =?utf-8?B?cnVSb2Y3VWdSam1odThOM2FTa2RBdE4xRFF2SW9RK1hOU2ZHS041K1c1c3FD?=
 =?utf-8?B?S2trbFhHUWdmTmJkbXFqRlVwUzZYb3JhQmhnOWNKSkN4N1J2VUhQbkxMZHFL?=
 =?utf-8?B?bmlab3phYWcvZkFjNzVvSWNPYk9YdmZkNm90Z0g4L1FQcDNnaHhMMlFNVGNK?=
 =?utf-8?B?S3k0d0h2N2Y3QnBMdEhMRlM3d05qK1U5Zml4ajY3Rm04dGQ1RGtlcU5IVlBS?=
 =?utf-8?B?cnd6cUlyazNrZEp1alFOZ1FDQ09wTHptTnZ3a0tOWnl2dTJ0YjIzM2kvcllD?=
 =?utf-8?B?L0VjaVZQSU9LYlA3azdZTmNrUldLVnBCZ0p0bGRwRzNOMExpcy9RQXdPazAw?=
 =?utf-8?B?Ty9mZ3lGbHNYb1kyR2duWFBCMGNaL2oyVjM2L09USWZiRWlQbGZaand6UGlw?=
 =?utf-8?B?YmxTNk5Jb2x1RVRIMmp0MG5kYWdPeHVRc0hwWmNQNEpldEY1SyswNG1hRWE4?=
 =?utf-8?B?cmhlYmpkelh1cnVzZllmQ0FVdGovOWhrQjZVZFNXamtqNVVtSXNmeGx2a2Fv?=
 =?utf-8?B?Wmlqc3p2T2RUR1V0eEhOTWxsWFkxZG5KZFFJQXMyTTJEMlpwN0IrSElsbTFZ?=
 =?utf-8?B?SDU2OStaYThFM2hNV0RTOWlBRkZ0SjcxQzNjNnRoYzByRTFKcVRzNDNybUNl?=
 =?utf-8?B?dXROaC9PdzJBWkhaY0lrZzRmY01abEFtR3NCMDl4Ry8ycWFvUWo0K1p5K2Rt?=
 =?utf-8?B?dUxoSFVXbmZ0MmllTEFGNWhlUWdMTmZrSlgzV3RvK3RUb2JRQ1dpdlQ3dG96?=
 =?utf-8?B?MGJseGVEUkZaajliR3liLzN6WGkxR1lLQ3R3VHdrZitrZnY4NVBRUTI2MnZz?=
 =?utf-8?B?MjQzRHA2TzFTNE9mdS9jSEl2WVpaVlJSbk5YL2VCcHUwVEphSTVxczJ4VENQ?=
 =?utf-8?Q?pqQU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 19:09:56.1466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e78932-9b4d-4fee-cfca-08de3368b658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364

[snip]

> +}
> +
> +DEFINE_FREE(put_cxlmd, struct cxl_memdev *,
> +	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev);)
> +
>  /*
>   * Core helper for devm_cxl_add_memdev() that wants to both create a device and
>   * assert to the caller that upon return cxl_mem::probe() has been invoked.
> @@ -1057,45 +1084,28 @@ static const struct file_operations cxl_memdev_fops = {
>  struct cxl_memdev *__devm_cxl_add_memdev(struct device *host,
>  					 struct cxl_dev_state *cxlds)
>  {
> -	struct cxl_memdev *cxlmd;
>  	struct device *dev;
> -	struct cdev *cdev;
>  	int rc;
>  
> -	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
> +	struct cxl_memdev *cxlmd __free(put_cxlmd) =
> +		cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
>  	if (IS_ERR(cxlmd))
>  		return cxlmd;
>  
>  	dev = &cxlmd->dev;
>  	rc = dev_set_name(dev, "mem%d", cxlmd->id);
>  	if (rc)
> -		goto err;
> -
> -	/*
> -	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
> -	 * needed as this is ordered with cdev_add() publishing the device.
> -	 */
> -	cxlmd->cxlds = cxlds;
> -	cxlds->cxlmd = cxlmd;
> +		return ERR_PTR(rc);
>  
> -	cdev = &cxlmd->cdev;
> -	rc = cdev_device_add(cdev, dev);
> +	rc = cxlmd_add(cxlmd, cxlds);
>  	if (rc)
> -		goto err;
> +		return ERR_PTR(rc);
>  
> -	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
> +	rc = devm_add_action_or_reset(host, cxl_memdev_unregister,
> +				      no_free_ptr(cxlmd));
>  	if (rc)
>  		return ERR_PTR(rc);
>  	return cxlmd;

Isn't cxlmd zeroed out by no_free_ptr() above? I think what needs to happen here is:

	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
	if (rc) {
		no_free_ptr(cxlmd);
		return ERR_PTR(rc);
	}

	return_ptr(cxlmd);

Looking ahead, this gets nullified in patch 6/6 so I guess it's only an issue if
someone is in the middle of a bisect (or doesn't pick up patch 6/6 for some reason).

> -
> -err:
> -	/*
> -	 * The cdev was briefly live, shutdown any ioctl operations that
> -	 * saw that state.
> -	 */
> -	cxl_memdev_shutdown(dev);
> -	put_device(dev);
> -	return ERR_PTR(rc);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(__devm_cxl_add_memdev, "cxl_mem");
>  



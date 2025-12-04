Return-Path: <linux-pci+bounces-42652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F230ACA514C
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 20:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8541030AF7FF
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 19:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F143491DE;
	Thu,  4 Dec 2025 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zj7o7gqR"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FC3349AFC;
	Thu,  4 Dec 2025 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875413; cv=fail; b=H0HAiXGAnaFWgglnFwYAsPxR6xL5sURlYaKRCKE3aDsVXvqU36sLnHqemve2bCyMzkvCU0343A5PPNbPhP5Hjzjy1OyRi2qZMBIAVEDYjULFJA7IlybSPN9eSR4gIUzqsaMMRRRC4b8BsWpOln+3yjp4frNgkTcRjRSnmaTxSd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875413; c=relaxed/simple;
	bh=T639KobItHOcQ2O9yHCr81M09ty63GO7azUTsa9Inpo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=i2BR/gyeoN04bnar9eA2N61AaAf3U/WbnLntzy6lYk8BwJvo46G4CWXU65w09KIwNE/p8vUFXyq+/nP56t+6+OxG/SnLRclZR2XphIeK0b5l5fowiMn7R5vuU5Nwi04/oCNECMpRfLRvzDKPtY3ELhqA5bH5FBQNGZVp6NBNGtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zj7o7gqR; arc=fail smtp.client-ip=52.101.52.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTBuuKEeYRKdcQR+atj0LfsWQ2sx5KOMr+MOiSA5yQlJcqFszaooUGz/oEVhewyZnjSp8aqWFZR21lMwqTXrbZ0DQ7o/KZgGIjI2DLwfPU6zL8sK8i0Y8iHD2ucvubveC7u/6nHQzfAmnmbxrN2uZ+x+St1Amztb5RQfm7Ek3XTICrfUG3gMH28d0YVfl5/gjDjt3WSX1xVAyZwdSleT53zFFM42tz2OtiDniHwbKDeswCBN3izbBb2KmiE9YCT9F7QH8A2K4pPPtxwIOaAEJiICrZo8IIspFFTKxs2KjL3PJwhB4bV9iibryig1nynjd+qKCtjjemI7X5OBHEoWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWzAAKyWYWmbz2eH0B1YWmAfgDg9lcncFiJuBA4uhkw=;
 b=lRyKfB36R1xgPQdYg5zrp7RJvHAmbncTB3IbccPPzo2Iyb6ACeK3Q0lNvyDJmmL+lvm6xOBxm4eZCClPR1DbL/EVUot59jze7UKxra4W74Jr1QuWb8V600e06hr4XANgJm3RVVuFxuxcDvT2oqulA7S0Q0Mv8x+sLKjsfCiRBfRN9efy879HyJOxGWoxJC9sKNWhQ0BlbdXHwy0kYqpuXkdB2Lhb/5LpNQjmE3prx5AfKwzQxXUJRc8K0B5twF2g1x09s8TIZ7TdriG7Jzy4QBEdG0grPMcAF2J0Wq2egqnKUVuMlYEFaDSk0gzPkHXX/vq2sl68rod2XIkt2pFpJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWzAAKyWYWmbz2eH0B1YWmAfgDg9lcncFiJuBA4uhkw=;
 b=zj7o7gqRJGXRYKYheLlIhe/GfaZaKwgi4f4k6HF9KiEz/zX+SjN3cDiUUUPrtxRDJ+qQubeRb+sHjTCmDhTUJsx8MQosf7xDz+3ACgb/E2/sUOdft5J6ApuLO/8SPQbZgwV+3x3sUbFvbdslX6QdR2LrJDmHBob0NO8JpGe7V7M=
Received: from CH5P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::29)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 19:10:07 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::da) by CH5P223CA0008.outlook.office365.com
 (2603:10b6:610:1f3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Thu, 4
 Dec 2025 19:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 19:10:07 +0000
Received: from [10.236.179.173] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 4 Dec
 2025 13:10:05 -0600
Message-ID: <03ec6e1f-bb7d-42e2-a887-70c18dbf4749@amd.com>
Date: Thu, 4 Dec 2025 13:10:05 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 6/6] cxl/mem: Introduce a memdev creation ->probe()
 operation
To: Dan Williams <dan.j.williams@intel.com>, <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <alison.schofield@intel.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Alejandro Lucero
	<alucerop@amd.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-7-dan.j.williams@intel.com>
Content-Language: en-US
In-Reply-To: <20251204022136.2573521-7-dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 1961e072-d8ee-40ba-1f1c-08de3368bd0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDZOLzZYUkZZdHFuUVJJdWFkMFA1RGxKYlEzVWJLVFFTQnNJaG1SV3J4c3Vp?=
 =?utf-8?B?VlRoZm5LUk5lZWNXYWNRU0Job3ZvZDE2ZHdHeTNlWXEwQUNrNUo0N1ROYlBB?=
 =?utf-8?B?ZU9paWZVSWxERDJTaTVjTGVZbkVPTTFvNGVnS3lySXFlQnVlbEJiQVN3STFW?=
 =?utf-8?B?b2hmV0doeklvekVCNEU0YWU1RWhJTWI1R0w2bWNocnhmWE1wdS8zb3lwcnJH?=
 =?utf-8?B?bEVYVVdFR1hpZ3I0L2ZkMnZrdmhkR3RFMldXcnpuY21TTW96OGZuRDNZZTlt?=
 =?utf-8?B?aEl2QllJVUtnQjU1V0VZK01EZUNkeFB0aTBKaEkxZmdnQkd1OU0wY29sK0Yz?=
 =?utf-8?B?ZE0wQXBZWFlqUmhlcndHRzYvSlJ4MUNWaHZKSlBSNVRkRDNQenVDZkhXS1Uy?=
 =?utf-8?B?c0NKdVFHVzB6ZGQweDJFYTRiL1pqN2xLZ3ROWS9IQXRTK1pUeFRJRVl0VDdl?=
 =?utf-8?B?L3Y0bDNYZWkwdE5kenh2YzZOWFhmTjlYNXFDcDZ3QnNoMUlZMjFDUWVKS2xD?=
 =?utf-8?B?VXVzSHNqQXdzdElhTHQxaG82WG9nUElEclFGZUh6RExxZ3MzckxZa3BzZ1cx?=
 =?utf-8?B?SnBZTjByTGxFemFWZU9kR2t0RW9ZeWw1Um5RSU1FT3RxOFRjMzN3eDFRVHRt?=
 =?utf-8?B?TmR1VzljeVBMYm1mem9LbEZ3TFJ6aUlneG81RmV5RDI0UXVPSWFDUi9UdW9C?=
 =?utf-8?B?L2hlK0JTS3kvQStJbHE1RmxBcmFiZ2JoRzVDSi93aEt2d0ZUU2hPU2Z1QUV1?=
 =?utf-8?B?aVBSSmN6WmUvQVlud1pmSnNhVkQyV1o0bDJrblR4dklnSUEzdGx5dHQ3SjUy?=
 =?utf-8?B?RmgyT1JjZWxSWjQ5TndIOTQxdXVoSHRMcStKTVcyaGdCSDRQL0VsN1A4MnJv?=
 =?utf-8?B?OG54c2pjY0ljM3M0UUJ4WFpZWjFza3JFbU1GVWtGQWs4WlQ5RUgvT05PQVI5?=
 =?utf-8?B?TVVaR2hEM3BFRG9aeFVJYjB6VHBxZ0czaWFRS2lpT21Wb20zSE9nZGZDa0FN?=
 =?utf-8?B?M0dTdFNod283ZVR4YW0zQThSRGhQMUE0bzNQNDE5NDJsV1Jadk5aUzZPWlB6?=
 =?utf-8?B?dVVSaCtSRC9zWjliZXpZbDltejV3bHQxb25mSC96dHNTVDdCUElpYnRaK1N3?=
 =?utf-8?B?NTZLc0lobVpLNmh3SzZQZmlkT0Z2d0Y5UnVCc05iTCtMZjZQWWZNMng5TURt?=
 =?utf-8?B?Y2xwT3FYbFl2STRzSnZzLzJCbVF3NWx1RWd2VEliRFJzK1VzRG1zc1hnNFZ4?=
 =?utf-8?B?Vlo2cFpnQitGbHVtR0gvVmFYVWJoNXVxRGdDQW8xYXlrSzNjcE1rYnhYR0Jm?=
 =?utf-8?B?Q0JPWmcvQ0RKSjloWWNuU1h4Z2NnV2lhS3pKNS9WL2tyTE5LeDJTTkl2ZDJz?=
 =?utf-8?B?aTVwM1VNbTVkZVNoYlN2VFBBZVRoNjcrMUN2NXJGVkJTdzVyb2RpS2MrOWNH?=
 =?utf-8?B?bUlCOUpiTERkcVdXRnFUd3hUci8xYnN0VDJ3amJYZ0d2d3RSalRJSmgxYjJr?=
 =?utf-8?B?a3dlS1dMVGlweU16M1Q3NFRMTlpZQUJyTkFSTFo3WGFIaXF5U3djVUhTV2xM?=
 =?utf-8?B?b050R0ZCT2k1bDJFcXVQSmF3K3JBRW1mOHlHcENEMkNESjNUR09YQ05ITnk5?=
 =?utf-8?B?RlVqT1NQMHlQa3g3aGZ5RnZmMUhsd2I2ajZjUVFraTl4QVBzT2FTRllMVUtW?=
 =?utf-8?B?ckFZcjNyZjgrOXhNNzY2WnJsSHRTNERHaG1VeGpnK3B2L2Q0QmhRZlc2ZFdo?=
 =?utf-8?B?UlRjWEc5SmFaNC92ZVI5RFlOc0p6aVkxWVJ4U0FETGVKKy9pbk90NnBQZDFr?=
 =?utf-8?B?d1dIVGdMWkpyVW54MW9GdUNOY2ppSXZCa09NdGhkZU5ENEIxVS9rVlVrNTdl?=
 =?utf-8?B?RDdYSzhHRER3SGNJWlJQaWFGMnFNQytaMDlZTEQ1QW1qSEFQZ0krN01YWnd6?=
 =?utf-8?B?Tlh3dkI2MzFPYVQ4VHQ1YThTNlM1WTFrempZS3VVdzBXZHZzeDBtUlN0OE5T?=
 =?utf-8?B?SWNUcHpRblZaZTN1QnBTeThRaFRQbldmOTJvZHdPZnZ0ZXBmWmJHNWd5RkFH?=
 =?utf-8?B?aXZ1RnA0SXNVNnRPUDF6ZkhSWTk1dUJIY2xMNk84WXF5bVc3dFdKZ25jUURI?=
 =?utf-8?Q?83OY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 19:10:07.3816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1961e072-d8ee-40ba-1f1c-08de3368bd0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250

[snip]

> +static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_memdev *ret = cxlmd;
> +	int rc;
> +
> +	/*
> +	 * If ops is provided fail if the driver is not attached upon
> +	 * return. The ->endpoint ERR_PTR may have a more precise error
> +	 * code to convey. Note that failure here could be the result of
> +	 * a race to teardown the CXL port topology. I.e.
> +	 * cxl_mem_probe() could have succeeded and then cxl_mem unbound
> +	 * before the lock is acquired.
> +	 */
> +	guard(device)(&cxlmd->dev);
> +	if (cxlmd->ops && !cxlmd->dev.driver) {
> +		ret = ERR_PTR(-ENXIO);
> +		if (IS_ERR(cxlmd->endpoint))
> +			ret = ERR_CAST(cxlmd->endpoint);
> +		cxl_memdev_unregister(cxlmd);
> +		return ret;
> +	}

Two minor gripes here:

1. The cxlmd->endpoint portion of this is unused. I think the idea is since this is prep work for
Alejandro's set to just put in here, but I would argue it should be introduced in his set since that's
where it's actually used.

2. I don't particularly like drivers having to provide a cxlmd->ops to automatically unregister the device on
cxl_mem probe failure. It's probably not likely, but it possible that a driver wouldn't have any extra set up
to do for CXL.mem but still needs to fallback to PCIe mode if it can't be properly set up.

I don't want to nit-pick without alternatives, so my first thought was a flag passed into devm_cxl_add_memdev()
(and eventually this function) that dictates whether failure to attach to cxl_mem is a failure condition. Then
that flag replaces the cxlmd->ops check. It may not be worth adding that degree of versatility before anyone
wants it though, so I'm fine with the above approach if you feel it's the way to go.

Thanks,
Ben


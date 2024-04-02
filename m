Return-Path: <linux-pci+bounces-5536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0B28953A7
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 14:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9182A2860BB
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 12:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7993B82881;
	Tue,  2 Apr 2024 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X1C03tOi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2132.outbound.protection.outlook.com [40.107.94.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5C7A151;
	Tue,  2 Apr 2024 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061605; cv=fail; b=awwFubHAF4Lc69SHZ4kc+aQhEoKlSJwSeOnwmVjHibteTjutntTNQRfK5WN4/yNaRd2Ni2phanXVbvgfwJSqL87rinPd/zt2m0CPq4VyquC8kO8+2fXwIpq8qGzbFhWcg7sZau8QnWa1hEt9DMqNe1dvYIiK6I/JzgT7+Z2O+jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061605; c=relaxed/simple;
	bh=E6oTosDaLW1ptJhurDkdP/67S6D/v2RnigILb3Mwiuo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eSP5I4JeiWhHSFllR2hp/5u2kSVgIgQjAyflUOG9W39JtFqBZitsUA0H9EaPs6vksBNPY++QAq6UQQ4pcfsO5OQ6SHUr7XHyAy4lgQ9MjqBmf97v3L3IbE+oMQeZ3dMPE7zhljjdh1Pd1Z9k20F1rmeKjJs5iHRcCkvGPDvgbUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X1C03tOi; arc=fail smtp.client-ip=40.107.94.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/PKTrm+GnSb2evSfxRLX1jJ9T3y1BnE3b78TH6BRplJlm2H7SvwK0uXcvBBgZxMdDsTlfp/Mw0+XJDaLzDW3uMLGW1DUw6ilXgx6w2Wd8k4PrDoAnE6KLCAlvtIZ0RnDyYvICuQmrURrvLLp35n+RlWxoSfbLziA++EjCnK5Wj3UzbL9WvLzH8BIaRn8Qv/xUo45m2D7rxJd7tz/RcoEKN5KVaegpV4iCPPX2bIlwIX1tizI4sLYagj0mDmHU0hBs2rsDKZJDnqh0zjQhzZqFWebZUJtTpwMMbFPkHyRqx6xwJ8y3iXp5Dd8fO9yzbzEmStvjcwOHWbl2/fubTS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRhxySxByKilHpe/IBdmP9cHDa9d92LSdCdFIS2V2so=;
 b=WotPWnDfon+QxB8b2y1OP3soqOE4ao0KoTz0dXYOLnQ52xz1s9paVTp9h5piWTgT8Jj7b+XE+Ozzjrj/NINrd4MTYiwaD5tAr9zMkA/m/RFJDXJfW6dBL1KaR6MxShtbx5M/sH7PgFyJBlLXOmU+jeFU4aH+JDoUT/EB5VcELGLIEqW5337Ai5iWWjZOM8ONGg0v50YWUGOOUFVilalfKAAnW9gLKy2yMRkSvPJMpGDgbBteszZ3py6jj0iF9ARuPZz0pvRpbIwaYRnubxULtiHeFPGUw6NzGa5xjnkiIJ0jQUtzyn2eR6KBq/I8kIGCM/JX6aPlJmPGNFQEjsBxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRhxySxByKilHpe/IBdmP9cHDa9d92LSdCdFIS2V2so=;
 b=X1C03tOiSI1RCTbcrs29oez5KmoYOL+KQk/M8lDs9Srq0clV1E78dhCSFDDdkbU0Oa9l5Hbo9l44LivSqD+IfzTumaFMLrruY3n1Xaj3hby5ZAhOEjUFdss96Lj0BO50SJC1aUIKhsDYkUBzy0W42BkTgHtYeC3Hlk8bYxbKC6/RdSBzyynN+fYMGwvjvQOllRcrMDh/XYo3AdY6jO5b4g77kxkKj8yFuHONyYO+lWvZbLLIqiUKQxjeFOq+Xwl8NJrNQ4wE5ph5nOceOp54jTwom0dYd+jAFrF/eLMR3+HfqOdQ2HsKqC94ICyD0KjZ8OM+PWVQ1wXLl46hgGVtoA==
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Tue, 2 Apr 2024 12:40:00 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5159:5fc3:7933:24c0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5159:5fc3:7933:24c0%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 12:40:00 +0000
Message-ID: <5f478d0e-5e7f-4e6d-a7d5-d6d50bb59722@nvidia.com>
Date: Tue, 2 Apr 2024 13:39:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] PCI: tegra194: Fix probe path for Endpoint mode
Content-Language: en-US
To: Vidya Sagar <vidyas@nvidia.com>, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, bhelgaas@google.com
Cc: thierry.reding@gmail.com, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240401150116.298069-1-vidyas@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240401150116.298069-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::19) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|BY5PR12MB4244:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tLHiW9jcWcEGn8EqsmT8zKrR1ih11/gVWpb3Hd77kVvGQSmJgFwULP2n6XhAq/I+HCj0fX1WY5rC1VziHiWf2lWC4L742FqwaHry8UEmMvlzFM6z1Yr/deyeB5npB3NRrOUIl5jJ9VYvQprUV8312bpc3kJFVMXrVboaIptJEDwj44BeJdfQzH9qayObnEzY/G6pLEe7FjTyWUUD4MTiw2d+zqJCXwwGkb7xsuCyZGoLdEx/0ncKcHUmCtBdew/KZKuWq1+Ho9mvyGI6i0CemEXzOC6oAaZwB9F64w9pTlTjpnxSd/tB5JobsWj6BLA1EfafFFA+WwR2AKnVxmDUr4sOi7pYyj8m/xoT/36AiSDw7Qx6+bHlYgzraHKroYuqhnohXRnepZQnWXyIEuUlPizbJJ/9FVnddF+soEif33qF9dziFBz6CAZPR9NVY5Sq1jLSsmZ+aoy3K5ZjykvYaEujF6ozUgVjUb8y0KSvANMwWp9dtqbd04HlA/i+nP2QpQn0cP2NljVGHUq2Wcv7YExB95GwdPQogGw2tInhSmFsoH8q1o7n9rLh7ZG+q2GRkb6rGUcH1QNrHYq9deJHtjOQnFr+5IVovIpAE+0Dc99YfERq/8Fu6l4HmanJ9NCo5EcCovuGyR/nlJMG+APZKDSWlg5wQ1ZMzaw3B0xo/nw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3FaRXZYT1BsU01BYktJRTNJZHM1ZTh1aGtvc0plYlFNNXlVdnZPREhVQ0Ri?=
 =?utf-8?B?TUg1czJUb01KNWNxUDE1cjBMcGRUd2oxQmJyVmNQQytobHlLNG5laVl1MFQy?=
 =?utf-8?B?VFpqTXdzVnVBVWhDRXBoQUtGeURkNjFWRCsrUFdWR1hJR1U3VHVFMUsvTXFT?=
 =?utf-8?B?Vncycm9MelRPTi9Qa2EyMS9uUitzUGZyZHZlTzRFcWw2c3RKNklJeklsVGhk?=
 =?utf-8?B?V1VrSGIwUFBxdjZXd1A0UndtUWpFai9HbmVGMjNMWWI0cmJMbmpBcGhMZ1V5?=
 =?utf-8?B?aE9Ta293ZmgzY0lhMVNYVDMxNWFodkxTZWNqZDc0QjBtV1VpS1ZEempjRC9K?=
 =?utf-8?B?Zlh0VTZVR08rL3VTTENKQit1ZDVFZHFWSmRXWXUrSWhGRm9USXRCbk9hUzhS?=
 =?utf-8?B?TzI3NmpEdnNJUWRVbUdXckFWbHVHSDU2S0h5dEhJL0QwMWpqVC9uWFNaZTg1?=
 =?utf-8?B?NEU0Tk56R25DQkNnUHZVUE85NmVLcFBncU5pOGx5eXY2bnNqajJ4OVdGelhq?=
 =?utf-8?B?eTY1MHB6TFRqVmFxNGNzY0JQcDdRckpIU3RuTURmbE0vTWdzV0JnQjlWd0Ri?=
 =?utf-8?B?cmMva0QyZCtKWnFScFc5L1Q3TWhvRVBvNmlaNTZ0WjlIeVd1RGgyWmdnRjBQ?=
 =?utf-8?B?NW1lNTNrdTJTZ082K1laRU9SdmEyYStEWElkbFRaZkpDN1cxTDZZMTIzYlBm?=
 =?utf-8?B?UzROYVZVN085VGFsQUtiOHAvVW96MXFtdjg2L1ZLc1F3NnFqRlZ2TUJXMlZr?=
 =?utf-8?B?bEZVRU1QRDVkcGtYUTJONE50WmVLL0dKeFB5ZktkcStIMU45UjA3T05ia3RL?=
 =?utf-8?B?V24xZnVoOXZCMC9lU2pYMlVVYUlmcWtaUDBXam8zdVZramZGZG9MWE5CSytz?=
 =?utf-8?B?T29WSzBrRUw4YnpnTjVra1doZjFJUFZuMkpaWHFveVkzMzY4dFdYYk4yYkxW?=
 =?utf-8?B?WDZ0V1NZcUJLUm5BVGUwbExHQ1MzbFpHRk4vbmhwTTMwSHdzR0ZGOVVkZU85?=
 =?utf-8?B?SWdLaXNLUFA3dkdDaVNNbmRxS2VBZlVnZ1NyWVdoVFE5eDRXei8rcnJPTUJV?=
 =?utf-8?B?Sy9NRm5KWFRyL1VVVlE3SVYzSWRub1Bkd0VxTzFhZXRyQnFrLy9pQjVONzNk?=
 =?utf-8?B?VGFBVU16UXVLemhTRFhBbFhnYmoydnlUelhqU08zdmd6bjJ4anB4WWVVS0RL?=
 =?utf-8?B?cFZiZk5WaTNQRFN5SG96djRKdVUwN2VudW9VV0t5ZDBOU3VEQjY2cksvVktQ?=
 =?utf-8?B?UjgwaXd6YTFGeW1ZN2x2T0dtcGs1OEluazN4RWlnSGZlNTl5S3J0TEdQQ1ZD?=
 =?utf-8?B?TW02VHJqM09BZllmQWpLZ3diUmErQnl4ck4zbEFnOEo4cjVEQmtYYldWbUpt?=
 =?utf-8?B?VjNtUE9aazI4aHppSFFWWVVTcFBzTEcxcktzTXpDTjJ6T3YrS1BxeDdoMzNZ?=
 =?utf-8?B?UkFKMkgrQUZldUZySElKREU3a1VIYVRGRkxCMTJCYnR3emJZNVdZRzRoWW16?=
 =?utf-8?B?YXg4cEpGcnNxT1hJTHdjVExqSGswQS9KWC94cHVCbmxNb0RQNzZYbUdRVk5o?=
 =?utf-8?B?Z2xsR0xFYkx4NU5uRVhuYWlRSWZ1cytwZGhLVVpCY1kvbjNzcXlSV1dKUm5R?=
 =?utf-8?B?U2F4cThRUm9qVy8rQW5ZdEVWTktjak95eXJ1R2Y3eG5PT1U2Zkx6VHdOL0xE?=
 =?utf-8?B?bmg5ZENuZGVob0ZBU2tnbEtwc2dJUTdiWlpKbldFMDR5TExTVzk4ZFJOSXcx?=
 =?utf-8?B?ZE9lQWlxcXZyU1N1ODcwbWpuanVJYWlsU0dKUTRuQjl5ZktTQk9mMmlJSWJs?=
 =?utf-8?B?b01YYmR6emptc2l3TUI5ZjdSSzRMb1o0NTFJNStaT0t2cmF3ZmVyYXJFN1FY?=
 =?utf-8?B?dXNNWEtpK3BZV2Y0SmNpMExBU0wxNGdwaUxIblV0ZmxqNEYrWnV0Q0lVMk41?=
 =?utf-8?B?c1dSSTJxREEweUoxYmQ3VW1MVmdKdEFQQlpPMWFWUWZnSGV3aTRJRGN2MGlZ?=
 =?utf-8?B?bnd2a3ZrUTZzaEtuNDFzYnFvZkIxWkRQQ0dLbmtPUmFzZ3Z2OWwrdDNEUGZV?=
 =?utf-8?B?eEtaMkpSTSsrWk5rZVdFRjAwckJOZHd6MUNtSXcxL05hTVdQVWxvajBsenRh?=
 =?utf-8?Q?mYOiNOcov4zqgoWsT8/z4nCJb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e946729-5164-4340-fe49-08dc531202d0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 12:40:00.4234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zW+aB48wBIC4RBoVq9Gd/QYhxg413KkIjFMsIAimm4tsomXrhN4Lvzryz3oPZdV7QWb4jxpXo5S64st2VE3UmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244



On 01/04/2024 16:01, Vidya Sagar wrote:
> Tegra194 PCIe probe path is taking failure path in success case for
> Endpoint mode. Return success from the switch case instead of going
> into the failure path.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")

> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 4bba31502ce1..1a8178dc899a 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2273,11 +2273,14 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>   		ret = tegra_pcie_config_ep(pcie, pdev);
>   		if (ret < 0)
>   			goto fail;
> +		else
> +			return 0;
>   		break;
>   
>   	default:
>   		dev_err(dev, "Invalid PCIe device type %d\n",
>   			pcie->of_data->mode);
> +		ret = -EINVAL;
>   	}
>   
>   fail:


Otherwise ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic


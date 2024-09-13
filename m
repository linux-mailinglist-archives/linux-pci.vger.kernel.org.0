Return-Path: <linux-pci+bounces-13163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CE9977E88
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 13:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67653282FA5
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 11:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7141D86E9;
	Fri, 13 Sep 2024 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jII1tZSQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D72A17BB3A;
	Fri, 13 Sep 2024 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227365; cv=fail; b=bEO3Dw4oWUKqwgaEpjiLvRzVz5AB3vUj3qYt98dKSslBoFEWFeHYZL4VKJ4140iOgjrLrLvTLTjt8w8YN9XC1Xt4jtoUIZu9phPJ906qa32JvY5TKkMzK1sPIMt3dB/D4VHJBVzStw8+qOx0f8Z1t628+K9SpyoSZHJLBHpLsRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227365; c=relaxed/simple;
	bh=Tv6U4HCIAbjSqE5fzrEZL781trH/JBAtKNeS8QDOj4c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WS6C7d/TFFFk0IoGn+dgkC68H19SUVeXsOcl04ZcKrPySB38a8ct+Ce89av4crsp7v0yqc63II+cnmGz6DBr8ckxLHJDRRwhhd8CnJS3Tr9D6Uk3jZBuitfnbBkmYQIICNWLSyKp75nZVvYRmRxQiibTI6e3aqqkE+rcfinrtAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jII1tZSQ; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZmLtobR0LVlu+glO3DRcE0ykDC0k3gTq+bq5XVGLhDvjpSWn16/2m2giTLPDk8A6jTfaiSZGRSbcpr5JjfrCxPXQ2xGMWPNyXHm1qKLr8+J6v5wIfuFrbWkdWn2Kmp2FUMbjUaw5EEMd74YZsZn7bFQghvG2B8i+aCMGAwvTnQC9Bth/YyS/m1OCDB6926WurPqlQKIYCqLODL1Xn+RAEHZt936yZXszOKLpNtyLSoG3SH3Q/2niwd85yxbZpvzaWz2QNFf0kHFoAIvKSZdVZhMxQwC/MthEfM98iEAU27WuiT16JULU5AlhaZtLQ/Xl4Qk9GjjhD7XytE46RXL+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbcubEGgjgZeNl75c91M+MecqnWSovKLzIZReNDrzRE=;
 b=HVBo+czR//VTF4iK00R9vDNyLPFcX9hFzzx7WjL8KlcIm+JNYb0ZQnB4qkW/8uJkaGQkYmCLrusijXQE3J3cpwnTM18x4bw2852j/vOr+B6RAHyDXYX/ZY5HD1+H1jgBNnN8GSdQEgOu2oviVBWxT66W+bbzxVAcFbqNJXmV6clTTnBnq7ecUqhrWVLLsDct2ADjQ6nXI/zJ5iPWZElRbwsS918HPsEVFJsmqWexg9blqUBOW7ygnt6cJUWACs7x82EnV+EROdwxH7NlyXLQrWMLXMARJtRzbTdMXcHkQnBxeuCXcmacQxBvKQ6m+3KIxznZU8JTjf8Qm98hiiFKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbcubEGgjgZeNl75c91M+MecqnWSovKLzIZReNDrzRE=;
 b=jII1tZSQL/qO47kxNQXz3xZyi+zLQJln+TI5Iqtqe778OxuRTM5wOKWeJGibV6dmxfOMtp0rDy2WYE1zKu3nYYmI7iEMH+f49bC6ZQoarlYTLhJSFzt+K/32DvnRe88IQdcq5B5NY0o+hjX0p9aBSBMuSdTtDJNZ2x5tM0ZBUPo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 13 Sep
 2024 11:36:00 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.021; Fri, 13 Sep 2024
 11:36:00 +0000
Message-ID: <fda48ab0-35bc-48ab-4b62-77e09758c760@amd.com>
Date: Fri, 13 Sep 2024 12:35:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V4 04/12] PCI/TPH: Add pcie_enable_tph() to enable TPH
Content-Language: en-US
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jonathan.Cameron@Huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
 lukas@wunner.de, paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240822204120.3634-1-wei.huang2@amd.com>
 <20240822204120.3634-5-wei.huang2@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240822204120.3634-5-wei.huang2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::13) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0216d6-2de6-414a-e7e3-08dcd3e83d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnVSZWU0aVA1dG56RVpOSFlzcjhGTEdlUXc5dFNHOE0rTFNwaC8rajd5QjZh?=
 =?utf-8?B?N0NhVXBVb2tWT3B0UEtaYmY3SDR6V2hlclRQZ2VzTHUzUlpZd1RQR0x4TW9Q?=
 =?utf-8?B?SDlobzFQZHY1TTBGemNZbnZuUEdwQmV5a3gzN1oyWWM4QXFFUTFuMEdtRE1y?=
 =?utf-8?B?ZWdKL2FhQWVDOG1rZ0RaOWRXcGVoZENxRXQ1dGhkK3RFN0xLNW5OK3FSbEJ3?=
 =?utf-8?B?Y2NON0wvanBpa2lNbkw3K29yOTJ1Q0M1NTZoUXRRMFgwejEwR0dRL0JtZ05o?=
 =?utf-8?B?d2NIc09nenAxRVpocm80ellVK3ZzSGJ5d0FwUzNvblkwL1pkclVBSWJuZnBt?=
 =?utf-8?B?QitvVFNjYy9JREtubzNZSWZ2enZmV3ZEVXpTQm83U3lWT2MrRU13bDVOMUFH?=
 =?utf-8?B?eXZsU3QwY2xHRjNJTEhGOExwTU5GSC9ucmVOWjlpS3VQdUJpUHVFUS9vd09O?=
 =?utf-8?B?T1JYQmlHVkgreUNVUW05ekcwd0IrZVdYR3RsWEZzRzR1bWV3c29FckFQMHBy?=
 =?utf-8?B?TmJCOW42SFFkU05KTHlJQUQzYVd6RnFyVm43TEk4TkIzVjlJSVdJdS9BYUJY?=
 =?utf-8?B?ZjFnRDFickxWVHVkWW5lRVgrRkFuWVhNeEZSSmJib0JYRmszbnpwNFdFbGV2?=
 =?utf-8?B?QUpnMWRDZGhwbFNTQXVzUGVGM1BpSTNIZC9ycWt5Ynl0dEZKSHlZYk5qbm1X?=
 =?utf-8?B?RkRVL0NSTjdjeEJRcEd0RHlVSWVFVUM1dXB6endvclpldjAwRGJtR2hXTHc4?=
 =?utf-8?B?Z1o0cWxucVVlMVl2bU1jTno2czlOOHVHQUk1YVdHRkQ4UCtrOVNaUGtFdlA3?=
 =?utf-8?B?c0dKUnE5QnF2WGxnbzZ1MHBmOHBadGg1ZHIybDJKSzMxVEE0MEZkdnhJNC9U?=
 =?utf-8?B?dzJ6NDd4ZVRCaWpsWHRwZXFXWlpFUmF6K3l4NjZyWmJtRnNGRzVLL2drNTlt?=
 =?utf-8?B?aEo4Sjgwc2l4YndBTmdLazdTVEszdEV6V0lLZTJ3MlNRUjBoNUIwL1k5Y2Zi?=
 =?utf-8?B?dmhXOFltc3J0Y1R2UWUxVDIvc2ZIWkhTeld1cGtsekx2UjRrb3pha0pRYnpG?=
 =?utf-8?B?c09SK3c2cW5kSmRldXRudjVMamtEcUJOb0VKWTA5S3dRRGZaTktYcEsxajUy?=
 =?utf-8?B?K21oTHdLbDBoTWRTdEJTaXB1YjEwcERCMkNpMUIyY05wZ0Y4US9EYk95cVFX?=
 =?utf-8?B?UlErdkc2NFhnNDZ0aFJ3anJtSHhyaU96MG1aM3N2eExDNEJmUjFZUXF6SzBm?=
 =?utf-8?B?ZHRtSE9acFphWnhRWkJjYmNSdzU1RVk3RHRwbXhLbjQ5cWprVHJvam9Ub3R4?=
 =?utf-8?B?TXdsQnpiUHIzdnBtb1ozcjdleFkwL3RVTDgrVXFKTDQzYnNzY2NvOHZPSkpX?=
 =?utf-8?B?dW55REJ6cXh0emdnQXZsWGNiZEt5c21PRTdncEtWRTdXRysrWkR2WWwzTmJq?=
 =?utf-8?B?Y2I5d0I2MXlRNzU0UnVlN29xM3NoMFM4c2hLeXhXa2tucjEyQmcxVEJvdDdu?=
 =?utf-8?B?QkNwUUdJOFBCZ3gxUGtnaUtOYkhWZ0VvbkJCeXBjY2lVNFFyV0pXbm9Ca1pX?=
 =?utf-8?B?QUtFaTI1RlRZK1dqTkYwWnk2azJEdWM5dDhyWjZRY1ErWm9idGx6MVc1Rzc4?=
 =?utf-8?B?YzBCWlUxa290dE13cHFIL0xwazdyNktPc3pOQ2cwaVZXZC8xSmQrWXpEQlV6?=
 =?utf-8?B?YWtZaFN0dW1lMUhsVkRwQkoxWGVudUt5QlJFREl6WFZiaHdZaGNiNC9OMlFE?=
 =?utf-8?B?cjg2QytBVmNmQ2JrTG1hekNXZmpKa3c5VmYyUUlNU1lTN3FoNWRDNzd5ZmNO?=
 =?utf-8?B?ZEZlNW1TSmZCcnQwbGVHQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blVPREVXSkVTWGJ3ZE1qZUk5MUNnSXppdHZFeVlyaUxWRzY4QlR6TTRMRmE5?=
 =?utf-8?B?bGs0U0w3UnhRTlUvY3lUbGF2cFJ5WjZ2UVY2bVJkeGZMUUkxUHZXUFlhTXVW?=
 =?utf-8?B?Um0wb0dhcTFCb1piTlg1bjAzczg2R0IzbUFRMXZQbEFsRmFPeTlBd1labGZo?=
 =?utf-8?B?aTVwdmxjY2M5VVdrVUNBVC9LNnNqVEdoOVJRT0JXOUJ2UXdIZjNSdlJKM09F?=
 =?utf-8?B?bWtpdVRRSmJtWjJ0anVjZFRiWTFyQ2Z4azl1aXhxNFRiMGJrUE5Ma21zekZM?=
 =?utf-8?B?VExJQ0NCUmxNbkJBU0ZkUWhhNzZpRmVwMmNhM2taN04yWmhjL3J4YStjelRL?=
 =?utf-8?B?bXErTXVUYm9Sc0JEeWJhREZ5dWtJQ2dDUjBhdzNMZUE2MjRpT3MrbEh6QmF5?=
 =?utf-8?B?MC9hMG5EYzJxUGttUTJzdCtZRnZ3d21MU25zYVRJd3R3NUdxc2xESS95YVZE?=
 =?utf-8?B?cXByUDJnYWRnRFlibHNuSDNsYitMNDVIZkNNTVBIWldlSStqSVJTREFubXps?=
 =?utf-8?B?dWdWd2h6aG83bFEzdlp6ZmJDQlBhRU40eUlsYXEvUWJQNmtybU9SZGVOV1JZ?=
 =?utf-8?B?U2pnYjFONVdpWHJJOUZxRXVmam1mMHZGK2h4TWVNOEpsYmZUWnBYR3dETi9O?=
 =?utf-8?B?cU1NaXdCWWNOMTRxWWZmRjhkSlZIblhLbVdtTHlPaHRQMk9NTTFLRG5tb2RI?=
 =?utf-8?B?ZDllZEtWRDRKaFNvQ2dBS0ZWemlQOWRROVpLd3RHaUJkKzcvaVZXU1gva2xB?=
 =?utf-8?B?R2cvdS9aZTJuREwxQk5qT2FXcTlmb0dnQW5qZ0dwMlFqMk5hSkdyYUc3QmJj?=
 =?utf-8?B?TXd0U3dGYVRqZFJIN29zYVBma3VZTVBCemxBRkc3YzRDRHF2VTd2dWpFWlgr?=
 =?utf-8?B?TnlMd0dEaUtuMGhGVll2ZHFRcjNBK2htVlF1UUp3Zms0VkVSdTB5RDdJY0px?=
 =?utf-8?B?VVpCaVNFck5DNXNibHE2VnBGRUJoN2svVkc4RERMVjBZUlVTY3lMTnZJR1pq?=
 =?utf-8?B?Mlh0cG5rb1I3Z25NWklqelZ4SlFmS3BxbStDbHpkSkJBWUJ1R1dBcFkrTmhn?=
 =?utf-8?B?SDl1dm1WT1p6aFJMdzRiQkZHQmtBZVlsQXdiNUkwc0M1OW9sMDBUSkFHZEdz?=
 =?utf-8?B?WDdIRkk5YThjNGphN3V0OHZuR01EdHdrdHd3aExFZHpoTHdJSEtITmdFNUdj?=
 =?utf-8?B?VnMwQnd3b1QwSUo5TG9NMWdDc3hPTVJpOFJ3Rm43ejlmbElLc1R2VTczY1Bt?=
 =?utf-8?B?aFpHTTMzVWE1cDMydXdJdE1KQlpuV29MSzRqUk1wYnhsbXlpbko4NFpBc2xD?=
 =?utf-8?B?QTlaSzN2ZXJBdXpRVFBtbGZZU01FOEJpdmZDQ1VrRnpzQ3E0aHh2RXdFRFpO?=
 =?utf-8?B?UW1jcStEZVg5VVAvTm5MeW1pUlg3ZzYzVU04dkVJekl1TEFVakNxeUV2V1cy?=
 =?utf-8?B?NzdWcm5kWnlCbGtnSmZ4dXhXMHcrVWtBcmJnVUlBT2FBZDh4UVk2eWF0SzU5?=
 =?utf-8?B?WnZDVzZzSDRJRlZlSkEyZFlLNnlCOXNBb3VjS05BRXBVa1p1Z051NDQvdmp4?=
 =?utf-8?B?T1dxQUtMQlpPZ0JEbjVtcnJvYXJrd0JSTXFTVzhaRWE0cEFrano0VmJJRXRJ?=
 =?utf-8?B?STUyank0QUlXdk5RMG91SUZpWlFPYTZ2cC9PTU5qTTlSRHBFMU9vWGsxVjJZ?=
 =?utf-8?B?UFhFeVQwVkxCZ01mUnpWUjBUMGJrYVV2dGQ5a20wMnhYQ3Y0VkZNamxBYzFu?=
 =?utf-8?B?anVURUliMXdudlB4TStCV2xhT1pFanVIdVRiZW85a2hEbHYwRWl6ZW1UcHJq?=
 =?utf-8?B?cllGU2hEN2FGUWtZOXRLbEVDQklpVGovUUg1bVl3OVZoVnZ6Ri9ydml6ZHAx?=
 =?utf-8?B?K1NEMDR0VDFXT1Nld0M1SDNIMVBlZTA0d0xXS0JFSjlqcW5tZGZGbXpocnQw?=
 =?utf-8?B?T0dCVGtoSHpWbTh4VFcvVWZPS3N6blIrSUdwRnhuNHNEQnIxeUQvY3Jpa21i?=
 =?utf-8?B?R3Bkc0U1SUNXUCs4Q1ZBaFBzTHA5SXFIOHkrV1RJbzJOMk5oOU8zRExPVjVn?=
 =?utf-8?B?b1JFUjdEZW4vYVI0QWdPRTc1VG5TNkZGNjVuZU1nemxsOWlUN3RzRkQ0N3hv?=
 =?utf-8?Q?LKveJd1BI91aHhht+2o0t4blB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0216d6-2de6-414a-e7e3-08dcd3e83d65
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 11:35:59.8697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgC8VOL3cVHFRe+maHQe6I2kT7s02pkrizM4Y/3O5CQkQEubO8hpuSzzu6GA3F0eoB98MzvBbXagzC0f+BJS4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725


On 8/22/24 21:41, Wei Huang wrote:
> Allow drivers to enable TPH support using a specific ST mode. It checks
> whether the mode is actually supported by the device before enabling.
> Additionally determines what types of requests, TPH (8-bit) or Extended
> TPH (16-bit), can be issued by the device based on the device's TPH
> Requester capability and its Root Port's Completer capability.
>
> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> ---
>   drivers/pci/pcie/tph.c  | 92 +++++++++++++++++++++++++++++++++++++++++
>   include/linux/pci-tph.h |  3 ++
>   include/linux/pci.h     |  3 ++
>   3 files changed, 98 insertions(+)
>
> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
> index a28dced3097d..14ad8c5e895c 100644
> --- a/drivers/pci/pcie/tph.c
> +++ b/drivers/pci/pcie/tph.c
> @@ -7,6 +7,7 @@
>    *     Wei Huang <wei.huang2@amd.com>
>    */
>   #include <linux/pci.h>
> +#include <linux/bitfield.h>
>   #include <linux/pci-tph.h>
>   
>   #include "../pci.h"
> @@ -21,6 +22,97 @@ static u8 get_st_modes(struct pci_dev *pdev)
>   	return reg;
>   }
>   
> +/* Return device's Root Port completer capability */
> +static u8 get_rp_completer_type(struct pci_dev *pdev)
> +{
> +	struct pci_dev *rp;
> +	u32 reg;
> +	int ret;
> +
> +	rp = pcie_find_root_port(pdev);
> +	if (!rp)
> +		return 0;
> +
> +	ret = pcie_capability_read_dword(rp, PCI_EXP_DEVCAP2, &reg);
> +	if (ret)
> +		return 0;
> +
> +	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
> +}
> +
> +/**
> + * pcie_enable_tph - Enable TPH support for device using a specific ST mode
> + * @pdev: PCI device
> + * @mode: ST mode to enable, as returned by pcie_tph_modes()
> + *
> + * Checks whether the mode is actually supported by the device before enabling
> + * and returns an error if not. Additionally determines what types of requests,
> + * TPH or extended TPH, can be issued by the device based on its TPH requester
> + * capability and the Root Port's completer capability.
> + *
> + * Return: 0 on success, otherwise negative value (-errno)
> + */
> +int pcie_enable_tph(struct pci_dev *pdev, int mode)
> +{
> +	u32 reg;
> +	u8 dev_modes;
> +	u8 rp_req_type;
> +
> +	if (!pdev->tph_cap)
> +		return -EINVAL;
> +
> +	if (pdev->tph_enabled)
> +		return -EBUSY;
> +
> +	/* Check ST mode comptability */
> +	dev_modes = get_st_modes(pdev);
> +	if (!(mode & dev_modes))
> +		return -EINVAL;
> +
> +	/* Select a supported mode */
> +	switch (mode) {
> +	case PCI_TPH_CAP_INT_VEC:
> +		pdev->tph_mode = PCI_TPH_INT_VEC_MODE;
> +		break;
> +	case PCI_TPH_CAP_DEV_SPEC:
> +		pdev->tph_mode = PCI_TPH_DEV_SPEC_MODE;
> +		break;
> +	case PCI_TPH_CAP_NO_ST:
> +		pdev->tph_mode = PCI_TPH_NO_ST_MODE;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Get req_type supported by device and its Root Port */
> +	reg = pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
> +	if (FIELD_GET(PCI_TPH_CAP_EXT_TPH, reg))
> +		pdev->tph_req_type = PCI_TPH_REQ_EXT_TPH;
> +	else
> +		pdev->tph_req_type = PCI_TPH_REQ_TPH_ONLY;
> +
> +	rp_req_type = get_rp_completer_type(pdev);
> +
> +	/* Final req_type is the smallest value of two */
> +	pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
> +
> +	/* Write them into TPH control register */
> +	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);


No error checked. Same with below pci_write_config_dword.


> +
> +	reg &= ~PCI_TPH_CTRL_MODE_SEL_MASK;
> +	reg |= FIELD_PREP(PCI_TPH_CTRL_MODE_SEL_MASK, pdev->tph_mode);
> +
> +	reg &= ~PCI_TPH_CTRL_REQ_EN_MASK;
> +	reg |= FIELD_PREP(PCI_TPH_CTRL_REQ_EN_MASK, pdev->tph_req_type);
> +
> +	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg);
> +
> +	pdev->tph_enabled = 1;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(pcie_enable_tph);
> +
>   /**
>    * pcie_tph_modes - Get the ST modes supported by device
>    * @pdev: PCI device
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index fa378afe9c7e..cdf561076484 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -10,8 +10,11 @@
>   #define LINUX_PCI_TPH_H
>   
>   #ifdef CONFIG_PCIE_TPH
> +int pcie_enable_tph(struct pci_dev *pdev, int mode);
>   int pcie_tph_modes(struct pci_dev *pdev);
>   #else
> +static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
> +{ return -EINVAL; }
>   static inline int pcie_tph_modes(struct pci_dev *pdev) { return 0; }
>   #endif
>   
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c59e7ecab491..6f05deb6a0bf 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -433,6 +433,7 @@ struct pci_dev {
>   	unsigned int	ats_enabled:1;		/* Address Translation Svc */
>   	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
>   	unsigned int	pri_enabled:1;		/* Page Request Interface */
> +	unsigned int	tph_enabled:1;		/* TLP Processing Hints */
>   	unsigned int	is_managed:1;		/* Managed via devres */
>   	unsigned int	is_msi_managed:1;	/* MSI release via devres installed */
>   	unsigned int	needs_freset:1;		/* Requires fundamental reset */
> @@ -533,6 +534,8 @@ struct pci_dev {
>   
>   #ifdef CONFIG_PCIE_TPH
>   	u16		tph_cap;	/* TPH capability offset */
> +	u8		tph_mode;	/* TPH mode */
> +	u8		tph_req_type;	/* TPH requester type */
>   #endif
>   };
>   


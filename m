Return-Path: <linux-pci+bounces-2487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC283940E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 17:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413031C26535
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 16:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20F6612E0;
	Tue, 23 Jan 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kLuPjU1V"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A7E612E1;
	Tue, 23 Jan 2024 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025712; cv=fail; b=KP73QcIFNOSOrzIFVppIf03RfB+UW7Grjuo6OJfQfq4+i4HmxtvmjkUKVp3THN2ubhVQ7bgENq5s3Lc6kMDieXnN7J3p8lM2CeBzJYavUQpy0Qnrbmi/cbrFTXnos6dpj3yEqmrV0Sw/AN5vzfMZYb/+Q2mvYYJQFbFCSY2dSTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025712; c=relaxed/simple;
	bh=dYrJ4h4nR4nXbJV8kRyCvtfGW5yUs9UuCznEDh74MFY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=okciPtpN763+gKjvIWtBnNDlGX5ZFXJaW96ZaC/cDq4x/rQeUijSzSLP/Qz6nEF0AD1hVmun2W81s2UqqRGVY5DGKgGaLLeV4+07V6iOdpdLzchE2S1D4lBxud3ushty5l/g8uhVnNbVMzzxgcDh4BrGvBdSy8VMg6Mwd3UWY8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kLuPjU1V; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjkBr8rDR1gpFXT+LpgE/rsNH6Pf4oGPQwF9JdkhyVtHyy+R7NpqTaAeEL0Qs7iFZpCzm/pi0PAkDoWrf36BSy9Rb6Fd34mtmRaw5O7WCv3qZd6Bzjs5x6Tx40tqD9l/9m8f0PflGx54yRjNdki9drgvbwLS69Le6MTBWeMsM5LCLrHvvVPXa63HEcZlFWqsBWkQ1wneLTLomOh8sseO/aThLwpliwHwGkBhkjEl7xCmsGYNGzYWHuV2bUAuFJKlzz/Ykvnfs5Ctt813DPE7m7jD1JX6yCSwkxX1h6vwfTB8iuNSG2cJ9MWrPcr5rnHjBkTPMMzPTUHg4Hr519xvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHRixsSiOJmLToMkmte3ELDsbiEGWWBp4PvnVfz9bp4=;
 b=mrKVH0GQDZVRwCRHuSY0UHPiWZy1j0FFs1gDk1veAvaATvJvIANrgwhrnhMNSjgJn68r3kIe/N9MCa5ybQdIaKhuyUQRk0zPDJSfHvcJuUVwnEOeWVijIbOoJuStR0ZFLZiLmoFYdTZQ6+A7ApmFc2TPX1Vi7eEuK4dRxjjIWXpVKoESq4JX/wDwLksjAvoB5X9ryUI2MzRQafZz8s0qvUojQgDBvF3466bcu3zjUCdKWFSsx27nizxAluH5RN7LeRkAutL7Wh8OCWjr62aYHrp5knPbxMxxHl8+IDXfa9nj4x9Zp2XaIPuUD4ACULlYMAG7ZeMQ747dJmw8RVKmkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHRixsSiOJmLToMkmte3ELDsbiEGWWBp4PvnVfz9bp4=;
 b=kLuPjU1Vevg5i5v6UWxouqZBKweOuvqgXL97WZDw747JpanQxGaxRn7NWNqRqoFFxZ0D3AGjCH/oRuAVCHtV/Yl7cFDHUVW7m+uZv8DEY+erlifjJ8TdzI7Hfgznj6sAJT6CT4UdDVQQ37TFOZ913dI1P6whEJ1GHBon3Ce/QM94PvrvnJY/+JwVzUpMNx+h4LG1p9+8EUhRTz5K6ePOY7oFE0WhIqzE2+BXEMZa6dB5RYoZWxalUsg0acADN9QgfEYHSxWAtvjDn/lvoEjfk/XCBcTopenQrWwZvMyMfRdzOoD/Uz0Ir/PqQMX66sUZsQ5FwpJcHU6cZMEp3tn5qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by DM4PR12MB5375.namprd12.prod.outlook.com (2603:10b6:5:389::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 16:01:47 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c%4]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 16:01:47 +0000
Message-ID: <23c5fac1-ebf1-4e5d-9691-7b87060b0df3@nvidia.com>
Date: Tue, 23 Jan 2024 21:31:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] PCI/MSI: Fix MSI hwirq truncation
Content-Language: en-US
To: bhelgaas@google.com, rdunlap@infradead.org,
 ilpo.jarvinen@linux.intel.com, tglx@linutronix.de
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, sdonthineni@nvidia.com,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240111052814.713016-1-vidyas@nvidia.com>
 <20240115135649.708536-1-vidyas@nvidia.com>
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20240115135649.708536-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::14) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|DM4PR12MB5375:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d211196-73a7-408b-71eb-08dc1c2c99d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t4BTQvThAOSFT/OjGJFMdvASEf+K15nx6lku5FMItbbe73G2mn91d0b61hlGtlnmYpuwPJfDNTIbW3bJzojouPELM7R1MyKlxcypUYQ22q8l2idqqzdNXx1JvJ+FdvKNr8HW9ExswaF1rZZ9o9homSZ5bW6jkfB4YY77wbCi+qG1z6e+EdnQpScDn2OvDeG54ndC4ArOHUAQlv1nGM3zvzdhxTlQV0VaYJBqFERm3vDfmMqZSPYt/Y17zRpI6TCM3OX562J477cOmmgLOECwA6F8LvZQgV2gair72KE6mpd6srJhtLvts3uLwnoC391Jgk7+02BF+XLGnFLP9tY31s4ewwDi32kC+Bo/ZahK0fNOYzujwwQA5S12Om+D58LccYqWTZ8/FOB66R3ctK0u5r/8yGjVu2RYxvIuOrZlQ1fdDYVY5LDiQSDbpFSv3dWXO3H1u7oBka9K5s3DyednXTnjAII1mtI0p7dnCQ69n3DU0KB5oez8G2Fayh8qDQHg5d9KDsId0q4xXUWZAPkFXRK8Vz8eCKQtJSw8zCGJnCKQwSzLmu/LXv/oAvFc9XuEqtHeqX0EnF1W5hvIR2oRsgk6G+wAe/cF+0oCusII6bDUJ676JDr0yzsxCTbho5pinmT93lyUdKfw8k3nfLs4wQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(53546011)(6506007)(6666004)(41300700001)(36756003)(2616005)(6512007)(66946007)(66556008)(66476007)(316002)(5660300002)(8676002)(8936002)(4326008)(478600001)(38100700002)(2906002)(6486002)(86362001)(31696002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkRjK1hQeGZPOXNZeml5QW11MkVza2hodFFnTURaZk81VlNOSlJ1WGtyQktS?=
 =?utf-8?B?WjJjU2U4VzFnZC9RNGhqV0craEFzbVNCRlhoK05rRW9Wb3RidUFRY1YzYlhY?=
 =?utf-8?B?dDJkTnRzRFhONTkvQUptbVh1cGlzMVgrQ0sza1ZQd1U5dUNlRzlaMmRuYloy?=
 =?utf-8?B?N3g2Z00vWVhIa1ZsL05HWmFrVDRuVmtMRW93Y2ZwblkvK1N1eHYvK3N2eW5I?=
 =?utf-8?B?Y0YvODBCK3IrZDFCeHN2QUt0dkRIaFFLYW5ZREExSi9RTjhUYXUrNy9VL3FO?=
 =?utf-8?B?L1NFckFENit2c0RvQnlqVG1qOXBKY0hPQVhzdEFOOVNnTVNxVmhjdUMyS056?=
 =?utf-8?B?M04vQ294WkNZdWdIQnRZaUpKdis4ZExQdjAwSnpyVkV5NDN6QjJiempZNlpJ?=
 =?utf-8?B?eFAxdytZTExYam1VU212bExYMEJnWGhicmpiTkVIbHp2SXJoV0lyVnhkQ2Fw?=
 =?utf-8?B?eXJDR2ZpVDZHNkQ3cU9WZUczVi9iNUNKNDNkOTg3UVgyMDBuS3kxRFdrWnpo?=
 =?utf-8?B?VzBZelJ6V2F5bFRYa0xlT0ZnbkMvYkR1Rk5ISkVtTFZrK0JHNitxa1Rsam1z?=
 =?utf-8?B?U1dDV0FtQ3Zwa3JiMnNhcnU3YmZ4Z1VpVXlTRytlTHk4R1ZUVGxkaXE3eElq?=
 =?utf-8?B?STdYMC85YjlRaEVIdWFibFByZ0ZYZktvenA2eHZtenFOQmhFZk11R2w0dWFk?=
 =?utf-8?B?WVM0aEJsQVZoY3VtSFhqaDNDSnJDRzV6ZEtlOE9TNlNSdzdsa1FkRHBmRGZ6?=
 =?utf-8?B?dVZoVGgzaXpNYVpxKzhNQm1BUUNEQUd5UlF3ZVdGd01kWXdhdlN5dW04U1BN?=
 =?utf-8?B?WWh6VjJCcHRsa1dacmJubStNVXNnZmJqOHZkUU9waVFaM2RuK1lNYnY1a0xB?=
 =?utf-8?B?dkYyR0t0Uy9JaEtCUGROWTAzeXhFZUNjMXRNeVg4NlpCNXRWVGNCckhFTVdH?=
 =?utf-8?B?em5YRlYvRURuQXRQWTFVdGJRaDNVd2x4emdzZ1JCSFVxMytpV1ZKemRpNTc2?=
 =?utf-8?B?bGZEQWprWHVrRDJCVnR3V3hsUmVkM3lyRzNpZzFBZi80Z0JLYXZtaVhRTXZD?=
 =?utf-8?B?VWprZmhoZXBrV2MvTGF5bVFvZHM4TGhORjVId2dRcjljdGJtdE9VZGM4dDBq?=
 =?utf-8?B?Y3VKYmMyZGxMM0J0U1lveWl0aTVJVkFpbER3S002OFJNTXhtUFZZckIzOUZa?=
 =?utf-8?B?QXlzdXlsZUxOeUZFTUxPTW9tU0JabmdXcUVsalJZblFKMzdrd0x1WjlLVGth?=
 =?utf-8?B?NTZ0c3RwU09pNkQ3NnVMZnV2WVFJUWxKUEFWL1FTU3pUSmxrSFUrQW92cFBO?=
 =?utf-8?B?SytPdXRDQWlBS2lxRVlhK2xSbDJQeURKM1pqNm9IbG83VWlWcWNGVUNIM3I5?=
 =?utf-8?B?Ym13UWFCUEdQWEdlQmdhWnZBR2p3bTI4dVRFQ2VvbFhJMXBHbThMR2tTa2hP?=
 =?utf-8?B?MnhtWG52eGMzczJVYzdITXp2Y0VvN3Bldm41bW9xS1M1TnNzQWJVdlNhRnhC?=
 =?utf-8?B?ajk1VHExbXRJeWZlTXFKOTZ6WVV1WHE0RXp1RW1ibkp1a2V4d01CT3Z1YVlo?=
 =?utf-8?B?NnUxbVo5K2cvZS9UakdKenRMR0RIZk5RdzV5dnNadHZCSEViWWE1N1k2Qitt?=
 =?utf-8?B?eHJOdDZWVWh0ODdNdDdsQmJFcWZzd2VacEp5UTJ4WmFYcmJuYS9PUDJPaDM5?=
 =?utf-8?B?UjhsRm9PRTBhaTZKNUNuUjVkVVJiMXNHQ0tnMTdLaG0waWVsaHJKOWprNFFO?=
 =?utf-8?B?bXZ5djR0NU84YjBMcEtZcXN2U3Vjb1R2RDBUUzhZK294YTNheDhERU5YQmtv?=
 =?utf-8?B?TkhwS29ISXQxUGZlYlltQ09zV0ZJVy9qbzRwdmhOYzd1WDJrd1NCOVlsNWFh?=
 =?utf-8?B?U2l1TW0xc2pWbTF4cFRTZ1NsQlovemtBbUN2RWJsbFU1cGlyUGgxUnJZU1Bk?=
 =?utf-8?B?d0JMak0yUjVHUENodDU3L3dXM1VTeVU1T09kYXlNMHVoYy9lQnlZcEFnSmYy?=
 =?utf-8?B?eFljTWZreVQvNU5VTjVhOE0zTVBaQmtUeEkwVmZOVnY4bGIzUnc5WUg0bjdL?=
 =?utf-8?B?YUswcXFxdXR4enAvREJZdUtPa21BY05aeVZuZlRBMWkxTUZMN2lZNUp6a1Yw?=
 =?utf-8?Q?oRQsxzV0ebqFaX3YFudnd61iJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d211196-73a7-408b-71eb-08dc1c2c99d7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 16:01:46.9263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LI/gLgw+6oaGkj42CUtskThIEpsenxWOpje1ggmiQR4Tg0LVAtg6C+ZyxfmM7955C9shHd5WCl5TIC9Im50yDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5375

Hi Thomas,
Does this patch look fine to you?
If yes, would you mind giving an Ack?

Thanks,
Vidya Sagar

On 1/15/2024 7:26 PM, Vidya Sagar wrote:
> While calculating the hwirq number for an MSI interrupt, the higher
> bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI domain
> number gets truncated because of the shifted value casting to return
> type of pci_domain_nr() which is 'int'. This for example is resulting
> in same hwirq number for devices 0019:00:00.0 and 0039:00:00.0.
> 
> So, cast the PCI domain number to 'irq_hw_number_t' before left shifting
> it to calculate hwirq number. Please note that this fixes the issue only
> on 64-bit systems and doesn't change the behavior in 32-bit systems i.e.
> the 32-bit systems continue to have the issue. Since the issue surfaces
> only if there are too many PCIe controllers in the system which usually
> is the case in modern server systems and they don't tend to run 32-bit
> kernels.
> 
> Fixes: 3878eaefb89a ("PCI/MSI: Enhance core to support hierarchy irqdomain")
> Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V4:
> * Added extra information in the change log about the impact of this patch
>    in a 32-bit system as suggested by Thomas
> 
> V3:
> * Addressed review comments from Thomas Gleixner
> * Added Tested-By: Shanker Donthineni <sdonthineni@nvidia.com>
> 
> V2:
> * Added Fixes tag
> 
>   drivers/pci/msi/irqdomain.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index c8be056c248d..cfd84a899c82 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -61,7 +61,7 @@ static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
>   
>   	return (irq_hw_number_t)desc->msi_index |
>   		pci_dev_id(dev) << 11 |
> -		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
> +		((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;
>   }
>   
>   static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,


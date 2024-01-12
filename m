Return-Path: <linux-pci+bounces-2099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C768C82C135
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 14:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DEADB2184F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 13:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6536BB58;
	Fri, 12 Jan 2024 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fl7OnfoI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8F86BB40;
	Fri, 12 Jan 2024 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8z4H/Z560Frt4V2sDQy8z7RFOl/VvlwIFj9LQvUC/fHVecviri/BXdNYkmymJvl0+97Xaf9WDQSLqi002s1SUHHPSkamDQUUuA7l4J6UCiqSQBKCbR6mNREeJDV46onnaKWyfHIGEWc1U/ZJ55+M+Y2R7uyHvtqHa4BnccaUXEyQ+wn//thRjYpSnSgftNfQasF7UOlpNFk8ZrSarfXOV2YhIrgqZV2Fp/6BjsRp/qB+I7ZlqNjnOjBpxS1BysHl4fz0PDQQrdq0KjFZTUDFHvBQCCPQI395TUnmj3KMuKDETQ1bgQmq80D5LoeKtLxQn+5A+jwi6U3CvNYn2ynGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Rl+fe+FUUksL3jEW5yeYMjit4z+Wrka+OwOUvTVFjg=;
 b=SUl8DfAbgJmi1dkl+jE94H8kwNENmPSgftyWg7wyZ1z/DFwTD0t+ZiuK/gfNG1R7ujYpFJbJXQxeGMtTvMC+kl5S4qHWcw/G6/WnST5jDw8p9QYt11+I0JPo7Xm15yJbsoZIXybogruwxkeixrICbCc3EcwcvA0rNIC4jZPRQnqhr4aMMBAAfj0iR9/FaIKJTrwKbceyhWYwRniRqp/2+IEsZNqOeF3IMZjipCUjTiXTXlhT8H6k0SLyHnuc0WOM+az+70ltj4DUiFAV6dDxhIVPQq/PlpFJ+o7gyXfL8uZSNFKvAzxWQqHLT8H2x66cszkGGEacm9kIBlrpAJfa1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Rl+fe+FUUksL3jEW5yeYMjit4z+Wrka+OwOUvTVFjg=;
 b=fl7OnfoI46SEAS/D8Rw5reXkrInvZrRbFjPE8CwyyYpE08ET806VyRk/fOpp/Fy1lQ7VBeiUKQmHHQ4z97v7cQURi3I+4hVOP6jr8tY7qLBrKlQBz9XV7jkcQk+l3IZAjcIwhXLZO1Gpni1q4eu8QjmR1dzDUQ215qQGd+0jN/6QBxd4Z4nt8Z5Duj+sXHRw3Qyr2VPe1vJg/himDTOPcP+wr5m1haJhr9whmF4WiR1tFAn3x6y72GJ0Em2j6mGuzLdSDo3NyK/DfOtB4V3pwiQPyM94w/SUFGPePP6yuSPeBkpFJUQOyCI2FMtwv5XJba1tGaWpskZTZp5UI9wSKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 13:57:27 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c%4]) with mapi id 15.20.7159.020; Fri, 12 Jan 2024
 13:57:27 +0000
Message-ID: <b04ae5f5-4770-466d-87bb-d1b96d65e89c@nvidia.com>
Date: Fri, 12 Jan 2024 19:27:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] PCI: Clear errors logged in Secondary Status Register
Content-Language: en-US
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
 mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240104013229.693041-1-vidyas@nvidia.com>
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20240104013229.693041-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::32) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d875d7f-6fe7-4049-6568-08dc137668cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZMRounmt7bikhoS76s8hVl6q1ASilFEMonf6xTqk6C6B1SffBTYhMP2aba401VuQaTmiQMovaP7HGvI2dxj21pFHJUU/ukMeo9jkJm2fq30uieowrCxGo0eZ62PMMtOkVHs/lMOBnIX9k9AxtSuYsiLho6e8/LNhGJQolEc9HdOsdFZugoNSKkW5HfDPJoZoEs1+TpLTTBP8j1nRjaDW+79QeBrySLe8PprHgAXxNBBfHNDzmQCLaapJcKwlS7SBdcF6UzQbfs+nz5X9kXO9aVYYBL72KPAhbnCGb++59R6mDeqd5JrbjWS9amSbOKY7wHbEs2WeOTqEVHL+rvla5LA6n8+GZ7BzAUz0UtgYwBhbbF7zC5binik+GTUYR8ZHuLbrghEMf5ISbU90Fn9vLRGoiZFfEgniVhDzLBcgGG7fVQeXcXu6BjhApg4XqrPEP27zrXWgRQSpFQspyCTklc4e33uH4uxq8S125u/AaPFvlm8Gh3YgGS/WzrOLk2O/Eg2jjVdsCyWgYjErDndVoHUpi8dI+OaczpEng0+fSJtIWjN0lBOEdcc7rMt+4nm/jAEzwTZf+rS+nRLfXCqFYj+Nlb1nN/4j5cWJzC3k2zPdBA5ewY9LquDWt7/7JVZesj1BwXI2NLQekF17pcYYcVk97C+cfoo552ILRaPf67lfyJ3WzO3JJLwF3Q8Bvfiu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(66476007)(2616005)(66946007)(66556008)(6506007)(478600001)(6916009)(6666004)(53546011)(6512007)(966005)(6486002)(38100700002)(83380400001)(41300700001)(4326008)(316002)(5660300002)(8676002)(8936002)(2906002)(36756003)(31686004)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFQ2ZFNnK1dKV1hqWWs3dHgyd3Y0Y2QzRG1oekR5b2ViMG1tVnhaUW1TVkl6?=
 =?utf-8?B?dHVhdHBnT3E1Z0pDdkZIaWVCV3lKWk1JNDRzT0pRdDVVa0UvcERHZFRTRTMy?=
 =?utf-8?B?YmxIc0RCQVhjZlNRVGh2NkVRRUdtRkI0R210WW0yN0tDYzJPMjlQVExNcWtI?=
 =?utf-8?B?MWUwdHZodlBlQnNxOUNtdVh5Vjh3S3g4NHFYOXVuemtrR1BaZW5RTFJNcjEz?=
 =?utf-8?B?SUd0b2syNDBRdCtYUVJtRDZHQlNHd0ZKc0dmTFpCN1YwNitoSk5tamUzay9p?=
 =?utf-8?B?K0xPQ1BUenhHd0swUVoyUkZ1c0crUWd1Y2I3amJpQnpMYytJSTArc0Y0R2Rz?=
 =?utf-8?B?YmNqTFAvUDZndHpHblJrTXUycVphbmIrMC94TzFTRmJvMGFGNW00MXpYVGVr?=
 =?utf-8?B?MlU1bFhjQ2pMSVk2d0k2djV4clNhbnVlOFQ3dXNwM2tIRDVjeWRCcHlQN1hr?=
 =?utf-8?B?b2JqYVRQNDVnNzJZUHdoUm9TRDZSVkdMdytOcHhOY0d5dGxnNHZDdUExTGxZ?=
 =?utf-8?B?emhML1NZNmFoNnpwRGdJb0loSEVGNWg4QXVpNzM2UmowSVBQTWx6QU0wT1pz?=
 =?utf-8?B?WVB0U1lvQmt4T1lMNlN1T0ExSm1HUzZDODQvb1FXQWVTa05rL2pSK1RLWGN0?=
 =?utf-8?B?TUgvZWNYeFBQZG9aMmhxZXBZL0hpUTFrOE44dGozdDhkNFBDdUtJODFadHkw?=
 =?utf-8?B?Tm1FMmd4MTA4TWNsMnEvMmJwYUNRaCtSUStGeFAxSHRPYklmOFBiRVpXZkow?=
 =?utf-8?B?enMydG5yRmZVTVcyYW5qYnUrbnFTZFMweTI1ck9KN3BETSs5RHlIQm1KYis5?=
 =?utf-8?B?c0dORDZ5Zm52NlpjUmhpSjdsYnY0V2IvMHJnSGdKQS9IMEQ5SW1vUmZTL3Vs?=
 =?utf-8?B?OUE2QU1lZVdmaEZ1U0ZsMHVyamhvaWhPZGVRTkJIWkZuL1Rtb3d4eGxVTlJp?=
 =?utf-8?B?NlU2UWFZWGlmb3EzZUs5TnI4MitzaldPd0V0UHdaZXF1U2RzZGNIR3BpdGw3?=
 =?utf-8?B?ZVdnb29nb2JURlZqTzVhMDF4NE4rRlFEYWVmamhyV3pCNVRVcU5iMWZqTFBk?=
 =?utf-8?B?cG5yMEJ4WEJ0MFBOZmFERW1xZ2I0QXllYzFSeEdCNGx1eEw5TjZjcnV4QXJl?=
 =?utf-8?B?NEp6c3VYNG1EcWIzTEMwcUZvbHliR3U5Q3dkYmg4ZlM5Q2EvV1ZTbVRyam1i?=
 =?utf-8?B?YTJycGphTVZub21OcTgxMDFjZS8wdEREQnViNmVkSTNIOHlWUkM4cmRVWjVF?=
 =?utf-8?B?RlJ3TWVtUFdZUlIwSHFnbktoWjhiaXBJL2hycHEwaDJMRFZGZ3VhVnJHMytC?=
 =?utf-8?B?N3RsNGRWakh2bEZ2cVhST3czVHptM0VVTEVpL3kvNmcxbGFlV1l3T0JNYVFP?=
 =?utf-8?B?bG9LRnlzZVFBVHVHbTdadWxYaWg5bHZLSVE3ejFoWm0wWSs5SktUOEMxdU5n?=
 =?utf-8?B?MzRQUjY5YXdoV1lSUzVwWEJNOFdPK1pOci9hTzBzTUJFdzJIdzJVMzVoc1VM?=
 =?utf-8?B?cW43ei9pVm5MME1oMmxFUFMvdXNrYmVJRU5MVlAwbEY2MW9TSy9OeUpYdEV3?=
 =?utf-8?B?SjBLVzBxUnJhMVpYR1hmV1UrUis0SEhJdVkyUTk2K2kyMlRqK1ZLYmpVbmo2?=
 =?utf-8?B?OGdJZVZtQUhSekR6R2l6QVhGcnd5MGdvaTBWY1Y2UzlYTkUvQmRORGM1MVI2?=
 =?utf-8?B?RkxTYUJUUTZoVGNnR0pqQlNTTEZMbmo1NWRqUERKSWpRb2xHMW9LSldDZlpN?=
 =?utf-8?B?dDJPMlBtMFZwdU5WU1VNZlcyS0J6blhoeFl0UGxBcFp3UGhRTjI0Zzk5Q3FV?=
 =?utf-8?B?bW9pdzNoK1Z2WHR0bkRvNjNnbndGVjFqRjd0L3BUUStxblRhK2xORngvSUF3?=
 =?utf-8?B?V0ZPcVRZMG1zdVlmcWpMMk9reHdDLzVLYnplaVBTNlZHbG50K3FIdkFuZWVJ?=
 =?utf-8?B?eFF6MU1Pb042T2ptRzV3UitDTnNzWm5jbXV4cEh3QktieVNxQ3Y4QmJudDAv?=
 =?utf-8?B?R3h1RUp2bzZyelVIYjJOOVFiREU0NFdwQU5UZlNpalBERjJxK0VUaHR0T2RY?=
 =?utf-8?B?NWt1OHkrcENSMUo3ZUhQVm1xVVk1bndoZUxoYThxVTVuVUFJMEdFUU9zcmVB?=
 =?utf-8?Q?mJOOPpimEox9rawkWfIlJGp0s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d875d7f-6fe7-4049-6568-08dc137668cf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 13:57:26.9027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UlqrPqQ7S3O8++B0b66SFD/Y7x0bdyf3wwjhHnDepP/bGbtkxYLypfebMdXob/Vn6JJ+FQbpOsJvH4WAh5mjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219

Hi Bjorn,
Do you have any comments for this patch?

Thanks,
Vidya Sagar

On 1/4/2024 7:02 AM, Vidya Sagar wrote:
> If a downstream port has a PCIe switch connected to it, the enumeration
> process leaves the 'Received Master Abort' bit set in the Secondary
> Status Register of the downstream port because of the Unsupported
> Requests (URs) take place in the downstream hierarchy. Since the
> ownership of Secondary Status Register always lies with the OS including
> systems with Firmware-First approach for error handling[1], clear the
> error status bits in the Secondary Status Register post enumeration.
> 
> [1] https://lore.kernel.org/all/1fb9d746-0695-4d19-af98-f442f31cd464@nvidia.com/T/
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>   drivers/pci/probe.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 43159965e09e..edf8202465d8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1470,6 +1470,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>   	}
>   
>   out:
> +	/* Clear errors in the Secondary Status Register */
> +	pci_write_config_word(dev, PCI_SEC_STATUS, 0xffff);
> +
>   	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
>   
>   	pm_runtime_put(&dev->dev);


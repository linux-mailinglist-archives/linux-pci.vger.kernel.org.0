Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5077036CB0D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 20:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbhD0SVt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 14:21:49 -0400
Received: from mail-eopbgr760077.outbound.protection.outlook.com ([40.107.76.77]:2695
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230219AbhD0SVt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Apr 2021 14:21:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqidSBEvnWXuE+C5wrehhqrWHVFMChs+IxSpFaXZtwPATnjvnsojNX7PAKjJdMeD8QRyUqXgNEwYLCtCI43ZZJFHQj6RT4SBushQvDECBp5k9UXW0+qgN5rPgcuU7T/gHYe8iy87IIoHib7UCeZzdfwz6GKMdbmNrOm8WbvGwdhJt7X/TmsPZIxhUK2uI98RO0fU6NIqKBsgcIYzBvgvaDMZHsMARzBoXFREaQOa2AcRMdFQMX7t8qEWlV8chuP0W9/n8iJzA7DXuYetjxkcqT6BjKzFWLOm/6ugCI3foa0+iWmPPNE5CmqK3loihGUx6xKAwTIrN0eY9Zh5Z6E7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BPcv68iqLO5O5+aRnYLbPLguwDsdIiCBsLDd7e8gmo=;
 b=E23TeCfX/xe+na24wH/GZ614vLUlbvv2fUPJxRX4YmKndmmxC6FQcPhKXpdu/Nyb6AmDblnYPfjMdSBK3JEMhS2fQuc1iBVpWM0UunXzd47OrziOh9tOhaK8wNLuUx6MGm0fUr+CR3jiHAv48UKOFgELj7lwx4jMENgysjht5v/N3JjKCgeUa/KlXIJrofeZ9eInJLoDrTYd2cG4w1WQhkFIaKvXp0RBJGvpHCExZnZ4Lbjr1JTeE31uZNtUoM5cNFDjq9cB+FEfvxXvDu3nK4HbxwL2MMfqpxAmGwfzmFBq/9LFyZn1FZN9haZ330CmrTXZynHhHsLSS5Ijksl7Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BPcv68iqLO5O5+aRnYLbPLguwDsdIiCBsLDd7e8gmo=;
 b=qkL64P0Ol+dgocQajYmKUUMacqkAJAL8jsjOKv/Ayp9ZpGf8J1OWQCmea4R6L4zptFj+0MmUowVmLyq21gIBWUgubQJZC4OHCpqlZ2cM+lF+SXfnfNXMAO+MhBFS/urr3dL52L8E8FJuKQJcaEdvRJYBn5Up95VyPbu2BQ39gLI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Tue, 27 Apr
 2021 18:21:04 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4065.026; Tue, 27 Apr 2021
 18:21:04 +0000
Subject: Re: DMA operations by device when device is fake removed using PCI
 sysfs 'remove' interface
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Christian.Koenig@amd.com" <Christian.Koenig@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
References: <7c188623-49ec-a958-1dd1-bdbb1f46987e@amd.com>
Message-ID: <d3ed2b7a-2772-095c-c87f-ad3385f01948@amd.com>
Date:   Tue, 27 Apr 2021 14:21:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <7c188623-49ec-a958-1dd1-bdbb1f46987e@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2607:fea8:3edf:49b0:f12:a3c5:5bdf:6c7e]
X-ClientProxiedBy: YT1PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::20) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:f12:a3c5:5bdf:6c7e] (2607:fea8:3edf:49b0:f12:a3c5:5bdf:6c7e) by YT1PR01CA0051.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24 via Frontend Transport; Tue, 27 Apr 2021 18:21:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b97ada5b-02e2-4b92-c1da-08d909a937c9
X-MS-TrafficTypeDiagnostic: SA0PR12MB4351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB435193FF83A9BE32AF99BFAFEA419@SA0PR12MB4351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFQgfrTi8tKWUHI40yaWaBOBptvQ6vjkRAg7ttkiEAN/xWcxY4ezkhXMPslBrKnuXCWTM/hwXZLNaqc1H/3TRkruSD6SEUxDNo/NdlbbCSqWtA2NrU7EdH8Fm+mQfgqKmvdCLa52suDbgHq5erqlLmWx7QRmtGJCHflTOChm0+qlHWdNFppP1Y2aJSPnlWew9ZGBFVPMJJxejg4lG/aAyW6vCrAYqdjftfkYvM7GJj9OAaAsvtKpAsBYJfPcsroBxy2BrHKkZyNUO8PAcxDCpnb/5aCERCJK2vscSROEVRPVFo5zQ+TBZ2hJtlIVBZvPYGgQPl/2vE2sKVSpujpm8QsRWksOhVw802RTrS2a3JE7BOYx054rKnDvQ8NqrZ/Ubm5+uSZqiBLPTzqqr4tp2lu+weAGYy9Rd+VpNXac9nVtuvkPa6+R331ADCoND3pS+X3cn6DTvLYIlqs8LMprbaj39UqRqWO4g06mOsoT7oFa9+QRioE6Wqb8Fb7jwbJWMrvTbxPYDL/rJ6fEB/2V8ulknhpiHciRRHg2T6P/nXH41qgW5/Mnca/9e26ez+PSdz6xop2ptU20oZM7ktjtH/tQOmCXPJKtcgyzhx4vIfMds3Mf47p7hZd/5JFqlICMP/lRS4Rqa0eVjUjhHDGA6NDoCJYFQdk5/tvue2oc1jH6x4DhmRcEeu+5H4Wiv+R9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(31686004)(66476007)(4326008)(66946007)(52116002)(478600001)(54906003)(6486002)(36756003)(86362001)(6916009)(31696002)(186003)(8676002)(8936002)(5660300002)(44832011)(2616005)(38100700002)(316002)(2906002)(16526019)(66556008)(4744005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UlZLalJiSm8xcDNjR0xTK1FISkZPWWFjMkh1NGdDbWJtSVUwMTV0Tm8wRGp2?=
 =?utf-8?B?TVBLZ1N1UlI5TFN0MDcvUXlVeGd2cVlWYysvNWxXUnRlQlpwc01UUlVpODNB?=
 =?utf-8?B?Y1JLVzJ3c3BYTm80bVJRWWZQeTMwYzUzRnRELzdQQVBKTXlVREVtR3NOZTFE?=
 =?utf-8?B?SlpjRWgzdjFjaTMvM0xVeHFmMWZBemwremVMZUNlWnllaFlCdnNYSFJtOUFC?=
 =?utf-8?B?NTNuVUlqSlRJbndQUmFub3ppM0EyZ29iL0kxNHlDcGlpUEU5OUovWk5NS2l4?=
 =?utf-8?B?YUZhdmxHWVZuL2pkU21iMjYxTW9lVmVVbVdxUElibUtHT0ZDT3JvM3A3Mk1R?=
 =?utf-8?B?Z0RORGNDTWVVajZLL1RtejVBK1ZYRnExalh1RWU1SzlqNnZoVWVGeDE5NGFa?=
 =?utf-8?B?R2RZZFNabnovWHZyT3FWL0xGdnBUK2t3am5oZFh3T2w3VkFNLzk4dm5VeDg2?=
 =?utf-8?B?b01lR2RNQ3k1V3orOGdKdnFhdit1NUNXWnVFUEl6TXdPNGhER2RRbFJ1ZFFR?=
 =?utf-8?B?TVpaOW9Pc0RPRFdXam1SS0g5T0c1ZnVzaExkRld5QXI0eTNxMzAwSXROWGU1?=
 =?utf-8?B?Snl6ak11MGZ0dUpVb01NcVNYR05YU01IOEpXTUptTThLSUlJWlRhVlpuVks1?=
 =?utf-8?B?QlZSVjVyWkdmaEp5bGlIcWIrUDFiSWtsTjAvQkU3UWp2a0RESE1jeUZISERO?=
 =?utf-8?B?YUFVS09mazl3MU9vZVJMd3AvY1czS05wZGxSUlBNN3YxMXQ1MXVqcW1HQWE5?=
 =?utf-8?B?TFk2b0NPZzlNeDFDMXczb0FmakVvTEpyTXFhdkRlcWVnZWl0WkU3ZEdsVUQy?=
 =?utf-8?B?WU85bjFEWTVFNEUxcjRpTWhXVVlxQlc1SEorTE5jeThrVklxc1dxRVVia2Rx?=
 =?utf-8?B?MEtXVVpmQ0lzM3JjSWEyMU54a05UTGFBalZ5YWhmR25Qa2VScDIySEQ5Z2tR?=
 =?utf-8?B?bU0vQmxWZS9xWllvd29aNlIvcTlsekQ0dU82WWQzazhhUHlDYWFUY2FYVUVJ?=
 =?utf-8?B?QlpBdGZsdXkrWWpST3AzYW51dnBSdlFBaGxTa1Rndm9JZzBqOXFRNU5EcEV3?=
 =?utf-8?B?NGxtVlB1dlppVDVSbURhTHZaUVgvVm9TYVB5UjhnSXRFY3N2OEp1Si9IU2tQ?=
 =?utf-8?B?L2VMVytQcWZDaXNiRW9tWXcyTFZhdUlsOVVxMHNJT29jejNxUGRIdzBUbkc0?=
 =?utf-8?B?WmVrMnNKK1VlSXgxZ0VyUy9pNmRaYzk2RkFodVNWSjRINE11ZExyQzg0ZURh?=
 =?utf-8?B?YmFiNk1LalhCMDNBMTJRMi9kWVRkcGRqc1krT0Y0NUY0MG00VEZ1RjBYck1F?=
 =?utf-8?B?WFU4MGdObzZaVXl0akN0cXhwTTJ5dENTc0NYanQ4U0czbWh6Ykc4eFlYK2xr?=
 =?utf-8?B?UUoyYU5uL2hScXA1NktpTFdLMXJpTzFRb0NEOXVQSXZ3a1RaSjBuaVJYU1hr?=
 =?utf-8?B?M1BXU0pIODIrZUxoRkd3cmk4SUhUcWM4L2swUjZiQ3pyVFFVQTZ6b2oyQ0tM?=
 =?utf-8?B?ZnoyeHRFQkt5Z2gvMDF3bkU3dHdMN3hYTll5UlBKQlRtWTFxTDhjUmpsNERj?=
 =?utf-8?B?R0tjenMyNXhYVndSRWFhQTlZSGI0NExJWUJ4Vzg3RWNTcGNWL0g4TFVUSzdV?=
 =?utf-8?B?dTI4NDkyTGhNekxsRTVzQm9PRDBjaFBxUzdHakJjQzdqbHgrb0JaWWZQN0Js?=
 =?utf-8?B?WTZXNmF4UnJ2eHI2VlVuQSsweGppNmM4ZlhLcnB1OWo4UDBIL2ZKUVdPSCtq?=
 =?utf-8?B?WG9EZEhubjR0Q3RQSHNPbUI4VmhrSTlvclZwMlZNRGxLTDBzbHlyeGgvY0lJ?=
 =?utf-8?B?RDl4ZkdFWS95VjBIdDNNTHdXTGFVR2QzTVNQRElKSXVFMm9HKy9lM1RtSjhP?=
 =?utf-8?Q?UtOO2Zpx9gz+N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97ada5b-02e2-4b92-c1da-08d909a937c9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 18:21:04.4695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Eokd+IQO26doXnoX/OMen+mQet2nGwYUhPzZtwZRXlJadYwF8jsPnQ1qcvdL/TKmgqYixrDpD5jdkGQNrwUkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping

Andrey

On 2021-04-22 11:05 a.m., Andrey Grodzovsky wrote:
> Hi Bjorn, I am working on graceful device removal on PCI for our amdgppu 
> driver. As part of it I am triggering device remove by writing echo 1 > 
> /sys/bus/pci/drivers/amdgpu/xxxx:xx:xx.x/remove
> 
> Question - in case there is a DMA operation in flight while I hit the 
> 'remove', is there a way to wait for completion of all the DMA 
> operations of the device being removed ? Is PCI core taking care of this
> or is there an API we can use to do it in the driver's pci_remove 
> callback ? We are concerned with possible system memory corruptions 
> otherwise.
> 
> Andrey

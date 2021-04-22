Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D1C3682ED
	for <lists+linux-pci@lfdr.de>; Thu, 22 Apr 2021 17:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbhDVPGL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Apr 2021 11:06:11 -0400
Received: from mail-dm3nam07on2058.outbound.protection.outlook.com ([40.107.95.58]:11987
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237164AbhDVPGG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Apr 2021 11:06:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IplR+kRrPfmEIAgrU8uxHgj7njD0S83furQaDMVlepNTv9a6X28P4+lNoCdBC6EZ9HmYfCO2/FrxJg1XKBv4G7mNvGgswqEyrbcLrT4VeoezoG1Po6UNt6Of5sysMTUb8IZwQW3rdPLdvnJ8Q94InVBugWYJHRkEsbipSmNT/k6MaEpb+KpXJEhoREvaSWNTTZwxyS0xFYgIYu++N8HXUnLu1PH/AV3xem3pjeTSpLqxWJyQ0qganbzRVl5N79w+B49bDTm9cEgWm4wtzb9UalrFSuT31L0JHjhu7ADs5RiSvHFyHrf0hN4+e4eq5RZ9joz+JoU2e6zand0aXW+w5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9bvK5HVWpWs47QRrzf3ZFloPY7yBuFmYWI0TSxfAXg=;
 b=aiKYvntISljSjJpSlrfrss7p91dz3TgcqLuqrzRQnIHkul1KIG9OUwqiytURnro28ag2VwalkbLrCIB0AdYiDazAylG3W9gaS9ajRGu6V1crhNC0pWik6PFSLNiUZQ4J1x5GWUM4Egyel4VaM/FUv0b0GpAPYIEum52jUh3gHq9MQ8OK9l7dRX0/j9Y9I2okTNRQJTCgwVhliYhZumCLefAM68sah5kFM550lYaJ7AKpXvoKa4HTWB+wJUgfApktTVz5KAh8RHzdujGu+MgG+EcVvPszn4XMwAPOoyaG35W/QLZF34uvSfbLoG8rRqcG7UVvekTC4AMloqPAoOyE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9bvK5HVWpWs47QRrzf3ZFloPY7yBuFmYWI0TSxfAXg=;
 b=QSHY8zQJnV843YRc6ApicxqPLVFuPZKyo6E+UBgzod2lrUI5NPxWA0qRPHLbNjc7FKS0tf0nHVHf3jdW6ff9/LCi9nAPXe6vZok/8RfPRODo/IyrEdNNizcK3LzBsK4w8NbKWuiyLG5Q6vRP3hbMeY7tq3eoTbzVgtAcuaETgV8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4591.namprd12.prod.outlook.com (2603:10b6:806:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 22 Apr
 2021 15:05:29 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4065.020; Thu, 22 Apr 2021
 15:05:29 +0000
To:     "helgaas@kernel.org" <helgaas@kernel.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Christian.Koenig@amd.com" <Christian.Koenig@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: DMA operations by device when device is fake removed using PCI sysfs
 'remove' interface
Message-ID: <7c188623-49ec-a958-1dd1-bdbb1f46987e@amd.com>
Date:   Thu, 22 Apr 2021 11:05:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2607:fea8:3edf:49b0:b901:c4bf:9b3f:ed8e]
X-ClientProxiedBy: YT2PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::22) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:b901:c4bf:9b3f:ed8e] (2607:fea8:3edf:49b0:b901:c4bf:9b3f:ed8e) by YT2PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21 via Frontend Transport; Thu, 22 Apr 2021 15:05:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a61907ea-59ee-4ae3-1d02-08d905a0117d
X-MS-TrafficTypeDiagnostic: SA0PR12MB4591:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4591065DACA912E24AB075E5EA469@SA0PR12MB4591.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnTHsq0fxrom8Ulm4RghviK5PkGDa1Xr1MfAoYWj5ABFUqU6+GqgxKq709zAFlcsIt9bfOWSR9TQWIyOuy+eWqLuiWgccf7Crpby6CU+iQzHn+MQ8wMAYIwPvVRDS3Y5Y1JqknA3wtNwhnaqpzso7EWYNzy7DsEQ5yit/h7TvR7iUJ/xa9rYSFxgMe+0CRD9B+6J7NL89vb+El7e1RjI8Bm5n8xRPuDl8PV/E4AdkwQxzJ3836Hx6eAHtLqQuBcjNDjXf0YKsfp0U3oK4t3C/uB582wade/L142H719AEe5QynsQPpK1LL7OZhe/f9n3Nr0pRYRSp+JLzL0sV3fIbiNIyka9aylf8ztH7CiU5JgYcrbLtpoEMaM1n5E/B5T/B9u2O83OFl5nIJkRm73AqxK8BFes1pBigt2AYvBlYU9ZC8JGtKSPACJ4wrIcdu24jYkHVrQ6juuvC3RkcWiP/4juPjTLpzrY/HA5BsUBA0UA7YnbQkT6zwtkEkZTyOkMeRXSaaS8pqqVWd6qtYCyP+Tj5fPbOBGYi+/128RnHVY/Nn2FTMcKC4ddZ5x6AlyR+DhEsk2zcf89cR+iw4SwJl2GZB2CcRu4f9WrXqr5I0KRjDntg60NwV9D4fN00hRkxd0Gep+ApEIO5E0pS+qSqvl2w4iP/mo4S/x9B587iUiIIU4FNgaAqPcaJvdhezlN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39850400004)(376002)(2906002)(2616005)(6486002)(16526019)(186003)(36756003)(6916009)(86362001)(8936002)(54906003)(4326008)(316002)(5660300002)(44832011)(52116002)(8676002)(66476007)(66556008)(66946007)(31696002)(478600001)(31686004)(4744005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VW9CZU9xRGlTeHBFWjVSSDZKcCtZdTk1Tko2aGJDaFJ6RFJETFdhVWdSeHgz?=
 =?utf-8?B?Yjl0Y1BPUDNjMmRQV3NDbm13d09MQnYrVkgySnNIZm4xR0hqRjdEU1lxNnFo?=
 =?utf-8?B?VnRScy9xOG5uaWo3V2VHcEVhTlViTzVoVG5UdVplUGtia1dGdUIyZ2prSEhk?=
 =?utf-8?B?cFZPczBFODUzcDEvUjdpMG1CbG5NNE9YRjY1c2tSYjBZSG9uME5PVi83dkMx?=
 =?utf-8?B?eDZCcXAxbG1QamptekFLRUs4SFlGOHd4RWorWlIvWjhDL1RUYmk5c2dqS2pz?=
 =?utf-8?B?OFYraGREZXBNYS9qamUyRVByYjh4dFN1SThiditwTWVzYW9lbnVxZTlySnRZ?=
 =?utf-8?B?Lyt1dVdIZTNZM0kvMVd2b0dDbmVyYWhoUGxxRTluT1VmcGNoZC9hMlZKbkJO?=
 =?utf-8?B?NDJoMHp6bk13a3F1alN2MDF2MGJzQml1NVdsb01CODd1MXBVbnc1R2l4ZFd5?=
 =?utf-8?B?NTNaTzhOc3NKbGtXVXZaUHozUGtEeWpRY1I1djlVY0ZMZW5GTm01cytmV08v?=
 =?utf-8?B?RXp1L3FiTk9ZZ3h1c0kwRmtEa2hBVzcxRk80Wm1Wd0NiRkVvclRnQ3JZOFJX?=
 =?utf-8?B?eWlNVy9acXJFN2t5RVU2a09WWWlsTElWNkdhd2NZQlZhb2hEaExmWXdXSC8w?=
 =?utf-8?B?ZUlXcWEvSUxIeXgvTjNQcnV3UFpRVlh1R1ZhTkhoQUFDdmdlaTU4NDRnTlhN?=
 =?utf-8?B?QzRXTVRvNms0Q1RxYmFXQUxudnlubVAwdWE0TWszWWNROWR1VStIMlVHU3My?=
 =?utf-8?B?RjlQTjNKSW1GZ3dDa29tNWVHZlJTZ2Y4WXA0eVBJMWI1c2d0NlA4VmhJY0RH?=
 =?utf-8?B?LzM5bUdremVDNUJ2dzdNc3MrM2J1QjRxV2h1U2NQcWRMNGZmY0kvODlZak8y?=
 =?utf-8?B?d3FYTmcvbkZCYzdvaC85V21wZFJVYm11ZXFkTFN2QVhPTk5VbVNIL2k1aEhm?=
 =?utf-8?B?S1V3WXhjRGJWTXg4em9IKzJwaFFhWHBvQXYxVHZESWNUZXhSZW5tWVB1R0pE?=
 =?utf-8?B?bXJZWmtiaHpJOHlmSndyZFluVmtad0tmU3d6N0h3MmxkUmpsWEdjdjBLaDhp?=
 =?utf-8?B?UWVOWlRkaXUwc3kxRVlUeUcwRUNIdWxWaVJOU0NZRndETFdIUS84TkRmQnBR?=
 =?utf-8?B?dzR4TnIwWTdKTFZvZDlXTkc4WUhZNzJjVXBLZUJJRjBvYms0Qk5VVDk4QjRB?=
 =?utf-8?B?M0hhZ2Z1NkIzZHN6cjh3R3B3TmxoOTV5Q1JQN2RHYkJ2RCtqbGRyNTEwYTky?=
 =?utf-8?B?MzRmcG5DMGtZWVBGR0kzdEM4aHV2azJHVkRmVjRNOGphU2dwV3U3REF1bHRk?=
 =?utf-8?B?bHhzSGxGMXVhd0pJdlJsRnJvK2hrSU1zWXk5NGhvMjFTQUZjYWlGL0thc3Bn?=
 =?utf-8?B?ejltWWl6dWdramdVbDFEQ2FORzNnNmZTd1JLaFBQWVJaTVJCeDRId25EVlg1?=
 =?utf-8?B?djdiSjlrTGdpSllDRWNFMTkxdDZQQUZwMjVHckk5Sktqa0Nzc0RwNXhvbi9y?=
 =?utf-8?B?TmIxYlMyZkRhWCtyeWFwdThyNXVyTnFsRHJlUEFOY1I5RU5YUmRNSExSWEpV?=
 =?utf-8?B?cFEvSUt2UkRZSzRJSUVtWWdSOVVXbWZydVRIeGx4UDRVNS9zR1kxWndCcHpu?=
 =?utf-8?B?NlprbmNjVzlKNnF4bVRRMjNESjhZODRhTU4yeVF4TWF4WE1teEwwUFl0YnBQ?=
 =?utf-8?B?eXFDeFhRT01yZ1c4b2VHdUN3NWJnUjlFbHFEVXlMeHFPbll1ZXdyN0t1QS9V?=
 =?utf-8?B?VXd4T1lwcFFQQnNvN1FrbjNFcDUycDVnMGhDZDI2Y2RFSzk0bXdENWtrZVFz?=
 =?utf-8?B?a1BBbXlSNWVIaDVha01LaVE4MzdZYm5kQnNaRG4rdVFCb203SkFYdTYwcWdz?=
 =?utf-8?Q?wDl+euH4zvtcD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61907ea-59ee-4ae3-1d02-08d905a0117d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 15:05:29.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsnYsICN3S3DYQLo0xsKFu8Tl+Zc4Wfo9EOYVD7fEt/y9EJzSnn+HBqbaYeu0Hmxbvh4KICxCHx2jM2Xj2Yv9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4591
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn, I am working on graceful device removal on PCI for our amdgppu 
driver. As part of it I am triggering device remove by writing echo 1 > 
/sys/bus/pci/drivers/amdgpu/xxxx:xx:xx.x/remove

Question - in case there is a DMA operation in flight while I hit the 
'remove', is there a way to wait for completion of all the DMA 
operations of the device being removed ? Is PCI core taking care of this
or is there an API we can use to do it in the driver's pci_remove 
callback ? We are concerned with possible system memory corruptions 
otherwise.

Andrey

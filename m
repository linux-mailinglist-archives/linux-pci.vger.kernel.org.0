Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A42B36CB89
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 21:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbhD0TQy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 15:16:54 -0400
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:40096
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237091AbhD0TQx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Apr 2021 15:16:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQ/5LekamdgRBljlvvcmw9y0ZhmCktPXP4nmJafcrtZG6zG9QJ/T+HJkWmThlIRNhnpGQFfB2ELDzFIcDy3GeQtV3uuk3OzwMVHIXtJ0SnNePuRza9fWglSV3QCNSKedhBhuFS1IA58Kq6DPonNScHC4II9VmE4Oa93/42NI3oQavWpmDnzZ76UzKlji/u+0+gYqJFhvmEQ/zRKaqD3kemNtzSbGa+5hgjSr0ZcfCA+R7pAtUyYIsPI0/PBRo7GQe1ttn4sQD7dqZxwGnUUKuxmk/g0umEEJUm9VqfeUr2LhByPo5qKy6aKXdGZdk33pAzqHiSVzcpG9eN1ja+hnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRYB9DDlsir9OnLzYT3n7l28dA0bcEg+zr6jqYgUZCM=;
 b=jYfCHFKnSYJz/AfG3wAJANNiz5ZQHQKZDUktASp3t9rwlffEjw38/5mQpwjfaAyl7yBqE5EHbKBapcXlgSQb7zWzrd812EJ9D4o6fZpyRjoY9i32FHfyvjeMs91xYlTkMGtXk8dY5P1Pki0u/QAsVew/VM9FyxNkiqUL8j9oLllPcu54hy0NAsUPT9R2WKQ1El5JqCkq/c07ZIfm6ed0luWSWm+nw8MFL9lp2LEcLoH0P/7UugWdbyyo1uxTUkv0WYVoTjj8FhTAUGJOYI1LaM9TW/JNQOuxSM71KKtabFrhlDnCdLd1ZVqTRQCT1JM4Ih37gTE/KfoahR2fH1lDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRYB9DDlsir9OnLzYT3n7l28dA0bcEg+zr6jqYgUZCM=;
 b=23QNzUuk5NXXIh2F1HAmB2JZnTPZ85XJswo3v7pChQk+mnue76iVqwiitAiDneMQv4sTWBS+rUIq4xn7adea8IFIsaZwW9mI11kBR0zFa2oXhPCwPOGttybrPzm3n/I60D19MHkwhjCpsH1NyUbTgW4pWqipc2OhpPispddJAQQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Tue, 27 Apr
 2021 19:16:09 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4065.026; Tue, 27 Apr 2021
 19:16:09 +0000
Subject: Re: DMA operations by device when device is fake removed using PCI
 sysfs 'remove' interface
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Christian.Koenig@amd.com" <Christian.Koenig@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
References: <20210427183311.GA121994@bjorn-Precision-5520>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <43de02df-7356-cd81-35c5-64e2899ff6c4@amd.com>
Date:   Tue, 27 Apr 2021 15:16:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210427183311.GA121994@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2607:fea8:3edf:49b0:f12:a3c5:5bdf:6c7e]
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:f12:a3c5:5bdf:6c7e] (2607:fea8:3edf:49b0:f12:a3c5:5bdf:6c7e) by YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend Transport; Tue, 27 Apr 2021 19:16:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3d90fb5-7fdc-47be-69c4-08d909b0e982
X-MS-TrafficTypeDiagnostic: SA0PR12MB4493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB449321FB74C1D71D4B2BF5A2EA419@SA0PR12MB4493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mcsq1AmE596Y86IYEVYblCvIsfyJxJAshRxLOFja2qmjTNS8MvZ92o7rXTJ8zUm8r6H5x0TCGlwXOIL03HlReOu0qXY3EOBqviUAZ8aEve/1zMNM5B9oT/2u0EBiy22adWz1Of1ZyaC86+PAg3EmOHLNkC6srYi59xvwUoEh23+hJmOwYqk4PBjBD8EskgXabBDIGvBUO9qLiNIK8N3pjJafUmlS5MgQr3VWnh0uoYjrQQzu5gfoFEJBLPnpvipnckRmdvFc0d9kD5yt9Dnih4xXHrxpHfu0/v0wAeiMB8ESgEEgJOCGnzmPY1oHpQ4a0mtlAuDjRJkJ/gKy5wz+VBjo5MqHRVDYRfZ3naDSxxb33vjI8IFfjts73juSnldhiA0GCvFiaNYFgmvO3M8zGFe3EgJ/FR3AQT60cA1GPajfdykjS+xuhQ/NllFWBuVPDN+SWAvgJi1BE8yv3pr2jYIPbZCOEyGQQ+ghC/wtfUODaxhyE5WgbpNP8bAXXpDiqSz0Prhbk7+3oLEbBihJZ06mlyD5h7IGLsedF56J5VUUZfqbnyGFQfiiS3PU0RIfpndAANbTloe8w3azVInYlHL42GX3k7WeWRHUB3TmYuAG5/xY8HNFxn/NoEArxBZIkAKqSOCeB2HQHbN5Ubg+ysm9EIszmsheY83v587kZRP1la3uKGjo7nXw5xO6uE++
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(2616005)(38100700002)(478600001)(5660300002)(36756003)(66946007)(6486002)(54906003)(4326008)(53546011)(31686004)(44832011)(16526019)(316002)(186003)(86362001)(52116002)(8676002)(6916009)(66476007)(8936002)(2906002)(66556008)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Vlp1V1IvbEVmcWxEQjVxRFdZWWJqV1g2S3hpMHFjeUtFRFBXcmpaZWRCOGU3?=
 =?utf-8?B?ZjA3RmE4MmVhYWN5UXpMbXJLQkF0dXdCTUYydUsyWjVwYTcwRVBXMWFHV0NF?=
 =?utf-8?B?KzVCNnVMdy9RVlpnTUg3elF4SGhjNVk4WXBVempidlNRK3RsUGlwdmVBdUtq?=
 =?utf-8?B?emlFell1TFJXUHgwMFRrbkZaM2NhUjVUYTAyUGtwZG9Xck5OK21VUk55eTZn?=
 =?utf-8?B?L0kyWlpXSUtnLzE4em5mZXVuYVFtZDJGM3VLdDdVNGwzZlBCanFpQU45aE45?=
 =?utf-8?B?akUvemNsWnllY1JMcmdFc3FLb0p1UmhVR3Z4Qnl0cTRsYU5ZaldqUk1KdDhX?=
 =?utf-8?B?MEl0RkF1dlJjd0VvUXZKaEwyMExrTFVaSW1aNWgvajVMQjEzV2VOR0VmVzBP?=
 =?utf-8?B?c2dyTHZOS3d0aXlyTkxhdFZLRmliUWpTZWZQMktLb2w3UlN6RkFneklXT2Vl?=
 =?utf-8?B?QjlKbFgrS0FaWm5yWVRobUtKMFRZNFlVMEhaenVvUzM2WEhIenpWYVlkVnVj?=
 =?utf-8?B?dmJVZlVaUzRjRG1JS3dVTFVjWURCNmdKVnBBeGE4S1hFTlM0RVNuQzdRbW1w?=
 =?utf-8?B?Ny9TWUpsU3Z4VUYrQ01CN09MTWdBNzhWVGVvbXM1YkJveUpNZXh2WmYwZVJM?=
 =?utf-8?B?RzEzamNuYTNGQzlGN3F2MDVmNGlWZldyT1ZmYmI2V3VDZFdtSy9hYjl4ZGJO?=
 =?utf-8?B?bVdMb2ViYnlkUTRKVE9FTXhKclJiemd0NFQwZ213di9kR0p4WFVOV05TUU5W?=
 =?utf-8?B?eW1rZHNvd3U4UWcxMzVGeFE1ZEQ5VnMzdmVjQzcrMXp2eUlxWCt3eDdDRGcw?=
 =?utf-8?B?WW01YkZqUGxnRmFQTVhnRWZidVJTWXZPeGlTZ3dRRmVGY2ZTWlc0dkxpekVO?=
 =?utf-8?B?QTBYdms0c1FTS0tOQURXTW1McVVCUWVyUjhWRmd3N0lENkFiMFBla05KcFIz?=
 =?utf-8?B?V0lCYjZaSjN2MkVzUXB5WFpPTHZzOUlDYkNUaDVQU1RXdXFka2ZseTk0Rmk0?=
 =?utf-8?B?bThXZ0Zqd2VrWEFtNjhFUGEyYTQvUWVqUkF1bXdOMi9vRTh1QzVHSW10WStv?=
 =?utf-8?B?OE96bERMblZ0RjBsb2cwOW1FWGRCQTFQTDlMdEpRb2lTb2F3Z1dKdEkrMnN5?=
 =?utf-8?B?MWNTbTBjWExxcUpOQy9YUXdySSs2dkhNM3Vvam5jejVtZ2ZrQzVUUEQvZ1Vz?=
 =?utf-8?B?OUhlcVBiS2FYYTNaR3M1ZXVaazdlOFF5aWNvdFk2T1dQOTV0T3lHdEliWW5S?=
 =?utf-8?B?TnRWbGJjQnNHMWlhOHRXbTZGSEtlK0RocWJHcjlpVzQzTGprYWs5bXU1QXRB?=
 =?utf-8?B?M3cxQ2MveXo5QmZFYXRxYVR2T1ppMmQ5YkZrM1U5U2psMXVzMDZROEF1VVdJ?=
 =?utf-8?B?UGFNTUtVSytvQm93U09SMFVtTkVzV2p3a05RanVGa2k3SkF4M1Q2OU9Uam5F?=
 =?utf-8?B?VUVJZS90ZGFFYS9xZTlwR29ITW1LbkVlME0zM05UT3JzcFFQZUNFU0E4Y2RV?=
 =?utf-8?B?eS8zY0F1MFFVY1FUaFhFVUM0Tjd4SGQvaEJtanpSOFlGN2YrNnJKUjVHOXB3?=
 =?utf-8?B?UnJkUTR0cDhNTnFmZ1JSc1hLZ1U1QmM5cWVQc3pDUUFFM0lOZTFIWEZ3NkpJ?=
 =?utf-8?B?MzdWSHFMOE1JU044S3JmVzFpUldyd2JBZ1JOdiswQjZaRDladUJQS013Y0FX?=
 =?utf-8?B?Z0NPMUlNeWp5QXVvQjNicmJrQWNwSTEyY0ZJcHRndVhyemw2VGpNTVpoa1p2?=
 =?utf-8?B?bStHY1ZIbThwZVdBak9iSzVuZnp2UGtUOTFNVXBPcWRScDhVaTVEY3hHTDl5?=
 =?utf-8?B?cy9xQkNnaEZlUUU0a1lnK1JqeVlicDN1dWFBc0VUcmhRTXIzMUVNUGhkTUZN?=
 =?utf-8?Q?0Tp8JkKX/5kEX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d90fb5-7fdc-47be-69c4-08d909b0e982
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 19:16:08.8676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xz89txNtp6idYSmmQTcGpjN6rbjVrmJzB2U82PGgvPwzvKktzvV+CI87XKGYU+Qr1E+Xb8CeQMFybbO8WlbBkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-04-27 2:33 p.m., Bjorn Helgaas wrote:
> On Thu, Apr 22, 2021 at 11:05:27AM -0400, Andrey Grodzovsky wrote:
>> Hi Bjorn, I am working on graceful device removal on PCI for our amdgppu
>> driver. As part of it I am triggering device remove by writing echo 1 >
>> /sys/bus/pci/drivers/amdgpu/xxxx:xx:xx.x/remove
>>
>> Question - in case there is a DMA operation in flight while I hit the
>> 'remove', is there a way to wait for completion of all the DMA operations of
>> the device being removed ? Is PCI core taking care of this
>> or is there an API we can use to do it in the driver's pci_remove callback ?
>> We are concerned with possible system memory corruptions otherwise.
> 
> As far as I am aware, the PCI core does not wait for completion of DMA
> operations during remove.
> 
> The only generic way to do this that I can see would be to clear the
> Bus Master Enable bit and then wait on the PCIe Device Status
> Transactions Pending bit.  Obviously that would only work for PCIe,
> not Conventional PCI.  There is one driver that calls
> pci_wait_for_pending_transaction(), in ice_remove().

It looks like they do the opposite in ice, they first  call 
pci_wait_for_pending_transaction and then call pci_disable_device which 
is the one turning off Bus mastering. Are they wrong ?

Andrey

> 
> Bjorn
> 

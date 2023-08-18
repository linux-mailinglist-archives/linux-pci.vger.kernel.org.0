Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB12A780D1C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 15:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377453AbjHRNy7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 09:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377490AbjHRNyg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 09:54:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE19D3C35;
        Fri, 18 Aug 2023 06:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izx88yioYio4WyNN3bDeb8e3Dy+27MMN4ZPM8lwkgnZ8y+8KTDlWmN4c+3IegdQ3ZuOm8jbMNKzEPmT5IQcMt0ykKP1O5DSKGJPpJCE/imo5W2di18XI57yCs+8x8pdGm8IDYjwZoPWhomwQKKeDGoVTxHYklVxly9I4OG0Mosoi28j5RfBTXh9wVnpUNNhZvK/fWcCUnMl+A5Bi/zH2AZpMYIw00ph506vJXBK6H8x7jGaJDXBZOfynIYG05LjNgDHYcQ+omFJ9hdYebl0Co0Qn7A5sclVPeAHuyTrV32Mwk9hRJtxPlVKVzWqJ4/F+yGgFnu8LLIn8XUN/maIpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97vIEc5goRdDvtSi5EFMvr552bGqvHDTutcxsW58sb8=;
 b=Zs3Y0wKoyWcKCZ/qoeZxdACsQ3RikgAwinRMYtSIbkoYqtvw4Gs8Bbfs8ekFOjROGQuJzEcqYDIs2CH3PIXVjKrZ0BJjTg6tfru9EqXeFkmM/qoetCF5dNhWl2mCzwDmNOwf+da2udg3CAMhyo2MuFLTVs+Og0JowvK6cBxY0ZR0uSKCOFi4FqJz6tWNnmj3d2o0yPgml4Xu03vqreqRwS5wCOW4aDH1uHQMy3mRMg0kjOFsiPUgwS7hQ7RDgU3HMIZ8SIM/tuvATVg4n5QuXHgBBqEgUV9RhrHE8WU3/EO4gTdjPiiO32aafmFs8bgm7z7vEJR3ptq8sSoZvVkGow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97vIEc5goRdDvtSi5EFMvr552bGqvHDTutcxsW58sb8=;
 b=hc3Rt2DRtH0tA0i7zajU2cg8InXuIoF/UWjsV+fAV2cKawKcYa3tLBsNa0LFTb+Al2ZsoKfuypQ6o9TtlkMpU/TpX92gtdx1XMFBu+2EvLl7mSutje/qqCyDDnXo+zZPZgiUf4NK/2DUNMaaMg3wTwXp90i/Nu4bO+QOqOC+esE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.20; Fri, 18 Aug 2023 13:54:30 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 13:54:29 +0000
Message-ID: <647e85d0-3790-4a21-b56d-1bd9123a294a@amd.com>
Date:   Fri, 18 Aug 2023 08:54:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/12] PCI: Only put Intel PCIe ports >= 2015 into D3
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        David Laight <David.Laight@aculab.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20230818051319.551-1-mario.limonciello@amd.com>
 <20230818051319.551-2-mario.limonciello@amd.com>
 <CAJZ5v0iHvbbNBnwb-RKvcBaFR8VMGyGt--b6RmbUmwuzcBZKnQ@mail.gmail.com>
 <106803fab8da4648a6881991c7f37214@AcuMS.aculab.com>
 <CAJZ5v0h1tCBOcnU2mCGbgE53_=ZM3kHHXzpCtqv=d9LOadaycQ@mail.gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0h1tCBOcnU2mCGbgE53_=ZM3kHHXzpCtqv=d9LOadaycQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0005.namprd21.prod.outlook.com
 (2603:10b6:805:106::15) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|PH7PR12MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c91445-f1f6-45e4-b383-08db9ff2a445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPWxb5eSNmrVddHhesNrS1nw8LA/gGlIkItJcMb7/jtLIeg1S5p6ae47BHCgzgJb8EcMZKNnme/vAOyhd4WHb3lKAgrLXuRCa5A+znDgox8LXTT3+ll0hJ9Q31Yxf7HJ+ZijzPwdWC55CuDM6x2rHkNqQUhtsD+07ilrXxo9hNKh1WFOS9ljuZk0cEi9l3o6f0km4uT7e9zWmNb3q1tUfSjOp0sTfYyOqDdck8J3opiHdIw2DQZerdEmwyqjBZtZtkVCC3bczX93PXSHPIV6TSbr90GRrksrxFy3RUq56d+kWi8rQ7U+3CnINdn+pVDNJdUJdHUWkzURnJ2bYXeL26G+XxqfSHYnMMkx3pp5FivaerocHlsCWrIhz4jbYMjFqlITo1pygivQNPPS3hue/pJZJ1W2oUuNOlq/AutJ7AHDMG8b6OLcUKU71RQZJviOiSP0OgqMlzaDwwXmOyXlsW1GvcB0Wnq5D8sz0EczKxT9svDfFmO9aM/daeWFARa0j9sXsRSJAYNDybJuiuoGvM8aLcdmd+V2HnkCVRSny6NFQW1VJwkt9jD2MxR8gg+L3SdkJYoXjORpPEyNSR/Pa0v9v5RnjPuhL9gYKYeTQMFydTr2p9xqV1qUFPN2C2lhZ52VbBCzKq0fA/hPeU4JpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(6486002)(6506007)(38100700002)(6512007)(53546011)(86362001)(31696002)(26005)(83380400001)(36756003)(2616005)(2906002)(54906003)(66946007)(66476007)(66556008)(316002)(41300700001)(110136005)(44832011)(5660300002)(7416002)(31686004)(8676002)(4326008)(8936002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnVPMU9WTWNYOTIxbXB6OW8vTi9TS2FPWHpnV3V0K1NBaWV3WFo0UXg0WDVu?=
 =?utf-8?B?MFVieTNkSGZLRmNYYUlwVW5uUTA5elZFaGdDRTY0S0wxVHlwSitKUXpVckVq?=
 =?utf-8?B?MURTYkNvUjNYRVpjRFk2RGlZaGpqK0NVTnJHVitraXl1OVllZkR2K2R5THpp?=
 =?utf-8?B?Q1JBZHBNWHFKTE1POHBHbjN5YUs1WGZMOS94bHhQb2lmS1k2b05LeGxrZ2l0?=
 =?utf-8?B?S284YW5sUWRWWnBYd0RQQXBvUEg0NWQvWUprcmpHQVRaUzUySW5FWXFueFdZ?=
 =?utf-8?B?K1UyZmVTeG0vOWU3SCtiTkJOdjk1VEY2L25SSm5xVjhKRS8zSjhwcUJMNFRo?=
 =?utf-8?B?SzVVbThyOEpLU1Rxb3EzL3AralBsRFRsNktPNXVWL2Q4UFV6QThjYVNINFZt?=
 =?utf-8?B?REtKa3NDM1VjaVNNUkdBQXRDM21wK0JMZlVGK3I1V1poRS96cHFrbzI4RjZH?=
 =?utf-8?B?Yzh5NCtQZEdKeTBHM0VBd0lUbEFHeHpnRXdHekVTS3h2azhlRXZkUWdlUkxZ?=
 =?utf-8?B?UGFFRmR3Rm50Q1NRSFdHcHVVMnd4SXk5MWxrcFhzZElhbXIxeHNRUjVIVm1m?=
 =?utf-8?B?cFlmVXBQWWQzNW1Nc3FRWDhMYkZ4c2xFZUkvQ0VDd3ErUDRPanRSakJnQ0Vl?=
 =?utf-8?B?TUU3d1A2VzhWSlJNeHF5MXJYMENZMEE3RVc0djE1KzdCS2docUgzQzBSajR1?=
 =?utf-8?B?OVFRRVBudmpyR0Q3SDFPWTlKVHNnZytiTmJETlhUWm9zSnJqVWZPTisvdTFw?=
 =?utf-8?B?d0FVMFdJUnVWZ1FVL21uRVZwTVY3RE5rVm1MWGpIRG90ZmpnTjFhR2hlZEth?=
 =?utf-8?B?T1g0cDFQTE9EdERZNHNHSjAxbHh5UGgvUC9vWDE1SkE1Y1BON0FVNHdBYWlv?=
 =?utf-8?B?Y0VWYlBYcTAxU1JCTmIxZklZcnd1MDFuSnhKR2J3czRwTndKVjNFT1MyUXU3?=
 =?utf-8?B?NjhCaUxqY0dMOGJENE9Femd2MDhtSVQ2R3J4UnJNdFRkbFpWeVplc2w5YVZ4?=
 =?utf-8?B?MUFFdWdKNUUzYVdPd0NRM1VMd2hKTStsRE5Pa3g1QnJobGlKMUJvU21tOFJQ?=
 =?utf-8?B?ejdLZ2twUzFzZzhFSmdONDFVdHhMbWdIOTNSWTFtMTM0SjMyc281czZLTkVX?=
 =?utf-8?B?VDVvL1U5ZlVLZHhiYkFKRWhUOWVjc3pqN0RoQ29UbDRYcllyaWg1SjlUdE1B?=
 =?utf-8?B?SDNMeUhxQy9pd2plUlhLQnBON3loTUFPOXFtRlFrZ2NXakVHT3lrOFFtek9q?=
 =?utf-8?B?TUFTcW5GelU1c0RmSGRqVEVFWVMwTklMakhzNWRBZXlycnowa29pcmIraUJ2?=
 =?utf-8?B?ZHZTekpFZkhrVE43ZDRrVFlUUUhwWXpvckgrKzRmSXM5ODZXL2k5dWFlT2xK?=
 =?utf-8?B?TFRJdXJpZzhXS3BGclhEcFdJd2lBa3ZDaDR3dXR6Y2x0am5mTWtpbzVOSnhD?=
 =?utf-8?B?dzB4VlBqMkZzUUltakI3azFuYVRyL1Nrb3IrWERmQWNRZXhQcmVVOWJMM3NV?=
 =?utf-8?B?VnFsVnNOVlJVVGp1T0xKWmNHTXpDNVNES0xGbERRMGc2WGRHZjRvK1p6VUxQ?=
 =?utf-8?B?akpKdXQ3MmltSUlUeERrcTdwcHRieG9XdWFETGxUZmdnYVlXQzZ4Z3FlTCtZ?=
 =?utf-8?B?YUY5MW1OYmtORzJNNkJVT2RoSTlNMXBuTUljdWxQNDhmTFpEdDlBZkFkbDVh?=
 =?utf-8?B?MGdPd0xiRStXOTRFT0xnNzRzS0ZVaGgvRXJEaithY2xDck1hWFNtb2ova3o0?=
 =?utf-8?B?d0JwR2FFQUVaOTRLMzhrbjNBMDI4RUNVQ0l1MEljSmVueXd4SEhDa1FZMDI2?=
 =?utf-8?B?OGlteUV1M0hiYjZTTm5rUHNuQ2NuWE9OcDF3c0V3Y0k0VGdqYUFDNHhaTm82?=
 =?utf-8?B?MWZ6ZUNpNmZONUJTRk5sNGw0Q2pZVE1aLzBxZXREMEliTGJYNGRRbGNScXNx?=
 =?utf-8?B?OVZRdWFrY2R3TXZSNXVxT2ZUc3c1b2NyTmVYcGZ3TmFhcC9rUzFqMHRHWWpa?=
 =?utf-8?B?SlV0MzVrcEJodmxiNDNoaUUwclliVTZrN1psYnE5TzYzZHJ5WHM5VnhIRHhO?=
 =?utf-8?B?cEp6MksweDd0d2lISkJRL2x4dThtcWE3ZTUwdzdZQVdlV1gxVkxTQVJGaVpY?=
 =?utf-8?Q?4q1qi7NhwpN2g4pAygHea4FK2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c91445-f1f6-45e4-b383-08db9ff2a445
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 13:54:29.3931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDo7oHkXeAR0bPvRGZ0AutdwGqy2qynIxtVvB0TqP7VlrlWF8ckrWK22VHVZ056ArwkJekAZFeju4NzDAmauSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7820
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/18/2023 04:19, Rafael J. Wysocki wrote:
> On Fri, Aug 18, 2023 at 10:21 AM David Laight <David.Laight@aculab.com> wrote:
>>
>> From: Rafael J. Wysocki
>>> Sent: Friday, August 18, 2023 9:12 AM
>>>
>>> On Fri, Aug 18, 2023 at 7:14 AM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>>> changed pci_bridge_d3_possible() so that any vendor's PCIe ports
>>>> from modern machines (>=2015) are allowed to be put into D3.
>>>>
>>>> Iain reports that USB devices can't be used to wake a Lenovo Z13
>>>> from suspend. This is because the PCIe root port has been put
>>>> into D3 and AMD's platform can't handle USB devices waking in this
>>>> case.
>>>>
>> ...
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index 60230da957e0c..051e88ee64c63 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -3037,10 +3037,11 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>>>>                          return false;
>>>>
>>>>                  /*
>>>> -                * It should be safe to put PCIe ports from 2015 or newer
>>>> +                * It is safe to put Intel PCIe ports from 2015 or newer
>>>>                   * to D3.
>>>>                   */
>>>
>>> I would say "Allow Intel PCIe ports from 2015 onward to go into D3 to
>>> achieve additional energy conservation on some platforms" without the
>>> "It is safe" part that is kind of obvious (it wouldn't be done if it
>>> were unsafe).
>>
>> Just say why...
>>
>> "Don't put root ports into D3 on non-Intel systems to avoid issues
>> with USB devices being unable to wake up some AMD based laptops."
> 
> Well, both pieces of information are actually useful: Why it is done
> on Intel systems in the first place and why it cannot be done on AMD
> systems.

Thanks guys, I'll add both in next version.

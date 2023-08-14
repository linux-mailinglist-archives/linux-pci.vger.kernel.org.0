Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD2A77BE4B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 18:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjHNQme (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 12:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjHNQmK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 12:42:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B66D113;
        Mon, 14 Aug 2023 09:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxX6Oy7+f4KQmkdQpc8nEVPdrR8cfKvE572wXJJWeoWhUml/7Kh6ziue1KMIt6Vi3uMjKegGIbpzv60TMPXnIoNsdHxy2OoXIlVyeYKHd48Ts1mtsyHALjUU51aR3GZS0cdevlPtS3SKIhZbLLAoC7/WBgjNbilQFdFJWyjV+UGKpLdPGeApXLCenWkoFIaSBP3d4H6Bdl6ssNqcEyIG1xL/hktoRXrJZAnpp8eySDaXhdbJ1W5Ti0BvkWyWSqEIKr3LP4k94QKiOGLwFTmcYE1sc6t2SEve7eU5Aj3QOVMzcKjlV+ue+77UsDeKfDUenmkhoSCWPo6xBNYw8TFltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aS6Qo3q8fZuZbeNVqRiEas87GlueyhfmF/tcw0ZXzfg=;
 b=Hwo0I73geOHLW8sU8r8wL6OvX2Tdg4/KcBSmdoxHdnnPYH2bZTXbSuhwnESn+sZH3Tt+q1iosoNaRxPxmFQz43JDgvtpdjnQ7rkDZDnNo2lOcUbsF3YtsPX7cuxud1LzWfAPU6hC10ib4o5UOh32e580d1yIRbPFovdH5o5v7u9rFscJQHU1V1IFEHN5t+DEQMYUOvz6sgwFRCWPIZ2hagBeuyIL42E2RPjrkLSC60dg6tHXklz+p5mP+wogiIXJrNcZ2V5x7UulvPvGQvpr26s2KUTqXdJRTvb6dprjoQSQyRwTwLbRln5fPr4uknq5rz+99VGAvl7o/tQtpeUlIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aS6Qo3q8fZuZbeNVqRiEas87GlueyhfmF/tcw0ZXzfg=;
 b=dJt4FbgEaPuLpXOLvGq6xFlZISVetFqPRfP1QPC/8440j3OBA+pLGGRvujIgpHdNgaV0fmkQnjZpTOS5aERm3M/KgqVP2JNVoXUJ7cccbD8ocmQ7REEtg4LkxfznRiFNPQGLmbkOnCGj56OxCJcNf9iyjAksEwL06b6TMRw9fwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 16:42:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 16:42:01 +0000
Message-ID: <4f218a49-e4dc-4a6f-8f80-338ed4dae207@amd.com>
Date:   Mon, 14 Aug 2023 11:41:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: firmware-iwlwifi: Wireless AC 7265 lacks D3cold support
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "usa@junocomputers.com" <usa@junocomputers.com>,
        linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230814163528.GA177266@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230814163528.GA177266@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 1718d389-aff7-4857-2ae3-08db9ce5622c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18w1YlmADEP4ql6LgYZL1kJ+5cnNfZnvv3eFw/fYylykKw1/5k279Crl+XtDQA7LEBfOb8b4z049bGMTq2zcb78Z8MxsCNLXD65qxLEKPyBsNfTP2KwfYzco9fjh9Q4CMF3ZLJxjgjaPlff5j/G66INsL/Dw86+B9AERcuogN4rhROk5JvNfB736TszbRG9dBXa6LC9leg+GdH70kASXbZ1u5tBjfNDSw3gu1mVRahUqsGBN8BMpEIfeBtSWraITedKIBef8AI+Teq5G8gfLC6EYWKUyuZJa6KBijaYrnjWbh5U0d4zjLJUIKyUtsWIXPTuE8bkbkuv4ySXzTIoORw/X//LVBNuCorZRbT3eqT5VzyuhkVqy0WBxcaqYOxSJFU4Sb/n4ZIBsgdE0i52HMTwPt7eds8RQ1xnGMPTHl4khDGItzZb+gAeuKJA6Ueeif2tcxg4BvnM+j8DyJnmlQiwE+bHWiK1SjOOG9zTRQHoeWjX4YjEvczcg2iDzrWK5MEfTcbJRwNhuFRB3CG68wwy5lFfChV8iiEoKTHAjwmXzQ17kZV8zithmYGVfiwe91iU0WsispbdGyXSyGDbEZfqUCOn71SQtP7rKqHCjlxKGbZtyxQ6Z7AoQZnKoP1KlcPOoIgdcJiT+F4B3TxyjmbS0O6shG5r8ab5Iw4CtLgE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(346002)(136003)(39860400002)(1800799006)(186006)(451199021)(66899021)(38100700002)(36756003)(86362001)(40140700001)(31696002)(6512007)(53546011)(6506007)(2906002)(6486002)(6666004)(478600001)(966005)(31686004)(2616005)(26005)(83380400001)(316002)(110136005)(54906003)(41300700001)(66476007)(66946007)(66556008)(5660300002)(8676002)(8936002)(4326008)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDU3UTg1MFM2NjgwdzBTTE9ncnpOTG5mc051NkdCYnZIcElTbW9WcWpsU0o3?=
 =?utf-8?B?dEtQaHFTSG1rWDd0Umx6cVZROXhqMG1Na1FYb3ZhdnZYeG9lOTFoZ2w2aWY0?=
 =?utf-8?B?WnFzSjN3VlFhOGthbkpTQjBqRm9xRndPUEZKSTh2OUovakQxNVJRRGU3OXV2?=
 =?utf-8?B?ZnVucC9td3ZESGpvTGxCRlhzdGRsSVVPbjk3bkNrVk51V0FCbW9WZURyS1lJ?=
 =?utf-8?B?OW9neGNoVnhRRGRQbExYY0tSc3p0N0Y5enRIYUF6QlZnaEYvS3huWWxsdVlM?=
 =?utf-8?B?aitETlJtU0oreG5ZQUY4Uk1Ba0QxMDdsSXdLVFVzd1AyR1psRWsvS2xJV2RV?=
 =?utf-8?B?czZaVVM4emRuaVJJT2xkaXkrUkJPSWUxQTUybmlyRE5zZzAyR2pGalhUSk1C?=
 =?utf-8?B?UDVUbE13RVlTenQxbmRhbkVpZk5XbDd2NlBTU1dIbFdlSTlMejJsRnc2cFE3?=
 =?utf-8?B?bGVDUFIxaERCOUN2b0JYeFhuWVlMVmNITUIxVlZORzg1Yjh6REVDMkgvSndv?=
 =?utf-8?B?OTROTUtJM2p4M1hwVmkvcHFJdVBDTnRScnRpQlZHSnFuQkZMUUM5cE1QdWl0?=
 =?utf-8?B?cE1nRHg2bFRtcVphYitsQkxCbEhTRkVWYkxGRVhCUHJsOTJuQU5WMFRzMjB5?=
 =?utf-8?B?Rk1BaVhEVWFjYmUvN0xLTnV0cFRtQ1NWNGhPVzEzcVYrQW5kZkRGN3BHTDFL?=
 =?utf-8?B?YTUrV296ZVBpTDNaU0xRaGNEcDlCSDJJRGV4TFpYQk5FTjhLbVp6VXNFRW1F?=
 =?utf-8?B?ejl0OE1iSWtXYU8xa2xRMzdCd3drYmp3TEswMTA3L1VQVGoxVkdHYTlXdFpx?=
 =?utf-8?B?TlFxRk1YNVQ5aHVvTStQSG5NZXBXNUc1aUhka0hqVUl1S2hSOEhUQmc1TDhW?=
 =?utf-8?B?WkRzMTRiWTdwYTk5aUFydEpwbVAydktsMTBobUNTOGhPMTZLaEN5T0lmUzN6?=
 =?utf-8?B?dWxCNFBkRXVjSVRyZi9laGVVTHFaUTIwa3FDNVZEYU9QSnZCU1BRcWtTUWZL?=
 =?utf-8?B?UTVFNWZja1NOaHFscXlhSTk2OFBsaEp1VTVRcWY0Y2ZRWnFPQWtvUVlpQ2RU?=
 =?utf-8?B?UzZCaDZEOFo2MjloVm93cWtKUzhwN1Q1RVJpNG5tSGVZZXlGeGNmZGliY1RL?=
 =?utf-8?B?ZmRQMEJOOXpyYjByOExoZTVTcFd2VThyRzdrRkZzRVpMS2ZoNC85NitpYnJn?=
 =?utf-8?B?NGdyMitYRUxxK3FMcGF0OUdEVENXVFlheWtXdVdzWUFjV3I0eWZVeFl4MUNV?=
 =?utf-8?B?U29pM3JRZWdXSHB2ZHB0aTIxN1NqdXFkYk1kT1hoUWpOck82WlIycVBGQlRv?=
 =?utf-8?B?V25ZZXdsL212cUtBMFkyVHJPaUJVZTF2RjBNeTJkSkh5ckVJVERPdmVFd01B?=
 =?utf-8?B?V0NuUWtjbW1ZZkZtR1Bramd3bHFTQU1CU1doUmNaR1FJajBwYVNwaXA4Zlg2?=
 =?utf-8?B?Sy9XZ2Q2ZVBsc1Y0OWxQSjRwMytlaW5ieUpjUzFFSHR4eEhQbGQ1Q1BsWm55?=
 =?utf-8?B?ZWhvUFlZdS84SFBCOXRkaVV0b0NtRVhnTnJzcFMreGU3VmZJWHhLdi9LbGNv?=
 =?utf-8?B?WkVaT3dTMXNWS3QyL1FVeHg3VFlSTERYT3RmOUZuYjdpTnRnc01ZWVpLRCs2?=
 =?utf-8?B?Ri9jOE9iNnMzaDRMOEVBU0cyQWd2ZDdUZTdRRkZ2RSsvTHA1MjRXQVFJOXhD?=
 =?utf-8?B?d2g3bkJxL1JMTlN3bDZ4TkFRN2JRdC9jbi9kaGRRWXhqYkp4bUo2cXNFZHJp?=
 =?utf-8?B?MHVpS1hGVHRhZXJtSWVQaFFTM21oQ0hxWFErYkp4TngrRGZ2eW51R3JXclE1?=
 =?utf-8?B?Y21YbFJ4bVpqVEk1WXdvN05zQk5wcU5KR0I3SGpNVVduZTMrWWszNlBvY0Rn?=
 =?utf-8?B?Z084WnMvM3FtWi91UUw2NEozY09TMGl1dXV3cVFHd0FQem90Rk5oTS8vdGFB?=
 =?utf-8?B?RzZpTVQ1QUZnWmlndllmR0F6Nm80Y3piTUJoSGxGcUY4OHYwcnlQTlZ4RjMv?=
 =?utf-8?B?OThleDl3MWpDbFB2bGNOeGtSRlVET1BJTWZvTGNYdU12TDJZbUNibDRTNDRK?=
 =?utf-8?B?UjhJOUJXOVBUR0xuZXlTVWUzbStJb3J1WjNIbHU3R0kzcU8yaDBKaHQ1ZTBC?=
 =?utf-8?Q?TI0Mxh6BZyxoanlq4uQFk3hWL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1718d389-aff7-4857-2ae3-08db9ce5622c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 16:42:01.3531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cu0l0SIaQ6EtCSIU5tES8360BekT1F8eVUohvLbSepq8crChlEvtzFgwGFGI2+EzHt716h1A62g7JKBZp+6VWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/14/2023 11:35 AM, Bjorn Helgaas wrote:
> [+cc Mario, linux-pm]
> 
> On Sun, Aug 13, 2023 at 03:33:21PM +0000, Greenman, Gregory wrote:
>> On Fri, 2023-08-11 at 15:34 -0400, Juno Computers USA wrote:
>>> Any updates on this?
> 
> D3cold support has been a problem area, and there are some changes in
> progress [1] that could be related.

Yeah; no harm in at least trying this series.  I'd love another data 
point with it.

> 
> Could you possibly collect the complete dmesg logs (with a recent
> upstream kernel, e.g., v6.4, if possible)?  And the output of
> "sudo lspci -vv"?  And the contents of /sys/firmware/acpi/tables/?
> You can attach them to the Debian bug report if that's convenient for
> you.
> 

Yes this could be related but it will come down to
1) Whether the root ports are considered power manageable.
2) The system uses S0ix or not.

whether the series could help as it stands today.

Please CC me into any kernel bugzilla that you open against a mainline 
or stable kernel and can capture the lspci output, the dmesg and 
acpidump and I'll look at it.

> Bjorn
> 
> [1] https://lore.kernel.org/r/20230809185453.40916-1-mario.limonciello@amd.com

BTW - Bjorn, can I have comments on the last patch in this series?  I 
have fixes ready locally for everything in the earlier patches that Andy 
gave feedback but I was hoping for some feedback on the very last patch 
before I sent out a v12.

Thanks!

> 
>>> On Aug 3 2023, at 8:01 am, Juno Computers USA <usa@junocomputers.com> wrote:
>>>> Dear Maintainer,
>>>>
>>>> If D3Cold is enabled from BIOS the tablet boots without Wifi.
>>>> The only two ways to enable wifi support is either by disabling
>>>> D3Cold from BIOS (not ideal) or adding pcie_port_pm=off to grub
>>>>
>>>> [   12.681303] iwlwifi 0000:01:00.0: Detected Intel(R) Dual Band Wireless AC 7265, REV=0x210
>>>>
>>>> This is needed for our new Juno Tab 2
>>>>
>>>> https://junocomputers.com/us/product/juno-tab-2/
>>>>
>>>> I also filed this under Debian bug-tracker.
>>>>
>>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1036633
>>>> Thanks,
>>>>
>>>> Giovanni Caligaris
>>>> Juno Computers USA
>>>> P: (215) 509-5472
>>>> W: https://junocomputers.com/us
>>
>> This device is very old and actually already EOL, so I'll not be
>> able to get any support for this internally. D3 works fine with this
>> NIC on standard, off the shelf laptops, so I'd guess that the probem
>> could be rooted in the tablets' PCIe hardware or maybe the BIOS
>> itself.

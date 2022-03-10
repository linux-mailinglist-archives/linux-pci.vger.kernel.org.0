Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37EC4D4FBB
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 17:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbiCJQvk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 11:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbiCJQvk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 11:51:40 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84725198D1E;
        Thu, 10 Mar 2022 08:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646931038; x=1678467038;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j7MmyBas9kG7VrEgd2f/Z6j3EBVr/vzxTWqC23LVLhU=;
  b=Um/VM/axbTghWKHhzD6P85VRsqTlpzwfN9SbeHNHhX3UzpsK+rrPuV2d
   CJ4n3bgO1waQ9QNZ3GkVXEa7sNHzZ3Gl6fNCvJ8ApBqKONfJwkRrtiPB8
   fynHpkOimzThy0lPwZzoUOU7t+Z5nHROf94TOmInTDqjHHJ6jyUnM4GOn
   AwSUE4y9KmmEzEBz+yiqkejwV45DU6jdilw2EAfkmfLWpkFeAllcdBs9G
   y2YaqtSRhd/IYIazotNOC6TaKjAaqS8gbiuadfyMj9oIqaOS5FQbIws47
   nidNXCaGqJmRen9/bv20j6p1ZFJa6U5PXB8rMNTmFT3/Qkq8QB0kH6U/c
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255039536"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="255039536"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 08:50:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="688718147"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2022 08:50:37 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 08:50:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 10 Mar 2022 08:50:36 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 10 Mar 2022 08:50:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XISLGSxkeDJVfrH75u5QUZbJvOp24Tik8RDWizcU3kr+0u8uRdnk7qpPAJUdRyC8ETqUYcH6tcIH3kbFDSKR0nbKFOYU87tLtlCQ+sNBt90Kip1d6Pz4mLxsLgLriPpnbSaCKccjRxz7kfrOA+3wID0BJitB/rtcQvVWaDj3owTaSMGBDnq9FtGLUeaRUDXYr7Q5mNla+3nAfky0R9qaK8j1ZlshpMbiAZ8oAGbwycdoP0KUj/IvaQ3qJicvj8sYBsJpcZhUdhJQ4LKaFY7LVzrUa/4oh8i/hCOZP5UUAo4agZkmNmsFluodLce3zwMR6FfunapWXKFLstREiMtKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nOd8FBFSSZvqk8PM0Snlmlf+rTYa5SbHbfKp3k/lcQ=;
 b=UfNyGABp7KbEWjzCm669HKSpdWbNeKf9hTYKFqEmOoPjKl985g3HeB4Q2Yeiu8VvPckBzkyE967sz/Ju1RB3xRyh0kgI8+2yhjH1HZq5T3E7sOhpoAw6JYIt4fyClLKHpeRVk82KBsHg0RoveLLHdbLjcYQNxxUOmoO7B28G+/mZNYyMwPPz6OtvbpeGUrZKe0gcdipdxDRrD63N7nA+xLfHExZxJJK4nrlqBdcLP1J8GV1AUrcDuKHLwwgmuw8cm3WlMgNcjt90KE1d2Z4zAES5EBN8Ja7RfocfoIHE/1xL9T+L8oAZWSCkFPNE0RIZnlK22jbEVIlknVXz3w0e0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DM6PR11MB3292.namprd11.prod.outlook.com (2603:10b6:5:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.21; Thu, 10 Mar
 2022 16:50:34 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::dda5:a04:f265:68ad]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::dda5:a04:f265:68ad%3]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 16:50:34 +0000
Message-ID: <187b2408-061a-cc29-97a5-d2e4bc91f3c8@intel.com>
Date:   Thu, 10 Mar 2022 17:50:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH] PCI: ACPI: Don't blindly trust `HotPlugSupportInD3`
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        <Sanju.Mehta@amd.com>, Linux PM <linux-pm@vger.kernel.org>
References: <20220309224302.2625343-1-mario.limonciello@amd.com>
 <YinLNvaH7+yv88QX@lahna>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <YinLNvaH7+yv88QX@lahna>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::20) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd5575e5-73cf-454f-b53d-08da02b61865
X-MS-TrafficTypeDiagnostic: DM6PR11MB3292:EE_
X-Microsoft-Antispam-PRVS: <DM6PR11MB329233DCDD85463702C06E32CB0B9@DM6PR11MB3292.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V61WxGumUGTqAAzxtyV3cYvKj+g4KiHC9P5MW5AX73ysd/NC4jVoQKCvnclDs+f0gbh1s2NcKFOP+X/wt/SRK/IbNmu+tTaCcTEE8NYisYiKQdR28BnmTTpZygSoHdrsIerCHE+mIEa96VI9yDwjny+iZ7G7EmY/B5eysepL+OMvW/Ak62H+02pY9dk9XKjDY6c3nhJesK5D6pxVqh6YDYNvp5bfMzsYlHzliREDjFiquaow4/oWy44OrGwnK3FvLY+oh5hyDqKRNS6EEpgH3aTFFSfFOMf+ywO5pooVWglnrZ8rSE/MzR+Y9qzfZzpGoofQ2zLbF2QfLBQOCwEf0lhuCRmhWuxNluAyld7ccz9gsUSNuifZyFFDUMtw3EwQzyThIiACCIch7s+zrmnICZyAHdtSGLTPoFCXHRi0Z5trx+sq3CXQZZc1YgtO66Z9XzF7X8dJg0t/iCVxM41oLebOOuRd1ubETnBsrE8FpNYWj82Pgq0F+kg4OZNqTOelwW1HzrJsD3uTYafQgvlsY22SPCFmmTAun+2gkJih0kUiDtDvmKORGLQDHFmMQVM8tRObnvWaRrfhbDAHL0MOJOAITXAew1z3wtkWfwpnQOuCqeEIwXGU0uPy/LtFTMbSnQBAm863MCYmSRKM36bkrKq97B44YFJA6IQcMpkjMgFpUy/FqLu3jI+7L7MHroamCjCBdOyC4QRlMM4DtacFAtwYs1hx3NU3WYtG9IcQEwptdHFw28F0VL9iRJAfXblxU1In4IURN09/CY/Cqpa83qKG5rPf+lAvZQhCxv0CcEG0W4RIdif6Y/HMIyJCU8zk7ncgOrhtkXnd/YhdmNw+w9D0XAHZJ8v2eArIBHuup27wPf787sv6H5+6g54Y1ce2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(366004)(66556008)(6506007)(6666004)(66946007)(66476007)(8676002)(316002)(38100700002)(31686004)(508600001)(966005)(110136005)(54906003)(6512007)(2616005)(8936002)(36916002)(6486002)(2906002)(53546011)(5660300002)(36756003)(86362001)(186003)(26005)(31696002)(82960400001)(4326008)(81973001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0h5RUVDOFphUktXWjZaTlBZdm5yZTR3eGdXUEhEVUU1TE9ueVZjdGpOR3R3?=
 =?utf-8?B?cWJJWWJSdTVyWXlzMnRUTGcwT3Nub1NtZ1BWM3JRQ1EzOGdQUHJNMHhkVmNJ?=
 =?utf-8?B?ek41ZFg3MUtOcXJJTmtXNFZrc2VvNEUrY2FrQlVDYzY3ZkRtdnYvOU92VWE1?=
 =?utf-8?B?T1lFLzlKc3hOSkJSa1BNYXpIVm9hWEtLVk9KUS9wUDNKUTdrQjR2aXlhcU8v?=
 =?utf-8?B?YVcxbG41NEhYdVVhMXFHS3BIUmVMSEpJUVVPSkdtY2cxUndjQnlRMW9zRkt5?=
 =?utf-8?B?R1RaZTZEQlRnVW54MExEbXpBSW1wRzArY3BxdklxUEVidWtKYWdJZ0xpT0p0?=
 =?utf-8?B?dFFVYmJSd2hTZ3RRT0hwYTA4NXVuUXpNMFdQbnVZZHJsRGtzb2UrY0FBUkdK?=
 =?utf-8?B?K1ZXcGtaZUFKS2RMeUNNUDgzWnBhS1dyemtMVnZ5UjQ2QlFtM3Z1OWp4cDJT?=
 =?utf-8?B?ck10c3E1TVN4eUdMQzNWeGhVMVlGbnB2ZzFJT0V0Z3VlcG9OMnhlZUVwMENG?=
 =?utf-8?B?b2lML2RDSC8zY050UWI3ajk2ZXkvUVplY0JIYnNENlg3NlpxdnpYbmFZNFhs?=
 =?utf-8?B?M2xzZzIxZHB2TTFWK2MvaWpTTFpsVlZUVEd5c1ZOZXVqcmZKTU5FZE10M2pk?=
 =?utf-8?B?VXlNVUVRQ1R4QjNXVnN5ZktpREIvYWVRd0x6eldERkdhN05LYTBqZi9GUnB0?=
 =?utf-8?B?T21ud1JhRUVmMUZyY1YzOFJCQ01SNkRyWXRZT2t6bDBMWVFGZm1PbEVyT1h1?=
 =?utf-8?B?QnkwL242enBSc0J0OVZDV3pNbEtkY3RQajg2bXRCUXQvcnNUTm4zY2NybjNi?=
 =?utf-8?B?ZXh3Q1czdEdyOXk1UmhucmtJclFBTmdWZ3RUZ01TMDFud0c3c2xVWGx6a3B6?=
 =?utf-8?B?LzhibUlYeTNSMXVzWXl6NVczTG9qcUJCZVRTcnkxMmtNTjNBNmd3Q3dkQ3RW?=
 =?utf-8?B?MnZFejZFb1I3QUMwZVFxR1RaN04rc1FkZ01tT0U5WFVVUXY0NUxybThxQWh2?=
 =?utf-8?B?dWcyZnNLQ2I2aVFuYW5EbVFlbWx2RktTNkF4SjByOG10b2lscnVDeklmbGsx?=
 =?utf-8?B?UGJlUXY4VldKRjQwdmpKTExjOXdON3AwejZhRWxxLzUzaEVxL3QyemdtUVFz?=
 =?utf-8?B?Z2E5cnEvbXdKdkdLVEdEWVhLanZqWW5lUGVOM1F4c045NWNQQzV5SWJPTURv?=
 =?utf-8?B?VnJXRUlsY09VYzFDYUVYWVJpVjBtZzU4QVliQTI3bHdncGc1T2Q1RWF5MG5F?=
 =?utf-8?B?clBlQ3cyTy9IK1ZSbDViTTNxNlAwb1dvcnpHUVVYQVI3LzZQeTJ3K1piS2lh?=
 =?utf-8?B?TUxlVGRKOXRuRU8xYlpUWU56WlFmWWV5NmpUVDVIb1pYUlNLUFN0RmpWK2ZR?=
 =?utf-8?B?QU5TY2dNdjhJaFpvMWFxS2dwMnpubFZwUE0zVFd0cTdYV3dzNDZ6NXRKY21t?=
 =?utf-8?B?SmtaZEdHNmJwemdKbjFLZ0ZMbldJS1g4b0kyeE9ZTFZQQUQ1anpYdFBvbkg0?=
 =?utf-8?B?UkI3U1R6dno2Q2k1OWZWMXFIUXlLdll1SHZRWkhNeFg5bmlYOS9CV0MweEVH?=
 =?utf-8?B?c1Yya2VVNG9ITjVDNHpZbVU1VFNGeFlDTytaTEZudTRUMXVOQ3FneWlaZGFn?=
 =?utf-8?B?NnRqUTFzK1NaRVBmaWY4bjd6WmhTbHpVeXVVTE5zKzNBL3YvR1QxZVd5aGVm?=
 =?utf-8?B?OGgvdGVCb0Zxc1ViQ3Z2RU05azNvWDEwUHhCYzRueTJGYkVpQ1lqQjVzVXUw?=
 =?utf-8?B?ZlBJTXdaaHl2cWdzN1VhUG5TdTVpQXM2RnBtYU1OdElKQVRDZTE3T2I5MWVm?=
 =?utf-8?B?N25GZjd5c290WjloQmhpQ2RTS1hNZVNUUFZUQlp2cW5DSU1ISFBOT2NpVFJE?=
 =?utf-8?B?NTBIbm9UL0p5N0ZkbmUvN0NDZDdXdVlvQy8zRm8yYXh5L2Z5UlJSZ2pucVBT?=
 =?utf-8?B?di8wdk9YblVZdnMyRnpBOU40TWNXaWswVW5mTjRISTNTU3N5QXpZODZ5MzBQ?=
 =?utf-8?B?cXJnclpjVzl3MWI1RU9xcFNkOVdaeGJYbzVLb3RBbHl3K0FraTVaMVZLQmh2?=
 =?utf-8?B?VEFVcU15RFoybnY2Y0I5clErZE1nNTZKVTFBS2hnZDBSS3JEdndPN0I0OGhB?=
 =?utf-8?B?dVhURFNXU3J2ai9pRVpza3pNdndDVSswVkZBczNlV20zdVk0YVVJOWhJak9r?=
 =?utf-8?B?amg0aGprR0ZBYmtEcUhzSElRak1MMlF1bUl4ZFo3ZVhlWTlKODBMdWRGYkUw?=
 =?utf-8?B?enRkV3NpUHlTZlZtejBJZ0pKTkt3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5575e5-73cf-454f-b53d-08da02b61865
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 16:50:34.5624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fv/X9y69qIPTVgJYwbvwlPzNR5WwLYMAh69Mu2YSoz9YLtdwgKM0PErlGtgSVp2if27CLAEpKW5is4KWLaqCPIWJxzDVsSseyMgskQIq3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3292
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/10/2022 10:56 AM, Mika Westerberg wrote:
> +Rafael

Thanks!

+linux-pm (all PM-related stuff should go there)


>
> On Wed, Mar 09, 2022 at 04:43:02PM -0600, Mario Limonciello wrote:
>> The `_DSD` `HotPlugSupportInD3` is supposed to indicate the ability for a
>> bridge to be able to wakeup from D3.
>>
>> This however is static information in the ACPI table at BIOS compilation
>> time and on some platforms it's possible to configure the firmware at boot
>> up such that `_S0W` will not return "0" indicating the inability to wake
>> up the system from D3.

It is "wake up the device from D3".  The system is already in S0.


> Ideally the BIOS should not allow this to happen in the first place but
> yeah we've seen all kinds of weird behaviour in the past so just need
> to deal with it :/
>
> I wonder if it makes sense to log this situation?
>
>> To fix these situations explicitly check that the ACPI device claims the
>> system can be awoken in `acpi_pci_bridge_d3`.

This is not too precise.

wakeup.flags.valid is 1 if there is a GPE allowing the device to generate wakeup signals that will be handled by the platform.

Again, this is not only about waking up the system from sleep.

>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html?highlight=s0w#s0w-s0-device-wake-state
>> Link: https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
>> Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
>> ---
>>   drivers/pci/pci-acpi.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index a42dbf448860..9f8f55ed09d9 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -999,6 +999,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>   	if (!adev)
>>   		return false;
>>   
>> +	if (!adev->wakeup.flags.valid)
>> +		return false;
>> +
>>   	if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
>>   				   ACPI_TYPE_INTEGER, &obj) < 0)
>>   		return false;
>> -- 
>> 2.34.1



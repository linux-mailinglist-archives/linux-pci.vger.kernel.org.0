Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149587C01BE
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 18:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjJJQer (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 12:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjJJQeq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 12:34:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8B397;
        Tue, 10 Oct 2023 09:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lsdt17dgz4UT65o7g7uJjNaxJDRtthQOsn45HjuvnNwNTleS77s6NcC05OsPf4fDzVJ6GVX1RjhgzgiMvndZvNT5Qiy2TAOmwLTTK/9n9g+DwaHtoHgBkQ6z2fI8av0cFQthb2yGUzxjJjxwwv45yvivtetnJjEP8RwP8kqySxFgqlkzWuI8Lq5ADRmvPpu8y2R1FJnDMnoGGeIw1LcHfX8p/RrSbTv/+VSReHOANKw3sWvJM0X+zLULCIaLRi8FhP7I7Vi4Rk6yj4ErbQNiXmwKxMnXFYMpQf+eTVG0i96R7BAjl5uPKRQtD+nAMzDRgPLPxzIcshUfgz2UCtU0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OstRbsQvgJS+ZbfpTllTDvpfvlMXtMMJIussT/krCN4=;
 b=BnDpe3RXPCedhYIvw3ZxqiQarFAujUlwXJab3nT5ic2FM2ueeni+6L1VT1q3ssWI+2fFwRt3mYLElGXJFmByqhzeayVpY9Yv+DMfMV3gtGcYy8cCpfTBnz1GrWheco0sIEFN440AWLEp8JVNyICRCKVb5SpZsz42QAOlEJDdtzNLfuhJZwg1qBkaHjk2HDx7T8CsCVA7v1H6CagHpLYzlraj6TwEHq0UU+Xu4hWOlFFwZLG4BlAiXfh6JP0UByApiNFWp9BjseVKVB0qSLlHpG9OsPApA8g2aCJkE73+g7yeERjDDj8ZihRthOPFekKKTIEjSnenVz897zaPKHKnRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OstRbsQvgJS+ZbfpTllTDvpfvlMXtMMJIussT/krCN4=;
 b=zeizVPrQJZVCatxpyEc+wEfQngMPeB9sgOHz9dMKyNIaHnMQGNq/f0PNNVqnHD7ZTjRrn6Ni4IuhQQ5bAG5kLg0Hz/LPAEPLnejSI1rM7FA+n9ShMV4BJoHDcPCun7qKChMFq4wXO3KqkZW5FkQFmwxeVa//um9HPKrn54W73Hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 16:34:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 16:34:42 +0000
Message-ID: <87bca301-f50b-4164-9b3c-c597dc26288d@amd.com>
Date:   Tue, 10 Oct 2023 11:34:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Make d3cold_allowed sysfs attribute read only
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, lukas@wunner.de, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com
References: <20231010163325.GA978803@bhelgaas>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231010163325.GA978803@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 9675d51b-fa44-45fa-dffd-08dbc9aecdff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZkW3HhxVfTDmefhIYbhvkkRWfk7423TyW2aB2oXz2I9mPbdU8tbVqqYd0IG/azzMt0oO8osXP5LJ28q8ix06N0YsJJYl1xVYKIiyylAQsXRrRqC9pkwi1BB7vJPfCOFCPr+bEDKJKxFDs07MRwuiDgfC5zbrn5wno+DXfoYkjkEz2zGV7VusDsJwMiqGmf4NFRANiioUwZAssXtcp8d1r1+FaazEH9O1PT2mqbxW0V6sFlwyYcq11ChILWZvX1ObI4AR+ROnieLscKwrl4S4wW3UL/0Qy3TnnOh3+SzzYFRMJEK+i14KEwUwCSEa74JM1e6tXnCG9EEZ9uFTghoe2BuNFEsgMqiRrGuTjJt+2RHBwheE9O6s59LayqUzCTCvb31szzMs6BkGmj2JMxEmw2VhEkgUIuVjWgGSiH46g1lLehf3TTGqWCpVsgMPmWvuLIelCyYqjcvtq3LkbXLrhxevv8AtREodzquEdBaK58yh3ctBfHZjKXSnVSr+IpW/X3JxAKbGPKndK01KGR5sqcW4VmtpQxxkd6LKu/34R+BXJTmSykPQa8YIrQ13wf/UcRyElLGVnu9vuEzboW9aU7PgwJ7BYKmL0oUFXONJ3wuNfgv9hJq0spN/mw8eqj8v19t1DalQYfEYQW9GH9KbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(83380400001)(31686004)(26005)(53546011)(2616005)(31696002)(38100700002)(86362001)(36756003)(478600001)(4326008)(44832011)(6506007)(2906002)(6512007)(8676002)(6666004)(8936002)(5660300002)(6486002)(6916009)(316002)(41300700001)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnFtVnFXV1QzOEsvN2t2c2I2UnVsZklrZXJlcUlERnhxQ3lMVFVMc2diQi9a?=
 =?utf-8?B?YkJ6VlhEYnozSjJHUEJyNXk4Ty9PVzZPWkRkbU8yK0JCMWRvZG1nMUdqbXdz?=
 =?utf-8?B?eE9DMTlDeElyaUk2UHlWN3p5U05ZRm5mbi9nTUUxSXJVK1VOZk51TUxkSzJM?=
 =?utf-8?B?aHpwR0ZybStNWjQ0Z08xb0VZOG4vazRkT253eU1Yb2M5OHdWQTByQUdZemFM?=
 =?utf-8?B?enBpait3M1UzcUtkUy9BSXJlcGpaSlE5bC8vamtlWitTdFZURzluUzdPcnVy?=
 =?utf-8?B?NUdENTk0Qy9XcFd0dzZHUGF3S01DZGZtNkEySnR6KzRNemo3b2JZNkZnYk1I?=
 =?utf-8?B?QkNjY01ZTEhQTkJPb3d2dEs3SVFlUGMvQ0dRZnhBenBkMzlHdGFUZmxFaWo1?=
 =?utf-8?B?WnNBTm90c09WNFFwVlM1aEhLMEVNRW1jU3JPTjRQRi9heVQrL1VnRWVTU3px?=
 =?utf-8?B?R1JvczRPbmF3RXFNUFpwK0RSSk5TbkF0K1dBQ1BWZWhIaHpORzd6akxxMjZz?=
 =?utf-8?B?eVhRY1JHVkdWYWhTQVRUM2JuTlBRSFoyTGlqTVc5RXcxb0tCUHNuNVBYRTUw?=
 =?utf-8?B?Q2I4amxnNEpYL0R3ZmZncHdzK2tsekcwc0hsd2daTjZCVUFwdklIMUxpdklz?=
 =?utf-8?B?NUR1L2d5UTBQRWlrdmpwMVBsZlBUbzJxTE1Xay9WRVVqdnlnK3dpeExWbmRR?=
 =?utf-8?B?ekM1VnFJNTlZUkY2WWFzbEFsRUU5MDlCQy85YnRoWmFsRVZzbE5IVkJFT3pl?=
 =?utf-8?B?Z2VRNTFEWDFMMnNwZi9lT2RTSXloN2Q5MVBNVlo0Zk1VZEpJL1hnWkJKSllS?=
 =?utf-8?B?L0swRk1NMG95ams5SmFHZHVMY1NiaGVIZ1djbmdYYUNsWDB1eWNRS0NROXRV?=
 =?utf-8?B?azVPcWhiTWUrU0QxSnJFTUxtL2Frck5GbFlkaHBlZzRuR1ErYUY2K3BsbFJS?=
 =?utf-8?B?SkdMbUhXOWh0UUhERm9JZ2p5MW53VGZxdUVtbGZKWXRZR1Qrajg0cXBHN3VJ?=
 =?utf-8?B?UHJhKzNMS0ZoUTRpUTF4bHRzV2VDcVloQW9xVjRiK3kvMWhJOU1WNS9hLzM3?=
 =?utf-8?B?RWpwSVh5SkNNL0dBK0lTV2QxQ1g2MStUUUpYSnRvMEYzU1FrbG5GcmUyeHpX?=
 =?utf-8?B?NUs0bzZPZDY3Z2ZnL21idGNqMTJwZS93SEtjSk54S2cxWjFCd0hXZDhNcERx?=
 =?utf-8?B?NFk3cGlaeG9GZnZlY3ZoSUsreTJ2VVZnVGhKMXlxUWZ1dVpyc2ZvVm02MW0v?=
 =?utf-8?B?QmZOSzIraXQvQUg3NFNXNDkvUTBvV0dYVWNFS0xNV0NTdkpxQ2YzeHU1Z2xu?=
 =?utf-8?B?Nyt2SjZHNkI0SXVIN0oxbkRtZnEwUXBhWDk0RlVwcmFUaFZzeWtBRlRWbkFX?=
 =?utf-8?B?NmE4NXlxK3ZleEdKbmM3eXBrclBmekc4U2FJcnpReFVOcGticUpRVFVHZ09q?=
 =?utf-8?B?Sjk2UWhCUHhhcEpFOXZKSXByZ0VBU0JkWFppYmxBOFptNndvMVNqbklGUi9D?=
 =?utf-8?B?czc4eUM2cUdveDRFNlBwYVRiK3cxa2wxcGpYRnZ6b0Nub1dtNlo4Vy80bERM?=
 =?utf-8?B?SDNlR1I0UFkvbjJzZ2FhUC9qRlNqd0ZqdGR4RGNKUVA2QWt0RkN6eGEvVHhk?=
 =?utf-8?B?dWtRZnpTOWFqWkVueGp4OVB2YnRrSkt4TGVNUjUyTGxJNUtpc2NqUFhvWUtJ?=
 =?utf-8?B?VUFIa2lBZ0QxQitvOFpKNkZCWEltMmJTUXdpcmpVVjNOZzh1cXpoUnY4QkhW?=
 =?utf-8?B?UFNlVytiQmtGK0lwVDBIUlFlV1k0ZTcxZDY1NFl5RVp5ZUZvRUk5VGJ5cUlo?=
 =?utf-8?B?T0cvb3EyVjBEVWU3UndwaXJFRW95bStKNWQ5YS9aVzR3ZTRXdElIN1BXOUla?=
 =?utf-8?B?dmFDZWZCNXFZN2QzSEhUWThaTUd6NDNmLzBBeGNiL1FQcGlSbXY3dkZRVEx6?=
 =?utf-8?B?TURXL1lpWE12a1dhTVVNRDJKb2VPbUwwSHRMbTRtdEF2ZHB4eWNkdHJNdkQz?=
 =?utf-8?B?a1RlOXdNUUtXbVdqL0dyMWs3OEZlak1tSmc2OFhCbXNRTllnOTdoWDhFS1dl?=
 =?utf-8?B?bVgyR01iNUpLampkKzhwdjNZTmtJcTJDVzRiQmRSa2FNUjlXK3crRGNuR0Z2?=
 =?utf-8?Q?RfLytnaPYH1oL66QsvQQRELpE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9675d51b-fa44-45fa-dffd-08dbc9aecdff
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 16:34:42.1965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpL/0WhW8ebRMKBp3PApdIrKqvPCQT/23BpKr1wxKgF6zUPP+/limbPt8htyXTwwbvUJea0EcEDlQnFN3NYZug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/10/2023 11:33, Bjorn Helgaas wrote:
> On Thu, Oct 05, 2023 at 01:56:27PM -0500, Mario Limonciello wrote:
>> On 10/5/2023 13:53, Bjorn Helgaas wrote:
>>> On Wed, Oct 04, 2023 at 09:47:31AM -0500, Mario Limonciello wrote:
>>>> Before d3cold was stable userspace was allowed to influence the kernel's
>>>> decision of whether to enable d3cold for a device by a sysfs file
>>>> `d3cold_allowed`.  This potentially allows userspace to break the suspend
>>>> for the system.
>>>
>>> Is "Before d3cold was stable" referring to a "d3cold" read-only
>>> variable, or to Linux functionality of using D3cold, or ...?
>>
>> I was referring to the previous thread's comments when I asked about the
>> history on it.
>>
>>> In what sense does the `d3cold_allowed` sysfs file break suspend?
>>
>> SoCs might not be able to get into their deepest sleep state if userspace
>> messes with it.
>>
>>>> For debugging purposes `pci_port_pm=` can be used to control whether
>>>> a PCI port will go into D3cold and runtime PM can be turned off by
>>>> sysfs on PCI end points.
>>>
>>> I guess this should be "pcie_port_pm=", which affects *all* PCIe
>>> ports?
>>
>> Yes.
>>
>>> Which sysfs file turns off runtime PM for endpoints?
>>
>> /sys/bus/pci/devices/*/power/control
> 
> To close the loop on this, I think these are questions that should be
> answered in the commit log (actually, that's usually the case when I
> have questions, because future readers of the git history may have the
> same questions, and it's not practical to dig the answers out of the
> lore archive).
> 
> Bjorn

OK thanks, sometimes it's unclear if you just want to know more or want 
it in the commit message.

I'll respin a v2 with the commit message adjusted.

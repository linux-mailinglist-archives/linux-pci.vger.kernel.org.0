Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2317DBE38
	for <lists+linux-pci@lfdr.de>; Mon, 30 Oct 2023 17:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjJ3Qq3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Oct 2023 12:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjJ3Qq2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2023 12:46:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795F198
        for <linux-pci@vger.kernel.org>; Mon, 30 Oct 2023 09:46:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OY7LOazvDCOih1rFc/ui0uVOw9Nkol1U466KKnzl8mqGUI08j2BzJziXV5z0nH8q1D1H0z2DwHSB8osIu1k/+NwUTnMRRlJkthDy+IGhjYXWczDTtuvzKhYmmFwbBAc06PFro/ITf67/0mc2G79/dG0FCY/xxVknTCMHY2juef/DhPyXU77JpgCzUp7a5dkf9tNZiuEntjztOM9QvhKgyGspxr6c7IAtiW5lPVmuf11ZxGKA2G1HfEsN9E8Cs5xbslViGg6dGwVYYO24S0pzIHYsawIoYPomjUsHoikMo2a4s64e43XPqjAFIBwG/MKFLen1vVfbJBU8p1sr8uIcxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXmpVRaz2XoA8kB8+3xcIXuY1LHl5GBUmX6WkajpcG4=;
 b=SBvpUf68WBZOaIGqh011ngHZ42Nl3jPEH9ltQHjw2TOb42UFgnuv70vnjzY5KY7NgDcffqXutktlZPevJpiDepzijkaZQQY0tI2Q4/xehqnCyAripINPVqzMqPndNLe+gR2jaAgfGBwqdyS3wZIr2ST1WJrMULgEOrUXTVO/9Qio/zOaUqn/CY3leU15zrEGAlWyhZ0uOR0kZnjbPiDzDm3mfgVGhgc5i8+nz0U7D2kpFdekq0CTjy7HnyQJ7eM7hSei8GRkjh5L6LQOE5ZAjRAVwePNaLtQLz26FakLeYH5bMYn5QhTuJoZIZJcr/ohQxwl8CvVJEcEFQFJb0ZDpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXmpVRaz2XoA8kB8+3xcIXuY1LHl5GBUmX6WkajpcG4=;
 b=2g9iIb0n/0YPM+167C7Cu50ZQ+GSD1DSdpT6v+j0kUbgHMFqXgvkMlY0lWbRLGRpz6Wsha+tWKR6+ylUbHXdnNBKI3gzOqmg3TyfFhB+J7jWlnPUFfxf7Ltnsm2HAf5MCHGYjUXsdg1eimmKl+lmxMMeQVWP74tbFtkVkQax2i8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 16:46:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Mon, 30 Oct 2023
 16:46:22 +0000
Message-ID: <7ad4b2ce-4ee4-429d-b5db-3dfc360f4c3e@amd.com>
Date:   Mon, 30 Oct 2023 11:46:20 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
Subject: pcie_bandwidth_available and USB4/TBT3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:5:80::37) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5229:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6ef4f4-fe0f-4a2b-548e-08dbd967bfae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vmMiX3l7pS03JxHr40tfRtdBYK0Kxf6yw+X1uxNRJjTF/k8IMI5/1vthBnWsm0JtqpaxcKEm/dSbDRQNQotM4tOUuzxHGvmvuK1P9Dl+QAkJZ1HGrwKwKANLYjPgQLvrW1WGDy9aPG4ZtbzcNej+dxz1QkorTbWwiA41s8CrG3VpZy9scWivj/6CDHadFI1YxTD4A5jH/tFQaFokm03dBNv2A+3nMUFRvkLlQmUqwXHPBKVe8cE8LTt7ND9lDgSav8IdUFLSFo4Ag0ykjV8ODsTnVm5ymBtzAXAlS0N82JLpetSpBFRh4RjpYdzSzPYLOuf0Di6cDCbmWzq0+DebtIrKyQYg5XPLRLIPpnHzAq+hb7sZzaIGS12TiR9E7I9pVn/X1knI6zmzWouGAkxaueFYpBhjspMzYszqX0BQ6SvnxrFQkHl6UuK1B6nV3CHVxoGIaAc76kj9ff9iqkRYeGH8u59ds3Gkl+Q1jj6GoGJHkDeC8pMj0HAFOWDFhwfHUtI8B01eKJjFOltvSr4lqtF4b7NWPdUka8E46Em+TQbe4CD6ncQW8XuF0CNPR1O80Hk/hxus44evQwYvhisxHlZl38hT/d/3wnk6jhuEfDfG0U1VOXOetkQmnFcS6Jmbj05V3P3K8N8MIYceIqWnxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2616005)(26005)(6506007)(6512007)(38100700002)(36756003)(31696002)(86362001)(83380400001)(31686004)(6486002)(966005)(66946007)(2906002)(5660300002)(66556008)(66476007)(54906003)(316002)(110136005)(41300700001)(44832011)(8676002)(8936002)(4326008)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1RMZ1JZUXpaK3lVSXNrU2RUWnNlcExzTEFVOElHeGlHRUhEa0xub25HNC9t?=
 =?utf-8?B?ai90VnZRTnJEZFEra1d3b3hmQm4zVEJJOG0vemhrclJUcjJtenMrd01hV215?=
 =?utf-8?B?ZXpCZ0FOaDZ0UUtBZzM5ZUFnWkZZaUlhc3RCMUJWekdQTlh4NFlJUVNmaEUz?=
 =?utf-8?B?U0x4UCtNZVJEQ3FtSkh5OHlMdU8zeCtjK2F5MDF5djR1QllUa2N0TFpmbHhL?=
 =?utf-8?B?OWVtUENHaS9Za0ZoZi9iMUptNGpaZ3YvWFQvalh1eDdyM1U1RUhnOFBaeEJN?=
 =?utf-8?B?aWJ2NXhmNmZUSTNhV0t6ZjJwY09IZDk1Z3ZqOVdiTHBGQVo4RjFKM3U0VTJW?=
 =?utf-8?B?bkpyalFmeXhzYlI1ZXY0eE5tU0E2cUozdVB3d000VnorRDNlQ2d4cms0VjFQ?=
 =?utf-8?B?TEYyNkljajFuRnRqNWVkWjYzWmtVSHR0UTU3ckFaRndZbVV0QjdoNU1YdlRK?=
 =?utf-8?B?TlhUOUs0SGJ3L21wYkVuVEhwNFBUbFZOajVTM1ZTOVlrQ0hqdG1ZNVZNQ0Nq?=
 =?utf-8?B?Zno5QktJQ3RjNHB3azcvcnRwdW1RUkl0bTF4TjFXa0paUm9rblJiTWQzL1l6?=
 =?utf-8?B?aTZyZEdYTnNSeWJ6NVBFb2wwRUF5S3FCclEvb0hiMXdEbXdaUkJ3U0V6b3FF?=
 =?utf-8?B?dUxzMmUvNEtYbmhoMkxmZmM3L05kandoU1NySFhHdGhxRDI1bVBwR2h5amNx?=
 =?utf-8?B?VTF5d2toWkkwVWVtRTU0TjhhUnB0aWdmK2VQajNGeXRNUHVoNENHMFNXdklL?=
 =?utf-8?B?bSswdkRmTFozRHozU3FPTlc1WG9XbXdsT3pMS3N3YWZodzY3YnNjS2UrV0RO?=
 =?utf-8?B?TE5mVjNYVWhIRjZUZHVFbWdRNWpzOCtUWFBieXhhRjBkaUhEN0h6V2J1M3Fa?=
 =?utf-8?B?RFN1bVhHWVN2TStYcnhCRGJ2blBPakxsWUxlRXBRRytCZW5qaExMekRERHhP?=
 =?utf-8?B?eXVKeEZ2MndaKzBjYld3UVc5bTFlam9mWjRaQ1F1czVaTnNzSGpOWVJzSjU1?=
 =?utf-8?B?TllEQXhoSGo0SjZhOWZ0LzJ6dmNCNEt5c3QvaWJObWdWQzdoYXp3c3pWRUpG?=
 =?utf-8?B?NFJjaHFjZURIYVhyYll1a1VaSE55MkRMTGxVVGU5b1gwU2hKRDkrVm9iSlNI?=
 =?utf-8?B?U20yWDdLUUFTdlIrZmtqUHRtOWEvY0tFKzRsNDJvMVJtS28zSTByOGxQbU5F?=
 =?utf-8?B?UHpQS2duU0xuK0RLa0ZZZU9nTkUyS2RnOEY5eVNLK2tiKyttYXQybTA4L1Zl?=
 =?utf-8?B?dW5rb0lqZlNReWZzOUhjWGRpYnlLeFMyYTNBUWZnU0h4QkQwd2syem1lcUV3?=
 =?utf-8?B?aWJYU28ra1B5RVorc3E3aE1EeXZ2a1NDa1IrTzNRR3E4cWVRUFk2aHBvOHZ5?=
 =?utf-8?B?eldDejk5TEROUFh2TklIcEV0enN2aFNlOVRZOThVeEFXQ3NTdjZVUDhuMW03?=
 =?utf-8?B?L3Q5a3NXdmxaRDVVU1Z6cVZ0ek5sSXlpekQvSVo4eHF1MkwxMVpmR2M4TDY0?=
 =?utf-8?B?WStWd1BJQTNqRU1DdXM1TnVQc1lBeHI5emhSRmtlTVpKd0RXZHU5NnhMVnd0?=
 =?utf-8?B?bzZSZ0VhRDloekdmVXdsMDFKNXpxUWI3cWxhS1plSS9uQmNJRFVsbnFHZkt0?=
 =?utf-8?B?WURVWDA5Tmk2UXNCUHB0Tlk1bnF4ajhXUzFTVDNlT3pxOFN2MC94eW0yL2F4?=
 =?utf-8?B?VU1WWXR3dzQ4czZLL3czVUw5UHBlZDVJdE14djFhcmJzd0VTSnhaZDJ3YWNH?=
 =?utf-8?B?Z0gvQjdSSXdwWXhSckZaOGpjNjNGelh2N1pXNEU3MXdabzA3dmM3aEYxKzdq?=
 =?utf-8?B?L2NEWHNPTkFWQVNFVlpQby84cUhEeC91eWR0emUyVzVNVTVCYnozK1NXTTl5?=
 =?utf-8?B?ZkNTTkw4b0V1VW40RldRdDZMUURSTjAyQWNmK2V4dEdjYmZ1Z3ZiSjFWT0Fy?=
 =?utf-8?B?Y3F5MjBrZDdmRG5CeEJnOWdsTWxOazJnOGhLbG1LVlVxM1lvYytWM3EwTytW?=
 =?utf-8?B?Q0NqQkQvQTJ2SkhrWXVSQ1UwL1hYNklpNnRtTENHOE5VYkxyeHFyUUNtOU4y?=
 =?utf-8?B?SWlzOThuai96T21NdVpJOVRsLzc1aUZoWmJqQkRLSGtyNER6aU9nTU9ySFVS?=
 =?utf-8?Q?5FGeaCBy/n95OKhWAvzMzr2Mi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6ef4f4-fe0f-4a2b-548e-08dbd967bfae
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 16:46:22.5129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: meviWNRUYHyHIZvzO/Sc1BK95L0agHXvdQEb/fTRkRRQNZd3PhT6Ml8T2Wawuxx3ld+67HVUMtWE/eYmTTClNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Recently we’ve been looking at some issues with AMD dGPUs being put into 
a TBT3 eGPU enclosure and various issues that come up.  Several of them 
are root caused to bugs in the amdgpu driver that we’ll fix there.

However one thing stands out is a performance problem where the cards 
are artificially limited to a lower speed than necessary.

The amdgpu driver uses pcie_bandwidth_available() to decide what values 
to use for the platform speed cap and bandwidth cap.
The value returned for the platform speed cap is always hardcoded to 2.5 
GT/s.

This happens because the USB4 spec explicitly states[1]

---
11.2.1 PCIe Physical Layer Logical Sub-block
The Logical sub-block shall update the PCIe configuration registers with 
the following
characteristics:
• PCIe Gen 1 protocol behavior.
• Max Link Speed field in the Link Capabilities Register set to 0001b 
(data rate of 2.5 GT/s
only).
Note: These settings do not represent actual throughput. Throughput is 
implementation specific
and based on the USB4 Fabric performance.
---

So I wanted to ask – is it better to:
1. Catch this case in pcie_bandwidth_available() to skip PCIe root ports 
associated with a USB4 controller.

2. Special case the usage of pcie_bandwidth_available() to ignore any 
limiting devices when dev_is_removable() for the dGPU.

I'm personally tending to think it's better to fix in 
pcie_bandwidth_available() because papering over it in amdgpu means that 
the discovering the upper bound isn't possible if you must ignore the 
return value for pcie_bandwidth_available().

Thanks,

[1] https://www.usb.org/document-library/usb4r-specification-v20
USB4 V2 with Errata and ECN through June 2023 - CLEAN p710

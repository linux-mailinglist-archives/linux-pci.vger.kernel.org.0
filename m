Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02407B6E78
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbjJCQbE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 12:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjJCQbD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 12:31:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B743D91;
        Tue,  3 Oct 2023 09:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvwrCuZObcM16gW+p+jYacM/2Y5ZG6XcNUoyEolHFVjcZqcBfQfK387RYPqTJbiR47/UzulQTI2YCV8dg9aeJZ8qN66V/vBM97p9rBXJeQUpltUwG760nRHn6d883KyUmQItjXzkRZN6QMtoxI+KOcjuuRdRuEbFDbLtPUl3TY/RNww9IjWyVpmEAadeHuacl5S2A57trD8GIQVjjwwDB2kpfXtQvIEy6bWJ6dGyLCi9eMnUg4tESHfnejEI57Xvral+AEav4vCb3PBYceDU72Uow+8jXMk3gbNqYVyPLgVRNdgDFaKcdUQGvEyF5S/xKJnMfPVti+EPZhxDWvdmbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wq7CCaLyIwFZKd5LbX5Oayymj/QWBtoRKBKjEOrLyPA=;
 b=dmNFU11lFPUML4XCIAJlCIBYZ9qqcIKtYAq3999GrARkTNlArkig+WHe4S5pPTT/ARDKFvdg5YiIVHwAMNbSQqn/upJJysgy2YzwFxmLaCJ7UhwbEbBr31C3g+1uElb340NKF7tImC0ANXmujs8/M504Uicb7iSF/pZYqCsTQQn4ConJz3KShzHwsQjCr429/ZsomQoKDsNm61nmIrgKfOh39ot1JAIcCT7ETrPJBYJ4Rgl41MdvVBTvMPzWBOPe6Ln4uPKfwgi+VXvsd0WhwtlwlrsmFXKaShS7UlFF4Dpjl6pnYqlh286pJJjX6GXwROMaXRS7GBpYMilrSRxtcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wq7CCaLyIwFZKd5LbX5Oayymj/QWBtoRKBKjEOrLyPA=;
 b=sAdAcMOtjYSowfcYUvVYxZKL5T+Exul8NLdAsRrrAJWd87Sw+nnU+a6OZ4aPhlRFJJh5uw6Ww+1A+sMRLKyPof8ZGr976//2x1lJGI6LiZO9x/Ti69lSoI+uoWqmgr9AmUrbxV1AbGd6I+WfZxL29OXwP8hEW7AwJPpJ+iqFP0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 16:30:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.028; Tue, 3 Oct 2023
 16:30:56 +0000
Message-ID: <6291393a-b830-4a37-ad2a-1e23b6ec778e@amd.com>
Date:   Tue, 3 Oct 2023 11:30:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Make d3cold_allowed sysfs attribute read only
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     bhelgaas@google.com, lukas@wunner.de, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20231002181025.82746-1-mario.limonciello@amd.com>
 <20231003094407.GG3208943@black.fi.intel.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231003094407.GG3208943@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:806:120::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: adf33bfb-c77e-47d8-1cc4-08dbc42e1e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +F1i8MFtQhoquZ+aYZt/JemZdGu8oZEiOnr/9vI17q9h4Vn52wBQRnPCJEdiqRojy8KmhntCYzpC4EsLK2M0rfaWqEAoMWrNwXnVbCr3kbX9DOqbF0xtLTxr9G5uKeWoyJPqvSQavVKmFriZPkXNzadSCMn3IBTZ1C34pYm60TckLsD93wl5IWyWw2CvrE+53+VdHkEDDQXdIifwfhssmFF0z1fMZFHFAQVxVJtfwJe9Smhu7lYArmQ5FVqMrBymudP5CAJ3PHcJ/59UqX+Py8CKJJem6xx8ENERm5KO8IoVA1JEF/9Sc0MNTReSUpDz7s1+eC/yJWOXQ1asDiRUszWqJTslMboY0dLp50LQ5AeaEeyJgY+0ZM8SYPCF/TGcLs/s/wdaXNQ+4BP5iizSIl/5qnRZj9xis39UtJ7A6wFelrXJu6W82qv1+iNyKoWyt75y+//ZGu7t5rNyeINJgC8qpvb987saHn/RpCyDCna6HQxpg6HsmZqeSq4V3dGx7jBxLVD2CtJcrNdgSzhwwH1y99ZetqiNMaEM20ooW7YbaBplL19I+cxH8rDA6hpma3v9N8AdpwOZq8FtaQreqJMW/SFhhsRYEBe3qjXiC/zRGXwTC13g9MPRCOqg4UsdMATcaz9FiIMowEHc5bikwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(2616005)(5660300002)(26005)(8676002)(4326008)(8936002)(86362001)(31686004)(478600001)(31696002)(6486002)(38100700002)(66556008)(66946007)(66476007)(6916009)(316002)(53546011)(2906002)(6512007)(6506007)(83380400001)(36756003)(41300700001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzdqeWl6Z09xelY4TUExRlpxa0Q0b2dpTnhIdUZmMXVqQUlOVk1KZWVsS1Nm?=
 =?utf-8?B?SllvRXFJL3VhVldlNHBjbzFxMzRBNis3Z3h5WElFZURpbWRiRHNyV2tHbWN0?=
 =?utf-8?B?UVpQcStTUi9HS08vYTdPMnJzS2JjcHdXUTBua2ZtZHdLWncycmpLdngvRkNL?=
 =?utf-8?B?QWlPMmVERXBkTSs5RzJwbTlSVnMwcTBRbDVVNmorTXVDZTU3NTM4b0FKTzIr?=
 =?utf-8?B?YzdJTzNqQzNFZ0IzMEJwazFBRHNJZ1RJZ2I4K0RmRDZQVW11dmJIaTBXeHNK?=
 =?utf-8?B?eGNEak83bEZzZytNOHlPakNoUVBFc0xmeDJpRkVxdUU0R2lpb0ljRTJLL2J3?=
 =?utf-8?B?Tk1GSFJkOGhHQnFJTjlHUjRzb0dkdUZwT1ZoRmhiRDRSaXNrRjh2QW9Zbkow?=
 =?utf-8?B?S2JqZ1ltNzV3ckVvNVo4RDk4T3NCQ1Yvd2NPcEpLdjNkUXhuWWNRWWhwZ3Y5?=
 =?utf-8?B?aDBmQnlwT1pySG9zWkU5c1R5cWtaTmlvbmZMRGF6c3ZralJUYm1WeUF4NjNy?=
 =?utf-8?B?L1NBQW5VNFZ6NU8yYnhRYVJtT2lpRkY3bkFoZkkxekVxSVRpV3E0MDMvOUpH?=
 =?utf-8?B?YWU4K0p5K1lsMWIxVlBRTmxBQTV6ZnF6YWVlTG9VQUFVdkIvcFA5bWVjRmM1?=
 =?utf-8?B?MFRuT01DcER6ejVtM2dyTWpmbk9KT0M2djhRNzQ2WW5HT3RDNVMyeXR4TmpG?=
 =?utf-8?B?WndvcEY3Um1za0MwcUN3SkhGSU00QTkwTHUvaGE5bEFVL01oMnNlVHpab3Yw?=
 =?utf-8?B?Z1pQelYvM3BhSm1iTHhjeERKME1GMHlNWkNEbm9KU1JrN0ZVTWhZYkpRSTRM?=
 =?utf-8?B?OUtQbzVWNzlTRWZ1M1c3U2RWemdTcUNMMmFaVjJOWGNnT0gzVGdCTHNtUjFr?=
 =?utf-8?B?NkVaNCt3ekY4SU9EWGdwUWZxeFFUaUZKaDR1ME4zSDV4U2crZXV2Wk0xYTdN?=
 =?utf-8?B?aFpOaFFuZjhjeC9sd1hrZ21lMGdGbkhNTmZsSXZxZEFKaElPSFhQUzkrdVVo?=
 =?utf-8?B?N25DUkpUQm5FRFhvN2tVbDI4Y0xqVWRyWFIzam5zeEFpNVd1OEFUNU9sYWZU?=
 =?utf-8?B?ZDc0bHlVdDVUSEN2VERHbHRJZjBGRE5CZ1V6SmlYaXdTTS9KTlZBL1NKdURH?=
 =?utf-8?B?eHhVeEI1Z21OUGZKWm9zeFpEcmV2N1J3QktUaWYvTzErQ3RmRjY5dTVjRVdT?=
 =?utf-8?B?dEN0Q2Q5WElIWnU5SnNlTDZBcEowMUJHK3ltV3d4RTdRK0ZvM2l3M0owRGhm?=
 =?utf-8?B?OS9uNnNseGZOZExxR1VFc3U4aGJmTmZTNmV6Y2ZIeldjTkZPemw4UmlrMEdj?=
 =?utf-8?B?MTlPcURIV2hjVnI4MHozQmQxMzRGcHp6MVVGbm1OZFRYRWdOUTFwTzFIWWl5?=
 =?utf-8?B?dWttajMwbDBvampmSTVMRk1WUkZlZDBsTnJrRWRGdWpRNHZpK1E3a2IvOUtt?=
 =?utf-8?B?NVVqcXlyNlZNRThVM2pLQUE4ZHNyMWxGS3paN0RWWkI5Z05tWHgxZFFEbXlR?=
 =?utf-8?B?RVB3ZDRCelVTTnFjSGgzdWhUN3RncTdrZ2hJTE5ld1JPeTROUWI3Wktyb0Ru?=
 =?utf-8?B?N0NMbWxmWDNDb2pobDN0eEJuQnhkWGFHZHlPRHdKVVdGb2QzWmR5WXlyejNs?=
 =?utf-8?B?eGhSMnlmSUl5ekliS1JzakJCdmVUN3FMM3B5ek1PUXowUVBCaU1wL3VnR0lO?=
 =?utf-8?B?aHBhdHVHYkFUNnFKYjAyYXNESkxJOXhxVy9SdHYxNlRLa004WUgzYkZNbGF3?=
 =?utf-8?B?bHhSbXIydXZOYktFb011UXRzSS9lQm1RZ0FDK09ES1dqMXlPZGM4bVA4a3Ir?=
 =?utf-8?B?TGcyajlwczFpWUpsZ1RDY3JyNlR0K0VYK3g2M2c3THhjdERzSTlWNitsaGd1?=
 =?utf-8?B?VktWM1NqejMxbW92RjR5eUZRYW5UT3Z6Ymd5Yzl6VGtnSUhTL3dkckM1QkdI?=
 =?utf-8?B?Vy93TGJrVEZraHBMc3NxRzdBYmttREgwU0JWWXJJTlYra243c2h2L3VxZVJC?=
 =?utf-8?B?TStJSkVsL2ZCMGtVZkt2dEZWR1JkT3ZhTVB5M0dSUE9LYTdaWWVDYUJLVVdE?=
 =?utf-8?B?ZjJCQ1ZhREx3SmgzNFhadW4zZ3EwU0NRMlBZdU5jNmMxTkZPYnVxK3BFcmVG?=
 =?utf-8?Q?oS15y+vhe1vrlBrpGDVJfy5Zb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf33bfb-c77e-47d8-1cc4-08dbc42e1e9c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 16:30:56.5748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2FFvN0Kk/wpVRtDZQpNUmj5Qbk+klDpBMr8+sITz+qYqIWMy2Nozc94vENIWHfvn3ajEv2oxwXfpVinvd24QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/3/2023 04:44, Mika Westerberg wrote:
> On Mon, Oct 02, 2023 at 01:10:25PM -0500, Mario Limonciello wrote:
>> Before d3cold was stable userspace was allowed to influence the kernel's
>> decision of whether to enable d3cold for a device by a sysfs file
>> `d3cold_allowed`.  This potentially allows userspace to break the suspend
>> for the system.
>>
>> For debugging purposes `pci_port_pm=` can be used to control whether
>> a PCI port will go into D3cold and runtime PM can be turned off by
>> sysfs on PCI end points.
>>
>> Change the sysfs attribute to read-only and simplify the internal kernel
>> logic to avoid needing to store the userspace request.
> 
> I wonder if this ends up breaking some userspace apps? Not objecting
> though, just wanted to mention ;-)
> 
> One thing we could do is to taint the kernel or log a warning if
> userspace touches this but allow it to do so.

If we collectively decide it needs to stay RW for userspace compatbility 
then I'll respin it to keep the store call but ignore whatever is 
written, return -EINVAL and emit a pr_warn_once() that it's a no-op.

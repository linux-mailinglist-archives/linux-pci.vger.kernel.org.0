Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053CC7700A7
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 14:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjHDM7v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 08:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjHDM7s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 08:59:48 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6811546BD;
        Fri,  4 Aug 2023 05:59:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQhXEDNDRs3KCzChME4hcdlTLsNr8JMxilDurd0vEtAI1i+cVccGArN+nH5wL+WpFwd7Dm2N8kV9K1EJpu3HJwH/v8h44OvJZpr5aZqERVouzImgPOzD0I3Hv0tEURPCGd5T8oXCw67my2dkPAiZkhJgwsp3EZHo1vOg3sY8nE9HOdpJ/ZUJJpnVk1zgqLmSmmh079GyB8aBBHGw+9wfZLJEyhv4EO+mCg6o6g89bo9BPeLvlN7Bme2lWWw7+h0Zw8JUdpDTlw1RegGTaCjDUEJ/YAY/yWMv2JZTd43PCnYmVfU9K2e9b9mggpkaQPVUauPVQIwtmx93qXBkeXAacA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nb953xZGTkNa9khnE+9/5NHzQKQMxPixeIvS2vvhdOA=;
 b=O8XgofBKS2FTndDj6SYidSaMjmE83+VfmwhDGitaXs3atHnyqL9op7Ee2q4iNTRWGiSQRu/2Q3LVz1QZST6/FyoSTGrB0mIukNkOqs2iajLqrFPlJiRlxhBGDJxnQQWM5UcN2d19L7iP2sS7PENF5eEg/I6rRpf0Mov+/pS7GPRPk6LehFYwDFCxlNYIE0XvEAshiqE+I7Tdz8rUFnQNB6mYg5pi9/6H3rSRTu71yGplwEKva61//VTwyk0D5MiM+x9pYLAAaf8+0GUyNMK9dPmB2iVMdUQ4FhZXNZke8O5g/wRtFzuK+s/U1lmjJfIVhfqwq1Qyci1EJKg7hk4j8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nb953xZGTkNa9khnE+9/5NHzQKQMxPixeIvS2vvhdOA=;
 b=h4hyG1e4hfDLqqO1JgXt+NUbeJ0eC403VhTQOGCgPM1bJwqYBhx0bU8L+lhxhy5Y7U4THlKhaAkjjgwshJkdEixkZ0ZbBHEkzTkvEnKlJ9Y6fpDCi/Wg2JIIyn6ss2mnbmXV5kctFpOkRepD6GBC4hy4UsmKvf7gOT19sEwXtpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB5108.namprd12.prod.outlook.com (2603:10b6:610:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 12:59:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 12:59:43 +0000
Message-ID: <b1db4846-9da1-9af4-4b3f-53ebf2e527a2@amd.com>
Date:   Fri, 4 Aug 2023 07:59:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 2/2] PCI/ACPI: Use device constraints instead of dates
 to opt devices into D3
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20230802201013.910-1-mario.limonciello@amd.com>
 <20230802201013.910-3-mario.limonciello@amd.com>
 <20230803050118.GV14638@black.fi.intel.com>
 <06cf76ba-de5f-caaa-d1c4-9d34adf15a52@amd.com>
 <20230803151454.GZ14638@black.fi.intel.com>
 <208afe43-2539-156b-971f-89233598b687@amd.com>
 <20230804060743.GA14638@black.fi.intel.com>
 <ZMyWt4JD1TjoLk8w@smile.fi.intel.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZMyWt4JD1TjoLk8w@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:805:de::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: f37f83d6-0456-45a5-8acf-08db94eaabed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2P+0Ea8xGPUWvR8MX0EL5RNEfwpocn/7DfTeDmZuAnbf2+vdTVCdHrmYKoFg5xCjnuJyBxuUh60cS+W/B2kFLumAdAjU5EeiNdGEfXJbU9b8lkfWn0eUgLZmFE3qBo8RkN2p7FGPCLX/ZSUwt9wlLCxp+qZNTdk5wW/WzYxIqBobVVfT2QLxmcgNDhRH3KC7j4zKBjt6f4vGAgrwEaiOBdGxWBvG6LARcIjm/pN1Gg3wEnntKnDtcgVIT1jqZ+dXPQxhWfeDXJTSHTX/1LzCbCtCowJfIKQrTd/8Tw5ASCXt9DhoOi4joRTnApWyh5xiZVX+NzOPxzwixx81h0VJicy9Qn+NkUYRBtWe8BeWISZnFyn/UpSU6XLuszcyaIdHpOPFidrJWFkkdmoHsvDShLR/kpETOg5uS0muHnTLb05iIyGqLVIzBO17z7t0sTbV37/nGyGn2zkSKr9dJ0Cjkv7X9lKwnLH8tnWiKxAWCKy76ZzrN0nAo4/RuON/nxlrOxnH7Y4EI8AJ8AnK//2aEwmO4KJDNLFD9VixIpKjthGQq3m39efsncidfg3jWr52O+OauKEW53YdV2SHWfBz1o/iXV4JnwpXbxCP/b46COH0q1TS6XqloneBL+8csptZgJiR4YykPceiQjQ9nv3Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(1800799003)(186006)(2616005)(316002)(66476007)(66556008)(66946007)(41300700001)(4326008)(44832011)(38100700002)(26005)(6506007)(8676002)(8936002)(5660300002)(6666004)(6486002)(6512007)(53546011)(31696002)(478600001)(86362001)(54906003)(110136005)(2906002)(36756003)(4744005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFlRSlZFMk1tZHVGOGtKV0t0YmZDbWVFV1BUTi9FUnVIeUxIRlpEcnFjUyt0?=
 =?utf-8?B?UkVnS2JrZGxMUC9aaDJsSkpNbGJFZTkvZ3dJNUwrTk5wSndGZEVyb05lYWdD?=
 =?utf-8?B?NytVVWZ1Qyt2Nldwb1BLTFR1NWFveHBXR2VlQmt1a05SdkZISkliajZOK242?=
 =?utf-8?B?N2phVk5wUVBFV1hhWTg1TnYxMkl0TFlYM0xrdVZIQ3BiaEpiYmpWYndvdWI1?=
 =?utf-8?B?T29WU1NURVY1RkRZeWZGRHcxNHVxUkJ6dHhKWEIra09mc0h3M1NYMFM4TzZ1?=
 =?utf-8?B?c1VYay9xNkZpSzk3M3QvMHQxS2c1NmhsaS9RaG1ub3M5RkNYblVMR1lRQ1Zn?=
 =?utf-8?B?cnVsd2VDOHJ3b2NmaUY4L3p0bTFBTThiQWo1T1pSaE1vellUam95UnB2UnRM?=
 =?utf-8?B?eXdXTHd2T20wU09EQ2kvUEMvUyszdThtTFkwT1NucjgwQkV4VVp3WHBUcHI3?=
 =?utf-8?B?VlhuSXgyeHIwbEpiZ2JnSWM2RzJpdXRIR3RLOE5tOGNrakNxTytoZXR0SWNZ?=
 =?utf-8?B?ZWNPSTNwclRFZVZGQmtCKzd4SGJCWFRvN3dTN0x1cUV3SjlPM0IyT0ZDNklp?=
 =?utf-8?B?eUtvT2lsZ3o3SjhkZHU1NTFmVUV4YlZFU2MyR0M5THRtMnNEQUJ3bkd6aXZ4?=
 =?utf-8?B?YmhVL1pHdktCUERxWVA3VkpGd1ovWDRGQTJyemRKb0NQQ0pDUlo4UVRLQk1E?=
 =?utf-8?B?eUpOenU3c2VscTFlZTdSSDVad2Q5YllzTTl6NGszN2RoZWszWE9iRG1EYTVS?=
 =?utf-8?B?T25uSkprcmhLT3EweU5RM1EzWHlkZVpUOGNocFBzdDZlVmpPY0FKVlVzL1NY?=
 =?utf-8?B?b1d1K1lycmFGRW5BNHJFZGU2bU5TRUpCUGJOUU1rSFd4RjBENm1LeFJYa2hz?=
 =?utf-8?B?SUFtMXEvUFg1aitVbnZseGp6TDJBK2o5TW1mNGFlZXVsSWRGeE1RaUYvMjFa?=
 =?utf-8?B?T0dyeExQeXV4OG9lSXpRQnRXTXBTeEphV2hMckZaWFJKbXlKL1dhbWZmVDBH?=
 =?utf-8?B?MTdwYnZxdHo3SnB1NjU3MlhzemVvbXgweGJFZk9nMVM5NHh3Wlppckg5WldD?=
 =?utf-8?B?UjBJR2NVaFNpdHN5ajU5TWc3WlNCZ1ZQTlhuNUtsRmtUNkZWRFNQLzZLaW41?=
 =?utf-8?B?R0daVjI1ZW80dmFnVmhqSFNNT1plKzVsTmw5SU9vVDRJZyswZ0ZtTGNMaWVH?=
 =?utf-8?B?azJlTDlKeDY1NWNBdzlwTkkzSHRXT1ZTVzBBYVQ1bklCWUNyUzZHZ2ZxZ1h4?=
 =?utf-8?B?cTAxUHRzR0Jlb3ZPUFdXdjFBSi8rakE4MDhpVUI1ZnkyWTFoOExIM1VXYUlo?=
 =?utf-8?B?UFFIZjhoODhSVENjYjZOOWh3di9yOWdacG9KUnRMRy9wWDlFcXJCVVA2Q3Ny?=
 =?utf-8?B?emZ1TmdrMkMwZEtDQVQ5WTBwREVCdU9wakJ3SEtocTVud1E2U1c5N2JWcTlv?=
 =?utf-8?B?NGY0TmQxWk82VG9IVEN0Q2pxaVhsbVcwRUthVFVTKzNjcnhZRVNUcmtSQ3Jo?=
 =?utf-8?B?SDg1Rm5aa0VaTWVjZ1RRd1U0YVprWkROTkJrbkZnZGMrZHJ3c1NVSEpqYkdB?=
 =?utf-8?B?SUxtdGZ4aUFPbUtQRGdmaEI2MjY0UzNuaUYzZUtjUUN6QlJpVElFdXRUOStl?=
 =?utf-8?B?cklnbkJWTmdXZWM5c2tZMENOYkZYMWhBRlRGOGNPdGJRM0ZTcjdidk9kNlBj?=
 =?utf-8?B?N1dKMytaTEJyL2NLV1NvV3plNGZadlgzcWZaRXBjdDFFUVdhZVN6RFRhMHFt?=
 =?utf-8?B?TXBUbWFRWHlhSlVsZWZMTlhHRVZvb0RKbFZkV3JqSTU4QUdyZlpCY1FTc0Vt?=
 =?utf-8?B?aE5Ebk55eU5rNEVhYVJsRHMvV1J3clJIS2pFL0FRYWlTSDdOUkpuN1k0alo4?=
 =?utf-8?B?R1FMQ3AySU5WSkMxMjlwWGlaVzNMMkMwZkFsME1yVk8yMzJGWm1sT0ZSTjNM?=
 =?utf-8?B?bFhIc1N1YWwzajZXNGRjUGVrYU0rV1g3dzViZEprKzVkTnB5Y1kzY3VtTmR1?=
 =?utf-8?B?OERzR0RjSllsMUV6dndoT2piSkFLclZvQ1J4OUR3OEk1bjVaV3cwYUxiVC9i?=
 =?utf-8?B?VUxFcWo4N0pkTDdwODJuTkdJamZJY2N0UnRuTmlEVndpa052Tm1kMjdDeEFB?=
 =?utf-8?Q?6aVh2ZgPfraa7yKYKbR06sCjM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37f83d6-0456-45a5-8acf-08db94eaabed
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 12:59:43.2487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjfwjDU4ViGBAlo3MF4m4c2c7sxqAB5idmmTrNZaxOPq6xRCs/Yt57usYPSdevAlPKS4Anv5wnm7RkMnl2DlzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5108
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/4/23 01:12, Andy Shevchenko wrote:
> On Fri, Aug 04, 2023 at 09:07:43AM +0300, Mika Westerberg wrote:
>> On Thu, Aug 03, 2023 at 10:18:07AM -0500, Mario Limonciello wrote:
> 
> ...
> 
>> Some of them, at least the Apollo Lake ones were used in IVI systems
>> that did not run Windows IIRC.
> 
> And if it matters, they even don't have EFI complaint BIOS.
> 

Thanks.  I agree then; to avoid causing regressions or building a 
monster list we should at least try to work in the confines of improving 
the situation with an extra optional check that doesn't fail if not present.

Hopefully the approach from my v9 series works for this.

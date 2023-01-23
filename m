Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D744F678660
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 20:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjAWTah (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 14:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjAWTag (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 14:30:36 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8A1B77D
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 11:30:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6IRnzkSDb7vFBagaAP8f5oFtKwGJePuZ/odwBSiUMj378gMZI1FfDEWK0HwGKCkmTFEyfk/RWYIZgXfRPgWpit4NQfAcyyq1IV1+Z8hsnyfG12x9zXYVQsaRPIOELj9lB1beB66wRWEzt1ulsUMXkrwqnd+WeO6+VSBTuPT4F8F1PhpJR58D3llcJJFCzeYZNmSWLK90mT7d5aaxr9nk80BdBhOBBkRyFV7UpJ0Ly/1tvhWH6Clg7mBeL5nqv3m+ipMIw9jQZ2UkHb0xyYvS56kAApERwFmY2CwnQmEQQn8NoT8WBBUNrISgQQUef38JQbxbiDSe5q0gfYYmatkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyhmornVtar98vYMtF7nwr02EVonLspHsU7aYqRsIvY=;
 b=GnqcKxohNupUqdZ+NFFKv/nQH8VjAbFVBklv4+xvo0Xs7b3ZUu9EUAjyUgveEwUZXdJK5TzYPz10UhfoLdgyU7OV+eYWXvWOhAcIq0SH/q2Qi07ObG9lRFp5dT9H5X2w2urKhcGAQ1LSALhyBfJNhDxpqrdk18ct3rxmV/P8MNL7dzNwqEhYtajRtHBcD4cxtGvG7oN9QN6gJVogMIpSJFH3QL8gUKa6UhaHG4KBRff6XDV11FP5pdrvGM3D+HWaLXzRcHcma0UT0WZTxf8lFpGdoixHwSpZoW01yS7jBiJUAeczOOTagiD6SGPVtXwhkLgR/vkKgMqNVtuSwl8HDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyhmornVtar98vYMtF7nwr02EVonLspHsU7aYqRsIvY=;
 b=hqbTCHk17C+mBrpG2caa0iWC2OA+a7zQfRFC/5bi37K55CcfmvCU0IzNYxRac4z2gXvpsi68YJFBharVB5hthpUcW3sE+wAddnVy1MRRhXOZL+Xalgp5+KfWjOOMT/Imbqgv8hd0zKvmPs/TSCjIvfVg8pBkU2J0UwLP8nol92I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 19:30:06 +0000
Received: from PH8PR12MB7109.namprd12.prod.outlook.com
 ([fe80::77fb:ec9:514d:dcce]) by PH8PR12MB7109.namprd12.prod.outlook.com
 ([fe80::77fb:ec9:514d:dcce%9]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 19:30:06 +0000
Message-ID: <22a64441-5eed-8d56-5c5e-80c425cf6967@amd.com>
Date:   Mon, 23 Jan 2023 14:30:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] PCI/hotplug: Replaced down_write_nested with
 hotplug_slot_rwsem if ctrl->depth > 0 when taking the ctrl->reset_lock.
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Anatoli Antonovitch <a.antonovitch@gmail.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20230113170131.5086-1-a.antonovitch@gmail.com>
 <20230120092824.GA2951@wunner.de>
 <d14fd1b2-41c9-75bd-5b76-d2c396c1ebb7@amd.com>
 <20230121072148.GA13969@wunner.de>
From:   Anatoli Antonovitch <anatoli.antonovitch@amd.com>
In-Reply-To: <20230121072148.GA13969@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0071.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::23) To PH8PR12MB7109.namprd12.prod.outlook.com
 (2603:10b6:510:22f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7109:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 28bb26de-4abf-42be-37ba-08dafd783b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nC8MoRoyZox9xZzasPtAGGJUXraBZK7KKgkm2gpbBmC2qElS4j6E5Z8SEPqAjS/cMgeqb73kMuH+6Ismij1bKC5Hg5XhGuiN63oA9NFucKViUfZF6jq5ahpxA+ENk3TjrTuIYfZELoOPHH0OU7XvE+mVRtfWBk4BRpunY+eODVklJklUNOjtHqN3vFgJP06BJ2InX5im5DdOD9JLGo36w+loLx0WnPPTHBwUtkJ8fLIGsU2Ap6cD+oh7O3WiDLXZc990zQwEPWCDDaNcJycJ+0bJfpIPvG+eDQ5yl2ZAKLQBR/HBFMdVEF3AIL+8vmcOjz6sjJ8AA69znle9DwDSNLrRQMC6vYjFrEVdOdKuEduxNasJY6Rrv4IDWBpok2byBtOPSsRquYj/i5pmWieWvtXLLZ/OlNLG3lmjukPjsnP+ofA20IPnw6PC41cV7UKiO8yjnACboV2vTahmY46Ir0S8bWRiTyuAO0ExPrXiTTdN/orJZGu+qcM3qaknIWu6ndwwrkbSdvZr4hDzEXdxaPkW129maCZXSpX8QBa4jZ8yXRKlWc7RWLmc1KBAh87goKMXGpDgtu/bYr6s3pRTX5wlvFxerFub2pz8pVphyKk3oiWZJYlFNFWS2lLuGXRMaYDqN6H1OtNnzpJHfltfmfuqb+ZlJu87nLlL4yZgQQBEGa+sJuma/s8fsV1fyhjPl1bpEX0wgPwFOzxr9WfybgHq+KCrAuW52cJwona99C0dhaS89piTFPiVyWw5JcWHjqdlZQOgwgt/f0O6EfLCt8T3KiUay2HgnAs0zBfVamkFx1qoD/e2j1i0SYreu0UM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(38100700002)(83380400001)(41300700001)(86362001)(4744005)(2906002)(44832011)(8936002)(5660300002)(4326008)(6512007)(26005)(8676002)(6916009)(53546011)(186003)(6506007)(6666004)(66476007)(66556008)(316002)(2616005)(66946007)(478600001)(966005)(6486002)(31686004)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dENhS3ZxTXl4QVFiZHBxNEtlQWNhNmdlYmh0VmtIVk52Mk9ONVIzb04xRytq?=
 =?utf-8?B?NGhubjVsUlBXNWxKWlhWR1FZeUd1YkdQMWsxVk9vV0Q0dlpnZVhFMzZqY3px?=
 =?utf-8?B?djFyOHljYThtWkVPMXBZZDZ3V29hSldQM28vWXRJQjVwdURtaStnVWN5SnBy?=
 =?utf-8?B?MHVPWmVwQk4wbm1wWGdSNUpSSURDd2RaNExEbGczem5YNUFub0JiaWE5R3I3?=
 =?utf-8?B?d09FdVFsYmdtOGJMMjNjbCtNNXhYZDI1L05JV0VuUGtpWXJiRWNDSWh4NS83?=
 =?utf-8?B?UzVMY2hKTDZBd3dya1A1bXZsa05USkxkeHM4UFRSdWlOSktRcWVsbXhQcnE0?=
 =?utf-8?B?bjlRbU90ZU8wcmgrUHQrZUNZZmY2YlhLUXNFQjZvN2w3d05DOU8zYWUrQWxF?=
 =?utf-8?B?UklFUUxMY05EM3dWNGwrUElKM1lyekJ5aUd0YTByM1Ewc0p6dWxzL1VpWVZZ?=
 =?utf-8?B?V3Q5cVhDVlJaaGh6RUZCWXVMem5hYzJabEFPWUVWckpvOERQalBQTTRVL2N0?=
 =?utf-8?B?WW96b1ZVQzJ6a1dLOXIwUjN4bnhKK1hjTkZ0eE13d0hvenY5S3NFN0p0Z0Rw?=
 =?utf-8?B?ekN2M1lnZlUxZFNEQVRCOWRMVFhBT0ZYbjlXZ2I0K005bUc1YVViM0ZDa1dD?=
 =?utf-8?B?VXFQODBjdmdpUFBwc2cxMnFVRXJYQmdmQXdmTmVUa055RnlDbGtzRWZ3d21K?=
 =?utf-8?B?WDZCNFlPcUlxNjcrZzhkS1BGWC9pOHh3QWxjbk1Lck92bmdPeFFCdmxRZUlT?=
 =?utf-8?B?cWRDWk1ZTWdCcWtsell1TFVWVnRKMDd3aHNmNW5FMFFYR2RNOERlZVh3OTRY?=
 =?utf-8?B?VElWUVdVbm8yVDZDWGV2aVRmL0N4YkdkTmFqTGNURHB5RVZ1UWdvSlNJSTV4?=
 =?utf-8?B?YkU2azdoUTFrVllVNG93WWxLWjRlWnhLRitFM0lwWFU3UDNPZ0tnak9IdHRi?=
 =?utf-8?B?RlF3Q05DRWVKRFVvdE5Wck1uV2hpR2hCalJMazFXQ1lYeTJnTDh5YXlqNHJx?=
 =?utf-8?B?THNJTFlTNmI5VHRTWDZIZ255MWpCaUtuWkc0UUplNUdzM2JZV1JTeUp6SC8x?=
 =?utf-8?B?NXI2U3hibmE1b0ZDalBlUHFGZ0ZVclhZOUh5aU1rY2ovM3hBTisvUjhBZXJB?=
 =?utf-8?B?aXVIQjQ5OTVqYXM4SEU1Q0o4eDVVRmFsNVFrclIwRnRhL3BLc2lzV28yWkdu?=
 =?utf-8?B?czZMNnhtQTA2bk14dmFVaW01SUliNFdvQW1YL2JzcUgvbzBMZUdKRzdmR0tO?=
 =?utf-8?B?dDNnd1BxaitHVHcvZXk1dXpsMklCVHVUU1FxdmZ0SkVUa1h2YXVRTVVzdVpo?=
 =?utf-8?B?VkRWZ1hrR0pxZzd1bDBRdnZZVXJPYU1KOHVCTEhLMmc4MFU3di9nQ3BRUXFw?=
 =?utf-8?B?a0VQTTFVMlEyVHVnU0huMVhMSERPaTUzQWVVNDVGYmk3NSs3aTNJSEtCTFdE?=
 =?utf-8?B?SmliZjdTUStkc0lqWk4xYVdGcUtiRk04NWd0NVlxTnFRNTBFUkUxRWNZelY2?=
 =?utf-8?B?aHJ1bXllOFdKMEx2UmlNblF4enQrY3BrMnRvbm9nbTBvMWtCWUJ3YU5lQjFh?=
 =?utf-8?B?d2ttdGI2WnBtekhvNm1CcWNHM2NNSzJKZ0hGSWc4aWhSNlZkdlRXeDFqVFYv?=
 =?utf-8?B?WWRRYW5VMytvbllBUEUrU0xqcExWcHVkVGpTVjJVdm8zUUhGYmRZZXhSWE5F?=
 =?utf-8?B?S3FOcGpMaXpQQnZteXhRcytOb0VVb3FERG5FN1pkZkRLNlMzSHdSc0tKWmNJ?=
 =?utf-8?B?MUJhaDIyYWVGUzdLVUFMeEhmMXByVU05UEZJSitSVUR6M0R3ZjFZTTdHeHVR?=
 =?utf-8?B?RFFicXBDZm9sU3UzZHdnZC90Z2hHeFVUMjNOVnZNQkRERHEzYVppaldHT2tB?=
 =?utf-8?B?VTYyM3ZRRU90K0J1VkRUTnUyVW5QSzlmL2MrNUtMdkVGU2RET2pxTU1FNTVX?=
 =?utf-8?B?TEZpbVE0emxoRlA5QUs5bHhTUjA5N0hmeEM5SjJWZWxRK2NrNEcxYXhqTVFX?=
 =?utf-8?B?eUNQTWZFZWxEZ3dNRk56RTRqQ3ROY3RBMXhDazJwVE8xWTFEVkRrczZEdFVV?=
 =?utf-8?B?alNiRTVCclRZQ2J2Z2RGd3I5emxKZmxBTHFaeEZDSzZpMk9iNHY3QW9qTmVW?=
 =?utf-8?Q?vWpDxkdXjjZMd8FJ2iykXWmEJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bb26de-4abf-42be-37ba-08dafd783b76
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 19:30:06.4521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxhILh4bMn4vjmyTx17KTu/2awRzZvg7FP91v2PP0zNVGd5TsTDtt0lG884fD4aknl+i0OvO6R86OqDITHPL2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I do not see a deadlock, when applying the following old patch:
https://lore.kernel.org/linux-pci/908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas@wunner.de/
after merge for the kernel 6.2.0-rc5, and applied the alternative patch:
https://patchwork.kernel.org/project/linux-pci/patch/3dc88ea82bdc0e37d9000e413d5ebce481cbd629.1674205689.git.lukas@wunner.de/

I have uploaded the merged patch and the system log for the upstream kernel.

Anatoli


On 2023-01-21 02:21, Lukas Wunner wrote:
> You're now getting a different deadlock.  That one is addressed by this
> old patch (it's already linked from the bugzilla):
>
> https://lore.kernel.org/linux-pci/908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas@wunner.de/
>
> If you apply that patch plus the new one, do you still see a deadlock?

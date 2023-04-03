Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B07D6D3B36
	for <lists+linux-pci@lfdr.de>; Mon,  3 Apr 2023 02:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjDCAzl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Apr 2023 20:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjDCAzk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Apr 2023 20:55:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF05A5E1;
        Sun,  2 Apr 2023 17:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTDmKuu91Pgx8myW8wdFCGk50e1dCviaYlOM+nw//XEx9WYT7AaBLeoNZoKFctlCrB8Tlswk9KBEe5AbY5g0W04+wVLlQvvePfGjRodtnIIdlj1Tz71FrePXCYvvKwl1ELnshEr8NEI6uoMjF9dPv17W16NPmVuC0R+plsGMMMXxAoKzDFlZRQRZYuG4CsWlogZmdoHDxA4Kagi006sSsnlsuIE3Nzz83Ir37km7UxCHCqWj0FVjn7joHF3BM1pYDvquUf5f4AFRYVP7xp5k6EaNut9fsNO6MgbGy6i/+bNA/ye/woLRLSkUuVkpLiGN8nqWgtBsU8ctO/7JmWz02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+e4pXAk825M/4HnL6vx++TG/s25XA7kE+mC76uSDWI=;
 b=CwD0MKKDKya5sYKyEkTnWJicrjcKM/tUDVJsJObXmMHB1rnmjQ9h8j7ijjNsgNAEDcVp2aD9pTwP9p+ZMqWn3qgl3l5PPYFTp69a75kjLVrOHX8S8NPx40qKuZa6QkGtPL2WF7YCaMwMrQX6rirJzLfBdM+9AabZpMzROIlpTtGazWCreoULJcftAYR345o2akV0518/2TrQXVncxfmFBCwyJQEswMWI0LffmUT0hQXY2BG46+4BoWFj9HF53r9J3EDVvFUVwaZeBF9/Nn8wAEemhw43/y8M/OCKtXorKoPQxRFxyDC4xn5VZaaPNCIhajOnLVXl2A0XkK7OpafipA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+e4pXAk825M/4HnL6vx++TG/s25XA7kE+mC76uSDWI=;
 b=Lgon2ScSoB+cZUmB9UyRvIrzJmoa6Vtn1fjqRTxydefFdcoIjAH1ES4TqpOB8rbLZ1MLPgwbTkXRtRvWq5Ch9J023nGXjUwfb3oVUq+hbt8UGqkT9nDgsmdABk73EK3I623Pg6HZf2lC21ARZHnPxEj4J2VnW3uuerOlDES3Xfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) by
 SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.33; Mon, 3 Apr 2023 00:55:35 +0000
Received: from DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::bd4c:997e:4436:52f0]) by DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::bd4c:997e:4436:52f0%4]) with mapi id 15.20.6254.026; Mon, 3 Apr 2023
 00:55:34 +0000
Message-ID: <9ae1a426-67a6-5192-890d-7b4f6fb8509c@amd.com>
Date:   Mon, 3 Apr 2023 10:55:23 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v3 12/16] PCI/DOE: Create mailboxes on device enumeration
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
References: <cover.1676043318.git.lukas@wunner.de>
 <c3f9e24fffa318a045f89664fb9545099cb0d603.1676043318.git.lukas@wunner.de>
 <bc150b29-ee21-b033-7d05-dd28dd7a1af4@amd.com>
 <20230228054353.GA32202@wunner.de>
 <66ca8670-6bd2-a446-d393-3c327aa45ccc@amd.com>
 <20230302202245.GA14357@wunner.de>
Content-Language: en-US
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20230302202245.GA14357@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0145.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::9) To DM6PR12MB2843.namprd12.prod.outlook.com
 (2603:10b6:5:48::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a6d273-850c-413d-82c3-08db33de21b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jNgDWnQP8h1y5CdNaJzHugTt9FrL7NLOSQ2rlbAVj4ApwyLe5mRH4pAcvvA7+hHamcLOc2vwTnWoMul8g9FwI1KN9bseyfcWTXJ28d0I1qXPcOZQicMSfkC7AQr3TJhonz+kc4gPNPnVXR0CIYpq3CQ2sNp4YDuus8YtLLBPjAOIqJe43JOyn56MNNRvCwrGdpzMvIKlEHxljOSZUPw5XCJyqmiW3fWFmOzOJZifKXt/ScpjNp6/KTxw9klWU1nPOiPhNfjuObWtevEh9wNJ52ZNE2zUSiAJnuxkvfAGZ5CqtsSzY48jttJ3VJSZAzoN3N46yhJXy06TQS5BUK6RYZpK3Xb+BGEVkNfDWwYVz5PX0zyf+dnV81g82R1ulXgg4bcMHPLV6yt30jdY/XcjHK0nm/luKNWSiEIhoIJRC/0Ekv/HpPvnSMtwHBCr+tlY+/krCVluQ57b2QT7kEbM4gFP+otCucpOeNSlhddgX2Lv+N9BPHLZDqhO6Xhyz2kh6BtAQMAqWYOd70kxs7aRBnsxwND+0z5629YBLeIZFcfaYtj5Xwg6UCNE+zVBKU2QjFIU/8634Mwh6S9a8yAbq9127bN74xGE69dj+Ab6gk9Eru5zckKsuVAprIPE3VAl4rSGsdyY5baaG1PwcshRTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(4326008)(6916009)(8676002)(66556008)(66476007)(66946007)(478600001)(316002)(54906003)(8936002)(4744005)(5660300002)(7416002)(41300700001)(38100700002)(53546011)(186003)(2616005)(966005)(6486002)(6666004)(6512007)(6506007)(26005)(31696002)(36756003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEZVdDVuNVpDZFUySDNWcjNpZXY2RURSdVBIRy8vbmNDeDlPWGZzT1FMNWkx?=
 =?utf-8?B?cVFMb3RQekVQTk5ZMUZReEd6RUEzUTlYRUhmemFvZ2VxUmExcUhLTDNrRkh6?=
 =?utf-8?B?ZnlDTkRHU1BHK1pidjdmVVhmNi9MaGlROTFLdi84aUw1Ty90TGZSa0NlU2RR?=
 =?utf-8?B?eUdyZWhncDY2OXAwRTcxMFRTemhuejl3NDE2VnU5UlRhNUlnSHlJQmZMeGE1?=
 =?utf-8?B?UDdyaFZ6NGdTTFU0NzlIVUp3SWpsV2VtdXc4SWFSZXJMczJvdm5XNFlUN1JJ?=
 =?utf-8?B?VTIrWDhaUHYyK0ZWa2dkc2k0bjZWajJ5ZUNQd29yck9FV0U5TmNjNjJwQzI0?=
 =?utf-8?B?SnRwN1dYbUVuc3I1QkxEckxIdVpCalF0MU9NNUFSUXozSGd2WmRXWjFwR21r?=
 =?utf-8?B?VG12OUo0WUhzelNRYWJ4UFFpckJFL3RseGxvRXZObSt4V0hhMXlxZ0dyN1hh?=
 =?utf-8?B?RU9ML1lUNElGT3dFRnhKQ01KWm1ZNWtrTWpQaFV6MEhxbWdTaUI2MlFUa01p?=
 =?utf-8?B?WmtXaGQzOVozcjFIMDJKRHdCM3NZT250dVJUelAzOFcwbDJrVWpJV09DMkF3?=
 =?utf-8?B?MGd6UUFGbExIV3c1WW8yZUpPN2ZLM0lhZzhyREJkZ3VqZ0l6bG5GaXdnZ1lk?=
 =?utf-8?B?dVV4emJCRUxrYitoZFNyNS8xRE0xODgycmRmTDBtTkVXZjJCczMvdURyUUxx?=
 =?utf-8?B?RFBhNmY4eGVPdjVuOElTa01xbGNncFhYUi9qcjd6d1FZRVdSMlBUQ1FBZGJB?=
 =?utf-8?B?NHZXcXJHcUhLNUZZMXdXcEhKallxNGNiQjkremx6bzh6VTROWHliMUJQQWxH?=
 =?utf-8?B?bHdhWlVqdHZCaVhvSDNYZmZBYzhQYWdYS3g2VlVyNThTZ2Vqc015QXp3NDZN?=
 =?utf-8?B?RVVxTlNUc2xDV3ZFUk01dGhUdkFSS3VmRkJ4Y3hqQyt6N3N3V1c1bjNMbEZr?=
 =?utf-8?B?a0lXUElDUjJ4MFY5THNqUEpoRC8vcnNrUmF6aGtGK2QwaFF3ODdHcXhNeFMx?=
 =?utf-8?B?MkpnMTZIMitoRFRDdzBCT25Uc3B4UFFoeFFNN2VzSlo5R0NFQ0huOFprcnYx?=
 =?utf-8?B?ODdMbTlBKzNqQWp3bkd3OGRjckE4UERmSHBVZ1ZCWHVJNkxyTVdkUjR4dkxG?=
 =?utf-8?B?TmdJZEEvanFsMkJ6MzA4cldzYmVvN2hwNmVhaE1Id2lraG04WWMzUFJobmpF?=
 =?utf-8?B?SnpCb0crY3dxa3NNWEhzT3FIdExqOWN3TDBhTTh1WHhuYXpqeEpYWGtQN3F2?=
 =?utf-8?B?YlMxelFUUXNrWUFDS3hqTzhvemVUU0dVWUNQazM4aHczaVdzcHlSeFdBalo4?=
 =?utf-8?B?VDRRc2FNbTV6a0JEeWdRUXlOcDRSSXRsL25jeklQNnlLcHJqWHVwRTNueWtS?=
 =?utf-8?B?ajFHMXpqYlBMd3JLOVVrc3lSSyt6VGVTQWZrdkE3QnVBS2kyUk9Dc1BHaU02?=
 =?utf-8?B?cVhmQWpYYldNcFlIa2FtL2ZYUE9PTlQ5NGxHODQzbjVyaTNGaDdGNnFWNS80?=
 =?utf-8?B?Q2lhYlpJYmJGNGJPdVRpb0JQSDNjTXFSbjhwV0JFeFVxNGVvT01CeHMxYVdp?=
 =?utf-8?B?Sk5NYlM0YlpORStObjdWZUJ4SmEwMUYvV0p5QlR6cGxlUTRpWjhxb0E3Mno4?=
 =?utf-8?B?ZWhVbnREU1l3ak1qMW80cmRhbVlwQURMbytGY1g3Tms0eXJCVnFxQlM0c2tx?=
 =?utf-8?B?NVBlWCs3bzZDeFQ4M2Z1cWFocGhRMmZxcmdGV1hGemJLZ0tBdVJpaDFXUnJ3?=
 =?utf-8?B?Y3lxMVZONGl2VE56V3FvNW9adENnaVJ1U0kxa09uTS9zMkpuQWVoZkorNitl?=
 =?utf-8?B?ZWFWTjBGTjFlUlQwdXZzZFhJZDNFckczYWh4M1M5UURxd29UL3FmaTNLRGpU?=
 =?utf-8?B?T2xaR3RGWmVFeDV5dFBVdlpZZDVtZUlEZXIvMmdzT29KMmw1aU9rZnppRjd6?=
 =?utf-8?B?REJjSWpMdHd1NmZDT1JVclR0azhsVHNOL0I0VFJ2VzhJQWtjcVJRTlhnb3lW?=
 =?utf-8?B?OFNzMTBING9OV3Z1N2xCMG5YQjlObG1hdkh2Y052QlM1ODgxUDNxSXk2Ym9t?=
 =?utf-8?B?RFZDSDduT3hIUXR6dDRqK3VuLyt4Um1sdTl3bGxPSWhqcGdLQmlOTEkyaSs1?=
 =?utf-8?Q?BTDxUeLZB3u978ey0V5HNM9m4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a6d273-850c-413d-82c3-08db33de21b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 00:55:34.7710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hnVruth/d+odAtnCovTKn55KORdTvtEIOHMg/so7vArFZX0aJ4HA38gp47uSwdvj7xRETSVxNHPs+uyvlVvHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/3/23 07:22, Lukas Wunner wrote:

> I would like to make the implementation under development work for
> your use case as well, but to do that I need a better understanding
> what your requirements are.

Soooo here is what we are up to:

https://www.amd.com/content/dam/amd/en/documents/developer/sev-tio-whitepaper.pdf

tl;dr: it is secure VFIO == TDISP on AMD SEV-SNP so it is going to use 
ASP (== PSP == the secure processor) for SPDM/IDE.


-- 
Alexey


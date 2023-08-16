Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E879977E84B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 20:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345379AbjHPSH1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 14:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345421AbjHPSHL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 14:07:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B89F2733;
        Wed, 16 Aug 2023 11:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692209225; x=1723745225;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dlclTrY4wIuBOsM94mwKrGAYOmT1QhVc2iqjAMomgjg=;
  b=ks7xx9EGovHpWeE0YhzY9cieEDZFdUG6WE+TrYxpTL8IOWRJkpTIy5Xg
   O0LVXBgnsS9OCGLuKMX9VO2G3Flm4lKehBNMGkwcpAP+wYccVuAwyD+ly
   1kECmJjPXQFnURmuN3/rzAbNZqDcE+C/QeHdWDK0A35bj5AfiOdz962ox
   dCTF9Jc7szNj5xeRqChkt6p7SZLSCGjrUR/322Gxu4+BXbThdCTeCUyfy
   VRIBI6URVvgkk9jjW9y+JhCijtf07eg6RUtQEYAY6owAN6LPQeDCFPokG
   g3jaBOkBMr92hrkvoj3hPcYIafQLWSBmVeRIePYSdDM60Ti9clLJ71WZe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352926084"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="352926084"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 11:07:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763722032"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="763722032"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2023 11:07:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 11:07:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 11:07:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 11:07:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZDMI0cPYaeyr+fYMqrjbJB7JFjuQrQLpfE1vBmdc3/r+12V69KXentokyg3U5PGyQ8U7CmEFWq/iDdCU8Ajhv2brZkwhXowMUpypJ+PmFnWKK62HKCEzcE/acsxQ2LbeU9aqPR/hhKu/p2+8yXzPVbib5nNBMcE+1TFlYFXSgSXZtcU2XwqpTj4clMNvCFLzWPEnvCDxNqklVGTDqLkj3Ws4vyVBlU6hl/X4ihviI7pDCTubd65yZg7W/CJWPlVfPJxQfXNAHKM4lMZqmB+h47GYzvtyU3eSZ7fSpdbNVOQIwA3gVhQasHSQ9B0c2YVfJ7k4WujksKnBSDcitd4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kf30a6sKq5APIJsCCMpmIGSWnVO7HyjNo62GZCfJZk8=;
 b=l84lbHT54rDJIQj2rGjWwI0z25Vd+Nzum6FABT/PCbClFnacNbNLU0AUE+sWbummHgpGwrFj/icEqri8fzwT2HD2KM1qbLtyAWVaGdPWGI64zn/zuRcFrsy6WAM7vsU5bkRJuR/daAygzLp3fNcOOpJWUaJrSRcWXeceB8pBPkNoPzWMW0KfIrMWaGbQjnpPTxy4dZNrRrs2dXO5uhnqCWwDZ+Ziu1/dmzrbszHqU8x5ebQHCy/2BA6n1aYX3XzvIx2nyzW5XE5VTPFDi3fJZBeyPMvzZ4iznQbwwcCfhwaEIH62q3Y/gb8laKWh4MrKfL8yhvnrIXiXbtngTn82Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB8068.namprd11.prod.outlook.com (2603:10b6:806:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 18:06:58 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 18:06:58 +0000
Message-ID: <5547a005-a492-9996-2d60-6919c3a6cc05@intel.com>
Date:   Wed, 16 Aug 2023 11:06:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v3 1/3] cxl/pci: Fix appropriate checking for _OSC while
 handling CXL RAS registers
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <oohall@gmail.com>, Lukas Wunner <lukas@wunner.de>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Terry Bowman" <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
References: <20230803230129.127590-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230803230129.127590-2-Smita.KoralahalliChannabasappa@amd.com>
 <20230804130929.00007dfb@Huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230804130929.00007dfb@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:40::31) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 05be4b81-085e-46bc-ebee-08db9e839515
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Au5P5ujVhgj3Z7ne3ZDP+XaE7gU2G3RRyedrogTQf+ZjyFPpbaFM5O79oAVQX+XBPgeSoDqlinSD4o7W+G8wmK/UUmbzquGlDz1CEsK+TWhPksEz59C7GBI4/PSV9FFJQl/Y9esgM+20civgs6xDCaPCNgB23DXXEta3ImnhEhIiInRz76m5AyNLXNUTVj1+ojJjIXqK/TfevHkfFuBldET/uVuwOMrSXqn2wbgc2TAyC13nfF66Ea9diqVjpPe2Qep1++ViXj/OBL88yoDVC107UaSlzwvDMAn13HVPa+lBa41W87obqoV7PX59ebilLMr7r59huVTu+KAvO2uDYMN2qghiXVrh+7lEL9rUvu11UAWOrs79j5E83rgo+Bu7ckAmjFwoX9KOvpD4ZkxeK+r18GoSB6KkIJ+ttZ6klvCKcwvt8E197wn+mMo7HPcr5wZlCB5fSvPVrY382OJQr+Eg4CfekS6JeQzB5mLh+mijy94EDIerx87XUbQgwB9fx/dFCq4zMo7nl/UlfY6/l9dRGWt8wDimubfjb/ivp7Bl8I883eW+fcl1Oz9MDZrxUwdvUKY5V6vKT9zZeyw3PvnZzd7yJv/rD81HcSqFp7pBRaX7whmrDH8NVMPjegK7UlvaohohNdxzw4mkkhiPaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199024)(1800799009)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(4326008)(8936002)(82960400001)(2906002)(83380400001)(26005)(478600001)(7416002)(86362001)(6512007)(53546011)(31696002)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFgrTzhyd0FtY1lySExzcncwN0RBYld3OTlvcGJ5NWpSa3k5UkxFVUFtdjRz?=
 =?utf-8?B?WXJYTWxMOTFSQy9FdTU4NTYwZzd3ZVVwcld5LzNiK0xOU3ovYTRCL2krVUFh?=
 =?utf-8?B?SHQycVFaUEpMTkhkZW1reGdzdWlzbitTT3h6dGRZcVNQeG1iRHQ0bGloOUhy?=
 =?utf-8?B?R0pHb1NFMnRqZkgrcWFXNThjUi95a1VDQU5RNkpNczNjdDZDZHVkb3hiQTNp?=
 =?utf-8?B?ZEZEaGQ5cDg5V1Jzbmp5bm50aTZwK3lLRDZyeExZNFpITmtOWk9jYVZNT3hU?=
 =?utf-8?B?bXEzUDBFaFhVek5icXlZWTI0bm1TZGN5SDMzMkowNnBMaXEwWkhrdlhQdmdM?=
 =?utf-8?B?dzBXTFppV2RVNS95clNYMGJ2WEtWTG8xeW94T0lpYVQxcHdyQWl3RXVyRVVl?=
 =?utf-8?B?Y1RMWU9ISXY3Ulo5cWxMMXZRNko3dTB2ZGMvL08rR0lHS1F2K3hGSWJEQzRo?=
 =?utf-8?B?N0hZaXF6ZmxCMnU2R1JWMjlRbE9CL3NnOU51RXhBRzNXMWtYTWVlZkd0Qlhi?=
 =?utf-8?B?cmJwSW1HTDIrUW55NWNTdUppRWllcW1ta3pjRDZaeisxdmVaUHpBb0RTNGFv?=
 =?utf-8?B?ZnZOaGVsclV2UkxwT3FrNnRmR0VXSnlzQmlBcjlNcXg3OXhzK2FHamlBcG40?=
 =?utf-8?B?QVV5MlRYQ2FkdUdHaElYYlJhSmR6Z2lkRzZjeVEvOUNwM1VSQkdRRElDZjRB?=
 =?utf-8?B?R3VYSVZoYk5aK1hFd3FZa2lMWW9zaWxrZjdEb3pSQVI1SXdVWGRnaVV4Y1ZM?=
 =?utf-8?B?SGZxVWdYbjVKSTJZdnNPRmtxcGU3NG40WGRBRlhNQzh6bXF2S3g5VlhrUGYr?=
 =?utf-8?B?VUsxUUdCOW40ZnZNUXpOVXNkNStVMlhSM0N0dGlrZHF6Q1libHFkSjJaOGl6?=
 =?utf-8?B?d21oQllUcnZ4MnMxNjE4UUI5L2s3V3g5ZXY2WkkxNDg3ekdiQ3pDTG9nSWVH?=
 =?utf-8?B?VnZJakJ3bmdBTXJNYmY1Vk0zWVFpbDQ1ZTZLWlRTQ1pkaUhocjVndUFOSExl?=
 =?utf-8?B?NEFlUTdzMHM3LzhtUXBhMGxZQWN4bm1TWnBUWnZQaUxWVVlDaXVMeU5IMHdo?=
 =?utf-8?B?TU4xa3B6OE5mazBiTHpMdlNhVmNOL1l6aGJ4endMMHdKa0psNXZRQUprWmsx?=
 =?utf-8?B?NHI0QjJuMWhOam5NT1V0MnRiTUtsNkpPUCtXQ3ZWTi9OUkk4anM5dTFjd2N4?=
 =?utf-8?B?WUxTaXZZYmgzTi9rTUJjczB4Z05UVEI0T0NTNjM1U0g0bzgxY1hnS1VOVmJM?=
 =?utf-8?B?KzJ6WXhKMituQVFBeExUMm5zYTFrQUcwcUpnTjUzM0MwdVl1QVE1aUg0Z2JH?=
 =?utf-8?B?R0xMWXpFdmZZaXBIZVVNeTNFOVdEM3k5MGREcWdRQmIwemtwRUpVbUJhLzc2?=
 =?utf-8?B?dTI3dDRmbWJMVTErL2d2cVhaSm9LYStiZ2NaQi9nSmp1emxHWXpwR3ZiWU5F?=
 =?utf-8?B?OWcxMHZMWkhLaFZWMWV1MWhOdjhKRGs0a2FCNjZVZ0REYWRZNjNYVjJVWHFn?=
 =?utf-8?B?US9oaUpDR1dVU3VJMW4zemkvU2lZRHBWT28xT1B1UTJxUzY2YWtFVXpvblBH?=
 =?utf-8?B?OVBzamVDSG5jMmxxMDgxSzNTWjk1NEpYb2xNNTRDYWtCNmlsRnJTN1Q3NHFz?=
 =?utf-8?B?LzU5Ync4M2JuQXhIRjBubDRZUCtMVEw4eEhiZkYyVTNheU1ZQU4zb2ZEMUx1?=
 =?utf-8?B?L1ZvaUU5WElGMW1wSjRJeTZJVCtNcHRIOEZ3STEwODJmK3NQZGJkUjBYenYx?=
 =?utf-8?B?TEJ0cXNHNll0Y3hKWWtsbXMvSWlrOURkcmxoeGpaaS9ranU5RVU2RGhpTVNG?=
 =?utf-8?B?a293bVJIUEdPYjl2dGN4MWJlajIxNnhPckx3NkV4QmowcVRFZGcrWFpLMzdN?=
 =?utf-8?B?Tzk1THVJbUhvTGt0TFlEQjBHckpCUVZ4L013NU53U1cwcEEzOWc2YTdTTTVH?=
 =?utf-8?B?OUtMOXpuVzlDVVZOOG5Kb2U5anE5ck1YUE1Ub1JxcnF3ZWxvR05qSEpHaFRD?=
 =?utf-8?B?RENCYzZjZ2VLcHpWTFNTQkNuaVdpL0wrYmwxdUo0b1Fyd1MyQ3dtYzExNm5B?=
 =?utf-8?B?bzNIRFoxWTIrWEYxejFuQlJ0ajRleUlrcjlZYTlYaTk2VGZDclJNbE9KRUh5?=
 =?utf-8?Q?bZyBhFY6KqUGZ//RlitAwsaXy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05be4b81-085e-46bc-ebee-08db9e839515
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 18:06:58.4799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2SbBueR4vUPRAO1BNmbsQvp9cucO9umEJdrrw1torNF/ia1P+8s07yPKPt/1LdlZ1b2KvgemZSyBhw02h0hKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8068
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/4/23 05:09, Jonathan Cameron wrote:
> On Thu, 3 Aug 2023 23:01:27 +0000
> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
> 
>> According to Section 9.17.2, Table 9-26 of CXL Specification [1], owner
>> of AER should also own CXL Protocol Error Management as there is no
>> explicit control of CXL Protocol error. And the CXL RAS Cap registers
>> reported on Protocol errors should check for AER _OSC rather than CXL
>> Memory Error Reporting Control _OSC.
>>
>> The CXL Memory Error Reporting Control _OSC specifically highlights
>> handling Memory Error Logging and Signaling Enhancements. These kinds of
>> errors are reported through a device's mailbox and can be managed
>> independently from CXL Protocol Errors.
>>
>> This change fixes handling and reporting CXL Protocol Errors and RAS
>> registers natively with native AER and FW-First CXL Memory Error Reporting
>> Control.
>>
>> [1] Compute Express Link (CXL) Specification, Revision 3.1, Aug 1 2022.
>>
>> Fixes: 248529edc86f ("cxl: add RAS status unmasking for CXL")
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> Reviewed-by: Robert Richter <rrichter@amd.com>
> 
> I'd be tempted to add a comment on why this returns 0 rather than an
> error.  I think that makes sense but it isn't immediately obvious from
> the local context.
> 
> Otherwise LGTM
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Echo Jonathan's comment.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> 
>> ---
>> v2:
>> 	Added fixes tag.
>> 	Included what the patch fixes in commit message.
>> v3:
>> 	Added "Reviewed-by" tag.
>> ---
>>   drivers/cxl/pci.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 1cb1494c28fe..2323169b6e5f 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -541,9 +541,9 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>   		return 0;
>>   	}
>>   
>> -	/* BIOS has CXL error control */
>> -	if (!host_bridge->native_cxl_error)
>> -		return -ENXIO;
>> +	/* BIOS has PCIe AER error control */
>> +	if (!host_bridge->native_aer)
>> +		return 0;
>>   
>>   	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
>>   	if (rc)
> 

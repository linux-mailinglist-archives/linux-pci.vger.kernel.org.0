Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0996892CC
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 09:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjBCIyH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 03:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjBCIx7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 03:53:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D408F536;
        Fri,  3 Feb 2023 00:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675414433; x=1706950433;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EofPvjHzUnlvmocUhFgmmzi5T+OM5HsaXAVt53fYilc=;
  b=nS3lKaapi0xH37GLlE9BtvhasERSBRfKIabgMrT/85l/GmybSqTNXdl/
   REq/+m8yf4GjZawVb7Tv9moRRc57a4KwUB/coWmgOTeQqPDkI9eFSvYB0
   +ydg4NJwfZgUInzW199N5fVVppOXzZ1nYtY7zpqGgjH78Mpod+hq39yIm
   WVDnultuTqtHbgPlZ48cFPmH04DoVpF+6NLTkwzy05c1YBuuBcFAoGDcI
   VI1mwwinKHZXQfSl/hB28e/UxNaoQkTZrPBFZNhZ6O5d81I5OH4uZqqNe
   IXxCrPA15TEsf3cjXHjpVktlWPJKmJedExZcXu9rS0WKBIKElWlIna4pa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="414908565"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="414908565"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 00:53:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="643198369"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="643198369"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 03 Feb 2023 00:53:52 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 00:53:51 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 00:53:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 00:53:51 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 3 Feb 2023 00:53:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqFQg8cLczWFkk5YvbMRevWFc8401QEIVQ9+9TtSXKGqcpspkjWxUb7bQJZHTK8QZ92TtzDXTzKBi+FhDqU0I7ilpivEHrX3M6iwGlvVwuTB1rdTHuaqHrgItV9vnn5PDn4eOtfCbv3Z8iruGu9J2wShftfRseni+65i1/mgGiNv2w2eRfwvJzaGoM6AfUerEvkFPgnv+yjqR/bzxk8TDbIReiAHmHNQHgalKQ7GAa4yuJ9BWw2FWiQb/ohb965+Wb0v/kGXn/Mczo7EglWiSVvr45yM6MIwGfyOvxgDtMWv0p6yiL5mPuP9b3scXq/Y2QRET0ATcZQj/T6sQq0Cfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rt1TV9wr5J5f2YhY/QGi84Gyb7TDIlR6h9/rcYDEEfw=;
 b=deJQCnMHPaKool1obroVSlOSYuNGgrNSTR6fqj31jVx8WbSOOqceElHP8fW/2d0U3SyeFGAb8uNxOdigOXKPlKNCPVi5BbbU8sHkW1DCAxrPiiomXzpulAmCtE55Y3Lb73Onp+I2k+BrEC6hMQ5njh0L1OkmiISOJVOsFoOoxk1eg6n+O2ATVA0T9ntIEUwaOfV2CTOIIwQSKKiSU2pEX/KJcsa2h9FGBSztVO5/IRRoz2XS2/nQg+Ytq7YBmOhBBkoQYKFFDoiUwrqWeW8lzOj50xo57LIUEinRaQ/0tHVXkEpPDuAGJWZ4ooRdVwheXWUzCt8VXotQzoOoszJOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by DM4PR11MB5389.namprd11.prod.outlook.com (2603:10b6:5:394::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 08:53:47 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::8eb2:90e5:b496:f4ee]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::8eb2:90e5:b496:f4ee%4]) with mapi id 15.20.6064.024; Fri, 3 Feb 2023
 08:53:47 +0000
Message-ID: <c9923e59-176c-2e52-9ebf-58bb25750083@intel.com>
Date:   Fri, 3 Feb 2023 16:53:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 04/10] cxl/pci: Use synchronous API for DOE
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>, Lukas Wunner <lukas@wunner.de>,
        "Bjorn Helgaas" <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
References: <cover.1674468099.git.lukas@wunner.de>
 <b5469cbb8a3e138a1c709ed3eaab02d7ca8e84b2.1674468099.git.lukas@wunner.de>
 <63cf2bc3cf76_521a294a1@iweiny-mobl.notmuch>
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <63cf2bc3cf76_521a294a1@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0219.apcprd06.prod.outlook.com
 (2603:1096:4:68::27) To BN6PR11MB3956.namprd11.prod.outlook.com
 (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB3956:EE_|DM4PR11MB5389:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3048d3-8de1-4761-6e4b-08db05c42989
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QmHQb+CiwevEpWgtVrDR8MTPvFG9phGdA4fYvxIYhX/kuDPtwicw9jwNYtLFMr1trsEHdp1M8mzZduATlQb6WTSZteSskmstBbu+39Pu4mY5Kl8QywFhCVCcQJqMvWOYnA0IBauGxn8nmbae1p44DRbhmKOmscfjEw3SSE8t+BNY4U32f74mC+HVa92wiz8Tu68UdQsQP3fHOP5jywa3flMOWZhkVuLw+FSfTNdUwFcBe6k8ZdoNrD8UEWZRCR6nay9J4pM/246QmnOC16USFn++XJXB0go0dV4rMaWXcwnqGgvPkNWRDfMUiR1aHzYolrShuHRD8iSX1uWRf0TgcRm+NGyGfkGeF6nXOyCYa1SFtQcOJ0y5bfKU7oAwDpVfrWR0TdcZG4M3rRfSi2E926FSJ0JzNRHfwaTD2JyqhN97OLABSOTiwjmUHFl0KWrVJhVNZ8qGnbe+mhP3kuVutmbWEcA/hb0wPoxWbX0iUfvmMhuiwX/YVvn06/oYIp5MzDQz6q9TyGeeRPDSfamgCs2ND0QjxzXIrE4jLAhz/AcpJec71DNlqhPgH7na7t7kHEzydmvQKdMFRaRqTI+bTxqtrW4bPXY40CnDtiO6hj3GxnbGazZu9TS6kVpPKt3yLE+bJmU3LiTrON8Lv1PU3b5yJ0m2hnrL2JfBcGN1/3XRC+1lgjFDtXv+nyaAGOZsLo0Kiha2qG2g8VyDcO8zBdLhxaHav2mI9Pbxu5128R4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199018)(41300700001)(8936002)(4326008)(8676002)(66476007)(66556008)(83380400001)(66946007)(82960400001)(38100700002)(86362001)(31696002)(36756003)(5660300002)(2906002)(478600001)(6506007)(36916002)(6486002)(2616005)(6512007)(53546011)(186003)(26005)(6666004)(31686004)(316002)(54906003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFNtTjhORDZucDFqS3o5RXhndXpNQk1ZY2JpaWJpTSt6L25IdytQQkVUNmoy?=
 =?utf-8?B?QkdVbmNLa1J1WSttMFBBMmRhSkJ3WkwvUGJtV3ovL25pcmZ3cW1vNGtuVEtl?=
 =?utf-8?B?Ulp6UlpUQXYrT3hRVUEwWHMyaThocGY0UWZXdElBVUROckh6a0FNSndBdnVy?=
 =?utf-8?B?dGo4K1VwcDd1eThoT0JqZDFOVzRZWXlobm9EVGVlOHdUdk1VRzQzb1J4OHFI?=
 =?utf-8?B?NWNqSDZLVW9oRWlNc3JTYmJUaGpsaER6SVVoV2FULzFWWWlDdEE0bEJhaGY3?=
 =?utf-8?B?U3EwZERqK0w4cTdNMmp2SDJZaCszSFc1ZytWN2NlTzQwckw5UmJwOHVOdmEr?=
 =?utf-8?B?MmR2RnFhR2gyalNaWE9kMzJWMHFFS2dFdzQ3T3lvUUxudXg4eUdCQzVhTGRa?=
 =?utf-8?B?QVpxTFJ6V2NKaEpTWHN0V01PTlBFV3BsU29RRVlsdURvMm5nYkJHa2ppaFRq?=
 =?utf-8?B?cEpwQjZCR0g0YkR6NjBpMlFKcDlYM1VJV2FyQVVNSEFVOUl5dEV6dzVSZ0xM?=
 =?utf-8?B?YnVwUWdDNnlKL3h1Nzh3Qk5EUDFRVTZKTmx5SThZZTY0RTh5cTNpcm5pVWZG?=
 =?utf-8?B?bDk3WGVPY3F0aXNJUDY5WmpPc0ZGTTlIcm1MckJoMFo1RU5rS2JnK3V6NEdY?=
 =?utf-8?B?NWVtWmgzRkhpdWZ6Sk5DdmFsVW1LdkZBcWJnaU8vTVI0TUVuUzRKaG5DZGVv?=
 =?utf-8?B?SlQ1Tnk0SUxLTWdvVkMyby9QNkZURFJxODZrRndhZDVaaGl4QTVmbS9yWnFC?=
 =?utf-8?B?bHRkNU9xcEhxVXlWa282MG9TMGRERnVKaE0zRHpaTlN3aUhFTzJzKytKRDd2?=
 =?utf-8?B?WkhVckFTMGdvSG1PTkdHZmdqWHpLRVFldVVPSFArZ2VJZnBENkQrWDVQWmYw?=
 =?utf-8?B?SXZlMWdNRkk3M1p3N1haMnVuL1lLNnFUU3A3MEQwNS9CNU1MRlVpZ0N2R1l2?=
 =?utf-8?B?blpxMWNoOVhXSDhIa3BpcGxVN21KVHh0dCtFN1Y3VmhMK3N1ME1PWVZ3L2FQ?=
 =?utf-8?B?SHF1R1NJYWVRVU9iaS9PWTQxVzc4VlYwY01RanZ0dGp6RzBZWDdWT0Y3YVBx?=
 =?utf-8?B?ajRsNEVRU2pSYzZBOWQ3SXFJa1dwVEhLR0x2K1BQRFY4UDg3UEovUGdqL1Nn?=
 =?utf-8?B?SmZhM3FIelhTZXV4NXpFeDgveDRhZE1jakNaOEIvV2dVamEzUCs1emdPR2R6?=
 =?utf-8?B?NzhZaTRQQ0RxUERXM0RhQlVqc1d3QjhTUXFVYThPdDk3aHk3eWZoN3pkQlAy?=
 =?utf-8?B?OVNzNnJaTzJvNUJkb2dia2gzazQyeHNaNlBuYk1TVUhUUjRqN3lXNnUwTjJ0?=
 =?utf-8?B?Q0pjeVRwbFdwVlJTM1VjNndCU1ErZG5VaXQ4b0xlekRvYmVBa1NkL2VlR0Vu?=
 =?utf-8?B?SkdSeTNVRVpqYnJzRm5TOWM1ekRWWmtLQWdINlE0dHFNcnNmTXdoMGxvd3F5?=
 =?utf-8?B?MVRDZ0l5RnE4OTNhV0dBUTYrYUFncWdVQ0U3WWRLVWFrK255UzErUkF5Y2JV?=
 =?utf-8?B?Wm5ra3pibHlJYzNTRm9MRkk5R0VuMk9qMWxvZEt5TjdzOS9MajZzd1g4T043?=
 =?utf-8?B?ckdRWWFKZlBxbE5zSFZ5R3gwdlNFV0xiYVhnS1owZ3dpSXZ0R3dlY0tjbGNv?=
 =?utf-8?B?dCtlSHhHQlRFMDRXb2RiMHBJYUYydm1UempraFJ4T3ljZ2Vqd3pwVUl0d3pE?=
 =?utf-8?B?MjhiTnR0bmh1UXIvaGFtNFIxRUU0bUExTkFPSndEcHQwN1d3UG5mSUU0UEI4?=
 =?utf-8?B?ZDY0ODBDeG83SUNuditnUkV6R3RlUjVRb3EzNEp1U2xsemdhWjV1VVVrL0xu?=
 =?utf-8?B?OVh0RkNQTWZET29sY2Z2cGZRdGMycVQvUFpOSUVhTEp1dWFMTTIyUmhSQ3Ex?=
 =?utf-8?B?QkYzcUtvRnVnTVljRW9KUmNtc3NnK0RhZ1hKajZvbURtNFc0R0dmd3pHRldw?=
 =?utf-8?B?NDFmZzFlUEJBWmFhdnVUUzBWallZUGZFNmtnakFpUlJLeHo3UHdyRGRITFJz?=
 =?utf-8?B?VmQzaWZNZTJTSTNQQTdLRkxEaUdYRlFVaDU0aEIwc21SeTVUZkl5cnhrcmZk?=
 =?utf-8?B?a1hoRXJQa0hsT1Q4RjZEV3FjZy9TT2JjT1o4WmdBWXhDcTQwenBTYWNCaXVH?=
 =?utf-8?Q?YFgzewSc+tgA669wHeskG1MQs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3048d3-8de1-4761-6e4b-08db05c42989
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 08:53:47.5720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIgXR4rwkz3VGRXwmNw9xGRIFkgIRMTkAWgTUmLA7SSTA2SOrTNArINTcB0FJoYA+n5YLha722W9XYJqh4fONg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5389
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/24/2023 8:52 AM, Ira Weiny wrote:
> Lukas Wunner wrote:
>> A synchronous API for DOE has just been introduced.  Convert CXL CDAT
>> retrieval over to it.
>>
>> Tested-by: Ira Weiny <ira.weiny@intel.com>
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
>> Signed-off-by: Lukas Wunner <lukas@wunner.de>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
>> ---
>>  drivers/cxl/core/pci.c | 62 ++++++++++++++----------------------------
>>  1 file changed, 20 insertions(+), 42 deletions(-)
>>

......

>>  static int cxl_cdat_get_length(struct device *dev,
>>  			       struct pci_doe_mb *cdat_doe,
>>  			       size_t *length)
>>  {
>> -	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
>> +	u32 request = CDAT_DOE_REQ(0);
>> +	u32 response[32];
>>  	int rc;
>>  
>> -	rc = pci_doe_submit_task(cdat_doe, &t.task);
>> +	rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
>> +		     CXL_DOE_PROTOCOL_TABLE_ACCESS,
>> +		     &request, sizeof(request),
>> +		     &response, sizeof(response));
>>  	if (rc < 0) {
>> -		dev_err(dev, "DOE submit failed: %d", rc);
>> +		dev_err(dev, "DOE failed: %d", rc);
>>  		return rc;
>>  	}
>> -	wait_for_completion(&t.c);
>> -	if (t.task.rv < sizeof(u32))
>> +	if (rc < sizeof(u32))
>>  		return -EIO;
>>  

Sorry, I didn't find the original patchset email, only can reply here.
Should this "if (rc < sizeof(u32))" be "if (rc < 2 * sizeof(u32))"?
Because below code used response[1] directly, that means we need unless two u32 in response payload.

Thanks
Ming 

>> -	*length = t.response_pl[1];
>> +	*length = response[1]>>  	dev_dbg(dev, "CDAT length %zu\n", *length);
>>  
>>  	return 0;
>> @@ -546,26 +521,29 @@ static int cxl_cdat_read_table(struct device *dev,
>>  	int entry_handle = 0;
>>  
>>  	do {
>> -		DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(entry_handle), t);
>> +		u32 request = CDAT_DOE_REQ(entry_handle);
>> +		u32 response[32];
>>  		size_t entry_dw;
>>  		u32 *entry;
>>  		int rc;
>>  
>> -		rc = pci_doe_submit_task(cdat_doe, &t.task);
>> +		rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
>> +			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
>> +			     &request, sizeof(request),
>> +			     &response, sizeof(response));
>>  		if (rc < 0) {
>> -			dev_err(dev, "DOE submit failed: %d", rc);
>> +			dev_err(dev, "DOE failed: %d", rc);
>>  			return rc;
>>  		}
>> -		wait_for_completion(&t.c);
>>  		/* 1 DW header + 1 DW data min */
>> -		if (t.task.rv < (2 * sizeof(u32)))
>> +		if (rc < (2 * sizeof(u32)))
>>  			return -EIO;
>>  
>>  		/* Get the CXL table access header entry handle */
>>  		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
>> -					 t.response_pl[0]);
>> -		entry = t.response_pl + 1;
>> -		entry_dw = t.task.rv / sizeof(u32);
>> +					 response[0]);
>> +		entry = response + 1;
>> +		entry_dw = rc / sizeof(u32);
>>  		/* Skip Header */
>>  		entry_dw -= 1;
>>  		entry_dw = min(length / sizeof(u32), entry_dw);
>> -- 
>> 2.39.1
>>
> 
> 


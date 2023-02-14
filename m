Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECC66970D5
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 23:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBNWoV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 17:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBNWoU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 17:44:20 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E0A2CC64;
        Tue, 14 Feb 2023 14:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676414659; x=1707950659;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wnjHJ+xXN/K/bA8pWQ+x7aZWqgTFwCjvKWiJFMNRCGY=;
  b=jpgtykBfL2HAT9Fs2G/qkPpue80GhhPGKjwzW0pr0NG/2ae5KOV5uTlI
   vL/pBFuRhp3F8u+szHa/8ZEU69onDHE2ZdNSRRKiUdUHgSpLY5NEENJE/
   GL0fqr/2GJbCu9lVB0WXAw4tc+QlSSrEeZ86Ql89DqzDT1hWyn27Nr/mT
   STF1z7+/iQc5wHZaz30WMChJ2ydiMGAmknbzpOGUbiDH/SbJonSZw6kVK
   o2a+DfeNDHUET7lx2VdQWWTw/a7FwufhYA5JfOKcvPm+dRZjb0L6KENqY
   ohrAPOxmK2loThgpqk6TjHzZPnvYVEla94VdYGbZ3vmbhYku8dAXlJKX4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="393691061"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="393691061"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 14:44:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="998235562"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="998235562"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 14 Feb 2023 14:44:18 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 14:44:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 14:44:18 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 14:44:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAm0gcQ9vENW6IVx2tmfZXfjPWTX+QloF7hA6hfiLcGR0D92iCdUAmhL72NEOSP/hGhj2qu8ppa9aQGvv/3a8VyrpscKJuX/fwoAOp7QuiG90SFWuIGldc/NsXDcwRuvN3F24NP5MwNBdxBu2bsIP9IjMaTJw8vUptsHnH5fzf3Kk1B711Qji0LPSbKTh6uydE83zbHJa+NE0/TqU1+J6+xqGnz8ezV7lnNZjf52RvrpF2DKLyiC0ufJIEPry/Nd+YnUKgpmSvy/nCxNh6l9ZRMiS7el72cswT6QQhAWbwXPtXIUbNCfGMIPl211LGD14PoT4GfFrvfyKoP2P/jhbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbegYOKnGmovOXxjhXMQTkATp9SLB6qdGF1trm1csl0=;
 b=HY/DGI8CfUZqyF6ZpOHOldbgUzy6ZSpyY/3jVlWeQGEjOYBEMCp8iaiRr8wtnn+lHkVmUxOKUwCXax+Z+RxAgWfBnEI8eBjssz4tbIYQO+eZgoYMbUFeqR87mRgWYChhDzckbL0aFWGjxGjdPNNQsYX4sc/g2Y3qtUiHVO997rO2J8vypAskawn9zZ722skGZ5vSAvA8OYaBzSmoB2JEJXF/mX/PiDfz0z7oXbSHrOqXeXSkiJNFpYPsUOfJsjWNZ8M91gfafGzVbIn+yGEBzbX9I3epWV6GkRX9yNlqnrNRnxuPIW5slmAzvdaPURclLOlhqIHqwoU2EK5oFc/96Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB6350.namprd11.prod.outlook.com (2603:10b6:8:cd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Tue, 14 Feb 2023 22:44:15 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6086.024; Tue, 14 Feb
 2023 22:44:15 +0000
Message-ID: <9b5972a2-63a9-6e2e-78aa-55ac112ef9ad@intel.com>
Date:   Tue, 14 Feb 2023 14:44:11 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.2
Subject: Re: [PATCH] PCI: Fix build error when CONFIG_PCI_MSI disabled
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <bhelgaas@google.com>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <trix@redhat.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, <tglx@linutronix.de>,
        <kevin.tian@intel.com>, <darwi@linutronix.de>
References: <20230214222400.GA3089902@bhelgaas>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230214222400.GA3089902@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0052.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::29) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB6350:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e39bda-7bdc-478f-6e09-08db0edcff95
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbVLUzZBar/SXMDyv4HRLggOJyRAo6E4FbX1q5mUwdMfEIP4KMUjzOrMeSsM7PoJoqRBsrT9tz72NZLnEAir1T+pcGDymtSQz+Gi5WYdUpOwiXQiz9hKv/d2pFFaw9RvXOTbE8QZC4vY9UOqhPKgz4K5S/d1FCfuhk9c84iLQcAZenF1zAUMbxhiOXWu1oeJlEBiDu/LqJYzoOfGTtLcMLl05D38Diex3G2sw2IoTXj00ofBrbWTMUo42Ryk/BByilfRcpXyPdo7vHoFXIIQnbVr9/rlfZ86hC6tgut5H7BZ+CVjnBMkgwBrLIjDyIa3VCyZ4I1bbqS6auYZuPtjilhtaLSaTySFd+sOYYXsqXPIRw515y380hDX/Shs7eumaGHUnWwdwkwJeBh167DuBnSLGkSX/Ncn0ywOq8+3HAPUeq5QUMGYSlZ+AFIPClbGbcxHLPJaYfpxcByr1I0/jJ1dD9v40ovEZMxVOIDEf5Zy/CkKOAOUf+hDGVm8yJ8qILDR0RdUutccdkMBSEO5KtYL0qXtoxQf5NTmOQ43WlvyYtBzf6JhM/sp3MOBwNgG47E2LGFvGEpS49Hbbi9m943isr1hPulbHV+6R/S9Sxh6j3hfHSbTVugtaeeCWWcufCTz094BvkwBGiskwknIEZ0YDdb4l1AaN0FHhfJNRr8bViX3S6TWHRjnk6KyEqMznBfi3L05g3+zt7Pca2v5W3JBQii63QdOP6srN7/t4I4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199018)(31686004)(36756003)(8676002)(4326008)(66946007)(316002)(31696002)(86362001)(6506007)(26005)(6512007)(186003)(53546011)(38100700002)(44832011)(41300700001)(6916009)(4744005)(7416002)(2616005)(6486002)(478600001)(2906002)(83380400001)(6666004)(8936002)(82960400001)(66556008)(66476007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkVuN2FwaldSdDRuSkRIYWo2QUV0akhneXhOUkVvdXpIVFRuY2Y2Wk1HazRi?=
 =?utf-8?B?VkYyZDN0bURja1Y2RDRnZDRMaGpadVJDd0JuVk4wWWluV1l2SmtmQlFSbHZX?=
 =?utf-8?B?cEpCcVByY282Ly80OVNXSGxoOVphMVR0a1lnaWR4YXdPRGlySGpaWGdieEVC?=
 =?utf-8?B?eEhXMnFVUmRxcVN5WW5SUGNtbFVWOTltZ2daWi9xc2NsQTYvYllQdTV1ZG95?=
 =?utf-8?B?TXY0U2M4UnBtNU9KTHAwQjczV2d0RkxSNkxvNzhsZ1VlejFtemVRSUVPc2k5?=
 =?utf-8?B?MWQ2RWEwR0YxYllwclVKd09XTDQ2R21MenR0M2RkTktrZVo2c01QeU9yVUEr?=
 =?utf-8?B?endreGhrbVY1ZWhpR09TOHZlblV0WlFiNXBQNjR1SklCejJScTl1UngyUCtk?=
 =?utf-8?B?d2dlYUlHR0Fab0txMWZVOGxxMDlLK1N5RU1FVWZ4Zjk1RUJQL0ViS081c3A2?=
 =?utf-8?B?dHlUU25OdkdlWWk0S21NeWwwUDB2R1ZKT3dORXZCTzd4MGNKektZVDQ2M2hK?=
 =?utf-8?B?enN6bzR4cEcyNTYxZk1DbEpUbHozOHNUM3RjakYzK3NmaC8vZ0ZPbzVodUNB?=
 =?utf-8?B?em04OEpOTFpxUWZRbGF0U1lkK3lNMG91VGh6dVNpMktDQzl6ak9RTFdtY1Y0?=
 =?utf-8?B?eEdiTENFQ1o5MkxZWW5vZEVmY2ZIOWV0cEpIQVU5SE1zbklocnM5OTlnaDJ2?=
 =?utf-8?B?cWdiWFFCSHNuUEJmeG8vdVgvMlllNE5XeTl3VUNxU1dKbElXQnJlcW84RURv?=
 =?utf-8?B?cWZZc1lxK09zNXBZN2RuR0R4NDc3YlNjaWF2Y3hKb2EwSFdhV1NPYWNCOHdv?=
 =?utf-8?B?cjR2TUNqU290aGRacWR6YnZuSlFSeXFKSkkrL3YzaVQ5UXBNdjVVZjZrRG9r?=
 =?utf-8?B?SytzZU9kQXlOYzBlVUgvOFdTUG03T0tkVTJmTGkvSmQvY0Zra1UzRDluTjV0?=
 =?utf-8?B?QlVoUDRSYVYxVUFhNytQOUFxWnN5R2dscU9uaDFGWVFRZkJ6N1M0MVJvZkFk?=
 =?utf-8?B?a1pvR2ZJK01qTG4xL1NmUTJSS0NnN0FHaWxQeEUxRFR3Y3pjeTlxOUpzMWhp?=
 =?utf-8?B?T3BoTHpFT1ZGZlB4YmIvRnVVN2pGc0k2Nzlwek02VHhtZmlqQlIvcnFNcjZw?=
 =?utf-8?B?L3BTK0lIZHFEdnhvK1dJSjBGMnFWaTgwc0R5UDAyM01oWG9sSkkya0oramFp?=
 =?utf-8?B?YmFreUZNUWljSEhIL3Rzb0xwbFQ3QnozdVFaOWowSmtWWnBtRlU2K3I2bThN?=
 =?utf-8?B?NjdqcHVXalhEOWwyTWE2YVJzODFSbDRKMy9YMjJoSGc2cmJtRGZIQmpwUGlo?=
 =?utf-8?B?NksvRVdrMk5jSjJGMCtPL0pyMVh1c0NZZnVjUEVneWVwZVl1WlJ1Tk0vZ0Z0?=
 =?utf-8?B?SEpVdzJZTVhmUjJNWi9nUWFCaWpDTmpkRW8zQzNWbWtkUThvaGttbTFDWkJ2?=
 =?utf-8?B?bmtBdjRJMnd1eWlaajV3MFp3N3JWK2VPdXhGcWIrM0QvNEpCb1BOZVVEZ1Rj?=
 =?utf-8?B?amMzS1ZHVmZZODUzVmc4dDEzUzJySW85dXVNb0ZBOFdvbDNpMHQvQjN5YmtZ?=
 =?utf-8?B?eVpSRkx4WDMyNWZrZVJtRkNNQkVITlFQMmdFNTJoSUxOUXhaWDVzZUZBM0lW?=
 =?utf-8?B?dlhhbXViUkNmUlBoaXo1aGhpRW1Qcm1qL1BmUnUxMFJ0NHRucFhjZERRUThl?=
 =?utf-8?B?ckN5R3FkanNFM2lKenpUMEJ0eVg1ckllOWNabDdrdkVkZEtzWnhsRURzRjZV?=
 =?utf-8?B?dHVNU21JN1NLQy81eENMWnJ6L1hMMElSdTdpUTFUaFFiSEhrandPSERHTjdu?=
 =?utf-8?B?N3JocTdtRWtzdUVkOXp0aWZOTDhqSk1QY2k4MjJ2Q29TampNOXJIZFJ6YVF1?=
 =?utf-8?B?RzAyVHcrZ04zYndZaCtjN2kybjc1aE9Oc3kzeStDMjlVdGNQbzVhMzdHeGFj?=
 =?utf-8?B?azNGWDNsVEZOWDVUcWVPWWpMcHgrNXdrdHVHTjB0SCt2ays0ZTQwRFpuTFBQ?=
 =?utf-8?B?bGtYZzlpaWg0MzNiV1o0a0ZQY3lPc1NqbCttYmYxSS9nbkFrOXYxTmd1U2Ru?=
 =?utf-8?B?MUJ2NmN0TUxvcDUzckF0WjlDTm94QzhYZG1PYmlmdVhFNzVQc3c2UllpOGs0?=
 =?utf-8?B?MStPRVpjSENCNGtwT296ZVZKbkpHak02UG5XazFxMlFGQzY2L09Ha1JWcTMz?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e39bda-7bdc-478f-6e09-08db0edcff95
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 22:44:14.8665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATg5iVfsYGr7A1rMWk8UJZhGiNU5qbUsGrskmt80QUHEBtAZVXUcuOLslg5K7HlDAgsscgkENurWImXx5JvFvzlPR72//OyRhwpINsqT0EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6350
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 2/14/2023 2:24 PM, Bjorn Helgaas wrote:

> I think this should have a "Fixes:" tag to connect it with the commit
> that added pci_msix_alloc_irq_at() and pci_msix_free_irq().
> 

Thank you. I was not sure if a Fixes tag was needed since it does not
fix an existing issue but instead prevents a future issue.

> Looks like 34026364df8e ("PCI/MSI: Provide post-enable dynamic
> allocation interfaces for MSI-X").
> 

Correct.

> Thomas merged 34026364df8e, so it would be best if he took the fixup
> as well.

Thomas did pick this up in tip's irq/urgent branch. While doing so he
added the Fixes tag that you proposed and also improved the subject.

Thank you very much

Reinette



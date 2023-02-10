Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26596928F4
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 22:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjBJVMx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 16:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjBJVMw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 16:12:52 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394401A951;
        Fri, 10 Feb 2023 13:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676063571; x=1707599571;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3m5ViBHSS+rf7NskbOCkXgBH0/Zr7NzADvFV9U8Lt2k=;
  b=dyWtfnYxaz4QPDkXwjfHo+uJdM4AjKBrqStA5XrEn+czADpbGEE8bUaM
   gMr7ASMg/rN+73gg3A7Zwwb8RxMSlIifHhssg3HsHLLu+8dWkNwMMd0Xf
   VCR/Rqj9UcZdqeju0gDIVYkzE8Qr4+Ub1kK7Ey/N9Kae5i2cMQkBdJx15
   815E3nqPnsTGMZ5SUJ4Nwyx/27k2JYg9C5Xbkpt+oh7tz3mNn1UaXSoDb
   BeCgUswuAqE8HJwRt488nF7SLtgn4laJcQJQqFNcTtwoh7c1hMmuaG5j4
   pg7u0auDKtNBjOU+8KJmmttQOVSIwwngrhHKW1W31w1tKj8A1vFXtSmhB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="328219204"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="328219204"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 13:12:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="913675732"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="913675732"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 10 Feb 2023 13:12:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 13:12:49 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 13:12:49 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 13:12:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5yLQxOnIvoqkVXIbfzRwd/5PyNgyD+52Q9Qn8owt/nsE063D9WeaKqzh1uZ3/5WIarYXGRj/TInsDpVvbNNKV+PUE5PJECrwNV1LZ1+KpM5G+U3fQVxi1TBcyQc2+77oW8ZgPUN1q1w4qOS/ptDAajRIf9cGbzFc7lu1I+Tmf2T0bpcANotTO3EtK9/rJkQQuuWryXlc3TdYZ79VZ82wNdSjSlIOQ0TobMrvEK0IdFibxcXxjn7phkXujEFJgnngRWhLad/SbMuJizzRLpY+Ez9CAYE1mh0iKvzY3cGNxCZ6Mcr2pPO3eu9PvbluyTKwMUSUlcIHKvI5VAJzq9GAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XM+loM+sv0Vnsbopw2kVMGxKIhgRtFmX1DbGz1CssIg=;
 b=G9nEc7mc0mAsFKdCiHmi+tpk96veFhSDWpYXOPXKKu4OMxc10Zcb6YrXuMwrB3IfvDouGyLvNdW+6cZVAPVYB+EFp5XMTtchHAhQUvwnp+8vjxykg4cSaBMiH/bo1V3UooubfNXfr1kQBD+j8ag0TiU+ViTfv6vlGy1vos168aY3GWqFFXnZXZmL7GFJGUD2sE7br5niZ03KMS62A/XXWBPBdkjEwzNOq4l+3gmmcRncY4maem3o7hIm5p7lshG05peNJOxxs0D7Z/GIcQHtScyhk6/PEk0kDR3NkbkgQO1qHszTSAEg9Ap9l2BTe/79uu45Zhg+Nu+v9+AahDUAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 21:12:48 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6086.021; Fri, 10 Feb
 2023 21:12:48 +0000
Message-ID: <af294def-fff7-469c-b8c6-a245ba641c2c@intel.com>
Date:   Fri, 10 Feb 2023 13:12:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH] PCI: Fix build error when CONFIG_PCI_MSI disabled
Content-Language: en-US
To:     ALOK TIWARI <alok.a.tiwari@oracle.com>, <bhelgaas@google.com>,
        <nathan@kernel.org>, <ndesaulniers@google.com>, <trix@redhat.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, <tglx@linutronix.de>,
        <kevin.tian@intel.com>, <darwi@linutronix.de>
References: <158e40e1cfcfc58ae30ecb2bbfaf86e5bba7a1ef.1675978686.git.reinette.chatre@intel.com>
 <333dee5b-6710-998c-bf3f-2cb1d676a7da@oracle.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <333dee5b-6710-998c-bf3f-2cb1d676a7da@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:217::6) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5618f7-035e-40ee-2a25-08db0bab8f6e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6pjTZl6PXHQBQpbGQhd9dilsSeSlDF7QMTQoxQU/JHY60+kA92VdKx/4O/HLAdNmtrr0HofN96cMryqoTRKjagGC5VFh/2NALy1TXeg+ZTJkD93KSOmORZu+VVpCLmI4ckB2MVZk4NiifRnWgwgcXjsYRSP6P/gEgy7skpYbH+1j0uXo/v/UBtDYP1j4GgzvHgd1sgNATlOLqvivSnjrgs8nDAp8L2lJ2DxjCfQ+osP4sXrXOOj0/78GSwt3ORbYkk6to1J+IC1NyZ/J1AfiDcBN1l4mfQIuWmqR6+kvjht7zA9HA/KZIWRqRn4fE2lYMvfqOpADESB0gap9BNMm5/EDbbyMdTn7eXif+EAJyttPDQpyu1RKp6GxArEWcSHUkf0rnvqKzMqTsxJSnqkELMB+mLsQFoW7uBNh+yE5uRGdzVMWsH2rvyy12I5JBejNbn0kPnbJZ1i4tUQOUHlfO7FEVKpFZE1rGFP0IRsW5FMuXYBYY/pupMchknTNcPEsvh4RQsJUyaOvQyPMWgWqFCTBrpJhS/z012WcmIJklK4+3wMbDLuybW0PeO5I0JD85f8WthHCxxo9k6hXVSBWCBM5rorkjwXS2ErHZUmMujHEVxi3DtJorXmt/nkRzYjfZXWg3EOna7SPQipccOcr/td4n4VCMmAmdYWJxxqxTJ0RzWHFeU5Xa+uUD19OlxFdy+ogoA8OzpqhkyuCeLp0+JYigF2nQKiX7MMaxtshCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199018)(86362001)(31696002)(82960400001)(8676002)(36756003)(66946007)(41300700001)(66476007)(4326008)(66556008)(38100700002)(6486002)(6666004)(478600001)(6506007)(8936002)(53546011)(5660300002)(4744005)(44832011)(31686004)(2906002)(7416002)(6512007)(186003)(26005)(2616005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGZ5bGpvTk03UThnU1hPY0gzNitWQklWK0JucG52TmxLUTRjS2ZyMUphcVgz?=
 =?utf-8?B?M1pLRFB3MzZ0Vzh1OFlSUDM1VHZBWUFMZHJRbVZKTmZGTWJRRzM0emNKRmVN?=
 =?utf-8?B?N3B4bVU0M09TNUpzYVFkNGQ2cHIvR0xRN2pMS0FJTGJ1Y0pjeDNJTXR4cEpQ?=
 =?utf-8?B?U2hGRXBqR09PUFJmdWJiRXNSRnprM0dkVzk0REdoVUplSU9SbWdFcG5OdTJa?=
 =?utf-8?B?Q2NGZzNhV1o0dlU2cmlqU0k4MTBYU1p2ek5oQ3d4Mmtqd3UycllUMnl4aXh3?=
 =?utf-8?B?WW1lTTZLVlBiYnpkL3RJNklqa1FyNWxuYStYTTZQeExtWHFkN0diOUNoZHhr?=
 =?utf-8?B?WGhCWGIydHJDNW5ISUIrY3BuaWlDdXptd3BocWRRQjBKZUgzS0xlZ3ozQ1dp?=
 =?utf-8?B?bXhiQ0tqWmhpbGEvYk0rQ0syVGtYSEdnVDNscHhSdWt0TFVTTVEwRGJ5WExC?=
 =?utf-8?B?OHRQTzRqc0xpV3ZCWS8vMHNIRmJZbFU2SDBDUE40T0pVaEZDbWMzS0RDa0hn?=
 =?utf-8?B?U2hhby90QTRieCswcWI4THJKZ1ZVanBSNzNGRkhhc3lJMjNGeXRHRUhNcDFr?=
 =?utf-8?B?U09sWlpTRGprUkRzeFFxQ1hqUWhSZC96ditHeGtmS3J4bW1XWDFIRG02bUFn?=
 =?utf-8?B?SHhqSVhMZnNUZmFtU3ExYVdQZVRkMTRaT0g0M3VPU011QkNQS2hkWVUzM25m?=
 =?utf-8?B?RllkejFQcnNwZWVXcG9TZUtMbDNVMWRQTkFoUkNhK0p3dDFkMi9lWHM5ZmJp?=
 =?utf-8?B?bXAvYUc5SmtYSG1iaElWY1czcHlrSFMxRHBmU0F2VXduQ3ZIa0JGcWNIanJ5?=
 =?utf-8?B?TVhEUTk1NkkzRmZvOHNZY0htV2NObFFoMzd2Q3BqaHo2MTF5QUkwSjVXUmlh?=
 =?utf-8?B?UzBjZkU5VVo3MTVCT1BVazlQM3U2YmdsbEtJa1d3bVBMcUVjNG4vMUp1K3VE?=
 =?utf-8?B?elhmVGZnM2trMmJhSGtlSTF6eHJRaXFPYXNSZ05sc1Z5L3B5ZDJsaHVvbmpO?=
 =?utf-8?B?a3E0cFRRd3A2alNYQzhOdkZGRTVTcGsyV05OblBJZU9Bd0lrSmc1THNMcFlE?=
 =?utf-8?B?TlpKOEVNWTd6aFlmOTI3V3A2NUIzQ0FkaEFaanJQRUhwVXRsa2dRVW43TXVF?=
 =?utf-8?B?ZDl0UmpKNUdodmRMZVdVekc3K2xJZVhOTml5UFVOS1o2U0NSRGx2MjQ1bzFx?=
 =?utf-8?B?MDRsbHlJOHhzRFR1cVg0QXlQU3hQZ3dDYzhMd3NWa3NueklVS3N6d0x6cEdD?=
 =?utf-8?B?ODIwRzZKN1E5eWJPTnBnYWRhTDhFWHY1RUhBdnZOekxTazg0bDZyclhGa3ZY?=
 =?utf-8?B?RGpYbEI5RFB4WWJiWmVZcGM1QlhyOEhXN2h5MjdLcXE4S1E2dnMwQjhJVnVS?=
 =?utf-8?B?ODJWcHVkZjhBcCtnOTNvc1BGeHU2YmlHL0VyQmhtdkNmL2ZCZVg1Z1FSSE1I?=
 =?utf-8?B?Mm9DbWtOb0lEZkRIbklmNlNEV1E0WFhTT1BDNDF3NFF4OGFiODQ0QkdmM0FB?=
 =?utf-8?B?SzlQWGJ3OGtmVW8reStkNVVadzZ1bTdsZEhWbnJ2WldIM1ZydEdiZjZHYkEz?=
 =?utf-8?B?eW5tR0VoZGNERTBVbGp5ZmVxL094anV4RGNLdHMwalgwNDdGT1dXdi8rSEVQ?=
 =?utf-8?B?L2hTSTI3cGJrdHFsMCtWL3NRZUZBZCtCZHh0VUFGYlYwZlc1ZHovR21FR1Nx?=
 =?utf-8?B?N0NRQXNpL252dXhGdnEyVmlETGpCMVZQZmlQOHBqTWppcWlsT3UzUXRPckNj?=
 =?utf-8?B?a1A4cmlJdWFtbUJoMUd5VVVJWHBiTCtEQStpbTZVSzJnTS9QelgyUG84clVn?=
 =?utf-8?B?UTQwdE5UWmFwU01KdUFnMHcrMU1KRFV0eU1CRWpjRk9XMXR3dXVEbEU1d2Zp?=
 =?utf-8?B?SnJYMXhDbU4xMXIvUENOWDZCQzcxZVNoQ2VzTTN6cjdyUGt1OUlka0dENkNw?=
 =?utf-8?B?MHdsNVc4bTVBVnB4clF4a01DY2hvNndKV0kzbzd5aFJwMG5pYVIvTFlnYzJT?=
 =?utf-8?B?dUdPWEd5R2FEYUQ5dnpUVGtkclJzQlFUZHJCZkI3d3IyQWo1QXBZZHhONUY5?=
 =?utf-8?B?Z3V2VllhS08reEhVSENMQjFHSkh4aWNSdTNTVDl4R05ycDFhOUZYMjAzU2Y2?=
 =?utf-8?B?S3ZlWlJhNTZ5bWJwSmNmRnVwRmdnYmYyUEduVUcxRGFLdHptdUJKU2FVUEw0?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5618f7-035e-40ee-2a25-08db0bab8f6e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 21:12:47.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlMKtUq1BQujH1ZunjCDqZXrJvR0y22Iw5TGS/aOz9CvUizPH7XtUcGhO/X5YiMMrYT0Gl9w8yUwWn1OS1Tf8w/3HI2L3p5E253a0WIk/vw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6397
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alok,

On 2/10/2023 12:45 PM, ALOK TIWARI wrote:
> shall we need to define this function under -> #ifndef CONFIG_PCI_MSI
> 
> #ifndef CONFIG_PCI_MSI
> 
> +static inline struct msi_map
> +pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
> +              const struct irq_affinity_desc *affdesc)
> +{
> +    struct msi_map map = { .index = -ENOSYS };
> +
> +    return map;
> +}
> +
> +static inline void pci_msix_free_irq(struct pci_dev *pdev, struct msi_map map)
> +{
> +}
> +#endif

No need. include/linux/pci.h already has those definitions.

include/linux/pci.h already has:

#ifdef CONFIG_PCI_MSI

...

#else

... 
/*  new function definitions will be inserted here */
...

#endif


Reinette

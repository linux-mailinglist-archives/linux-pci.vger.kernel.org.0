Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD9B77E851
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 20:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243883AbjHPSH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 14:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345399AbjHPSHg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 14:07:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF88010C0;
        Wed, 16 Aug 2023 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692209255; x=1723745255;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oDE0/TWPSMV9wdoT2jXL2TDMG+BQRIg2TwVnYSas+nQ=;
  b=FZ262HLGyxjjvIijUeXhVGTWVj46zp+rOLB/jN3N1uvHGHPAZ5mdTFWi
   OZm9NimEy4857+B7EWHdiy9LI64tju19z/B2tWWHVGPTXbHFoenKQjO+j
   J7AlyhU977q3eZnCWIJT/G+GSo9MDEKQY7U2D1lTrSQXFGfvO9+fWt+ks
   sj/e/0vswa1XIL5UVJsfxB2K14OddT41vcDmnFtOr51piZe+TziAQF9lS
   oqnymGYqbLU4p7mmu1HEwk9IX3DeaG87Nv43H2O75hROdX/MPtwuAt8j0
   05hvz/e8YTDc1Gsb6Z8QdWWRdjaEJvs+2mQprIEiUmd2pzKP5h9MjARYD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357574454"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="357574454"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 11:07:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877906444"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 16 Aug 2023 11:07:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 11:07:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 11:07:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 11:07:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 11:07:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnH0A2IiLKPQbR3iL2Udm6iLoMSuwBT/nEukod0qb4X5GDzEjjqXlvhQo0QMYjGqybEPFkjCrxuzYSGQwlJbZJEDztsiepMZD5wcRGDazW1mYNQKVkCMIXbIEj4+vAgIKoftLprvczTfmUW2armIfZviQYFPU+JqrUpoPU5jcMqrm5ibm9MfBuGnxVPv4mpdFwOngj7+kPwztYCDqFh0DrRyfOkYCSdyXPvDyYFb4OlSV5IKpaZLKae5BlRfJ8IKRjyMnqbYSHgz2xc1mg7H0DK44LnO//R4/GBtiTwtHzF4uA7HM7ktNQ/vacG1C5T7ipdjy9xDTiC3teryxySC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdeir1bwMp9+51Bs9FFxQiQAystdKB7x4ahe0gaV/WE=;
 b=AFFKn4qFLPOY3SUwyCMJWOPED9bhMhQY/Ojbkvh+saXIoDS8wQgtOnLvsloqdAweWEL4qSChY8F/OccBg0B03vTGCIddYyoJkZESeORmlkoVA3jBjw50eis1aUWCgwjc7pXliIUh3j+RdDrW0GO9CwyUFCkjHWVeo+VRARTU6nQ3TTx8tWc8c6TUTKceP2aRMrF1rjNIYK4refbbS9UKBHpA7Gyu90j1q6GXtPOaZChx1494+gWKyI9uh9EcwmeuFjSp9IbEjcwCCgk3lHJERx4LESswJPuVHx1o9ISWcBuVa93cqg/hv60ru2JGhN9J4IOzSrm97rn4khXVnoS3YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB5046.namprd11.prod.outlook.com (2603:10b6:510:3b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 18:07:32 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 18:07:31 +0000
Message-ID: <0c5a9c27-70f2-dc19-58e0-d8059c4806e6@intel.com>
Date:   Wed, 16 Aug 2023 11:07:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v3 2/3] PCI/AER: Export pcie_aer_is_native()
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <oohall@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
References: <20230803230129.127590-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230803230129.127590-3-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230803230129.127590-3-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:40::30) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB5046:EE_
X-MS-Office365-Filtering-Correlation-Id: c992424d-dc3e-49ed-a040-08db9e83a89c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 82XputXG3RNL/WwiUXishjQf1byooJZGWpOxUtnYVrYXN71lmeO434IDBNKV6wX01+z86Y7D8c744uyEb8CDvM6pdrk1MxDbMw/nMD26bLyXh8JuB6WPk0AvL5g9TC069zqZp/K1mRUm+LI8ZjED2idHj+/5ybnZ1i1DAW8r8ahHcwyiRvidRCpkacEf9uYeaCEYY0vaRroCDH4tnr5dYx99OkDvjyVzD/guOubnOUrv2Lvwxy7qmeipyWirDQoLW0ZgseRgyiQCP8qrbA5PAZqAThW9dBElwspQGp/SS2Pm2PZZWVpfbiIRw1pyoaI5+35E/Ix9NHElZGQILbxo/1DQkaL4HMAPije+LJf8HtiafnmI7j8jtMkcHr3buKqk8bG9RUqlCTVUg1qfuK11ux/70cmreKa8j1pNYAJWgMg0KmyFDZ80WB0gIlFS+spSYzOnKHhCoTinv8rl082mvxvnu4VFJhKIR5vHtkN/w7kzFYhirf0LspNWGeo4GU8kfEyV2+DV4pzcadV8PK1tcYMS3t7doa7I6w3OM0UaukwvQXmJzz866zZwZexsq63z1fNllCylzwRp53VWllUP4yQckQT8nBD/OKia2nHbkJlR/5+hkN9cMLI+GiDbU6x3yqQwIfiO4tpu0U4C5rmJKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199024)(1800799009)(186009)(316002)(54906003)(66946007)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(4326008)(8936002)(82960400001)(2906002)(83380400001)(26005)(478600001)(7416002)(86362001)(6512007)(53546011)(31696002)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU01QUdqdjlOelNKUkp6UG9qMG05TUtuRVZiMkx2SkxoOG1Rdi9kUnNPU1F1?=
 =?utf-8?B?L3pGNXc2MUpjUWpiYXRPNy96S2ZJVDkzcytvamNVbVpYMnVZTDBhVEZyMFJr?=
 =?utf-8?B?TzVaQnpzT3UvdVEwV1NaMG9TVS9jbXBQZ2xhN0dJenJuTjREYlhJZGYrYkFG?=
 =?utf-8?B?ZE1NMXdIL0FGT1BWcEg0S2pLUURNQWZqRFFacndDdm4xRFoveENzTDJVejcv?=
 =?utf-8?B?dEhLb0hXYkJnakorWklkRkNSTGQxcDFIanFWMG1KMWF1T1A5ZVNiSXhrU3Jn?=
 =?utf-8?B?dVAvc2cyWHNIYkNQcFl0YkhaQUhvcWJQdzd4ZlJCZ0VZbjhPL2NMaytqbUtH?=
 =?utf-8?B?eC9BZlZTV2lmSlJranNFc1RlbmxUMkF4dVhXUGtOejlkbmZSa0ZzZytQdjhm?=
 =?utf-8?B?Yy9wQ1F0dVpESThwT1BTR1M0UlI0QUFUZ0Z5U0hVMVl2ZUpTT2w5UzVHakkw?=
 =?utf-8?B?aXp2SWwxNU0rZEJOYlpkZTFnbGg2NmdBaDVPSlZrL0s5cVpybEZIUmlyYUEw?=
 =?utf-8?B?V3l4R0l0K0MrSVZKMnQ1NDRmbnNIOFhSSmVDVUNQb04vMFVNRWFLMEpuT0tL?=
 =?utf-8?B?U0xsTjdOZThOMDBOT2M4Q1ZhQitNOEYzWnBtWDJQUHc2MGR0amhoRVJGM21K?=
 =?utf-8?B?YnptUnNlUFh0WVpWMGRCVFVVUUxlVUhhaER6Z09OUW00VUVpR0p0M3pWQUtG?=
 =?utf-8?B?YVlqYlhQcWRBQ3lTWkoyT2MrTWc2Vmk0YmVVK0VERkNzdzF5aTlqbzQ1UWtm?=
 =?utf-8?B?eGZSOXpiZGxaaTM2UjdScm1TSmlYLzZWV0taYXBRczJjNnhjZnpOY002TWoz?=
 =?utf-8?B?K0lRbGI5b3gwYkhsS1A2TXV2RmlGb1NYaGRNSC9McmdUNStYOTU4VHJ0N2Rm?=
 =?utf-8?B?RndjZjBXYWgvMlBGVEhBR3lDbVUydWQxWE1venNsNnZPZ0ZPd0ZuSmkrVnky?=
 =?utf-8?B?V0t0M1NFb1RiaXFlbVVzYmdYTHBxNUVuT2tmcVN2U1FkRlVtcFNyVDRsRjNM?=
 =?utf-8?B?L3BnS2VxL0VVd2VpYzVlVzhQK1lZaExrajJ3OFFXUERRaHdNUTZmczJYaHl2?=
 =?utf-8?B?TTUzUFNOVUNDM2c5LytpVkMxc2xPVlVOeG5mVUQ1bUxocnBiamRLOWozeXM1?=
 =?utf-8?B?TVN0T2NaTWFaajlyUXdVOGdycmFmaUppOENDUGFXclhvOUdaSXU0dWVic3E1?=
 =?utf-8?B?KzRZQWxOd0tqL3FJOGJLK242NXpPVHZKeThkY1l3K0VraDRycDZieHgxYVIz?=
 =?utf-8?B?YmpPckc0N3RzaTZDR1dFdzF1cFp4bjVkN0Jxb3FkKzZ3dnl1ZEdGNnhyc0E0?=
 =?utf-8?B?MklSNnFsR0hPVmxSWG8rVWNGWDVaVm9oS0VRdnExRVVtTmRvMm5mQnFHVXk5?=
 =?utf-8?B?Q3NpUDJGMWd6aWljeVVLNWM1d2ttSVN3bWl2M2xQMXIzNXplQUdoYjdya1Q4?=
 =?utf-8?B?dFhoaVg0QWdkelFXaTVKSi9EaGhBNVM5N2I2NktEeXhuSHkzb3ZaRUlLbExl?=
 =?utf-8?B?Y0tmbkhCcXpEWWczNEZiS1M3NDgrRHZnMmdmQmNhenZobnNMbzVPZXFxUFVN?=
 =?utf-8?B?TFNodGNxRU16M1ByOXVzZ2Z1RDc2TlpaRGU2VEhMMy8zdXJNUGlIU0NqZ2FH?=
 =?utf-8?B?cFFLanZQWElqQW5COUFqaWpmVGUybjU2bUdHN1VZdFlYbXI4cDJXVXlWVHZv?=
 =?utf-8?B?YkhJWTNQbHF0ZDZjYVRrLzJvRUNGcFdkSmVMSkhmR3piUlFNamR5b1lJdE01?=
 =?utf-8?B?dXgzNzNpU25mNFA0ZWxvZ2NSR3dIMjk0YWU4SnQ1NGF1dlZZR016ajZTRlk2?=
 =?utf-8?B?bWU5UWIxQ25wVWd3RStTc0UyaiswaVRFZElnMHB3cXZNMUNDMDBJRGZGMitH?=
 =?utf-8?B?c3crM3l5Rzh5NlUrVGhrYVJUck9JZDM0c1VKWWt5TnRpRzlOT2UvYmRRb0Nv?=
 =?utf-8?B?dVVuckFRR2JKWUZ3OWF3SzhGY1k2U0ZsdUtEOFdGM1lKUWE0Y1gwSnJ0WUdJ?=
 =?utf-8?B?M3MzcEd6VDRZZm41TDFhNzFwQjdic2UvbGFiV2w2RVlFTitycCtlVFJXemdU?=
 =?utf-8?B?V3FSU2dqeGxUcWJUN0ovMHIxa0Y1emhFQkovMHJVL0ZVZjl3c1ZUek9iemhj?=
 =?utf-8?Q?ObXZjHZLdebKgkvqB+N/qaUhY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c992424d-dc3e-49ed-a040-08db9e83a89c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 18:07:31.1730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3qaxo5HplJRfLMO3CkYlsydj/vxag6YFVbdUXsPxWNFLQGpNZx1h+8sPfbkFSCyHrYSVyAre59lkCTqRPFZhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5046
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



On 8/3/23 16:01, Smita Koralahalli wrote:
> Export and move the declaration of pcie_aer_is_native() to a common header
> file to be reused by cxl/pci module.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> 	Fixed $SUBJECT
> v3:
> 	Added "Reviewd-by" tag.
> ---
>   drivers/pci/pcie/aer.c     | 1 +
>   drivers/pci/pcie/portdrv.h | 2 --
>   include/linux/aer.h        | 2 ++
>   3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f6c24ded134c..87d90dbda023 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -229,6 +229,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
>   
>   	return pcie_ports_native || host->native_aer;
>   }
> +EXPORT_SYMBOL_GPL(pcie_aer_is_native);
>   
>   int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>   {
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 58a2b1a1cae4..1f3803bde7ee 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -29,10 +29,8 @@ extern bool pcie_ports_dpc_native;
>   
>   #ifdef CONFIG_PCIEAER
>   int pcie_aer_init(void);
> -int pcie_aer_is_native(struct pci_dev *dev);
>   #else
>   static inline int pcie_aer_init(void) { return 0; }
> -static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>   #endif
>   
>   #ifdef CONFIG_HOTPLUG_PCI_PCIE
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 3a3ab05e13fd..94ce49a5f8d5 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -45,6 +45,7 @@ struct aer_capability_regs {
>   int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>   int pci_disable_pcie_error_reporting(struct pci_dev *dev);
>   int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> +int pcie_aer_is_native(struct pci_dev *dev);
>   #else
>   static inline int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>   {
> @@ -58,6 +59,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>   {
>   	return -EINVAL;
>   }
> +static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>   #endif
>   
>   void cper_print_aer(struct pci_dev *dev, int aer_severity,

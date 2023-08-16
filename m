Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DBD77E855
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 20:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345400AbjHPSJC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 14:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345412AbjHPSIf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 14:08:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F952D64;
        Wed, 16 Aug 2023 11:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692209297; x=1723745297;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8rlyITqaWW/LopYzqDCGNb2CU/kTBaHgEAq5jaf6pbg=;
  b=gTqciO+KwfyOPgB+LZ0QE/xupX9vh4PP8v2pZiD3FrOSosins4kV43mb
   uh/c7AzW+U8a0AdWDVqIa/mLYPTJzz1AESeW9q+TGfGydnhNl0DhNQ1aD
   SsPMYij0EngtKw38Qh6KR+cifoJPKwT/ljgVa61VLe/8vgU8mR2KDICR5
   xjQmktR0aPJmd+NCTG7hJ1EaUxvnvQF1GBBW7RjLHbu2ihVTa9pQZsVDl
   PQpTn5BMn8IKXAVo0dQVYPFmb0M35b9pV0RKF+l2v/0j+27cOKubeYqsZ
   hG2STrqJWFVuRM7f0UWR3MAMndFJYb366TD/D4eZWZBURcWyfmBvxH4Oo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357574802"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="357574802"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 11:08:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848575078"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="848575078"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2023 11:08:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 11:08:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 11:08:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 11:08:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 11:08:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0M7u7eOLOtIs9nJe8xdMV2EAKouvwMrtKt46KFDDsLL5C+B8pySbGiFa0BE7idHkMwJPEE3JhC16DJA2/GqQopsiQuaRpb3N3sOPZTdaQo0NqC+IvJuwpyaeHOJ/kBvvxqoeMIedieY7/1f1zw9Lm9QxpcuOyKfKLIkb27lcz+WmhYBRrQgYI0Y0Uf5vqj7kXRseivgRgaADkkjAqSEIN1vEhPX3sGvWol4abIMLg2x2DjIiiMhAMaVcK+5cpQtWMV0m5pjZ4p8dBm70S+RN5vZo4SIrZ3ea5CW9mFlTfX2xXhALJY35MxOEUgIkYTo9+pcZL6F6/wYdHP4L1UgIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2oQVTX5mW/t7V6yG1MPFwynourhOl031wFgOg65GdY=;
 b=jGelaIaX/Ke4hqGxRua4jB58nGhySujgtq7UFCzLtuBQ63eqzzIsqImdXnij4qlVr4JfZ//wYLCjpIfuUoBw/ew04p3Xdyn/63CrUliFjC037LZEaFOfxDD9pISj84XTtNo1+IjttEhIdhdTXEwcFqLFeSl7r8LsQfuMtXrervlzRtu4OrAFe1n16tc/KQ2OWUKah3UE5qBRp7SIpUbZNvzz3nllO5/pVGs/w52VjXPTZreRrfKvtmQC4K/NM4BjC45nMStI5GHhSHVNnIKC2Y1flokniWY+BAyhHcdmlOd8PRpysh3vJ/zO9uLpxNwsIM1LcoPQM5i0aBtwgu0olw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB5046.namprd11.prod.outlook.com (2603:10b6:510:3b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 18:08:13 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 18:08:13 +0000
Message-ID: <f4791b93-951b-4687-147c-ebec51880f14@intel.com>
Date:   Wed, 16 Aug 2023 11:08:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v3 3/3] cxl/pci: Replace host_bridge->native_aer with
 pcie_aer_is_native()
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
 <20230803230129.127590-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230803230129.127590-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:40::43) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB5046:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e187cd-7349-4463-f8a5-08db9e83c19c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Np+EiT52gDyCK855W6JM4AKK0URSO5hjnpbUz92H7QH0ee+1uEwRefQV0ThpDZLM5yFHpcRf7NGdbQLhSu6jZHwIc/CHyx+B2vRVo6SVmZePaQa8kghdW/1acbWVK8q9kDFLBX6cn98caV5IC8YOvcDwO2MEkS8jaUm5IqqDoF4W+IIM3kYIRI+aQrNz+X6mM6tmYh9cJbG1C8q4BYp/NC50ky0mc549NRyymVBcIJbGou+OIvXbx8Tkvl/U66+cCDRgv/w952yf/zNp4YDG2af1rCMApkiwChQD9NL80aQObzI8GZ0+iIBu6kYcsKiaOnepY5yqvx5dM45QB8RLWkkzbRGIqYMbXGEGowQMEU3y2HX3ielUMW/wJEs3/UkXBZYGL/3APUmKfh3WYByCZi0GGJTJl0axvdV6ZAQhZ5Jk4onKr4ibq3/BrPVZ08dQjSXMfdGJQdlsweqO6PJ4Sqh2KBOlDiouuWoz5jbokBFhYSyGT+FTr+780G5OUyIQLhojCgEE5rlc/lf/E+9t/kilVO3pZBMFAVMbzj/KZ5TvpRXueKgd5t1AMjng727/rMzDmHpvq3rMIoh8+rrClhVRdEhk1zudD/dw6HZltbUArOsStmdTE0oCHQ2n+uk882ghJWQHnboKekl+6cqxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199024)(1800799009)(186009)(316002)(54906003)(66946007)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(4326008)(8936002)(82960400001)(2906002)(83380400001)(26005)(478600001)(7416002)(86362001)(6512007)(53546011)(31696002)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDdpQW4yRW8yb2F1T3NBLytpbG01TE9HSGhXMWhHZXV4ZzBQcm5Vd0M0ZlJ5?=
 =?utf-8?B?aGRtRGFYNFlyVDZHdU55RXcyOHd0dWhrbTBabDBFZjBQSmZYblh0SXVDV3Rw?=
 =?utf-8?B?bUxINEVCVzlDYmZ5NFQ5SVlxNlZCS25HMXZ4SUlLOElXUHJESU01bHFHNDNF?=
 =?utf-8?B?STEwYURaQ3lLTk8rR0kvZUlzWkljZUJjUytKNm52WEpPaVR3aXk0cjRuaER0?=
 =?utf-8?B?Z2F5RVpFd0hBYmNKUWhneExoK2pYQzVnRTlYU1V1SzBDcVZlN0I2K2FIVHBK?=
 =?utf-8?B?em10YzNabldickZrSXVUTkxtUXMxcm51OFhqc1QxWjA2NTliSzdNbHE1eEpl?=
 =?utf-8?B?V04wcWdVVU50YitwK1JHaU00UUxUTm1NTENKQ2xrSXJUa0xqdURDQlNnby9M?=
 =?utf-8?B?U0ZhWVhGU0xocHpkVTFhQUtJdDhqL0ZjNkhvZnVVUkt4ZFp4STl6RktseHB5?=
 =?utf-8?B?T1VoWnc1YzEyTEFEd29KaFZqb2R6REN6eG5tc0p5eXlaSWEyWUx5QmJ3ajhx?=
 =?utf-8?B?UlhCVWltNnpackxoOGZVNUEzcFhOamR3QmRzdGlGblJIZHpYVEhPcmdsaFBG?=
 =?utf-8?B?MGVrRzdJMUxNVEgzd0VoRGJrNW85UUxYUjF1ejNvVG84dFpJejcxenRXQnha?=
 =?utf-8?B?dkh5MjVIcEE1WHE5SXJoWGVndWx4RXVpUUpQVVV3RXpTMS85aTBXM0xTbTI3?=
 =?utf-8?B?R2JuTzNWTEtWT0llNmVxak9ZbGZWQ3BrS0pGMzRiS2VFZ2ZjRUtCNDF2OXp1?=
 =?utf-8?B?NGFOTmd4VTk2SlIvbGRnZFQvUFVkcVZMMk5hQTU5K2tXbUJPSU9RMnMwbWMx?=
 =?utf-8?B?bUxRVnZDUEtJOTF4L3RlSXFZMG8rTzR4MEtvM05NTTN5N0V6TVFQQUJIc1Vl?=
 =?utf-8?B?dFErWWFHcEppRDNmMEJ4NnFXTUJ2VVR1RVVvZEo2UG9yUmpCL0NJREo5djZX?=
 =?utf-8?B?eVZaYVJzNmNjQUxuUUd1V2NqeGFoMU5XOVNHSGluaHhOQnlONjAyejAxOGxx?=
 =?utf-8?B?SkdRbWkxc0RXRXBydzJyVk1Kdm1rTTA0V1VnWGV5UERoU2Z3SG40RWpoemFV?=
 =?utf-8?B?ajU3V0hUbkxRZkN1VjNtbTFLa3BCamY1ZTZDbTlBK0xpajM1VmhlMXNmVmp0?=
 =?utf-8?B?WlRnUkRCa1ZUYXk3YWJ2L0ZmS0xQS3JDdlNiOGJGMDF5c2JsWHRhN2dBZER3?=
 =?utf-8?B?SHFxMDV1NEx3NFhOVmp1SlMrdDZhR0h4V2UzVGhtT2xpdVJpbFdqQjNQUDVa?=
 =?utf-8?B?TXl4MTQ1dkQ5T1B0eit0eUFEVFZ1ZUZWbjZSTHNpbUxHVnZobkdWOHZZWGRJ?=
 =?utf-8?B?QTAxUWlYSGRiV2xjR0E5QTRNckl6c09Tb3B2eVRNcU16bmlzb1J2ME9GYlVx?=
 =?utf-8?B?aURkZTJzZURHVkk1OEhXOEFobWpXYnhndnE5Y0c1NkZ3bnJsVTZzeHFiRldF?=
 =?utf-8?B?cnFHdjA4MzExdFd5TlJobFRhcHJzdEJ5S3B1eHVrS1JNOUt1UFBENTlyTGV3?=
 =?utf-8?B?UlZCTWZTajA0bmtuZlV0cjNmNjc1ZWxxY2ZiY2FmYUVxejkwMkIzWXlCMDcv?=
 =?utf-8?B?N0JBeG1PUVU2WklUVjB6Mjk1RFlJUm50bG45eWNFRmcwandBRXRVWVFCSUps?=
 =?utf-8?B?azZhTTFWNExnb1NRdmVHZ3AzWXpkZ2treHpNTXZ2c2FQV2ttbldrNFhJN0pL?=
 =?utf-8?B?ejJzcDdjWkprVDl2YUdMaEJvSXVIYzRSeUV2MGs3ZS9DQzc0cE54enhSaFZ5?=
 =?utf-8?B?Q05xaC92UFczaFpHNXlZcURITDhKcFA1c3dvc1ROSm1oME92VmltblI0alFz?=
 =?utf-8?B?c01qTStKaTZVdkVrV2Z4UDVZWTRLR2d5RU9VMFJ5VENkNWhMaUw0czVjRkZE?=
 =?utf-8?B?Q2IybGdsMXFCdVRuVm5URmg4WXBSNGUrMm5pdzBqRjcwZ0c1SXk5bUdMQWxn?=
 =?utf-8?B?b3p0WFRCMVNQeWJhaU5tbWdCUEFycW1wR1hyYU9oNWNKUWpyTWxBRERaQVUr?=
 =?utf-8?B?S053UWxRNkp5RFM2STVQRjByV3ZFQnFEem12OVBJYVBkZnZxb1FUUC9GZ1Nx?=
 =?utf-8?B?eEg0U1NNTE5EWm5yRVpCeGZ5SmNxTmwrOGN6b3pSajM0emN4UnBlRkV6L3JU?=
 =?utf-8?Q?4iVOG2kTb5NbdrbOzM95aV5S9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e187cd-7349-4463-f8a5-08db9e83c19c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 18:08:13.1541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9var8ZhbFQt8usxYiJT1qjMfAVDdqEEmNiPr1+2GgyVv23vk6YJPtrPIytWbzuIbtdmvV17fzFHBCPRSSGz5pg==
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
> Use pcie_aer_is_native() to determine the native AER ownership as the
> usage of host_bride->native_aer does not cover command line override of
> AER ownership.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> 	Replaced pcie_aer_is_native() at a later stage for automated
> 	backports.
> v3:
> 	Added more context to commit message.
> 	Added "Reviewed-by" tag.
> ---
>   drivers/cxl/pci.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2323169b6e5f..44a21ab7add5 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -529,7 +529,6 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>   
>   static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>   {
> -	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>   	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>   	void __iomem *addr;
>   	u32 orig_val, val, mask;
> @@ -542,7 +541,7 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>   	}
>   
>   	/* BIOS has PCIe AER error control */
> -	if (!host_bridge->native_aer)
> +	if (!pcie_aer_is_native(pdev))
>   		return 0;
>   
>   	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E797697439
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 03:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBOCOA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 21:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBOCNr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 21:13:47 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F8620685;
        Tue, 14 Feb 2023 18:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676427226; x=1707963226;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zInPEK3aiNcK7Nbknzq0gLgK1IkhdXkfST9CKt2mgU0=;
  b=Gn61Q7uKYEzoa3oIssd5C+Q2MprYnxWm+gDOZPfaPbqG7zii+Q1paAI8
   pAOorECXvLrIljVCTNgX6AxXF48JPyOnPyNomu063M0LXoWeSe59dd+QM
   Dcp9La1dqXjt8HEZiF9vteL6xR2Ivcsj+dth/ZgdjX5MU6HgnJYbc9iKd
   TJiOULwIX7950WK6CvNTc69PaaShCWR0fGsZC4hyYvxJD6Fd/nOKh+CYz
   UU65NRUvLAovL35wIrg5E1si3xfB9HfND/w11GpS07t75WTZha+M5GvY9
   fJcAEiu9ZZSleHmimgz4KhXkuKVRc2fAlyFJ01WaioQCreozXrX5k3Sml
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="393727821"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="393727821"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 18:13:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="619263365"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="619263365"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2023 18:13:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 18:13:45 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 18:13:45 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 18:13:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWfHQCTLxnC1Qm2MS5Swaib2hPDTA1bEYgmbge+mt8C1fVImvCXzuAR0c5TAGd87l8zAzCnH1jyDpHi7lDVyF3QvqK2aNWN3RIdqSZjL+2rN3u+XuTZR3OapbuDXP2Yj7k6A2m7CQ4mw2ThGWpUr8+tov9Hegkp+SUOuACTKLxBcYxw2GieEAhd2xlAKsvkwcxqIpJGZUKKn/UbVxolbSrLMAnSDWClxMPSX8mh0EC+ttktuPnGSR45NAMhMUHlm7usNppZt0e6bOOCMPiLGoSSGgy2hWkfEz2m6ZctuPqPuVnaO2P1iYPblFJBrEjiHcZLd+VDChXcPcR1X8qysYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsZyiNxfMhpEb+cZQ+hRrKkl773Rpe5DB29uwpqzUP4=;
 b=YssJkhJdT7CcuuLbAXKim7Oqc+09zB9FFuoy1FiZaH1k6qAQxkT1CckejEIhpNCX9bsiHwuR1VgI1FSdl8SA3weng3StMX2UyX0L0DMzXvzQecv9LfXxe89kEaMZr68+wfaPcirCvZIquu+meGXxYVdKWs5EeDcLktg+K9bkKGzTCmMgCUp0H0pIrpt2tleiNfPfX+YEmdggpR73BuEtw3nsH8PjlM8uDjIlTZAFAfdZ/djcGknDQo8FrBmdnYi8z60AqxUcK/TKebvmJmml6mCinvTVfvR90uB293KNOgTvjk2w/i0uvBakkcZebWSFL7TmjnXCTX9fq0+t86cIHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by PH7PR11MB7985.namprd11.prod.outlook.com (2603:10b6:510:240::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 15 Feb
 2023 02:13:42 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::8eb2:90e5:b496:f4ee]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::8eb2:90e5:b496:f4ee%5]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 02:13:41 +0000
Message-ID: <29bb8118-ed71-3c00-31fe-0aae5b1e5572@intel.com>
Date:   Wed, 15 Feb 2023 10:13:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 14/16] PCI/DOE: Make mailbox creation API private
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
CC:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <cover.1676043318.git.lukas@wunner.de>
 <add3ba8358848c2614f3dd8761e5c730ec35942a.1676043318.git.lukas@wunner.de>
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <add3ba8358848c2614f3dd8761e5c730ec35942a.1676043318.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::18)
 To BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB3956:EE_|PH7PR11MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: c860f1ca-ef15-4a43-fb4e-08db0efa41e5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q0ZGzwLW2+PYAixxTsuLmgSRWEIz7wGsyJAeHurY+cGYlVm/W9hbRF3P6WhcLqDz2yZm3rulOq/wxmYnv3666K5P6B3KePrU9en43KMU8Ma/XlHgY7rc6Nz50VGHqIgeRXroU0PEMFOWXAhiJ0wBnADWvK0cnReWWntyWyDeuAUkCDWiEpDq7GKXkmlvS7q/zGAEcQMo+3gL6hvggfF54TVgb/lwmwjQPFJyC2gzosbUhlvdCEuhVZdqTc+qDY4r3Cs0z/sXPaMzrOcRSUptFp1n+grnOeeGnSqIgDrY6a3HgT+0nmIhIWEms0sl00eK2jR/rwXjs2sZCtpudfpoQrsbI6BoGlT9P5G3XGzrnUT81lux0KPxl8w+he9HgO7ViSu313BGdtfIs2VtOFk+doABkBEDkeAdVDq7z0NTzxZnaJ0z76fu6aiTmPB19FWiblbFr8Svy2qG4k4FA5V27QXTBiahUCjEQ4rKzunGi00dDbFJXeyhWmd2mmuzj7UW0R+ihwSD1vLPQHTHMIB7r5Rg4bIZeYrLMuHfqxhiNLJEv8mHe1xOtfIs5zWyTCn22pqKTyutpL/eLs2BSTLR+MG5WU+daiB8RRIh0xlO8aJlCb2PACvoj/opI/hNSh6/ugbTRz3zdvw/ghSvbyvnVTW+COyMM6LTGHlnnzpCHPxfa/nyJeUiScvgdz9ItLHaDUrmfGlll4dVd6dnY01BpfzYZnEHfBXo/hsjT/PJq+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199018)(66476007)(6506007)(53546011)(38100700002)(26005)(82960400001)(2616005)(6512007)(83380400001)(66946007)(4326008)(186003)(6666004)(86362001)(6486002)(6916009)(478600001)(54906003)(8676002)(36756003)(31696002)(316002)(36916002)(66556008)(8936002)(15650500001)(31686004)(41300700001)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2kzcTR6VEZ5U0VsdHBndDI5eXBzdHMzTElHb0greEl1SllMaTJYM0ZmcnBn?=
 =?utf-8?B?RkpPSjZIY1k0V1JaQmc2K1ZCVDYrN0xMWTAzYTVlY3Q0UnYzRkx3dk05WlRm?=
 =?utf-8?B?MFlWVG5kVWtRMGdMRjFLN3Zyc2VlOUdEbzl2a056ZVEyR3FJTmE3ckYyU2Zi?=
 =?utf-8?B?SDRNd01JQzRZN0xUbkphR3pwYVVyc0JuN0xwR1lUMm9PSkNRNDcvNStYeFlI?=
 =?utf-8?B?ell0YTR6dVVEdllsK21XTGJ3WmIxclo4dmxHTTJ6ZFpEQlRmVmQ0R3hGa1Q2?=
 =?utf-8?B?V204bkJFTy96NTJJbUJiTmdVZ25RejljUlkxclBCSitDa2NnRlZNbWdCbjV4?=
 =?utf-8?B?MGNxV3ZiWDNYd3MxSjN6MWZqWTBVS2s0TEJzdUxrQURGd0NpK2pxU3loejFG?=
 =?utf-8?B?SDRSRkE0UnJOOUl5Z0Z5d3AyWTRndjBEVzFBNnFnYlhiWGFVcXlMTXp0UEM3?=
 =?utf-8?B?ZnM0WG4xRVBWSVVRVXBjTzc0ZjBIVXBoZEpBV3EvSFQvaXhEY3J6RTYwRmFP?=
 =?utf-8?B?VkdRdi9iS21KQ1RuM29GUlZEd25LVm44S3VDR0RvZHhKK1J2MnVFUUc5QmRZ?=
 =?utf-8?B?b01oWkEyWGh5SVJaSC9zbFN4a1RBYzYxTEc4WnVYenNGRkNYOHdtZ2pkZzVC?=
 =?utf-8?B?MHl6MEhsN2tCaERsQzlxTWpZa0hHQy9ZV1N5ekEyc0E1NUtCVUNldVVJQSto?=
 =?utf-8?B?UXpET3QwK0ZUUndWa2RBckNEb0t3aHVaS2pLVUNxWkM4alFibHVnVkhxWkty?=
 =?utf-8?B?L1kxQk0xOTRlMHhlbmJ1eG9zcHN2UE10NVFLSnZQaXNld0d2TmRsVGV2QW5O?=
 =?utf-8?B?NXVIblE1eElxNDlMckxmS3V6UDhCTVdEMkNtbnJMeHYxbHBoUldqSmdqeU5u?=
 =?utf-8?B?T0dndTE4akYwbmZ5aXVIbTlYYm4wbTNaWGRLZ0lUeGVCOUMrdndKRGNXWXo2?=
 =?utf-8?B?R1VuR3JNbERLVUl4NEwxR2xjUGYxeXFaOWpDYWM0b254V0hFcml3bkdYVmZO?=
 =?utf-8?B?UXV1QkdrYk9lT2dEWFNvL3VKZnRNWW1peHFkakp6NGVLUGJFMVFIZGphVkV2?=
 =?utf-8?B?TXQ2SlNSUWFpYlhGK0JKSEtLRDROR0hvT0NGaWhUbXovdFZINUpKWURqWHJu?=
 =?utf-8?B?U2dsWDZjR3RpUDZSWmIyU1lQbWdUNHNkQU1HOFNmZjNsS20yNHZIWnB6YU1k?=
 =?utf-8?B?MGprSEMxYlowblYwVG5zWW9tTXh3L0JVU20vaGpnTGtFMGUwaUJ2b210RU5t?=
 =?utf-8?B?bTRSWCtzdWRRNFJZVE5sSGx2Z09rWnNFOUtWcUhSZzFIa3hEOWVLSGFNSXJ3?=
 =?utf-8?B?N09NMmEwSkxqS0FYOERlZjFIUUFhR0pRL1hIc2c5MkNMa2VCVHJHRlJFS2hL?=
 =?utf-8?B?VUEySzVadU53S1d0QzkrV05UM0o2aXY2NmFLalN6ZTZFQ28yOXlRYW5iRy81?=
 =?utf-8?B?R0EvRnJvWGVWZE9GUVE0SGhpbUtmVVNyaEpPZ1hpd1JyRmNrU0RvUytpK08x?=
 =?utf-8?B?OFF5cUtvUy8wMkxjT2gxZlV0NkpjQ2piNlhoVXFCc1pJdnlJVkFJZHJ1b3Ru?=
 =?utf-8?B?S2pFaEdDVEdicjEyMGZnL3NNVTFDTENQTjNRRTAraEcvdUJSZU1LMzh0RlFG?=
 =?utf-8?B?TkZkV0JmRGpiT1ZBenNGaEhibDFqbTdnSXNrMG1NNW5zV1FscExkK2R4OWFn?=
 =?utf-8?B?c2g5dmxROTZtRTB4Y1FTRjlGcWFjWVl3V2x2eG5lTFExN0tTdDFqYWZNY21q?=
 =?utf-8?B?VVhZSmt6QVRTNmdWTjBpT2VudW9nNTJEaC81VEh2bXdKNnAvdGE5MWRNME9M?=
 =?utf-8?B?cHhEMW1KWDZTcmRmdm9KeDZ2bTkwOUs4aTcxQlNPNjBXWTF4NzY1blpBZHBK?=
 =?utf-8?B?V1RqTG15b1RVaFJDaWRLakp3ZDBUbWVpbmU2UVNxY2xMUmJvREZMNlBwUFdw?=
 =?utf-8?B?QjRhcndHRjhrakZ2VjlZRE8wY3hmMXpVRkxrOVIzdFMyTDBjZDZ3OVo2U2Rw?=
 =?utf-8?B?ODd2MTRaQjBpdklLcVhFcldaU1dyTlZmU2VDRi9EeEhNNU1Edk9vT25ER0VY?=
 =?utf-8?B?eDRBd01wUGYxSXpNem9CajczTThrU01ES1ZhLzZtV2JvbjUzRUtYTFpPTFFI?=
 =?utf-8?Q?u1hKLwD358pC0manHbgmd8haH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c860f1ca-ef15-4a43-fb4e-08db0efa41e5
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 02:13:41.7792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6cJyljlpYXYZaw+TWMFNCVPMkIkfusiDX6NDtSx4nt1TDGF88U83T8/r/DTCacKRn6CTmhY5cf0Qk3i1o77vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7985
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

On 2/11/2023 4:25 AM, Lukas Wunner wrote:
> The PCI core has just been amended to create a pci_doe_mb struct for
> every DOE instance on device enumeration.  CXL (the only in-tree DOE
> user so far) has been migrated to use those mailboxes instead of
> creating its own.
> 
> That leaves pcim_doe_create_mb() and pci_doe_for_each_off() without any
> callers, so drop them.
> 
> pci_doe_supports_prot() is now only used internally, so declare it
> static.
> 
> pci_doe_destroy_mb() is no longer used as callback for
> devm_add_action(), so refactor it to accept a struct pci_doe_mb pointer
> instead of a generic void pointer.
> 
> Because pci_doe_create_mb() is only called on device enumeration, i.e.
> before driver binding, the workqueue name never contains a driver name.
> So replace dev_driver_string() with dev_bus_name() when generating the
> workqueue name.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ming Li <ming4.li@intel.com>


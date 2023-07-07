Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574F674B2F4
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 16:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjGGOSJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 10:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjGGOR7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 10:17:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7329E6E;
        Fri,  7 Jul 2023 07:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688739474; x=1720275474;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HwRI+du5DhMIV5hdNqGE48uKkwqjv5sELlayYQHTuGo=;
  b=Hub2wvWJmO5LWEk7QUW+ludFKvw9MgsIXO/B++rMlMYMRhe2YG59DJ0r
   P/RHCAmCctb1fPtKT4otAEjpQQtBzsL7Pne/yOSbLkL/E22OrKhXDfKo4
   pGPI18hC6hjBGyuh7rUE+Bgr3b5Y73Cf/nAOpPT0+2paB12ah1RswL+s9
   RvPvdfBBEdFsEWUHjMGDEPdBN9typmnTttx0MOQU244xXd7GMnomuSoTe
   xz4hxW70CMu85S6DS6OMlNMbVT6qZQ7Ry4h0wCy4zxOOxn3HOD4TANQTb
   PnmhEbaWl5tfSo3icF0DVKhGtW2qLtCWbrb0GwptjiNo2v/ZzhXXcp5jj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="363933993"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="363933993"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 07:17:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="1050557442"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="1050557442"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2023 07:17:51 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 07:17:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 07:17:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 07:17:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbMANlmUdqjnqw48tHZWe0wAug2gYgSoRvxk8yYxsRaUozUCVaVmZYjXWsQbuHOSZzxKgiGxwhzCAMOTmtItL+L3zsfHBWMYxXcLK1nu3SyZdQ8A7x1TYKD2+ZmFHCnvr8h5WTrfmMs3Km0AxTFZ66cdtDy9fr8vbxPuDxN5NJX+egPvf21aB4i21FR9PkWQWMZ72Uwclm89YYidNQUAZBwN+DWa2sqUL7yvimEGCuGGYkKFFaX79g/mtO+Ic9rqpXK7BL1eeIErArn5HO8CZwTwfecS4Zgl7BtbWAd+i9wdKI/GAS2cX6/C/YDEcNsWyqKHBz6Km+M9zWTxW5yyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYarfpJ9Apvc5SgX0vbkMiwqsyNBPKEXM+Vpop6/nbc=;
 b=FzhKcNAD+KwKrJketEqTKS4+0l6MnZr587qhFxBjgSLtltOpHHg2dlJ4Rpl8nWj/lZj/ybPDmIAAfe58z7UxhmK5IC2WMQjxpDaWXYLtvxdyn2caoeQyY56Ac5hZ92P6b0NRBK+28yrwGACzJc7B+TdLOGVfXtpAlU0cUx9sv9LklcFtYuMj7p5EhG+kx7dyorRr5AgCE1WRhBkzDjpCI2jFW2qt2mh4UuAML6/s2vcPdfwqcW7leJXS1wFjo+BnhIE2KApJkwCA12XOez9gCT47dQwLrIGpUFTsUWiUTjjA4m9zKrOaCLDyTvw3ChIOLxlX84qZllT3f8CIPfPMJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7539.namprd11.prod.outlook.com (2603:10b6:806:343::6)
 by DM4PR11MB5325.namprd11.prod.outlook.com (2603:10b6:5:390::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 14:17:48 +0000
Received: from SN7PR11MB7539.namprd11.prod.outlook.com
 ([fe80::1552:870f:2326:abf3]) by SN7PR11MB7539.namprd11.prod.outlook.com
 ([fe80::1552:870f:2326:abf3%5]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 14:17:48 +0000
Message-ID: <52cbccda-e18e-5bdf-c32f-88bdbfee230a@intel.com>
Date:   Fri, 7 Jul 2023 17:16:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Ask for a regression issue of vfio-pci driver with Intel DG2
 (A770) discrete graphics card from Linux 6.1
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <mika.westerberg@linux.intel.com>, <bhelgaas@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230705220135.GA75408@bhelgaas>
Content-Language: en-US
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
In-Reply-To: <20230705220135.GA75408@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To SN7PR11MB7539.namprd11.prod.outlook.com
 (2603:10b6:806:343::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7539:EE_|DM4PR11MB5325:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d0ba32-4500-4fe1-6482-08db7ef4efdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /PMxQiQrJ+cMkZXoFGjMLzqdztOwbxk2FBahPjdsT+Q931/nocAHAyBVW/sz6R+TCH0iCsB6MZ+A+mHBWzjXOdT1bxC6jvHkLosGcpkECz9pN+KESkilITIk+smjY9jpY8lz5e1B2oAa7GUqtM6k1N0wbFa+qutsQ0f5g0NolpPyVPIFjoL9pV9ajf1dIxZynNB/zH4UVmBt5GbLRow/QjFlNFidCD0h70vwPv5jDYbF2awGgn3H8Q3xkjGYTAbBf0rV8JU0qevOIJV97yp+csEIVz0gpyB/1CYaDVr20hV0n0uf64G62D73OQ0wfaPRss3KDbFDSUCFtNulCMNq0EHl6NrnzsEerUxcnldMb8wCFTayrcny/AyMFE5mFjPSGfS9K7Zya1jekH/LByG8L0GoNx+YICSOsZDiGdSS9Bvm8ezI9Djo3XZhfo/ZTC/fgmQgixmyViQsxAYc6XWQuWVo2BpCRKjfSUSg8j1u35k8+IGGDrHD4UCWxcGvGNeaYlb88m2028oW1nvd3U6x084Drg5JFG9xaHjLthFUO6XUnc3WMa0rP+EuGdkMnSnu3n0CO5b456IlI7asUX5iEYMztIaaTmG2ykNyqB5cIZGdFwVmbYhmemC0n6nO1mPWfG8VKHWeFnxvPZN5fIcLiG6WOQkMS8IkCJCRtm6IN+dGeps+Qe8hbrZgkUY3qKQ5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199021)(316002)(82960400001)(38100700002)(31696002)(36756003)(86362001)(31686004)(8936002)(41300700001)(966005)(26005)(6512007)(5660300002)(6506007)(53546011)(186003)(30864003)(8676002)(2906002)(83380400001)(2616005)(6666004)(66946007)(478600001)(6486002)(4326008)(66476007)(66556008)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWRpN3IzOVFqUGZrWjVBV3hPM0tZblIrLzJ4RzY5SjNXTUdEbVJDOEptV3I1?=
 =?utf-8?B?YUw0QWRSMHRVRHlDZlFWYTRaMGEveEhqRTlYdHR2ZVZEd0dkMkFrT1dwc3NQ?=
 =?utf-8?B?OFFCdEo1NUhMVi8rNEpKTDR2aUc2a0M2c1J2aW1mZE1MVnNRYTFwY3doNm9X?=
 =?utf-8?B?czhLWm15cjdKSTZBcC9LZ2lLZWRhbk9MVkxZbTJaMTZMVTZDcnZ5UXdUMVlz?=
 =?utf-8?B?MFRzMjI0a2JTOUEyV1RNNksrSm43cnFob1pxZWdWR2JGcDJoU1ZYTjFYdDFt?=
 =?utf-8?B?ZkRHWVFvaFJWdDF6em1DaGxSeC9rQVVkMmpnMVJoSlE5UHo4QzZabnAzTDd3?=
 =?utf-8?B?cDBkeDA5eStwaGJDWDJUSlQwQ0N4bjJSb2x6S0xpQThPTTNQUEJHamptbWkx?=
 =?utf-8?B?emtuYy90d1pEMDNtZk1oSUhwOTJVaU8xdXBhekJLQXlDdUF3Ump2cmZTOEhJ?=
 =?utf-8?B?NGlFOXFxZ1NXaVFtS3AxT0dKejFBdmpwYXlRR3NMQVJUTHFNNndPdlI2aFg1?=
 =?utf-8?B?RGhOcG1rc20vT3A0TEdMcTg2RWdkN0o0dGovUE4xeFFiOC9scktTUHpTeXd1?=
 =?utf-8?B?VVdjVFkvRHJ3U2gvL0REbWxRRzV1YXVyWjJxMmE3NGl5bisxdGtoR05hMWJm?=
 =?utf-8?B?aWUva2ZDckZOeUc1ZzNzV0VIc0hVaXBCZnlMbE50UVladmdWeXFtUzRrNUox?=
 =?utf-8?B?U3psYncxT3V6eDFLZE5FVjJsaVpJMm9rc2NQYVd5M3UvZDdpa0o4Y0VSVE1P?=
 =?utf-8?B?eFNEbXBDNkVmTUFsSkt0b1VSSGlsdlZTanFEeGUrVzlQaXk5V0RjdEpOKzBm?=
 =?utf-8?B?R1djZ3BLcjZwNGFoYnFYcnFveUxEN0s3a0c1V3FncUg2WjJKcUxyenY3NnZR?=
 =?utf-8?B?cldRckFLUjdwaG8wNzVTd093VkMzWGZqWEZrN2FPTHljQ3BPOTJCZCtiUWVU?=
 =?utf-8?B?cU4wWlBPc3c4SjBJaUNqRi9CWjJRVmFDK1ExNXhuOXBlSHJxb25RZDNjdDBE?=
 =?utf-8?B?Lzg5bnQ1Ty9lb3VXalk4QlFsTm5WZ0VMMFlwQUxBci9Ndk1scnNPVHkzRkJl?=
 =?utf-8?B?VTBMOStKTEZSeWhjSDR2bDV0VjNWdXFYdGRWcS9iOWZwNStkNFU1VUxoSWNR?=
 =?utf-8?B?bUlvTFZFMW1JOXE1cFJEY2RUTi9iWWE5WFAxS0M2WTJpWW1tcWhZenNLREg0?=
 =?utf-8?B?U1NuRTZnTUlud0xJMGkyM2N3RHZPYU1pN0QwSVZQSUFlM3hKK3BhWXhIYncw?=
 =?utf-8?B?YjB3L1FjWW95K0txSFBqMnlTN2NXcWlicG1ONW9scGpFZklOUWlxUFl5dkI5?=
 =?utf-8?B?RzNPbDhUR0EyTjZJZlR0bng4NlR1RDlXajY0V2hnN29jd252ampvY0c0L1hC?=
 =?utf-8?B?VFdIdFNvaVNNeGVyUHB1K1g5WG94Vmw0ZFhBMTI3Yml6Q3BoL3VRakI2blBF?=
 =?utf-8?B?V1pTT3FlVjFmalBGQmdVVkZTUm9QR2NTMXFKVkpvcXFuQW0rQWlROTFMT0du?=
 =?utf-8?B?aTlhTkw3S3l4UGJUNXVNKzZlU3BPMWdYSmpDUnN0RGszVnUvM2xLbi94bG1i?=
 =?utf-8?B?UXVLRGlGbStVMjBib1RaTlV3SFYyWDBxaWJ6RGFacCtLQ3lYZUlseWFpUWVG?=
 =?utf-8?B?REdmd3NlbVBsMTFxZEpUY0pqbnp3YkU0NWFDdXdPZzU2MGRVcEhTY3lQMU50?=
 =?utf-8?B?U0VXWmhxUXY4TDl3ZGVkZEFLcXcyLzBvRUdCOFZXZFMwdzZjOWs0cnJzU083?=
 =?utf-8?B?dkk1aFdCWW01a0lncVN5c1BITFBJUFF1ME85NkdIb1hid0psRkxvdjNFSER1?=
 =?utf-8?B?OTg0L0lZckdreTZYWnFZQlRWc2VvU0tveStYODBuM2p4SFRxWjluYS9LRENx?=
 =?utf-8?B?RGRvVjE3K3YvVXdhWXZzQUpZSnMzdHZCZ09OS3lTRWg1Vks3NzZRbjNXM2dI?=
 =?utf-8?B?Y1AzWE9MTkFRSWMybGRZaEwzYmJLV0FjbXJVVzM3MTM1dW9HQ0twTDdVSHZi?=
 =?utf-8?B?ZUlpUHRlb0NyZk9IKzJYNFBwWG9Edy9NSURIeksxUGNWV3g3azhGK3JMM3Er?=
 =?utf-8?B?QkJpNEpwaGFkQ3ZVeEh0MVBCVG84RTEyQ0g1OWpCeVhuSUR3Tm80NWk3cTNq?=
 =?utf-8?B?OUZnamZSSGJQZjljN08welo3aEZVZmREYkNSckZsL3ZXWnVWUVcvbGNFSWFJ?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d0ba32-4500-4fe1-6482-08db7ef4efdc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 14:17:47.9107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGS3lEi6lHPMvceruY53dcpJ5cl7FtCsoOkMVSGi6eun/hM05rl5Sn+QgneQcUykJTK9CU/r4GxWvGZj/Bcxh5c6bc/sYo1HLP1Y72fJOhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5325
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/6/23 1:01 AM, Bjorn Helgaas wrote:
> On Mon, Jul 03, 2023 at 01:37:42PM +0300, Gwan-gyeong Mun wrote:
>> Since Linux 6.2 kernel (same happens in Linux 6.4.1), loading vfio-pci
>> driver to a specific HW (Intel DG2 A770) target does not work properly.
>> (It works fine on Linux 6.1 kernel with the same HW).
> 
> Thank you very much for the report!
> 
> Does this problem only happen with vfio-pci?  d8d2b65a940b appeared in
> v6.2-rc1 (Dec 25, 2022), so I would think somebody would have used DG2
> on a v6.2 or newer kernel.
> 
Hi Bjorn,

Yes, the problem only occurred when I set DG2 to vfio-pci as shown below 
in the settings [1].
(The reason for setting DG2 to vfio-pci is to use dg2 as a qemu pci 
paththru device).
If you don't set DG2 to vfio-pci, you won't see any logs of the problem.


> Can you please collect the complete "sudo lspci -vv" output (not just
> the DG2 items)?  We need info about the switch ports and all the
> capabilities, since d8d2b65a940b has to do with switch ports, AER, and
> MSI.
> 
> Also, please collect the complete dmesg log with v6.4.1 (which does
> not work) and v6.4.1 with d8d2b65a940b reverted (which should work).
> 

I've filed this issue with kernel bugzilla[2] and added the dmesg and 
lspci information you asked about as attachments.
I've also added direct links to the relevant logs below.

1. complete dmesg log with v6.4.1 with d8d2b65a940b reverted.[3]
2. lspci -vv with v6.4.1 with d8d2b65a940b reverted [4]
3. complete dmesg log with v6.4.1 [5]
4. lspci -vv with v6.4.1 [6]

[1]
$ cat /etc/modprobe.d/vfio.conf

options vfio-pci ids=8086:56a0,8086:4f90
softdep drm pre: vfio-pci

[2] https://bugzilla.kernel.org/show_bug.cgi?id=217641
[3] https://bugzilla.kernel.org/attachment.cgi?id=304560
[4] https://bugzilla.kernel.org/attachment.cgi?id=304561
[5] https://bugzilla.kernel.org/attachment.cgi?id=304562
[6] https://bugzilla.kernel.org/attachment.cgi?id=304563


> I know you said that on v6.4.1 with d8d2b65a940b reverted, the system
> boots but there's still a problem with suspend.  I'm intentionally
> ignoring this problem for now.  After we figure out the boot-time
> problem with the DG2 being left in D3cold, we can come back to the
> suspend problem.
Yes, I understand, and I agree.

Br,

G.G.
> 
> Bjorn
> 
>> The configuration and hardware information used is described in [1].
>>
>> Starting with the Linux 6.2 kernel, the following log is output to dmesg
>> when a problem occurs.
>> ...
>> [ 15.049948] pcieport 0000:00:01.0: Data Link Layer Link Active not set in
>> 1000 msec
>> [ 15.050024] pcieport 0000:01:00.0: Unable to change power state from D3cold
>> to D0, device inaccessible
>> [ 15.051067] pcieport 0000:02:01.0: Unable to change power state from D3cold
>> to D0, device inaccessible
>> [ 15.052141] pcieport 0000:02:04.0: Unable to change power state from D3cold
>> to D0, device inaccessible
>> [ 17.286554] vfio-pci 0000:03:00.0: not ready 1023ms after resume; giving up
>> [ 17.286553] vfio-pci 0000:04:00.0: not ready 1023ms after resume; giving up
>> [ 17.286576] vfio-pci 0000:03:00.0: Unable to change power state from D3cold
>> to D0, device inaccessible
>> [ 17.286578] vfio-pci 0000:04:00.0: Unable to change power state from D3cold
>> to D0, device inaccessible
>> ...
>>
>> And if you check the DG2 hardware using the "lspci -nnv" command, you will
>> see that "Flags:" is displayed as "!!! Unknown header type 7f" as shown
>> below. [2]
>> The normal output log looks like [3].
>>
>> This issue has been occurring since the patch below was applied. [4]
>>
>> d8d2b65a940bb497749d66bdab59b530901d3854 is the first bad commit
>> commit d8d2b65a940bb497749d66bdab59b530901d3854
>> Author: Bjorn Helgaas <bhelgaas@google.com>
>> Date:   Fri Dec 9 11:01:00 2022 -0600
>>
>>      PCI/portdrv: Allow AER service only for Root Ports & RCECs
>>
>>
>> Rolling back the [4] patch makes it work on boot with the latest version of
>> the kernel, but the same problem still occurs after "suspend to s2idle".
>> This problem existed even before applying [4].
>>
>> Suspend has been tested with the following command.
>> $ systemctl suspend -i
>>
>> $ cat /sys/power/mem_sleep
>> [s2idle] deep
>>
>>
>> Here is the log that is issued when testing suspend to s2idle. [5]
>>
>>
>> Br,
>>
>> G.G.
>>
>>
>> [1] Env:
>>
>> NUC: intel-nuc-13-extreme-kit-nuc13rngi7 (https://ark.intel.com/content/www/us/en/ark/products/229784/intel-nuc-13-extreme-kit-nuc13rngi7.html)
>> (MB: Z690, CPU: RPL-S i13700k)
>>
>> PCIE Card: Intel A770 GPU
>>
>> Add boot parameter: intel_iommu=on iommu=pt
>>
>> $ lspci -nn |grep DG2
>> 03:00.0 VGA compatible controller [0300]: Intel Corporation DG2 [Arc A770]
>> [8086:56a0] (rev 08)
>> 04:00.0 Audio device [0403]: Intel Corporation DG2 Audio Controller
>> [8086:4f90]
>>
>>
>> $ cat /etc/modprobe.d/vfio.conf
>>
>> options vfio-pci ids=8086:56a0,8086:4f90
>> softdep drm pre: vfio-pci
>>
>> [2]
>> 03:00.0 VGA compatible controller [0300]: Intel Corporation DG2 [Arc A770]
>> [8086:56a0] (rev 08) (prog-if 00 [VGA controller])
>> 	Subsystem: Intel Corporation Device [8086:1020]
>> 	!!! Unknown header type 7f
>> 	Memory at 93000000 (64-bit, non-prefetchable) [size=16M]
>> 	Memory at 6000000000 (64-bit, prefetchable) [size=16G]
>> 	Expansion ROM at 94000000 [disabled] [size=2M]
>> 	Kernel driver in use: vfio-pci
>> 	Kernel modules: i915
>>
>> 04:00.0 Audio device [0403]: Intel Corporation DG2 Audio Controller
>> [8086:4f90]
>> 	Subsystem: Intel Corporation Device [8086:1020]
>> 	!!! Unknown header type 7f
>> 	Memory at 94300000 (64-bit, non-prefetchable) [size=16K]
>> 	Kernel driver in use: vfio-pci
>> 	Kernel modules: snd_hda_intel
>>
>>
>> [3]
>> 03:00.0 VGA compatible controller [0300]: Intel Corporation DG2 [Arc A770]
>> [8086:56a0] (rev 08) (prog-if 00 [VGA controller])
>> 	Subsystem: Intel Corporation Device [8086:1020]
>> 	Flags: bus master, fast devsel, latency 0, IOMMU group 19
>> 	Memory at 93000000 (64-bit, non-prefetchable) [size=16M]
>> 	Memory at 6000000000 (64-bit, prefetchable) [size=16G]
>> 	Expansion ROM at 94000000 [disabled] [size=2M]
>> 	Capabilities: <access denied>
>> 	Kernel driver in use: vfio-pci
>> 	Kernel modules: i915
>>
>> 04:00.0 Audio device [0403]: Intel Corporation DG2 Audio Controller
>> [8086:4f90]
>> 	Subsystem: Intel Corporation Device [8086:1020]
>> 	Flags: fast devsel, IOMMU group 20
>> 	Memory at 94300000 (64-bit, non-prefetchable) [disabled] [size=16K]
>> 	Capabilities: <access denied>
>> 	Kernel driver in use: vfio-pci
>> 	Kernel modules: snd_hda_intel
>>
>>
>> [4]
>> commit d8d2b65a940bb497749d66bdab59b530901d3854
>> Author: Bjorn Helgaas <bhelgaas@google.com>
>> Date:   Fri Dec 9 11:01:00 2022 -0600
>>
>>      PCI/portdrv: Allow AER service only for Root Ports & RCECs
>>
>>      Previously portdrv allowed the AER service for any device with an AER
>>      capability (assuming Linux had control of AER) even though the AER
>> service
>>      driver only attaches to Root Port and RCECs.
>>
>>      Because get_port_device_capability() included AER for non-RP, non-RCEC
>>      devices, we tried to initialize the AER IRQ even though these devices
>>      don't generate AER interrupts.
>>
>>      Intel DG1 and DG2 discrete graphics cards contain a switch leading to a
>>      GPU.  The switch supports AER but not MSI, so initializing an AER IRQ
>>      failed, and portdrv failed to claim the switch port at all.  The GPU
>> itself
>>      could be suspended, but the switch could not be put in a low-power state
>>      because it had no driver.
>>
>>      Don't allow the AER service on non-Root Port, non-Root Complex Event
>>      Collector devices.  This means we won't enable Bus Mastering if the
>> device
>>      doesn't require MSI, the AER service will not appear in sysfs, and the
>> AER
>>      service driver will not bind to the device.
>>
>>      Link: https://lore.kernel.org/r/20221207084105.84947-1-mika.westerberg@linux.intel.com
>>      Link:
>> https://lore.kernel.org/r/20221210002922.1749403-1-helgaas@kernel.org
>>      Based-on-patch-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>      Reviewed-by: Kuppuswamy Sathyanarayanan
>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>> index a6c4225505d5..8b16e96ec15c 100644
>> --- a/drivers/pci/pcie/portdrv.c
>> +++ b/drivers/pci/pcie/portdrv.c
>> @@ -232,7 +232,9 @@ static int get_port_device_capability(struct pci_dev
>> *dev)
>>          }
>>
>>   #ifdef CONFIG_PCIEAER
>> -       if (dev->aer_cap && pci_aer_available() &&
>> +       if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>> +             pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>> +           dev->aer_cap && pci_aer_available() &&
>>              (pcie_ports_native || host->native_aer))
>>                  services |= PCIE_PORT_SERVICE_AER;
>>   #endif
>>
>>
>> [5]
>> [   71.995824] PM: suspend entry (s2idle)
>> [   72.000793] Filesystems sync: 0.004 seconds
>> [   72.153926] Freezing user space processes
>> [   72.156234] Freezing user space processes completed (elapsed 0.002
>> seconds)
>> [   72.156244] OOM killer disabled.
>> [   72.156246] Freezing remaining freezable tasks
>> [   72.157616] Freezing remaining freezable tasks completed (elapsed 0.001
>> seconds)
>> [   72.157619] printk: Suspending console(s) (use no_console_suspend to
>> debug)
>> [   73.756457] ACPI: EC: interrupt blocked
>> [   75.103988] ucsi_acpi USBC000:00: ucsi_handle_connector_change:
>> GET_CONNECTOR_STATUS failed (-5)
>> [   84.052478] ACPI: EC: interrupt unblocked
>> [   86.085388] pcieport 0000:00:01.0: Data Link Layer Link Active not set in
>> 1000 msec
>> [   86.085523] pcieport 0000:01:00.0: Unable to change power state from
>> D3cold to D0, device inaccessible
>> [   86.086984] pci 0000:02:01.0: Unable to change power state from D3cold to
>> D0, device inaccessible
>> [   86.087005] pci 0000:02:04.0: Unable to change power state from D3cold to
>> D0, device inaccessible
>> [   88.335403] vfio-pci 0000:04:00.0: not ready 1023ms after resume; waiting
>> [   88.335427] vfio-pci 0000:03:00.0: not ready 1023ms after resume; waiting
>> [   89.375444] vfio-pci 0000:04:00.0: not ready 2047ms after resume; waiting
>> [   89.375471] vfio-pci 0000:03:00.0: not ready 2047ms after resume; waiting
>> [   91.615418] vfio-pci 0000:04:00.0: not ready 4095ms after resume; waiting
>> [   91.615439] vfio-pci 0000:03:00.0: not ready 4095ms after resume; waiting
>> [   95.882059] vfio-pci 0000:04:00.0: not ready 8191ms after resume; waiting
>> [   95.882081] vfio-pci 0000:03:00.0: not ready 8191ms after resume; waiting
>> [  104.202062] vfio-pci 0000:04:00.0: not ready 16383ms after resume;
>> waiting
>> [  104.202066] vfio-pci 0000:03:00.0: not ready 16383ms after resume;
>> waiting
>> [  121.482058] vfio-pci 0000:04:00.0: not ready 32767ms after resume;
>> waiting
>> [  121.482067] vfio-pci 0000:03:00.0: not ready 32767ms after resume;
>> waiting
>> [  155.615409] vfio-pci 0000:04:00.0: not ready 65535ms after resume; giving
>> up
>> [  155.615412] vfio-pci 0000:03:00.0: not ready 65535ms after resume; giving
>> up
>> [  155.633757] i915 0000:00:02.0: [drm] GT0: GuC firmware
>> i915/tgl_guc_70.bin version 70.5.1
>> [  155.633761] i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bin
>> version 7.9.3
>> [  155.636177] i915 0000:00:02.0: [drm] GT0: HuC: authenticated!
>> [  155.636860] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
>> [  155.636860] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
>> [  155.637228] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
>> [  155.661583] nvme nvme0: Shutdown timeout set to 10 seconds
>> [  155.663188] nvme nvme0: 24/0/0 default/read/poll queues
>> [  155.674267] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
>> [  155.823379] ucsi_acpi USBC000:00: possible UCSI driver bug 1
>> [  155.823390] ucsi_acpi USBC000:00: failed to re-enable notifications (-22)
>> [  155.833326] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x1f
>> [  155.833358] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x0
>> [  155.833367] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
>> [  155.833377] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x960
>> [  155.942363] ata6: SATA link down (SStatus 4 SControl 300)
>> [  155.942537] ata5: SATA link down (SStatus 4 SControl 300)
>> [  156.030241] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04:
>> bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
>> [  156.030830] OOM killer enabled.
>> [  156.030831] Restarting tasks ...
>> [  156.030894] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1:
>> bound 0000:00:02.0 (ops i915_pxp_tee_component_ops [i915])
>> [  156.031827] done.
>> [  156.031837] random: crng reseeded on system resumption
>> [  156.036058] PM: suspend exit
>> [  158.962881] wlp0s20f3: authenticate with 4c:ed:fb:a0:7f:6c
>> [  158.966647] wlp0s20f3: send auth to 4c:ed:fb:a0:7f:6c (try 1/3)
>> [  159.001337] wlp0s20f3: authenticated
>> [  159.001858] wlp0s20f3: associate with 4c:ed:fb:a0:7f:6c (try 1/3)
>> [  159.002882] wlp0s20f3: RX AssocResp from 4c:ed:fb:a0:7f:6c (capab=0x11
>> status=0 aid=1)
>> [  159.010807] wlp0s20f3: associated
>> [  159.159528] IPv6: ADDRCONF(NETDEV_CHANGE): wlp0s20f3: link becomes ready
>> [  287.875205] vfio-pci 0000:04:00.0: Unable to change power state from
>> D3cold to D0, device inaccessible
>> [  287.936500] vfio-pci 0000:04:00.0: Unable to change power state from
>> D3cold to D0, device inaccessible
>> [  289.414087] vfio-pci 0000:03:00.0: Unable to change power state from
>> D3cold to D0, device inaccessible
>> [  289.475297] vfio-pci 0000:03:00.0: Unable to change power state from
>> D3cold to D0, device inaccessible

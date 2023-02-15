Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7D76973E0
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 02:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBOBtO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 20:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBOBtN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 20:49:13 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB457EF7;
        Tue, 14 Feb 2023 17:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676425752; x=1707961752;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CmTMPqFX8+h9WtR6IRdHY9qTXQCNWs4aMEjgHEFgwCk=;
  b=eG+bhug4kWuo18kenHR/Cf7KzqBwmSDXOYJiCeGxn/lN5nBWgmgTJghX
   oOpvr88n0FxV0OYVUQONiuvfEwNxNgDXUaLy6fQZup4ih0SxrnqAQ15Lv
   DRRabYYVLDULLg7geLcwpM6ToPbkDNq6Q5x1rBrGUwAA7wV9ieTVJqP06
   NUkgqbxtgVsO7qpMTjViudOneH5G1jN7agiwQn45kmH+IqtD1IlvoJBzy
   H2rrVDVO/wZ3iTh7hBZ6Kj9gd1RyBnfGi59rrUeRc9PXTL0poiEnviVao
   YSZJlZccDYKLW88ndAvKsNOUrwCXBtvSQENL6slfyUD1O9CDUp0P78hT3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="395944626"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="395944626"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 17:49:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="733098392"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="733098392"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2023 17:49:11 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 17:49:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 17:49:11 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 17:48:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZR+kAQR6VmJ3cJDTp4Xj0d/Ghh96ngh6pkLBXoC7OxNI2VkHmJJJ7tA85zW3oAGchuwNO38oaUwRNDp2vxJZvqj/sjrQ4ybICPqAQgnUG51n2DRRFplRHJpxy8kY/PkU//z/4lAODyuoPqM9gIYmyRfjbRfDCnPHSWP61aZX4WZB729f2CY2o6Ur9PuMXYgkjsD0QR5Jcg2LKz6qrNtUlxkjz9hpmd5Ooulvh+CxmsWDQo6zeRo8X7qX88lCf9D3aZWEA5atr2qZeMOt4Fe0OcxZvMsHGRRlK8h5KYd3RUGNRQEy5+SmvLcsxp9FRQrsLXAygwHAKD9VapfPa7V/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZ1PPudblU7483IiHg9LD3H+pUD1ziab0Wh8+QvxyBw=;
 b=b3ykz9RERg2qtMiD7gIRKV0R8vPo3BKOhk536zG1O4OlgFY/CoeUkpmpuDNU9GQS/EqxFdxWLuosFzpRDGYC1C21vgHu5Beb+e+/bm7/2LItnaJs7Sx8GRZ61lx1Y4ytgfo1FfP5GFcU0RATWwlawE98s+rRDA22oxf/3aKO5bfWILk9GiCkIB/wHSD2/nGhLnB46vliB3MAlukJObw88RWJXUZWRHxAm73Qzyd0bquzAxfA08hXpfeTHftriY1F18YQgl1Rf5alL3j1trouwiks8igDuzyuD2FO/e+Z823bErht76nENCBMUtRQqmn4sitOXu7tHUizVFxokM6xyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by MW4PR11MB5774.namprd11.prod.outlook.com (2603:10b6:303:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 01:48:16 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::8eb2:90e5:b496:f4ee]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::8eb2:90e5:b496:f4ee%5]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 01:48:15 +0000
Message-ID: <524dd05a-a8c9-03e4-9c78-5119badde514@intel.com>
Date:   Wed, 15 Feb 2023 09:48:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 09/16] PCI/DOE: Make asynchronous API private
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
 <97aed81c22650f3c8bdb20a84d575bd985dc0c74.1676043318.git.lukas@wunner.de>
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <97aed81c22650f3c8bdb20a84d575bd985dc0c74.1676043318.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0086.apcprd02.prod.outlook.com
 (2603:1096:4:90::26) To BN6PR11MB3956.namprd11.prod.outlook.com
 (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB3956:EE_|MW4PR11MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: efa990e5-9096-4e26-1395-08db0ef6b3f3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SIZS9+sCs52ec0rLTiXGGFUf39fgqPyibBXKDSutl0Z0BXmaVgiC0mFrC4JG7oTwGg021E0rdSYJBL6BJReuu2GLmaKF7U0pzrL2jl7DPtVFdDBkgFAYZwsENgTRUj1ECJkvLsU5HWUGonPDHbWKXn6CpB2soz7YUyht3c1uUvJomwdorMhfMUWj4TiPPcnBdcR85CexJpXAFQU+awqfNmtpmK2lQfuch31h7TAxM0koknYEorDzuIdRMNcupgm2FCk77ytIuIOQBVJvulroTTZUgRkidBklA3g1v4uhbKlEn9RrOfmeFcLu6M6K/DsYm/3KjyezQeBLcTbmfe1NQxk3U1B35Eer9BtvC8meBlFn3h3U4zshZbZo6FECGK9Qrf5GNAm4Byq0UZDPSwMG+qtxtnry4xw5UJ2fWXzVeiKTJm2i7YvZDypd1dxlZjtzuWs0IuRlBEpR53K03xxAeIN4UXX087hF59b6w65pnmdw9WBuo9nyk1SaB0Br19odmyebzXsilR1crM8ylrvk4gxShHBiMbfdGp+CnAsA06wPTtha0gTQkfDOAmch9ryu8v5+AI7dGjaPJiriaYkYkhEUZ1LyAaXAROFRhDjZGIPQI3OX0Q/Ci7sSQ9x+8BBD3wZOHHSg+h1d+X4Xi/DcStJnoeR6n2Jyi1o17+bz30ZkeU1upWsBTSZh/9rjTmJoK5clqqss+StuIq8JRx2akwNZcfsgFMCcLLo1mQwcAu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199018)(478600001)(26005)(36916002)(186003)(54906003)(316002)(6486002)(2616005)(6666004)(53546011)(36756003)(6512007)(6506007)(31696002)(8936002)(4744005)(86362001)(2906002)(31686004)(38100700002)(82960400001)(5660300002)(6916009)(41300700001)(66946007)(66556008)(4326008)(8676002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTJHRFo1ejlqOHBrQjQ2YWN0Qk1QZmdKaFhOMjlqQUdKZjdQV3U5Z0hYN1kw?=
 =?utf-8?B?UEErRjhuOXZaMDBqWHJMYlFuNFhacityUENHRE12aE4zdjlmRWNvb2V2ZE1v?=
 =?utf-8?B?SHhJSTZ5WlNLNmNzQ01ISlF4VG9Fc3FwYjU1TlpJZnRhU2x1cHN6QTg1Q1g0?=
 =?utf-8?B?bGl5OUFEVWQwRHBrRVZBQ0dCNmZpT3gxcmVLamFIMkJGa2dzWFVuM2htckpK?=
 =?utf-8?B?Wkw1WExVMVh1NGRDcGE3dlZWak5lZm51MmJLSzJiWk5LdXJ6ckNab2E3SStU?=
 =?utf-8?B?MUw5RjBNMktyWUh3UGg2OHRGWE1DNGJpbXozaHNQWk52eEdzcmMrYVVKQ3dl?=
 =?utf-8?B?R2Q5OUpZWENoTlpkb3VadnhTUzdOaWVaQnJDVG5wNE9XUjFMY3FLUTc2Wlhu?=
 =?utf-8?B?SGFWOTJ3dml3MS9nb2FRTGZGRklrdTJKTzZjVzRsUXk2Sjc1cXBKVXFiSHhG?=
 =?utf-8?B?eUFsdTJmQWNKak1KaDlIaDFJWDV4SW50VDBIZUlpY1JQNXM4dVdDUGloc3Bu?=
 =?utf-8?B?akFVR2d6WmVpdWxFRWhnV1ZZaHI0NGpkKy9GWXZFWDExeVR2ZTJGc1Mwa3Mv?=
 =?utf-8?B?alJVby9QeGIxRnRhWkhQdnRKaXR3OUwrR2VlSWs3TC9TTmNVOEplNm04WlRT?=
 =?utf-8?B?bkM1cVNxTERzZG5TTmdzMjQvenRKZ0RlUTFTMStzZHgzMVE4TmQwakIwMFJh?=
 =?utf-8?B?OU96eGlHNEpOYnBIeGxnaVRDZzlGamUxZGwwV2hod2FyQ1N3UlYrem5ieDJp?=
 =?utf-8?B?MjRjcVc0MkdaNEg3N1QyQ0UzRHZKRUFJakxrR3NTblpTZ2o0cHYrZzZXSldV?=
 =?utf-8?B?R3gweTg5b3d3NnlMcGYzdWRjZWdHK3hiQkp1cW9CTGVUaWFCNUMyQUdJNW1u?=
 =?utf-8?B?anlDWlp3bUlycG9ibWp5MG55eUtCMG9hY2dzVGhiMGhJQ0tZcklhQTZOV0NQ?=
 =?utf-8?B?NVR1R1lKdy9XOEFnNWJ2bkFWYnhocG5hNEZBdHBZTUJMV0VzdWhPa2RKdC9x?=
 =?utf-8?B?ck9ZNzBiUUFKeHVVbUxDYitqWFVGTXBLdS9mU2pISXorOUdUbDRIYlE5b2N2?=
 =?utf-8?B?YVNIc3ByNDNyMVIxL0VVc29PcG03UmIyM1BiYmhaUmFteVo5SWlkaFBlUDAx?=
 =?utf-8?B?RVpXQmN3bmk1TmduUXNNampXTVU3NUIxc08rWDlZMVd4TGF5ZVZ1eHEyS1RW?=
 =?utf-8?B?MVFIazNHQXFySU93bkpJdlZPbTROcUVPT0EwTDVMNVpMcWQ4MGV6Y2hIM0U4?=
 =?utf-8?B?M3N4WE1sQXZFRmZaVytHVElaamlYdGNoT0htbXgwSEhSWW41NTJQRTNKS2tP?=
 =?utf-8?B?b2ZseHBkS0JEVU1KRlZxbmU5RDI3Um9LaGlDMmtQdHUvRGRGN0xxUFVpQmFJ?=
 =?utf-8?B?QmRYQm4yY3JYbFE0NUNNV053a1VhTlU5bWVsdzM3cTlQU3VTdXVLMlgyUjRZ?=
 =?utf-8?B?MjhHa1RIL3VSQ21GVmhkTEtsMmdPUUdJZ2tBS01JbXFRbmgzWVRzYWFhcnBl?=
 =?utf-8?B?TnhjYnNBaFBaMDV5ZEUxU0QvbTUwNHI5UlJRRU5UaFVRTHNkOUU0cWdnTjk3?=
 =?utf-8?B?U3dKWVFaV3d5aEtjVXRnNkVab2FZQ0hudjUwclpoR2kxVVhVOFpHTHVrWVlw?=
 =?utf-8?B?b081bFBJd0NlV0xRdzBNNGpZazV0T1grNmFtZUVaUWJnWEVHZjRvdjc4ckxv?=
 =?utf-8?B?YWI2N1dzL3lRQ2dUaEJ5WGl4eUZqcTZlY2lnNHFTVmVzR2MzQkVDeGtJbUNZ?=
 =?utf-8?B?aDBCWEVhQzhVa20vbmtzMzJreHQwRWhJOWVOcVVmc09VSmNJNk04V2R0RU5G?=
 =?utf-8?B?TWdQSGRKbWhCeVBjM0lrK1A0SlFCYU1tQnFUelE1N1dFTVNPWnFvMTl3WjZk?=
 =?utf-8?B?M3lPRExMaFNlU2lHdURsN20vZ2h0TGJ0LysyVDd2OTNtQ0NsQUdlMWV0dkp2?=
 =?utf-8?B?QSt1bXhTSkg2YkxLUk5ZbkhxOXZFWVhUZlY0bnpKNEtkMFJxdXN0TzdmdEM0?=
 =?utf-8?B?d2pFbjNUV0FDSVM3c3RjMXBlclRIMnV6T2J6Vm5Jd04xbnJWR25lYnVraUpu?=
 =?utf-8?B?N01YU0Rwc1A5STBQamxpV1VzWkZHVUZlL0FnUDY4SnVaMmZ6QllJK1A4MldF?=
 =?utf-8?Q?bdLox6lgAj+0HKZ5Ql0KCwFGu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efa990e5-9096-4e26-1395-08db0ef6b3f3
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 01:48:15.0602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoTcQgPGAFk0YTkZAxb8P5htUm2MHRb0IE/H03qPS8cz3IkfYHmunEbstPTCHiPJCVhPyW99BWdB6eAtPxMWHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5774
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
> A synchronous API for DOE has just been introduced.  CXL (the only
> in-tree DOE user so far) was converted to use it instead of the
> asynchronous API.
> 
> Consequently, pci_doe_submit_task() as well as the pci_doe_task struct
> are only used internally, so make them private.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ming Li <ming4.li@intel.com>

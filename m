Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21B06975AE
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 06:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBOFHc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 00:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBOFHb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 00:07:31 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3482D28844;
        Tue, 14 Feb 2023 21:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676437650; x=1707973650;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MSWHeOOr+mEsoBMlpWiyb0sH1i90BFBhGuVlFLezXcY=;
  b=mjWRllvKiH9b+1lwtYeT8Uwc2HqCpy+rdDcLK2EbmCGX0s57PZJ7JJF6
   GvltPikb8zZKtWlsRdHOme9xmSLQqxYKTSy6ywWLjMyv3sXpVDpWmwb3F
   znaaDmRPg/gTSyd3R5CLHl8KmVIf/8AIpMCVfj6nylKLcRAgd3y99hqaX
   tmTk0A9T3tMn95Meo+vbEjny5UNKhFYHpJVGKPcHCDqssMtiE1gZl39mx
   ACSfDwFnNqHkOhiV7Bga82CGO6ysOBHbaKN0nOOJKTFYDpsSmJBuxNWyD
   P3KCe9upcU5HgWLP/JFUhePytF/Ht+qC9WNPQHjYJBZ0TaWe7UpXWatAA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="333483527"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="333483527"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 21:07:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="733140681"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="733140681"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2023 21:07:28 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 21:07:28 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 21:07:27 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 21:07:27 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 21:07:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aek1pRRSg8WHVqWoC+NZdjx4M4yDjVURf4PVdKwr37D8Hzdy0mpmYz5EAcg0/M69xp8Zih8V/fVHi2KWjyThxhV7+t4/L+6ULQxSWXjuZVAfbypQWiEIUu5ECTaSSdexsES8IsKFzXi3fdrs+RSJqOpO3VV9D0JLeY3IlY7MkgHhsVBs/ctYzCFytaGZgi+RWPphbOR0L0x9TiMepMJOYHujJoqjf+hcg4KJLTPXyops7umLKqL9XXLsy61h3+6ee2gal3EoKJ7mKQP5M0dW0792cJvhC2UAzJZFztbjLz3dC2bHHZNBmSjBLALj37pqVW+liLlPqh0p46fvMsWi2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfESwKq86eASwCdqxSBwE48ml9ZIfDXeOt9e+VFaR8A=;
 b=FUcaxA1k+HEX5uUN9AxAelLfGEHgySsc7sPGSCnbvLuhTYRqnam+gQsQdEUiyizNmPi3c8HYnXV/4XBqLh4Ve4oALmo8pJ9ZjqVPJL8KX1k+L7t0ejJA2ZEU1MZNmMR4S5+NoT9ARADSkQTlmLD+cP9wVdcWraJHQEh6z78JnpEsJsq5kNhD62loCsM0x2CMfCPA670v9WQQnpLLE4fDEGjXTYGc7SYjqnm12mxCWEFEjW+wYc0+dnLPE2InGIwdOZ0i7KOoSPXrJc0ylkpRhkAcdJFLntvwISMZqjW3miovlm1n1pdNvTdUJ4Kw7fcBiHK6Trpt3ZQ9vYCQNH3Uzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3957.namprd11.prod.outlook.com (2603:10b6:a03:183::21)
 by CO1PR11MB4884.namprd11.prod.outlook.com (2603:10b6:303:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 05:07:19 +0000
Received: from BY5PR11MB3957.namprd11.prod.outlook.com
 ([fe80::a328:556d:855e:3f4b]) by BY5PR11MB3957.namprd11.prod.outlook.com
 ([fe80::a328:556d:855e:3f4b%2]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 05:07:19 +0000
Message-ID: <16e65bf4-9618-f1a9-146d-acecd10cab6d@intel.com>
Date:   Wed, 15 Feb 2023 13:07:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 10/16] PCI/DOE: Deduplicate mailbox flushing
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
References: <cover.1676043318.git.lukas@wunner.de>
 <7b5cf1e007ba1638ff2512f221e8a7fd72ed8245.1676043318.git.lukas@wunner.de>
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <7b5cf1e007ba1638ff2512f221e8a7fd72ed8245.1676043318.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0154.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::34) To BY5PR11MB3957.namprd11.prod.outlook.com
 (2603:10b6:a03:183::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3957:EE_|CO1PR11MB4884:EE_
X-MS-Office365-Filtering-Correlation-Id: 5edf1d41-cb5a-4acf-3d59-08db0f12831c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7u+L8EfvZF6cupxzs5MckjGCl9iRYmWMmNMeEYuXkM60oteWtyVVjRb8eZjUE5hn06x+pQiupPINHMr6dzMkgTAaN7JCCtrzHh5NNW8FUXdvKiSYAOZPyi3CHU3ZQQdQ37Ytdm3OlFudmpct1+tTXC5qyUgKyyLdkyYaqxO0+yElypkYdxfrsGj61TV5PRya5u+f3MESVEtDipeqBeavd0oRryQr8yUFQY7a7TizWJWpom/Hiavb7aFx4hXGiwkw9tD01t9TalJn799Zuij65hx9nJdqNa4Im8p0/G5RrVYTvF/Em5QDj4KP7aOZ1p814zALYw2zAkNCgSEUuLqCZdVg757QGehpfbTEo6aG/0RoN+pEg6Dv56VWvpgPglRmrCAiHIfei6PePj+i0GHz5x9/mg06uwkAOLuwQtyX0Trb578JxmPDDbAdzUUmxUSW9mO4dSDofkZK1doj3IN+HNO9fwp2HNbUpgYAuF3unKkkzTkypc9g5iFF3LC/ZePAczSjdCv71khTYk25fAptY7MUPEdv+0/T2sVUaSAlRCHz7uRO74VutOVausKT+xzk4VlUSY0qjYNhJPHlwVvt4zFmQvTo7bNr31m7sWsawJcYGkjm0wK5QEhF9En1+PFf/BvVI/pEAIN9n+ytRLcnv3nOtWzAkCguYFGot1rK9m32FpB41wCCRcONVpfFUvCQ9ln+b0oMJBdYitfzwgLoYOOc79NBFYZNG5a0mDq9Al8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3957.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199018)(2616005)(83380400001)(6486002)(86362001)(478600001)(186003)(36916002)(26005)(6512007)(53546011)(6666004)(6506007)(31696002)(36756003)(38100700002)(82960400001)(8936002)(41300700001)(15650500001)(4744005)(5660300002)(316002)(54906003)(4326008)(66946007)(66476007)(66556008)(8676002)(110136005)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnNOMktYVlNwSVpibC83Qnp1QVZLY3lpc1NacG9LN3loY1djekh2TStiNFRa?=
 =?utf-8?B?eFdqc21lcFFzWmx4U2dRQjhDR0poN0VrRW9sZ2VzU2FCc2tCR1huTWFLWXpX?=
 =?utf-8?B?WFRaRDJQeXp3VjIwaVFyNThCY3RsdDBGV1J1OC9mbFBTTkkzaDNiaE5IWWFm?=
 =?utf-8?B?OFBaM04ra1FneXovWllJVXErUU5pdG1XM2MrZStwWTQwaWU5RVhZQzcyOW0y?=
 =?utf-8?B?VjFKZVZTVEJFZ3gyM3phMkNVTVRuS0h5cW5oakdBUXkyYjJYbm1hMDVxWU5F?=
 =?utf-8?B?b3ZRalFSQ1JUOFZmUlBTV0dJb1UrOFdEODNLZjJWZUtYMk03UU5YSTRIc21N?=
 =?utf-8?B?ZjhodUMzbWpNMFBRdEFzSWdWUkJsKy9DMnVxazlnQkF2WFdUempVclNHVmRI?=
 =?utf-8?B?MGcxVUlBM1RIbWFDSnZiTmJ5UnNnVG5oS0RRUkd0bXZtZm9QdjJsUzFHMTBN?=
 =?utf-8?B?MFNjc3hjL0FDK0hORnkrTUk4R1pHSFoxRWthaUVmRHVuMGxWNkJTbVZjUnFu?=
 =?utf-8?B?N0hzNDRMY1lTZnhlRnZYbHozRUxaRnNOVkFqTiszL1psakdSNDhyc3pNWjV1?=
 =?utf-8?B?NGZwR3lZZnpVZklTT1JzQW9vOEI4WFg1TFlTNm8xYmxHWG5BTUN6cjJlbllX?=
 =?utf-8?B?cVNESWpHMUp0YWR3eHA4M3VVNU5SbTQzZndmejNwWjhxM0tqK3IveXV0aG1w?=
 =?utf-8?B?ZGFjcTRDK2YyMVJOeU5IbHdUSTI0L0lPOVpsd1M0RFRlRGZ1MlFhQndKNVB0?=
 =?utf-8?B?MGJmTHpDdk9KelZ0VVd6N2MxcmFUU2Y1V2ZzQXp0Ulg5K053MHNrdHlMTDho?=
 =?utf-8?B?YWs2ZW5icEhxaEpDTWU5dVJrQkxwMXMybGU3Y3ZpelhRV1JpaVU1cFlZUGd4?=
 =?utf-8?B?T05jcmZ2MjdrSGhWdDhtb2NOekJLZnorYTl2T2FHMHlSM2lpRjFHTHdoakRH?=
 =?utf-8?B?N1E0UTUrSUhid0FjeTgzQy85RjlvNURSbXR0eVpKS1lBRVdHM0tSRHg5dTlF?=
 =?utf-8?B?MWJmYlp2L09QdzJJSVp2VkVZOWxYeTJJbWdLMzJuWmpFSmp1VnBOOHZIbnJM?=
 =?utf-8?B?Y01KZE9XK2E1aG5zWm5oOURJMVBmeHVtYWtlcGhOMkFLWWg1bGhzWmpMdkEv?=
 =?utf-8?B?MzA2K3orM01ha3hNZXZidlpTMEZaZUp5TDJDWGw0YXBaWWQ3OExOVEoyelQr?=
 =?utf-8?B?RUljdWU1b3V2b0VhUXR4dEtyTlNucCs0QUxGTXZzVXA0MWdvKzdGNnpuYStp?=
 =?utf-8?B?dFNBYlpQNk03WHFuamFNY0kzQmZ5RzlzeEQ1N2dVMFJiVGhFVkNZeWlwQTlj?=
 =?utf-8?B?b2Y5cW02ZU5JalJ3dHFDSlR0VDByS3l0WllUVTMzNHRpTUtSd0lFV05lSHhF?=
 =?utf-8?B?V3VMcFdscG9YMFVXclI4V1lCZ2ZiMnZtaUJiTDRKbEFIeXpYOHh3VTBkT1lU?=
 =?utf-8?B?RXVycUJScjVKZFh1YVFpN0tpYW5BcnZYMzZLUHpGdm5hVE9kWDA0ZWFwZGM5?=
 =?utf-8?B?M3R6V3dNaG55VXBzLzRvTklVK3JEbDdJQnhBY2xNQy9URDBOaVVtUjlTNDhn?=
 =?utf-8?B?VW01QUp2VjdHNDVFVzhpY3M3TlgvU3VmREdVTm5YRWVxSUYyVkU5Z2RFSU5S?=
 =?utf-8?B?cUY0YndFUzZjaVFxWjB1R0JnRktCMUtXbnZjblFDOGhra3lHMW1pUTdjL2lo?=
 =?utf-8?B?aEt3TkdGRVZuUjU1d2FGWm5TcVJVdUhKY2lVbUowclF4VHRJNW9FNHpNVnFY?=
 =?utf-8?B?cHowWEszNzhkb2puQlo1dHlyUmRFY3R0SGt1WDJGM2ZpQW1EWmQyZ0ZCT0FF?=
 =?utf-8?B?eWdkUWlwazdTVW9XVncwZDVPc0dBQ09vUVZLUnIyb1U4V2JQL2EwUUV6d0Vw?=
 =?utf-8?B?VFR2ZVIrcHg1dVlCcGR4RGx2NFNXcUVENlhCQkxnNDFKQXhwVmZ0Rm5BeHhq?=
 =?utf-8?B?L0RDMW1xNHpzU0lOUEdGb0lxOVpoTmlqdzBXckRDb3NwdWF1MWFmREhTbC9p?=
 =?utf-8?B?SmR5MEtPempOdFhDZjlDeXdlenpVaVZ0eU1lZTI4TEtuMGgvUFNjR3pXNVRG?=
 =?utf-8?B?SXBpREtLbjc5eGRpWC9TZndhTU9Kd3ByNzlCb2diaFdXV0Q3QjcyQU5YVHcx?=
 =?utf-8?Q?BJ9biWIEHib/9UULT7/eCG6BF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edf1d41-cb5a-4acf-3d59-08db0f12831c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3957.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 05:07:19.1082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptj00b1gQO83heCSAZBhiMO11AP+ARZX8hAHBsBUkoSXG9s5P2FmgAk1YctZ8OTpxiS1fQif1Y4R/6G9PP0jww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4884
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
> When a DOE mailbox is torn down, its workqueue is flushed once in
> pci_doe_flush_mb() through a call to flush_workqueue() and subsequently
> flushed once more in pci_doe_destroy_workqueue() through a call to
> destroy_workqueue().
> 
> Deduplicate by dropping flush_workqueue() from pci_doe_flush_mb().
> 
> Rename pci_doe_flush_mb() to pci_doe_cancel_tasks() to more aptly
> describe what it now does.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Reviewed-by: Ming Li <ming4.li@intel.com>


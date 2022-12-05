Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C835642E8F
	for <lists+linux-pci@lfdr.de>; Mon,  5 Dec 2022 18:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiLERVs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 12:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiLERVr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 12:21:47 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6795B5F89;
        Mon,  5 Dec 2022 09:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670260906; x=1701796906;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YHEsNPrEEfRQeTTncY1PfHW8fP07M4yk8AbFkOsw29U=;
  b=Gp9RfEhtcwFkSJUDgimfmFb8mj67HIzW8VQpoeZU4d++UoVNz06GO3jE
   m8OkYkQr34R+RSzKVN08b+3JvmheK1y1JnLQl4VTGf+8MUG9dFlIrH2g/
   fLeIkdAhPYp3XqvPwUrF0YjvSg0aQbeEmvPiRdOFBawxAibNHY908LiQN
   8QV7+VtrwaLEWZbd+cINp2CHdnXiBWtsoS9nkv7ikiTlQNRJvb5N2v3dm
   UWuQJTQqMVMlt7Vj1BWFgLBe+cywfdA5d/jYjpgEKmELKW41H5xNRwDAq
   QsZLI7qQKxhpUe9Jcot+kVYBe0GDdNWnAJEckqkvlsUDnwh4vVGtnk3Wq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="343402981"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="343402981"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 09:19:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="820267811"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="820267811"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2022 09:19:54 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 09:19:54 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 09:19:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 09:19:53 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 09:19:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3BH4e4X+c2yXHP+ZXF0RfQqHIh6ZkNYJa4MuPrpTQkZCtW2TTxeq4yICXcwFeQShEsEUqqwAFqv0CV2V8+ubqnnGgvqfbStlsKfc1dOiU4I+JATjYqvr/ha4QebUGn4FHB/REKVQ3xa9f7vAY1fRnp+E4NJ5cWI3ca+EMzQO/Jc+Fd6a/6zgddm2sd6ahn/bEwAmo+W756814eIG9C1KU+gnwLC1P4ST8s7V4AbOO5JfLs33nqDYZU5w+5RGmdSy5+nPDGqkl7Kkj+z6u7jK/mdTA6xSsYWAL1+XhSM3WTm5oVBe7ZGU6tMP1TaiZb04rfQ+hdix2dwLfjmeGEncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lmdfdjROtTfVAb4cq+2lruhc6UyvKnYK9VHSzzxokU=;
 b=mbAZMvt75GJ9JRhiZNvZHqP4mBKZB7xDeTXgh0TXsrHAVNFkAOdrnTuTxgOFvC6kXhakaTG/piazugGGWr2EW4RxhERzyxkNLdTRnMupyFyt6nf6PAFi82qoRDzPEa3BbPWz7CuuJGuEA5CGgnUToJrKu6h1qfE7HMuJc2gENYTQ1sztCY5t7rkQnWx/F5GJkJwdrdcRcHRIJ4uHGjbZlnh3t7kBc/zrm2TkOpiFN9fV++LmvxvzfarTFh3KhGLtpdlrdsOX9NZIMdMPObAJF91lLXmyGucR4wdpJRS5NFYrN/L6Dn0HxW/GlxMQTB8H4yRN3oLgRtVCbvPg4AUgnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN2PR11MB4629.namprd11.prod.outlook.com (2603:10b6:208:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 17:19:51 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 17:19:51 +0000
Message-ID: <11fede06-0481-511a-f9d0-7393339b05d1@intel.com>
Date:   Mon, 5 Dec 2022 09:19:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [patch 33/33] irqchip: Add IDXD Interrupt Message Store driver
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Marc Zyngier" <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>
References: <20221111133158.196269823@linutronix.de>
 <20221111135207.141746268@linutronix.de>
 <4a15c569-0545-20ac-e74c-ae17f7eb067d@intel.com> <87sfhxoa7i.ffs@tglx>
 <87v8mpg9mo.ffs@tglx>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <87v8mpg9mo.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0211.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::6) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN2PR11MB4629:EE_
X-MS-Office365-Filtering-Correlation-Id: e99ab476-2fe4-42fa-984f-08dad6e4eaac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSEisoQJVtZi0v2Y5J89gvIcWRi8Rmymk9IcLoalJn5kKtBIt+oIeJ4UrJ+ABR13WvjAJFrDWGEn+q3P/hywex18SalosZ/jRwQ4dOb3x+wXbry4C4mVZJU84E05yXBGxkmwnBteALzYdatVdqIKpEt3XXuL/yBV1KYurigoySF98Ms2YXidT4v5Z4y3Dra7j96kxubwWHQDp8WyIMw0VVLzJBJaWthLBZcqv86UpQ4N0SRgMXozxsdyF5UYvl2rdyNkzjwERWz0ql/9axL5FBSqTd7aQXQZS6DOptqZ2cGy3h/X6m4IkfHB8l8ymd/TPukg4RMKefvcVvrHCXszXlwquJSDmG1yHna+v5VbkNlExIBVGHG2ZmfEnS7qtAJDIK99NpbZAoCLGOmvftbYdsmyebB5MHIzReMNKN1VLGRpTxcWAjgax9f5GYMcPX5EKlmeEaTYR+Ik77tiu4uLBD4I7rMTnRWzzYLrViH0vgSz+RxuHB15rk0xCvYwknQGXY8uDs1ED1LLQN7puJ46R39Uhd3imKf9Ru0wlFWHPUbJImqRiUgodTEu4uRXP/r7hzDwJxqd+eQnBxqqojHmvIEynwKIrnrChA851h7hbx/r0ELo7cHROb7oDoli86BlJt8kb0BZneoAtut43xGsEOaGkcGdyVH9zWatm85NF1boZE5Tgy68hCZ4skbSlGkQEcCKKr5yRihb8OAo9NgIlfD5mlfe8k2f2zgfayYhbKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(186003)(31686004)(110136005)(316002)(478600001)(54906003)(6486002)(82960400001)(86362001)(31696002)(36756003)(38100700002)(83380400001)(6506007)(53546011)(2616005)(6512007)(26005)(6666004)(5660300002)(7416002)(15650500001)(2906002)(4326008)(44832011)(66946007)(8676002)(41300700001)(8936002)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym5Zb3pBMXdCUm1vQ1M1OEp2QllUMFRDTi9ZS2pJNTVGam9FRmsweld0bnFP?=
 =?utf-8?B?Y2lEa3lucXd3bG9YanV0VzdKZ3JjWFNDMThRYW1rdUhrNlVvWVVYUnFRTUQ5?=
 =?utf-8?B?NVRNOHZ5aWhBRVZpTWhibFJyeUE3N3FSb0piMEJpN05vVlZhUmI2ODdtbG1F?=
 =?utf-8?B?VElrdVViVWxIYllSYTVoc3Uxd0J3NWZWdmhGSTdabU9MVWtQWFplOHc4TjNp?=
 =?utf-8?B?OFhIRDRac05KaVFYamRMVzR6aWdJMUxvUlEzdkNWUkdzUGVXbzZuM1Z6akFn?=
 =?utf-8?B?M2tUMXBJMDdZQTNmOFNLNDNBMW5tUm9VeUVPU3VpMThXbU9xNGQ5Y2UvM0xa?=
 =?utf-8?B?aDNuOUNGWnpISGhWZ1ZlazhBbUdnMm1IU1lEU2g5NXZ2QkIyKzBVTGo1S1hY?=
 =?utf-8?B?OEtvR1AyMlA0dkNsd2lWdmVVYVZMcUVxdDFvZVlrTWZXSDYzMjg5UXhjL3BC?=
 =?utf-8?B?bFpLNXh4WDF1UWhScDRwYU1WaG5qK0IwTTRuTWs1L1ZzdTREbW9iV2EvdHht?=
 =?utf-8?B?S1JxSjJ5ZXNTTFdwSW5MQ2FVYzZMcjMwWW5ubTEwbzFacVdpZ2h2QVJoVHdF?=
 =?utf-8?B?REplUUkwa2lVZlVmb09IUFM0ZDREbWJLbkZWUEJKYmlZZlozRmxPaGJxdVlo?=
 =?utf-8?B?MFFNdUUvQXkwWUtvODBhaEJVdEdHeWdOcUVLQVY1STFkNitSUEtZaEhUNmR3?=
 =?utf-8?B?WnBqdnY5R2FOY3BXUjBEVkxZaUZwRGx6bjMxZHBjd2NRdzJvQWIwanVxanBr?=
 =?utf-8?B?V1NKUU1YMjBuNTZRZzY4RWxITzhGSlBaazZsVXlXOUZJM1NHbmRsVU9xRzIw?=
 =?utf-8?B?TjRITWFVVHArOTREWndqcnRadHVtOWRFTXJMZ0VGa21idVp5M2JzdlV2QWZ6?=
 =?utf-8?B?eWVnUTMreEpBa2l3VkdDRWxPMWtOQTJpSzIyRXlPMmFjYTYzMGhoNEI2WU9k?=
 =?utf-8?B?VkdCTE1XZEF6a1pvckptT3lpQzIrVDlHeFAxcFdWOFd4RG5UNTkySnc2c3Zs?=
 =?utf-8?B?aWRHWWhTUlN3UnFXRFBvKzV3QTlsYlgyY2VQSDgwRm81TkNsMDU4bWJIK3Yx?=
 =?utf-8?B?elVRSFJMdE1rOWNId1pHb3VzeDNFb3Q0ZFFMRmtKaE8wSUVtcTJFT0VyNWR5?=
 =?utf-8?B?bCtEcU9EUmExamdXTlR1cGVPQWgweStUZGtUWVpqM2x3MklSUDVIOHRpM3Az?=
 =?utf-8?B?SWFRRmJxWDdEak1QQTJndnJKMXFUckhUS3VVVnhpdXFmRXljcGtnUEtYdDlx?=
 =?utf-8?B?cnZXWGJQTVNnSm8yU2VtcTIxdjhmT1RTcFpMVzMvR1ZtbTY2dkxQR2dQMEVG?=
 =?utf-8?B?Q0ttU1VQaW9lV3dQcy9RY2JCNDdzRk5SbHVCS1ZoclI0eUt5aWFlaVpRVXMz?=
 =?utf-8?B?Z1hjMU1oQ0hJQjRVaDRsRXZqdjhhVWgyM0pjb05ja25qYVFEbk56R3c5cW9r?=
 =?utf-8?B?SmZRNlYwRFBXUld4Wk8wdmZBblE4QnpPNU1XamUyZUY1akV4emNjOW8zOWtt?=
 =?utf-8?B?c0pPaGl6ZlpDY1c1Z2FRSmV2eFRjR213RGR4OTB0M1JQMWdEOFJxd2E2ZFQr?=
 =?utf-8?B?di93cE9uU3FpeHNSWitWMkZZeVhKdkJxQ2ltaXB5SkVMempRYzFrTDJ0QWJv?=
 =?utf-8?B?cU9ZZytxK3Zaa1dXWWhNTGsxZkJIODZBQ3p4dmtTdThXTHRVU2hzdTkvNXZM?=
 =?utf-8?B?V3VxaXJOaklNbTkxbzExTlk1YWV2dkVQZmlwUVNXUFpaZjFUSE9NQWM5OGVK?=
 =?utf-8?B?QTRucFlad2JNZUxTeFZlMWhuRHdLWVVpZ1lZMlhITThTVUtEb0RCZEFsR2xC?=
 =?utf-8?B?Tmg5VU9vTVQxZ1BPVWJsMFNmWWx2ZXlkcVJlbmVlcWVneHBJVm9CM2pkYXVN?=
 =?utf-8?B?RjBFd2xqRjd6bXRFbmpkZERWeE5uTGsxR2xvYWN0a0M5TGlyamxUQkZ5R0w5?=
 =?utf-8?B?ZzAyU3ZGbXJZdEwwMXVRSnMzMUExblRlaG1UOERnR25CeURuM3MyVWw5Qktj?=
 =?utf-8?B?R2diNFp6MFFtNG8wY003VnFOWFRZVURJQ2lzaEYxNWhsKzBrUkFFWGlTSC83?=
 =?utf-8?B?T1BEM2MySCtMZnBzY3FwWTVsZkdSWnRSdkhWTmhDelViKytMdnpucTZESkxv?=
 =?utf-8?B?anZ2TkJ0UE5xdEFTSi9kT3NhL3FySnBlZ3B5cFlsaU9mOVhvNkdJV0RHRUY1?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e99ab476-2fe4-42fa-984f-08dad6e4eaac
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 17:19:51.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXXJUPkMwBH3fk4H4C+QKlkgKee29Pf97kzlJiz2s/2Ha+RZeoIwfRz6Q0kc9rmqf5muYPIdm0a116o9kM7WMMN8OzcC8ZRz01V7DBQVbTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4629
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On 12/5/2022 7:20 AM, Thomas Gleixner wrote:
> On Fri, Dec 02 2022 at 20:51, Thomas Gleixner wrote:
>> On Fri, Dec 02 2022 at 09:55, Reinette Chatre wrote:
>>> With the first change I am able to test IMS on the host using devmsi-v2-part3
>>> of the development branch. I did try to update to the most recent development
>>> to confirm all is well but version devmsi-v3.1-part3 behaves differently
>>> in that pci_ims_alloc_irq() returns successfully but the returned
>>> virq is 0. This triggers a problem when request_threaded_irq() runs and
>>> reports:
>>> genirq: Flags mismatch irq 0. 00000000 (idxd-portal) vs. 00015a00 (timer)
>>
>> Bah. Let me figure out what I fat-fingered there.
> 
> tag devmsi-v3.2-part3 works again.

Thank you very much.

This tag is not yet available but I can confirm that the current tip of
devmsi, 6bd4ee6cb126 ("irqchip: Add IDXD Interrupt Message Store driver"),
combined with the earlier irqchip driver delta snippet passes the "dedicated
kernel work queue using host IMS" tests.

Reinette

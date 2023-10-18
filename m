Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265EC7CE347
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 19:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjJRRDQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 13:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJRRDP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 13:03:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC32111;
        Wed, 18 Oct 2023 10:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697648594; x=1729184594;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4vaUIap9rlBbXlnU+r0TR95qW6eKIO9E2rqmD5oa7K0=;
  b=cqT3jud5TxCL706v7gZoWi6AcWJ0ol/yZb+5Wc1AM9TWPM1C2iWFSJFB
   mwrE7M0sh5wu8+rJcr7BcBg3fLfOGdUGVIAtTpQ4yN30yF5z3YXty+frW
   ngNLCb4bQRLaE/O26hDMYVczNd3sTgxnQlr692El5x5l3VbnDToAL4jIy
   9eINHpjocTGaIjyiyvgN9ZshxfGOG9tlAxV0xC+sH8eBN5wCOK14XJbW+
   FsJfkIY+g/L3dV34rD8tSMr2a3EIyfchoD5L8Oz9rJvKTfewuJHoP+hhv
   /3cNFlhpcXgv2/UaKLsloJ2B6LE03hxMeYtUVhRpp8dateXLY8ZldUrWj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="7610419"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="7610419"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 10:03:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="880303731"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="880303731"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 10:03:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 10:03:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 10:03:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 10:03:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz88hJTZGmngeq3EmO3EwIdo7ga2iNlU3IDRI4TjJCPVnqgCu8ZX7Bk6XCDwCiLV9ArTKhy+bMSIAPMVQ1YPy+JCO19z5UZmBiAulpURKDTEWle6s0E3Z9X3MJWjOInFXg3ruGoqK1dwqNtrdCnL0t3kNtVL0Xu+b09RcJB2upca6xWk55RxEer4qAz6opGeszGe03mkEtlVaO2UKWMqAwV8G/XQsNdL1Tfp93nQKpGpix3CVifpKMBkDksH/eGkzjzkFXYw9HxwfciF5WRbRpIDNDfsDa7uM3VTCXOG5Tk/UZmuogsTi0ejx4kTEd8+eKozRMBEbBKkTcIoFY+BLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yh49dGkaNmi/FqV4fHQ2QtLIZY4DoUQXQFmwZAlxt4=;
 b=kWr/RYk/aH1UoigTA7UnEeVMV5cdhyrKB/BPUS5vTEk9Q4XvlunYucW9Gm2BVGZhmDrN4HKu0hbgm4QarBvYkNDEOxCuAiBV95irOWJHdRfRi/TS0+x4FzbmXXMJOqauiBd6D1PgYmSMD5JnrZxNCn8djjT+0iyzSquyvzqIXrTsHMKkj7KhZ819of8FU0ov+vKpUmXFo4Pdv2OyMclzAzkmGt/OkT2darLyyo4yBlKBZMKucizb6br/kdPUUUDSJzcOqEZ0hxz0BSEhL7c/1CEQ7natmqejAZXORC+H4KRo4n+morSQLdnntqDSnrgTKKoTgJl4pp7p6t9qBVX6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7684.namprd11.prod.outlook.com (2603:10b6:8:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:03:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 17:03:09 +0000
Message-ID: <943c50fe-b951-4e5e-b130-64e20742a3c2@intel.com>
Date:   Wed, 18 Oct 2023 10:03:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/MSI: Provide stubs for IMS functions
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <bhelgaas@google.com>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <trix@redhat.com>, <tglx@linutronix.de>,
        <kevin.tian@intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20231018165231.GA1365828@bhelgaas>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231018165231.GA1365828@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:303:16d::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: c202ac9a-f5c2-40bd-5e1b-08dbcffc1b11
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F9PHzyyr7LxN3ZAPREqAXHq7e8hfmDYuRzgStypAPpRZN7pUk6UkDkj9HZTo6XnMDrxnnXRi/G/qWiS3OBqJYWQh2+CozrNtkQwhw/Fa9rXseYuMT37drc82OlQsgmD8US9fxBlaMzqrbgI20giYSxRbCQ1ULHukkSmNfmTeN0801mbDqvuawjAkh6gU53XLSc/FJ75xLbeyit5cOmAZzzf8qn2wrH1fAxyZenVWmBrmVLb9Zg/kDchVjj9X2lww6lOT5Kt+zwrfx4rmVs+sjr+eWGQQYSPskr73rPtjF6q/I1VYh8NVWw8ZafkUYlyRTKx72HUsqeWyyuZ1m/ptgKtGdu2PxgdEJUODuSzc1P8BKHkQaIVnwyqev2a5jt3u5M0lo3Txkg4+1vcebQVyd38ez4mQDsF7rTz/slzD46lUQTqpn1zHbw4TKxcwt4kpQF44FK4GTE3cC/eZvIp6KpiTKagnYd5xndhFgjjzlrXpfEVO7iO49s2IGbW9+REMMWyaCUlEBGJpEiHFilvL602clTxiqC1KkCkVWae8WExMhZyNDGw5qg1JooPBYJ5M2znT1lw78uqjyZZ1g3uuEJoQwd1fZcSgko2cjuk4emRL9ygIZQsSHm4Ma2l0NGCb7E+c4JXiR1N/BslZksb4+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(2616005)(6512007)(6506007)(53546011)(83380400001)(4744005)(5660300002)(44832011)(8676002)(8936002)(4326008)(41300700001)(2906002)(966005)(6486002)(316002)(6916009)(478600001)(66476007)(66946007)(66556008)(31696002)(82960400001)(86362001)(38100700002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWNXUHlUZDNiUXlJWmkxdks1MWI5ZFBCdVlKOStKQ0hnSkhKWnkxTUM5VVcx?=
 =?utf-8?B?bitPRU5Zd1pNM0VFd1l1Yi90RDkvMk1VbDltcHBKbzdCQVZPOVdoTWc1UGo1?=
 =?utf-8?B?dVE3aFNpMkhwOEdNdkFUVDl6WFIzQXhBVEpxbTJ6eHllWFhFWk9McnNJdWRV?=
 =?utf-8?B?WUxsZFhYQmtwalFrSVRXcDNFMWdiSUZUVXp2c2QwUTEyZjhnWUVYYlFDZklT?=
 =?utf-8?B?aFRQMGhNeFprVzlSMHNzNUlMLzRRaXBESkNabUJSeFJ1S2NBNzBiL0pDbVow?=
 =?utf-8?B?UktLZU1KNTRjdGZwYTFHZ0c1L04zRHVYU3E2cUZiaEVKRFpCS0F6SjFFWmVz?=
 =?utf-8?B?bStUeW5qdlVGdTV2dW9hOFFMdVhOZndCVmdMT25saVNRK1lBTnNUdWkyUGJn?=
 =?utf-8?B?R2liMkE2ZDFNS1dwMXNjWWpOb0dmcEhDSWtIbml5L2U1WVo0bkptcXdkekVG?=
 =?utf-8?B?SlpMM3M3WGVRVUhLZVlwYTNBbDMzejFEUWcxNWFTb3kxTjVqb2JmdU1hVE5Y?=
 =?utf-8?B?aS84ODJaS2daMDFUODJCa1cyZlZPRzBrTjFnQkJrZ1dnVm0zaC9oQnErZ2Zo?=
 =?utf-8?B?YUxvR0cxQVR1WHMvTWFVWTFpYXU0eVVEY2ZYSGlLeDRwZ3E0SHh4ajFhUTY4?=
 =?utf-8?B?dWJrUnZUNmgzbWxHLzlnSVAxcENGeHlNdUE5c3lqcGNTMGc2RHJkOHUyY21O?=
 =?utf-8?B?Yyt4ZC80aFU2cEhLQ0hlOFRGVzY5Zm54OUpJSzVnQVVwMkRzR1dzQ1BiU0w5?=
 =?utf-8?B?SUkxWk5PKzlXNlZ0YkMzaXdhQ2dIZ094bXo0QzhkaGFUV200UUU2M1ZoWnB6?=
 =?utf-8?B?QVdXU2xSWnBLaUNMNVROeXp0bGlGSnk1emFmTVNsaGx2aXFXR3BxZGFRWDY2?=
 =?utf-8?B?TW1vZHFnMGlFWFNIMUFzR3g4QkltaTF4a1NnL2lOSHh0bFZlNXJxd0V2N2Vt?=
 =?utf-8?B?elBYeWlQSHdIMWdKRHExWmxPMGgvaXp0OGI1SWluSjV4TXp4bDlkdnZsMFlj?=
 =?utf-8?B?NlU5LytXeEwwbWZjUzhlc0dqTXJZdUVYSVZJcXg5RTFFNFZjVS9QVUhNeVNL?=
 =?utf-8?B?SVNtSi9wSXJsaGh1SGtHY05OS0FBeE5ESHp3QytSOW5GNGlyMllFRFlkdjc4?=
 =?utf-8?B?REJOalYyK0pGMEVxanJTTHVvZndRNnlEbFlKb0FNcHJjTHlCNmZ5SGZrR1ZD?=
 =?utf-8?B?aW14T1VwMEhnR2hRVXpacGlkbkQ2M1A2clAwVVJwMy96eUZFL2xwRGxuV05z?=
 =?utf-8?B?R3pKaGFWZXZ6VTBmMUhoUjAwTlBQVmNPdzFqNzZzeWo1UE80UktNOFUxVVJW?=
 =?utf-8?B?OFhFaEQ4RG96RXJTV3dUN3RDMFc5UlpoTG9GRDRvS3NFbXJsa0VkcWRCem8y?=
 =?utf-8?B?L1ExSkNaZGVEK1d0eTBWY04wZkVNd0NBbXo2VDNsNjJHTTNFTTJWT1RiQktE?=
 =?utf-8?B?UHNIeWt2MW8wenlkQVlSWGt2QkN3Z2kzUEJQeDFiVnk4MHJoNGJpclJmMW5w?=
 =?utf-8?B?QVhLcjFia1g2NmJSalNuMUl5S2Q3dU1IaUdJNytrcTFsWmU4TnVEb001OFh6?=
 =?utf-8?B?TEx2VXZJRTFwSi9VZWJrZlQ4UnM1SXhnbXNtZDczK3pBT0ZuTFhidjJjTzNn?=
 =?utf-8?B?ZVlzRUFWdXhlVmxBRXhNOFpIUjVlUS9uV29EK2o4MSt5b1VrbTU1UnFNeThJ?=
 =?utf-8?B?N0dYOFZ6TWpKYWFmTUJUeVFIVDZXR3FrNlBXSThtNXI4M0hEeVQ4aFZRT3N4?=
 =?utf-8?B?Vit5Qy9mZTlTTzNUaXdUS2pERGJxRzRWb3lJT0dMZ1p2MVlhSkRnNnRSdTVQ?=
 =?utf-8?B?dGU0MWZKUlUwWkw5NGI4ZmJialNwazhTYTBUaDc2bVNFaDJ3TUlRcHpFaDVx?=
 =?utf-8?B?OVV1RU8wa2hFQTR2WHBoOStya2gzUXhNWW04U0tYT2FuMnh3UFNFOUI1aDJ0?=
 =?utf-8?B?UTRYL0R5S0tuOEdwWUduUERHRGUrbFBJL0NHdlh0R2VlMnZkOFVHbzZ6Ni9M?=
 =?utf-8?B?WjRib0tid0ZNbXhvWm84S1VYV0x1S1RvQkN1Um53aWo2V08wSit0WmZ1M016?=
 =?utf-8?B?Mm1vSDVML2kxRnhQZzhhV081dmM1WG11SHFsQitaTDEzODZFUURha3BwcEM1?=
 =?utf-8?B?bk1TRUVCZFM5clBRVy8wYXZNUWd2ZHRWME9uT0Jmcm90bnQrcHB2bkp4bFMw?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c202ac9a-f5c2-40bd-5e1b-08dbcffc1b11
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:03:09.7052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjgCQc9fo5sVOBWB2GVBHagVzAL90PCoyGi3an9AkrUT5m4jmuyUScIbFWpTQnKk6T+iI0S0SOQkIcoGF9aUzMTyrFOikxoqTJAaMf/ghxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7684
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/18/2023 9:52 AM, Bjorn Helgaas wrote:
> On Wed, Oct 18, 2023 at 11:43:51AM -0500, Bjorn Helgaas wrote:
>> On Tue, Oct 17, 2023 at 10:56:38AM -0700, Reinette Chatre wrote:
>>> The IMS related functions (pci_create_ims_domain(),
>>> pci_ims_alloc_irq(), and pci_ims_free_irq()) are not declared
>>> when CONFIG_PCI_MSI is disabled.
>>>
>>> Provide definitions of these functions for use when callers
>>> are compiled with CONFIG_PCI_MSI disabled.
>>>
>>> Fixes: 0194425af0c8 ("PCI/MSI: Provide IMS (Interrupt Message Store) support")
>>> Fixes: c9e5bea27383 ("PCI/MSI: Provide pci_ims_alloc/free_irq()")
>>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>>> Cc: stable@vger.kernel.org      # v6.2+
>>
>> Applied to pci/misc for v6.7, thanks!
> 
> And dropped, since Thomas applied it via -tip:
> https://git.kernel.org/tip/41efa431244f6498833ff8ee8dde28c4924c5479
> 

Thank you very much.

Reinette

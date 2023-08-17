Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB9977F405
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 12:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349887AbjHQKDl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 06:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349889AbjHQKDf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 06:03:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C621BFB
        for <linux-pci@vger.kernel.org>; Thu, 17 Aug 2023 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692266614; x=1723802614;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+x+Dwrj4zV8CcRpMdgXZZFDF1JFVf8PMUnyhTcq78Bo=;
  b=UYjrUOS2q1COW4aDV314ZUKijzSn2d8u75eaYyR54+dH0wqX9UvYGfUw
   6RZMRdmWP0D6TJxRQM03GH8qtJ8p97rMDoE6Na0jJzZCA827/5dmCoufc
   UsoRGQgY8wtHClZUMhMiCib4RjKd3mTIXHF9qO0vct2tsXE+4Gf/mzvIa
   9KTObzuKlq26mkKDA2iCIUjBB0wlgOO07uVq77rnpbFL009WPxZyD1hGr
   cQ3IX+GD4O6OKLDpEwxEn7u91SIyQ9Ou9oorMoT212gfPpJ7+DaJ2o6vQ
   uv+fd09Z2Iwpme5Gg/LA4SFhHxIwEzEp1O9ncJuFeSQJh5FR6pRQoxHxl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="370236989"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="370236989"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 03:03:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="981094457"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="981094457"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2023 03:03:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 03:03:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 03:03:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 03:03:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 03:03:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zu9AW1/N6zN3kTe/oTrJNH8u8Ksm1YNJEdy6YUM5ADKXUbb/sdE3nBkJCfO828RajCw+/By+mfMUZPL8myJYI8GOeTdYUdncV00AChU28Fy6+A4OlQceIvVV0eahRfFRdhXHhcFl43ZEBUTHmN6/PEC433LbGD1w8UmbZ1l1knFezMStFah41kp3Dhkf+pUY/HwQMuZ2vEFEXJbNGviFPmpssAEqWcRxepYNlortFkxfC2p+xOR27M9Uuh/d7pVZsY50Or0elfVg/VBNwe2/VbMVbRe9+1jQS+JoeknSEaPiv1qt1wwbeSbtIByvQ995eSo6BdbqggBOH6RD+T8pbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoVqox4qCO7sFgnWwBkGgaPdfugrQqT7t7dhG8ekaBA=;
 b=jx4xWRccYBgmUZNTSnQeXmunaXAahW99xhMujVvNCnVJ+aI47ChmuIol9FZ196T1qKkDUIP1ME2lvwDCRNCuauvncQH/Ql5RJUzlLLfcSLUXOUAX5QoiUU51fNb9I1hzcbZTngFw2v5a5la62zmU2os8ZRPPCq+9wzH+xy9HKpO7iVU2sxx77LNk2l9XK1V8A2hBYdR9j9G6gO8vUEFZyQ5bAB5zaTlEzofPDTNjZRDguoJx0zlgI2TaWXz8N2XzfVtyeJ9DCb5M2mu0DoC5koQDEi7uOFmpi3crHDTJ4TxN6smjlx7IiOBQL/bwhsk1hr10DMiTslO7DYfySK9xeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB5948.namprd11.prod.outlook.com (2603:10b6:806:23c::18)
 by SN7PR11MB8068.namprd11.prod.outlook.com (2603:10b6:806:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 10:03:03 +0000
Received: from SA1PR11MB5948.namprd11.prod.outlook.com
 ([fe80::357f:cb81:fe70:d9d6]) by SA1PR11MB5948.namprd11.prod.outlook.com
 ([fe80::357f:cb81:fe70:d9d6%4]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 10:02:57 +0000
Message-ID: <5da35e67-1cc3-0bad-35e4-819a4f19e925@intel.com>
Date:   Thu, 17 Aug 2023 12:02:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] PCI: Disable ATS for specific Intel IPU E2000 devices
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <sheenamo@google.com>, <justai@google.com>,
        <joel.a.gibson@intel.com>, <emil.s.tantilov@intel.com>,
        <gaurav.s.emmanuel@intel.com>, <mike.conover@intel.com>,
        <shaopeng.he@intel.com>, <anthony.l.nguyen@intel.com>,
        <pavan.kumar.linga@intel.com>
References: <20230816172115.1375716-3-bartosz.pawlowski@intel.com>
 <20230816173906.GA292642@bhelgaas> <ZN3t2eYU09iW/4At@smile.fi.intel.com>
Content-Language: en-US
From:   Bartosz Pawlowski <bartosz.pawlowski@intel.com>
In-Reply-To: <ZN3t2eYU09iW/4At@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::18) To SA1PR11MB5948.namprd11.prod.outlook.com
 (2603:10b6:806:23c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB5948:EE_|SN7PR11MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 428963e6-750a-4780-8439-08db9f0921d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +U52Ag5YiA6aHbGs0ytyfi3X6qrE/616ZsNYunZpFnbe7k3DmysVcPKUgA5fF6kHv9BmPNxAcatuc/rd9JdaZFtLMnU2sQdMLTijcZl0gzSTZE4CAkWkHLExHFyxlFe4v2IC1TFf4JdRNJc7WU7EMZWuCSN+cXQ15TC8+lY8bvrfDKXqgchoDbujzvbBw+kpy/QEUgTtfvTqkqvfDJNPDG/vjtiv6clXTm7kF4iq7HYNXuMVYY9bQ5mE+iERVgww54fpRIHdZFURH85cRin+FG5z8rhA2rruaVAMBUDPBIpiIAd2lZnnuRIQPJFLmturGoLTLNl1zS4FEdrIpKk4KEXUTLNbN5eZREZRwcl5ONvFuQiYm2oxqLyZO64IB49UPX279odAwRzX9RdMyjGPEYBjgJOQbpIZj/bFfhKoUPp8MeXub5f+7Td9K68CYB/1zs5sTsPbOr+Tb+tybXHoRR1J9Q+ixkTn9ola/tRTawyubU6NiC2pyfPGRTDc5MzCrIdSchDxJLDW0D086nya7XEIzDeMJoOja2ERQIi1A/bP0dZzG8LWjWvQqyMpN7DkhF+n02n1Quft+eQa7qxucz3qGCy/K1kCpKYtVAEdZL6KZaJOx8yD2f1r4Wg5YGRPmi4Th+CFsWUX5WDslXN4hQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5948.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(1800799009)(186009)(451199024)(83380400001)(2906002)(110136005)(66946007)(66556008)(66476007)(6666004)(6486002)(6506007)(316002)(53546011)(478600001)(44832011)(2616005)(5660300002)(26005)(6512007)(41300700001)(8936002)(8676002)(4326008)(36756003)(31696002)(86362001)(38100700002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em5PVXZYZUxJb3V1eUlxNTh4MEwwKzZHZTBlZ0xrUGM1S0YwL3doaTFTYVVk?=
 =?utf-8?B?Y3ZjRUJNL3FVNGgvZXZycHprc2dsVXpuZXRVRlFoNHQ0a3JYejBJTFlIY290?=
 =?utf-8?B?RW5IcStHS0swd3JYMnJNRlJqaTVpTG0zb0ZjL2wyL205YjR6MHQwbStya3Zp?=
 =?utf-8?B?Skk5b0hYMEVYMkhMRXRPd2VJL3dpNlA4LzlsYm5Wdm00WXZzbEJvelNqQmFE?=
 =?utf-8?B?MXFRNUorQzJPZmhsNjJLOUtscGJvZW0vV2hsSUtybk9iN21Ia1dtcmFOUHNN?=
 =?utf-8?B?cndyWGhvWG94UXFETmhkc0ZwMnBwZ2JLNDdVL0ZGOWd2Q1ppYWpPcFFNYmYz?=
 =?utf-8?B?aU83UEd0OEVMQ3F4Vkw2dXR3ZCtjZ2w2NUh3UjF5d1lVbHVhcS9MOTVUbjM3?=
 =?utf-8?B?SFJBampDS2QvOFYyOVVnMVhoRWpGRzlncE5WVXdURjBQMTJPRzkyVGNrNk9y?=
 =?utf-8?B?WURnN0dlWnlXbGdsUWZINGRKSmpNR1NreDhycDdXTGMrRU4vS2grcElKVFVp?=
 =?utf-8?B?M1FBYy9QRzVYeVVONHhKZXYxREFBaldCNmlNeGlVOVIxdHBhaDN0YmI0MmNN?=
 =?utf-8?B?WFFEVGs2OXdnNUJnWFZ5bzVSamFweWsyd0dHelJqbll0NUlEb0xEdVp0WlJw?=
 =?utf-8?B?OFM4VjJXektEbVJKdUVEQnpIeDJvT0lwcHlFY0hnQ0RZSUtVTEpQNmhoMzF6?=
 =?utf-8?B?THMyMmpPNU9xRnlmK1lmLzQ3eWUrNkVpV2J0SFNEMzFMUUF4ZW9KSm9QRW83?=
 =?utf-8?B?UEl0b2dUUk5ER2Q1QVU2dTNRS016eCtCV0h3M1k3WVQ0dU5qYkxETlRiUEFp?=
 =?utf-8?B?aFRkWmZ1NUhnRktvODlXMjBiZ0ZMc0dabFRWYUJZL0xUS1FWVUhvM2orb1Za?=
 =?utf-8?B?V2VKZFlxWWxqMC9TUmtCeWY0WU5VRTByd0JUY2xiUXRFTVFST0J3TEg5N1BZ?=
 =?utf-8?B?VmhWZ1hFUlZ4ejNqNC9vcVUrTHlacVIxSDErSUFKWkNBT3N0M0JyK1pSa3Fp?=
 =?utf-8?B?STZ2SmpIQXdQUlhQRU5WVElqaE0zMzNRa0lGT3gwOXhnS3BjU1lSNjFoNEY2?=
 =?utf-8?B?bjRJOUhVTFczYVJuQWJ2V0h3cWlrQUlBcUFFL1FWMU1lVHZVZlhEZmpFcDdM?=
 =?utf-8?B?MWNPd0RFYkZpd25IZDVxSFFURUNnbFR0dnRzT1ovNjJTQ01yTVFEY3RmZGxm?=
 =?utf-8?B?YkJSbzI0clRUM05WYzVMNDBQLzB3ZTFxNTNHczNLUWdoOXBjenZSK1d4RlZ2?=
 =?utf-8?B?SVh4RkpyZjhyUmhlM0Q1bjN6UGVyM3Z5b21yUVkyQmNVTzNwdVhOUjVoL21v?=
 =?utf-8?B?N3VwbWxHclRibmtJV0xxNXNwa21LTEd3N1BNV1g2TWpobkpDMGY0d3FDNnRW?=
 =?utf-8?B?VFBjeWpsYXd6Z0dqOTBYdlBzOVAvUy9TMXE1RTUxbDkrMHNLd3hRSjJwY0Ir?=
 =?utf-8?B?OWhveTdtbnUrMlJMNWhScWRvZTlHZTd2dXFpeEJGbjRKaGZxNEhJa2xoK0xW?=
 =?utf-8?B?SGxvODBQQ3BzZlJYbzhYaDJja3pFN0hrU1VYZWhyYjUxOXBNT1cvcHFrOFhE?=
 =?utf-8?B?YlRBdzR4NWxxMUx0VUMyMWUveVRmdys1U3J0MElGVjBFR3lEeVh3UHlNNWcr?=
 =?utf-8?B?ckZWTFBUaG05bnBnSi9GNHpqWmhJcGxLeHlHUGVKOHM5bnRJUjV0NjdUNDJY?=
 =?utf-8?B?VHdNQkFkc21xN1dNV2NEL3pIcHBCdENoUDUrM3VBQWhtTVdiK1NTRkkzK1pQ?=
 =?utf-8?B?RlI1NkJVVzVxZHBQL2xOVElHcjdnd2psOS9iM2pMaitHYVBmc0t3SVJjQ3k5?=
 =?utf-8?B?b0twUmMzOWZRS285Szc5Q210QStabENhU1kxU3dROGxaQlh2YmllRUVXVjkr?=
 =?utf-8?B?RFlLKzNpd2RZR1NuczQwcjlLSysrb1dYcytja1JjaXZlemNoOEJYdnhCQksx?=
 =?utf-8?B?TFY3T3BBMWwzTGt2QXYzRHZoTUwwMXhxa3lBb1VEVU9CT2JGNHlSYlkvNWhj?=
 =?utf-8?B?bUVMODNuTXlLR05pSW1IdUUrUnZPa1VCVFlwRU10RnRNYkF1ZWRxZVlKTmVp?=
 =?utf-8?B?R2lPMEtEcWFSajlWcDlRYTlEOU5PYkpRS1dWbWxnK0JBK2ptRW5aRG1XYlcy?=
 =?utf-8?B?YWozaGtJMkd1Vy9pQS9JQXBRbEJiVjROa3RZOXJ1RkdOeTZibyt0ZDRZeHgz?=
 =?utf-8?Q?NGWAmnUtdJeBORhAhaUaDTA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 428963e6-750a-4780-8439-08db9f0921d6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5948.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 10:02:57.7635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adl6idA5isO/MSpZQbhrL+A31tTthZ0lqXHRoAjS24ZpP5U8QOL6ICLy+k0aQIRn1aFu45/VPwim+QRPiEEDM6vnKSRUIXtKrGsvmLsLASU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8068
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 17.08.2023 11:52, Andy Shevchenko wrote:
> On Wed, Aug 16, 2023 at 12:39:06PM -0500, Bjorn Helgaas wrote:
>> On Wed, Aug 16, 2023 at 05:21:15PM +0000, Bartosz Pawlowski wrote:
>>> There is a HW issue in A and B steppings of Intel IPU E2000 that it
>>> expects wrong endianness in ATS invalidation message body. This problem
>>> can lead to outdated translations being returned as valid and finally
>>> cause system instability.
>>>
>>> In order to prevent such issues introduce quirk_intel_e2000_no_ats()
>>> function to disable ATS for vulnerable IPU E2000 devices.
>>>
>>> Signed-off-by: Bartosz Pawlowski <bartosz.pawlowski@intel.com>
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Andy, Alexander, would you please reiterate your reviewed-by on the
>> mailing list?  I try to avoid relying on internal reviews collected by
>> the author.  Those are great and I'm glad they happen, but it's good
>> if they also appear as part of the public conversation on the mailing
>> list.
> They are legit for my name, I dunno what exactly you want to hear from me.
> The internal process of review requires these tags by default, it's hard
> to deviate from maintainer to maintainer.
>
>>> Intel Technology Poland sp. z o.o.
>>> ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
>>> Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.
>>>
>>> Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
>>> This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
> What really needs to be dropped is the footer.
> Bartosz, consult with the internal resources on how to get rid of it.
Requested already and I hope it won't appear anymore.

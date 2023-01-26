Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B969767CA35
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 12:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbjAZLoI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 06:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbjAZLoH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 06:44:07 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A242CFED;
        Thu, 26 Jan 2023 03:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674733446; x=1706269446;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3/3+YOI2v8PL3LKZARkozyXvrdntCJDQc7Qo/xV/gZE=;
  b=XOYWzcmicwlkmGBaanXMFWDyXO9S6JxXEWiY8p55ghRmYkxf3M9bdVkF
   DfSSx9Rt28CcHyAeSg8G9Xio0OsSWGWJNanElnP92rdJjQUMC7yjyHlVh
   bQkW3w69+mKs6gP6tcMNWpBRGOTTjL9f+xNWC7FwdMMmm2McRF0px1lqQ
   M6bFfPXyu5HLHsOtmyeFmqKjwlMOy2y/sLPSQcU6FTX8hUY83QpKuamqo
   Du6erW0ny2g8lSB32HX5RX7E9Fd+8bSIbJIENCpzaE6MEbcPme7bWlJh3
   M9l7Is2PbiyUmTtFHt4VXEYa/O2a+q8HmjNCGjrTvp32xShgSPkAhpNbD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="354088868"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="354088868"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 03:44:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="695059865"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="695059865"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2023 03:44:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 03:44:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 03:44:04 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 03:43:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lv7BJPFurj+yfSJG6vy9Fez3cJUUOxRvTyIZdHjwbUmpmU/qlJy3WIO8KumtHXiZ50OFkrSrg+UHaE28GAUBR8AQA8zJIBe+1NmlpWFTkNwhmhNmRFjGNKNC1DugoxHfzr2IuUosatQHKU6q1hXz4VxtspVNWnXmnZA59mlTqQK14YUrNF24CY+u/+5vZ/ExdaZ95QBcReDwgKNnY+zBNLrLYAKkdNSqkPsj2cfAYYsl4nHD6PqDXyO9YU7Q1QKNCLdlOUriokFHUQN5p1i84/ZKU1xu4evtxh+Z1cKnXdMDwxjjUiEghB6idrU9JINAX/co1/URnMNi0o7c7Sgc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHGyj/n2CjLe9dAFPHU2ZW7GSATPpoR/uikF9uM4HE0=;
 b=ag1gpcZYMSOKUHcwhHEKW+kZWRxTx8pZ8hu3bMUD8f2jTcFXWYWj2cn+GAVExjFjwrZku8pGGtfeP4dDR4KodjTsFojnbh0eBx20m6JwF+Me8lOKFz/WaFgQieFJLxfCKWP6eB91w5fk1V0M0Mf87kwP8FSEaT4re4u9UP+ZfaBsRkXsAavvViN3VBxliIzFloyuwUgddnWepNhbIUC9U36frRCaR8jt70EDJdcX/WviyOykfgHXD/PZkWIpC1+uxppTQh1wHuscfGB1JwUg2pF4OpGfzeuRe65xfXVmBrfWUV5qtilMOKPhvT0V710LmDE7b2I8Te+4LeXKGuz0mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH7PR11MB6745.namprd11.prod.outlook.com (2603:10b6:510:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Thu, 26 Jan
 2023 11:43:55 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8836:6aeb:e872:30c3]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8836:6aeb:e872:30c3%4]) with mapi id 15.20.6002.026; Thu, 26 Jan 2023
 11:43:55 +0000
Message-ID: <6543a06a-2d8d-3bdc-6d01-75cb94417221@intel.com>
Date:   Thu, 26 Jan 2023 12:43:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V1] PCI/ASPM: Update saved buffers with latest ASPM
 configuration
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, <bhelgaas@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <kai.heng.feng@canonical.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20230125133830.20620-1-vidyas@nvidia.com>
 <5be13f9b-fc19-28ee-3ed5-8b85f85ca7e8@intel.com>
 <8cf4c8fa-db6a-7814-04d5-921958949f42@nvidia.com>
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <8cf4c8fa-db6a-7814-04d5-921958949f42@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::19) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|PH7PR11MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ba9b91-5dd1-491a-7c1a-08daff929a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nFgnWR2w6EthJbvg987q29aA58jzjath8tvf2JuLLxqoc/j9NrUJJyqQHx0BxIpziR1I3vZy7IAgMPuKlcUYFfWLELzeNFOHy2Ds/4r5pxlS1QdPAHGeCe2Mx7fW+L6W58srvKo4Yu+pREu81wjUqWk582l2un8MqCSkjFxGT1EHmxez0JXLDLd4UIqaEnmvK+3a+BCR9+RXIAfP7YqGVElF4YzJnUnSLCwC/LfbuxR+KOFp8Etsj9DkplXLwIJ7B89rSF/2yMhvI6+biSm8hT4UFqRMV1EaT2SdLPKgsL2fDSwdqTZqkSPG8hUmH3h5tQDXavDuCBBvDUu+ECA72murW+7LhLNlxF8fdSTUoauV64xrWtb/tNsU1HlE0Db4trG9gbbOGeAALPAdaYAauN9Y9tCYpDOkjtqFbPcDZLDpuygenZN/+oLjQE7L/KbpgxJarUwTEjP7tf2eHnok3lgov98RoO7lq+jV/4beNAqKTX/7JfnDsXn7rltWf1zhA9W+NX5Su0y/Yb064rmBKRmurVGh+rV1gHxkjhb15Cu1bcL+qcNTXp84PH2sfXVjJSQwn8E+kkXcozryMPgwhhfde+s1FQks/I9MWfR6NDZvCUv9qMNaS8Hh3jmulGyb2kWM9GssvkfgCC/aXI4mEqOva9J1mZfTg8QwoorTBMbaBkad0DRNK73zR+n0RwM4gvtOQKgnrr3u1uAv7wNL3aciq2Tlc/6sxL6A0dIzEGlk+rgssKtjxBNiV/OneT5O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199018)(31696002)(38100700002)(86362001)(36756003)(82960400001)(7416002)(2906002)(31686004)(6512007)(66476007)(41300700001)(8936002)(66946007)(8676002)(4326008)(66556008)(15650500001)(186003)(5660300002)(53546011)(6506007)(2616005)(316002)(26005)(6486002)(83380400001)(6666004)(478600001)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2tsUXZSOXFoTzdLcUh3RWozMVBnTXdjVnhDdDBSOHV1MGFNSjZhRnhvb1lv?=
 =?utf-8?B?RkdYK2VUWkk5V0JOS0hPSThYMGNEMzBaOFNxdWJHTmxGcUhLUmNmZGltdWk0?=
 =?utf-8?B?VytHbHJYYW5LZGQ1Q3MzdGFNT1hQeTFtbVJyNnhxSks0Qm1BdzJiUDlna1hW?=
 =?utf-8?B?c1UvUUVTRGRSZnRSUzZkQnNkVDkyajdIV2hzY0NPelR4ZytSMG81aXErMmEz?=
 =?utf-8?B?SGtMdGdhZTEyY2JaeWpSRllhNWRSWkFiK1pac3MzOHZtOVdGei9zbkcvS1Qv?=
 =?utf-8?B?aHFveVJlS1dwb3o5QmNNUUxFQXpzUUJZeitEYTVnOHdHZGFqWkFlSjdlbzk0?=
 =?utf-8?B?aVBsbHd2bFZUSjFKeEhVcUpNVEZUcnFEL0V6bkpSNFZ4SzBsMWV0N0hPUnJ3?=
 =?utf-8?B?MUFWM0dVb0ZqZXY1VzhnQzExcCtINkRlNXZwVnAyVlA5MkprV2JOaG90eFA2?=
 =?utf-8?B?VW5nYVJWZmcvRmxEYXp0bHNxRFM4NllaMFZ1aXJ0Rk1SRkg5d1BHM2s0YS9s?=
 =?utf-8?B?WmE1TjRtR0c1OEpwQ2dNOG55U05Ic3BTelYwaStFNU1IU3grUGhvREErUFVu?=
 =?utf-8?B?Z3c4MDlmRGx3NElzRXFLbFQxMDNPRE1JOHZNeDBCS0JHd0tmZ0lKdUlnVjhU?=
 =?utf-8?B?UDgzU1FCanhhalpxYk9UV2E3K29CL2NSR0oyZ0Q3OCtoWUtUUDlFWUVBUmxI?=
 =?utf-8?B?Vkl5djNYRjdEVmlPWndwN0FHSTJvUitEL3Y2Zkh0V20vcm1xR2U0QUVjdFU3?=
 =?utf-8?B?b3Uwa3QxT0ljQ3FzamFRK1ZPRGFLYTFrcjZBUkg1SnREQkd5eVYyU3FHR2I4?=
 =?utf-8?B?TDNQNDZqMll3Z2dxZjFLSUpUWG5VTzB3S091ZmtxWVExWEhmai9xZXRaNmZv?=
 =?utf-8?B?S2kydkl6UDZjbk9ReGhKc3ZmdGV5ZkRNUlJ1S1dwUFpqVDdiR3pqRERjTndV?=
 =?utf-8?B?aTB0cG1LY2JuejRNOVdxbm05MEh0VWVkSU1hNkh2QmR6eG10d3dHUzZSWnZP?=
 =?utf-8?B?MXN4UjB0MHVzdEcrck9meWszSi85SHpqc0drbjF3UW5xTE41UUdibzk5V2RH?=
 =?utf-8?B?SDEyRU9paU5aN1dJd3RBS0RLRXVIS1BwSndxaS9qTDYvRmNYYWRXM3RKd0VQ?=
 =?utf-8?B?OC85eUtiakVFYXc0dEJHazVMRG1kSk9sendHVWFqWnd5RlA4Vzd5d3JrSTB4?=
 =?utf-8?B?LzBlc1JVZy9SNUtodEJlZ2xWRzJYTEpNUmZaZTBidTFHSmJzL0duUXFGSThS?=
 =?utf-8?B?emlsRnBiOG95enBsUmhDWDNsYURSWmY4N2lhUC9oelc4UGxiSEJXWVdaVlcx?=
 =?utf-8?B?SkJGU2JpdnJQTkg3ZjF3cnNNWTlyTE9IZEpEenFpc01nVFdtQzgrVW5yaGRZ?=
 =?utf-8?B?U0ZTdDMwQllyZzJKdnJJeFkzWHp0SEdLWXhGdlRxMnRTUnpRY3htTEcvWnpE?=
 =?utf-8?B?QlVOVUZuWHAxVWJObTZHWEhyODBwVjNNS2F1Y1ZnUURwNmNCZXJoMFl3c0la?=
 =?utf-8?B?ZG5WMDBxa1pVajQ0RjZuemV6REdqdi83cEFvKzBDd2EvYkprTE1UeE9NQ090?=
 =?utf-8?B?NWFZOG1zTmxOd1RzYjFCbkxLLzBYdjV0K3VPem5tcHp3SkU3VGplc01CaGI2?=
 =?utf-8?B?TWxRT2FDNTEzRld4YytMamhaY2dqcTFUNjRuZ2hzSGVtSStPZW1YdlpmNDg1?=
 =?utf-8?B?b2R1RnNnU09ndDlJeXRQTG8wbUdCeGdKUnZMM0N4ODVsVUZXTENNc3FKSmFv?=
 =?utf-8?B?aDlESzRldFowMkhWU0hValdvZVN1ZGcrNytnZklBU2FjUFBHMmxQS2tTeCs1?=
 =?utf-8?B?SkRWSUEyNHpzUnhQQzI1V1NLRWQvWEU0d3Z3VEpxMW1KNHhJUGxJSDRvTTc1?=
 =?utf-8?B?NitPQ0UyNEVLVnprZFc3VXB6T0h3N0ZxOWw3VGhvQkNLV0hnbXM3eHJqbFVC?=
 =?utf-8?B?aXgrZ0lEdkRjd0x4TENDWGpGaHhpaFV0Q1JrdStCOUJlWHNHWjZaUEpiYXRq?=
 =?utf-8?B?SjNpMlNucC92U04xRngzb1BOZHZmZDN3ancwckNSRE92Z1gwVERQRHRMajdN?=
 =?utf-8?B?VENFZldYNWdzUTluQlg2NklldStuWGtIbnowaEo0WHRxajdhUEpDeGNaUHNG?=
 =?utf-8?B?OEFaTWFQZUFhUVZwRUpaL1c5M05jZDNhcTl4dHJSb1grWkVtTXJtdk5nMmR2?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ba9b91-5dd1-491a-7c1a-08daff929a63
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 11:43:55.0302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUE1OYuZ0uirR2bGeo3d0RWEEANDJJebKm5PERzfDJ/vydQyaCD6JYcGZISWFRyqlVFPF1UJ5Vw+wSxjgYy2CKUzAbp2BDfxo/rKjvBkEB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6745
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 1/25/2023 6:22 PM, Vidya Sagar wrote:
>
>
> On 1/25/2023 8:31 PM, Wysocki, Rafael J wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 1/25/2023 2:38 PM, Vidya Sagar wrote:
>>> Many PCIe device drivers save the configuration state of their 
>>> respective
>>> devices during probe and restore the same when their 'slot_reset' hook
>>> is called through PCIe Error Recovery System.
>>> If the system has a change in ASPM policy after the driver's probe is
>>> called and before error event occurred, 'slot_reset' hook restores the
>>> PCIe configuration state to what it was at the time of probe but not 
>>> with
>>> what it was just before the occurrence of the error event.
>>> This effectively leads to a mismatch in the ASPM configuration between
>>> the device and its upstream parent device.
>>> This patch addresses that issue by updating the saved configuration 
>>> state
>>> of the device with the latest info whenever there is a change w.r.t 
>>> ASPM
>>> policy.
>>>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>
>> If it is a bug fix (which I think it is), a Fixes tag should be present
>> here.
>
> It is kind of a bug fix but I couldn't pin point to any particular 
> commit that would have introduced it.
>
>>
>> If the reporter's names are known, Reported-by tags should be present
>> here too.
>
> I was experimenting with the error handling code and happen to find this.
>
>>
>> If anyone except for you has tested this patch, a Tested-by tag should
>> be present here.
>
> Only I tested this patch for now. It would be great if more 
> verification is done on this patch.
>
Fair enough.

Please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this patch.


>
>>
>>> ---
>>>   drivers/pci/pci.h       |  4 ++++
>>>   drivers/pci/pcie/aspm.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 44 insertions(+)
>>>
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>> index 9ed3b5550043..f4a91d4fe96d 100644
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -566,12 +566,16 @@ bool pcie_wait_for_link(struct pci_dev *pdev, 
>>> bool active);
>>>   void pcie_aspm_init_link_state(struct pci_dev *pdev);
>>>   void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>>>   void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>>> +void pci_save_aspm_state(struct pci_dev *dev);
>>> +void pci_restore_aspm_state(struct pci_dev *dev);
>>>   void pci_save_aspm_l1ss_state(struct pci_dev *dev);
>>>   void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>>>   #else
>>>   static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) 
>>> { }
>>>   static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) 
>>> { }
>>>   static inline void pcie_aspm_powersave_config_link(struct pci_dev 
>>> *pdev) { }
>>> +static inline void pci_save_aspm_state(struct pci_dev *dev) { }
>>> +static inline void pci_restore_aspm_state(struct pci_dev *dev) { }
>>>   static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
>>>   static inline void pci_restore_aspm_l1ss_state(struct pci_dev 
>>> *dev) { }
>>>   #endif
>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>> index 53a1fa306e1e..f25e0440d36b 100644
>>> --- a/drivers/pci/pcie/aspm.c
>>> +++ b/drivers/pci/pcie/aspm.c
>>> @@ -151,6 +151,7 @@ static void pcie_set_clkpm_nocheck(struct 
>>> pcie_link_state *link, int enable)
>>> PCI_EXP_LNKCTL_CLKREQ_EN,
>>>                                                  val);
>>>       link->clkpm_enabled = !!enable;
>>> +     pci_save_aspm_state(child);
>>>   }
>>>
>>>   static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
>>> @@ -757,6 +758,39 @@ static void pcie_config_aspm_l1ss(struct 
>>> pcie_link_state *link, u32 state)
>>>                               PCI_L1SS_CTL1_L1SS_MASK, val);
>>>   }
>>>
>>> +void pci_save_aspm_state(struct pci_dev *dev)
>>> +{
>>> +     int i = 0;
>>> +     struct pci_cap_saved_state *save_state;
>>> +     u16 *cap;
>>> +
>>> +     if (!pci_is_pcie(dev))
>>> +             return;
>>> +
>>> +     save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
>>> +     if (!save_state)
>>> +             return;
>>> +
>>> +     cap = (u16 *)&save_state->cap.data[0];
>>> +     i++;
>>> +     pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[i++]);
>>> +}
>>> +
>>> +void pci_restore_aspm_state(struct pci_dev *dev)
>>> +{
>>> +     int i = 0;
>>> +     struct pci_cap_saved_state *save_state;
>>> +     u16 *cap;
>>> +
>>> +     save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
>>> +     if (!save_state)
>>> +             return;
>>> +
>>> +     cap = (u16 *)&save_state->cap.data[0];
>>> +     i++;
>>> +     pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++]);
>>> +}
>>> +
>>>   void pci_save_aspm_l1ss_state(struct pci_dev *dev)
>>>   {
>>>       struct pci_cap_saved_state *save_state;
>>> @@ -849,6 +883,12 @@ static void pcie_config_aspm_link(struct 
>>> pcie_link_state *link, u32 state)
>>>               pcie_config_aspm_dev(parent, upstream);
>>>
>>>       link->aspm_enabled = state;
>>> +
>>> +     /* Update latest ASPM configuration in saved context */
>>> +     pci_save_aspm_state(link->downstream);
>>> +     pci_save_aspm_l1ss_state(link->downstream);
>>> +     pci_save_aspm_state(parent);
>>> +     pci_save_aspm_l1ss_state(parent);
>>>   }
>>>
>>>   static void pcie_config_aspm_path(struct pcie_link_state *link)

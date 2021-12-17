Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E783478B8C
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 13:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbhLQMiS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Dec 2021 07:38:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:33349 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhLQMiP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Dec 2021 07:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639744695; x=1671280695;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PmMmGHnXY95V8hSH1g1M2tLWZkaaPmAlLzjCFhIqRwY=;
  b=D57DzQE1rIg9N8zajsI7ySjSl46VUck+AGYqU/H3rCVYHrGTDrUA5ect
   xnmpZ3VDYvVbgOtRE6aMsGqPucu6p/ile/T67c4SiZSoxeLsscj4c/q/c
   NgYkme8JFlGXYk2Wi56fB9o7/dQNYt1kX8C56pnFOag5rjYuIc8wPNXPa
   1Or4wGCflKaYwV1ii86Cf3ffY01F7rYPcir6DgLoU4SFPq6P2dIvLQeke
   aHRwIPtCAA7ENHbtWLb+XS6Qblf68oXKWQP5QK1Vv9mZtbrUbyNzpU4HR
   qkay6N+uG18ekXCphNbJmJaIKici3bXSopxNMdrBdueiqF5WvkuLF4Bqy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="219759301"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="219759301"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 04:38:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="506751345"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2021 04:38:14 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 04:38:14 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 04:38:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 17 Dec 2021 04:38:14 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 17 Dec 2021 04:38:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdeGFkcHmg7ActScRYZ6d0naJtaAS3eqsq2twz6cclT0nasgCzn9VguLbNzW9tKsPQLed5gyYGIwTRTcCx0JJ0qlnxsvs8njTkaS4XPM9vneEYk38hWnwQ2XKTnJAhgjODEKg7bN/QKHxrUuduZgQgCR5ddRYSen2Bre7HnqZLAGEU5SyDSFvmHntxgnSTEfs1DC4EXcmp0x4QWvdXT7O4aefElRUQuqEslME/5CMrKNZmQNBnHMvFssOBnq7kaXfZKgyqUqMz/C8YNMULZj+Df9moDiyo3fXtBu1JdgrAEXXhN4PrOq8tM2IZG1Pj6UNOUtbaGeM8vtZIj5izlxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P260rZ0hr/R+GuPskSm1ZOcwu6f4qQmvCgr7wqPNYA0=;
 b=Tu94oR8MuHPfha0gWuNuEmVl8Lwt1ubDScD/nCAFOtywtYcVFSXcvCqioVeMtxpGQ3eNgH4pYVqVJHzvk3XftVMM+ObiHnLMWyIhjtMClWDZcVhqnVh18NEXzFmXVOB2uQbWDzOtxlVN0G1hukcjn6+EzKL5fKHuENc6rrqt4o4OYkhVYbw67zPK2ndcpiFoH6BLHNZf6cE4sJz5A7XrKt7C5TrAlXusQsaDoiyGJl0720t1FwXhu1OxuCyY7cb3T37BvvjLiophnihxGswzFenovSjjKIHwgZjQ4syhkZnquz4VgGLI4m3KJj4qADJDKOHM99W6aTiHS+vIk1XmxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM5PR11MB1292.namprd11.prod.outlook.com (2603:10b6:3:7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Fri, 17 Dec 2021 12:38:12 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::54fb:8c9f:670:3658]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::54fb:8c9f:670:3658%4]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 12:38:12 +0000
Message-ID: <6e98eced-9882-2397-663e-94470c88ec48@intel.com>
Date:   Fri, 17 Dec 2021 13:38:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] PCI: Add support for VF Resizable Bar extended cap
Content-Language: en-US
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20211215141626.3090807-1-michal.winiarski@intel.com>
 <20211215141626.3090807-2-michal.winiarski@intel.com>
 <YbqGplTKl5i/1/kY@rocinante>
From:   =?UTF-8?Q?Micha=c5=82_Winiarski?= <michal.winiarski@intel.com>
In-Reply-To: <YbqGplTKl5i/1/kY@rocinante>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0253.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::6) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcc2b172-5b25-4cfd-9147-08d9c15a1686
X-MS-TrafficTypeDiagnostic: DM5PR11MB1292:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR11MB12924DED7B2B88F9A87C9A0B98789@DM5PR11MB1292.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0MpL1yEXRtCaSnJDy7UwalIBU5ivA2Rbc5Vxi8y8+S3FZksOKoWLIjNOxs2RBY8LzkQVLCOipprfweRw+mvzBXozb7LG/OBpczcW5qJEBhKhAdJEe7GaDHI3Ce6em3fD5J690uaUCdgiN5L4lqa4NkCx349lxx/fHxheQpbRnT7kZgT/wldTLq9hyuLAp2D/ZVhWR7j7oyrAJCV2ni+OD4nAiUirC7ZzMtEa/DgBF3RoaEIHYiMKYqfiEYMWxtYB+4KdajYIbQRfm4/mP+OLoEoTStWbY12Enot1VbZfCNw3lF5dB5vikS6Ba7BqFqrVVdv9Lr41hZyO2WA+HUaCcn+BcwJkqZNaiTycdaSEFXMNjDGmqTTX6l59jpG1bvQiiHSbLAuiNPdkbSFPlnFA70pRr1g8++0M0dIc9A6Gt6Kdke3CjnP7hfBItnTHBL+ABTZtPB0Mmploa7e6GhtyfPiPyi0LIrJ8eeWIhIE96o0MIYXT5y/zq2KuQb07Tq77O7r3v+kFeMsL5S+bGRH3wHObFWEuu1nquK5LZMfXXhVn0gGnnh4xnpOj0DI4NHbjOqPKjy206pLz8d9FTdawF+30GFkAwewDe/1h4Nqh/blfDS5yomnWqeYwTn8q+eIvtVwbTzvPwTMRX42Pbzb7mdIsUUWaZlsSMr8m5oLcE62XUDbU39dXnunV7VY9Q2oCXJztylo/lsPHY39eQIkOCw7VuCkqXsEfUaIQN0aKb8XpcY7fpXKzN4Ecx9tJEpD2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(6512007)(36756003)(508600001)(66476007)(5660300002)(316002)(54906003)(4326008)(66946007)(66556008)(31686004)(186003)(107886003)(8676002)(6916009)(2906002)(53546011)(6506007)(6666004)(82960400001)(31696002)(6486002)(38100700002)(8936002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk5OaGRDSDFwNjl0OHRjak8zRFVoUHZ3RlR0NE05a2gwbk5TQ2VJM2V0aC83?=
 =?utf-8?B?QTdjbFMvdVVHbjFUQXl2VFVwcUgwdXYydE8wYTR0aStXY0s0bGk1U05NZXZE?=
 =?utf-8?B?Wm9qbEIzVVlVaTNIc3E2RzBUTStHYmU1R2ZtVXhpZ21KcytMejZkU0p5dFA5?=
 =?utf-8?B?aW5Yb3ZWUE5Qeis2QU9GNC9mRTF0NTFRQnJKUm1DZUt6bCtTb2M2cVJxeEFo?=
 =?utf-8?B?N3pxajYwV0xZWS9BN3BwSzZtSDZmTEZDdEhwckJEenY2c00rMWZ6WmVaRHE1?=
 =?utf-8?B?T3d3ZE1RTjBja21yTm9KdXdEZVkyRmkyL2p2TDhqUnYzYXBwME5pTzdIN0dw?=
 =?utf-8?B?aitydUJvTUx1b2MvMXZBbFJQWTNIOStJU0h0RHgvWGlBaEdXWXo3UkV3Mk5t?=
 =?utf-8?B?cjVUdFl2Z2xXazZINjFuS3YvUlUzcFFGNi9JWnp6dWcwT0VZa0N4N2hrRFNi?=
 =?utf-8?B?M1FnS214czNoT0N4Q3dGSmRrbFpNMGVWREc3MlRCb2RlMGg5SDMweXJOSkFG?=
 =?utf-8?B?Qmdvc0I5OTh1TVZmUHl0bkQrMEZqT2lFMkdia2ZiemNjMHhNbjFFUUV3UUE2?=
 =?utf-8?B?Z2pWNUZ3SnNpYjZjbk84T0I5eWtsWDVjUFIySlpHVEZMUFdpU1FIcUgwMFZ2?=
 =?utf-8?B?QkxPN2V1cnZDRDBLbXhReExyaXJvYWhnSU9hQ2pLKzlqa29jd3dPQmI3bEJj?=
 =?utf-8?B?ZnJTYVZoZk94WUdyYlFEZGhoNmJTUm4vU3BjYTNVOXlIM2dRZVJ3WXQzL1pC?=
 =?utf-8?B?bHpKY0xmeUtjc2lSNUFxMlBrcU9CQ09ndUd4ODh4WlA1aTRENU9vWTRJRFh5?=
 =?utf-8?B?QWtDbGwwT1BwMkY5V2RlYUFWd1JwdTd6UUViVCtydlBiV3E0ZEp3cGZmRFEr?=
 =?utf-8?B?eXdVUGVyZmdZM0c1WStEY3phTFF2RlArZ1A2akpJSjhWQlk1RmJ2THRVbTI2?=
 =?utf-8?B?R1FWUkJKZjFxZXNENDNMVmlMZjRQU0FRWHNaL3BVVjFuSnFWcjV1WlN3ZHJE?=
 =?utf-8?B?aUtjUU93bDZkVHJSRm1DV1JJMkNyTkJzOHZRcTFTazIybnVrSDk5Mk1selZo?=
 =?utf-8?B?bDlKQkVUSngvSEVISjZMaElCSHVzL2VwaWF0KzBEMDdvcFNtM0hZS3puZ3BW?=
 =?utf-8?B?Y1h1eElWQ2cwMHI3M3ZyVWsyWTUzd09EL3JSSHJMZGxDSEpQUkhQWGNibkpQ?=
 =?utf-8?B?QkZWcDN2MzhnZ25tSUNnR0JsNmJtV1dJTkdvUTdTMGxIVGdqS2FNcjFmamZS?=
 =?utf-8?B?eWtTb1kxRDVOOEo2NjgzWEhiOTNUd2E2RWZUS0dWNkgxWjUyVnZYSHlna0pN?=
 =?utf-8?B?dEVqSlA3d3ZTQ0p2V0d3ZlZQMGJraUk3VVNrU3l0ZmxIenFiSHRDQ09aOXJX?=
 =?utf-8?B?V2hxdFJFcGY0cWxCc01ickI1M2hxcVEyUmF3eGQ2OGppNStueXBnQ0JjeDJa?=
 =?utf-8?B?L0RaQ2M5aGw1OXZiTExjcmprUnE1K2RyUWFQQ1NSZXdEc3k0bVA3aW5hWkhY?=
 =?utf-8?B?NitBS2IrenV6RnZuQXdpTDZwTi9STmNNSzJRcHg0a2VRa3R1VkxEMlUyR0sz?=
 =?utf-8?B?NzNvNHczcjk2aVNvcnNZdnpDYTE0bjBvSSt2amJ2Z2tITnpUOXI3ZEZuMy9a?=
 =?utf-8?B?RDJyWGw5QnJ0SVdjVXY5aEN2UUgvcCsyRDB2NGszUVpQeFRjSDUwTllweFdm?=
 =?utf-8?B?b1RBMVhlQWxTTVdJa2JNUzNzdDFoSjkyYVRJakNRLzJzV3JCcjM3MWt2VTBo?=
 =?utf-8?B?b0YzZjlTR0VoUmtweTJiQy9rRnE5OWJpcmEzMWg3MGllcjVURGs3OFl0TThl?=
 =?utf-8?B?QlltV1d0WG1yeCtkcTZidkxsQjBVRUZDemZ2Qmltb2pJaE1GNWd1dTJvbEx2?=
 =?utf-8?B?d1krM0txZWRJVDNBVDNxYW5hc0lCL0lmVDNva3RVL3dpdnRUakhncDNkazA2?=
 =?utf-8?B?M0paaHdndVU3Q1l5cU9mY3JkR2VKWHF5SkxRKzVIMmVaaFk0aEw2SmxGZXFt?=
 =?utf-8?B?d3hUZjlYeklnUWxzM0JhdmwvUEloQUUyaGpEc2pxR09vaWlWdW9RQWZxOHBq?=
 =?utf-8?B?TEJxcytxdjEwR2VyWGdWcUlxL3J2NE9tVURkVHBJaCtYNndXaFNMcWF0ZGIw?=
 =?utf-8?B?Wm9IdjZUVGo3emVDbEgxM0JTZkJ2ajc4UlhiZ01TU2pLN2xSN2tZRjN4Q2tG?=
 =?utf-8?B?ekRtMmJYK2lGMko3MnFtYlZzREhMQkhJWEZ0MjJXK2xiU0NDYkxUdEtXdzBi?=
 =?utf-8?B?NnlmTWdKNENwZk5vZnVoU0xFYTBTNE1iWWFleklrSVU1UVlOL01mOWpWKzht?=
 =?utf-8?Q?Ryy0FHqPCkNiFlF2AT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc2b172-5b25-4cfd-9147-08d9c15a1686
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 12:38:12.1426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6VmgnX7MHe77QASMf22bQjzHaCgJNGrMLr1NfOqCe1RapOq/QmeMw/66L8DjKRQYqPCHYcMW1LokJ6iSU/pNvu0w1tG1GIjftXldQ49FpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1292
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16.12.2021 01:21, Krzysztof Wilczyński wrote:
> Hi Michał,
> 
> [...]
>> +static int pci_memory_decoding(struct pci_dev *dev)
>> +{
>> +	u16 cmd;
>> +
>> +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
>> +	if (cmd & PCI_COMMAND_MEMORY)
>> +		return -EBUSY;
>> +
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_PCI_IOV
>> +static int pci_vf_memory_decoding(struct pci_dev *dev)
>> +{
>> +	u16 cmd;
>> +
>> +	pci_read_config_word(dev, dev->sriov->pos + PCI_SRIOV_CTRL, &cmd);
>> +	if (cmd & PCI_SRIOV_CTRL_MSE)
>> +		return -EBUSY;
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>>   int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>>   {
>>   	struct resource *res = dev->resource + resno;
>>   	struct pci_host_bridge *host;
>>   	int old, ret;
>>   	u32 sizes;
>> -	u16 cmd;
>>   
>>   	/* Check if we must preserve the firmware's resource assignment */
>>   	host = pci_find_host_bridge(dev->bus);
>> @@ -424,9 +447,14 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>>   	if (!(res->flags & IORESOURCE_UNSET))
>>   		return -EBUSY;
>>   
>> -	pci_read_config_word(dev, PCI_COMMAND, &cmd);
>> -	if (cmd & PCI_COMMAND_MEMORY)
>> -		return -EBUSY;
>> +#ifdef CONFIG_PCI_IOV
>> +	if (resno >= PCI_IOV_RESOURCES)
>> +		ret = pci_vf_memory_decoding(dev);
>> +	else
>> +#endif
>> +	ret = pci_memory_decoding(dev);
>> +	if (ret)
>> +		return ret;
> 
> The above else works, however, it does trip our static analysis tools, and
> lack of the indentation makes it slightly confusing to read, at least at
> the first glance.  Thus, I wonder whether it would be possible to combine
> the pci_vf_memory_decoding() and pci_memory_decoding() somehow neatly into
> a private helper that takes a boolean to indicate whether it's a VF or not.
> Then, we could drop the if-statement, since some of the logic could live
> within the helper.
> 
> What do you think?

Sure - implementing a helper in a way that Christian suggested (the 
helper still takes resno though) should also take care of that.

Thanks
-Michał

> 
> 	Krzysztof


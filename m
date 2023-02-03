Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453D16892DD
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 09:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjBCI5O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 03:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjBCI5H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 03:57:07 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600628B7F9;
        Fri,  3 Feb 2023 00:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675414626; x=1706950626;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ggaM9hzEdKAO48xZM4qFq5gSKLkbA7skZmqwv6ZtcMk=;
  b=Cvfti2wUZmL3eU6qvUNZySl4yUpGBl5VpfzB0iOyMOVtps9xGCFsYx0L
   DBWxFCiqyNzi1iU0WCkeINAj+70ymbUUhJv+7JfdnFpbHp1pVAyeXgU/K
   kN/1GWA+I+ZXzu6mEmaDoP7g67kaEHGFCSsXUxoV0UQs75Hu0okPm+HhW
   ryWTSQgmwLm/8l833voyZUUefoekzRsSgXvINemw4Z4rDTvV/bVTBniz1
   bicHEd39n0v+SXBjW7W85BR3oOP0xwHtfMsKkBmmSBxfi3h/OdqeJoXUB
   tvHTVciakqpz8q2yEbuNGNM9My1Bq1aTGKkOb7CHVu8ugssjvspk0kp5R
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="312353878"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="312353878"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 00:57:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="729202926"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="729202926"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 03 Feb 2023 00:57:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 00:57:05 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 00:57:04 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 00:57:04 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 3 Feb 2023 00:57:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHgT1miKsMmWzpMquqwfHlnNqSBQ8vL/MsIAybBrUmKqypZe20SaA8vDFlX57hyU2V0wc6tQYywYKSBufWfByLVkfS053td3szHpgC+GQ3FrBxmi4nJlOEPgFNFq0dMClK85PyUyYissKmiB7ewEB7MwbFlQTtnAKlHxYM7DLPdxNq462RMoNg0wBB6ZdPmkY9T1gM/I+toSmG7VZQleVYFa781RbZmHoIbgrUC93KP066ZkTJodDSpLlPugXfcI/mnumDWZXWBUEuRBSAxk+RTW05VmVXdgfPphmG44xXXKqHv03X/pR7ZJz16nApyYb17USYEdoojRoV7vJtrbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7x6LbEV1yxZIPbqk1Ysof9fK4PBf1IS4Oebr6PsnSM=;
 b=Gp4RldC6BpMEI+hv3oCOz1pZXy6xYhHnvdfZ+jCJNfhTqWq4L6WBijD85YErPLU51r56885atkaM9m0q4JgM0ttew1bVYClk0+O8grfkSS0o4lJTUwqIoIL0NeC1oIz84541dbGshwEXvLNnCKcfGp+TShh+OBQyyToL3ECGkPZ3KK26XJHpaBgCOtry9a9AGP6JGo2KqFPDduiFa7zp1iSLtPAd3BWwDCnhnw83paz8TgoXLgT/AxWOx19rFrHOUp014oVzOT2HrYVWrjiRUEU9z6CVNnIo+ETKC1VGmmqqyRit42+ogCLl9U31XBesaQ9LreHWLRwbH4Y0KD782A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by DM4PR11MB5389.namprd11.prod.outlook.com (2603:10b6:5:394::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 08:57:01 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::8eb2:90e5:b496:f4ee]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::8eb2:90e5:b496:f4ee%4]) with mapi id 15.20.6064.024; Fri, 3 Feb 2023
 08:56:58 +0000
Message-ID: <3359d431-6ad1-8577-6f16-cdc17da5fe42@intel.com>
Date:   Fri, 3 Feb 2023 16:56:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 04/10] cxl/pci: Use synchronous API for DOE
Content-Language: en-US
From:   "Li, Ming" <ming4.li@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>, Lukas Wunner <lukas@wunner.de>,
        "Bjorn Helgaas" <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
References: <cover.1674468099.git.lukas@wunner.de>
 <b5469cbb8a3e138a1c709ed3eaab02d7ca8e84b2.1674468099.git.lukas@wunner.de>
 <63cf2bc3cf76_521a294a1@iweiny-mobl.notmuch>
 <c9923e59-176c-2e52-9ebf-58bb25750083@intel.com>
Organization: Intel
In-Reply-To: <c9923e59-176c-2e52-9ebf-58bb25750083@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To BN6PR11MB3956.namprd11.prod.outlook.com
 (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB3956:EE_|DM4PR11MB5389:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc88c4f-3ee0-4167-8518-08db05c49b6e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tskukh8VZggTkN1psrZQ8MSlzhFp9kDZDdNsF1VUstXUE81dhIDig1UKUpdtqnDfS+aFu08cKhhZKMJ8un+uskEXqZ82RU3j2LcciJgOsyaGIhltb+nBpuBlHFsWcct52bi2z/iq4r6lzh7sKZSnpwfK+CEBhnlN64tt2qVN7fPIY4oh0n9oTOgd1dMqe3JiLMcr1enMEkO9kK+BRLHlAAIU40KHD/TwB3eFYP/plRehpyeybY+pE3Fg3s+64tTDlHkIGdRAYLlPxXxsDw+cs70uqrc0VmpBz2i3QJeJnLkkPlnPhdqoKv/7P360v5hSDRW627T0FHe99U+yhOBk+38SvoS2Uo1zb5i3SRkDBXpe7vRCqQdaCRBE0f8k8l/TaAi5nGbZQaHFFQG92eFdn1fJcL6xkb04A3dKbVcFNvU9zfEu8hqFKVp3d2IZ5tLEgovUpQEnzKG6soyIGF+HyqqwhzcbAlq/TDkR9H0is2ChfOZUbPHeO32co15qQ0PEW7f1A/xCIFQz4FiJikyJjqPUjoV4juRjHdadebKa8yBhXsrkCIvNgLzu1Aqtbpcl9xvYfnQFJuBRMyldl0/0mD+37Wfu0Bf4pJZFtrxsxBWBKqOEp6khldXNtNxE12xZDJy27aCCML1IQkZ31mkYHUE/zSM3hwo+QqqXY2gZ00l/XYRCCmEI1Ab4pugZMaujKMybDELjP16qrS0jDfCs6pR/2AiuICo3R0OJ2AqzTVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199018)(41300700001)(8936002)(4326008)(8676002)(66476007)(66556008)(83380400001)(66946007)(82960400001)(38100700002)(86362001)(31696002)(36756003)(5660300002)(2906002)(478600001)(6506007)(36916002)(6486002)(2616005)(6512007)(53546011)(186003)(26005)(6666004)(31686004)(316002)(54906003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG1MZjBwRk9yNWVQV1JtK2k3Wm4rRENFcW9DRktFOXM0TzFteWFKV3VJZStz?=
 =?utf-8?B?MldDZ2FSMWpqNmo0clJoTHpUdDhSWnUwWTdlb1lReGRSdlF4SzF2d1Uyd2Rw?=
 =?utf-8?B?aVFzeXZNL09PV3VTeWZWMlEvRjZ2MlREOXBOR25pTHJKTXZ1c21qRnFWWERD?=
 =?utf-8?B?YzhkZ0lyd0pWTTVSN0pFTEhlQXFyTFhSdlNPaHltd2JtSDNSQ0NiQzBLMU1v?=
 =?utf-8?B?Z1NGNlFkK2lrN2xIRG95Q2ZQN1dseWV1L3FIbmtjS0dobkR1aXVYbVRwQjdT?=
 =?utf-8?B?NjhQdmhaRU55RXIxa0sxcTMvTi9VcU44eVBnN09HY1JTdmRlOVBMK0VzZlFr?=
 =?utf-8?B?QXVaSzA4M1VoMzVhRUVzRDYyQXNMM29VQnlzOHF6dHhxSEVmUkJtMUJwaEU4?=
 =?utf-8?B?eC9yaFpoYmZUKzJvK0ZRVzNjcHluMEFNV0UwSVFFV0FmekxIN2tQZlYwNVBN?=
 =?utf-8?B?VmhERFJSdmZrWUlEOTl0OEwwMUlOb0FVK3lTOXo0anBZZXNRVmJjSGVrdFdR?=
 =?utf-8?B?WWtGTW1lT0Q5THhQOGhvVTBwcTB2YUx3bE94eVVaTkpjU21xanZsUUZPQWVT?=
 =?utf-8?B?U1dLUUdNYmZSTm96S3lUUHFSbmdrNXdURElEQTdBQXg5YVhEQUVIeEU3VlM2?=
 =?utf-8?B?eUdMNkNnaHAzRFVHUHVhcVlDMDZQYkJvZ3g0QnVqNUMvQ09HYzJwYTI1SGMz?=
 =?utf-8?B?Z3VYL2ljdHRBeEQrWG9SZnY3NEV0YldhR2phbDQ5VWkvR3hESGY5UWtjSzIz?=
 =?utf-8?B?NlByaWd6cXBkVk5mMjZDeHFIREs3UmY5NFAyR3dDTEE4OTVPT3NVT2tubHBB?=
 =?utf-8?B?Q21SWG45ZnZYQ0w1MHZ3L0ZTbHcyclEwUm51KzlBTlBvWkQwVzJqSmdZeEtq?=
 =?utf-8?B?b3BzWkxVeFBrSFZhZURDSjBxc3pRdWhDc25LMGIxemtsRk9EVnBWVUFrYllq?=
 =?utf-8?B?S1dOWXUrcnNqQittOWRCSG9tbE1uTEI1dzNsbGZ0eEU5ZE5LYVZseThDMXJT?=
 =?utf-8?B?cTh5a0c1MjVOTndXK2ZXUEtYS1lCQ0pyZWxCb2Z2RDlZYkJIM24vUHovcjhX?=
 =?utf-8?B?ekJOd3JTZHF6bnFiNDI2YWxNemYyRE11YXVaUlR3dUMyWUExcURnRUNBQlZC?=
 =?utf-8?B?OWtIL0x0V2xWZGpZUFZiazhwM3hEbGxncUMyOVI1V2VzcGZoZ29UMVIyRDBk?=
 =?utf-8?B?LzRkRFIvdUEyUE9adkVkb0xyMU1KWDdvYVJvWlMyOHZOOVRvNDdIQUZWdDFK?=
 =?utf-8?B?MW5NUlp5dXZ1WEV5WWJEcWNnVjZWWTFlTnFDYURWZm5UdUJRTzNqV212UUYr?=
 =?utf-8?B?NXRWcTByTmxoOTQzanZGLzlka3d6Y1dmZDBrYkkvUFpmWVR6cS9CalJKS0NJ?=
 =?utf-8?B?QjY0MC9lWXJuL3dHZ0plUngxOEZUTG9tdE5ISXBIdDVhNS9JMzhHQlk1MDNO?=
 =?utf-8?B?eDUwWUNtYml5dURYT3FVMHJPWXFrRUR2RVB5bWthWkxEaTArbFVrVHBvaFZy?=
 =?utf-8?B?ZG04bGlaRE9aaFZuOGhOZGJURm1KaENrVFk5VDhEWDFOWVpFMWxXWFd1TmVO?=
 =?utf-8?B?RVQxV2JrVnZ6TGExdzhPS2NiRm5YS0ZYZFF0ZWk0RUhPMTdZRkc4V05MSjVB?=
 =?utf-8?B?RlVnalJyd1NuYWRISzdLK1pQR0JlUUFyYXAzTHNHNUJPY09oVWE2T0tQNFdF?=
 =?utf-8?B?clJ3U2IvSVByaHhnNHkrbEFFYkd4U0FGZDV2Y0lBOGFWVkRKZGRodDFhaDBP?=
 =?utf-8?B?YjZPRitvZExhRUtZczduVWJNbGdEMi9iRjdHaDZ2NzBuNmJXYXRhdjNyTmdS?=
 =?utf-8?B?MWg0RUo1N1NvOElIWExaVXlaK0J1cXpjZ00wNTlyNEJWVVA4by8wb25jY1JF?=
 =?utf-8?B?Q3hHbWxMMjROdUZQUWoyYjZkRjRSbXBZQVNNclpjYWJuR0M5ck1vWjlPcVFE?=
 =?utf-8?B?c0JIU2syQ2VDWVJKTENhYjJocStZTytuZ2R0OWI1alJXcXVId1V2TzJJVmN2?=
 =?utf-8?B?WGhoVjBoeVNiNld5UUUzbGhWUGc3NVZoZVdWcEZ4dGdndzE1QXk3NGJMSTFC?=
 =?utf-8?B?dFZEc1ErNUdaSlZVeHVVT3NwNGlESDdNbzhQY1hvT0phVnlxekY3c1RJNUpu?=
 =?utf-8?Q?xKwj3yHJlKfNbg9TaRORRxqzL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc88c4f-3ee0-4167-8518-08db05c49b6e
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 08:56:58.6247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PshSqQa6IHECvZcCMNo882EuuCf9AiN6z747UDFE9daQBLhglpscLD/yDGykSFIaMVTLyFY3KkpLDmpGoN/UGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5389
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/3/2023 4:53 PM, Li, Ming wrote:
> On 1/24/2023 8:52 AM, Ira Weiny wrote:
>> Lukas Wunner wrote:
>>> A synchronous API for DOE has just been introduced.  Convert CXL CDAT
>>> retrieval over to it.
>>>
>>> Tested-by: Ira Weiny <ira.weiny@intel.com>
>>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>>
>>> Signed-off-by: Lukas Wunner <lukas@wunner.de>
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
>>> ---
>>>  drivers/cxl/core/pci.c | 62 ++++++++++++++----------------------------
>>>  1 file changed, 20 insertions(+), 42 deletions(-)
>>>
> 
> ......
> 
>>>  static int cxl_cdat_get_length(struct device *dev,
>>>  			       struct pci_doe_mb *cdat_doe,
>>>  			       size_t *length)
>>>  {
>>> -	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
>>> +	u32 request = CDAT_DOE_REQ(0);
>>> +	u32 response[32];
>>>  	int rc;
>>>  
>>> -	rc = pci_doe_submit_task(cdat_doe, &t.task);
>>> +	rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
>>> +		     CXL_DOE_PROTOCOL_TABLE_ACCESS,
>>> +		     &request, sizeof(request),
>>> +		     &response, sizeof(response));
>>>  	if (rc < 0) {
>>> -		dev_err(dev, "DOE submit failed: %d", rc);
>>> +		dev_err(dev, "DOE failed: %d", rc);
>>>  		return rc;
>>>  	}
>>> -	wait_for_completion(&t.c);
>>> -	if (t.task.rv < sizeof(u32))
>>> +	if (rc < sizeof(u32))
>>>  		return -EIO;
>>>  
> 
> Sorry, I didn't find the original patchset email, only can reply here.
> Should this "if (rc < sizeof(u32))" be "if (rc < 2 * sizeof(u32))"?
> Because below code used response[1] directly, that means we need unless two u32 in response payload.

Sorry, at least(not unless) two u32 in response payload.

> Thanks
> Ming 
> 
>>> -	*length = t.response_pl[1];
>>> +	*length = response[1]>>  	dev_dbg(dev, "CDAT length %zu\n", *length);
>>>  
>>>  	return 0;
>>> @@ -546,26 +521,29 @@ static int cxl_cdat_read_table(struct device *dev,
>>>  	int entry_handle = 0;
>>>  
>>>  	do {
>>> -		DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(entry_handle), t);
>>> +		u32 request = CDAT_DOE_REQ(entry_handle);
>>> +		u32 response[32];
>>>  		size_t entry_dw;
>>>  		u32 *entry;
>>>  		int rc;
>>>  
>>> -		rc = pci_doe_submit_task(cdat_doe, &t.task);
>>> +		rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
>>> +			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
>>> +			     &request, sizeof(request),
>>> +			     &response, sizeof(response));
>>>  		if (rc < 0) {
>>> -			dev_err(dev, "DOE submit failed: %d", rc);
>>> +			dev_err(dev, "DOE failed: %d", rc);
>>>  			return rc;
>>>  		}
>>> -		wait_for_completion(&t.c);
>>>  		/* 1 DW header + 1 DW data min */
>>> -		if (t.task.rv < (2 * sizeof(u32)))
>>> +		if (rc < (2 * sizeof(u32)))
>>>  			return -EIO;
>>>  
>>>  		/* Get the CXL table access header entry handle */
>>>  		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
>>> -					 t.response_pl[0]);
>>> -		entry = t.response_pl + 1;
>>> -		entry_dw = t.task.rv / sizeof(u32);
>>> +					 response[0]);
>>> +		entry = response + 1;
>>> +		entry_dw = rc / sizeof(u32);
>>>  		/* Skip Header */
>>>  		entry_dw -= 1;
>>>  		entry_dw = min(length / sizeof(u32), entry_dw);
>>> -- 
>>> 2.39.1
>>>
>>
>>
> 


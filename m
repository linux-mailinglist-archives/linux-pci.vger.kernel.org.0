Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E58617A4A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 10:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKCJy2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 05:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKCJy1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 05:54:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFBCBF8;
        Thu,  3 Nov 2022 02:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmFmhSXYRm2DsfgietR9CSUENQxOZP6dg7Iq8W8reRSPYY4zooFB9HOhVAL+GXd9+Xhg07sIMQ3mktu6hxkwja+QiTC2fBkc3l0xE5YCejmtYED+yWbEFgeo7g7i4ma7CefGwr88TW/3lWmnyMdjF1BtMuYCLi59vTU3NYg7MMaW+eSBkq2QoqV5WnNfii4CIKExMUzfJAvBbmpUHY3WZZ70Jql88JnQhvBQ5fYPME5RRCUBFl8H7745PfL6FGcDXmmuAVrLR7GvKVPFSSW3puO+T+fr6VxVAVosZ5UKEF/SZPmJOSQO1yZfBy4hC1XXvt7aFrm2/W8qA2pBCKWttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUqgxmP2OlChii2KYBIvq54UANsdq/0Aqz7MX9pcmMw=;
 b=bAjYSup1ZCJtIOn7uXbPNhWbGIamR6CmNQRzLwAN3maQbJlfDugM7BmuD/SozZ1ADQ75z8lu8XmpEkn8c/uW2QMiQySzm+fy6zQOrPCLFqly/r6kkvGPQ1nj84SB9mxRH41Mbh7tlqBTrjbjRPP8G/nDuT9gCONzLhc0pWKJD2en/yQ7qvrnVa3q/v4+InuwjrPtziYhequnX4pub61O5kU+D4PeLcqVOX81oMrUhhLraT1jwjigXiX3cOME8+UOdQ+ZmdZEh2ss6y9E4eNOgArWfcoihYQ5thS4kKA1U+Cq7wK2pagIH0hqD/eMiB01KFYfTCuTBviALWzHdHUV4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUqgxmP2OlChii2KYBIvq54UANsdq/0Aqz7MX9pcmMw=;
 b=uAJuXbjBaxba9b2zKZd0fS/JUyVU86f3F+oTdqaS6XebOA9ub8rdCmHyYN+sUHnylbo+ArHh/mYNGFGf4WC3EEIWC7piayteEaBhQQ3EmSqtrG1hGxiH5tgVHiXr0SRd/Vsqo0D2VUwlIpnX83BJS4jP5JXFnMQgTXBzJqMrZUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 09:54:22 +0000
Received: from BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::d2bb:6bef:338:aab9]) by BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::d2bb:6bef:338:aab9%3]) with mapi id 15.20.5769.021; Thu, 3 Nov 2022
 09:54:22 +0000
Message-ID: <daba3022-2c3f-dd5f-925a-77da5293e308@amd.com>
Date:   Thu, 3 Nov 2022 15:24:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 4/5] PCI: endpoint: Use callback mechanism for passing
 events from EPC to EPF
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com
References: <20221006134927.41437-1-manivannan.sadhasivam@linaro.org>
 <20221006134927.41437-5-manivannan.sadhasivam@linaro.org>
 <b6001af6-4c41-a678-b3cb-4c1d874425bf@ti.com>
 <20221025113933.GC221610@thinkpad>
From:   Kishon Vijay Abraham I <kvijayab@amd.com>
In-Reply-To: <20221025113933.GC221610@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::16) To BL1PR12MB5827.namprd12.prod.outlook.com
 (2603:10b6:208:396::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5827:EE_|DM4PR12MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: 16625dbd-bdb7-4c3d-4321-08dabd816254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZacQ1ipgmPSEGX1+3tqgdU/9FmS96Wob2H6mCQMOLLROVqMrrv1WpBXJQKIZGdV34v2CnwCR7O/PwY/6jArKslzxyVhtJwTaGsEHvH35HeBXDJzPerr5KEP3hJVfqEzFK+KHkoJinUiB4QTa918BOYKl/rdw5XgQxi2BwDCIwbJYOCxf3Rnuyoa1SBaiQ6iYn8JUFxtNN0+qbtGkTroyHts0q6cWuv5OHf88tNELcDCpQas6ZAOEWPqGHDsthKXzD+ZLiwieUvAZLXgLZ7h4W9LXNf/YCd+iuMKjN4VHJmzDxOqqErftBqOLTn7lzKtOUmA7aYroipMP8PYyfLt90WezCwnVhhqVMqAvNSvILJhZkURN6exIJUlyzQ5ttuKrPfe3HpVlKFK6HPvjh/qKODxpZNcb73VM/1/qpyIgR7vniSnYmQOLrI+IO49lrp8N6PeMpTwYRUK+bx2BomSq60FkEEou/TvNQQTq87qk+9Q4QYRiTYMAFV2RN7DIp8wG2/8eTXpp+HdBkcUNOuzYIcU3NlIRA1x4GeuJSXNsLq9qa5uZRcVG4BAQw3qdn4xi5pTbyMsUZ8fL2y1hcYvOy5Wm6Gw3E+K0ixleNUujbBkotMA6mHS2J4F5jxlfcrNJY+mdrEFn84zOu46Y6AyffdyIoveaxtcoOaez17Vi0fkt+4vUlL3kfMeV8OYTBvHQ2impK15xD07poZgJ/jeQ2m6/aOAum0HteZGmkWteXa9vR5fBCGOdGNEB0mM/EZs8gcbHt1muG4RUUfhuwqDPhC1rAoD0GYNTgO57Za2WDPY/iqkaS9h8M7fiRku4Haj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(8936002)(478600001)(6486002)(31686004)(6666004)(6916009)(316002)(36756003)(31696002)(41300700001)(66556008)(26005)(6512007)(66946007)(6506007)(4326008)(66476007)(8676002)(53546011)(186003)(7416002)(5660300002)(2616005)(38100700002)(83380400001)(2906002)(90184004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEpEdVFVczB6OXE0NUtIbWladEJvK1V0S0paamQvMVRrSERGOGs3VFlhbXJM?=
 =?utf-8?B?aE1PSUtYenRSejdXVm95eXd4L1lwWmFMbWZyNmhGV0F3dXh5bXo4ayt3VTdJ?=
 =?utf-8?B?OUd4RDBHYlFzYkF4V3B5QWNPNHN0eXRlS1FTbTZ4ZWRyV3RuemhOdkp1YmlP?=
 =?utf-8?B?Y25EZFJqczNCbjgwbXJ1ajF4aHZzNGJIdlFodTJrajh4UWM3Zm5hVVVzT2tR?=
 =?utf-8?B?N3RlOGhGdmpZdzBsdkUvNTdWV2FKbFlpQU9VVmpnbFRMakdHSElha01jWklR?=
 =?utf-8?B?WlF5M2x5ZGFobnNPUEJHUzJYRkRHaGd3WEFlbXhQc29INVl2ZUdHOGhDU3gv?=
 =?utf-8?B?UFFnV0l0Tko3OXM0dG12akRWR0E1N0NYWVc3VlBVak9xdnZmai9mNVpzZjhw?=
 =?utf-8?B?a2k1Y21mbC82bHhMOTdMOEt4VVA2eU9JaHdQTDdXbEtmYkNuOXI2cVR3dVdz?=
 =?utf-8?B?dHUrS0F0NHNUaUs1VDdEOFVqeVQ1NkRZWXRCNGt5UEhUUkt2RGg4VVZLWGVH?=
 =?utf-8?B?bkhYYWdZT29CM3Q0Z291SGJRMzhDeVVlWVZqTGgyT2QwVU1kbXh5WThneWZ4?=
 =?utf-8?B?Z2lNQkhPM0g2L3pwMVVqZ2x6VVMySXF2d3daVXZvV01XeERvdlZSWGxYb1po?=
 =?utf-8?B?YlViclZVQlZWUlhlUzJ4L2JPMjRTWjNyYW5mazk5VkgxajNCV2toM0xFYkt1?=
 =?utf-8?B?SWE0V2wrTU1kWm0vaDduWWhnRFRXN2kxVjZRdlpZVjNrOWZnSSs0WTJuZUNE?=
 =?utf-8?B?MmlFdFRrTFN2NnpkQnh4R2ZKbkIxbCtodnRFdGNkUzF0V083alJ2SXdLUVdW?=
 =?utf-8?B?eis4Uzd3Tm9sMkpGQUk5QTkyeHd4M1NmUGpkM3gwMkl0NnMxbzZmR1drM2dX?=
 =?utf-8?B?VytzRk9RbGJ4VTgwZ2M0VmVnK0hLZ1UvRFY0T0I4d2tBRFFFakQvVEdlTHMz?=
 =?utf-8?B?TzMxRFRIOVdTZlB6R1RwM2llclhUZVRVRjJvdkVUY3BLYzVzOXNHRVdlVzk1?=
 =?utf-8?B?WHNoRVJBTWtRVjdYdUt1R0RGQkY1UGJaWnN2U1krSDNKL1ZqaS92NUlwK3lk?=
 =?utf-8?B?SmdYdXFxcDJ3cXJlZGhtN0U1UWp0MGpPVEtKNVBqcy82QzE2aFV0VUJCUXc0?=
 =?utf-8?B?WU5QaXd1ZGc3ZzNZVURvSE9FUm5qZkREbmY4RnhUSyswdE9mY3Z5VTkralBu?=
 =?utf-8?B?bnZBZjN3bTFZbkJwWHYwM2xHUXkxNUp0SDYrV0FJS0JGbGtCTWFLOXVNbFVw?=
 =?utf-8?B?RFhDbFhqKys4TGJHTVhoVmQxQmp2WkRqaGd0bVAyUGFUei8zZDNTNDRaN1Zx?=
 =?utf-8?B?T2ZHYXROWWhhQXQ2MUVGeEZndjNiUkg3M09wQnJMTWJ5N1RlWHdnbHpXNytl?=
 =?utf-8?B?R2Nid1NRcXROaS9wejlFbllOOGxyUCttQmVNREhya3c1V0ZQY3duYWRlUTZu?=
 =?utf-8?B?NFdRc1g2dmZzRWRaZ2lDY2FHYUhuT0dLcUNDWnhCa0VWaDBZbFJZek9Mb0d4?=
 =?utf-8?B?TWlCMlBSdU10UlYrdGwvV0NvNDFNVUhNM0QvSy8vci8yZUFSOEhDVDhqeEhD?=
 =?utf-8?B?NlRLZFlHajFBUjBLTkFOZmk2RlFyZTdJeUlCV0wyR0FUcnJXZUNwRXFSZWF4?=
 =?utf-8?B?UG81OVM5Uzl4M0x2KzhlKzZkcjlZU21tVXk0Q1cyUkxUYk1MRWZHayt1Zi9R?=
 =?utf-8?B?VzQ2Q1l2Y2dMcXlic0x1cmVTVDZ5b1pMVXRYNXo1eGVsZHY1YTFEZFcrajll?=
 =?utf-8?B?cGU3eFV3YnhyTXYrZ2E5MUgrRVpMaGI0clJZQUpoM3ZHQlBwYzl0Z2JVaUpo?=
 =?utf-8?B?Kyt0YTl0WXhkdS9ISzVxUE5hMDVKSU84VEpTWjFXOUovTVo2RFpHVWFPSWx5?=
 =?utf-8?B?L1JkWkFvbU9TWWUrQllRcFYyVFFlV3RqRXdWQUpaY05wNndUZGVONDB6WDVL?=
 =?utf-8?B?YkFUK0V0ZmhTTys1K2JDdjR6ZUVaZTM5K0tmV25iLzRacnkwU2V5V0JXTjJO?=
 =?utf-8?B?b3dRNmlvK3BxMmNVUTFPU3gzNTMySXhGV3VIUnJKQzB4ZnlhNFhOWjFzWnE0?=
 =?utf-8?B?NDYvK3dQa2RsL0hGNkppTWVkUUZPczdNRTlNR1o2ZVIzemdiL1BTcmNlNDdq?=
 =?utf-8?Q?NvnPWB/m2YBKfV10jOwKk4E/P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16625dbd-bdb7-4c3d-4321-08dabd816254
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 09:54:22.7434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4nAQUUG+feAQkFpaA9FArlynhSMojYgdRv1PO4k2UxWYY3LlsfC68oZ7nCf2gTcYKMXpDPktHUPP3zgrpLgmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mani,

On 10/25/2022 5:09 PM, Manivannan Sadhasivam wrote:
> HI Kishon,
> 
> On Tue, Oct 11, 2022 at 06:27:37PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Mani,
>>
>> On 06/10/22 7:19 pm, Manivannan Sadhasivam wrote:
>>> Instead of using the notifiers for passing the events from EPC to EPF,
>>> let's introduce a callback based mechanism where the EPF drivers can
>>> populate relevant callbacks for EPC events they want to subscribe.
>>>
>>> The use of notifiers in kernel is not recommended if there is a real link
>>> between the sender and receiver, like in this case. Also, the existing
>>> atomic notifier forces the notification functions to be in atomic context
>>> while the caller may be in non-atomic context. For instance, the two
>>> in-kernel users of the notifiers, pcie-qcom and pcie-tegra194, both are
>>> calling the notifier functions in non-atomic context (from threaded IRQ
>>> handlers). This creates a sleeping in atomic context issue with the
>>> existing EPF_TEST driver that calls the EPC APIs that may sleep.
>>>
>>> For all these reasons, let's get rid of the notifier chains and use the
>>> simple callback mechanism for signalling the events from EPC to EPF
>>> drivers. This preserves the context of the caller and avoids the latency
>>> of going through a separate interface for triggering the notifications.
>>>
>>> As a first step of the transition, the core_init() callback is introduced
>>> in this commit, that'll replace the existing CORE_INIT notifier used for
>>> signalling the init complete event from EPC.
>>>
>>> During the occurrence of the event, EPC will go over the list of EPF
>>> drivers attached to it and will call the core_init() callback if available.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>   drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++-------
>>>   drivers/pci/endpoint/pci-epc-core.c           | 11 ++++++++++-
>>>   include/linux/pci-epf.h                       | 11 ++++++++++-
>>>   3 files changed, 26 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>>> index a6f906a96669..868de17e1ad2 100644
>>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>>> @@ -826,20 +826,17 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
>>>   	return 0;
>>>   }
>>> +static const struct pci_epc_event_ops pci_epf_test_event_ops = {
>>> +	.core_init = pci_epf_test_core_init,
>>> +};
>>> +
>>>   static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
>>>   				 void *data)
>>>   {
>>>   	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
>>>   	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>>> -	int ret;
>>>   	switch (val) {
>>> -	case CORE_INIT:
>>> -		ret = pci_epf_test_core_init(epf);
>>> -		if (ret)
>>> -			return NOTIFY_BAD;
>>> -		break;
>>> -
>>>   	case LINK_UP:
>>>   		queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
>>>   				   msecs_to_jiffies(1));
>>> @@ -1010,6 +1007,8 @@ static int pci_epf_test_probe(struct pci_epf *epf, const struct pci_epf_device_i
>>>   	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
>>> +	epf->event_ops = &pci_epf_test_event_ops;
>>
>> Doesn't this ignore epc_features input from the controller driver?
> 
> Sorry I don't get it! epc_features from the controller is acuquired during
> pci_epf_test_bind(). EPF probe doesn't have any visibility of the controller
> driver.

That's right. "core_init_notifier" from epc_features is used, so this looks fine.
> 
>>> +
>>>   	epf_set_drvdata(epf, epf_test);
>>>   	return 0;
>>>   }
>>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>>> index 6cce430d431b..ba54f17ae06f 100644
>>> --- a/drivers/pci/endpoint/pci-epc-core.c
>>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>>> @@ -707,10 +707,19 @@ EXPORT_SYMBOL_GPL(pci_epc_linkup);
>>>    */
>>>   void pci_epc_init_notify(struct pci_epc *epc)
>>>   {
>>> +	struct pci_epf *epf;
>>> +
>>>   	if (!epc || IS_ERR(epc))
>>>   		return;
>>> -	atomic_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
>>> +	mutex_lock(&epc->list_lock);
>>> +	list_for_each_entry(epf, &epc->pci_epf, list) {
>>> +		mutex_lock(&epf->lock);
>>> +		if (epf->event_ops->core_init)
>>
>> This would result in abort if the endpoint function driver is not bound to
>> endpoint device and the notify is called.
>>
> 
> I don't think so. We are iterating the "epc->pci_epf" list, which will only be
> populated if a EPF driver gets bind to an endpoint device.

There are two binding here, one is EPF device getting bound to EPF driver and the
other is EPF device bound to EPC device. We could have a case where we have an EPF
device bound to EPC device (when added to epc->pci_epf list) but the EPF driver is
not loaded (though not applicable with endpoint configfs). In that case the EPF driver
would not be probed and event_ops would not be populated.
> 
>> This would also require all function drivers to have event_ops populated.
>> IOW this could break pci-epf-ntb.c.
>>
> 
> This I missed. I will add a check for the "epf->event_ops" existence first.

sure, that would fix for the previous case as well.

Thanks,
Kishon

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC248620934
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 06:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbiKHFz4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 00:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiKHFzy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 00:55:54 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD53623BC3;
        Mon,  7 Nov 2022 21:55:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GM/6ZauKlRPBzTm56giRvVPjA2Zc6nXPOBerSPkBEpBdpD2wFxEKAcJEV1D8lJCWn8s1/5M3UvEVBoTtcl4qQmDkRzJ4K4kkaY2Ibiei471LlTV1nTyZP7IGcEQXc+D89gfGv3W53XVO4ywDqrHLpHaHfvrT/6fbUdTrAHm2zq+7x42X81biQ6qTwyGf2sTqf8VsWx7OsC9iM6AzTlCHF28eBimQVQvrWURZAteW+bHv08y20+ufvE0aGcJU6ypsyEuQ3d945GgRhMsg4yO9dijJHr8Iqf2raaPtunI1k4zllC4mV2o8hzxAALSRVphD7p0yBilPf3CFZwiXHr/Wwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbeeITczexax0FKyMMQzoQIbJSYNHib9wbq4An4XOFk=;
 b=HOXICcRDjD1jkAl/5ruJvTx5iwWjCkM5iKAYhTGX3WoT8DxHyqaINed0yR3r8tpb1Atla+nJBiUH8fmSyIYccN8x/a/yENtOpMgp2+P+CJgkxZ05E8S2FevUtyz1dFn4SSDG01Up2Wh/Hy1nMY2Z6ylC+SVbe+LkoEA96jtl0eqNA0ZNUfj4iWjHCJKSJv3s5JciWphT98vLwbSo8MDq7R7UoHgePOd7DhPaOegaVss3iPTHO9scNBMScvaLZWTgDesZsRG7Bd8eQYadDM7CEm5wcZ5S2iIEC1UfJ543zCeuTGHPkenSLMjDovOrTeJxzOTWYSl4qoh9Kd8rJ13xrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbeeITczexax0FKyMMQzoQIbJSYNHib9wbq4An4XOFk=;
 b=Kxqo+qMzVfNYz8U4pVO/0di/waTyzAL/v3Ze//U3kE77KVWhYck7OLvmBW0i0TOvAtshidL83x7ulDJmq9w73wIfi637eFmKIBFjtya2ET9H4OG3M36RNCcfImqDbr2Q0NSaSCJ8wMlT+UN3ooV2Etky8A1T/+9nRgvw/zljMQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 by IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 05:55:51 +0000
Received: from BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::87b1:d413:9ef0:9af]) by BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::87b1:d413:9ef0:9af%6]) with mapi id 15.20.5791.025; Tue, 8 Nov 2022
 05:55:51 +0000
Message-ID: <3c3a65e8-b7cb-613c-aa14-d1255b14a0f3@amd.com>
Date:   Tue, 8 Nov 2022 11:25:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 5/5] PCI: endpoint: Use link_up() callback in place of
 LINK_UP notifier
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com
References: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
 <20221025145101.116393-6-manivannan.sadhasivam@linaro.org>
From:   Kishon Vijay Abraham I <kvijayab@amd.com>
In-Reply-To: <20221025145101.116393-6-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::22) To BL1PR12MB5827.namprd12.prod.outlook.com
 (2603:10b6:208:396::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5827:EE_|IA1PR12MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac0ea71-601d-46b7-af1b-08dac14de3f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HEFYs1wh4RMrAgeiK8g98J0Y9ETLPia8PJupJyvioUxI3YrD7T1JGM0ma/baBgNBLJuPI7vSqVT+kfUvk/kvikdVbdKCZsib68iZkxCX+20B4ppy+o/HvE4WylI0v0DBQFZzg3RlfSz9onp8jP+9r/fqG7JJI+tWpCiWqWeLsN9djydwIzDVqwIRdRHuA77uhAHVL9a/E+yGNjHAJVbq/2pio0hyCjW8g6cRr4QH4i13U4JsFIz3PZD1P/LSq4bKqLzcw+SeLh3/9cb19HaZZx29MLwwBOmU2VQFij0tbWjncQhlUeVtJPoLPlMHkJ7SJ/oT+ELL/kjxzMwqwy8GMFVTqGdsx1vCYMyNfJgWM/eZCSIEkSUuSxIZAs3UgqyRti/SVZ6FDlAVj0AoRuTz0rCmuIs1nyb+G0ImDHXNV0AAxUoZAn27C+cM7Ce8TR21A87Jhan4ayA9JtqigqehEAjB07IKEwRAVi4ESwFd0qyheRY2MGGjSDcEKu+GTiygHc3YP2025P++9Rkbpu/3HDVE4telDmRfSNqwAIyUm0F0V0oLbq4+ZN5pTLQVriE5/qvOeygYLBxIll+92XIjxQ5IiWGJP1f2TKZ2KpGVIS1IrNimKYYXNiLFCFKV/u+RhpR4064pbtM9mEbTXAYUeGUaQxE43z+nFLWS89vmZq5khjI2v0YuXVWRlVm4NqeEa3x+tdwGp1laYoVcpheyAaCSKrDODuishdaIb18WabopIXZwd1hsY/02fDSdqJPFAbi9ZUOBD4iOFcI3YknRaFe5eKjKN+LxXaHpvuBFlk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199015)(26005)(66946007)(38100700002)(8676002)(66556008)(66476007)(4326008)(2616005)(186003)(316002)(53546011)(31686004)(2906002)(36756003)(5660300002)(6506007)(41300700001)(6666004)(8936002)(7416002)(6512007)(31696002)(83380400001)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUxYZ1prWmNQaENvU1VJbG9aYXFlSzRvdXpqL2dNRWR1c3FtQWxYSGcrRUs3?=
 =?utf-8?B?RG5OdHlXMzB5VGVzOHB5c3hXK3E3S0hteExVdTgrOXQ3Zkk0QnhhWGxIczBD?=
 =?utf-8?B?YytoK2NER05XUCtpWGNBZXRZYkhIaE8xYWdrZWdYeXJnam45TDJDcGRMcHRh?=
 =?utf-8?B?WHd2bkx4UWRSNnNVMTNiWThTdDZiN29kV0pYckl0Snlwem5EUDdjUTY2bjJL?=
 =?utf-8?B?TTF4UW9UdTBkNDVkem5MNXFVekFDeDBKQXQ4bGpMWS83UUVSNGp6RVJjWGpQ?=
 =?utf-8?B?amtoVlJyQW5DSlFUSlNaR0I5SGt6TTRiS3hjZnVSRGI3NVozaEJlTmF0Skdp?=
 =?utf-8?B?SmZZYk5BTkU0eXIzODh1SUNrMDNqeklsbmRkVjFsUWR3UEtkVjBtY2xpUm1h?=
 =?utf-8?B?Zk5rQmxVZWpHZ3FraFVTSXhYaHJVdUhyOVkxTEpqSGNvNEZuYVp1UWptdVJO?=
 =?utf-8?B?TnM1VlUxQnhDdnlFbnI5S2lKQmdkQmtMMlYwV24wUjdINm45VTJMVVNvUXpl?=
 =?utf-8?B?Njc3NW5FZUduVlFzUVIvcVJtWWZya2NNalVZV0l0c1AwWCtkNlV0TzBZQjQ5?=
 =?utf-8?B?Q09ndDY4aGpMYlR1bU92VVNVRStFcnpoeXBaSjNiYVBQaGt2OTU5em5rQWoy?=
 =?utf-8?B?Mm1RUUVlQVN1QlpwaU9oZnJRdmZodkU1eE1CWk1OaVNWOUlYbE5rdXpVbGcw?=
 =?utf-8?B?Q09WQ09zaUkrc0dtS1NHOUw0UkFaVm1ybkptejFxTnB5Z1I2aVNONXM3QU9D?=
 =?utf-8?B?L28vTGw4UUErK2hKaXE5dlZhandpTmorT2RKeG9nS3dYcU1oYitVUnNPT09h?=
 =?utf-8?B?SEoxQ3k1bGEvNHdaWEd1RW5vdG53Zlp4QUlNMmlaTTl5UGIyejQwYmx6blQ2?=
 =?utf-8?B?TjlISUVZNkhna1VCbUcvS0lOT2RDWmhxM0l3cHNlL25LcEYwM2FDRHQ5Tmd2?=
 =?utf-8?B?V3BIdU5FUWRGSURVNE9NQ09CUnJoeExhQ051cEpGUVc1Wk1VYTNKRmozd1Ri?=
 =?utf-8?B?VjlqWmZuaUwxUndTRWxBZGVPR1QyRWJxZ3pvQ0hMYkphNDdRSGJlaTJzWC9T?=
 =?utf-8?B?bmxaWU9ubnYvM005R0d4aWxWWUdFWUJqRE5vMEtwYUhiSy8rNFNNaUR4cWkr?=
 =?utf-8?B?ZEliMVNBYnB6b2tvRFpTeFM5L1NlQjVqTFZqdXFENVF4VUVmTDZvZXRWQWtM?=
 =?utf-8?B?b0FlcnVkV1NKNnkyYldMM05GOVQ0cUFjUDFvUHczU00xdGtHYVZTTXFCWk51?=
 =?utf-8?B?L2NCb0JnWXNLMzJ3UUR0MWFpU2IzSmIvZVg1NEIzNExIaEx2cnZ5Z0w4NEUx?=
 =?utf-8?B?UStRYTRheHpMaS9HbG9rQUxvdERyVm8zMzhjMU03SXZYU2ZxMDFOMExseG5j?=
 =?utf-8?B?cDFKSWVaZnFJTHllRlpmWDdhRjFlc3hGMDRLWU05bUd1T28vM0ZtN2xqaDZF?=
 =?utf-8?B?NmQxRzVUdjgyQ2taZ0Y2cURKN25KQnF5KzhtUG1qdzNyNXhpU2p6VnJieVhX?=
 =?utf-8?B?WnZSeFc1RVh0NElsN01oQVhHaFVWaWZZRnZtWS9qNmFTcWJDSStlekFjcDVD?=
 =?utf-8?B?cktyU0RYenY4dTBLajZzV0pPbCtCazUxaGtyLzFIT3VEYXlMOVNNa2t0SmZO?=
 =?utf-8?B?NjNFZERORFRqaVVhc0VEUlpUV3dQUFdOcnJBYTRnY1BwLzVpSEZwWWFHazdw?=
 =?utf-8?B?NlRzbEd5MEl4Y0kyZWdFZVh4NU9ZbHI5YzRjc2RLUFRqR0dTSzBXWUVNY3FD?=
 =?utf-8?B?TEVCOEdweUUrUTNXYSt1ZllwanF4Um9GZEJ2Z2tFUkhUZVJOczBuelMyTktG?=
 =?utf-8?B?U3lVd1B1aCtmNnN2eFVLdjlSaUtMLzV1LzJRdGw0YzRPSTRKMVk0UjZTN25Q?=
 =?utf-8?B?NERSQk4yTGpJSjlBY1dQenEwUkxqc0FuUkdMQ3NDK25PRU01QXg5Q0N0M3dP?=
 =?utf-8?B?d1A0ZXJoUFhMbHJ6NjFuMC9VQjBVb0JHSU1nbnZncUxoVDg4MmduQ1JVTkRD?=
 =?utf-8?B?bU9zSkp5TFBZUld5SlJYdG1ScmZRaitEVGZNZUxPSmVUUVVZU2g5NVdiWDNy?=
 =?utf-8?B?YkEvVGIwQ1VkR2ZMZkt6QWxscG93eGJLSXVMYkdIbTA4MnZqRGM5Vkk1dlpF?=
 =?utf-8?Q?15q+F49umPSk5E1lxIYwYFQes?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac0ea71-601d-46b7-af1b-08dac14de3f1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 05:55:51.0224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWTZsmu42cFTGcL6KZ/MAo+7xu6khtP4POV2YvuBPi/gHZ2nV1fDs2A6ARaRhRdrpaEph1UnDdYSrgTRH3BvJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/25/2022 8:21 PM, Manivannan Sadhasivam wrote:
> As a part of the transition towards callback mechanism for signalling the
> events from EPC to EPF, let's use the link_up() callback in the place of
> the LINK_UP notifier. This also removes the notifier support completely
> from the PCI endpoint framework.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Acked-by: Kishon Vijay Abraham I <kishon@kernel.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 33 ++++++-------------
>  drivers/pci/endpoint/pci-epc-core.c           | 12 +++++--
>  include/linux/pci-epc.h                       |  8 -----
>  include/linux/pci-epf.h                       |  8 ++---
>  4 files changed, 22 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 868de17e1ad2..f75045f2dee3 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -826,30 +826,21 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
>  	return 0;
>  }
>  
> -static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> -	.core_init = pci_epf_test_core_init,
> -};
> -
> -static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
> -				 void *data)
> +int pci_epf_test_link_up(struct pci_epf *epf)
>  {
> -	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>  
> -	switch (val) {
> -	case LINK_UP:
> -		queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
> -				   msecs_to_jiffies(1));
> -		break;
> -
> -	default:
> -		dev_err(&epf->dev, "Invalid EPF test notifier event\n");
> -		return NOTIFY_BAD;
> -	}
> +	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
> +			   msecs_to_jiffies(1));
>  
> -	return NOTIFY_OK;
> +	return 0;
>  }
>  
> +static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> +	.core_init = pci_epf_test_core_init,
> +	.link_up = pci_epf_test_link_up,
> +};
> +
>  static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  {
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> @@ -976,12 +967,8 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	if (ret)
>  		epf_test->dma_supported = false;
>  
> -	if (linkup_notifier || core_init_notifier) {
> -		epf->nb.notifier_call = pci_epf_test_notifier;
> -		pci_epc_register_notifier(epc, &epf->nb);
> -	} else {
> +	if (!linkup_notifier && !core_init_notifier)
>  		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
> -	}
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 8bb60528f530..c0954fddcc14 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -690,10 +690,19 @@ EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
>   */
>  void pci_epc_linkup(struct pci_epc *epc)
>  {
> +	struct pci_epf *epf;
> +
>  	if (!epc || IS_ERR(epc))
>  		return;
>  
> -	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
> +	mutex_lock(&epc->list_lock);
> +	list_for_each_entry(epf, &epc->pci_epf, list) {
> +		mutex_lock(&epf->lock);
> +		if (epf->event_ops && epf->event_ops->link_up)
> +			epf->event_ops->link_up(epf);
> +		mutex_unlock(&epf->lock);
> +	}
> +	mutex_unlock(&epc->list_lock);
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_linkup);
>  
> @@ -784,7 +793,6 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>  	mutex_init(&epc->lock);
>  	mutex_init(&epc->list_lock);
>  	INIT_LIST_HEAD(&epc->pci_epf);
> -	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
>  
>  	device_initialize(&epc->dev);
>  	epc->dev.class = pci_epc_class;
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index fe729dfe509b..301bb0e53707 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -135,7 +135,6 @@ struct pci_epc_mem {
>   * @group: configfs group representing the PCI EPC device
>   * @lock: mutex to protect pci_epc ops
>   * @function_num_map: bitmap to manage physical function number
> - * @notifier: used to notify EPF of any EPC events (like linkup)
>   */
>  struct pci_epc {
>  	struct device			dev;
> @@ -151,7 +150,6 @@ struct pci_epc {
>  	/* mutex to protect against concurrent access of EP controller */
>  	struct mutex			lock;
>  	unsigned long			function_num_map;
> -	struct atomic_notifier_head	notifier;
>  };
>  
>  /**
> @@ -194,12 +192,6 @@ static inline void *epc_get_drvdata(struct pci_epc *epc)
>  	return dev_get_drvdata(&epc->dev);
>  }
>  
> -static inline int
> -pci_epc_register_notifier(struct pci_epc *epc, struct notifier_block *nb)
> -{
> -	return atomic_notifier_chain_register(&epc->notifier, nb);
> -}
> -
>  struct pci_epc *
>  __devm_pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>  		      struct module *owner);
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index a06f3b4c8bee..bc613f0df7e3 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -17,10 +17,6 @@
>  struct pci_epf;
>  enum pci_epc_interface_type;
>  
> -enum pci_notify_event {
> -	LINK_UP,
> -};
> -
>  enum pci_barno {
>  	NO_BAR = -1,
>  	BAR_0,
> @@ -74,9 +70,11 @@ struct pci_epf_ops {
>  /**
>   * struct pci_epf_event_ops - Callbacks for capturing the EPC events
>   * @core_init: Callback for the EPC initialization complete event
> + * @link_up: Callback for the EPC link up event
>   */
>  struct pci_epc_event_ops {
>  	int (*core_init)(struct pci_epf *epf);
> +	int (*link_up)(struct pci_epf *epf);
>  };
>  
>  /**
> @@ -135,7 +133,6 @@ struct pci_epf_bar {
>   * @driver: the EPF driver to which this EPF device is bound
>   * @id: Pointer to the EPF device ID
>   * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
> - * @nb: notifier block to notify EPF of any EPC events (like linkup)
>   * @lock: mutex to protect pci_epf_ops
>   * @sec_epc: the secondary EPC device to which this EPF device is bound
>   * @sec_epc_list: to add pci_epf as list of PCI endpoint functions to secondary
> @@ -164,7 +161,6 @@ struct pci_epf {
>  	struct pci_epf_driver	*driver;
>  	const struct pci_epf_device_id *id;
>  	struct list_head	list;
> -	struct notifier_block   nb;
>  	/* mutex to protect against concurrent access of pci_epf_ops */
>  	struct mutex		lock;
>  

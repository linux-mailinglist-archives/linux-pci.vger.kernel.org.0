Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42710620920
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 06:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiKHFwv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 00:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiKHFwu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 00:52:50 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576772CDFD;
        Mon,  7 Nov 2022 21:52:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/GoR7eSwD1qNxNc4ToHTC3yx2VRwrLKzhHvCQXZ6xuVsYFmWgiHIQCY9d8fjs42Sa56U2FVKvqLb4Hg3RFDM7u8OTcYWLkCzohWxOnq8SjiYOznCvFgDxLCfzAWndZ9ugP2VnB3pkKa6A3ETd2IMiw0Y3yn4yyH1m4yurJD+ciSqDTxRw/K2pkWZ6eDaXE86+oAtwW988hf5mbgtSY3nbAf0u2gfkYXnSfYh6DllNalshiEyjLmlMsquGX3joISXyoQKN1/yKW45Mu2JqVEFZrXg4LlYBjMGKD0OknwRgdO1p08b5psqQEBJ7dZdHpAgoN1sa8kckJQL71dYicecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1qW+X7DuxRgSnOjsL0hHHOWZloe6zja3piRnakm1Q0=;
 b=FS8awZGyuKzm+Xld7+qlhdEZRpwkpcplceDvNGDoquJowhTcFGMQeB68MfTm4I7DaCjZFQHmeSdsZ1i1r/8fmR63D/QDWBW1pzdts4ov1ElNSvMa1c6Bw81AInYDFhVKK0tKXkzVoTCb3/dCAOqCRNul+72TNIqJplI9Hj7NHmvPwSpY9BGXCSfxe7l1ygA/nZHAUg3fyMghXwfwaS9kQPjfmQhmw2gxnTg90NAF5TdGAYSzeBR28CMxH2AaHsrZZEMdQQmI1YM1xSNYAu+BV8C66WIjLCGsQA4udliRBOlCl7Zg+h23dVmET8HcmCh0kFla0SuaPRrLt5C6VU/j2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1qW+X7DuxRgSnOjsL0hHHOWZloe6zja3piRnakm1Q0=;
 b=ldHRheWBmTUjs+nwOlpQdsBLx1SvqCCcXzYvfl+igYvuGDjp+zv5QhEG4O4zqhrha5k5vBov+b1tBAQKQrpJ8jFqRZptMDJfRR8F39adsW6ZJY2vRf3qFOHl8W0U0XtZ4+2SJh12EK+3IduSaVYPv1NFqFSgtVSZW7W4rzehsAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 by IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 05:52:47 +0000
Received: from BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::87b1:d413:9ef0:9af]) by BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::87b1:d413:9ef0:9af%6]) with mapi id 15.20.5791.025; Tue, 8 Nov 2022
 05:52:47 +0000
Message-ID: <1f673c67-f1ea-318b-b110-a4520d76ff59@amd.com>
Date:   Tue, 8 Nov 2022 11:22:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 4/5] PCI: endpoint: Use callback mechanism for passing
 events from EPC to EPF
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com
References: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
 <20221025145101.116393-5-manivannan.sadhasivam@linaro.org>
From:   Kishon Vijay Abraham I <kvijayab@amd.com>
In-Reply-To: <20221025145101.116393-5-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::19) To BL1PR12MB5827.namprd12.prod.outlook.com
 (2603:10b6:208:396::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5827:EE_|IA1PR12MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4c4d61-d0cc-416f-830f-08dac14d7677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awOZwhEBRKIkBaAIac46qNdT6nXIxdwgW2bwFdSIg8qqEp1CmlfmdhTLsJAM/SWYFpdHMNoELwuxgKfGkB1q2S1G3r2p/OJw0Rbi0VITBakmRxHXHLGiIUTqx3JK6VgNlNaMtKqI+jDhnM/LB67r0TNsX3fCjFLQZihSIrbHgYDgRdKJlquUiM3y0xs6D3HNMT1Vt2d+sVmnoVkoL5LcMVhzgeguvhlsGniZsAnspVf5tschJ4XJM0eJc25aHzkbwSrfQK8+y9KRurW3cCLdBRvByM3ojKtxBhQB8vYfdlb8o/NfRo8PbGci1CNcdv1++LFQMy/Ex/BXXqDThcmfl9q9DvqN0ctBHg5Vg37bfMkIPvbcbraqv1tcyHL0ruk+SXnG6EdjZeCZl9wa2xL34YYK93aZrci3m2jPhLnyaL1NeRYSMOljtsULRP1WH7Zef79LbegWKR3kzwMI5p8uM2P4FS4j9r7KttWBbteDPi52+/AXPhwZauUC2+6tuVigHYdZZr0LyaDKcM4QIJB36lNbpUcyjz57RrsBUAmmzyvEPAAlfLfdlZGEtjL8weUHakETfu5DNyC6JxutByzlGnZ/1eZqGQfAVUwdpw9aronrEuPX77lyRqjMv7H5LRe4oill0LblyUqTOotPwx9bihUzlGxHcWcRgVmHE1tKdFz9VsSkG4wPXoMOu/6LPH7wWo2+kuVPQiXNBVIXWuAuC6F7n46drI20PfA/QB548O9m/ADVAlYlIZ/+xXmTqR2nOh573TPjckt1oaYJdx0dFtyQTvYXBl6YzCCO0SPy0aM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199015)(26005)(66946007)(38100700002)(8676002)(66556008)(66476007)(4326008)(2616005)(186003)(316002)(53546011)(31686004)(2906002)(36756003)(5660300002)(6506007)(41300700001)(6666004)(8936002)(7416002)(6512007)(31696002)(83380400001)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmVwV1FoNlJNVkVUSVJvVm9QNmxOeDFFZk9HSTBkZktPeHlpbXhkeWRSMXRL?=
 =?utf-8?B?amVrRlFKaVJVdzdBdGgramtOeWNqaDV6R2ZQV21hcTJVeE95UnpsaHVOMTU0?=
 =?utf-8?B?Y3d2MmtCUUJjZFphbFlxQ1JDTVl5Mk1UenJkTzk4eE92OVpnU0cvWDlPdkhh?=
 =?utf-8?B?RVlVcUJkUHBtTnRyTkhrYzh1bjZ2L2pDZFR2NVQ4RVRiVUROSHZBWDRLLy8w?=
 =?utf-8?B?eXpSSGVheWlrL3BZMytoVk5NUmtNSFZhYU5tODFKc1RmelZRK2RETUZWN2hU?=
 =?utf-8?B?dDJmTkZEOHJmaUZDcVRSYU04cGhUTllRUVE2UEhjMzYvNjNtMzVybm1OWlE2?=
 =?utf-8?B?YU0xMForYmkyVjZpYXlSYzFQQXREOFA1eUw4QVRBK3MzU1VBSjFTYThyNXhi?=
 =?utf-8?B?UFlTSG8yZUlwemw0azJJVzVDNFhRM3ZvTGVwSERVa014WkV6MGxpT0VaQkRH?=
 =?utf-8?B?UkdiSjM4Q2JFSkhIZmx6RDVWcnFmRFJRVDFPSm4rU3owMVBpNWZmSi9FWEJo?=
 =?utf-8?B?SlJlQXRLZXZBVXhoWDYrSzdHVXRwbHBVWUZtaHF1WDBVZVRUMC82TW5KQmZ5?=
 =?utf-8?B?ZDAycHdtZ1BmZUpUdGhpNXFZRnpCOERxMVJNdzRmT1RoM0lBR0tJdGJMRlE3?=
 =?utf-8?B?K0Rrakg2QW1GQTV4YktjV2dqa0FFd0tER2NPL3Y1N2pyeHpjMWZRamlNRllX?=
 =?utf-8?B?ZDVzUnZ3dWpxNFdsRktXb3pHbUprM1lTRHpBaWVlQ2Nhb1FaMWo5MFU0V1BP?=
 =?utf-8?B?WUNUTmVOZzR5eUtFd0NBY0xRMDhYaCsvV0tqc0wrbVpWV2tkb3pXZXNONW4v?=
 =?utf-8?B?dEU1Y1g3WUZHTCtOb01BSlNPUTJtQkcwY0M3bllzYUkvWk5KV25mNHR2NERV?=
 =?utf-8?B?bEk2Nkp3N0d0cDJOdWZRTWFVZjJVMktvU0hwVkQyeXdSb1FJN2NVMjlQRjF1?=
 =?utf-8?B?NHdGcFMxeC9vN2V5OHowc2VFZVZLcTZJTkRqa0hpT3BzRW56eEN1akNpZmY2?=
 =?utf-8?B?UGRQbVZiY21tbWY2QUJwM04xSG9NdUpwN0RveXk1bHR5N1pqVUlCczd6dnZK?=
 =?utf-8?B?b05seS9RRGVaQjNjd0daL3V0NVBvbmI2b05qV2NWeUxHWnBqRy9hSmpyTEVx?=
 =?utf-8?B?SmttRng2S21UcStmeXM1SktGWFNIdlJqTDRiaVBiLzJhV0dMaUpoY1crVEdp?=
 =?utf-8?B?RVlCRml0WlB6NVBMZnQ5TEpjdUFpVUJOQXl4R0VSa2hzbGF4SWJBT1M3ZWRs?=
 =?utf-8?B?eHpMN3pmWWxwL1lSUS9Femd0MERaYzlEekM0bFdNSlNKZENyRzRRdTdaVmFT?=
 =?utf-8?B?ZkhrakZFeGFiTFZzTFVHdTEzODMwWS9FMXQwQWZFb2FRa212Z0JuZzlkcCtr?=
 =?utf-8?B?TUVjTW1LQUZNT1QxK1k1Sk1TbVFTcUwrSHBoUWxnaUpkS3h0aVlaMndUS1Fq?=
 =?utf-8?B?OVErNEJ1Q1NSejZxdUt1UWxzcllJNUpCeUhKNjZkSFd3N2NCZTJqTTRSbFRp?=
 =?utf-8?B?SlEvYXFWTHkvMWZORmJEM25WRHFlV25ZTUM0cHhjSVNRazhZc3hxQlM5UmRY?=
 =?utf-8?B?bVBha3FPRTlZbHIrTWxXdmhYbzZNU3MwN0RoNWxhZjlIOHloWk1EMEFOWDdx?=
 =?utf-8?B?NFVNOFhYYjFHUjByeFNOSmlvd3Z3Q1FXU3pDSTl1V2FqMTBwclZWbXlYNlh5?=
 =?utf-8?B?R1NkMEZ1T0dCV01XZmYyQmtUQzV1VW9WUTFRMXJMSnZTclF4QUZ1bFBoN0g0?=
 =?utf-8?B?RXJhNmNMZjYyQkhLa0pTeUZqVzlvMmN0c1p3YXNnMk9hS0VkQmxYdmFmWkVm?=
 =?utf-8?B?bDRZd0NsVTJRQ2lOc2hJbk9HdUgxbEwvbys0ZS93bEZuS1YxNDJEWVZPVjVO?=
 =?utf-8?B?Y0g1R09vTHJ5bjRFQzhlcG5tU3hZSVNTVVNldFhDR3ZJbU93VVVJbm14UTd4?=
 =?utf-8?B?d0ZGMVErR2M4YzZGeTN2aVJCc3RleUZzdjVDcTk3cEhCa2p1NGNCNlNwQmRB?=
 =?utf-8?B?TWsyVklaYW9LV215QTEwWUZvMGlueTh1OFI1S3UxbXBrcDZ1dVpQbDVZRVV5?=
 =?utf-8?B?YTQ2OUoxN2xzUW0vdnVqM0JxSWNySXpRUzUzY092bk9FWFNrdXUydXA3QXM3?=
 =?utf-8?Q?DBdleyJevb8KK6Ol4+vcbkIP3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4c4d61-d0cc-416f-830f-08dac14d7677
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 05:52:47.3657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pqlvmUJZhiTxqEcE8pyUAOe2rBTB91/Rt0EU3jSrmmAXz0Z+CH9PSla0W5J473S7riEMVWiBAXebQrrtFr0Ng==
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
> Instead of using the notifiers for passing the events from EPC to EPF,
> let's introduce a callback based mechanism where the EPF drivers can
> populate relevant callbacks for EPC events they want to subscribe.
> 
> The use of notifiers in kernel is not recommended if there is a real link
> between the sender and receiver, like in this case. Also, the existing
> atomic notifier forces the notification functions to be in atomic context
> while the caller may be in non-atomic context. For instance, the two
> in-kernel users of the notifiers, pcie-qcom and pcie-tegra194, both are
> calling the notifier functions in non-atomic context (from threaded IRQ
> handlers). This creates a sleeping in atomic context issue with the
> existing EPF_TEST driver that calls the EPC APIs that may sleep.
> 
> For all these reasons, let's get rid of the notifier chains and use the
> simple callback mechanism for signalling the events from EPC to EPF
> drivers. This preserves the context of the caller and avoids the latency
> of going through a separate interface for triggering the notifications.
> 
> As a first step of the transition, the core_init() callback is introduced
> in this commit, that'll replace the existing CORE_INIT notifier used for
> signalling the init complete event from EPC.
> 
> During the occurrence of the event, EPC will go over the list of EPF
> drivers attached to it and will call the core_init() callback if available.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Acked-by: Kishon Vijay Abraham I <kishon@kernel.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++-------
>  drivers/pci/endpoint/pci-epc-core.c           | 11 ++++++++++-
>  include/linux/pci-epf.h                       | 11 ++++++++++-
>  3 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index a6f906a96669..868de17e1ad2 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -826,20 +826,17 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
>  	return 0;
>  }
>  
> +static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> +	.core_init = pci_epf_test_core_init,
> +};
> +
>  static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
>  				 void *data)
>  {
>  	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> -	int ret;
>  
>  	switch (val) {
> -	case CORE_INIT:
> -		ret = pci_epf_test_core_init(epf);
> -		if (ret)
> -			return NOTIFY_BAD;
> -		break;
> -
>  	case LINK_UP:
>  		queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
>  				   msecs_to_jiffies(1));
> @@ -1010,6 +1007,8 @@ static int pci_epf_test_probe(struct pci_epf *epf, const struct pci_epf_device_i
>  
>  	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
>  
> +	epf->event_ops = &pci_epf_test_event_ops;
> +
>  	epf_set_drvdata(epf, epf_test);
>  	return 0;
>  }
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 6cce430d431b..8bb60528f530 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -707,10 +707,19 @@ EXPORT_SYMBOL_GPL(pci_epc_linkup);
>   */
>  void pci_epc_init_notify(struct pci_epc *epc)
>  {
> +	struct pci_epf *epf;
> +
>  	if (!epc || IS_ERR(epc))
>  		return;
>  
> -	atomic_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
> +	mutex_lock(&epc->list_lock);
> +	list_for_each_entry(epf, &epc->pci_epf, list) {
> +		mutex_lock(&epf->lock);
> +		if (epf->event_ops && epf->event_ops->core_init)
> +			epf->event_ops->core_init(epf);
> +		mutex_unlock(&epf->lock);
> +	}
> +	mutex_unlock(&epc->list_lock);
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_init_notify);
>  
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 0c94cc1513bc..a06f3b4c8bee 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -18,7 +18,6 @@ struct pci_epf;
>  enum pci_epc_interface_type;
>  
>  enum pci_notify_event {
> -	CORE_INIT,
>  	LINK_UP,
>  };
>  
> @@ -72,6 +71,14 @@ struct pci_epf_ops {
>  					struct config_group *group);
>  };
>  
> +/**
> + * struct pci_epf_event_ops - Callbacks for capturing the EPC events
> + * @core_init: Callback for the EPC initialization complete event
> + */
> +struct pci_epc_event_ops {
> +	int (*core_init)(struct pci_epf *epf);
> +};
> +
>  /**
>   * struct pci_epf_driver - represents the PCI EPF driver
>   * @probe: ops to perform when a new EPF device has been bound to the EPF driver
> @@ -140,6 +147,7 @@ struct pci_epf_bar {
>   * @is_vf: true - virtual function, false - physical function
>   * @vfunction_num_map: bitmap to manage virtual function number
>   * @pci_vepf: list of virtual endpoint functions associated with this function
> + * @event_ops: Callbacks for capturing the EPC events
>   */
>  struct pci_epf {
>  	struct device		dev;
> @@ -170,6 +178,7 @@ struct pci_epf {
>  	unsigned int		is_vf;
>  	unsigned long		vfunction_num_map;
>  	struct list_head	pci_vepf;
> +	const struct pci_epc_event_ops *event_ops;
>  };
>  
>  /**

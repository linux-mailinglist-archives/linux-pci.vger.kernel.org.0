Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C841C734F97
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 11:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjFSJXN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 05:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjFSJXD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 05:23:03 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A26B4;
        Mon, 19 Jun 2023 02:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0tZzjXWYdJLr90v8jjZgnnlLIhoD28xNnvIavLnVSxII7nup/VK0vFjOLtDQGpwldQNeyRp33utoaaZi5rEKzIcXQrU8Mf0/QYiNADeRTlcUPyNEAtYA0hPtnZg2m3B0pGCXAOR/myKNzwkFRbFC+61tRUHCJ7TcqnB7m/EOA2pyLPgF7xEx6ZTFKlTNtf9GSVuPhUm5xjnoRBPbqOsBF/wo3ZsltJlFEy6J9AxAaKW1Kebn5qJsdB2ZnIm2puTKt7wxUgUdyWDPTvR+5TxOxLoN5mX7uj5JoyeXlcIvv5Ys6Zy7HV4dCL5cEUuPxD+3ay1B/0CNT3MAhJ+Pb0HqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpNOzlEIUs/EjC1QdNOfbNm+10MI5IxESjakS5gmhs0=;
 b=KfbcGWa49f7nCuCNTXTQu4ryVajhrOEkgbAdiHcjbDE7yHXKF5S8VEd2tH+RxwUgEKiJMbAzgb8VrNHajxaxORCRy9i7nrN8u7uzYrJBVjXGnRXDeE0EgqCv/akC9qU3IzRg8RLdmXqiuN+DD/vTeCXo1zG+dCNNDE/V2JddIOBZ74nS43BRYAHkR1QZliasmZOUH5O5hAeq62I4CP1VvvfZTozq7yd/qjRfLkB2Np3yDUmCUZuZyRP6YvnfrW3fF6YYQGn5FMMpfkry9NZeFJVVwLf/b/FavOq5f/1AFJKTd5z/xPyrAiTQswJRh/awscmTzt7PivW3V7xhTlh1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpNOzlEIUs/EjC1QdNOfbNm+10MI5IxESjakS5gmhs0=;
 b=peHy5YUGN7RYQi8wV6s/Lf89BKcaGY3hlQbisBrFMsjwZvWM0NV59339eaTGa9cIBsgvVXeoRYnQYEDHgVCxIvTqSHhxWC/19+g0ml4Al9lNNAsKX81iJs0YRH0nFKsRTbNq0GbYNcOTVNrj9XT4+WyxxrFXOTo9hlyJHi0G3bc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) by
 MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 09:22:55 +0000
Received: from DS7PR12MB5839.namprd12.prod.outlook.com
 ([fe80::5ce6:1e12:bbb5:716f]) by DS7PR12MB5839.namprd12.prod.outlook.com
 ([fe80::5ce6:1e12:bbb5:716f%7]) with mapi id 15.20.6477.037; Mon, 19 Jun 2023
 09:22:55 +0000
Message-ID: <791ced92-6198-3b6b-3cb8-c6f413986f61@amd.com>
Date:   Mon, 19 Jun 2023 14:52:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 1/3] PCI: endpoint: Add wakeup host API to EPC core
Content-Language: en-US
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1686754850-29817-1-git-send-email-quic_krichai@quicinc.com>
 <1686754850-29817-2-git-send-email-quic_krichai@quicinc.com>
From:   Kishon Vijay Abraham I <kvijayab@amd.com>
In-Reply-To: <1686754850-29817-2-git-send-email-quic_krichai@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::16) To DS7PR12MB5839.namprd12.prod.outlook.com
 (2603:10b6:8:7a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5839:EE_|MW6PR12MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d3e20c-1b99-4056-e06b-08db70a6c36c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkGOHwcIYQlnSG1OLlsE3KKgRedyuBkQR0xttGCLA62sjWE8T7XURLmZH/VZ528y0YjROsiURQua9NJaF8+iUKEzYeToPp+6huwu46o8AlJiaBkY/9kpumdiWqeGF+3iZ00BDgaRSKDQIS+oeys2lCxujFMpCakWYc5OTa4FpJtTGmxpcSe9knUxWLf93TT8hleOkJsVvzQeZAdc2exqOUqTw3AmZYHiIrmVwgzo/hLhJvTK3DIwjih25SDGG48IL9ztSbgWBQgvxSYoNElJ8O173NQSgnmvgY3dDEvpPkkaVulJdCqUwKoNwLL13+Q+e97Y7+Dg7ex5oFUISnbD5g9Py53VfK33F+mgWIGUdmkovVfRm/jfq1fhvhzTAKlH9kAuShWl+a3tImUEuPhG3O6q04NbgI9jSh5TXyqbJpy3RgRobqyT4y2DdXuq4Hm855IRJstyQ8U03Kcj/6yWSi2QR4OFa7IVfFHlJ4WsIKTeOD+rWyPoaq3WSk1iH05JtP9WeU2DT75bkH9hYXEs5zzfmdQvf3AdJ0Pa6Ngry7uv24i6Bc8yLal8KuzkJm8gmOhtZwmU9SnJIgXIMv8t/vN6M6F2nTxWL6gRUB8UtQUV6x0hE4JuMb+mm4/RD7GBE7jCDFiLzJb17K90dYg/nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5839.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199021)(7416002)(478600001)(5660300002)(4326008)(66946007)(66556008)(66476007)(2906002)(54906003)(31686004)(41300700001)(316002)(53546011)(6666004)(6486002)(8936002)(8676002)(6512007)(6506007)(186003)(26005)(2616005)(83380400001)(38100700002)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU1ITG94SjhLSHFKc2JpcjV2elJ1RHdMQlF3QlhzSjNRMWpZWE1HMEJJUGIz?=
 =?utf-8?B?Mk9LWW9sL05TR1VVM1V4Z1dXaTI2b2ovT1dSUktBUHFmOGs0TTFwSW1WSmo3?=
 =?utf-8?B?MGVrRzl0Zlh4M085ZjdBV0lIbVVScnVGUTkvdnJlV0U1YnMxNE5mZGJMRVow?=
 =?utf-8?B?aVJQMklSUm1oN1RhZEY0eDJBVEVoWkYyQmFLQmlHK3pkSXFJTWVVWHlXVVRk?=
 =?utf-8?B?eFpGQkYrUks5ZkdUVmY0aEVTaVYwSHNyWDFNMWsvdklZZDF0K05oVUlKcUR5?=
 =?utf-8?B?WmxYQit3a1cwckRsak5XOXJOT1ZCeWl6QThVR0RyZFEvdnpUSlBEMHRlbU9K?=
 =?utf-8?B?cjJPU1FkVkpTNHN1dHhLb3Y5dEhrMkd4NWRZcmxyakkyWVEzVWdMU3h4UFZ0?=
 =?utf-8?B?cU4vZmVZcEdwOUNET1Z6Zm84WlY1OFVXbjRGWDRwMEk5d25jUldnbFZueXd5?=
 =?utf-8?B?M0FReVcwa3hLaVdxamcxeEs3RWp1czFBMkhia2dIdFpFdGpHYnppKy9STEg1?=
 =?utf-8?B?bzFibVNYeGNtbFJiRE1yZVduNlU2NUcwTnQ1YkdiTWNkQ281eTJWM0xKUFp3?=
 =?utf-8?B?aU1JOHo2RTRJQkdRVkN4UU1TSVJQd3RzMjdIcUkwN2xsaW4yNjNrWjdXVjQ2?=
 =?utf-8?B?OTBJZGw0aXkwZnFNZ1dVcmtsV3VTZXdPajYyNzRVb3A4VDdTUE5wNzBOczhj?=
 =?utf-8?B?V1N2UDdFdUt1Y1JmQzk5d3c3M0tLaUtpVUJ1cFVEeTVGK2FDM3BLQVkzZHU3?=
 =?utf-8?B?cmhBQUpLYzFNNGRIdzEvUHBoNU81WldjRzdOYmFWcnk0TUtQc0ZxWHMzOURS?=
 =?utf-8?B?Y0IybmdISEI2cXBGaEZhaVRRaVk5dHV2UzBSUWpmWCtnazMzY2QxUDM1SW83?=
 =?utf-8?B?OERxSkxYajZUd0IzaEZoblo0Q09nV3F2YTUvY0NpOVNwcGk4TVZERWJtdmtV?=
 =?utf-8?B?WVR3dGJSbWpTdU8zc0VpRUIrcTdpcG5ib01rVThXSklYM2hBUkhJcFp2Sm80?=
 =?utf-8?B?cWhuMDh4aXMveENCZzdSR1dTb01FYlh1YzZVVTlQdnFRblhmc0ZqaHNYNlpO?=
 =?utf-8?B?b2kwSTU2TFdMLzgwUDV3QXVoNEtqV0Nna1RQNjZKTlk3QWdQZHBsUFlueTlR?=
 =?utf-8?B?NCtXakR4V2ZmaUZ4RWgrTy9mWHdYZk9OYWpPNHFJcnJ0Q2hUeTI1OGJnS2x6?=
 =?utf-8?B?ZjcxbGZMbmpVYWNxcDUvUi9uWFJCYk9IMmJROGRxbTZtNzZRM1BITmJDVWU1?=
 =?utf-8?B?bUhUdk4yWjYyYUNHcHhWaEpsb0RIaHJxSWsvTEhhOFJGTlN5NCtjY0RqVUR0?=
 =?utf-8?B?MEdlbDJ0dnROVGJiTk5TZ1FnK1greGZSc2hsUHdRaTlFKzNheGZRYTUxd2Vm?=
 =?utf-8?B?SldjaDI4UURGY3I2OUh5M0FMck5WVnRNNXBkU0lGc3djbTlkOUpKWHFCWW9P?=
 =?utf-8?B?WWplcWVWaWd5emFrcEE4YzJYaVNydHJxdDN2VEt6NE1nckpRc0JzMXdUOWhG?=
 =?utf-8?B?MjlmSGZEbUdjUGgrWHIzVG1sMzRjSDFFMmpsZDJFZjM4NUdoZzZ3cHd0RSts?=
 =?utf-8?B?NWhwbDB5MExKL1JQTkUwUWZjWUxjZFF6WlFJSnUvdnQ5c3BGOEhxeGJEVHAz?=
 =?utf-8?B?a0ZMMDJXVVVpUTlsUEp4NlM2Q3phaGJMNnZvNndFRTY4VGgzcklBcEFWMTdr?=
 =?utf-8?B?QWZVUHhlOG1uNlhoajdvYUVRQUtMSGlmUDhMT0MwMEdGd3l0R3JWcDVFWGhQ?=
 =?utf-8?B?ZnJGbG9jc1dhVnp4MVhWVThkNzBIaE4yUzlBaEd2TlMwZXdTS0NsdHJLNlRl?=
 =?utf-8?B?VnVESmc0YXUzVlhxcHpOdC9Hd09ZcGExa0tNY2ZQKy9LdlNIYWxIYTJ4SlJ1?=
 =?utf-8?B?MzFoN2cvMFdqVFpXY3lWeHJSSGh5Z2puZnJCS0lITEdjckh6TnlHYXdIU1Jv?=
 =?utf-8?B?cHhGaFZuQ1ZEZldqNkN1L01uMkZKcU14L0x3dGZndk5iSXU1bENJZTQ2VFNu?=
 =?utf-8?B?cDR4R2tRNkFTRWthQ0E0UWp6WHE5L2FONDl6djdpRlJSMTVNSWszcVNramdp?=
 =?utf-8?B?TzREa1JIQ2sxdThYR1U4bzNFaTVZWlhNNWN6aWhuSnpPMGxOTDB2b29hVVBm?=
 =?utf-8?Q?DDZQtJmiNeIKdRGnDajjud2IN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d3e20c-1b99-4056-e06b-08db70a6c36c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 09:22:55.2440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwmJfk6zfocKl6uaNyg3AuRZLfC/o182sry1Ki3n4E+3GcPRv82hsizT5db5Q4b6Lv891KzcDKvjSL77FypW/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8900
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krishna,

On 6/14/2023 8:30 PM, Krishna chaitanya chundru wrote:
> Endpoint cannot send any data/MSI when the device state is in
> D3cold or D3hot. Endpoint needs to bring the device back to D0
> to send any kind of data.
> 
> For this endpoint can send inband PME the device is in D3hot or
> toggle wake when the device is D3 cold.
> 
> To support this adding wake up host to epc core.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>   drivers/pci/endpoint/pci-epc-core.c | 29 +++++++++++++++++++++++++++++
>   include/linux/pci-epc.h             |  3 +++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 46c9a5c..d203947 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -167,6 +167,35 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>   EXPORT_SYMBOL_GPL(pci_epc_get_features);
>   
>   /**
> + * pci_epc_wakeup_host() - interrupt the host system
> + * @epc: the EPC device which has to interrupt the host
> + * @func_no: the physical endpoint function number in the EPC device
> + * @vfunc_no: the virtual endpoint function number in the physical function
> + *
> + * Invoke to wakeup host
> + */
> +int pci_epc_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> +{
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> +		return -EINVAL;
> +
> +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> +		return -EINVAL;
> +
> +	if (!epc->ops->wakeup_host)
> +		return 0;
> +
> +	mutex_lock(&epc->lock);
> +	ret = epc->ops->wakeup_host(epc, func_no, vfunc_no);
> +	mutex_unlock(&epc->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_wakeup_host);

Which endpoint function driver uses this? And when does it have to be used?

Update Documentation for any new API's here
Documentation/PCI/endpoint/pci-endpoint.rst

Thanks,
Kishon
> +
> +/**
>    * pci_epc_stop() - stop the PCI link
>    * @epc: the link of the EPC device that has to be stopped
>    *
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 301bb0e..a8496be 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -59,6 +59,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
>    * @start: ops to start the PCI link
>    * @stop: ops to stop the PCI link
>    * @get_features: ops to get the features supported by the EPC
> + * @wakeup_host: ops to wakeup the host
>    * @owner: the module owner containing the ops
>    */
>   struct pci_epc_ops {
> @@ -88,6 +89,7 @@ struct pci_epc_ops {
>   	void	(*stop)(struct pci_epc *epc);
>   	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>   						       u8 func_no, u8 vfunc_no);
> +	int	(*wakeup_host)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
>   	struct module *owner;
>   };
>   
> @@ -232,6 +234,7 @@ int pci_epc_start(struct pci_epc *epc);
>   void pci_epc_stop(struct pci_epc *epc);
>   const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>   						    u8 func_no, u8 vfunc_no);
> +int pci_epc_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
>   enum pci_barno
>   pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
>   enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features

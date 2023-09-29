Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14127B2F29
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 11:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjI2Jal (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 05:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjI2Jaj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 05:30:39 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBA6193;
        Fri, 29 Sep 2023 02:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEXrDh0j5t2b4IQk1qwoD6Nv5zltDP2PAof7g1FQC7VXK77SeJ9aDzuwfLWiuH3sd3eY3etICYg0YNYIAdf6rTpfKC0zA2sMH+ksOoQaqRwwEk01LJNZA7BHPIpO19ptxeF8B2LjdKjd46HLtv66FtwyNA8uhG1tZXCUSyiYFpeMZldKILVBaLE3Xv7bNe3w5Pk3dtalrmWupfO06aFsBm00luoHyaHuyt92r2GMmPJ8xEf+LwkAeKfJTBuY1dZTF7KBJHRWXPDIJHJiHULVVNt2ljowLM5jW1OkOooYWCMML/1t526FL8FRzYZCAfikjmBPO1l2RpbAYZ4QhMnQGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iphzvOWsjvax+TkAjXnF9J+565UE9ADDNabZtIbJ7Hw=;
 b=gsrfefJvSay8UzmfZ398H9WAHVq2fpggGDpiF8RqcIprs1eREUQJwjw6dwPWo9AkseYN3ggQkhl7zXnSwAXoMGDEW2dIh60eaNDiQ960vFJ4AnYdV6OuviTu5dRN2ueVhdzNbyXcVXUc3Y+K/Pq/Dk6lF5e2OtCWHQxKaB9PWcjqjZIxfCvPZ/FOlz7BF7YKb4oi2aIxHXCTvbGQ53eWcBVKjkCNcA34iOndZkbJVaqUXlsQ+DTRG6+27WuqlsfC7pCrO2UBdwmMNPdAppnybeTuv2kcbD2Iy0niXqjCfjLP3y/bNsKBYm0tM6zctu93/6kz1RPVUnUFI5gmtyKBhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iphzvOWsjvax+TkAjXnF9J+565UE9ADDNabZtIbJ7Hw=;
 b=rRDjRq82Mx6XWwKVY9T04x/OeO8zduEf8qvpAJgffb7wkAetEptdUHVkgTxqQuVVLDfpsg0DxjNeQzK+JPzStQVPnZlM33cTfIhysVv3XzgsjLIQqV9r5wPd7FNIu68RXlFzVszRjVo9h8oeiRY4wxAqwesJGoCz4Okk1ezgQVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 09:30:31 +0000
Received: from BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::3b23:4df3:c8f4:4585]) by BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::3b23:4df3:c8f4:4585%4]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 09:30:31 +0000
Message-ID: <8918a885-b803-5430-8200-6b97c8782d76@amd.com>
Date:   Fri, 29 Sep 2023 15:00:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
To:     Frank Li <Frank.Li@nxp.com>, manivannan.sadhasivam@linaro.org
Cc:     aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <20230911220920.1817033-2-Frank.Li@nxp.com>
Content-Language: en-US
From:   Kishon Vijay Abraham I <kvijayab@amd.com>
In-Reply-To: <20230911220920.1817033-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::29) To BL1PR12MB5827.namprd12.prod.outlook.com
 (2603:10b6:208:396::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5827:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd67037-02fe-4cde-1604-08dbc0ceb91d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OrQXpI4zbDQRdumrPYVkwpFhM/MtGjgEL5cRZqUvknQRs0DMK+JjomjovvIATmjihJB/KzigTndphMMlVEjMvr5aDGQaVa8iQCb+vsE9Rb0QgM7v2rXI0j4tAkod9Wf03PO8N+AlnUMKRnW2y+FX4NkHBOOAiM01f6YFsYwbnecyyvvmdCkldch60oRyU1qSk0g8DGX+Jw17uJIOQJ2PrJIdEfP4itKGDaZciphE7sDbNW9Co1lrJHSub251E+cGWjw7UKPDfa/RixTmgKhUVUaqsNuTXaj6pEqoR/rQ0UufII/UeWSqfXpY+qMJxIKehDh/IpcDZDmZ+IjKwik1mXP9vg+fd8oOkCZ6J2JOA25OnPYRlkV33dT+3BVRNY75TVAMKoBH7zZVHFY6j1Z4EL3eWXO4rijwY0EdnevVz/r/cK8lQ5Bp7++YK2L0iGhcvyiecDc29kstfzuTnCGBeHlfgoqH8Bbtop/gElasl/76eL8sjadYMKtxj76k/YfhLrawb5AUdpuGQfPGIdIEuNXxq+TTVzmRHo39ssz4lqHNLOf8isqFbibHGilY0OBxBUw23YxBMuFpEbGBqzeoFE8FjtwJLJxGDuxiH1CleEYcFDQz6pPXz0qLn4n4zSjRAs5Xa68jfas2QzI5wVeH3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(66899024)(6506007)(6486002)(6666004)(6512007)(53546011)(2616005)(26005)(66556008)(66946007)(31696002)(478600001)(38100700002)(66476007)(83380400001)(2906002)(7416002)(8936002)(8676002)(4326008)(316002)(41300700001)(5660300002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXFMZjdkZHJhaHpPYWk2b2ZkS1hBbVlSZDU3ZjRyV0F2eVJaODMzZEZyVDZr?=
 =?utf-8?B?WFJFNDNkTTVzb1NuNUt2eFBsek9HVVk4YTB0YmFoZ1orUmxpUzZxczcrZ1Iz?=
 =?utf-8?B?cndXb0NZcmg1SkNCeit4WlI3SWRsOWhTWW9OaWZQZG51VlFOR3g3T0pzVjRr?=
 =?utf-8?B?dXUxMzI4NXllOC9QRkk1bUxDT09oazBLZTFqRElpQUVOQ2I2cEJ5WHZJOG9I?=
 =?utf-8?B?ck1mSHJvZVRTT251ZmI5d2lKcGVUdzBsaVNoRUl6bGJrTTN2WTJkSWlnT09X?=
 =?utf-8?B?VjNvK3Q1VkxvcCtjeCtJRUFtRWNraEVEM2JoOG1ONG1PVXJUdTN1MHY1RXdu?=
 =?utf-8?B?S3Q2VnN4UUliRXVhNFFSZlFBRHRsMkVHdTJSeDg2R3Q2VDZnblJDbmp0T09D?=
 =?utf-8?B?L0d3Z1dnL29aNlltK3FROW9EVlZWNmxGeTBVU3VHMUE0Ty80cXNsUFJjVURx?=
 =?utf-8?B?cjVXcFErNmNJVXJIMnBTMXZRQ2FKbWw5dG0zQ1BNbjVIR1JyY2h2Q3ZCT2ZV?=
 =?utf-8?B?WTc4andwV3VNcjZ2SmRkTmFSNW5pMGdKc041Y3Y5K0lFWUJoZnJ2U0hoblZu?=
 =?utf-8?B?UkRHa1ZwcHRrclpjdUN5cExjWWVyb3poVlhjalE0M3luMnRrZTI1WDhnNGE0?=
 =?utf-8?B?OTJyYUxmRXRYdXREWWJSbE1iV3pvNWRENTErSGh3V29kLzlQREFFZ1FUSHdZ?=
 =?utf-8?B?Z3ZzbHB0WHQ3b1ZTcTU1UWtlcE1qSW1FNTJ1V2dZcWVGQy9IM3dVUUc3ZFBZ?=
 =?utf-8?B?THBVcmtYR3ROcTIyQW1rbkwrZXFaL3pUOFhVY0RSNHBmTnFzSWNvZGh2V0ZE?=
 =?utf-8?B?ckNIdWdHeVFSYWw2S0Jab2pXZWNicDBiNlh4ZEpnNGxaT2lIblIwKzIyZUti?=
 =?utf-8?B?aGVoMlJYeU1YM285am15dkZwN1IwL2ptR2VRTWVqeXowT2NsSkhEbi9Mb1Ir?=
 =?utf-8?B?cEZjRG5VNnBMQVdNclVBUFdxYzUvTzI5WnN3S2w3eVJHeDc5VDlTTHc0aEh5?=
 =?utf-8?B?NTNKQ0J3KzVVZHEyWHp5RDMwWDlhK2liVDdINEp4andMZGR4MVRtekFEQWZR?=
 =?utf-8?B?SDNMWFhLa1c4N0c2bHc3YnY4RGxpL1RCNFZVQW56ZjlTZ2FGd3ltOWhxM1Rp?=
 =?utf-8?B?MndZMitWei9rOWhTTUIrR25ldCtkWkhHczJDQXM5NkZHMGhQaVlmMjUrdnpr?=
 =?utf-8?B?dkpXRllrOWxyM3p2UXpPZU1tM1duSFRkbG16aURYbTNZbDJ1LzViclNocmIw?=
 =?utf-8?B?MUticnY3RWpaZUFZT2JaY0ROT3lMbDdzaWd0VmloRC8rWWhZTnhLS1grSVFF?=
 =?utf-8?B?enFrUTNBVWVPcUVDQ2x0K0Y0enpsLzJGcEQrdVVLeFBaV0tYZ3M5UHpaSkx3?=
 =?utf-8?B?dityYUQ0Zm9GMjhKRFhwamtaNFNXZkNEUGRSMXdwc1Z1clJqVEdwNC8rTEJU?=
 =?utf-8?B?d2M0cWE4WEZIUUxGN3RsL3lMNEpiUmhjOVFwMGlCaDk3OGV0T0xCcXpyNmxi?=
 =?utf-8?B?TFU4ZlFiTmpjVzJEdEd4bExCS1VaQWJlQ0QxVnQzN2hxN0NGMkRJS1N4bVYz?=
 =?utf-8?B?UC9xT0greXVWYVArU2Zvb2kxd2kvekZtSE5meisyZFUwOTZMdENHUlVmdUov?=
 =?utf-8?B?ZHNBcHdxdVhpTDZLV2dHdWdadGJncm1CY3FrRDIxK3o3clJFYm4xWGtCTmFr?=
 =?utf-8?B?YlpLRm8yeXBud2hFTEN3b3IxL1VCdXQ3dmY2R25KZkp5U0lxZjVjN2ZlYnRi?=
 =?utf-8?B?R1VNM1RHVzBxM1FTZ2hIMjRVNHR2V3I5RmpZZkRsRFRxdStyYnJMR0FjVFhK?=
 =?utf-8?B?NGVSbkxzdHhsTk9RZ24yRHNyV1k3UVFVcmN0V2JhYWlwSUNyNU0vdXR6eXdr?=
 =?utf-8?B?c25tZElESG1kM1RCTUxMcWNHNXQ2OXJ1REt5UU51TjBQc3BaTjJXL1k3dEJq?=
 =?utf-8?B?QnJodXFBN0pkdU1LeVptamltSEVocVpOZUhZdGk3MCsxMVhTekc0WEdZcFFW?=
 =?utf-8?B?Z2REaTRQRnVkY2dlM3V6Ty90OWFyWHdlb2p0WjRrWS9YRllOcmI5aFJCUEVQ?=
 =?utf-8?B?SGdjKzNqR1RiUzdNMkNJVTV1ZkRva2o4WFVydkd5dERHcytTS0djNndsNm9L?=
 =?utf-8?Q?ubqfD5nDG9grakYkPYQlncJuN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd67037-02fe-4cde-1604-08dbc0ceb91d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 09:30:30.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncSi4EtOsLy6crS+vv4dXV2jcpvFssPsPrL3xETr1kqnlyiuIHW3w0ByzElb1r4oLZs06/zCoVywhVZYWVcbRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank,

On 9/12/2023 3:39 AM, Frank Li wrote:
> This commit introduces a common method for sending messages from the Root
> Complex (RC) to the Endpoint (EP) by utilizing the platform MSI interrupt
> controller, such as ARM GIC, as an EP doorbell. Maps the memory assigned
> for the BAR region by the PCI host to the message address of the platform
> MSI interrupt controller in the PCI EP. As a result, when the PCI RC writes
> to the BAR region, it triggers an IRQ at the EP. This implementation serves
> as a common method for all endpoint function drivers.

This would help avoid the polling used in current EPF drivers. Thanks!
> 
> However, it currently supports only one EP physical function due to
> limitations in ARM MSI/IMS readiness.

Any such platform or architecture restrictions should not be handled in 
the endpoint core layer.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>   drivers/pci/endpoint/pci-epc-core.c | 192 ++++++++++++++++++++++++++++
>   drivers/pci/endpoint/pci-epf-core.c |  44 +++++++
>   include/linux/pci-epc.h             |   6 +
>   include/linux/pci-epf.h             |   7 +
>   4 files changed, 249 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 5a4a8b0be6262..d336a99c6a94f 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -10,6 +10,7 @@
>   #include <linux/slab.h>
>   #include <linux/module.h>
>   
> +#include <linux/msi.h>
>   #include <linux/pci-epc.h>
>   #include <linux/pci-epf.h>
>   #include <linux/pci-ep-cfs.h>
> @@ -783,6 +784,197 @@ void pci_epc_bme_notify(struct pci_epc *epc)
>   }
>   EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
>   
> +/**
> + * pci_epc_alloc_doorbell() - alloc an address space to let RC trigger EP side IRQ by write data to
> + *			      the space.
> + *
> + * @epc: the EPC device that need doorbell address and data from RC.
> + * @func_no: the physical endpoint function number in the EPC device.
> + * @vfunc_no: the virtual endpoint function number in the physical function.
> + * @num_msgs: the total number of doorbell messages
> + *
> + * Return: 0 success, other is failure
> + */
> +int pci_epc_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs)
> +{
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> +		return -EINVAL;
> +
> +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> +		return -EINVAL;
> +
> +	if (!epc->ops->alloc_doorbell)
> +		return 0;
> +
> +	mutex_lock(&epc->lock);
> +	ret = epc->ops->alloc_doorbell(epc, func_no, vfunc_no, num_msgs);
> +	mutex_unlock(&epc->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_alloc_doorbell);
> +
> +/**
> + * pci_epc_free_doorbell() - free resource allocated by pci_epc_alloc_doorbell()
> + *
> + * @epc: the EPC device that need doorbell address and data from RC.
> + * @func_no: the physical endpoint function number in the EPC device.
> + * @vfunc_no: the virtual endpoint function number in the physical function.
> + *
> + * Return: 0 success, other is failure
> + */
> +void pci_epc_free_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> +{
> +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> +		return;
> +
> +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> +		return;
> +
> +	if (!epc->ops->free_doorbell)
> +		return;
> +
> +	mutex_lock(&epc->lock);
> +	epc->ops->free_doorbell(epc, func_no, vfunc_no);
> +	mutex_unlock(&epc->lock);
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_free_doorbell);
> +
> +static irqreturn_t pci_epf_generic_doorbell_handler(int irq, void *data)
> +{
> +	struct pci_epf *epf = data;
> +
> +	if (epf->event_ops && epf->event_ops->doorbell)
> +		epf->event_ops->doorbell(epf, irq - epf->virq_base);
> +
> +	return IRQ_HANDLED;
> +}

IMO the handler should be directly implemented in the EPF drivers. There 
should be one API which returns the virq and the msi_msg to the EPF 
driver and the EPF driver should do request_irq.
> +
> +static void pci_epc_generic_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> +{
> +	struct pci_epc *epc = NULL;
> +	struct class_dev_iter iter;
> +	struct pci_epf *epf;
> +	struct device *dev;
> +
> +	class_dev_iter_init(&iter, pci_epc_class, NULL, NULL);
> +	while ((dev = class_dev_iter_next(&iter))) {
> +		if (dev->parent != desc->dev)
> +			continue;

Ideally the msi_desc should be associated directly with the EPF device.
> +
> +		epc = to_pci_epc(dev);
> +
> +		class_dev_iter_exit(&iter);
> +		break;
> +	}
> +
> +	if (!epc)
> +		return;
> +
> +	/* Only support one EPF for doorbell */
> +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> +
> +	if (!epf)
> +		return;

If this is a platform restriction, this should be moved elsewhere.
> +
> +	if (epf->msg && desc->msi_index < epf->num_msgs)
> +		epf->msg[desc->msi_index] = *msg;
> +}
> +
> +
> +/**
> + * pci_epc_generic_alloc_doorbell() - Common help function. Allocate address space from MSI
> + *                                    controller
> + *
> + * @epc: the EPC device that need doorbell address and data from RC.
> + * @func_no: the physical endpoint function number in the EPC device.
> + * @vfunc_no: the virtual endpoint function number in the physical function.
> + * @num_msgs: the total number of doorbell messages
> + *
> + * Remark: use this function only if EPC driver just register one EPC device.
> + *
> + * Return: 0 success, other is failure
> + */
> +int pci_epc_generic_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs)
> +{
> +	struct pci_epf *epf;
> +	struct device *dev;
> +	int virq, last;
> +	int ret;
> +	int i;
> +
> +	if (IS_ERR_OR_NULL(epc))
> +		return -EINVAL;
> +
> +	/* Currently only support one func and one vfunc for doorbell */
> +	if (func_no || vfunc_no)
> +		return -EINVAL;
> +
> +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> +	if (!epf)
> +		return -EINVAL;
> +
> +	dev = epc->dev.parent;
> +	ret = platform_msi_domain_alloc_irqs(dev, num_msgs, pci_epc_generic_write_msi_msg);
> +	if (ret) {
> +		dev_err(dev, "Failed to allocate MSI\n");
> +		return -ENOMEM;
> +	}

The alloc_irqs should be for a EPF device IMO.
> +
> +	last = -1;
> +	for (i = 0; i < num_msgs; i++) {
> +		virq = msi_get_virq(dev, i);
> +		if (i == 0)
> +			epf->virq_base = virq;
> +
> +		ret = request_irq(virq, pci_epf_generic_doorbell_handler, 0,
> +				  kasprintf(GFP_KERNEL, "pci-epc-doorbell%d", i), epf);
> +
> +		if (ret) {
> +			dev_err(dev, "Failed to request doorbell\n");
> +			goto err_free_irq;
> +		}
> +		last = i;
> +	}
> +
> +	return 0;
> +
> +err_free_irq:
> +	for (i = 0; i < last; i++)
> +		kfree(free_irq(epf->virq_base + i, epf));
> +	platform_msi_domain_free_irqs(dev);
> +
> +	return -EINVAL;
> +}

Thanks,
Kishon

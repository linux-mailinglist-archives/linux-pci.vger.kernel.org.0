Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCA37026E1
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 10:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbjEOIJs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 04:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240313AbjEOII1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 04:08:27 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DF51FFA;
        Mon, 15 May 2023 01:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/rcl3qRXteB71p0EiDfsJ2eZOu08ju3/38RRsSUmxY1uR8JogOIZjw5SjQMXjW2rOEq+DBvqo6AoXncRQdcF8Uubn0nzscarIVBNEFW0+s4f5qJkyvlctiUnV+1edEk2z/VvFvCmMtocy8R3oxIPnCRESS9nMl2xO3T/nD4F+e5OOxydva3JbbYKrv7/h40QiMx7Y0XXt7q2VJHlDWd9zgziQyPRxxbw9E7w3LjYbhGUFKJ4953jO8hqdp9AWDpu6kPkDnbl+Y0jIOp9vh9Z9TEwu2gwChKqUkQnmKjaXHH4MVYEGYjhlkQusmO5fhoCa0dtHRfVadqFKmGSHz5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+J+c3ymDSF9daKVyWioapX4K3WMRXQaJxugRuYS8Kj0=;
 b=a7Tv3Jy3w8A+vexDF+b4zJyvmjJmV/32nurX9pG523zkipP3ueNLIYN4Bt0nXZqwRaFnL5IIhb8z5RdIhP18aitQKVwSY511uWSGOGZHEMulQgRRs2tA1bBvMIER9E8EXPyrqZ6lwMmiANKKOIKS1Gr304ey8DClPTfqco6BitbSgH8aR8vxVuCDcdfi9VCoT6bn0OLiu4Vl2sjT07Um7bDLctRgxofYwAUwVYnHE10LToQf10r+wF5d8ZEtzHToitBg4v02ZYEY5BithOufEMBfWKxbvgTuPHOb0m6+SowJqNKNKT+6Rdr3NLLt45Uu0IgidUXc1ojXYIWh7J9qfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J+c3ymDSF9daKVyWioapX4K3WMRXQaJxugRuYS8Kj0=;
 b=b4JevKhN7qzgyhkBL5d9LQkN8KzMkAi5mU7AFOSzebJIXCllSBj59ZmdZzOgXkiu2sWiH6JRAdHAwlXr5KORQHF1chmQm2a7GxOSZrYtheegjvziWwBs2jRXaIg1/J3tXkqfAgVqnSBaMaZyVLUSjuuzwqIQRJrtCcu1qaFHyG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) by
 MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Mon, 15 May 2023 08:07:38 +0000
Received: from DS7PR12MB5839.namprd12.prod.outlook.com
 ([fe80::8d75:647d:7520:a63b]) by DS7PR12MB5839.namprd12.prod.outlook.com
 ([fe80::8d75:647d:7520:a63b%7]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 08:07:38 +0000
Message-ID: <d25fdf75-e1fe-b83b-cb9c-ec0fb62f9254@amd.com>
Date:   Mon, 15 May 2023 13:37:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH v3 7/7] PCI: endpoint: Add PCI Endpoint function driver
 for MHI bus
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230314044623.10254-1-manivannan.sadhasivam@linaro.org>
 <20230314044623.10254-8-manivannan.sadhasivam@linaro.org>
From:   Kishon VijayAbraham I <kvijayab@amd.com>
In-Reply-To: <20230314044623.10254-8-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::8) To DS7PR12MB5839.namprd12.prod.outlook.com
 (2603:10b6:8:7a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5839:EE_|MW4PR12MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: 942794b8-57cb-46a8-50fd-08db551b728f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+5gn+v0Il5hfm/qSdziiujBz1OUXRB3qAc22/lbZ8kamuxGFpGyhVsfvFc1hJPUGpK8yT1YZdsPWtpZkslZTzvOP9L+Pjrl7HjZfDxtK0/TWyQQbYtsM6K0FV1e3lM4FE1nWn7qplcQj68jj6McCaib+/Zrfo/lvi+JU/SMUb2K/h9AEgq3iS58qeMhtmHi6Nzr0pLbfP0R1r0qzE3ICCrXQHXdMOQ/fz+wbu/sw1YJVpYxmbHjF7PqsVbA27wY/cc1W8I1G7fP8Wl4Welt2wixAPX/Fy79eWt2GzYQsOgfgoVQYx0pw7TQMD7KdYirOPFAN/5IPLZE6Xmhc32RnOQDT5Rdo+s2svLAmrHk1aI3DMW4fXOGqgMNnPDSlLQjjTVILcuqowgM9w7qDPvOryE5+jZD4/Y4k+zWO9dOf0kYExe1q1PEYA071y3CKAZK4SRJDn/NkSq+LZMJRLjJcEzUfvLnXs5y+sC0F+cHk14NMZyov2qdkqUhBbfYppaShLdHfD90ph0XkxBbQ2kYjwPTscIzz3c5Al3lo6NeIVz8U8lE82r0Eps3HfsjBXQqYGwJZ0UWA42L2c+sd4O9BNTyxVCyyDt04938CmdSsLiBN595or0M3QnYxKMHleUk7VRZXWZiVKvwbZjsBQWp6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5839.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(31686004)(66556008)(4326008)(66476007)(478600001)(66946007)(6506007)(186003)(53546011)(6512007)(38100700002)(2616005)(36756003)(8936002)(8676002)(2906002)(6666004)(6486002)(316002)(31696002)(5660300002)(41300700001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajFDMzRDWm1ndm8zc0s0U1BwV0ZXRVRKNVBCTEd3aXh5aklyOTkrQnNJZmQ1?=
 =?utf-8?B?UUhLUTFTYzREN1h4REpwcXFiRFd5MjR5eDNibW1pUHdHc2phMVFDZHRJVG01?=
 =?utf-8?B?THJqNTZ2MFpiNGpnaUh0RHN4ZVhGKy9uSmJ1VFFLVWxheWt0UVd1ZXVJdFls?=
 =?utf-8?B?anNPY1RZdmdlSlp4OUhTVkpuS1RzMEdjSkxEMlA1V29hbzlaZGQ0SDZHc1hU?=
 =?utf-8?B?bG1TYzZIOGlEUjdqSkZsdFlKbHZtRndnUmpOYUtMR1ljUE9VK2c5MnlhVG5n?=
 =?utf-8?B?alZDR2F4TUo4WEpUWUNweXZDVU1BVnliS2hvVmFpNUltcy9Ya3lRUXFibk85?=
 =?utf-8?B?NEJuNzJXWkNDVytVZldHYzBmZUJJbFJ2bjNBVlFFYnIvaEcvRzVNNS9SaEs2?=
 =?utf-8?B?Z0tXR3k2RmhaQmFaZER2QjlQNHlyeTFLN0Q0RStzQVQzRUU5RTJPazVpS2l0?=
 =?utf-8?B?N3pGSUdHMHdLZUd1NUNGU000ajlqZFk1Tm44dGkyRnRvSlZVZ1l4dmVWTGNZ?=
 =?utf-8?B?UkdOU3dRclZrMytWUjdDK0oyMDltTmlTNVI1ZjhqTldhWXk5OEhxdU4xSEtU?=
 =?utf-8?B?aG9aWms4aXFTVXd6MXdQVkY4UUhGY0g4bXMrM0FNU0JDcEhtcnRKa1JnMTg3?=
 =?utf-8?B?NDVjWWc5RUhkUm9GVGpXVXpOUnR3cDA0c2xBM01xaGl5aUJ4UER2cWp5dlo4?=
 =?utf-8?B?eWduSWhjSEtacmVrN2pOb1FxUXc5VE5KL24zc1lHaUtYZU9BVEJmVnY5RGZQ?=
 =?utf-8?B?L3liT1RqQ05MNHlVSk8ySmJ3cUtZdEVUQllRbUwwTjVrS085b0MwYmNPN1N5?=
 =?utf-8?B?VkVhd09IWXl0b2c0Z01JNDFQVjZCNEVMU0F6NjdrSWd1SEZNLzNTVjBLZUZL?=
 =?utf-8?B?NGdRaFp3Rlp0dHFpVnBkZFJOVHY3dVN5ZmtLTVliM0ZuM3JQZ1o2WmZtcDhP?=
 =?utf-8?B?SDZxMWJVUHdoVmNTVkJYWlhwUUQrSTI0cUNxZU1JVVZidG5jOEoyOVljYVRZ?=
 =?utf-8?B?SGJBNGFUaFVtS3JIU0tEcXRVdDNMQ2wvRTZqNWZHU0sra1diQmthVTNuQlFz?=
 =?utf-8?B?bkdUUFVHaytEcExyZkNRakI1OXYwWVhMY1BCZ0pDK3BhdTllUlNOemV5UUNG?=
 =?utf-8?B?eW5reWR3SlZsejBMVzA5VHZ0dnJFTU9za2NkQ2JhYWJRVzdTWEJIM0xMSlh5?=
 =?utf-8?B?RFJ2YVFabjdDWENzOUE0aGEyRm0xQ0lBL3cyTEt5UDZTZmdPbkZLc1FMVEh3?=
 =?utf-8?B?REw2VWFkb3A5aWtuZCtwL2pVNjFNWFFKNkdicFNHNWo0UTlGdXY3RFVCaFBI?=
 =?utf-8?B?VzJhb1VoM3dJN1ZtQXRFVGNPNjZRR1JydUhMQVV6QlpFK0p6c2hQTUpuM2Zs?=
 =?utf-8?B?dkV5VTAvc0dGeVk0cGNZd290VEFrRkh0Syt0dXB2MXMzMUc1Sy9NT1BxUG5W?=
 =?utf-8?B?M0VDbHlpWHVhZWs3K2RLeDVNTnRPVFpNVGIwUWI4OEtjODczWmhzcWNETVF0?=
 =?utf-8?B?d3FSNlBhaDQ2dDcwWXZiVVBsaEF6eFpMQ0FPS2xmTHFKb2VrZlczaFFYYzds?=
 =?utf-8?B?U2VmbEl6alhXc0FhZ3hZVFBKVVpyd0k4cHBRa28xenFTZGp4N3g3ZDk2Ty9a?=
 =?utf-8?B?UjIrKzhpcUJTYUV5NTdXSXhpK3haWFNlSE9QMk1UNFEzRGFjdmVNV3pOK3pH?=
 =?utf-8?B?Yy9jSkIrKzdGczdWa2lvVVZZK2g4ZW5Eb2dxOEZGWXJPanRHL0FwVDhwY2tZ?=
 =?utf-8?B?ZHRZZXdScHNkVlFTQ1I5M3VVNUNnUGVBZ09NRU1IQ09NeThJbEwzTWJmUXJC?=
 =?utf-8?B?MnFkVGpHNnJXZVo5dFpKRHN2T21ienVleUhQVnlRUHJlY3R5cWFtb2VnakRB?=
 =?utf-8?B?dVBhcmszMXZRNHZVOFY3SnVESnU4dzdRdFdsaEhIZVZhTkQyZElKdzN6OHBr?=
 =?utf-8?B?ZXZxUGJLd1d3R0dZTWlqeCtTeGxmb0xZdUk4YUd6b1RRTjBSL1Q4YkNWQ1la?=
 =?utf-8?B?b0tlTjcrRHVTbFBFeS9ZUmlaclVPdHg3Z043d0Z5STd6YkZDRUlXQTRiUnQw?=
 =?utf-8?B?czJZL3JHMlBlWlFJdDlUQmNXcG9xWkpBcHpyOXhWNUxYSDV1elRXaXVKSVpN?=
 =?utf-8?Q?RMD2H+U7Monw6ncOrzEK1t4Ld?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942794b8-57cb-46a8-50fd-08db551b728f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 08:07:38.1151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPjD4KAya9PoHYPMfCIHliE3p5GMj/j+v6t2sf0VX2eGoB0O+lfwehmvEU6PW3Z7Qa7u5KG+pyKHwr23/yp6sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Manivannan,

On 3/14/2023 10:16 AM, Manivannan Sadhasivam wrote:
> Add PCI Endpoint driver for the Qualcomm MHI (Modem Host Interface) bus.
> The driver implements the MHI function over PCI in the endpoint device
> such as SDX55 modem. The MHI endpoint function driver acts as a
> controller driver for the MHI Endpoint stack and carries out all PCI
> related activities like mapping the host memory using iATU, triggering
> MSIs etc...
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/endpoint/functions/Kconfig       |  10 +
>   drivers/pci/endpoint/functions/Makefile      |   1 +
>   drivers/pci/endpoint/functions/pci-epf-mhi.c | 454 +++++++++++++++++++
>   3 files changed, 465 insertions(+)
>   create mode 100644 drivers/pci/endpoint/functions/pci-epf-mhi.c
> 
> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> index 9fd560886871..f5171b4fabbe 100644
> --- a/drivers/pci/endpoint/functions/Kconfig
> +++ b/drivers/pci/endpoint/functions/Kconfig
> @@ -37,3 +37,13 @@ config PCI_EPF_VNTB
>   	  between PCI Root Port and PCIe Endpoint.
>   
>   	  If in doubt, say "N" to disable Endpoint NTB driver.
> +
> +config PCI_EPF_MHI
> +	tristate "PCI Endpoint driver for MHI bus"
> +	depends on PCI_ENDPOINT && MHI_BUS_EP
> +	help
> +	   Enable this configuration option to enable the PCI Endpoint
> +	   driver for Modem Host Interface (MHI) bus in Qualcomm Endpoint
> +	   devices such as SDX55.
> +
> +	   If in doubt, say "N" to disable Endpoint driver for MHI bus.
> diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
> index 5c13001deaba..696473fce50e 100644
> --- a/drivers/pci/endpoint/functions/Makefile
> +++ b/drivers/pci/endpoint/functions/Makefile
> @@ -6,3 +6,4 @@
>   obj-$(CONFIG_PCI_EPF_TEST)		+= pci-epf-test.o
>   obj-$(CONFIG_PCI_EPF_NTB)		+= pci-epf-ntb.o
>   obj-$(CONFIG_PCI_EPF_VNTB) 		+= pci-epf-vntb.o
> +obj-$(CONFIG_PCI_EPF_MHI)		+= pci-epf-mhi.o
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> new file mode 100644
> index 000000000000..03e7f42663b3
> --- /dev/null
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
.
.
<snip>
.
.
> +static int pci_epf_mhi_link_up(struct pci_epf *epf)
> +{
> +	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
> +	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
> +	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
> +	struct pci_epc *epc = epf->epc;
> +	struct device *dev = &epf->dev;
> +	int ret;
> +
> +	mhi_cntrl->mmio = epf_mhi->mmio;
> +	mhi_cntrl->irq = epf_mhi->irq;
> +	mhi_cntrl->mru = info->mru;
> +
> +	/* Assign the struct dev of PCI EP as MHI controller device */
> +	mhi_cntrl->cntrl_dev = epc->dev.parent;
> +	mhi_cntrl->raise_irq = pci_epf_mhi_raise_irq;
> +	mhi_cntrl->alloc_map = pci_epf_mhi_alloc_map;
> +	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
> +	mhi_cntrl->read_from_host = pci_epf_mhi_read_from_host;
> +	mhi_cntrl->write_to_host = pci_epf_mhi_write_to_host;
> +
> +	/* Register the MHI EP controller */
> +	ret = mhi_ep_register_controller(mhi_cntrl, info->config);
> +	if (ret) {
> +		dev_err(dev, "Failed to register MHI EP controller: %d\n", ret);
> +		return ret;
> +	}

Any reason for delaying registration with MHI bus till link up? Since 
after linkup, the host can start using the device, this should be doing 
minimal stuff IMHO. Or is there further handshake between the host side 
MHI driver and the endpoint side MHI driver?

Thanks,
Kishon

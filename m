Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA05F704407
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 05:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjEPDib (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 23:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEPDia (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 23:38:30 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAC5559A;
        Mon, 15 May 2023 20:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0FvGGW54jgRo4nxM5k10clxNDWVXcPKd0jP5yxGzF5avp09VddXRZU4bCr0H9zsnuH4DEPq0oPHtPIC08wF++wiMQyzQeasXQxklNkvqy4RXv/I0FbYO1rcifUzOtnkXxCp4ityIElnLsjzChKznUc4pnUylebIWB3Np5XBBSM826hbuCN3nA2tuEXZ6NjOe6WcJJuSzxPM4tNRjD3ytMaW1i9jRLI9YBaqX+fU5CdYPfXrPMrp049pz3GixQGxOySBN8KbYp9yxjLwzzbi6NaaR6/UGkpPdTILiMYdNbfbsrL//G4ruQOme3hKqQZdb+7NAwx8PtWNSXvCtV9Wqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GB2PhSJ+EdxaTDSJq+dy3tP4nGt87W3Tq9b7WvLXKE=;
 b=gbmdUJovEjsLl9LC3bz4IlejU9lKAUpzLH479iq89QQ5d9w9Z/bzy1s7C07LqM29phnvxAPBWYTBchGqYQvr82Ct8XYODJug6GPXEpe1UjS6YKAL8GNd3iy1cjxy8UHWloOR3gWboyLeFVCvfcZnRjgX8O/5PuU95lgKRJ+JhsSX2MVP8/bSzhvxgnHFhKtjOPDaevh7yPcj79HFldYPhkJe7MngDAfocUoYZaQyQNN93dVUqT9nCAPPycBImMFyTP7qDd+mfbNdjylfUef5bi3mdwltqBifqmygifjrp7FlSe+aG+BMAK3Tim+VY5yi/mJBT0sYD7kLcpGc4hkrUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GB2PhSJ+EdxaTDSJq+dy3tP4nGt87W3Tq9b7WvLXKE=;
 b=LZnRf0RVaIlN0tK1TNpJN2VxHkEDEg2+woiWjH3r9GZK0zHAYq7HjmDT0wUIg/znTzVVCX2radBnPwIOtBJv1y2jVqD2J7tEm05K6UdZc90ZsQNRVWcu48KPvigRmqUOhyJl+Aip4s/FK9daOcgrbL/zBflx5YqcrKyeTWhkgFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 03:38:26 +0000
Received: from BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::e7a5:8627:717a:d6f9]) by BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::e7a5:8627:717a:d6f9%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 03:38:25 +0000
Message-ID: <ff522b83-d84a-d76e-0317-e8ca55fb82b8@amd.com>
Date:   Tue, 16 May 2023 09:08:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH v3 7/7] PCI: endpoint: Add PCI Endpoint function driver
 for MHI bus
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kishon VijayAbraham I <kvijayab@amd.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230314044623.10254-1-manivannan.sadhasivam@linaro.org>
 <20230314044623.10254-8-manivannan.sadhasivam@linaro.org>
 <d25fdf75-e1fe-b83b-cb9c-ec0fb62f9254@amd.com>
 <20230515113647.GA42703@thinkpad>
From:   Kishon Vijay Abraham I <Kishon.vijayabraham@amd.com>
In-Reply-To: <20230515113647.GA42703@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::14) To BL1PR12MB5827.namprd12.prod.outlook.com
 (2603:10b6:208:396::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5827:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 86052c3e-9c10-489f-9359-08db55bf0160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KAShmMiUss5/2ZvIcbeOTnL9G7cDi2zJYRjfFZhanCo4pLCZZ+mr7W8fku4Rjgvez0FHoNRn166SKHLFKXiO5/uLEMynUqXH/dhqbXhqIYXhNCuG2izS2LyZdHRuU8hCSMy3BAuW/7XSUr3OPzTLMswJ/7aisDAqnCztXx/AyNB3oTn0lG14Skzcglh9yOm9iEohjEbvIDphLikNuBaQxsEdx0kEKKZoQbeINarc8nBoDcBbhiqda/nqFWuaBrG9mQOhIC51kvEiL8q8Zl+rxFyuMNgKnIgXamJFhtAAkKILvyY/CA4H6POoQwieYeQFDHmJB7+OYkV2OPf4PkXI6sDW9U7/++tRQQrlDJj4t7fxeH8drop6/dtiey6Cpkhgy9IJAq1TGJ9yVSzRyxFqAK5tdx3EPdgn1jWqN6GSrlid0Dbl0ur5YpEDlDod3LHNQtfIxVLZs0uVAYltNmhepQd9IqSRJoyjpnUTiljoHfQY1yRkD3zUEwxk+z77mlNCA/3VUq0xXyc6EyxLEttypz/psQs79eHE3kMrn80gQJQ514pvShUVoNETPNt4e4Ifghwm2xuDMGCssjOHYe3UgLxh93DlOuh9lNhsLjYKghEApJsh+Wl6LsJmPa8VUoWpqOiOBoDjgKp8RXli0HRaSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(478600001)(6486002)(6666004)(2616005)(6512007)(26005)(6506007)(110136005)(186003)(53546011)(2906002)(36756003)(4326008)(6636002)(66476007)(66556008)(66946007)(38100700002)(41300700001)(5660300002)(8676002)(8936002)(31696002)(316002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUNmQWY5YmNPb2hnT3Rnb0RCNVF1MUx4cE1sTTAvbDZpSWVrVjA4VFRlcGtI?=
 =?utf-8?B?dVZBcEdJSGovbnRsTmVQTGNoTUZ2TkNHc3EyTzcvc1hjeE9IbGR4TlFqSEMw?=
 =?utf-8?B?TWhYMGdNRzdyeHRJR0RwMVZBUjQwQmFrV1p4anM2VFdDOEdzRWF1YnlOWGhF?=
 =?utf-8?B?a0NXNVF2NGs0REJNd28wNUNVNzFrUXcvU1hSaG05Z1JidVhhbHp3aFlIYzBx?=
 =?utf-8?B?RUxxU05zci9NN3ZRZURCUmNMZ0ZCVDluUy9pMVFyS3llcFJScGJCNk82NzBC?=
 =?utf-8?B?d3IrWGkxQUhaVXhBOHBOTENxSnZPTWJZemo5M3ExOTkrYlEwaWFjdEo1MkFa?=
 =?utf-8?B?MncvS1U3T1FyZU9UaUJHNHA1czFuSFhCWmpHcGplRlFCSTg5cnJrN0FXQXVU?=
 =?utf-8?B?NWlqVTloUEFWc3p4TGhWc29qcGdBek1xLy9ieG5xZjliOHhLaGtvUkxIVnpF?=
 =?utf-8?B?V3lZQWI2K0JoSHJJbG1YZUVsYlpjalZiWDBrNm5oZTZvdmRlazQwa1VUemJk?=
 =?utf-8?B?ZlRqZWdSMkVuQnowQUsxdFVRaXNwU2tyU2xmRkI3TkgwbVVueUtWWitianoz?=
 =?utf-8?B?aXhzTXgvTW01YXM1Uzc5Nk5LNEhoZUo2SHdDUGVhMldQZHRsNlU5NGdlNk9o?=
 =?utf-8?B?Z01qdjZUUHN3TnZiTmVwQ3VUYXlPb2dlTUY2N09SWUNCc2hWYkNxYlEyck0w?=
 =?utf-8?B?azNPczYxTnVBb0hxeFdGQWlVd2xuN0plampnMmNsZnpXbVhJZklWMkMwMVl2?=
 =?utf-8?B?RmNJT3FwWHU1aG9nTDkvRE1iaTBHZmtDSTlMYXN3SGVWY2dUekEzZ28ycjJl?=
 =?utf-8?B?QVFhOWdKQ0NwbDBaYmJjOE9pSlg5a3diRkdWbHdOTTdjYUZwNmszelBYUis3?=
 =?utf-8?B?U2tnVC96QVdBU1RoVlZhanp5QWFhRXZUcmZUU2ZzLzlKZ1dvTk1pYTFnUTVi?=
 =?utf-8?B?SkU1bXBXcXNRMnpiU2hjeFVRdXhYZHVZaEh4ZytvYjBGcXVjYkkzejVYTDFq?=
 =?utf-8?B?Z2t4T1dLeDRpd2ZBZFlpeHVWQlA4US9jQ1BXYXdXRS9UOGFYd3B5VVV5MWhK?=
 =?utf-8?B?VGIrai9FMzBWSDErMUlITzJZcDZvUDZCZ1VBSHJIQzV6NGlYK3BDeVhIUmhh?=
 =?utf-8?B?TTQ0eEVJc3M0VURqME5VRUU2SVVSK2ZPZzFSNmxzT0lXSVJ1dklHUDRNN2xa?=
 =?utf-8?B?dUVWMEVTemd6NHF6Y0FRTU9CZ1hxRFdBb1F4dWJlMjRnd282M2JwTWlwSy9L?=
 =?utf-8?B?STk1UWlHM1lDSE1obE9ycE0vVGRWY2tER2gxK1Q2OXZwOFN5dUdabFVxSkcz?=
 =?utf-8?B?RzU5TUE5ZlRuNGo3djd5NFBIMFlGUHpRQysvQVpSTUlFY1dqaTA1VzN6YjFD?=
 =?utf-8?B?S3ZiWWNVOERjTldGWmh1eUY0bjZ0YVFYbmJnQXJiZ0hOaTU3RG12SUdFV3Vs?=
 =?utf-8?B?QXg4K3VwV29ZTEZMQTNWV0dsS0djeGFmZFViOUJDckM2a0hyVjJCMzREeTM1?=
 =?utf-8?B?YTVCK20rcXlydGZDQlJib1JzV1BUdXJKVlBIYmswT0JpM2E2TXlqbTRVNmtz?=
 =?utf-8?B?ZDNNR1dHUDVsRHZwdnRFVDdlVWJlUXQxSGRVdzJwa1BIeTNDbmJtRWFTOFZ6?=
 =?utf-8?B?ZkhaRE5qNEZtWmdwZmVYZ1IwenN1dTQ3V0RWN0QraWxFN3VTYUJPTGtKeFI5?=
 =?utf-8?B?aHZMbkFYaldTYSsxSlJUNGtNVU5qNWc2MzFVblVJUnd6UU9kQXlybVZ6K3dH?=
 =?utf-8?B?bHJrbnNJMUwxSjMyK0g0WkxKQVpXeU1leDBNU2NKYTBMNFVSRnhHMHIxQ0xQ?=
 =?utf-8?B?TE9BSkNMc1Z5MEV5VVFvdVF1RUZ2UWlDb1NiYXYvTU9JcFdrd1lEai9oSXZE?=
 =?utf-8?B?cXpuSncvRXE2UXQ3dmoyQ0VvZVpDSWVnN1hUVGZ5MmNqR3c3cGpSS2FLemNN?=
 =?utf-8?B?Y0lVM2MzQnZVdWVzYVBsNVRVRGxpckVRUW5HaUZTdDQ3MTVldFZJRDR1V05D?=
 =?utf-8?B?NGhlMG9UTDRmUHh1RU1ydzZrS3VBWkVEZG5RNHhHMmZnZWFPS3IxLzBDRDVv?=
 =?utf-8?B?VXdaV3BQWVlqM1E3Z1NiaVpHdjlYeGhNb3V5RCtpdXMvQklZN2JvcHJ4YXFv?=
 =?utf-8?Q?w34FtOWf05RWqfXLXmvddZP4w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86052c3e-9c10-489f-9359-08db55bf0160
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 03:38:25.7301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bI6Tt8J8qLOdsiwJ3FVOEzTyb7vkW4usvxW61ixm50587il6YxTPJS4IdH7YuDYYJ4cg0okHQHxvy6W0McVsxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/15/2023 5:06 PM, Manivannan Sadhasivam wrote:
> Hi Kishon,
> 
> On Mon, May 15, 2023 at 01:37:28PM +0530, Kishon VijayAbraham I wrote:
>> Hi Manivannan,
>>
>> On 3/14/2023 10:16 AM, Manivannan Sadhasivam wrote:
>>> Add PCI Endpoint driver for the Qualcomm MHI (Modem Host Interface) bus.
>>> The driver implements the MHI function over PCI in the endpoint device
>>> such as SDX55 modem. The MHI endpoint function driver acts as a
>>> controller driver for the MHI Endpoint stack and carries out all PCI
>>> related activities like mapping the host memory using iATU, triggering
>>> MSIs etc...
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>    drivers/pci/endpoint/functions/Kconfig       |  10 +
>>>    drivers/pci/endpoint/functions/Makefile      |   1 +
>>>    drivers/pci/endpoint/functions/pci-epf-mhi.c | 454 +++++++++++++++++++
>>>    3 files changed, 465 insertions(+)
>>>    create mode 100644 drivers/pci/endpoint/functions/pci-epf-mhi.c
>>>
>>> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
>>> index 9fd560886871..f5171b4fabbe 100644
>>> --- a/drivers/pci/endpoint/functions/Kconfig
>>> +++ b/drivers/pci/endpoint/functions/Kconfig
>>> @@ -37,3 +37,13 @@ config PCI_EPF_VNTB
>>>    	  between PCI Root Port and PCIe Endpoint.
>>>    	  If in doubt, say "N" to disable Endpoint NTB driver.
>>> +
>>> +config PCI_EPF_MHI
>>> +	tristate "PCI Endpoint driver for MHI bus"
>>> +	depends on PCI_ENDPOINT && MHI_BUS_EP
>>> +	help
>>> +	   Enable this configuration option to enable the PCI Endpoint
>>> +	   driver for Modem Host Interface (MHI) bus in Qualcomm Endpoint
>>> +	   devices such as SDX55.
>>> +
>>> +	   If in doubt, say "N" to disable Endpoint driver for MHI bus.
>>> diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
>>> index 5c13001deaba..696473fce50e 100644
>>> --- a/drivers/pci/endpoint/functions/Makefile
>>> +++ b/drivers/pci/endpoint/functions/Makefile
>>> @@ -6,3 +6,4 @@
>>>    obj-$(CONFIG_PCI_EPF_TEST)		+= pci-epf-test.o
>>>    obj-$(CONFIG_PCI_EPF_NTB)		+= pci-epf-ntb.o
>>>    obj-$(CONFIG_PCI_EPF_VNTB) 		+= pci-epf-vntb.o
>>> +obj-$(CONFIG_PCI_EPF_MHI)		+= pci-epf-mhi.o
>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
>>> new file mode 100644
>>> index 000000000000..03e7f42663b3
>>> --- /dev/null
>>> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
>> .
>> .
>> <snip>
>> .
>> .
>>> +static int pci_epf_mhi_link_up(struct pci_epf *epf)
>>> +{
>>> +	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
>>> +	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
>>> +	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
>>> +	struct pci_epc *epc = epf->epc;
>>> +	struct device *dev = &epf->dev;
>>> +	int ret;
>>> +
>>> +	mhi_cntrl->mmio = epf_mhi->mmio;
>>> +	mhi_cntrl->irq = epf_mhi->irq;
>>> +	mhi_cntrl->mru = info->mru;
>>> +
>>> +	/* Assign the struct dev of PCI EP as MHI controller device */
>>> +	mhi_cntrl->cntrl_dev = epc->dev.parent;
>>> +	mhi_cntrl->raise_irq = pci_epf_mhi_raise_irq;
>>> +	mhi_cntrl->alloc_map = pci_epf_mhi_alloc_map;
>>> +	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
>>> +	mhi_cntrl->read_from_host = pci_epf_mhi_read_from_host;
>>> +	mhi_cntrl->write_to_host = pci_epf_mhi_write_to_host;
>>> +
>>> +	/* Register the MHI EP controller */
>>> +	ret = mhi_ep_register_controller(mhi_cntrl, info->config);
>>> +	if (ret) {
>>> +		dev_err(dev, "Failed to register MHI EP controller: %d\n", ret);
>>> +		return ret;
>>> +	}
>>
>> Any reason for delaying registration with MHI bus till link up? Since after
>> linkup, the host can start using the device, this should be doing minimal
>> stuff IMHO. Or is there further handshake between the host side MHI driver
>> and the endpoint side MHI driver?
>>
> 
> Yes, there are further handshakes required between ep and host before the host
> can start using MHI and this is done during mhi_ep_power_up(). Moreover,
> registering the controller during link_up event allows us to do cleanup properly
> when the link goes down.

Thank you for clarifying!

For the entire series:

Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
> 
> - Mani
>   
>> Thanks,
>> Kishon
> 

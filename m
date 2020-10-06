Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F09284855
	for <lists+linux-pci@lfdr.de>; Tue,  6 Oct 2020 10:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJFIVf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 04:21:35 -0400
Received: from ns.iliad.fr ([212.27.33.1]:59422 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgJFIVf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Oct 2020 04:21:35 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2020 04:21:34 EDT
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id CAC98205AE;
        Tue,  6 Oct 2020 10:15:08 +0200 (CEST)
Received: from [192.168.108.70] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id B0FDF20590;
        Tue,  6 Oct 2020 10:15:08 +0200 (CEST)
Subject: Re: [PATCH v2 5/5] PCI: qcom: Add support for configuring BDF to SID
 mapping for SM8250
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, mgautam@codeaurora.org
References: <20200930150925.31921-1-manivannan.sadhasivam@linaro.org>
 <20200930150925.31921-6-manivannan.sadhasivam@linaro.org>
 <507b3d50-6792-60b7-1ccd-f7b3031c20ac@mm-sol.com>
 <20201001055736.GB3203@Mani-XPS-13-9360>
 <e63b3ed4-d822-45dc-de60-23385fb45468@mm-sol.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <1dd23bad-3bea-fb55-e1fb-05ea3497dfd3@free.fr>
Date:   Tue, 6 Oct 2020 10:15:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e63b3ed4-d822-45dc-de60-23385fb45468@mm-sol.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Oct  6 10:15:08 2020 +0200 (CEST)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 01/10/2020 12:57, Stanimir Varbanov wrote:

> On 10/1/20 8:57 AM, Manivannan Sadhasivam wrote:
>
>> On Thu, Oct 01, 2020 at 12:46:46AM +0300, Stanimir Varbanov wrote:
>>
>>> On 9/30/20 6:09 PM, Manivannan Sadhasivam wrote:
>>>
>>>> For SM8250, we need to write the BDF to SID mapping in PCIe controller
>>>> register space for proper working. This is accomplished by extracting
>>>> the BDF and SID values from "iommu-map" property in DT and writing those
>>>> in the register address calculated from the hash value of BDF. In case
>>>> of collisions, the index of the next entry will also be written.
>>>
>>> This describes what the patch is doing. But why? Is that done in the
>>> other DWC low-level drivers or this is qcom specialty?
>>
>> AFAIK, only some NXP SoCs deal with similar kind of mapping but right now
>> this is a Qcom only stuff.
>>
>>>> For the sake of it, let's introduce a "config_sid" callback and do it
>>>> conditionally for SM8250.
>>>>
>>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>> ---
>>>>  drivers/pci/controller/dwc/Kconfig     |   1 +
>>>>  drivers/pci/controller/dwc/pcie-qcom.c | 138 +++++++++++++++++++++++++
>>>>  2 files changed, 139 insertions(+)
> 
> <snip>
> 
>>>>  
>>>> +static int qcom_pcie_get_iommu_map(struct qcom_pcie *pcie)
>>>> +{
>>>> +	/* iommu map structure */
>>>> +	struct {
>>>> +		u32 bdf;
>>>> +		u32 phandle;
>>>> +		u32 smmu_sid;
>>>> +		u32 smmu_sid_len;
>>>> +	} *map;
>>>> +	struct device *dev = pcie->pci->dev;
>>>> +	int i, size = 0;
>>>> +	u32 smmu_sid_base;
>>>> +
>>>> +	of_get_property(dev->of_node, "iommu-map", &size);
>>>> +	if (!size)
>>>> +		return 0;
>>>> +
>>>> +	map = kzalloc(size, GFP_KERNEL);
>>>> +	if (!map)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	of_property_read_u32_array(dev->of_node,
>>>> +		"iommu-map", (u32 *)map, size / sizeof(u32));
>>>
>>> iommu-map is a standard DT property why we have to parse it manually?
>>>
>>
>> So right now we don't have a way to pass this information from DT. And there
>> is no IOMMU API to parse the fields also. We need to extract this information
>> to program the hash tables (BDF, SID) as the mapping between BDF and SID is not
>> 1:1 in SM8250.
> 
> We used iommu-map for msm8998 see this commit:
> 
> b84dfd175c09888751f501e471fdca346f582e06
> ("arm64: dts: qcom: msm8998: Add PCIe PHY and RC nodes")
> 
> I also Cc-ed Marc if he knows something more.

My memory is hazy.

I remember an odd quirk in the downstream kernel:

[v1,1/3] PCI: qcom: Setup PCIE20_PARF_BDF_TRANSLATE_N
http://patchwork.ozlabs.org/project/linux-pci/patch/958ae127-3aa2-6824-c875-e3012644ed3d@free.fr/

Manivannan, are you trying to deal with PCIE20_PARF_BDF_TRANSLATE_N
or some equivalent register?

+Robin, he's the one who helped me figure this stuff out (iommu-map).
It was in reply to patch 2:
http://patchwork.ozlabs.org/project/linux-pci/patch/82ab78ee-4a38-4eee-f064-272b6f964f17@free.fr/

In the end, I dropped patch 1 because... everything seemed to work
without it (?!) (Makes one wonder what it actually does. But qcom
refused to provide any register documentation, which is idiotic
because this is DW IP, and they are open-source friendly, IIUC.)

Regards.

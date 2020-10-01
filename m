Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374A427FDE7
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 12:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbgJAK6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 06:58:06 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:58964 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731913AbgJAK6G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Oct 2020 06:58:06 -0400
Received: from [192.168.1.7] (unknown [195.24.90.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id C3FFDD066;
        Thu,  1 Oct 2020 13:58:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1601549882; bh=aeX9p36tew60f0R0DEdoSn8LDBixknrj+HYsM83QCg4=;
        h=Subject:To:Cc:From:Date:From;
        b=BB8TEdyHqtY83Pya1Q1s6sUUOg+BTaI58jDzFhkUBrjqY5dk9CCi2k/LWf98m/5Yf
         GKddAmqEnLSCpciO37LnQUGnDH9MqIvl3PwvEo1Ik0IaXTgLSzOFtLonIuGbIyiQ7q
         ZMLjIGrAieWXGRgmxcC/zygHMCpVVj3qwQmGjMDik5J/dKuvv+yN43BjDLgFch9MIQ
         EiIHGK9BYKg9aZyizfZcLIxfrTPnR6SLH3fyYARl0smeRuPLh15P3lC1LL9U0/hrdH
         Di3G7m5qL8lYQdJHUY1Gu2gfsg8sUIR8KNR6P2+yQpNjEoU3IOFU8rYKtUDKjgxZ4I
         CXWAIaHJxlO9w==
Subject: Re: [PATCH v2 5/5] PCI: qcom: Add support for configuring BDF to SID
 mapping for SM8250
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
References: <20200930150925.31921-1-manivannan.sadhasivam@linaro.org>
 <20200930150925.31921-6-manivannan.sadhasivam@linaro.org>
 <507b3d50-6792-60b7-1ccd-f7b3031c20ac@mm-sol.com>
 <20201001055736.GB3203@Mani-XPS-13-9360>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <e63b3ed4-d822-45dc-de60-23385fb45468@mm-sol.com>
Date:   Thu, 1 Oct 2020 13:57:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001055736.GB3203@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mani,

On 10/1/20 8:57 AM, Manivannan Sadhasivam wrote:
> Hi Stan,
> 
> On Thu, Oct 01, 2020 at 12:46:46AM +0300, Stanimir Varbanov wrote:
>> Hi Mani,
>>
>> On 9/30/20 6:09 PM, Manivannan Sadhasivam wrote:
>>> For SM8250, we need to write the BDF to SID mapping in PCIe controller
>>> register space for proper working. This is accomplished by extracting
>>> the BDF and SID values from "iommu-map" property in DT and writing those
>>> in the register address calculated from the hash value of BDF. In case
>>> of collisions, the index of the next entry will also be written.
>>
>> This describes what the patch is doing. But why? Is that done in the
>> other DWC low-level drivers or this is qcom specialty?
>>
> 
> AFAIK, only some NXP SoCs deal with similar kind of mapping but right now
> this is a Qcom only stuff.
> 
>>>
>>> For the sake of it, let's introduce a "config_sid" callback and do it
>>> conditionally for SM8250.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>  drivers/pci/controller/dwc/Kconfig     |   1 +
>>>  drivers/pci/controller/dwc/pcie-qcom.c | 138 +++++++++++++++++++++++++
>>>  2 files changed, 139 insertions(+)

<snip>

>>>  
>>> +static int qcom_pcie_get_iommu_map(struct qcom_pcie *pcie)
>>> +{
>>> +	/* iommu map structure */
>>> +	struct {
>>> +		u32 bdf;
>>> +		u32 phandle;
>>> +		u32 smmu_sid;
>>> +		u32 smmu_sid_len;
>>> +	} *map;
>>> +	struct device *dev = pcie->pci->dev;
>>> +	int i, size = 0;
>>> +	u32 smmu_sid_base;
>>> +
>>> +	of_get_property(dev->of_node, "iommu-map", &size);
>>> +	if (!size)
>>> +		return 0;
>>> +
>>> +	map = kzalloc(size, GFP_KERNEL);
>>> +	if (!map)
>>> +		return -ENOMEM;
>>> +
>>> +	of_property_read_u32_array(dev->of_node,
>>> +		"iommu-map", (u32 *)map, size / sizeof(u32));
>>
>> iommu-map is a standard DT property why we have to parse it manually?
>>
> 
> So right now we don't have a way to pass this information from DT. And there
> is no IOMMU API to parse the fields also. We need to extract this information
> to program the hash tables (BDF, SID) as the mapping between BDF and SID is not
> 1:1 in SM8250.

We used iommu-map for msm8998 see this commit:

b84dfd175c09888751f501e471fdca346f582e06
("arm64: dts: qcom: msm8998: Add PCIe PHY and RC nodes")

I also Cc-ed Marc if he knows something more.

> 
> Perhaps I can add this information in commit message.


-- 
regards,
Stan

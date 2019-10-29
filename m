Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0234CE84AF
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 10:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfJ2JvJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 05:51:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:32413 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbfJ2JvI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 05:51:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 02:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="202791380"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 29 Oct 2019 02:51:07 -0700
Received: from [10.226.39.46] (ekotax-MOBL.gar.corp.intel.com [10.226.39.46])
        by linux.intel.com (Postfix) with ESMTP id CF3A6580472;
        Tue, 29 Oct 2019 02:51:04 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] pci: intel: Add sysfs attributes to configure pcie
 link
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <d8574605f8e70f41ce1e88ccfb56b63c8f85e4df.1571638827.git.eswara.kota@linux.intel.com>
 <20191021133849.GQ47056@e119886-lin.cambridge.arm.com>
 <6a209452-f569-4f6a-8aea-5c9f84167f5a@linux.intel.com>
 <20191025093457.GY47056@e119886-lin.cambridge.arm.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <0c680994-6d29-28a7-45de-7f76d79256d8@linux.intel.com>
Date:   Tue, 29 Oct 2019 17:51:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025093457.GY47056@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/25/2019 5:34 PM, Andrew Murray wrote:

>>>> +/*
>>>> + * Link width change on the fly is not always successful.
>>>> + * It also depends on the partner.
>>>> + */
>>>> +static ssize_t pcie_width_store(struct device *dev,
>>>> +				struct device_attribute *attr,
>>>> +				const char *buf, size_t len)
>>>> +{
>>>> +	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
>>>> +	unsigned long val;
>>>> +	int ret;
>>>> +
>>>> +	lpp = dev_get_drvdata(dev);
>>>> +
>>>> +	ret = kstrtoul(buf, 10, &val);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	if (val > lpp->max_width)
>>>> +		return -EINVAL;
>>>> +
>>>> +	/* HW auto bandwidth negotiation must be enabled */
>>>> +	pcie_rc_cfg_wr_mask(lpp, PCI_EXP_LNKCTL_HAWD, 0,
>>>> +			    PCIE_CAP_OFST + PCI_EXP_LNKCTL);
>>>> +	dw_pcie_link_width_resize(&lpp->pci, val);
>>>> +
>>>> +	return len;
>>>> +}
>>>> +static DEVICE_ATTR_WO(pcie_width);
>>>> +
>>>> +static struct attribute *pcie_cfg_attrs[] = {
>>>> +	&dev_attr_pcie_link_status.attr,
>>>> +	&dev_attr_pcie_speed.attr,
>>>> +	&dev_attr_pcie_width.attr,
>>>> +	NULL,
>>>> +};
>>> Is there a reason that these are limited only to the Intel driver and
>>> not the wider set of DWC drivers?
>>>
>>> Is there anything specific here about the Intel GW driver?
>> Yes, they need intel_pcie_max_speed_setup() and pcie_link_gen_to_str().
>> Once intel_pcie_max_speed_setup() moved to DesignWare framework (as per
>> Bjorn Helgaas inputs) and use pcie_link_speed[] array instead of
>> pcie_link_gen_to_str() (as per gustavo pimentel inputs) we can move this to
>> PCIe DesignWare framework or to pci sysfs file.
> I think the key concern here is this: If you introduce sysfs controls that
> represent generic PCI concepts (such as changing the link speed) - the concept
> isn't limited to a particular host controller, it's limited to PCI. Therefore
> the sysfs control should also apply more widely to all PCI controllers. This
> is important as otherwise you may end up getting a slightly different user
> interface to achieve the same consequence depending on the host-controller in
> use.
>
> If each controller driver has a different way of doing things, then it lends
> itself to having some set of ops that they can all implement. Or perhaps there
> is a middle-ground solution where this applies just to DWC devices and not all
> devices.
I see the better way is to move the implementation to PCIe DesignWare 
framework because of
the registers programming.

Regards,
Dilip
> Thanks,
>
> Andrew Murray
>
>>

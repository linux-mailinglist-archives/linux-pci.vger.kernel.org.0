Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C631E00BB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2019 11:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbfJVJ1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Oct 2019 05:27:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:32819 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731229AbfJVJ1p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Oct 2019 05:27:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 02:27:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="227638156"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 22 Oct 2019 02:27:43 -0700
Received: from [10.226.39.21] (unknown [10.226.39.21])
        by linux.intel.com (Postfix) with ESMTP id BED79580127;
        Tue, 22 Oct 2019 02:27:39 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] pci: intel: Add sysfs attributes to configure pcie
 link
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <20191021171832.GA232571@google.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <187a1a7d-80bd-a0e9-a0d9-7fc53bff8907@linux.intel.com>
Date:   Tue, 22 Oct 2019 17:27:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021171832.GA232571@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn Helgaas,

On 10/22/2019 1:18 AM, Bjorn Helgaas wrote:
> On Mon, Oct 21, 2019 at 02:38:50PM +0100, Andrew Murray wrote:
>> On Mon, Oct 21, 2019 at 02:39:20PM +0800, Dilip Kota wrote:
>>> PCIe RC driver on Intel Gateway SoCs have a requirement
>>> of changing link width and speed on the fly.
> Please add more details about why this is needed.  Since you're adding
> sysfs files, it sounds like it's not actually the *driver* that needs
> this; it's something in userspace?
We have use cases to change the link speed and width on the fly.
One is EMI check and other is power saving.
Some battery backed applications have to switch PCIe link from higher 
GEN to GEN1 and width to x1. During the cases like
external power supply got disconnected or broken. Once external power 
supply is connected then switch PCIe link to higher GEN and width.
>
> The normal scenario is that the hardware negotiates link widths and
> speeds without any software involvement (PCIe r5.0, sec 1.2).
>
> If this is to work around hardware defects, we should try to do that
> inside the kernel because we can't expect userspace to do it reliably.
>
> As Andrew points out below, this all sounds like it should be generic
> rather than Intel-specific.
>
>>> So add the sysfs attributes to show and store the link
>>> properties.
>>> Add the respective link resize function in pcie DesignWare
>>> framework so that Intel PCIe driver can use during link
>>> width configuration on the fly.
>>> ...
>>> +static ssize_t pcie_link_status_show(struct device *dev,
>>> +				     struct device_attribute *attr, char *buf)
>>> +{
>>> +	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
>>> +	u32 reg, width, gen;
>>> +
>>> +	reg = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCTL);
>>> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, reg >> 16);
>>> +	gen = FIELD_GET(PCI_EXP_LNKSTA_CLS, reg >> 16);
>>> +
>>> +	if (gen > lpp->max_speed)
>>> +		return -EINVAL;
>>> +
>>> +	return sprintf(buf, "Port %2u Width x%u Speed %s GT/s\n", lpp->id,
>>> +		       width, pcie_link_gen_to_str(gen));
>>> +}
>>> +static DEVICE_ATTR_RO(pcie_link_status);
> We already have generic current_link_speed and current_link_width
> files.

Thanks for pointing it. I will remove the pcie_link_status.

Regards,
Dilip

>
>>> +static ssize_t pcie_speed_store(struct device *dev,
>>> +				struct device_attribute *attr,
>>> +				const char *buf, size_t len)
>>> +{
>>> +	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
>>> +	unsigned long val;
>>> +	int ret;
>>> +
>>> +	ret = kstrtoul(buf, 10, &val);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (val > lpp->max_speed)
>>> +		return -EINVAL;
>>> +
>>> +	lpp->link_gen = val;
>>> +	intel_pcie_max_speed_setup(lpp);
>>> +	dw_pcie_link_speed_change(&lpp->pci, false);
>>> +	dw_pcie_link_speed_change(&lpp->pci, true);
>>> +
>>> +	return len;
>>> +}
>>> +static DEVICE_ATTR_WO(pcie_speed);
>>> +
>>> +/*
>>> + * Link width change on the fly is not always successful.
>>> + * It also depends on the partner.
>>> + */
>>> +static ssize_t pcie_width_store(struct device *dev,
>>> +				struct device_attribute *attr,
>>> +				const char *buf, size_t len)
>>> +{
>>> +	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
>>> +	unsigned long val;
>>> +	int ret;
>>> +
>>> +	lpp = dev_get_drvdata(dev);
>>> +
>>> +	ret = kstrtoul(buf, 10, &val);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (val > lpp->max_width)
>>> +		return -EINVAL;
>>> +
>>> +	/* HW auto bandwidth negotiation must be enabled */
>>> +	pcie_rc_cfg_wr_mask(lpp, PCI_EXP_LNKCTL_HAWD, 0,
>>> +			    PCIE_CAP_OFST + PCI_EXP_LNKCTL);
>>> +	dw_pcie_link_width_resize(&lpp->pci, val);
>>> +
>>> +	return len;
>>> +}
>>> +static DEVICE_ATTR_WO(pcie_width);
>>> +
>>> +static struct attribute *pcie_cfg_attrs[] = {
>>> +	&dev_attr_pcie_link_status.attr,
>>> +	&dev_attr_pcie_speed.attr,
>>> +	&dev_attr_pcie_width.attr,
>>> +	NULL,
>>> +};
>> Is there a reason that these are limited only to the Intel driver and
>> not the wider set of DWC drivers?
>>
>> Is there anything specific here about the Intel GW driver?

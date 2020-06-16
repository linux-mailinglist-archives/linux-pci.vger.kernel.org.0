Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314A11FAC10
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 11:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgFPJM7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 16 Jun 2020 05:12:59 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2312 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726805AbgFPJM7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 05:12:59 -0400
Received: from lhreml711-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id E1FF3719891E5005D90B;
        Tue, 16 Jun 2020 10:12:56 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml711-chm.china.huawei.com (10.201.108.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 16 Jun 2020 10:12:56 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Tue, 16 Jun 2020 10:12:56 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        yangyicong <yangyicong@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v9 2/2] PCI: hip: Add handling of HiSilicon HIP PCIe
 controller errors
Thread-Topic: [PATCH v9 2/2] PCI: hip: Add handling of HiSilicon HIP PCIe
 controller errors
Thread-Index: AQHWQv5GPLiMMOPNiU6kqnJ8IzwlUKjZgnyAgAFqP0A=
Date:   Tue, 16 Jun 2020 09:12:56 +0000
Message-ID: <51550b510d1e40479bf4fce47443747c@huawei.com>
References: <20200615101552.802-3-shiju.jose@huawei.com>
 <20200615120053.GZ2428291@smile.fi.intel.com>
In-Reply-To: <20200615120053.GZ2428291@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.82.233]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

Thanks for the reviewing the patch.

>-----Original Message-----
>From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
>Sent: 15 June 2020 13:01
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
>kernel@vger.kernel.org; rjw@rjwysocki.net; bp@alien8.de;
>james.morse@arm.com; lenb@kernel.org; tony.luck@intel.com;
>dan.carpenter@oracle.com; zhangliguang@linux.alibaba.com; Wangkefeng
>(OS Kernel Lab) <wangkefeng.wang@huawei.com>; jroedel@suse.de;
>yangyicong <yangyicong@huawei.com>; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>
>Subject: Re: [PATCH v9 2/2] PCI: hip: Add handling of HiSilicon HIP PCIe
>controller errors
>
>On Mon, Jun 15, 2020 at 11:15:52AM +0100, Shiju Jose wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> The HiSilicon HIP PCIe controller is capable of handling errors on
>> root port and perform port reset separately at each root port.
>>
>> Add error handling driver for HIP PCIe controller to log and report
>> recoverable errors. Perform root port reset and restore link status
>> after the recovery.
>>
>> Following are some of the PCIe controller's recoverable errors 1.
>> completion transmission timeout error.
>> 2. CRS retry counter over the threshold error.
>> 3. ECC 2 bit errors
>> 4. AXI bresponse/rresponse errors etc.
>>
>> The driver placed in the drivers/pci/controller/ because the HIP PCIe
>> controller does not use DWC ip.
>
>...
>
>> +#include <linux/acpi.h>
>> +#include <acpi/ghes.h>
>
>bits.h ?

Ok. I think bits.h was already included through some other .h files.

>
>> +#include <linux/delay.h>
>> +#include <linux/pci.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/kfifo.h>
>> +#include <linux/spinlock.h>
>
>...
>
>> +static guid_t hisi_pcie_sec_type = GUID_INIT(0xB2889FC9, 0xE7D7,
>0x4F9D,
>> +			0xA8, 0x67, 0xAF, 0x42, 0xE9, 0x8B, 0xE7, 0x72);
>
>Can we have it in more common pattern, i.e.
>
>static guid_t hisi_pcie_sec_type =
>	GUID_INIT(0xB2889FC9, 0xE7D7, 0x4F9D,
>		  0xA8, 0x67, 0xAF, 0x42, 0xE9, 0x8B, 0xE7, 0x72); ?

Ok. Will change it.
>
>...
>
>> +#define HISI_PCIE_CORE_PORT_ID(v)        (((v) % 8) << 1)
>
>% -> & ?
(((v) % 8) << 1) is correct. We can make bit operation instead. 

>
>...
>
>> +struct hisi_pcie_error_private {
>> +	struct notifier_block	nb;
>> +	struct platform_device	*pdev;
>
>Do you really need platform device? Isn't struct device * enough?
We need platform device as the error recovery device is a platform device,
which provides us the "RST" reset method.
>
>> +};
>
>...
>
>> +static char *hisi_pcie_sub_module_name(u8 id) {
>> +	switch (id) {
>> +	case HISI_PCIE_SUB_MODULE_ID_AP: return "AP Layer";
>> +	case HISI_PCIE_SUB_MODULE_ID_TL: return "TL Layer";
>> +	case HISI_PCIE_SUB_MODULE_ID_MAC: return "MAC Layer";
>> +	case HISI_PCIE_SUB_MODULE_ID_DL: return "DL Layer";
>> +	case HISI_PCIE_SUB_MODULE_ID_SDI: return "SDI Layer";
>> +	}
>
>match_string() ?

match_string() does not work here because we need sub module id -> string
conversion. 

>
>> +	return "unknown";
>
>> +}
>> +
>> +static char *hisi_pcie_error_severity(u8 err_sev) {
>> +	switch (err_sev) {
>> +	case HISI_ERR_SEV_RECOVERABLE: return "recoverable";
>> +	case HISI_ERR_SEV_FATAL: return "fatal";
>> +	case HISI_ERR_SEV_CORRECTED: return "corrected";
>> +	case HISI_ERR_SEV_NONE: return "none";
>> +	}
>
>Ditto?

Same as above.

>
>> +	return "unknown";
>> +}
>
>...
>
>> +	pdev = pci_get_domain_bus_and_slot(domain, busnr, devfn);
>> +	if (!pdev) {
>
>> +		dev_info(device, "Fail to get root port %04x:%02x:%02x.%d
>device\n",
>> +			 domain, busnr, PCI_SLOT(devfn), PCI_FUNC(devfn));
>
>pci_info() ?

It's wrong to use pci_info() here, as in the branch we haven't get a pci device and also 
we're printing info's of the error handler device driver, not a pci device driver.

>
>> +		return -ENODEV;
>> +	}
>
>...
>
>> +	/*
>> +	 * The initialization time of subordinate devices after
>> +	 * hot reset is no more than 1s, which is required by
>> +	 * the PCI spec v5.0 sec 6.6.1. The time will shorten
>> +	 * if Readiness Notifications mechanisms are used. But
>> +	 * wait 1s here to adapt any conditions.
>> +	 */
>> +	ssleep(1UL);
>
>It's a huge time out... Can we reduce it somehow?

Less time may leads downstream traffic not recovered, so it's better of follow the spec,
which is also done by the PCI driver.

>
>...
>
>> +	for (i = 0; i < HISI_PCIE_ERR_MISC_REGS; i++) {
>> +		if (edata->val_bits &
>> +				BIT_ULL(HISI_PCIE_LOCAL_VALID_ERR_MISC
>+ i))
>
>for_each_set_bit() ?

Can't use for_each_set_bit() here because edata->val_bits contains valid bits for other fields of the error data
as well, those need to printed separately.

>
>> +			dev_info(dev,
>> +				 "ERR_MISC_%d = 0x%x\n", i, edata-
>>err_misc[i]);
>> +	}
>
>> +
>> +	/* Recovery for the PCIe controller errors */
>> +	if (edata->err_severity == HISI_ERR_SEV_RECOVERABLE) {
>
>Perhaps negative conditional?

Ok. Will change it.
>
>> +		/* try reset PCI port for the error recovery */
>> +		rc = hisi_pcie_port_do_recovery(pdev, edata->socket_id,
>> +			HISI_PCIE_PORT_ID(edata->core_id, edata->port_id));
>> +		if (rc) {
>> +			dev_info(dev, "fail to do hisi pcie port reset\n");
>
>> +			return;
>
>redundant.

Ok.  Will remove it.

>
>> +		}
>> +	}
>
>...
>
>> +	const struct hisi_pcie_error_data *error_data =
>> +				acpi_hest_get_payload(gdata);
>
>One line is better to read.

Checkpatch warning, the length of line will exceed 80 characters. 
>
>> +	struct platform_device *pdev = priv->pdev;
>
>> +	hisi_pcie_handle_error(pdev, error_data);
>
>And how exactly _platform_ device pointer is being used?
>
>...
>
>
>> +		dev_err(&pdev->dev, "%s : ghes_register_event_notifier
>fail\n",
>> +			__func__);
>
>Make error message more descriptive that __func__ will not be needed.

Ok. Will fix.
>
>...
>
>> +	kfree(priv);
>
>Double free?
Check was deleted on previous comment that remove for the platform device will not be called
if it already freed.  "The remove function isn't called on stuff which hasn't been allocated."

>
>...
>
>> +static const struct acpi_device_id hisi_pcie_acpi_match[] = {
>> +	{ "HISI0361", 0 },
>
>', 0' part is not necessary to have.
May be we will keep as it is.
 
>
>> +	{ }
>> +};
>
>--
>With Best Regards,
>Andy Shevchenko
>

Thanks,
Shiju

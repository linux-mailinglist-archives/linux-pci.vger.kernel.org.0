Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0371FF958
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 18:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgFRQfd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 18 Jun 2020 12:35:33 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2342 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727882AbgFRQfd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jun 2020 12:35:33 -0400
Received: from lhreml717-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 58DCFB5B45E8DECDE9C1;
        Thu, 18 Jun 2020 17:35:31 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml717-chm.china.huawei.com (10.201.108.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 18 Jun 2020 17:35:31 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Thu, 18 Jun 2020 17:35:31 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        Linuxarm <linuxarm@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>
Subject: RE: [PATCH v10 2/2] PCI: hip: Add handling of HiSilicon HIP PCIe
 controller errors
Thread-Topic: [PATCH v10 2/2] PCI: hip: Add handling of HiSilicon HIP PCIe
 controller errors
Thread-Index: AQHWRYc885IZEiLFhEi4UCzp76myaajedjqAgAAS+mA=
Date:   Thu, 18 Jun 2020 16:35:31 +0000
Message-ID: <761e579035d346bf8cce2dfc6857587c@huawei.com>
References: <20200618154051.639-3-shiju.jose@huawei.com>
 <20200618155627.GX2428291@smile.fi.intel.com>
In-Reply-To: <20200618155627.GX2428291@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.90.32]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

>-----Original Message-----
>From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
>Sent: 18 June 2020 16:56
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
>kernel@vger.kernel.org; rjw@rjwysocki.net; helgaas@kernel.org;
>bp@alien8.de; james.morse@arm.com; lenb@kernel.org;
>tony.luck@intel.com; dan.carpenter@oracle.com;
>zhangliguang@linux.alibaba.com; Wangkefeng (OS Kernel Lab)
><wangkefeng.wang@huawei.com>; jroedel@suse.de; Linuxarm
><linuxarm@huawei.com>; yangyicong <yangyicong@huawei.com>; Jonathan
>Cameron <jonathan.cameron@huawei.com>; tanxiaofei
><tanxiaofei@huawei.com>
>Subject: Re: [PATCH v10 2/2] PCI: hip: Add handling of HiSilicon HIP PCIe
>controller errors
>
>On Thu, Jun 18, 2020 at 04:40:51PM +0100, Shiju Jose wrote:
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
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>
>Hmm... Did I give a tag?
>
>...
>
>> +static guid_t hisi_pcie_sec_guid =
>> +		GUID_INIT(0xB2889FC9, 0xE7D7, 0x4F9D,
>> +			0xA8, 0x67, 0xAF, 0x42, 0xE9, 0x8B, 0xE7, 0x72);
>
>Drop one TAB in each line and add two spaces before 0xA8 on the last.

Sure.

>
>
>...
>
>> +	idx = HISI_PCIE_LOCAL_VALID_ERR_MISC;
>
>> +	for_each_set_bit_from(idx, (const unsigned long *)&edata->val_bits,
>
>Can't you make val_bits unsigned long? Because this casting is incorrect.
>Otherwise, make a local copy into unsigned long variable.

The data val_bits in the error record is 64 bits, thus used u64.
Casting is added because of a compilation warning on _find_nex_bit_ function as it 
expects the type of the address as const unsigned long*.
Probably I will make local copy of val_bits into unsigned long variable.

>
>> +			      HISI_PCIE_LOCAL_VALID_ERR_MISC +
>HISI_PCIE_ERR_MISC_REGS)
>> +		dev_info(dev, "ERR_MISC_%d = 0x%x\n", idx -
>HISI_PCIE_LOCAL_VALID_ERR_MISC,
>> +			 edata->err_misc[idx]);
>
>...
>
>> +static int hisi_pcie_error_handler_probe(struct platform_device
>> +*pdev) {
>> +	struct hisi_pcie_error_private *priv;
>> +	int ret;
>> +
>
>> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>
>(1)
>
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->nb.notifier_call = hisi_pcie_notify_error;
>> +	priv->dev = &pdev->dev;
>> +	ret = ghes_register_event_notifier(&priv->nb);
>> +	if (ret) {
>> +		dev_err(&pdev->dev,
>> +			"Failed to register hisi_pcie_notify_error
>function\n");
>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, priv);
>> +
>> +	return 0;
>> +}
>> +
>> +static int hisi_pcie_error_handler_remove(struct platform_device
>> +*pdev) {
>> +	struct hisi_pcie_error_private *priv = platform_get_drvdata(pdev);
>> +
>> +	ghes_unregister_event_notifier(&priv->nb);
>
>> +	kfree(priv);
>
>See (1), as I told you, this is double free.
>Have you tested this?
>
>> +	return 0;
>> +}
>
>--
>With Best Regards,
>Andy Shevchenko
>

Thanks,
Shiju

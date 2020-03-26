Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B823F193C37
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 10:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgCZJr4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 26 Mar 2020 05:47:56 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2606 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726292AbgCZJrz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Mar 2020 05:47:55 -0400
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 94680B43317A3F13F0F7;
        Thu, 26 Mar 2020 09:47:53 +0000 (GMT)
Received: from lhreml711-chm.china.huawei.com (10.201.108.62) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 26 Mar 2020 09:47:52 +0000
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml711-chm.china.huawei.com (10.201.108.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Mar 2020 09:47:52 +0000
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1713.004;
 Thu, 26 Mar 2020 09:47:52 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH v5 2/2] PCI: HIP: Add handling of HiSilicon HIP PCIe
 controller errors
Thread-Topic: [PATCH v5 2/2] PCI: HIP: Add handling of HiSilicon HIP PCIe
 controller errors
Thread-Index: AQHWAsv5Pa1C0kaXt0i5HExQ9lFwB6haoF/g
Date:   Thu, 26 Mar 2020 09:47:52 +0000
Message-ID: <d1f2f313ea8e45689b5818489759faac@huawei.com>
References: <24330bd8-afaa-d7ac-594c-f9fda4242400@huawei.com>
 <20200325173639.GA484@google.com>
In-Reply-To: <20200325173639.GA484@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.27.105]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for the feedbacks.

>-----Original Message-----
>From: Bjorn Helgaas [mailto:helgaas@kernel.org]
>Sent: 25 March 2020 17:37
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
>kernel@vger.kernel.org; rjw@rjwysocki.net; lenb@kernel.org; bp@alien8.de;
>james.morse@arm.com; tony.luck@intel.com; gregkh@linuxfoundation.org;
>zhangliguang@linux.alibaba.com; tglx@linutronix.de; Linuxarm
><linuxarm@huawei.com>; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>yangyicong <yangyicong@huawei.com>; Dan Carpenter
><dan.carpenter@oracle.com>
>Subject: Re: [PATCH v5 2/2] PCI: HIP: Add handling of HiSilicon HIP PCIe
>controller errors
>
>[+cc Dan]
>
>On Wed, Mar 25, 2020 at 01:55:18PM +0000, Shiju Jose wrote:
>> The HiSilicon HIP PCIe controller is capable of handling errors on
>> root port and perform port reset separately at each root port.
>>
>> This patch add error handling driver for HIP PCIe controller to log
>> and report recoverable errors. Perform root port reset and restore
>> link status after the recovery.
>>
>> Following are some of the PCIe controller's recoverable errors 1.
>> completion transmission timeout error.
>> 2. CRS retry counter over the threshold error.
>> 3. ECC 2 bit errors
>> 4. AXI bresponse/rresponse errors etc.
>>
>> Also fix the following Smatch warning:
>> warn: should '((((1))) << (9 + i))' be a 64 bit type?
>> if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i))
>>      ^^^ This should be BIT_ULL() because it goes up to 9 + 32.
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
>I'm glad you did this fix, and thanks for acknowledging Dan, but I don't think it's
>necessary to mention it in the commit log here because it won't really be useful
>in the future.  It's only relevant when comparing the unmerged versions of this
>series, e.g., v4 compared to v3.
Sure. We will delete this.

>
>If we were fixing something that's already been merged upstream, we should
>absolutely include this, but since this hasn't been merged yet Dan's report is
>basically the same as other review comments, which we normally just address
>and mention in the change history in the [0/n] cover letter (as you're already
>doing, thanks for that!).

>
>Also, I think it's nice to CC: anybody who has commented on previous versions
>of the patch series, so I added Dan to the CC: list here.
>That way he can chime in if we're not addressing his report correctly.
>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> --
>> drivers/pci/controller/Kconfig           |   8 +
>> drivers/pci/controller/Makefile          |   1 +
>> drivers/pci/controller/pcie-hisi-error.c | 336
>> +++++++++++++++++++++++++++++++
>> 3 files changed, 345 insertions(+)
>> create mode 100644 drivers/pci/controller/pcie-hisi-error.c
>
>As I mentioned in the other message, I think this file should be
>drivers/pci/controller/dwc/pcie-hisi-error.c so it's right next to pcie-hisi.c.  If
>there's some reason it needs to be here instead, please mention that in the
>commit log.
>
>> ---
>>  drivers/pci/controller/Kconfig           |   8 +
>>  drivers/pci/controller/Makefile          |   1 +
>>  drivers/pci/controller/pcie-hisi-error.c | 357
>> +++++++++++++++++++++++
>>  3 files changed, 366 insertions(+)
>>  create mode 100644 drivers/pci/controller/pcie-hisi-error.c
>
>> +struct hisi_pcie_err_data {
>> +	u64   val_bits;
>> +	u8    version;
>> +	u8    soc_id;
>> +	u8    socket_id;
>> +	u8    nimbus_id;
>> +	u8    sub_module_id;
>> +	u8    core_id;
>> +	u8    port_id;
>> +	u8    err_severity;
>> +	u16   err_type;
>> +	u8    reserv[2];
>> +	u32   err_misc[HISI_PCIE_ERR_MISC_REGS];
>> +};
>> +
>> +struct hisi_pcie_err_info {
>> +	struct hisi_pcie_err_data err_data;
>> +	struct platform_device *pdev;
>> +};
>> +
>> +struct hisi_pcie_err_private {
>> +	struct notifier_block nb;
>> +	struct platform_device *pdev;
>> +};
>
>Either align all the struct members or none of them.  Currently
>hisi_pcie_err_data is aligned but hisi_pcie_err_info and hisi_pcie_err_private
>are not.
We will align the structures. 

>
>> +	/* Call the ACPI handle to reset root port */
>
>Superfluous comment.
We will remove this comment.
 
>
>> +	s = acpi_evaluate_integer(handle, "RST", &arg_list, &data);
>> +	if (ACPI_FAILURE(s)) {
>> +		dev_err(dev, "No RST method\n");
>> +		return -EIO;
>> +	}
>
>> +static void hisi_pcie_handle_one_error(const struct
>> +hisi_pcie_err_data
>> *err,
>> +				    struct platform_device *pdev)
>
>Align "struct platform_device ..." under "const struct hisi_pcie_err_data ...".
sure.

>
>Bjorn

Thanks,
Shiju

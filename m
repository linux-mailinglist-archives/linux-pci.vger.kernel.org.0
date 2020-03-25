Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1B2192E30
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 17:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgCYQ1S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 25 Mar 2020 12:27:18 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2605 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727386AbgCYQ1S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Mar 2020 12:27:18 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 7C7B644093CAB3F291D8;
        Wed, 25 Mar 2020 16:27:16 +0000 (GMT)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 25 Mar 2020 16:27:16 +0000
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 25 Mar 2020 16:27:16 +0000
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1713.004;
 Wed, 25 Mar 2020 16:27:16 +0000
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
        yangyicong <yangyicong@huawei.com>
Subject: RE: [PATCH v5 0/2] ACPI: APEI: Add support to notify the vendor
 specific HW errors
Thread-Topic: [PATCH v5 0/2] ACPI: APEI: Add support to notify the vendor
 specific HW errors
Thread-Index: AQHWArk9LTp1thyJ80ifFE8yZh20/KhZdCmQ
Date:   Wed, 25 Mar 2020 16:27:15 +0000
Message-ID: <84a30116698a49cda1e8b580ee35ce1f@huawei.com>
References: <8aa40a48-39c9-ba6b-ea70-bcb60907a733@huawei.com>
 <20200325152220.GA261586@google.com>
In-Reply-To: <20200325152220.GA261586@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.86.66]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

>-----Original Message-----
>From: Bjorn Helgaas [mailto:helgaas@kernel.org]
>Sent: 25 March 2020 15:22
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
>kernel@vger.kernel.org; rjw@rjwysocki.net; lenb@kernel.org; bp@alien8.de;
>james.morse@arm.com; tony.luck@intel.com; gregkh@linuxfoundation.org;
>zhangliguang@linux.alibaba.com; tglx@linutronix.de; Linuxarm
><linuxarm@huawei.com>; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>yangyicong <yangyicong@huawei.com>
>Subject: Re: [PATCH v5 0/2] ACPI: APEI: Add support to notify the vendor
>specific HW errors
>
>1) If you can post things as a series, i.e., with patch 1/2 and patch
>2/2 being responses to the 0/2 cover letter, that makes things easier.
>It looks like you did this for the previous postings.
I will send the patches as series after fixing the issues in the patch subject lines. 

>
>2) When applying these, "git am" complained (but they did apply
>cleanly):
>
>  warning: Patch sent with format=flowed; space at the end of lines might be
>lost.
>  Applying: APEI: Add support to notify the vendor specific HW errors
>  warning: Patch sent with format=flowed; space at the end of lines might be
>lost.
>  Applying: PCI: HIP: Add handling of HiSilicon HIP PCIe controller errors
>
>3) drivers/pci/controller/pcie-hisi-error.c should be next to
>drivers/pci/controller/dwc/pcie-hisi.c, shouldn't it?
Our hip PCIe controller doesn't use DWC ip.

>
>4) Your subject lines don't match the convention.  "git log --oneline
>drivers/acpi/apei" says:
>
>  011077d8fbfe ("APEI: Add support to notify the vendor specific HW errors")
>  cea79e7e2f24 ("apei/ghes: Do not delay GHES polling")
>  933ca4e323de ("acpi: Use pr_warn instead of pr_warning")
>  6abc7622271d ("ACPI / APEI: Release resources if gen_pool_add() fails")
>  bb100b64763c ("ACPI / APEI: Get rid of NULL_UUID_LE constant")
>  371b86897d01 ("ACPI / APEI: Remove needless __ghes_check_estatus()
>calls")
>
>and "git log --oneline --follow drivers/pci/controller/dwc/pcie-hisi*"
>says:
>
>  6e0832fa432e ("PCI: Collect all native drivers under drivers/pci/controller/")
>  8cfab3cf63cf ("PCI: Add SPDX GPL-2.0 to replace GPL v2 boilerplate")
>  5a4751680189 ("PCI: hisi: Constify dw_pcie_host_ops structure")
>  b379d385bbaa ("PCI: hisi: Remove unused variable driver")
>  a5f40e8098fe ("PCI: Don't allow unbinding host controllers that aren't
>prepared")
>  e313a447e735 ("PCI: hisi: Update PCI config space remap function")
>  b9c1153f7a9c ("PCI: hisi: Fix DT binding (hisi-pcie-almost-ecam)")
>
>So your subject lines should be:
>
>  ACPI / APEI: ...
Sure. I will fix this.

>  PCI: hisi: ...
Can we use PCI: hip because this driver is for the HIP hardware devices. 

[...]
>> --
>> 2.17.1

Thanks,
Shiju

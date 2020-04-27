Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C081B955D
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 05:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgD0DWZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Apr 2020 23:22:25 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2492 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbgD0DWZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Apr 2020 23:22:25 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 61F824F59A8333890CA5;
        Mon, 27 Apr 2020 11:22:18 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 27 Apr 2020 11:22:12 +0800
Received: from [127.0.0.1] (10.40.49.11) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Mon, 27
 Apr 2020 11:22:11 +0800
Subject: Re: [PATCH v5 2/2] pciutils: Decode Compute eXpress Link DVSEC
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
CC:     <mj@ucw.cz>, <linux-pci@vger.kernel.org>,
        huangdaode <huangdaode@hisilicon.com>
References: <20200420174747.GA48539@google.com>
From:   Jay Fang <f.fangjian@huawei.com>
Message-ID: <6bb98f80-2c8d-cfd5-7ebf-c1365485c9c8@huawei.com>
Date:   Mon, 27 Apr 2020 11:22:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420174747.GA48539@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.49.11]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Got it.
Bjorn, thanks.

Jay

On 2020/4/21 1:47, Bjorn Helgaas wrote:
> Hi Jay, thanks for taking a look at this!
> 
> On Mon, Apr 20, 2020 at 09:21:27AM -0700, Sean V Kelley wrote:
>> On 18 Apr 2020, at 1:36, Jay Fang wrote:
>>> On 2020/4/15 8:47, Sean V Kelley wrote:
>>>>
>>>> [1] https://www.computeexpresslink.org/
>>>>
>>>> Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>
>>>> ---
>>>>  lib/header.h        |  20 +++
>>>
>>>> +
>>>> +static int
>>>> +is_cxl_cap(struct device *d, int where)
>>>> +{
>>>> +  u32 hdr;
>>>> +  u16 w;
>>>> +
>>>> +  if (!config_fetch(d, where + PCI_DVSEC_HEADER1, 8))
>>>> +    return 0;
>>>> +
>>>> +  /* Check for supported Vendor */
>>>> +  hdr = get_conf_long(d, where + PCI_DVSEC_HEADER1);
>>>> +  w = BITS(hdr, 0, 16);
>>>> +  if (w != PCI_VENDOR_ID_INTEL)
>>>
>>> I don't think here checking is quite right. Does only Intel support CXL?
>>> Other Vendors should also be considered.
>>
>> In the absence of currently available hardware, I was attempting to limit
>> false positive noise.  I’m happy to avoid the check on the vendor if there
>> were to exist a definitive supported list.  Bjorn suggested that I check for
>> vendor ID with DVSEC ID for now.  As hardware enters the market, I can
>> surely revise this with an update when the CXL group publishes a list.
> 
> The Vendor ID check cannot be avoided.  Vendor IDs are allocated by
> the PCI-SIG, but the DVSEC ID is vendor-defined so there cannot be a
> global "CXL capability" DVSEC ID.
> 
> CXL *could* work through the PCI-SIG and define a new CXL Extended
> Capability that could make this generic.  But apparently they've
> chosen to use the DVSEC mechanism instead.
> 
>>>> +  /* Check for Designated Vendor-Specific ID */
>>>> +  hdr = get_conf_long(d, where + PCI_DVSEC_HEADER2);
>>>> +  w = BITS(hdr, 0, 16);
>>>> +  if (w == PCI_DVSEC_ID)
> 
> However, this is slightly wrong.  The name "PCI_DVSEC_ID" implies that
> there can only be one DVSEC ID and it is vendor-independent, but
> neither is true.
> 
> This value is allocated by Intel, so we must check for the Intel
> Vendor ID first.  And Intel may define several DVSEC capabilities for
> different purposes, so the name should also mention CXL.
> 
> So this should be "PCI_DVSEC_INTEL_CXL" or something similar.
> 
> But that doesn't mean other vendors need to define their own DVSEC
> IDs for CXL.  The spec (PCIe r5.0, sec 7.9.6) says:
> 
>   [The DVSEC Capability] allows PCI Express component vendors to use
>   the Extended Capability mechanism to expose vendor-specific
>   registers that can be present in components by a variety of
>   vendors.
> 
> Any vendor that implements this CXL DVSEC the same way Intel does can
> tag it with PCI_VENDOR_ID_INTEL and PCI_DVSEC_INTEL_CXL.
> 
> Note that there are two types of vendor-specific capabilities:
> 
>   1) Vendor-Specific Extended Capability (VSEC).  The structure and
>   definition are defined by the *Function* Vendor ID (from offset 0 in
>   config space) and the VSEC ID in the capability.
> 
>   2) Designated Vendor-Specific Extended Capability (DVSEC).  The
>   structure and definition are defined by the *DVSEC* Vendor ID (from
>   the DVSEC capability, *not* the vendor of the Function) and the
>   DVSEC ID in the capability.
> 
> This CXL capability is the latter, of course.
> 
> Bjorn
> 
> .
> 


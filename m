Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F76F2229A8
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 19:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgGPRSu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 13:18:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:10449 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729313AbgGPRSs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jul 2020 13:18:48 -0400
IronPort-SDR: LMGdHxlnO9xPDX7Hg9H8zkYvo+Us96z69yAFkPded5gOLuD4Zf3w21HVUwL3+Ir82iFGpNnAF4
 g8X4eP+NIwsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="147437683"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="147437683"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 10:18:47 -0700
IronPort-SDR: 7QSD0mIFZV35GRaqBa9TP6Fa8zQ8z3ynWR9ZmO2bMYDAPb6uT49V05gYbuiY2WiH71Hf1nF44t
 ekUDmyuR2Lrg==
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="286550453"
Received: from ahduyck-mobl1.amr.corp.intel.com (HELO [10.209.124.206]) ([10.209.124.206])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 10:18:47 -0700
Subject: Re: [PATCH V3 1/3] PCI: Add defines for Designated Vendor-Specific
 Capability
To:     Randy Dunlap <rdunlap@infradead.org>,
        "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20200508021844.6911-1-david.e.box@linux.intel.com>
 <20200714062323.19990-2-david.e.box@linux.intel.com>
 <3f490460-62f8-8b49-0735-ad29653bfbc0@infradead.org>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <dc459a96-1434-16bf-80d2-06b0680f9fda@linux.intel.com>
Date:   Thu, 16 Jul 2020 10:18:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3f490460-62f8-8b49-0735-ad29653bfbc0@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/15/2020 7:55 PM, Randy Dunlap wrote:
> On 7/13/20 11:23 PM, David E. Box wrote:
>> Add PCIe DVSEC extended capability ID and defines for the header offsets.
>> Defined in PCIe r5.0, sec 7.9.6.
>>
>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>   include/uapi/linux/pci_regs.h | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index f9701410d3b5..09daa9f07b6b 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -720,6 +720,7 @@
>> +#define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
>> @@ -1062,6 +1063,10 @@
>> +/* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
>> +#define PCI_DVSEC_HEADER1		0x4 /* Vendor-Specific Header1 */
>> +#define PCI_DVSEC_HEADER2		0x8 /* Vendor-Specific Header2 */
> 
> Just a little comment: It would make more sense to me to
> s/DVSEC/DVSPEC/g.
> 
> But then I don't have the PCIe documentation.

Arguably some of the confusion might be from the patch title. DVSEC is 
acronym for Designated Vendor-Specific Extended Capability if I recall 
correctly. It would probably be best to call that out since the extended 
implies it lives in the config space accessible via the memory mapped 
config.

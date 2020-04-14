Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2791A8D29
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 23:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633541AbgDNVCF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 17:02:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:33300 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633575AbgDNVB6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 17:01:58 -0400
IronPort-SDR: 97k9skWINaT43ehZWTMiuXjIdLvPb84RTxVIUfgPkBlp+oQ1liLI2hiCxwheAXNbez0Bi6aK5b
 cKPOm0PDmp+g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 14:01:56 -0700
IronPort-SDR: qG7pkSv8sU8JBwjZ1u8MnBaTFrPBBPRk0xCEimvte6CnhiezOsuZJR2ZTQ1ZohncQd/GOpZNon
 cJkSBgMnlGMw==
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="298812645"
Received: from mknudson-mobl.amr.corp.intel.com (HELO [10.209.99.231]) ([10.209.99.231])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 14:01:55 -0700
From:   "Sean V Kelley" <sean.v.kelley@linux.intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     mj@ucw.cz, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pciutils: Decode Compute eXpress Link DVSEC
Date:   Tue, 14 Apr 2020 14:01:53 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <A89BD01A-195C-40CF-9E06-C30277871086@linux.intel.com>
In-Reply-To: <20200414203711.GA102808@google.com>
References: <20200414203711.GA102808@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14 Apr 2020, at 13:37, Bjorn Helgaas wrote:

> On Mon, Apr 13, 2020 at 08:35:26AM -0700, Sean V Kelley wrote:
>> Compute eXpress Link[1] is a new CPU interconnect created with
>> workload accelerators in mind. The interconnect relies on PCIe
>> electrical and physical interconnect for communication via a Flex Bus
>> port which allows designs to choose between providing PCIe or CXL.
>>
>> This patch introduces basic support for lspci decode of CXL and
>> builds upon the existing Designated Vendor-Specific support in
>> lspci through identification of a Flex Bus capable Vendor ID.
>
> I don't think this is quite right.  Isn't the Flex Bus ID the
> "DVSEC ID" (not the "DVSEC Vendor ID")?

Correct.  It is not really a Flex Bus ID but really a DVSEC ID.  I was 
leaning too heavily on the Spec’s wording which stated: “The DVSEC 
ID is set to 0x0 to advertise that this is an Flex Bus feature 
capability structure.”

I’ll correct.  I was trying to note that CXL depends on Flex Bus 
capability which is identified through the DVSEC ID.  But I confused 
things by also mentioning the Vendor ID.

>
>> +static int
>> +is_flexbus_cap(struct device *d, int where)
>> +{
>> +  u32 hdr;
>> +  u16 w;
>> +
>> +  if (!config_fetch(d, where + PCI_DVSEC_HEADER1, 8))
>> +    return 0;
>
> And here, I think we need to check the "DVSEC Vendor ID" first, i.e.,
> in the log below, I guess we'd look for the Intel Vendor ID (0x8086).

Agree.  Will do.

>
> We can only decode the capability if *both* the DVSEC Vendor ID
> (HEADER1) and the DVSEC ID (HEADER2) match.

Got it.

Thanks,

Sean

>
>> +  /* Check for Designated Vendor-Specific Flex Bus Capable ID */
>> +  hdr = get_conf_long(d, where + PCI_DVSEC_HEADER2);
>> +  w = BITS(hdr, 0, 16);
>> +  if (w == PCI_DVSEC_FLEXBUS_ID)
>> +    return 1;
>> +
>> +  return 0;
>> +}
>> +
>>  static void
>>  cap_dvsec(struct device *d, int where)
>>  {
>> @@ -947,7 +992,10 @@ show_ext_caps(struct device *d, int type)
>>  	    printf("Readiness Time Reporting <?>\n");
>>  	    break;
>>  	  case PCI_EXT_CAP_ID_DVSEC:
>> -	    cap_dvsec(d, where);
>> +	    if (is_flexbus_cap(d, where))
>> +	      cap_cxl(d, where);
>> +	    else
>> +	      cap_dvsec(d, where);
>>  	    break;
>>  	  case PCI_EXT_CAP_ID_VF_REBAR:
>>  	    printf("VF Resizable BAR <?>\n");
>
>> +        Capabilities: [e00 v1] CXL Designated Vendor-Specific:
>> +                CXLCap: Cache+ IO+ Mem+ Mem HW Init+ HDMCount 1 
>> Viral-
>> +                CXLCtl: Cache+ IO+ Mem- Cache SF Cov 0 Cache SF Gran 
>> 0 Cache Clean- Viral-
>> +                CXLSta: Viral-
>> +        Capabilities: [e38 v1] Device Serial Number 
>> 12-34-56-78-90-00-00-00
>
>> +e00: 23 00 81 e3 86 80 80 03 00 00 1f 00 03 00 00 00
>> +e10: 00 00 00 00 00 00 00 00 00 00 00 00 03 01 00 08
>> +e20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> +e30: 00 00 00 00 00 00 00 00 03 00 01 00 00 00 00 90
>> +e40: 78 56 34 12 00 00 00 00 00 00 00 00 00 00 00 00

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752291B1169
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 18:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgDTQVb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 12:21:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:26061 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgDTQVb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 12:21:31 -0400
IronPort-SDR: 0IwIZIwVjZ9AruLN6AZF7Ayjo8aWWjBFLueYmUy1eosDr6if/nXnY2H3svvjbCFghYmEUpjCsW
 UFSkJEg90wrQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 09:21:30 -0700
IronPort-SDR: eEuXPPryH4haI2HkciXsuluEGhJ1gMr1imRc8Bz1Mw1K1fL3blheYADLQW24LGngYuArDxWdK9
 8YZ1Jg6jdqXQ==
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; 
   d="scan'208";a="254987101"
Received: from labenne1-mobl.amr.corp.intel.com (HELO [10.135.61.52]) ([10.135.61.52])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 09:21:29 -0700
From:   "Sean V Kelley" <sean.v.kelley@linux.intel.com>
To:     "Jay Fang" <f.fangjian@huawei.com>
Cc:     mj@ucw.cz, bhelgaas@google.com, linux-pci@vger.kernel.org,
        huangdaode <huangdaode@hisilicon.com>
Subject: Re: [PATCH v5 2/2] pciutils: Decode Compute eXpress Link DVSEC
Date:   Mon, 20 Apr 2020 09:21:27 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <B647B03B-9476-4D31-9662-4D68E7204459@linux.intel.com>
In-Reply-To: <54a9a3f3-aa30-aa2f-1660-15c70ea7dc54@huawei.com>
References: <20200415004751.2103963-1-sean.v.kelley@linux.intel.com>
 <20200415004751.2103963-3-sean.v.kelley@linux.intel.com>
 <54a9a3f3-aa30-aa2f-1660-15c70ea7dc54@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jay,

Thank you for reviewing.  My comments below:

On 18 Apr 2020, at 1:36, Jay Fang wrote:

> On 2020/4/15 8:47, Sean V Kelley wrote:
>
>>
>> [1] https://www.computeexpresslink.org/
>>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>
>> ---
>>  lib/header.h        |  20 +++
>
>> +
>> +static int
>> +is_cxl_cap(struct device *d, int where)
>> +{
>> +  u32 hdr;
>> +  u16 w;
>> +
>> +  if (!config_fetch(d, where + PCI_DVSEC_HEADER1, 8))
>> +    return 0;
>> +
>> +  /* Check for supported Vendor */
>> +  hdr = get_conf_long(d, where + PCI_DVSEC_HEADER1);
>> +  w = BITS(hdr, 0, 16);
>> +  if (w != PCI_VENDOR_ID_INTEL)
> I don't think here checking is quite right. Does only Intel support 
> CXL?
> Other Vendors should also be considered.

In the absence of currently available hardware, I was attempting to 
limit false positive noise.  I’m happy to avoid the check on the 
vendor if there were to exist a definitive supported list.  Bjorn 
suggested that I check for vendor ID with DVSEC ID for now.  As hardware 
enters the market, I can surely revise this with an update when the CXL 
group publishes a list.

Best regards,

Sean


>
> Thanks
>> +    return 0;
>> +
>> +  /* Check for Designated Vendor-Specific ID */
>> +  hdr = get_conf_long(d, where + PCI_DVSEC_HEADER2);
>> +  w = BITS(hdr, 0, 16);
>> +  if (w == PCI_DVSEC_ID)
>> +    return 1;
>> +
>> +  return 0;
>> +}
>> +
>>  static void
>>  cap_dvsec(struct device *d, int where)
>>  {
>> @@ -947,7 +998,10 @@ show_ext_caps(struct device *d, int type)
>>  	    printf("Readiness Time Reporting <?>\n");
>>  	    break;
>>  	  case PCI_EXT_CAP_ID_DVSEC:
>> -	    cap_dvsec(d, where);
>> +	    if (is_cxl_cap(d, where))
>> +	      cap_cxl(d, where);
>> +	    else
>> +	      cap_dvsec(d, where);
>>  	    break;
>>  	  case PCI_EXT_CAP_ID_VF_REBAR:
>>  	    printf("VF Resizable BAR <?>\n");
>> diff --git a/tests/cap-dvsec-cxl b/tests/cap-dvsec-cxl
>> new file mode 100644
>> index 0000000..e5d2745
>> --- /dev/null
>> +++ b/tests/cap-dvsec-cxl
>> @@ -0,0 +1,340 @@
>> +6b:00.0 Unassigned class [ff00]: Intel Corporation Device 0d93
>> +        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
>> ParErr+ Stepping- SERR+ FastB2B- DisINTx-

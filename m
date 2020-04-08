Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1671A2ADD
	for <lists+linux-pci@lfdr.de>; Wed,  8 Apr 2020 23:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgDHVMs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 17:12:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:25434 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbgDHVMr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Apr 2020 17:12:47 -0400
IronPort-SDR: DMBAMDHMTz0HjSjDB9gLRPY9F86v3gcGT6+VVy1xEiEvTxF4Oa6yWNOKKDJF81T2+v7tRP6JM6
 P0hToP5GIOfg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 14:12:47 -0700
IronPort-SDR: KAt/GSK6k9fxd/BKXg41bC8TIX3CS3DM8ItUX2D6gyJVmB3DNNOKDTZXN4EvEfq/vKCD4cOS7X
 Q8htPoAOtZcQ==
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="297339800"
Received: from rwthomp1-mobl1.amr.corp.intel.com (HELO [10.212.84.222]) ([10.212.84.222])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 14:12:46 -0700
From:   "Sean V Kelley" <sean.v.kelley@linux.intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     mj@ucw.cz, linux-pci@vger.kernel.org
Subject: Re: [RFC Patch 1/1] lspci: Add basic decode support for Compute
 eXpress Link
Date:   Wed, 08 Apr 2020 14:12:45 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <1766804A-54D2-4977-975A-9E9F29EFC155@linux.intel.com>
In-Reply-To: <20200408165623.GA80917@google.com>
References: <20200408165623.GA80917@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,

Thanks for taking time to review.  My comments below:

On 8 Apr 2020, at 9:56, Bjorn Helgaas wrote:

> On Tue, Apr 07, 2020 at 05:09:59PM -0700, Sean V Kelley wrote:
>> Compute eXpress Link[1] is a new CPU interconnected created with
>> workload accelerators in mind. The interconnect relies on PCIe 
>> Electrial
>> and Physical interconnect for communication.
>
> s/interconnected/interconnect/
> s/Electrial/Electrical/
>
>> Moreover, CXL bus hierarchy appear, to the OS, as an ACPI-described 
>> PCIe
>> Root Bridge with Integrated Endpoint.
>
> s/Moreover,/The/
> s/appear,/appears/
> s/the OS,/the OS/
>
> Actually, I don't think this paragraph is really relevant.  At least
> at the level of lspci, it doesn't matter whether the host bridge is
> described via ACPI, DT, or something else.  And I don't think it
> matters whether this is an Integrated Endpoint or otherwise.  All
> lspci cares about is that we can read config space for the device.

Will do.

>
>> This patch introduces basic support for lspci decode for DVSEC CXL
>> extended capability.
>>
>> [1] https://www.computeexpresslink.org/
>>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>
>> ---
>>  lib/header.h        | 25 +++++++++++++++++++++++++
>>  ls-ecaps.c          | 29 ++++++++++++++++++++++++++++-
>>  tests/cap-cxl-dvsec |  8 ++++++++
>>  3 files changed, 61 insertions(+), 1 deletion(-)
>>  create mode 100644 tests/cap-cxl-dvsec
>>
>> diff --git a/lib/header.h b/lib/header.h
>> index bfdcc80..421612d 100644
>> --- a/lib/header.h
>> +++ b/lib/header.h
>> @@ -1042,6 +1042,27 @@
>>  #define PCI_EVNDR_HEADER	4	/* Vendor-Specific Header */
>>  #define PCI_EVNDR_REGISTERS	8	/* Vendor-Specific Registers */
>>
>> +/* PCIe CXL Vendor-Specific Capabilities, Control, Status */
>
> s/Vendor-Specific/Designated Vendor-Specific/
>

Will do.

>> +#define PCI_EVNDR_CXL_ID	0
>
> Unused in this patch.  Is this the DVSEC Vendor ID as described in
> PCIe r5.0, sec 7.9.6.2?  Is 0 really the ID assigned for CXL?

It is as described in the PCIe Spec.  The DVSEC ID is set to 0x0 here to 
advertise that this is a Flex Bus feature capability structure. It’s 
assigned in table 58 “PCI Express DVSEC Register Settings for Flex Bus 
Device” of the CXL 1.1 spec.

>
>> +#define PCI_CXL_CAP		0x0a
>> +#define  PCI_CXL_CAP_CACHE	0x0001
>> +#define  PCI_CXL_CAP_IO		0x0002
>> +#define  PCI_CXL_CAP_MEM	0x0004
>> +#define  PCI_CXL_CAP_MEM_HWINIT	0x0008
>> +#define  PCI_CXL_CAP_HDM_CNT(x)	(((x) & (3 << 4)) >> 4)
>> +#define  PCI_CXL_CAP_VIRAL	0x4000
>> +#define PCI_CXL_CTRL		0x0c
>> +#define  PCI_CXL_CTRL_CACHE	0x0001
>> +#define  PCI_CXL_CTRL_IO	0x0002
>> +#define  PCI_CXL_CTRL_MEM	0x0004
>> +#define  PCI_CXL_CTRL_CACHE_SF_COV(x)	(((x) & (0x1f << 3)) >> 3)
>> +#define  PCI_CXL_CTRL_CACHE_SF_GRAN(x)	(((x) & (0x7 << 8)) >> 8)
>> +#define  PCI_CXL_CTRL_CACHE_CLN	0x0800
>> +#define  PCI_CXL_CTRL_VIRAL	0x4000
>> +#define PCI_CXL_STATUS		0x0e
>> +#define  PCI_CXL_STATUS_VIRAL	0x4000
>> +
>>  /* Access Control Services */
>>  #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
>>  #define PCI_ACS_CAP_VALID	0x0001	/* ACS Source Validation */
>> @@ -1348,6 +1369,10 @@
>>  #define PCI_CLASS_SIGNAL_SYNCHRONIZER	0x1110
>>  #define PCI_CLASS_SIGNAL_OTHER		0x1180
>>
>> +#define PCI_CLASS_CXL			0x14
>> +#define PCI_CLASS_CXL_RCIEP		0x1400
>> +#define PCI_CLASS_CXL_OTHER		0x1480
>> +
>>  #define PCI_CLASS_OTHERS		0xff
>>
>>  /* Several ID's we need in the library */
>> diff --git a/ls-ecaps.c b/ls-ecaps.c
>> index 0021734..8c09517 100644
>> --- a/ls-ecaps.c
>> +++ b/ls-ecaps.c
>> @@ -207,6 +207,33 @@ cap_aer(struct device *d, int where, int type)
>>      }
>>  }
>>
>> +static void
>> +cap_cxl(struct device *d, int where)
>> +{
>> +  u16 l;
>> +
>> +  printf("PCIe DVSEC for CXL Device\n");
>> +  if (verbose < 2)
>> +    return;
>> +
>> +  if (!config_fetch(d, where + PCI_CXL_CAP, 12))
>> +    return;
>> +
>> +  l = get_conf_word(d, where + PCI_CXL_CAP);
>> +  printf("\t\tCXLCap:\tCache%c IO%c Mem%c Mem HW Init%c HDMCount %d 
>> Viral%c\n",
>> +    FLAG(l, PCI_CXL_CAP_CACHE), FLAG(l, PCI_CXL_CAP_IO), FLAG(l, 
>> PCI_CXL_CAP_MEM),
>> +    FLAG(l, PCI_CXL_CAP_MEM_HWINIT), PCI_CXL_CAP_HDM_CNT(l), FLAG(l, 
>> PCI_CXL_CAP_VIRAL));
>> +
>> +  l = get_conf_word(d, where + PCI_CXL_CTRL);
>> +  printf("\t\tCXLCtl:\tCache%c IO%c Mem%c Cache SF Cov %d Cache SF 
>> Gran %d Cache Clean%c Viral%c\n",
>> +    FLAG(l, PCI_CXL_CTRL_CACHE), FLAG(l, PCI_CXL_CTRL_IO), FLAG(l, 
>> PCI_CXL_CTRL_MEM),
>> +    PCI_CXL_CTRL_CACHE_SF_COV(l), PCI_CXL_CTRL_CACHE_SF_GRAN(l), 
>> FLAG(l, PCI_CXL_CTRL_CACHE_CLN),
>> +    FLAG(l, PCI_CXL_CTRL_VIRAL));
>> +
>> +  l = get_conf_word(d, where + PCI_CXL_STATUS);
>> +  printf("\t\tCXLSta:\tViral%c\n", FLAG(l, PCI_CXL_STATUS_VIRAL));
>> +}
>> +
>>  static void cap_dpc(struct device *d, int where)
>>  {
>>    u16 l;
>> @@ -924,7 +951,7 @@ show_ext_caps(struct device *d, int type)
>>  	    printf("Readiness Time Reporting <?>\n");
>>  	    break;
>>  	  case PCI_EXT_CAP_ID_DVSEC:
>> -	    printf("Designated Vendor-Specific <?>\n");
>> +	    cap_cxl(d, where);
>
> This assumes that *every* DVSEC capability is a CXL Designated
> Vendor-Specific capability.  I think this needs to check for the
> correct DVSEC Vendor ID and do cap_cxl() if it matches and the
> previous behavior otherwise.

Yes, that’s what I’m looking for on feedback as CXL is one possible 
use of DVSEC.

>
> Based on the spec, I would expect to see a check for both the DVSEC
> Vendor ID and the DVSEC ID before decoding the registers.

Right, agreed.

>
> Actually, it would be nice if the generic "I don't know what this is"
> code would at least print the DVSEC Vendor ID and the DVSEC ID.
> Ideally this would be a separate preparatory patch.

Will do.

>
>>  	    break;
>>  	  case PCI_EXT_CAP_ID_VF_REBAR:
>>  	    printf("VF Resizable BAR <?>\n");
>> diff --git a/tests/cap-cxl-dvsec b/tests/cap-cxl-dvsec
>> new file mode 100644
>> index 0000000..14e1022
>> --- /dev/null
>> +++ b/tests/cap-cxl-dvsec
>> @@ -0,0 +1,8 @@
>> +Simple diff of lspci -vvxxxx
>> +
>> +<       Capabilities: [e00 v1] Designated Vendor-Specific <?>
>> +---
>> +>       Capabilities: [e00 v1] PCIe DVSEC for CXL Device
>> +>               CXLCap: Cache+ IO+ Mem+ Mem HW Init+ HDMCount 1 
>> Viral-
>> +>               CXLCtl: Cache- IO+ Mem- Cache SF Cov 0 Cache SF Gran 
>> 0 Cache Clean- Viral-
>> +>               CXLSta: Viral-
>
> I think this should be complete "lspci -vvxxxx" or "lspci -xxxx"
> output.  If there's secret stuff in there you don't want to expose
> yet, I don't personally object to editing the hexdump to zero it out.
> But the point is that people should be able to run "lspci -F" on this
> file to decode it.

Understood. I’m running this in simulation right now.  I will see what 
I can do.

Best regards,

Sean

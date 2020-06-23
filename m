Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6273C20571E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 18:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbgFWQWn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jun 2020 12:22:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:42921 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732155AbgFWQWn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jun 2020 12:22:43 -0400
IronPort-SDR: fs+er1UcfAYgXdnuJXpaJ2yk7B0z7aOLGs0X7pRdXKa4RWbuynRkI7TNKRPBamlG8tAhrbpZH5
 oDkz4gVN4CRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="162208933"
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="162208933"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 09:22:40 -0700
IronPort-SDR: jWJ1ahjQWjXc8KPcuWYyWsgdwLRC3DsN5MI6MvSt7jg9WL/cqj0AMWE6ogs1f9qFPyXS3pRLUR
 dU4Rqyx9A02w==
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="452281068"
Received: from hungjul-mobl1.amr.corp.intel.com (HELO [10.212.71.70]) ([10.212.71.70])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 09:22:39 -0700
From:   "Sean V Kelley" <sean.v.kelley@linux.intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     mj@ucw.cz, bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pciutils: Add decode support for RCECs
Date:   Tue, 23 Jun 2020 09:22:38 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <5DE19132-95CF-4DE7-8C19-4712E5224DD7@linux.intel.com>
In-Reply-To: <20200622232617.GA2334699@bjorn-Precision-5520>
References: <20200622232617.GA2334699@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for your review.  My comments below:

On 22 Jun 2020, at 16:26, Bjorn Helgaas wrote:

> On Mon, Jun 22, 2020 at 04:03:30PM -0700, Sean V Kelley wrote:
>> Root Complex Event Collectors provide support for terminating error
>> and PME messages from RCiEPs.  This patch provides basic decoding for
>> lspci RCEC Endpoint Association Extended Capability. See PCie 5.0-1,
>> sec 7.9.10 for further details.
>
> s/lspci/the/
> s/PCie/PCIe/

Will fix.

>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>
>> ---
>>  lib/header.h   |   8 +-
>>  ls-ecaps.c     |  30 ++++-
>>  setpci.c       |   2 +-
>>  tests/cap-rcec | 299 
>> +++++++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 335 insertions(+), 4 deletions(-)
>>  create mode 100644 tests/cap-rcec
>>
>> diff --git a/lib/header.h b/lib/header.h
>> index 472816e..deb5150 100644
>> --- a/lib/header.h
>> +++ b/lib/header.h
>> @@ -219,7 +219,7 @@
>>  #define PCI_EXT_CAP_ID_PB	0x04	/* Power Budgeting */
>>  #define PCI_EXT_CAP_ID_RCLINK	0x05	/* Root Complex Link Declaration 
>> */
>>  #define PCI_EXT_CAP_ID_RCILINK	0x06	/* Root Complex Internal Link 
>> Declaration */
>> -#define PCI_EXT_CAP_ID_RCECOLL	0x07	/* Root Complex Event Collector 
>> */
>> +#define PCI_EXT_CAP_ID_RCEC	0x07	/* Root Complex Event Collector */
>
> OK, not super descriptive, but it does match the kernel's definition
> in pci_regs.h.

Yes, thanks.

>
>>  #define PCI_EXT_CAP_ID_MFVC	0x08	/* Multi-Function Virtual Channel 
>> */
>>  #define PCI_EXT_CAP_ID_VC2	0x09	/* Virtual Channel (2nd ID) */
>>  #define PCI_EXT_CAP_ID_RCRB	0x0a	/* Root Complex Register Block */
>> @@ -1048,6 +1048,12 @@
>>  #define  PCI_RCLINK_LINK_ADDR	8	/* Link Entry: Address (64-bit) */
>>  #define  PCI_RCLINK_LINK_SIZE	16	/* Link Entry: sizeof */
>>
>> +/* Root Complex Event Collector */
>
> This comment could mention "Endpoint Association", though.

Will do, good point.

>
>> +#define  PCI_RCEC_EP_CAP_VER(reg)	(((reg) >> 16) & 0xf)
>> +#define  PCI_RCEC_BUSN_REG_VER	0x02	/* as per PCIe sec 7.9.10.1 */
>> +#define  PCI_RCEC_RCIEP_BMAP	0x0004	/* as per PCIe sec 7.9.10.2 */
>> +#define  PCI_RCEC_BUSN_REG	0x0008	/* as per PCIe sec 7.9.10.3 */
>> +
>>  /* PCIe Vendor-Specific Capability */
>>  #define PCI_EVNDR_HEADER	4	/* Vendor-Specific Header */
>>  #define PCI_EVNDR_REGISTERS	8	/* Vendor-Specific Registers */
>> diff --git a/ls-ecaps.c b/ls-ecaps.c
>> index e71209e..589332d 100644
>> --- a/ls-ecaps.c
>> +++ b/ls-ecaps.c
>> @@ -634,6 +634,32 @@ cap_rclink(struct device *d, int where)
>>      }
>>  }
>>
>> +static void
>> +cap_rcec(struct device *d, int where)
>> +{
>> +  printf("Root Complex Event Collector\n");
>
> This could mention "Endpoint Association", too.

Will add.

>
>> +  if (verbose < 2)
>> +    return;
>> +
>> +  if (!config_fetch(d, where, 12))
>> +    return;
>> +
>> +  u32 hdr = get_conf_long(d, where);
>> +  byte cap_ver = PCI_RCEC_EP_CAP_VER(hdr);
>> +  u32 bmap = get_conf_long(d, where + PCI_RCEC_RCIEP_BMAP);
>> +  printf("\t\tDesc:\tCapabilityVersion=%02x RCiEPBitmap=%08x\n",
>> +    cap_ver,
>> +    bmap);
>
> I don't think "Desc:" is necessary.
>
> Isn't "cap_ver" already printed as part of the header?
>
>    Capabilities: [160 v2] Root Complex Event Collector
>                       ^^

Correct, it’s the same.  I can skip that.

>
> The "bmap" is a bitmap of device numbers of RCiEPs on the same bus as
> the RCEC that are associated with this RCEC.  Could be decoded as a
> list, e.g., "0, 1, 2, 8" or "0-3, 8".  Or maybe the hex bitmap is
> enough.  Not sure how much trouble this would be worth or if there are
> other examples in lspci to copy.

I think it could be worth it, I’ll have a look.

Thanks,

Sean

>
>> +  if (cap_ver < PCI_RCEC_BUSN_REG_VER)
>> +    return;
>> +
>> +  u32 busn = get_conf_long(d, where + PCI_RCEC_BUSN_REG);
>> +  printf("\t\t\tRCECLastBus=%02x RCECFirstBus=%02x\n",
>> +    BITS(busn, 16, 8),
>> +    BITS(busn, 8, 8));
>> +}

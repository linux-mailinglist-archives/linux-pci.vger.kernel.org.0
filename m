Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A942D1A3BBD
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 23:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgDIVNQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 17:13:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:10279 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgDIVNP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Apr 2020 17:13:15 -0400
IronPort-SDR: /84fPFT6iTqqV17qeTsOz8ET9DTX8o6aigvnpOItjmiP/HVyZAJmyaDJYgMMRBBaps6tmDgdcx
 ayiRFaEXpH3Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 14:13:16 -0700
IronPort-SDR: qLmaHQ1xMdIbinL+MCYKwjanROPRnFQTu2tYCvhtdlL1+MfXLPBohpg4ETxXzKdYucFmX8rN7w
 bb/ys498+VZg==
X-IronPort-AV: E=Sophos;i="5.72,364,1580803200"; 
   d="scan'208";a="452148258"
Received: from muthiahx-mobl.amr.corp.intel.com (HELO [10.212.186.196]) ([10.212.186.196])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 14:13:15 -0700
From:   "Sean V Kelley" <sean.v.kelley@linux.intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     mj@ucw.cz, linux-pci@vger.kernel.org
Subject: Re: [Patch 1/1] lspci: Add available DVSEC details
Date:   Thu, 09 Apr 2020 14:13:14 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <2F6DE20A-485E-4E65-9BF2-59673430366F@linux.intel.com>
In-Reply-To: <20200409195616.GA62263@google.com>
References: <20200409195616.GA62263@google.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9 Apr 2020, at 12:56, Bjorn Helgaas wrote:

> On Thu, Apr 09, 2020 at 11:32:04AM -0700, Sean V Kelley wrote:
>> Instead of current generic 'unknown' output for DVSEC, add details on
>> Vendor ID, Rev, etc.
>>
>> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>
>
> Looks good to me.
>
>> +static void
>> +cap_dvsec(struct device *d, int where)
>> +{
>> +  u32 hdr;
>> +
>> +  printf("Designated Vendor Specific Extended Capability:\n");
>

> s/Vendor Specific/Vendor-Specific/ to match the spec usage
> s/ Extended Capability:// to match other lspci capability output (?)
>

Sure, sounds good.

>> +4e:00.0 Unassigned class [ff00]: Intel Corporation Device 0d93
>
>> +        Capabilities: [d00 v1] Vendor Specific Information: ID=0040 
>> Rev=1 Len=04c <?>
>> +        Capabilities: [e00 v1] Designated Vendor Specific Extended 
>> Capability:
>> +                DVSEC Vendor ID=8086 Rev=0 Len=038 <?>
>> +                DVSEC ID=0000 <?>
>> +        Capabilities: [e38 v1] Device Serial Number 
>> 12-34-56-78-90-00-00-00
>> +00: 86 80 93 0d 00 00 10 00 00 00 00 ff 00 00 80 00
>
> Obviously this class code is wrong.  I assume it'll be fixed in real
> hardware, but ironically we've just spent a few days chasing a problem
> because of a Google Edge TPU with invalid class code.  In that case,
> Linux doesn't assign resources to BARs, so things fall apart after
> that.

Wow.  Easy to forget how much depends on it.  Yes, it will be fixed in 
real hardware with real IDs.  :)

Thanks,

Sean


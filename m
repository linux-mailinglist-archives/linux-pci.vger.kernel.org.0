Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8EF12DADD
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 19:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLaSNs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 13:13:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:63315 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfLaSNs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Dec 2019 13:13:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2019 10:13:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,380,1571727600"; 
   d="scan'208";a="216100240"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 31 Dec 2019 10:13:47 -0800
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 4A6F558043C;
        Tue, 31 Dec 2019 10:13:47 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v11 5/8] PCI/AER: Allow clearing Error Status Register in
 FF mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com, Austin.Bolen@dell.com
References: <20191230235902.GA226371@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <d6986b35-f015-6bb4-f2cd-0baf0a40b163@linux.intel.com>
Date:   Tue, 31 Dec 2019 10:11:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191230235902.GA226371@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 12/30/19 3:59 PM, Bjorn Helgaas wrote:
> [+cc Austin]
>
> On Thu, Dec 26, 2019 at 04:39:11PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> As per PCI firmware specification r3.2 System Firmware Intermediary
>> (SFI) _OSC and DPC Updates ECR
>> (https://members.pcisig.com/wg/PCI-SIG/document/13563),
> What is the state of this ECR?  I see it in the "PCI Express Review
> Zone Archive".  I don't know what the usage is of the "Review Zone" vs
> the "Review Zone Archive / PCI Express Review Zone Archive".  AFAICS,
> it is not listed in any of the "Documents for 60 Day Member Review".
>
> And I think it needs some clarification (for one thing, it needs to
> say what the red/blue text means).  I've mentioned some other items to
> Austin, but I haven't read it in detail because it seems like it's not
> quite baked yet.
>
> E.g., there's language about "it may make sense for an embedded system
> OS to own SFI, but it's recommended that general-purpose OSes never
> request SFI ownership."  That's useless: Linux is certainly a general
> purpose OS, but Linux is also often an embedded OS.  So the ECR
> doesn't provide useful guidance about how an OS should decide whether
> to request SFI ownership.
This ECR has merged three different change proposals (SFI related,
_OSC related updates and update to implementation note of DPC
handling with EDR support) into a single document.  Out of these
three changes, we only care about "DPC implementation note update".

We already have a ECR specification for Error Disconnect Recover (EDR)
support (https://members.pcisig.com/wg/PCI-SIG/document/12888) in published
spec section. But this document has some ambiguous statements / missing 
details
which as  clarified in the implementation note section of mentioned ECR.
>
> Making code changes based on a published spec or ECN is fine,
> obviously.  Changes based on an ECR that is well on track to being
> accepted, e.g., is in the 60-day review period, are probably OK.  I
> don't yet have warm fuzzies about this ECR because I have no idea how
> far along it is.
>
> We might be able to justify some of these changes based on other
> specs; it just sounds weird to me to say "based on this Engineering
> Change Request that might be accepted someday, we must do X".  Anybody
> can dream up an ECR that says anything at all, so AFAICT, an ECR is
> not at all authoritative.
>
>> sec titled
>> "DPC Event Handling Implementation Note", page 10, Error Disconnect
>> Recover (EDR) support allows OS to handle error recovery and clearing
>> Error Registers even in FF mode. So create exception for FF mode checks
>> in pci_cleanup_aer_uncorrect_error_status(), pci_aer_clear_fatal_status()
>> and pci_cleanup_aer_error_status_regs() functions when its being called
>> from DPC code path.

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer


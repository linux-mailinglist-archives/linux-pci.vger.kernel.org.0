Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94CEA76EBA
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2019 18:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfGZQSR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Jul 2019 12:18:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:7028 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfGZQSR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jul 2019 12:18:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 09:18:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="189674915"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jul 2019 09:18:15 -0700
Date:   Fri, 26 Jul 2019 10:15:24 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH] PCI/AER: save/restore AER registers during suspend/resume
Message-ID: <20190726161524.GA8437@localhost.localdomain>
References: <92EBB4272BF81E4089A7126EC1E7B28479A7F14D@IRSMSX101.ger.corp.intel.com>
 <1fbfe79b-0123-7305-5fc3-4963599538a3@linux.intel.com>
 <92EBB4272BF81E4089A7126EC1E7B28479A7F9BA@IRSMSX101.ger.corp.intel.com>
 <cd3cb1af-bc80-f92d-b9e4-7b7c2a9bd2fb@linux.intel.com>
 <20190724184548.GC203187@google.com>
 <20190725160822.GB6949@localhost.localdomain>
 <92EBB4272BF81E4089A7126EC1E7B28479A8704C@IRSMSX101.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B28479A8704C@IRSMSX101.ger.corp.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 26, 2019 at 02:00:05AM -0700, Patel, Mayurkumar wrote:
> > The call to pci_save_state most likely occurs long before a user has an
> > opportunity to alter these regsiters, though. Won't this just restore
> > what was previously there, and not the state you changed it to?
> 
> 
> There were two things (not sure to call them issues),
> 1. PCI_ERR_ROOT_COMMAND resets to 0  during S3 entry/exit, which disables AER interrupt trigger
> if AER happens on Endpoint after resume.
> 
> Also specified in spec. NCB-PCI_Express_Base_4.0r1.0_September-27-2017-c.pdf in
> chapter 7.8.4.9 Root Error Command Register (Offset 2Ch) - in bitfields descriptions.
> i.e. Correctable Error Reporting Enable – When Set, this bit enables the generation of an interrupt when
> a correctable error is reported by any of the Functions in the Hierarchy Domain associated with this Root Port.
> 
> 2. Root port resets to its default configuration of UNCOR_MASK/SEVER/COR_MASK register bits after system resume.
> This influences user configurations, how errors shall be treated if AER happens on root port itself due to Device (for example
> Endpoint not answering which results in completion timeouts on root ports).
> 
> Following is one example scenario which can handled with this patch.
> - user configures AER registers using setpci certain masks and severity based on debug requirements. This can be applied on Root port of EP.
> - triggers system test which includes S3 entry/exit cycles.
> - system enters s3 -> AER registers settings are saved which has been configured by users.
> - system exits s3 -> AER registers settings are restored which has been configured by users.

Right, I was just more curious *where* the aer state was being saved
during suspend since pci port driver only saves state during probe. This
patch must be relying on the generic pci-driver's power management. I
think that works, but I just didn't realize initially that we're relying
on that path.

> > You are allocating the capability save buffer in aer_probe(), so this
> > save/restore applies only to root ports. But you mention above that you
> > want to restore end devices, right?
> 
> That’s correct. I agree that my commit message was not so explicit.
> But Since I included PCI_ERR_ROOT_COMMAND register for save/restore which is specific to Root ports only & I thought
> endpoint drivers can handle to save/restore (UNCOR_MASK/SEVER/COR_MASK) themselves with its suspend/resume functions.
> 
> However I am fine to move pci_add_ext_cap_save_buffer() to some other function so
> that it also save/restores UNCOR_MASK/SEVER/COR_MASK registers for endpoints and
> if it's not useful to save/restore MASK & SEVER registers  then also fine to remove them
> and just restore PCI_ERR_ROOT_COMMAND & ECRC settings.  Please let me know.

If users are changing default settings that you want to preserve, that
reason should apply to bridges and endpoints too, so I think you ought
to allocate the save buffer for this capability for all devices that
support it in in pci_aer_init(). Just make sure to check the device type
in save/restore so you're not accessing root port specific registers.

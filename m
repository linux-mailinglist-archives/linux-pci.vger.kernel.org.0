Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07EC5DC655
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 15:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408471AbfJRNkn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 09:40:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:37267 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbfJRNkn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 09:40:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 06:40:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,311,1566889200"; 
   d="scan'208";a="348084175"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 18 Oct 2019 06:40:40 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iLSUi-0003zv-7z; Fri, 18 Oct 2019 16:40:40 +0300
Date:   Fri, 18 Oct 2019 16:40:40 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [RESEND PATCH v3] PCI/AER: Save and restore AER config state
Message-ID: <20191018134040.GG32742@smile.fi.intel.com>
References: <20191018084721.GS32742@smile.fi.intel.com>
 <20191018123729.GA158700@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018123729.GA158700@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 18, 2019 at 07:37:29AM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 18, 2019 at 11:47:21AM +0300, andriy.shevchenko@linux.intel.com wrote:
> > On Thu, Oct 17, 2019 at 06:09:08PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Oct 08, 2019 at 05:22:34PM +0000, Patel, Mayurkumar wrote:
> > > > This patch provides AER config save and restore capabilities. After system
> > > > resume AER config registers settings are lost. Not restoring AER root error
> > > > command register bits on root port if they were set, disables generation
> > > > of an AER interrupt reported by function as described in PCIe spec r4.0,
> > > > sec 7.8.4.9. Moreover, AER config mask, severity and ECRC registers are
> > > > also required to maintain same state prior to system suspend to maintain
> > > > AER interrupts behavior.
> > 
> > > Can you send this as plain text?  The patch seems to be a
> > > quoted-printable attachment, and I can't figure out how to decode it
> > > in a way "patch" will understand.
> > 
> > I understand that it changes your workflow and probably you won't like,
> > though you can use patchwork (either thru web, or directly thru client(s)
> > like git pw): https://patchwork.ozlabs.org/patch/1173439/
> 
> I had already tried that and "patch" still thought it was corrupted.
> Same thing happens when downloading from lore.kernel.org.  Did you try
> it and it worked for you?

Hmm... indeed. patch work recognizes the patch, but fails to validate it...

Original mbox is broken :(
https://marc.info/?l=linux-pci&m=157055537210812&w=2&q=mbox

So, here is for sure the problem on the sender's side.
Sorry for the noise from me.

-- 
With Best Regards,
Andy Shevchenko



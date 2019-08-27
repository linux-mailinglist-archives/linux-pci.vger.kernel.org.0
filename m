Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465ED9F675
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 00:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfH0Wxz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 18:53:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:54664 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfH0Wxz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 18:53:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 15:53:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,439,1559545200"; 
   d="scan'208";a="181840162"
Received: from skuppusw-desk.jf.intel.com (HELO skuppusw-desk.amr.corp.intel.com) ([10.54.74.33])
  by fmsmga007.fm.intel.com with ESMTP; 27 Aug 2019 15:53:54 -0700
Date:   Tue, 27 Aug 2019 15:50:58 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Denis Efremov <efremov@linux.com>, Lukas Wunner <lukas@wunner.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Simplify PCIe hotplug indicator control
Message-ID: <20190827225058.GG28404@skuppusw-desk.amr.corp.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
References: <20190819160643.27998-1-efremov@linux.com>
 <2f4c857e-a7cc-58da-8be5-cba581c56d9f@linux.com>
 <20190827223254.GC9987@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827223254.GC9987@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 27, 2019 at 05:32:54PM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 20, 2019 at 03:16:43PM +0300, Denis Efremov wrote:
> > On 8/19/19 7:06 PM, Denis Efremov wrote:
> > > PCIe defines two optional hotplug indicators: a Power indicator and an
> > > Attention indicator. Both are controlled by the same register, and each
> > > can be on, off or blinking. The current interfaces
> > > (pciehp_green_led_{on,off,blink}() and pciehp_set_attention_status()) are
> > > non-uniform and require two register writes in many cases where we could
> > > do one.
> > > 
> > > This patchset introduces the new function pciehp_set_indicators(). It
> > > allows one to set two indicators with a single register write. All
> > > calls to previous interfaces (pciehp_green_led_* and
> > > pciehp_set_attention_status()) are replaced with a new one. Thus,
> > > the amount of duplicated code for setting indicators is reduced.
> > > 
> > > Changes in v3:
> > >   - Changed pciehp_set_indicators() to work with existing
> > >     PCI_EXP_SLTCTL_* macros
> > >   - Reworked the inputs validation in pciehp_set_indicators()
> > >   - Removed pciehp_set_attention_status() and pciehp_green_led_*()
> > >     completely
> > > 
> > > Denis Efremov (4):
> > >   PCI: pciehp: Add pciehp_set_indicators() to jointly set LED indicators
> > >   PCI: pciehp: Switch LED indicators with a single write
> > >   PCI: pciehp: Remove pciehp_set_attention_status()
> > >   PCI: pciehp: Remove pciehp_green_led_{on,off,blink}()
> > 
> > Lukas, Sathyanarayanan, sorry that I've dropped most of yours "Reviewed-by".
> > The changes in the last 2 patches were significant.
> 
> Anybody want to review these?

Except for one nitpick in [PATCH v3 1/4], rest seems fine to me.

-- 
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

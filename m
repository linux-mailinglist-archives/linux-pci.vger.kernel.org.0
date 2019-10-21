Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E05F4DF1EB
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 17:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfJUPqZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 11:46:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:15381 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbfJUPqY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 11:46:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 08:46:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200"; 
   d="scan'208";a="209463506"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 21 Oct 2019 08:46:07 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 21 Oct 2019 18:46:06 +0300
Date:   Mon, 21 Oct 2019 18:46:06 +0300
From:   Mika Westerberg <mika.westerberg@intel.com>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
Message-ID: <20191021154606.GT2819@lahna.fi.intel.com>
References: <CACO55ttOJaXKWmKQQbMAQRJHLXF-VtNn58n4BZhFKYmAdfiJjA@mail.gmail.com>
 <20191016213722.GA72810@google.com>
 <CACO55tuXck7vqGVLmMBGFg6A2pr3h8koRuvvWHLNDH8XvBVxew@mail.gmail.com>
 <20191021133328.GI2819@lahna.fi.intel.com>
 <CACO55tujUZr+rKkyrkfN+wkNOJWdNEVhVc-eZ3RCXJD+G1z=7A@mail.gmail.com>
 <20191021140852.GM2819@lahna.fi.intel.com>
 <CACO55tvp6n2ahizwhc70xRJ1uTohs2ep962vwtHGQK-MkcLmsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55tvp6n2ahizwhc70xRJ1uTohs2ep962vwtHGQK-MkcLmsw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 21, 2019 at 04:49:09PM +0200, Karol Herbst wrote:
> On Mon, Oct 21, 2019 at 4:09 PM Mika Westerberg
> <mika.westerberg@intel.com> wrote:
> >
> > On Mon, Oct 21, 2019 at 03:54:09PM +0200, Karol Herbst wrote:
> > > > I really would like to provide you more information about such
> > > > workaround but I'm not aware of any ;-) I have not seen any issues like
> > > > this when D3cold is properly implemented in the platform.  That's why
> > > > I'm bit skeptical that this has anything to do with specific Intel PCIe
> > > > ports. More likely it is some power sequence in the _ON/_OFF() methods
> > > > that is run differently on Windows.
> > >
> > > yeah.. maybe. I really don't know what's the actual root cause. I just
> > > know that with this workaround it works perfectly fine on my and some
> > > other systems it was tested on. Do you know who would be best to
> > > approach to get proper documentation about those methods and what are
> > > the actual prerequisites of those methods?
> >
> > Those should be documented in the ACPI spec. Chapter 7 should explain
> > power resources and the device power methods in detail.
> 
> either I looked up the wrong spec or the documentation isn't really
> saying much there.

Well it explains those methods, _PSx, _PRx and _ON()/_OFF(). In case of
PCIe device you also want to check PCIe spec. PCIe 5.0 section 5.8 "PCI
Function Power State Transitions" has a picture about the supported
power state transitions and there we can find that function must be in
D3hot before it can be transitioned into D3cold so if the _OFF() for
example blindly assumes that the device is in D0 when it is called, it
is a bug in the BIOS.

BTW, where can I find acpidump of such system?

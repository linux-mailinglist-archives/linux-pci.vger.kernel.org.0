Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA5942058A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 07:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhJDFSe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 01:18:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:17601 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232388AbhJDFSd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 01:18:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="206099171"
X-IronPort-AV: E=Sophos;i="5.85,344,1624345200"; 
   d="scan'208";a="206099171"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2021 22:16:45 -0700
X-IronPort-AV: E=Sophos;i="5.85,344,1624345200"; 
   d="scan'208";a="566826043"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2021 22:16:39 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 04 Oct 2021 08:16:36 +0300
Date:   Mon, 4 Oct 2021 08:16:36 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
Message-ID: <YVqONA0vhl0/H3QE@lahna>
References: <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
 <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
 <YVaywQLAboZ6b36V@kroah.com>
 <CAPcyv4gqs=KuGyxFR61QWqF6HKrRg851roCGUqrq585+s2Cm=w@mail.gmail.com>
 <20211001164533.GC505557@rowland.harvard.edu>
 <CAPcyv4i__reKFRP1KjWUov_W5jBQN9_vbUbKRL_V7KMM3oPuuQ@mail.gmail.com>
 <20211001190048.GA512418@rowland.harvard.edu>
 <CAPcyv4hYL51DcBuSuyMRFo5Jcc=zLd=Ugo+H_2saELcZ5AJBeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hYL51DcBuSuyMRFo5Jcc=zLd=Ugo+H_2saELcZ5AJBeQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Oct 01, 2021 at 12:57:18PM -0700, Dan Williams wrote:
> > > Ah, so are you saying that it would be sufficient for USB if the
> > > generic authorized implementation did something like:
> > >
> > > dev->authorized = 1;
> > > device_attach(dev);
> > >
> > > ...for the authorize case, and:
> > >
> > > dev->authorize = 0;
> > > device_release_driver(dev);
> > >
> > > ...for the deauthorize case?
> >
> > Yes, I think so.  But I haven't tried making this change to test and
> > see what really happens.
> 
> Sounds like a useful path for this effort to explore. Especially as
> Greg seems to want the proposed "has_probe_authorization" flag in the
> bus_type to disappear and make this all generic. It just seems that
> Thunderbolt would need deeper surgery to move what it does in the
> authorization toggle path into the probe and remove paths.
> 
> Mika, do you see a path for Thunderbolt to align its authorization
> paths behind bus ->probe() ->remove() events similar to what USB might
> be able to support for a generic authorization path?

In Thunderbolt "authorization" actually means whether there is a PCIe
tunnel to the device or not. There is no driver bind/unbind happening
when authorization toggles (well on Thunderbolt bus, there can be on PCI
bus after the tunnel is established) so I'm not entirely sure how we
could use the bus ->probe() or ->remove for that to be honest.

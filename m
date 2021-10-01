Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AF541F263
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 18:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhJAQrS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 12:47:18 -0400
Received: from netrider.rowland.org ([192.131.102.5]:54681 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232114AbhJAQrS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 12:47:18 -0400
Received: (qmail 508736 invoked by uid 1000); 1 Oct 2021 12:45:33 -0400
Date:   Fri, 1 Oct 2021 12:45:33 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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
Message-ID: <20211001164533.GC505557@rowland.harvard.edu>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org>
 <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
 <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
 <YVaywQLAboZ6b36V@kroah.com>
 <CAPcyv4gqs=KuGyxFR61QWqF6HKrRg851roCGUqrq585+s2Cm=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gqs=KuGyxFR61QWqF6HKrRg851roCGUqrq585+s2Cm=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 01, 2021 at 09:13:54AM -0700, Dan Williams wrote:
> Bear with me, and perhaps it's a lack of imagination on my part, but I
> don't see how to get to a globally generic "authorized" sysfs ABI
> given that USB and Thunderbolt want to do bus specific actions on
> authorization toggle events. Certainly a default generic authorized
> attribute can be defined for all the other buses that don't have
> legacy here, but Thunderbolt will still require support for '2' as an
> authorized value, and USB will still want to base probe decisions on
> the authorization state of both the usb_device and the usb_interface.

The USB part isn't really accurate (I can't speak for Thunderbolt). 
When a usb_device is deauthorized, the device will be unconfigured, 
deleting all its interfaces and removing the need for any probe 
decisions about them.  In other words, the probe decision for a 
usb_device or usb_interface depends only on the device's/interface's 
own authorization state.

True, the interface binding code does contain a test of the device's 
authorization setting.  That test is redundant and can be removed.

The actions that USB wants to take on authorization toggle events for 
usb_devices are: for authorize, select and install a configuration; 
for deauthorize, unconfigure the device.  Each of these could be 
handled simply enough just by binding/unbinding the device.  (There 
is some special code for handling wireless USB devices, but wireless 
USB is now defunct.)

Alan Stern

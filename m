Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F06C8DFBA
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2019 11:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfD2Jpm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Apr 2019 05:45:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:56282 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727239AbfD2Jpm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Apr 2019 05:45:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80E2CAD43;
        Mon, 29 Apr 2019 09:45:40 +0000 (UTC)
Message-ID: <1556531138.5647.1.camel@suse.de>
Subject: Re: [Bug 203297] Synaptics touchpad TM-3127 functionality broken by
 PCI runtime power management patch on 4.20.2
From:   Jean Delvare <jdelvare@suse.de>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keijo Vaara <ferdasyn@rocketmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>
Date:   Mon, 29 Apr 2019 11:45:38 +0200
In-Reply-To: <CAO-hwJLCPd-KfoK7OnSpEWG4B5cYfsH3J0tYAxJeVMqHyJEN1A@mail.gmail.com>
References: <20190422130814.GJ173520@google.com>
         <3a1139ef-10ed-6923-73c5-30fbf0c065c3@linux.intel.com>
         <CAO-hwJKvXO6L7m0g1D6wycFP=Wu_qLDyLXTtmm0TkpxT5Z8ygw@mail.gmail.com>
         <e96a7220-974f-1df6-70ee-695ee815057f@linux.intel.com>
         <CAO-hwJLCPd-KfoK7OnSpEWG4B5cYfsH3J0tYAxJeVMqHyJEN1A@mail.gmail.com>
Organization: Suse Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2019-04-29 at 10:53 +0200, Benjamin Tissoires wrote:
> On Mon, Apr 29, 2019 at 10:38 AM Jarkko Nikula
> <jarkko.nikula@linux.intel.com> wrote:
> > I got another thought about this. I noticed these input drivers need
> > SMBus Host Notify, maybe that explain the PM dependency? If that's the
> > only dependency then we could prevent the controller suspend if there is
> > a client needing host notify mechanism. IMHO that's less hack than the
> > patch to rmi_smbus.c.
> 
> So currently, AFAIK, only Synaptics (rmi4) and Elantech are using
> SMBus Host Notify.
> So this patch would prevent the same bugs for those 2 vendors, which is good.
> 
> It took me some time to understand why this would be less than a hack.
> And indeed, given that Host Notify relies on the I2C connection to be
> ready for the IRQ, we can not put the controller in suspend like we do
> for others where the IRQ controller is still ready.
> 
> So yes, that could work from me. Not sure what Wolfram and Jean would
> say though.

I would say OK with me, this looks like the cleanest solution to me, so
if testing is positive, let's go with it.

-- 
Jean Delvare
SUSE L3 Support

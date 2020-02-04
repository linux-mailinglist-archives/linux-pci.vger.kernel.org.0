Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAAC15150A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2020 05:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgBDEia (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Feb 2020 23:38:30 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:52629 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgBDEi3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Feb 2020 23:38:29 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id D0B35101C051A;
        Tue,  4 Feb 2020 05:38:25 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7C426DFAA5; Tue,  4 Feb 2020 05:38:25 +0100 (CET)
Date:   Tue, 4 Feb 2020 05:38:25 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Ben Skeggs <skeggsb@gmail.com>,
        Karol Herbst <karolherbst@gmail.com>,
        "Alex G." <mr.nuke.me@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jan Vesely <jano.vesely@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth
 notification"
Message-ID: <20200204043825.thpbqpz3ao7zqvlh@wunner.de>
References: <20200120023326.GA149019@google.com>
 <b9764896-102c-84cb-32ea-c2a122b6f0db@gmail.com>
 <8409fd7ad6b83da75c914a71accf522953a460a0.camel@pengutronix.de>
 <CAPM=9twvggZqVu=HmXZMN70+-6hAPGdog-dGFnM7jp3RhjAB9w@mail.gmail.com>
 <CAPM=9tz9dOLL=onbA-73T-hwzFYMXjSywCufqmnM7bP5dT_x0Q@mail.gmail.com>
 <CADnq5_PRQJmG_NYHmqWhv2R1utaNf0LcTVgFA7LMeYr75fy55w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_PRQJmG_NYHmqWhv2R1utaNf0LcTVgFA7LMeYr75fy55w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 03, 2020 at 04:16:36PM -0500, Alex Deucher wrote:
> AMD has had a micro-controller on the GPU handling pcie link speeds
> and widths dynamically (in addition to GPU clocks and voltages) for
> about 12 years or so at this point to save power when the GPU is idle
> and improve performance when it's required.  The micro-controller
> changes the link parameters dynamically based on load independent of
> the driver.  The driver can tweak the heuristics, or even disable the
> dynamic changes, but by default it's enabled when the driver loads.
> The ucode for this micro-controller is loaded by the driver so you'll
> see fixed clocks and widths prior to the driver loading.  We'd need
> some sort of opt out I suppose for periods when the driver has enabled
> dynamic pcie power management in the micro-controller.

Note that there are *two* bits in the Link Status Register:

* Link Autonomous Bandwidth Status
  "This bit is Set by hardware to indicate that hardware has
  autonomously changed Link speed or width, without the Port
  transitioning through DL_Down status, for reasons other than to
  attempt to correct unreliable Link operation.  This bit must be set if
  the Physical Layer reports a speed or width change was initiated by
  the Downstream component that was indicated as an autonomous change."

* Link Bandwidth Management Status
  "This bit is Set by hardware to indicate that either of the
  following has occurred without the Port transitioning through
  DL_Down status. [...] Hardware has changed Link speed or width to
  attempt to correct unreliable Link operation, either through an
  LTSSM timeout or a higher level process."

See PCIe Base Spec 4.0 sec 7.8.8, 7.8.7, 4.2.6.3.3.1.

The two bits generate *separate* interrupts.  We only enable the
interrupt for the latter.

If AMD GPUs generate a Link Bandwidth Management Interrupt upon
autonomously changing bandwidth for power management reasons
(instead of to correct unreliability issues), that would be a
spec violation.

So the question is, do your GPUs violate the spec in this regard?

Thanks,

Lukas

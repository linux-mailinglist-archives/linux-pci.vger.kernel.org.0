Return-Path: <linux-pci+bounces-1630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 061A582318F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 17:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDD31F220A2
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 16:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC921BDED;
	Wed,  3 Jan 2024 16:51:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279231BDEC;
	Wed,  3 Jan 2024 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id F3C6530000861;
	Wed,  3 Jan 2024 17:51:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E6CE12B0031; Wed,  3 Jan 2024 17:51:19 +0100 (CET)
Date: Wed, 3 Jan 2024 17:51:19 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3 06/10] PCI: Cache PCIe device's Supported Speed Vector
Message-ID: <20240103165119.GB3463@wunner.de>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
 <20230929115723.7864-7-ilpo.jarvinen@linux.intel.com>
 <20231230151931.GA25718@wunner.de>
 <94973372-91fc-27fc-b187-7427af9e4b7d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94973372-91fc-27fc-b187-7427af9e4b7d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jan 01, 2024 at 08:31:39PM +0200, Ilpo Järvinen wrote:
> On Sat, 30 Dec 2023, Lukas Wunner wrote:
> > On Fri, Sep 29, 2023 at 02:57:19PM +0300, Ilpo Järvinen wrote:
> > > Only the former is currently cached in pcie_bus_speeds in
> > > the struct pci_bus. The link speeds that are supported is the
> > > intersection of these two.
> > 
> > I'm wondering if caching both is actually necessary.  Why not cache
> > just the intersection?  Do we need either of the two somewhere?
> 
> Intersection is enough at least for bwctrl. The only downside that is 
> barely worth mentioning is that the bus SLSV has to be re-read when
> function 0 sets the intersection.
>
> I can think of somebody wanting to expose the list of both supported speed 
> to userspace though sysfs (not done by this patch series), but they could 
> be read from the registers in that case so that use case doesn't really 
> matter much, IMO.

Yes, that would be a reasonable argument to keep both values instead
of storing just the intersection.


> > > Store the device's Supported Link Speeds Vector into the struct pci_bus
> > > when the Function 0 is enumerated (the Multi-Function Devices must have
> > > same speeds the same for all Functions) to be easily able to calculate
> > > the intersection of Supported Link Speeds.
> > 
> > Might want to add an explanation what you're going to need this for,
> > I assume it's accessed frequently by the bandwidth throttling driver
> > in a subsequent patch?
> 
> Yes. I tend to try to avoid forward references because some maintainers 
> complain about them (leading to minimal changes where true motivations 
> have to be hidden because "future" cannot be used to motivate a change 
> even if that's often the truest motivation within a patch series). But 
> I'll add a fwd ref here to make it more obvious. :-)

Bjorn has used phrases such as "We're about to ..." a couple of times
in commit messages to convey that a particular change in the present
patch will be taken advantage of by a subsequent patch.

I've used the same phrase but got criticized (in other subsystems)
for using "we".

So I use phrases such as:

 "An upcoming commit will create DOE mailboxes upon device enumeration by
  the PCI core.  Their lifetime shall not be limited by a driver.
  Therefore rework..." (see 022b66f38195)

Can also reference the past:

 "The PCI core has just been amended to create a pci_doe_mb struct for
  every DOE instance on device enumeration.  [...]  That leaves [...]
  without any callers, so drop them." (see 74e491e5d1bc)

If someone finds your commit e.g. through git blame, it may help them
enormously if you provide context in the commit message.  If maintainers
in other subsystem tell you otherwise, they're wrong. ;)

Thanks,

Lukas


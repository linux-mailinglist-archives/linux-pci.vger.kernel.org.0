Return-Path: <linux-pci+bounces-1580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 937FB821484
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 17:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EED8B212A7
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 16:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A944D63A7;
	Mon,  1 Jan 2024 16:40:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDAB8F57;
	Mon,  1 Jan 2024 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id EF5EC1019DAE4;
	Mon,  1 Jan 2024 17:40:10 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A71264B2CE; Mon,  1 Jan 2024 17:40:10 +0100 (CET)
Date: Mon, 1 Jan 2024 17:40:10 +0100
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
Subject: Re: [PATCH v3 05/10] PCI: Store all PCIe Supported Link Speeds
Message-ID: <20240101164010.GA23354@wunner.de>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
 <20230929115723.7864-6-ilpo.jarvinen@linux.intel.com>
 <20231230114549.GB12257@wunner.de>
 <20231230193000.GA11331@wunner.de>
 <5dd84bbf-2e5-dded-bf49-f4db17b265f0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dd84bbf-2e5-dded-bf49-f4db17b265f0@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jan 01, 2024 at 06:26:40PM +0200, Ilpo Järvinen wrote:
> On Sat, 30 Dec 2023, Lukas Wunner wrote:
> 
> > On Sat, Dec 30, 2023 at 12:45:49PM +0100, Lukas Wunner wrote:
> > > On Fri, Sep 29, 2023 at 02:57:18PM +0300, Ilpo Järvinen wrote:
> > > > struct pci_bus stores max_bus_speed. Implementation Note in PCIe r6.0.1
> > > > sec 7.5.3.18, however, recommends determining supported Link Speeds
> > > > using the Supported Link Speeds Vector in the Link Capabilities 2
> > > > Register (when available).
> > > > 
> > > > Add pcie_bus_speeds into struct pci_bus which caches the Supported Link
> > > > Speeds. The value is taken directly from the Supported Link Speeds
> > > > Vector or synthetized from the Max Link Speed in the Link Capabilities
> > > > Register when the Link Capabilities 2 Register is not available.
> > > 
> > > Remind me, what's the reason again to cache this and why is
> > > max_bus_speed not sufficient?  Is the point that there may be
> > > "gaps" in the supported link speeds, i.e. not every bit below
> > > the maximum supported speed may be set?  And you need to skip
> > > over those gaps when throttling to a lower speed?
> > 
> > FWIW I went and re-read the internal review I provided on May 18.
> > Turns out I already mentioned back then that gaps aren't permitted:
> > 
> >  "Per PCIe r6.0.1 sec 8.2.1, the bitfield in the Link Capabilities 2
> >   register is not permitted to contain gaps between maximum supported
> >   speed and lowest possible speed (2.5 GT/s Gen1)."
> > 
> > 
> > > Also, I note that pci_set_bus_speed() doesn't use LNKCAP2.
> > 
> > About that, I wrote in May:
> > 
> >  "Actually, scratch that.  pci_set_bus_speed() is fine.  Since it's only
> >   interested in the *maximum* link speed, reading just LnkCap is correct.
> >   LnkCap2 only needs to be read to determine if a certain speed is
> >   *supported*.  E.g., even though 32 GT/s are supported, perhaps 16 GT/s
> >   are not.
> > 
> >   It's rather pcie_get_speed_cap() which should be changed.  There's
> >   no need for it to read LnkCap2.  The commit which introduced this,
> >   6cf57be0f78e, was misguided and had to be fixed up with f1f90e254e46.
> >   It could be simplified to just read LnkCap and return
> >   pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS].  If the device is a
> >   Root Port or Downstream Port, it doesn't even have to do that but
> >   could return the cached value in subordinate->max_bus_speed.
> >   If you add another attribute to struct pci_bus for the downstream
> >   device's maximum speed, the maximum speed for Endpoints and Upstream
> >   Ports could be returned directly as well from that attribute."
> 
> I know it's quite far back so it's understandable to forget :-), 
> but already by May 23rd your position had changed and you wrote this:
> 
> 'Per the Implementation Note at the end of PCIe r6.0.1 sec 7.5.3.18,
> 
>    "It is strongly encouraged that software primarily utilize the
>     Supported Link Speeds Vector instead of the Max Link Speed field,
>     so that software can determine the exact set of supported speeds on
>     current and future hardware. This can avoid software being confused
>     if a future specification defines Links that do not require support
>     for all slower speeds."
> 
> This means that it's not sufficient if you just check that the desired 
> speed is lower than the maximum.  Instead, you should check if the bit 
> corresponding to the desired speed is set in the LnkCap2 register's 
> Supported Link Speeds Vector.
> 
> PCIe r6.0.1 sec 8.2.1 stipulates that the bitfield is not permitted to 
> contain gaps between maximum supported speed and lowest possible speed
> (2.5 GT/s Gen1).  However the Implementation Note suggests that rule may 
> no longer apply in future revisions of the PCIe Base Spec.'
> 
> So I'd assume I should still follow the way spec recommends, not the "old 
> method" that may not function correctly after some future version of the 
> spec, or have you really changed position once again on this?

I haven't, you're right, I forgot about all those details.
Thanks for that blast from the past. ;)

But it would be good to extend the commit message because without all
that context, it's difficult to understand why the max_bus_speed isn't
sufficient.

Lukas


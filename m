Return-Path: <linux-pci+bounces-1629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F33B823160
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 17:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A741C227BD
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 16:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13211B29B;
	Wed,  3 Jan 2024 16:40:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCE81BDCD;
	Wed,  3 Jan 2024 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 698962800BB42;
	Wed,  3 Jan 2024 17:40:06 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5C41E10B43F; Wed,  3 Jan 2024 17:40:06 +0100 (CET)
Date: Wed, 3 Jan 2024 17:40:06 +0100
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
Subject: Re: [PATCH v3 08/10] PCI/bwctrl: Add "controller" part into PCIe
 bwctrl
Message-ID: <20240103164006.GA3463@wunner.de>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
 <20230929115723.7864-9-ilpo.jarvinen@linux.intel.com>
 <20231230184905.GA6104@wunner.de>
 <b56bb460-7876-272a-23ce-83d1dab212b2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b56bb460-7876-272a-23ce-83d1dab212b2@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jan 01, 2024 at 08:12:43PM +0200, Ilpo Järvinen wrote:
> On Sat, 30 Dec 2023, Lukas Wunner wrote:
> > On Fri, Sep 29, 2023 at 02:57:21PM +0300, Ilpo Järvinen wrote:
> > > --- a/drivers/pci/pcie/bwctrl.c
> > > +static u16 speed2lnkctl2(enum pci_bus_speed speed)
> > > +{
> > > +	static const u16 speed_conv[] = {
> > > +		[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
> > > +		[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
> > > +		[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
> > > +		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
> > > +		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
> > > +		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
> > > +	};
> > 
> > Looks like this could be a u8 array to save a little bit of memory.
> > 
> > Also, this seems to duplicate pcie_link_speed[] defined in probe.c.
> 
> It's not the same. pcie_link_speed[] is indexed by a different thing

Ah, missed that.  Those various conversion functions are confusing.


> > > +	dev_speeds = READ_ONCE(bus->pcie_dev_speeds);
> > 
> > Hm, why is the compiler barrier needed?
> 
> It's probably an overkill but there could be a checker which finds this 
> read is not protected by anything while the value could get updated 
> concurrectly

Why should it be updated?  It's a static value cached on enumeration
and never changed AFAICS.


> If the value selected cannot be set because of endpoint no longer being 
> there, the other parts of the code will detect that.

If the endpoint is hot-unplugged, the link is down, so retraining
the link will fail.

If the device is replaced concurrently to retraining then you may
try to retrain to a speed which is too fast or too slow for the new
device.  Maybe it's necessary to cope with that?  Basically find the
pci_dev on the bus with the device/function id and check if the pci_dev
pointer still points to the same location.  Another idea would be to
hook up bwctrl with pciehp so that pciehp tells bwctrl the device is
gone and any speed changes should be aborted.  We've hooked up DPC
with pciehp in a similar way.


> So if I just add a comment to this line why there's the data race and keep 
> it as is?

I'd just drop the READ_ONCE() here if there's not a good reason for it.

Thanks,

Lukas


Return-Path: <linux-pci+bounces-1581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 723C9821488
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 17:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC32281846
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D7C63A0;
	Mon,  1 Jan 2024 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpET3GwR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150A66FB1;
	Mon,  1 Jan 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704128020; x=1735664020;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ucoHcQ6zg0XV0E1JPHjnPo7iCjTxFbzI/rI7Zcr2CAk=;
  b=LpET3GwR6zuvDcl8CWm/mrPyMGO8qP/DS36dARYFBk0A9qHpYn2ht1b6
   Vi8QSW5cUD1YAEZtFCgMK9rimivvuuxI4IxQmZaYs53tktfUITI0MqSxN
   8X7+uXyTHoK/cT7iHuUjwnpbZDEKYcf6clDrOWGx0FLCdyta7CSEBF8MJ
   iaeeIP16MdozYftK9rwjznfa/JsJeCPWnq/d6g9gPzmeehDaPNZMNlRlk
   fhudh+R5/stA2K7z5i6DREv4l9bPn6u2i73oHoGqMXHoNch0msdSiCjDr
   15AX3HLViY1BV4zQAQmFWhUw4a0mAuip5G2raFefP9+ugoj2WZFTtzEuv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="427967956"
X-IronPort-AV: E=Sophos;i="6.04,322,1695711600"; 
   d="scan'208";a="427967956"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 08:53:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="849890644"
X-IronPort-AV: E=Sophos;i="6.04,322,1695711600"; 
   d="scan'208";a="849890644"
Received: from amazouz-mobl.ger.corp.intel.com ([10.251.210.158])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 08:53:34 -0800
Date: Mon, 1 Jan 2024 18:53:29 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>, 
    Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
    Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, 
    Alex Deucher <alexdeucher@gmail.com>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3 05/10] PCI: Store all PCIe Supported Link Speeds
In-Reply-To: <20240101164010.GA23354@wunner.de>
Message-ID: <65d594cb-b21e-cfc2-7c79-e495b75067b@linux.intel.com>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com> <20230929115723.7864-6-ilpo.jarvinen@linux.intel.com> <20231230114549.GB12257@wunner.de> <20231230193000.GA11331@wunner.de> <5dd84bbf-2e5-dded-bf49-f4db17b265f0@linux.intel.com>
 <20240101164010.GA23354@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1756007640-1704128018=:7866"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1756007640-1704128018=:7866
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 1 Jan 2024, Lukas Wunner wrote:

> On Mon, Jan 01, 2024 at 06:26:40PM +0200, Ilpo Järvinen wrote:
> > On Sat, 30 Dec 2023, Lukas Wunner wrote:
> > 
> > > On Sat, Dec 30, 2023 at 12:45:49PM +0100, Lukas Wunner wrote:
> > > > On Fri, Sep 29, 2023 at 02:57:18PM +0300, Ilpo Järvinen wrote:
> > > > > struct pci_bus stores max_bus_speed. Implementation Note in PCIe r6.0.1
> > > > > sec 7.5.3.18, however, recommends determining supported Link Speeds
> > > > > using the Supported Link Speeds Vector in the Link Capabilities 2
> > > > > Register (when available).
> > > > > 
> > > > > Add pcie_bus_speeds into struct pci_bus which caches the Supported Link
> > > > > Speeds. The value is taken directly from the Supported Link Speeds
> > > > > Vector or synthetized from the Max Link Speed in the Link Capabilities
> > > > > Register when the Link Capabilities 2 Register is not available.
> > > > 
> > > > Remind me, what's the reason again to cache this and why is
> > > > max_bus_speed not sufficient?  Is the point that there may be
> > > > "gaps" in the supported link speeds, i.e. not every bit below
> > > > the maximum supported speed may be set?  And you need to skip
> > > > over those gaps when throttling to a lower speed?
> > > 
> > > FWIW I went and re-read the internal review I provided on May 18.
> > > Turns out I already mentioned back then that gaps aren't permitted:
> > > 
> > >  "Per PCIe r6.0.1 sec 8.2.1, the bitfield in the Link Capabilities 2
> > >   register is not permitted to contain gaps between maximum supported
> > >   speed and lowest possible speed (2.5 GT/s Gen1)."
> > > 
> > > 
> > > > Also, I note that pci_set_bus_speed() doesn't use LNKCAP2.
> > > 
> > > About that, I wrote in May:
> > > 
> > >  "Actually, scratch that.  pci_set_bus_speed() is fine.  Since it's only
> > >   interested in the *maximum* link speed, reading just LnkCap is correct.
> > >   LnkCap2 only needs to be read to determine if a certain speed is
> > >   *supported*.  E.g., even though 32 GT/s are supported, perhaps 16 GT/s
> > >   are not.
> > > 
> > >   It's rather pcie_get_speed_cap() which should be changed.  There's
> > >   no need for it to read LnkCap2.  The commit which introduced this,
> > >   6cf57be0f78e, was misguided and had to be fixed up with f1f90e254e46.
> > >   It could be simplified to just read LnkCap and return
> > >   pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS].  If the device is a
> > >   Root Port or Downstream Port, it doesn't even have to do that but
> > >   could return the cached value in subordinate->max_bus_speed.
> > >   If you add another attribute to struct pci_bus for the downstream
> > >   device's maximum speed, the maximum speed for Endpoints and Upstream
> > >   Ports could be returned directly as well from that attribute."
> > 
> > I know it's quite far back so it's understandable to forget :-), 
> > but already by May 23rd your position had changed and you wrote this:
> > 
> > 'Per the Implementation Note at the end of PCIe r6.0.1 sec 7.5.3.18,
> > 
> >    "It is strongly encouraged that software primarily utilize the
> >     Supported Link Speeds Vector instead of the Max Link Speed field,
> >     so that software can determine the exact set of supported speeds on
> >     current and future hardware. This can avoid software being confused
> >     if a future specification defines Links that do not require support
> >     for all slower speeds."
> > 
> > This means that it's not sufficient if you just check that the desired 
> > speed is lower than the maximum.  Instead, you should check if the bit 
> > corresponding to the desired speed is set in the LnkCap2 register's 
> > Supported Link Speeds Vector.
> > 
> > PCIe r6.0.1 sec 8.2.1 stipulates that the bitfield is not permitted to 
> > contain gaps between maximum supported speed and lowest possible speed
> > (2.5 GT/s Gen1).  However the Implementation Note suggests that rule may 
> > no longer apply in future revisions of the PCIe Base Spec.'
> > 
> > So I'd assume I should still follow the way spec recommends, not the "old 
> > method" that may not function correctly after some future version of the 
> > spec, or have you really changed position once again on this?
> 
> I haven't, you're right, I forgot about all those details.
> Thanks for that blast from the past. ;)
>
> But it would be good to extend the commit message because without all
> that context, it's difficult to understand why the max_bus_speed isn't
> sufficient.

Thanks. I'll extend the commit message.

-- 
 i.

--8323329-1756007640-1704128018=:7866--


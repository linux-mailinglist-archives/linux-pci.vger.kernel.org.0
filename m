Return-Path: <linux-pci+bounces-1578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E21D82146F
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 17:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790CC1C20B62
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8563A611E;
	Mon,  1 Jan 2024 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fSKrkM8b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB6363A0;
	Mon,  1 Jan 2024 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704126412; x=1735662412;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=qkQCaAfgp9d77EcAt0SnIBdGmkAlVg1/8Or7Ngnt334=;
  b=fSKrkM8b7C9/geQ4ZQGzAg8rXkeWs3GQ0sz/KSbKf3oZGuKHN4vZtdqB
   QZDILJYv57cCBf/kajvJfUhYGABqElWnCA1wywgz6w04xJLrG1hMs/KwD
   RmGxM3endeGlgHFhpWF7MZDBkg4RmH+7sFjBefH0r68mNM+thGgcVHMPR
   4fFKdGIHCYIrWDXhoeruPterqBBnUmKPmc0RbOuf9zkjnj1PKJrwunKb2
   khX9Wu8NHFAA5UYn7oEzUpxHKq4evMWb+hro7FpKze0vW4TaergNzcqDK
   dfEyBmqhb1bIVLqeI01aGmsrwb8nLfXlbR76SKqToQXM3GWexmri8UH4M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="18346893"
X-IronPort-AV: E=Sophos;i="6.04,322,1695711600"; 
   d="scan'208";a="18346893"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 08:26:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="729271316"
X-IronPort-AV: E=Sophos;i="6.04,322,1695711600"; 
   d="scan'208";a="729271316"
Received: from amazouz-mobl.ger.corp.intel.com ([10.251.210.158])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 08:26:45 -0800
Date: Mon, 1 Jan 2024 18:26:40 +0200 (EET)
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
In-Reply-To: <20231230193000.GA11331@wunner.de>
Message-ID: <5dd84bbf-2e5-dded-bf49-f4db17b265f0@linux.intel.com>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com> <20230929115723.7864-6-ilpo.jarvinen@linux.intel.com> <20231230114549.GB12257@wunner.de> <20231230193000.GA11331@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-737575340-1704125951=:2521"
Content-ID: <a0e641d6-2894-330-dff2-2c4cfef8318@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-737575340-1704125951=:2521
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <e45f3096-c420-8925-b335-96f1482f6de9@linux.intel.com>

On Sat, 30 Dec 2023, Lukas Wunner wrote:

> On Sat, Dec 30, 2023 at 12:45:49PM +0100, Lukas Wunner wrote:
> > On Fri, Sep 29, 2023 at 02:57:18PM +0300, Ilpo Järvinen wrote:
> > > struct pci_bus stores max_bus_speed. Implementation Note in PCIe r6.0.1
> > > sec 7.5.3.18, however, recommends determining supported Link Speeds
> > > using the Supported Link Speeds Vector in the Link Capabilities 2
> > > Register (when available).
> > > 
> > > Add pcie_bus_speeds into struct pci_bus which caches the Supported Link
> > > Speeds. The value is taken directly from the Supported Link Speeds
> > > Vector or synthetized from the Max Link Speed in the Link Capabilities
> > > Register when the Link Capabilities 2 Register is not available.
> > 
> > Remind me, what's the reason again to cache this and why is
> > max_bus_speed not sufficient?  Is the point that there may be
> > "gaps" in the supported link speeds, i.e. not every bit below
> > the maximum supported speed may be set?  And you need to skip
> > over those gaps when throttling to a lower speed?
> 
> FWIW I went and re-read the internal review I provided on May 18.
> Turns out I already mentioned back then that gaps aren't permitted:
> 
>  "Per PCIe r6.0.1 sec 8.2.1, the bitfield in the Link Capabilities 2
>   register is not permitted to contain gaps between maximum supported
>   speed and lowest possible speed (2.5 GT/s Gen1)."
> 
> 
> > Also, I note that pci_set_bus_speed() doesn't use LNKCAP2.
> 
> About that, I wrote in May:
> 
>  "Actually, scratch that.  pci_set_bus_speed() is fine.  Since it's only
>   interested in the *maximum* link speed, reading just LnkCap is correct.
>   LnkCap2 only needs to be read to determine if a certain speed is
>   *supported*.  E.g., even though 32 GT/s are supported, perhaps 16 GT/s
>   are not.
> 
>   It's rather pcie_get_speed_cap() which should be changed.  There's
>   no need for it to read LnkCap2.  The commit which introduced this,
>   6cf57be0f78e, was misguided and had to be fixed up with f1f90e254e46.
>   It could be simplified to just read LnkCap and return
>   pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS].  If the device is a
>   Root Port or Downstream Port, it doesn't even have to do that but
>   could return the cached value in subordinate->max_bus_speed.
>   If you add another attribute to struct pci_bus for the downstream
>   device's maximum speed, the maximum speed for Endpoints and Upstream
>   Ports could be returned directly as well from that attribute."

I know it's quite far back so it's understandable to forget :-), 
but already by May 23rd your position had changed and you wrote this:

'Per the Implementation Note at the end of PCIe r6.0.1 sec 7.5.3.18,

   "It is strongly encouraged that software primarily utilize the
    Supported Link Speeds Vector instead of the Max Link Speed field,
    so that software can determine the exact set of supported speeds on
    current and future hardware. This can avoid software being confused
    if a future specification defines Links that do not require support
    for all slower speeds."

This means that it's not sufficient if you just check that the desired 
speed is lower than the maximum.  Instead, you should check if the bit 
corresponding to the desired speed is set in the LnkCap2 register's 
Supported Link Speeds Vector.

PCIe r6.0.1 sec 8.2.1 stipulates that the bitfield is not permitted to 
contain gaps between maximum supported speed and lowest possible speed
(2.5 GT/s Gen1).  However the Implementation Note suggests that rule may 
no longer apply in future revisions of the PCIe Base Spec.'

So I'd assume I should still follow the way spec recommends, not the "old 
method" that may not function correctly after some future version of the 
spec, or have you really changed position once again on this?


-- 
 i.
--8323329-737575340-1704125951=:2521--


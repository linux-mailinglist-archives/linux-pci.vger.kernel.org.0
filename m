Return-Path: <linux-pci+bounces-19187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59845A000D2
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 22:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496F93A36EE
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 21:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD25B1B0F1A;
	Thu,  2 Jan 2025 21:39:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46413BC0C;
	Thu,  2 Jan 2025 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735853995; cv=none; b=g+DK/6ApI1l9tMdeiiD6IPz4GJs5fZ0zpxHDFpcqXkpu2Tj4GWDsS6htqYXGX8XavKxRwqKe6UEwcTdx0H2QZrEnbTo0Cf7GWa+jEAlV9ihaghRjTa4e+2lliemwq6rtBzc8FSbhBZnfoKTUG2TRrgCwYmL6P8HLpjBEFZ5kqFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735853995; c=relaxed/simple;
	bh=x8r8W9nOjGPFmJACK43eIlITuOvo5ra9svdTzJuNoMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLDVwNiSLAg2dCjV/AHKr5wdcK0XDEh7t6zrvl6Jvl9+Gz/FPZ06Ly2KYAD54VUu3+G4ncPIeUqqA+EI+gIdlwb/Qf/FHoniAWNRgC3vn4JF9tI13XL1gn9rHmK1bEbF0l1yHDtWklFKjfw5o1vGwToJjIku1fPcZTslIIxK4RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 181A23000A3A4;
	Thu,  2 Jan 2025 22:30:38 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 107DD59DC31; Thu,  2 Jan 2025 22:30:38 +0100 (CET)
Date: Thu, 2 Jan 2025 22:30:38 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Niklas Schnelle <niks@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Evert Vorster <evorster@gmail.com>
Subject: Re: [PATCH v9 6/9] PCI/bwctrl: Re-add BW notification portdrv as
 PCIe BW controller
Message-ID: <Z3cFfhHirAgxjmDQ@wunner.de>
References: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
 <20241018144755.7875-7-ilpo.jarvinen@linux.intel.com>
 <db8e457fcd155436449b035e8791a8241b0df400.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db8e457fcd155436449b035e8791a8241b0df400.camel@kernel.org>

[cc += Evert]

On Fri, Dec 06, 2024 at 07:12:37PM +0100, Niklas Schnelle wrote:
> On Fri, 2024-10-18 at 17:47 +0300, Ilpo Järvinen wrote:
> > This mostly reverts the commit b4c7d2076b4e ("PCI/LINK: Remove
> > bandwidth notification"). An upcoming commit extends this driver
> > building PCIe bandwidth controller on top of it.
> > 
> > The PCIe bandwidth notification were first added in the commit
> > e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth
> > notification") but later had to be removed. The significant changes
> > compared with the old bandwidth notification driver include:
[...]
> I bisected a v6.13-rc1 boot hang on my personal workstation to this
> patch. Sadly I don't have much details like a panic or so because the
> boot hangs before any kernel messages, or at least they're not visible
> long enough to see. I haven't yet looked into the code as I wanted to
> raise awareness first. Since the commit doesn't revert cleanly on
> v6.13-rc1 I also haven't tried that yet.

Hi Niklas,

another regression caused by bandwidth control was reported,
this time it's a hang on shutdown (instead of on boot) and
this time we root-caused it instead of just working around it.

Here's the proposed fix:
https://lore.kernel.org/r/0ee5faf5395cad8d29fb66e1ec444c8d882a4201.1735852688.git.lukas@wunner.de/

Could you test this on top of v6.13-rc1 (or any other rc which
does not include 774c71c52aa4 ("PCI/bwctrl: Enable only if more
than one speed is supported")?

I suspect that it may fix the issue you were seeing as well and
I'm curious whether that suspicion is correct.

Thanks!

Lukas


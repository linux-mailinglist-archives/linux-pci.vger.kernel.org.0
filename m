Return-Path: <linux-pci+bounces-16697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B489C7DDB
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5481F22F06
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF48018C02B;
	Wed, 13 Nov 2024 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+5Xe0KE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B258F18C019;
	Wed, 13 Nov 2024 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731534532; cv=none; b=rEv+Kzausue0upqVTOquJ8ge0wYo8SuRZn6lQP1NxV5Z37bbN0SmLT7WQ43OgZjujbQiU4N0KcRLtdHwkhNHIdqLFDNLYefLIpQNK8+OxP6m5gnQXlDDPjE3HmXKT7ULChbzo8n5OcBUl1aJTWnv2sNz16kxNliMtaqWT4XMXhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731534532; c=relaxed/simple;
	bh=SzEvzERxpqaF4qURYLvjSUAk4bsgnytILLb9yuMYj78=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KjOTnfPNGnnWC77Wm5gcxdOUdJtCx5GquA6f4u4qSI6CidtraxK1X1MZhetdOIgKAqWz820fs1nvHRztxfxCKVC+fY4Y7uNI6dpXHaWaf52CbXqc5w6M/POsrX60juENN9Svf15RomMpF+JNDrqYfD5afFlW1YvU2pGsR6Jx8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+5Xe0KE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A69C4CEC3;
	Wed, 13 Nov 2024 21:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731534532;
	bh=SzEvzERxpqaF4qURYLvjSUAk4bsgnytILLb9yuMYj78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=m+5Xe0KEXDudiczDXkLy3se2djXe7GDdcd+ojwOdT4DwCQ0wBQHQJmh6dJqztCnh7
	 5aTdm/bb/3kOJRPeSP3vdqAx5N9bCApM+0WJCjush/Zc3ulXlydDl4hOlBvKk6UQJc
	 Fz778BsNoQthFkC0BRQzhxt9M29NEx8zRlbVBeAhqUsQY5utcQD86tKzzHedMntuHc
	 7IYcdnDAMINbgOHSOaTydwrQh0le0I5d8Ox7fBHRVbLGzvFzOHrJYX+LxbuMrlIYmg
	 gb2V5KA7C1smhxzI9Kx/AmIRT0RXaU7UeCblgcSWBQm2eDbV3YaDpYA19Jsz6DA/wA
	 TdLavZAEmPgOg==
Date: Wed, 13 Nov 2024 15:48:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v9 0/9] PCI: Add PCIe bandwidth controller
Message-ID: <20241113214850.GA1912974@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241023221904.GA941054@bhelgaas>

[+cc Bart, Amit, Neil, Caleb]

On Wed, Oct 23, 2024 at 05:19:04PM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 18, 2024 at 05:47:46PM +0300, Ilpo Järvinen wrote:
> > This series adds PCIe bandwidth controller (bwctrl) and associated PCIe
> > cooling driver to the thermal core side for limiting PCIe Link Speed
> > due to thermal reasons. PCIe bandwidth controller is a PCI express bus
> > port service driver. A cooling device is created for each port the
> > service driver finds to support changing speeds.

> >  drivers/pci/pcie/bwctrl.c                     | 366 ++++++++++++++++++
> >  include/linux/pci-bwctrl.h                    |  28 ++
> >  tools/testing/selftests/pcie_bwctrl/Makefile  |   2 +
> >  .../pcie_bwctrl/set_pcie_cooling_state.sh     | 122 ++++++
> >  .../selftests/pcie_bwctrl/set_pcie_speed.sh   |  67 ++++

> Applied to pci/bwctrl for v6.13, thanks Ilpo (and Alexandru, for the
> bandwidth notification interrupt support)!

How attached are we to "bwctrl" and "pwrctl" as the names?

I just noticed that we have "ctrl" for bandwidth control but "ctl" for
power control, which is slightly annoying to keep straight.

"ctrl" is more common in the tree:

  $ find -name \*ctrl\*[ch] | wc -l
  691
  $ find -name \*ctl\*[ch] | wc -l
  291

so I would prefer that, although "pwrctl" is already in the tree (as
of v6.11), so it would be more disruptive to change it than to rename
"bwctrl".


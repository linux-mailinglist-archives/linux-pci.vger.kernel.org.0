Return-Path: <linux-pci+bounces-44497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BDCD127C0
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 13:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEAA23040D3A
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 12:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35303570AE;
	Mon, 12 Jan 2026 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tihHO1Gn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD7715665C;
	Mon, 12 Jan 2026 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220017; cv=none; b=cThccUWRBhG2mmqMwxYx+bndhRMxhiqVeBlwSV4XYDpssu5z2hMj6S7cEFQz9bG8VAdXIxV3HTb/+E0kPNHN5l1YKBrp9uLpiCuW8X8PzRsyaN+Qv6AzByhadXLLa0B/MeLBRWKYeFd05SQ/ayUzMB51vDizuVQLs5lGZOYSAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220017; c=relaxed/simple;
	bh=RuHDtGL00SnpZqV0qXNelW6J171aN3M0JIvYYprsUe4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LonIgpT+Nz9t63rqtdpylQhCasqpJV23u/WobVBspf0pqbIe9IEfPG67t4h+D1ZfNZZTc7x8C8WLBzoImSX4LTWvo1ES6I+RvOqazW509hG2ixB0p1+OjOqYkguk2BZPYHz9pEvLIYrPgQImaA5NMZImL5NnLECfZPWZbKrcKk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tihHO1Gn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAF7C16AAE;
	Mon, 12 Jan 2026 12:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768220017;
	bh=RuHDtGL00SnpZqV0qXNelW6J171aN3M0JIvYYprsUe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tihHO1GnLWfY9wTo0UJsTeEZG5Im8Hy7bZW9ZSc1XOA+8ypp8wVtpSWnjwewMpslK
	 tzDnQAFBnNSvNtEYN4SXoWEUPhsI/gQmZVTlodE1heW8SU5Y0Z6VdBo3Kj9TMAFC8R
	 hk0mU9eJwRijZcYP5/jk1SphGXW8LEIykh/3uF9bFhv52VkeBCn+HRQYRYqoXFpnin
	 a7KNXq23lNjbKjAJ0ZNbrWKh6lKk/iqOBGysDnDZKrNy9RWv5aOnBEgIFDAo38zfAv
	 Rxe06/PPcx9WXvt0fWG7TKk7u8kO905YNM9xpft30CxeFAC1g4jRbxxQ/l3ph6mTGC
	 xUQJHWg7xQ9uQ==
Date: Mon, 12 Jan 2026 06:13:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 0/8] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
Message-ID: <20260112121335.GA707347@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <smxp3g5pveepvub3j2p7kvftnaza5ptuehmlvanhdamt46ugrb@hszfopsdzkgz>

On Mon, Jan 12, 2026 at 01:23:02PM +0530, Manivannan Sadhasivam wrote:
> On Sun, Jan 11, 2026 at 09:31:32PM -0600, Bjorn Helgaas wrote:
> > On Mon, Jan 05, 2026 at 07:25:40PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > Hi,
> > > 
> > > This series provides a major rework for the PCI power control (pwrctrl)
> > > framework to enable the pwrctrl devices to be controlled by the PCI controller
> > > drivers.
> > 
> > I pushed a pci/pwrctrl-v5 that incorporates some of the comments I
> > sent.  If it's useful, you can use it as a basis for a v6; if not,
> > no worries.
> > 
> 
> Thanks for making the changes, they look good to me. Do you expect
> me to send v6 or you intend to merge this pwrctrl-v5 branch to
> pci/next?

I'm not planning to merge pwrctrl-v5 yet.

Still hoping pci_pwrctrl_slot_power_on() could be factored out earlier
to simplify "PCI/pwrctrl: Add 'struct pci_pwrctrl::power_{on/off}'
callbacks".  It wasn't quite obvious to me how to do that.


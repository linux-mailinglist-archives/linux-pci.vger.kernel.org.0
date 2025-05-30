Return-Path: <linux-pci+bounces-28726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1ABAC94A0
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 19:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97BCC1C20A39
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B6A2367CA;
	Fri, 30 May 2025 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBXBtw7h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921542367B7
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748625579; cv=none; b=BzXelAEyXGE+VeavYRmgfHe9Ia5ax5+ESutq0YyTcVWoo4Qhl5YSr4AbaTJvY4WDlNiSLKuLB5ZjTKUvkTsZ2MP9tr+3leSXVpbjqikYXmAIvTyllEoPw0+TsiYu3TuhoFUDepwqnWkZN/6gowiLBeIqR7nyrf1oC4quDvTllIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748625579; c=relaxed/simple;
	bh=r75gyDrLGguzONHF8H73EFamx8iEhr+JOYtKKCo4xv8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QxidxcZJeF4fyqKyCGmWvTF+Kn4ua1Gs1uho7ucMI1/KWXTiZSxpdF+aHhNAyd8Nw/zXBIuoH6Z44Y0fyGnJl4hCK6YDOhUoQE9F5KUm6uS4jkR87tTgOy16RMUxAv8wqP4ubYVNfT2LK535tX/Q5/NDYRSaYgGJvRG7yA6Edl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBXBtw7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C713BC4CEE9;
	Fri, 30 May 2025 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748625579;
	bh=r75gyDrLGguzONHF8H73EFamx8iEhr+JOYtKKCo4xv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aBXBtw7hPt5+MiQPWv6+6d/vPcbxlur8A9dvcQsNL1iOU8Z5M8CNWOZhKNYKj/QWv
	 SlgXOWD1Q3pcSYl2PcyR3ZvNrdrWFGuFyeZYBXFFKuXDn/xIGFo3elxaFJgiZOfdHu
	 4y4DcCjdio6aDA2qbFQPz+t0drZhicR7ldwnNouwxEc0XCr4DacokmvfJtxklQr53t
	 vVxnVbbTOhq0lh6+y+KZ43rCs4J4ykIPfdCqy+FYI3jl1CAYNiI1hJqomtBmIr57In
	 9BtyJQX3YzScR0CqjMR4rb6Rm7SDS1lRwJ1RYOSOW6XfvPa2ZFk0HLNTYVsKzF8rr7
	 x0Bm/xt/NSzvw==
Date: Fri, 30 May 2025 12:19:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <20250530171937.GA198252@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbvatgydh64wr2z2srivbuurjonxpq46xie3bq57grtosesfti@v6vplhyxc343>

On Fri, May 30, 2025 at 09:29:57PM +0530, Manivannan Sadhasivam wrote:
> On Wed, May 28, 2025 at 05:42:51PM -0500, Bjorn Helgaas wrote:
> > On Tue, May 06, 2025 at 09:39:36AM +0200, Niklas Cassel wrote:
> > > Commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can
> > > detect Link Up") changed so that we no longer call dw_pcie_wait_for_link(),
> > > and instead enumerate the bus when receiving a Link Up IRQ.
> > > 
> > > Laszlo Fiat reported (off-list) that his PLEXTOR PX-256M8PeGN NVMe SSD is
> > > no longer functional, and simply reverting commit ec9fd499b9c6 ("PCI:
> > > dw-rockchip: Don't wait for link since we can detect Link Up") makes his
> > > SSD functional again.
> > > 
> > > It seems that we are enumerating the bus before the endpoint is ready.
> > > Adding a msleep(PCIE_T_RRS_READY_MS) before enumerating the bus in the
> > > threaded IRQ handler makes the SSD functional once again.
> > 
> > This sounds like a problem that could happen with any controller, not
> > just dw-rockchip?  Are we missing some required delay that should be
> > in generic code?  Or is this a PLEXTOR defect that everybody has to
> > pay the price for?
> > 
> > Delays like this are really hard to get rid of once we add them, so
> > I'm a little bit cautious.
> 
> Ok, I digged into the spec a little more and I could see below
> paragraph in r6.0, sec 6.6.1 for devices not supporting Device
> Readiness Status (DRS):
> 
> "With a Downstream Port that does not support Link speeds greater
> than 5.0 GT/s, software must wait a minimum of 100 ms following exit
> from a Conventional Reset before sending a Configuration Request to
> the device immediately below that Port.
> 
> With a Downstream Port that supports Link speeds greater than 5.0
> GT/s, software must wait a minimum of 100 ms after Link training
> completes before sending a Configuration Request to the device
> immediately below that Port.  Software can determine when Link
> training completes by polling the Data Link Layer Link Active bit or
> by setting up an associated interrupt (see § Section 6.7.3.3 ). It
> is strongly recommended for software to use this mechanism whenever
> the Downstream Port supports it."
> 
> We are not checking for DRS after the PERST# deassert or after link
> is up, I think DRS check only applies to enumerated devices, but I'm
> not 100% sure. But if we assume that the devices doesn't support
> DRS, then we should make sure that all controller drivers wait for
> 100ms even after link up event before issuing the config request.

I don't think we have any DRS support yet.

I think all drivers should wait PCIE_T_RRS_READY_MS (100ms) after exit
from Conventional Reset (if port only supports <= 5.0 GT/s) or after
link training completes (if port supports > 5.0 GT/s).

> So I don't think this is a device specific issue but rather
> controller specific.  And this makes the Qcom patch that I dropped a
> valid one (ofc with change in description).

URL?

Bjorn


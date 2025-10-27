Return-Path: <linux-pci+bounces-39414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE99C0CE0B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 11:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A35884E6CDD
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BF326F29C;
	Mon, 27 Oct 2025 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cX+PXi9/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478D023EAB9;
	Mon, 27 Oct 2025 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559669; cv=none; b=hKsexPFCGMfPSGBaUOrpA5312g1dyxf0D7mLTXRF8Nd67Yhaas9PkzPs7WwXkFCWyHqN5UFTAPzeY00uJIndXqpRjMbNNs2KQGvxx8Hn0wvM8WyfLZi/16QN6vTwdva0DvwLHZ3oXflvSswHe0AXIBMW34bIVbcMze4gB9J65dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559669; c=relaxed/simple;
	bh=gYH15C0Zx3xImMUg00MAivmQVJErsxHFY89b2ystD7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE3FriCOKoYxuHQOYXOkbxu9nC9mlsErX1UwHqCSNTr/WhUh8RVPKhVWnIFVXIWi8ZABDF9hpYkPYHct7UHCqgcyqlwZ03+uYkZVPIZXYUQNkRfzTJIUZu9mFMtR7d32nRJGAm7iCrVmOMYNt/DhMj5wplbiaCvA1qfgMrzvVpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cX+PXi9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5675C4CEF1;
	Mon, 27 Oct 2025 10:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761559668;
	bh=gYH15C0Zx3xImMUg00MAivmQVJErsxHFY89b2ystD7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cX+PXi9/8m1/+zRXnI4SGanJoiQTLozQT7QNvV+sOaNOo1/NXBrK9++7PqqprT2nQ
	 qaoSJYkdZdf1v9WM9+SstKga4E2/LyJ+UO4dNNqpBONKc0E8aBfneM58niYtzE+0mj
	 NwTxaj22tH/bx5Km47rCI0mJC1Bvo9mswORntpZPWBQZKfdW/H7EH318rFuWvRVtkB
	 UbFMqGVrOftWv/gof1OpHIo8cGptU56/dTySfYwMX6NE/CTXqJYugNqwGrFsNJqofr
	 W/9A3QNg/KqkH4qP3glxaME1FrAeabbT1kRdEIj2hkVt0yJ9GwD0ADyKYQ011T+byP
	 dwVPpm82nFVwA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vDK8l-000000006fl-2vmW;
	Mon, 27 Oct 2025 11:07:51 +0100
Date: Mon, 27 Oct 2025 11:07:51 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Frank Li <Frank.li@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>,
	Rob Herring <robh@kernel.org>,
	"David E . Box" <david.e.box@linux.intel.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Han Jingoo <jingoohan1@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Revert "PCI: qcom: Remove custom ASPM enablement code"
Message-ID: <aP9Ed1Y1lcayFn7Q@hovoldconsulting.com>
References: <rc4ydm2c3c4gqipaorr2ndrlwufay3ocfc2rq7llskkg7npe6x@53eztxy5v3gt>
 <20251026193754.GA1432729@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026193754.GA1432729@bhelgaas>

On Sun, Oct 26, 2025 at 02:37:54PM -0500, Bjorn Helgaas wrote:
> On Sun, Oct 26, 2025 at 08:58:29PM +0530, Manivannan Sadhasivam wrote:

> As far as I know, it's L1SS that has catastrophic effects.  I haven't
> seen anything for L0s or L1.

Enabling L0s unconditionally certainly blew up on some Qualcomm
machines. See commit d1997c987814 ("PCI: qcom: Disable ASPM L0s for
sc8280xp, sa8540p and sa8295p").

Johan


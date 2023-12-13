Return-Path: <linux-pci+bounces-913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A24811F95
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 20:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0298E281A1F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 19:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434457E542;
	Wed, 13 Dec 2023 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYft67vo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209625FF18;
	Wed, 13 Dec 2023 19:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650E4C433C8;
	Wed, 13 Dec 2023 19:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702497589;
	bh=n4y6guQRV12k+liN2WHD+wd3QSw9JETlMI+NEhFXEvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YYft67voJWxpBtLm5xqPzprpXz2B1yCo7ZrhnnWakz/NJaoH0i821cOvZiF4YISQq
	 0Q5We9nWveoWSKZ1Ls+/RwyeFWXqWP1oXDrohPmOejUE68ozgge5vUbTZ//8Wo7Kig
	 SztMPmEXg5mIRfwuf/IBtYuhHER0buqy5Pq+PVEPLpZ9ajKkyMG/i9hzW5inTtGP3H
	 VbTJ6Dm5zDFrcl03Ovd1h/frFO+I7g4CpBLSzIhYmQBA0N4ApyTAa15Id3QHyPMiFR
	 GxGz4Mlxhi1xmwmBRpZwWPPQUIRKqOufiLnSAFjQ+dB6/49i1AvZalL+ShevNK+yTW
	 ZoXcLjK3/VSZA==
Date: Wed, 13 Dec 2023 13:59:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Cyril Brulebois <kibi@debian.org>,
	Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Phil Elwell <phil@raspberrypi.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Jim Quinlan <jim2101024@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 0/2] PCI: brcmstb: Configure appropriate HW CLKREQ#
 mode
Message-ID: <20231213195947.GA1056194@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae49227b-5026-43a4-8e19-aeeb63865a6a@broadcom.com>

On Tue, Dec 12, 2023 at 03:51:12PM -0800, Florian Fainelli wrote:
> On 11/26/23 12:19, Cyril Brulebois wrote:
> > Hi Jim,
> > 
> > Jim Quinlan <james.quinlan@broadcom.com> (2023-11-13):
> > > V8 -- Un-advertise L1SS capability when in "no-l1ss" mode (Bjorn)
> > >     -- Squashed last two commits of v7 (Bjorn)
> > >     -- Fix DT binding description text wrapping (Bjorn)
> > >     -- Fix incorrect Spec reference (Bjorn)
> > >           s/PCIe Spec/PCIe Express Mini CEM 2.1 specification/
> > >     -- Text substitutions (Bjorn)
> > >           s/WRT/With respect to/
> > >           s/Tclron/T_CLRon/
> > > 
> > > v7 -- Manivannan Sadhasivam suggested (a) making the property look like a
> > >        network phy-mode and (b) keeping the code simple (not counting clkreq
> > >        signal appearances, un-advertising capabilites, etc).  This is
> > >        what I have done.  The property is now "brcm,clkreq-mode" and
> > >        the values may be one of "safe", "default", and "no-l1ss".  The
> > >        default setting is to employ the most capable power savings mode.
> > 
> > Still:
> > 
> > Tested-by: Cyril Brulebois <cyril@debamax.com>
> 
> Thanks Cyril! Bjorn, Lorenzo, any chance this can be applied soon? Thanks!

Seems OK to me if Lorenzo or Krzysztof W. are OK with it.


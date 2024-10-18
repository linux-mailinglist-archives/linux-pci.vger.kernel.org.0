Return-Path: <linux-pci+bounces-14888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C27C89A4A16
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 01:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57E24B2185E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 23:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117FE18C938;
	Fri, 18 Oct 2024 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQoZSC5Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF50314F9D9;
	Fri, 18 Oct 2024 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729294264; cv=none; b=DntaMl485P3DdDWgMAt+1ij/NCGAdZtANK+lqAkk/FcabxIr0/8NZjlRgAm+bbnxOYCkeLtMSDWlTXiaTbQSmih+ACz1WGDcjSWw+79lt3pYNs0DZNGOyztTQRIcVYl/Zw58HzbI42KUrmi1qiw4Jcyyme9Nel5uCA2uGbptEkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729294264; c=relaxed/simple;
	bh=0c1uwez6hOT+dNwlWPtjBKASFttyCohhN5DW6r850zU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uxuxjCg+XJHDp54OGGNijWN0yijsnw0alkZqHQ0E7ySLWqNvQDSMn3508z9xS/yRYIsCoicxFtOBbAujBo75c5ManLx3K9H1C5GVr8mVvNNGbJMGN/N5HGMC9EUR+Pl24KjSvlBX61ZaKL+WewCg8zd/w8DJb9Jq0E+GegZ8de4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQoZSC5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFBDC4CEC3;
	Fri, 18 Oct 2024 23:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729294263;
	bh=0c1uwez6hOT+dNwlWPtjBKASFttyCohhN5DW6r850zU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PQoZSC5ZpMUk0IexHBKuJKJsUwLGwE2NWMA146OlcwDNQbQz1Hv3eCrovdbGDq2UC
	 X3GCddARrNgFrc3t+A6q3keB9WcR3fC2dd9EBUe4HTg7iXeVwD740AkklLzmpe8+LC
	 km6yj/Ey4vyBNuEUDHN1pRm/w713wzPPoGXXCIvDnSOlHnboOnhoGgkCvfRh+HPAAA
	 LAkY5U+XfEr8MBLnqYp2fviSHdAPiZdvJHyvP/kEG2xpY3YD/1fDtcD5DuHmrEw1Oq
	 NaKuB0kbTYVB50670og89LCvR6eRohIpjgdw+uEXXq0dN6lNJ8SL+14Fuv4j+sZuYM
	 RI1tEIB9XCsIw==
Date: Fri, 18 Oct 2024 18:31:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: Jim Quinlan <jim2101024@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>
Subject: Re: [PATCH v3 04/11] PCI: brcmstb: Expand inbound size calculation
 helper
Message-ID: <20241018233101.GA769193@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27c18374-8120-40bd-87d2-183c40945fbf@suse.de>

On Thu, Oct 17, 2024 at 11:02:33AM +0300, Stanimir Varbanov wrote:
> On 10/16/24 22:38, Bjorn Helgaas wrote:
> > On Wed, Oct 16, 2024 at 01:09:00PM -0400, Jim Quinlan wrote:
> >> On Mon, Oct 14, 2024 at 1:25 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>> On Mon, Oct 14, 2024 at 10:10:11AM -0700, Florian Fainelli wrote:
> >>>> On 10/14/24 09:57, Bjorn Helgaas wrote:
> >>>>> On Mon, Oct 14, 2024 at 04:07:03PM +0300, Stanimir Varbanov wrote:
> >>>>>> BCM2712 memory map can supports up to 64GB of system
> >>>>>> memory, thus expand the inbound size calculation in
> >>>>>> helper function up to 64GB.
> >>>>>
> >>>>> The fact that the calculation is done in a helper isn't important
> >>>>> here.  Can you make the subject line say something about supporting
> >>>>> DMA for up to 64GB of system memory?
> >>>>>
> >>>>> This is being done specifically for BCM2712, but I assume it's safe
> >>>>> for *all* brcmstb devices, right?
> >>>>
> >>>> It is safe in the sense that all brcmstb devices with this PCIe
> >>>> controller will adopt the same encoding of the size, all of the
> >>>> currently supported brcmstb devices have a variety of
> >>>> limitations when it comes to the amount of addressable DRAM
> >>>> however. Typically we have a hard limit at 4GB of DRAM per
> >>>> memory controller, some devices can do 2GB x3, 4GB x2, or 4GB
> >>>> x1.
> >>>>
> >>>> Does that answer your question?
> >>>
> >>> I'd like something in the commit log to the effect that while
> >>> we're doing this to support more system memory on BCM2712, this
> >>> change is safe for other SoCs that don't support as much system
> >>> memory.
> >>
> >> This setting configures the size of an RC's inbound window to system
> >> memory.  Any inbound access outside of all of the inbound windows
> >> will be discarded.
> >>
> >> Some existing SoCs cannot support the 64GB size.  Configuring such
> >> an SoC to 64GB will effectively disable the entire window.
> > 
> > So I *think* you're saying that this patch will break existing SoCs
> > that don't support the 64GB size, right?
> 
> Existing SoCs will not be impacted. It could be theoretically possible
> to break inbound window translations only if you wrongly populate window
> sizes in DT.

I guess this is the part that I missed -- the inbound window sizes
come from DT (via bridge->dma_ranges, IIUC), and the patch merely
supports encoding of larger windows than previously.

Bjorn


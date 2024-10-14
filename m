Return-Path: <linux-pci+bounces-14490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD5499D536
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 19:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF6A5B21FE2
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A8D1C1AD8;
	Mon, 14 Oct 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liodWHvA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749AA1C0DE2;
	Mon, 14 Oct 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925386; cv=none; b=KYNsQ6MjxVS2ndj2c99SkShY9tA7ByClLt5EoE438mcY0m8pu0ZnKtKzHliVgoDz2/0YT+oNbumAttEx0IvztMkkueumWhmon1teHkjKT6T6PUVwaGTheryPnT+5UeshEY6UyRC9KFwvMt/Ahb3pyZq7rs/rBmS7kP3tYjriX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925386; c=relaxed/simple;
	bh=7EBzx9TKWhfNLZhoOLG6+HPFV0q3qnPTqrLIobCq0yk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pmlOaqFIa/cG77gUKAEwdlWu8CmEaAIuz2lCUOKrIoOz1sXYq1qvmClaC8MEOrmx9Syi3FG6JSUWUO2XCjh7kcIgBiPkZiZJC55nDcPYpijUZGil9f5Z8A/HbhZdIrxiDt1uuvaBplwnCacNM+vmYe/nkDQq1gjy3Wv2zSC73o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liodWHvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB77C4CECF;
	Mon, 14 Oct 2024 17:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728925386;
	bh=7EBzx9TKWhfNLZhoOLG6+HPFV0q3qnPTqrLIobCq0yk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=liodWHvAXSwdRZ24OJzo6b6dLba0jDpqemmMj8zSUmIq9dn7iIj8+tA5c+NR4vtps
	 lswpBORi48/kw9Bq0kYm+Jy4P4x2h6u0FoWoxesxIe/ylqM+s0Oryy5HSoYy4T/D12
	 GU8UAryRP7jazy4N4TIJv9IKn7EzsKbbwkHqsc6rwuIAwlqxto0MicNd8GGrg3oGpA
	 dTlN1IWPy/GG0ZHiiUnj9JGrcfhO2/TAJhrOAK/ZqUcPPIGLPK0d4Om/Jom/m+sz9K
	 8/KRYAKSnh3nAdOc+yOIVZMQw5woos+TmB0LBTOLN948+VKJhJHmPCMNbt13R8cQMd
	 Qnwe3bP0pa5SA==
Date: Mon, 14 Oct 2024 12:03:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>
Subject: Re: [PATCH v3 08/11] PCI: brcmstb: Reuse config structure
Message-ID: <20241014170303.GA611791@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014130710.413-9-svarbanov@suse.de>

On Mon, Oct 14, 2024 at 04:07:07PM +0300, Stanimir Varbanov wrote:
> Instead of copying fields from pcie_cfg_data structure to
> brcm_pcie reference it directly.

This seems good.  I would consider moving it earlier in the series
so you don't have to touch the CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN stuff
twice.

Bjorn


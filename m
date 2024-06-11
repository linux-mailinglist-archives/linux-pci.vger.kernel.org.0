Return-Path: <linux-pci+bounces-8600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8426290422B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 19:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 043BDB245C1
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 17:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095D443AAE;
	Tue, 11 Jun 2024 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrKsbTQu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9311D556;
	Tue, 11 Jun 2024 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125856; cv=none; b=UFPCflXEi4dFFABun9kl+QQU5EJisJ46bSqK49GaAIK691Fb2cRdP5vEWbNIGYznzNuoVuQn8P9gGQDFPhYRhQbLiA4dMwaAzoFRvkziUubqVkqQTVPLD4GAvjJptCEykMFJ3+gBUuBg/9jHbOxfIrxol2y0KcBzx5reIfre3P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125856; c=relaxed/simple;
	bh=gFYHyJOp+GLvLO8caFrC+bAJxiiQYs3SDuhR95Pp0qo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mc9JQ2KWoJEfQeC+nYGulwXzZhAlfhXkCHxOhPbLjBXsDN5YhM5qzlWrqex2jJi/O5R7/QrHYYPiwU6qGNe69EWAiYgSwXlSjruZWKbUfi+507gxXVxD/YqE/KOYDNU920BCJ+bul/EU+z3/WHSZTrFhxZd/51gyT+JMGWrPyFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrKsbTQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9CBC2BD10;
	Tue, 11 Jun 2024 17:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718125856;
	bh=gFYHyJOp+GLvLO8caFrC+bAJxiiQYs3SDuhR95Pp0qo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rrKsbTQu+g8sy3y1sNoL/1cLUJzwsI+jSnaeJF/MUDr9qBxDOXI6yVew9zke6UlYs
	 Niwyn9lfbTuT9Cr+QujfSQQaieXHLWYZh8rj7ssbarEupC2Bv9YsZPcMBG8kEBJPd/
	 rkjLST5yzg4X8QJWMXnjfCELmLrrgbuPsFerKYAYDP2FBD5vq9FJW4/rSVDGwLTN6x
	 QzCcItvo6D4CYccoG8wXEpusNaq9STs0AOH6kH5KHTJm/5rmKxbH9ZN6UYu9MuQcMJ
	 URp2sqtJbHh5fD7Xt5Ks4nOMQ7g3u4aGSYpsXvt5xO+iMbHTGBJDxXbI6vifW1gyAI
	 U/Slc4E54/X0g==
Date: Tue, 11 Jun 2024 12:10:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: conor@kernel.org, Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 2/2] PCI: microchip: rework reg region handing
Message-ID: <20240611171054.GA989979@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-flint-whacky-4fb21c38476b@wendy>

On Mon, May 27, 2024 at 10:37:17AM +0100, Conor Dooley wrote:
> The PCI host controller on PolarFire SoC has multiple "instances", each
> with their own bridge and ctrl address spaces. The original binding has
> an "apb" register region, and it is expected to be set to the base
> address of the host controllers register space. Defines in the driver
> were used to compute the addresses of the bridge and ctrl address ranges
> corresponding to instance1. Some customers want to use instance0 however
> and that requires changing the defines in the driver, which is clearly
> not a portable solution.
> 
> The binding has been changed from a single register region to a pair,
> corresponding to the bridge and ctrl regions respectively, so modify the
> driver to read these regions directly from the devicetree rather than
> compute them from the base address of the abp region.
> 
> To maintain backwards compatibility with the existing binding, the
> driver retains code to handle the "abp" reg and computes the base
> address of the bridge and ctrl regions using the defines if it is
> present. reg-names has always been a required property, so this is
> safe to do.

When you update this, can you add something about the objective to the
subject line?  "rework reg region handling" just says "we did
something", but not why or what the benefit is.

The cover letter ("support using either instance 1 or 2") has good
information that could be part of this.

Bjorn


Return-Path: <linux-pci+bounces-37809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48306BCD88D
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 16:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEB584E9256
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 14:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44682367B0;
	Fri, 10 Oct 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0DM+ICi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EAD1DE8A4;
	Fri, 10 Oct 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106741; cv=none; b=HQE1BrxukQFcKu1m/5QpxtqEwW+mnTTEtv4mnlCNRG9+AYais6F81gOH6P1XroI1GnuNGtueZD+wal/DPU7iA7whR4aTtuGSpOoGeZ5Dg9e7uuaznw/5gLfjuoqivojoKibumZm8qG1Jp4H38cmm0kjba54KxY4pqY7TwmlxvAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106741; c=relaxed/simple;
	bh=Y13MZLSFH0Wu9ldSZ+acLNvddtlrHdyWJ1rhQK7RQ6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM/JMnRAWIlAuUrUUJCAYCJKe2rYgfVJwuQQ4OeawvYrv5m2XsYAFaT9PuNwCSVaqnktRFBInWZi8WMRX0IqFWeDx7b2LgX7vpDF5EdBLBHdzU8NQ6Et1/SFMik2CLncRD4t8xuSEZafwhcEEZYxCbxNaV120luE/eNsYRY+zDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0DM+ICi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52057C4CEF1;
	Fri, 10 Oct 2025 14:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760106741;
	bh=Y13MZLSFH0Wu9ldSZ+acLNvddtlrHdyWJ1rhQK7RQ6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K0DM+ICir0i7Q2RAddxiar9C1/wPPoy+vlk/h9Y4rlov2EXexkpvpkfdWzZkbsl0H
	 SYclKJTzLys6HmkeArSuiRrYlL/3AxDha0Epirp2i9kof7u57OttYN14foOe+xb3p8
	 0q8ibH95OrzKRRX+ffcSIeZB0yMrYyj3wOJEb1BELpU4N87plVZIOz1aspcv7bLdPX
	 7ZjugNKFVTC8MjrjDzZM16hBiH3KEGQ7lgQhXnbqxGe2+lxFZEZvi4GtHMli2sLIM5
	 f44y/xXonYOLkNN8RuARkh2DyeI4BoaS0+Oa95dcp8eg/fGkaXYRL0Gpu5bEq7MQQP
	 Qui8oxOOOCjmA==
Date: Fri, 10 Oct 2025 09:32:19 -0500
From: Rob Herring <robh@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add
 documentation for the PCIe IP on Renesas RZ/G3S
Message-ID: <20251010143219.GB242024-robh@kernel.org>
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
 <20251007133657.390523-2-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007133657.390523-2-claudiu.beznea.uj@bp.renesas.com>

On Tue, Oct 07, 2025 at 04:36:52PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The PCIe IP available on the Renesas RZ/G3S complies with the PCI Express
> Base Specification 4.0. It is designed for root complex applications and
> features a single-lane (x1) implementation. Add documentation for it.

Also, for the subject, "Add Renesas RZ/G3S" is sufficient. We already 
know it is for PCI and is documentation.

Rob


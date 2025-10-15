Return-Path: <linux-pci+bounces-38245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F96DBDFB60
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 18:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8A319A7F8F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 16:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95BC33A011;
	Wed, 15 Oct 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjBFrI6F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95AF299AAF;
	Wed, 15 Oct 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546517; cv=none; b=cFC9Rq2Iag1mBaZ/+ey+pYszxQu/vD/7HLULCz2r2KZFEvqzQJivHacUQUBf5fvcYV/5zazJNyss45+079KRFlUOriaRrLHpWeObP85p4GCTrGRGd0tl8m3UCNoGut6D/SXBjtNC229rUs6YWSGvFnVnNRl4gbVMzciZigERCTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546517; c=relaxed/simple;
	bh=9K61xwRqqf8ENXqYLk5+Ql/HCKvMYhIsjWS3UR1LAJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdZC4Rjmt9D9WZUwt5GYMrKTGXKStRKf595d8mqCz4+eJrZNFutaMLNfpE01C3t4scwgZ+Ufuhtxgue7LSmYp/0p0YZTHJTzMfkB8kZgs9ONXp4yLmM8XnjnMdvZJfsEUTFUoT6QsffHg9Yo9Ax7egeFWcnNYikoO+rlP9r34nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjBFrI6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139FDC4CEF8;
	Wed, 15 Oct 2025 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760546517;
	bh=9K61xwRqqf8ENXqYLk5+Ql/HCKvMYhIsjWS3UR1LAJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AjBFrI6F5Vkk+AEmnLeRu9FXSyTmTlJ4lmgOUVAziqVPGaJn60saM3QaDV8VSGgJb
	 DUcJIYdpCj+RAEQgV/qsyUWH/HmwHpBfeYlrZW5fJ0ZfrpIu/SG1rcxxeN9Q8+yS+g
	 ygfrzqS5lt4XPm4jlXExzO2pQ6VIKlym6Gmd+RoViEevqE43vQuqyJ5tt8vjhZYhoe
	 nKZoxUeiB4y0BKn2AJLqWsLi5vGv/b2LTog/BbKVYFi2yhP+/2QNXOnfZ+fGBis4Zl
	 fl2QZMvo/3kwhBxHhlfhcqPqbSTeJi3CJrc3cDd14ZcKFs6HotuiW3PNfL3cQTlMmX
	 frC4tr4OJrw9g==
Date: Wed, 15 Oct 2025 11:41:55 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: guodong@riscstar.com, bhelgaas@google.com, christian.bruel@foss.st.com,
	krzk+dt@kernel.org, namcao@linutronix.de, aou@eecs.berkeley.edu,
	shradha.t@samsung.com, vkoul@kernel.org, linux-pci@vger.kernel.org,
	dlan@gentoo.org, pjw@kernel.org, linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, p.zabel@pengutronix.de,
	linux-riscv@lists.infradead.org, mani@kernel.org,
	palmer@dabbelt.com, kishon@kernel.org, kwilczynski@kernel.org,
	linux-kernel@vger.kernel.org, inochiama@gmail.com,
	devicetree@vger.kernel.org, spacemit@lists.linux.dev, alex@ghiti.fr,
	krishna.chundru@oss.qualcomm.com, lpieralisi@kernel.org,
	conor+dt@kernel.org, thippeswamy.havalige@amd.com
Subject: Re: [PATCH v2 2/7] dt-bindings: phy: spacemit: introduce PCIe PHY
Message-ID: <176054651498.4032617.11231316454316691309.robh@kernel.org>
References: <20251013153526.2276556-1-elder@riscstar.com>
 <20251013153526.2276556-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013153526.2276556-3-elder@riscstar.com>


On Mon, 13 Oct 2025 10:35:19 -0500, Alex Elder wrote:
> Add the Device Tree binding for two PCIe PHYs present on the SpacemiT
> K1 SoC.  These PHYs are dependent on a separate combo PHY, which
> determines at probe time the calibration values used by the PCIe-only
> PHYs.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v2: - Added '>' to the description, and reworded it a bit
>     - Added clocks and clock-names properties
>     - Dropped the label and status property from the example
> 
>  .../bindings/phy/spacemit,k1-pcie-phy.yaml    | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



Return-Path: <linux-pci+bounces-36389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DB2B82230
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 00:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240AA17FCFB
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 22:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C582EA735;
	Wed, 17 Sep 2025 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiO9y55N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8091A28B4F0;
	Wed, 17 Sep 2025 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758147479; cv=none; b=EKYX1ezwQIT25sI/i5bU+yoCth1ymYD4BqwaotFShqlLgnm7DJX7/HCvIEU/Y4KYMhxUkJ+BNYwX6ywfp4ph/Yacy3QZizPf3U55cJ3dJZs+gCZKk9wrhN99aN0bqlaE9hogBLHbG5a3jem3XBb729KISEn5Cispog+ZzT5a/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758147479; c=relaxed/simple;
	bh=fbdW+KLDFPxSjGQleOs2jS1S1g6p2m+vvMK1Y9c6Oso=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WzDykKHJN9nmJfWu0khwjjv7YrG0CmHSIRNicO6HAvYw6VY4p/DeGF2a5QPxPJ5oSRd4BbNoYjVTV3zFyEUsYM9odkHT83Ms9eRphZzU7AVVuii0yVsIqtwv7Z8/gmU8sh7W23exrLaUWTXirNZTXXsW/zjWmzWil2DPVPxOnIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiO9y55N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3043C4CEE7;
	Wed, 17 Sep 2025 22:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758147479;
	bh=fbdW+KLDFPxSjGQleOs2jS1S1g6p2m+vvMK1Y9c6Oso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WiO9y55NLHOAOCK2KmkjN2HDDGG1i3ZDMfTVlWD/l7IniL/n/Hy0DW5q2oKUhsMQf
	 D6WTIEo2Jpc+/pcaoe9kxfHk+Xl8UQDzhAYQn4HvLggUwJQHT62ZnMngLU0e0MiN+x
	 wjI685uwrPsmZl9sM06ejL9L91e758An1sU/1efbR6q5EfEtNPFzo0qFzAHWp8f2sq
	 41/EKx+3Hl6Mq5fxI2lHZ/S0MA1qGtWiEwVy4bgKPbYr48hqNGPu55/CJWRCmabGks
	 EFOfN1DKIC/VClQNU8Sxw8ZWoUJEsiPTSUgU0G1BIZ3y68Sn+dtaneBPSPm8WKoVr7
	 5WVI/lJhM+tMQ==
Date: Wed, 17 Sep 2025 17:17:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] dt-bindings: pci-imx6: Add one more external
 reference clock
Message-ID: <20250917221757.GA1878979@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917045238.1048484-3-hongxing.zhu@nxp.com>

Update subject line similar to patch 1/3?

Also, I notice most binding commits include "PCI:", e.g.,

  dt-bindings: PCI: brcm,stb-pcie: ...
  dt-bindings: PCI: qcom: ...
  dt-bindings: PCI: altera ...

On Wed, Sep 17, 2025 at 12:52:37PM +0800, Richard Zhu wrote:
> i.MX95 PCIes have two reference clock inputs: one from internal PLL,
> the other from off chip crystal oscillator. Use extref clock name to be
> onhalf of the reference clock comes from external crystal oscillator.

Not sure what "onhalf" means.  Maybe it means something like this?

  The "extref" clock refers to a reference clock from an external
  crystal oscillator.

Same issue in patch 3/3.

> Add one more external reference clock for i.MX95 PCIes.


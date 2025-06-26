Return-Path: <linux-pci+bounces-30836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBBDAEA876
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637B14E13A8
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB623498E;
	Thu, 26 Jun 2025 20:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXjhJWui"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78B202996;
	Thu, 26 Jun 2025 20:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750971202; cv=none; b=fRRPhhP+eFvDwZ4li2KDVmQNrKGyr4gExbl4tEYYucTXjOtnVKHk1qqkhOCwrFn6GJJVT5b+Z7ZCEM024+KFMwSFEVfVlUvNNh3yMs1uW6Pm2HmZ91w0k1oa3WDPrPyC00ujypqqWHazs0sAkrz45L+gIT/V12v7kCTrUztepos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750971202; c=relaxed/simple;
	bh=0g7iSied3OEnPT7KVQMAkGAzIEK4A+z+aiw/sGNinZg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dU/CIn0ywiFi+gyZf8NVcXVATztfYjazVhzrPy9OhLOeONRBhaG+2PkOV51TP3JAtu3UOho1ssKjsthn0pUeHXS0adDyu0SudOjDFWkEUsDAlttnsGUZpiPlrslYNQsFI/cTmL6ZOvpM9MUWDCrp0COhQP1IybWxbzkr8ZByOwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXjhJWui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84894C4CEEB;
	Thu, 26 Jun 2025 20:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750971201;
	bh=0g7iSied3OEnPT7KVQMAkGAzIEK4A+z+aiw/sGNinZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AXjhJWui5+w9ZEguUthWz8aOBt63fz+PqDqaMPG7AQM7MW7VMMNYqmR5ot4CkE111
	 OQaSUdW8eN7vpH8xtVbdzFmvYzMUmvWOlhdQwGt5wUeybDv7I4+tgtjuIsfFa7RQvo
	 Aen/y5yFfhASs91QlMJ+Wz1z13WZc0fBb3waPzA1N5KjiO3NmgG3u9l/55JVr6fguo
	 W88NlRFFgagQE//5mHpplVIT8SdZJMASZyBpWMWVarCJQxppT72ohAsxeHTt5fuBh0
	 30jFvrv4O8D0tGLNyMl2RcKZInFOvKpYu6Erm/I/tMDgIhitgTUmTCCG4Fl07zfvaI
	 6nOLgPrYBcOfg==
Date: Thu, 26 Jun 2025 15:53:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-binding: pci-imx6: Add external reference
 clock mode support
Message-ID: <20250626205320.GA1639629@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626073804.3113757-3-hongxing.zhu@nxp.com>

On Thu, Jun 26, 2025 at 03:38:03PM +0800, Richard Zhu wrote:
> On i.MX, the PCIe reference clock might come from either internal
> system PLL or external clock source.
> Add the external reference clock source for reference clock.

Add blank line between paragraphs or reflow into a single paragraph.


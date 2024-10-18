Return-Path: <linux-pci+bounces-14886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FAB9A49D5
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 01:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72061C2189C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 23:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FBA190075;
	Fri, 18 Oct 2024 23:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kj+Am4S1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2EB188010;
	Fri, 18 Oct 2024 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293189; cv=none; b=J6PMta4ffxFuqMT/ygTeeHUQ9eq0uxveCU+vm4Cv+GFdvWHejVXipRdG/sauxx4Dc8dIB4ykL2/1EV5OZZM18zmyqupytjBMyKugbrF7bHGiP0WB/9WkukOVssn6zJVNYF+h6wDWiZIYXZrmaSaM9MP1Ipf0aUNVDHzPtfm8pnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293189; c=relaxed/simple;
	bh=PxigYZHsMS7Ka5btja412U+QAgfuxXzExNadMgste3k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sAl2SzDJdq/kLsuIrv3y4TmPXJtFsAAkNg4qUKDVpIkqKKPDCf0TPSWjq7dqu3wbwjahkE/t+wMW3wBBwX/EfJmzbfh5yd0FNV/WfiPn99ZfUQlZJ/ya3wJML3YRoeuEBYpDeXS3+nfoGiwq//pBOuEWw2z8vjEcyy6m5nNhofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kj+Am4S1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391BCC4CEC3;
	Fri, 18 Oct 2024 23:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729293188;
	bh=PxigYZHsMS7Ka5btja412U+QAgfuxXzExNadMgste3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Kj+Am4S1ctlX8aVYBQNWz6oPsMnQEk2nOAo5koJNfIszdt6Eq47C1G2y4R2hy4GAU
	 /ApgU0OfDgBcDCrtPG5CNhY1fPyd7Jmk3ieIqJy7l7+JCBqeIb4q4kwVYj8eUzMjfB
	 96gbzFf4veNd+v+hUUQOrjJHyFzgroSLHAzHT/pbcS+KXOy9nx0b65aOJ102DyL+it
	 2h7/KLbWxSgd+e3ZNlxui6WBdDETnzhe3p+EnHbOg3tVCOvdOqUbSxQnw0rLwNLp9r
	 V4It16N9KjDPspAmRWXOIuC0Hq9YHbBgSDLWBDjssKlbniMC7sR42o1d91nFNGqMoV
	 vuTz7ZPuFUEOw==
Date: Fri, 18 Oct 2024 18:13:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	lpieralisi@kernel.org, frank.li@nxp.com, l.stach@pengutronix.de,
	robh+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
	s.hauer@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 1/9] dt-bindings: imx6q-pcie: Add ref clock for i.MX95
 PCIe RC
Message-ID: <20241018231305.GA768070@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728981213-8771-2-git-send-email-hongxing.zhu@nxp.com>

On Tue, Oct 15, 2024 at 04:33:25PM +0800, Richard Zhu wrote:
> Previous reference clock of i.MX95 PCIe RC is on when system boot to
> kernel. But boot firmware change the behavor, it is off when boot. So it
> needs be turn on when it is used. Also it needs be turn off/on when suspend
> and resume.

I think this background would make more sense in patch 2.  IIUC,
that's where the driver behavior changes to do something with the
"ref" clock.

I'm not sure how to interpret "Previous reference clock of i.MX95 PCIe
RC is on when system boot to kernel. But boot firmware change the
behavor, it is off when boot."

Does that mean a previous version of the boot firmware left the ref
clock on at handoff to the OS, and newer firmware turns it off?  If
so, I think it would be useful to include information about the
relevant firmware versions.

> Add one ref clock for i.MX95 PCIe RC. Increase clocks' maxItems to 5 and keep
> the same restriction with other compatible string.


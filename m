Return-Path: <linux-pci+bounces-2822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34376842B63
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 19:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECDA1F26343
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 18:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853A7156965;
	Tue, 30 Jan 2024 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SP3HKBR9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F39151CC5;
	Tue, 30 Jan 2024 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637642; cv=none; b=aPXGxpCmgQZC2nJBtDzClRbgpVvzP0jwTbT4AuU1/LE7fgSVG/SVzx/oki06z2RynMtAm0seVU/7TIdm7b5ASCkjDQZMrlYJMcS5LxDNccE0Sgc3qWYDoNmTyqZYtAQGtLbgaB2eqKYeS6u5pYVLrL5aDC+I3f1EXKmFisUc49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637642; c=relaxed/simple;
	bh=jmEGxZN9eYlnIeXi/0mGgvvYWPqlfpHZqWmehh8Vc14=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ISecXq2RimPlHNR2mm5pf9oPIvlUa/tV5XiNGlmdMa3IIr1kCJoe8v89wpr/oIs1mAUUUfYn8Ji3zncxgkexCGMxX5ta6AADoP2GE7s5Y8Hqv5P/3vuvIt5h6xo5hNvk4Nc1u+/VgYrVTwq8Kl4gU/ad48aUlL+K0TT57XC5g/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SP3HKBR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8927FC433F1;
	Tue, 30 Jan 2024 18:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706637641;
	bh=jmEGxZN9eYlnIeXi/0mGgvvYWPqlfpHZqWmehh8Vc14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SP3HKBR9cXVVQTQSJ2YaAzeKPdbiCOgkHbpOombxoJdnTqnEGTkQf96c80E2KZXUS
	 7ucVgJth0eMCxO/9iBJnLyafsAFTUyLQj4v6mB8ZyWXnGEn0lWOdpXkN6aC3gWpLNJ
	 dvpIulGF/OfoI5CdRlqiRNC3X/ebXBG4jbViajfIbVLKED3PPwCtZVs2a+SBAuH5kD
	 3bkFXuzadURq9dnA2vy6tSbA8vecRsno1W1gnnvR2GEqfOAP3T8B3aUS3zpuVyooSQ
	 7uZKfEukyqC78t6VHl/3pBgu16oMnzyIM9b7mRuHGppSZVNK7qij2gnOkqGF3E+Y2d
	 tRA48FZec8aPA==
Date: Tue, 30 Jan 2024 12:00:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/2] PCI: qcom: Add X1E80100 PCIe support
Message-ID: <20240130180040.GA527428@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130065506.GE32821@thinkpad>

On Tue, Jan 30, 2024 at 12:25:06PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jan 29, 2024 at 04:41:20PM +0200, Abel Vesa wrote:
> > Add the compatible and the driver data for X1E80100.
> 
> If you happen to respin the series, please add info about the PCIe controller
> found on this SoC. Like IP version, Gen speed, max. link width etc...

FWIW, I always prefer actual speeds, e.g., "8 GT/s", instead of things
like "Gen3", for the reason mentioned in the spec:

  Terms like "PCIe Gen3" are ambiguous and should be avoided. For
  example, "gen3" could mean (1) compliant with Base 3.0, (2)
  compliant with Base 3.1 (last revision of 3.x), (3) compliant with
  Base 3.0 and supporting 8.0 GT/s, (4) compliant with Base 3.0 or
  later and supporting 8.0 GT/s, ....

Bjorn


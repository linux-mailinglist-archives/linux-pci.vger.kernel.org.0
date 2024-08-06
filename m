Return-Path: <linux-pci+bounces-11357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 046A7949336
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 16:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA835B243C4
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E931D27A3;
	Tue,  6 Aug 2024 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="cE+AUJ4q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A43B1D1F4E;
	Tue,  6 Aug 2024 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954937; cv=none; b=KVpU8ja0bi3yyQ7etp+4N1j6F15mq3vqzoU9KcLUEb7jMSs/3YgUqxfXO3AoEszHJGo8RSbGfg/TLkHv5W9FJa9VO8CL2dox+CklAa/ORY7q/b5U7h/fBVKbrmiKmpjYoEeI+iRPhukSmb2Dgq07PvI+SzdlT06SD7H35yrsjdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954937; c=relaxed/simple;
	bh=Uw6HRtpZl8EfaERoyXUbtABtnWbIWcooNpV9YaxkyjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6bK28Dqnly2IagcoCMLP+dSgKIqCwnV1YvVSQwBX7InuL8Saec/Z/Iv5Ewscl8Kt2BH+b2S7efFD898XcNK39XwGuS9Rfgzdw8v0KRrFrNz+hPO/dNYFPwHbusyYEtt2JoWrxF0Wreddqk9jdpgK76rGcMlXXVnuc+E4DLOZhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=cE+AUJ4q; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 98A3220284;
	Tue,  6 Aug 2024 16:35:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1722954924;
	bh=fGtGysqRw2M+SB4BHIAeHaD7D+DJXET7byhHYZ12njk=; h=From:To:Subject;
	b=cE+AUJ4qwRpoqscFcQYUl597p/+2xAYsBs0yS78ta+rfpc83a74oRDlV1dp0+C83m
	 dphzyJryQhUYJJRO6jufn6x8Glz9z244tud7rZUnVy9f8WmjMNpUZulOBvWbzm6J5I
	 MywqLZ1LhltSIoK5m/addWAtXzZYDeKkDjuYJH3WBiuBaqdVsVllmiz7QmY3UxX6vK
	 g40oXQfHt29ufPMte6s4UJkLWfN43sNWzL7gd18mgAV2V02Fh82aw8nhNnBKxHHo5x
	 LMTIG6NT2QZocJ3ora97d7bdjngueLyRv1ccY+c83wmwiR1L/p3l0IgOGct5jHOG5p
	 kCM4a2JV4zZtA==
Date: Tue, 6 Aug 2024 16:35:19 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/2] PCI: ti: k3: Fix TI J721E PERST# polarity
Message-ID: <20240806143519.GA176293@francesco-nb>
References: <20240703100036.17896-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703100036.17896-1-francesco@dolcini.it>

Hello Bjorn, Krzysztof W., Lorenzo

On Wed, Jul 03, 2024 at 12:00:34PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Fix PCIe PERST# signal polarity in TI J721E used on TI K3 machines.
> 
> PCIe PERST# needs to be de-asserted for PCIe to work, however, the driver is
> doing the opposite and the device tree files are defining the signal with the
> wrong polarity to cope with that. Fix both the driver and the affected DT
> files.

I just had a chat in IRC about this series with Nishanth. He agrees that
this should be merged, even considering that this implies breaking the
compatibility with old device tree blobs.

However we should be sure that both patches get merged in a coordinated
way, to avoid breaking stuff within the same kernel release.

What would be your advise to move forward? Are you ok with the change?
Should I split this series in 2 separated patch?

Francesco



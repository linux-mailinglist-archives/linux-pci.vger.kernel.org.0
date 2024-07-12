Return-Path: <linux-pci+bounces-10202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C4E92F916
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 12:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463DF285EAE
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E45D15DBAE;
	Fri, 12 Jul 2024 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwOv1qfx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C2CD512;
	Fri, 12 Jul 2024 10:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720780852; cv=none; b=kvGcyMQrMR6yFDmr370ZukQr+HzWx0TWKdE/IdLBZwHxg2rrT2J9ul+VA4JRy4qkRUfRACNYA6lq+Wka8GLRtlLamCIe6NKd3xzGUJrgfLRaZn3pdIofhLHx1py/HgZ6K2s9dyCXMzc8d760miafbmd/5iDzfIzjmLc0CI5ryjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720780852; c=relaxed/simple;
	bh=bOjn2VZ/JaTevNQ7X+A3Hi2dXS4RDmxT3adWzbfLPT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyIkoBmQX9BMu86M9ynirNlmP5wdXeaDkPq4AoaFTNWET9kfYSAL2QdT9tTnsSNaejo0Kz577iAAxTYeB5WLtsHACjVlr2TfzktqxDCBKJAOSWUJWrJ6KyNXRn6uvnycxrSjVpD5vIGf/7G7SlhHWGuMrbNLJndxV8L03fB8VGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwOv1qfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD33C4AF07;
	Fri, 12 Jul 2024 10:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720780851;
	bh=bOjn2VZ/JaTevNQ7X+A3Hi2dXS4RDmxT3adWzbfLPT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jwOv1qfxwZzuyLqY1dIu/s8+Qx2Iw9fC2qZzln8sDB37wZ0k/HL6T/D6icz/O7v4E
	 pYGTtgOjL9F6KSmtn2BMTnXpn8Kd9ggCDUmEO4OUJaJf1Om0Njb9V/HRToGqMNT+at
	 mfFmRJHADeEucZEynxSCdJR3fUn0JGMrFwp/TpbWMEwhHMaI8VORKhZnpG64UFhHWJ
	 WGeqNXt45ofxi7/Si7IPVDeIPee4dxkqkwuX8Ry4XV4uX/km0Uc0TM0jQ6PalwzZB4
	 KM/61AI3emfHONXbccaqlkXAXrUJK+4a00mHdJN80x4TEDGMhVXNzPiCjFaSd3MdTW
	 Ldu6YRKkSiWeQ==
Date: Fri, 12 Jul 2024 12:40:45 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/2] PCI: ti: k3: Fix TI J721E PERST# polarity
Message-ID: <ZpEILZ2DLhvYYGci@ryzen.lan>
References: <20240703100036.17896-1-francesco@dolcini.it>
 <Zo_qbspq0vA_p8VC@ryzen.lan>
 <20240711152531.GA35875@francesco-nb>
 <ZpEGmeJUJxrDFQWa@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpEGmeJUJxrDFQWa@ryzen.lan>

On Fri, Jul 12, 2024 at 12:34:01PM +0200, Niklas Cassel wrote:
> 
> If you knew about it, I think that you should have stated that your are
> breaking DT compatibility in the commit message, while also explaining it
> is acceptable in your specific case.

s/while also explaining it is/while also explaining why it is/


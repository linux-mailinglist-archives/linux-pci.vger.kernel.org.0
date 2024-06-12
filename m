Return-Path: <linux-pci+bounces-8670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5829054AA
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 16:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142571F2461F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 14:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4677F17D363;
	Wed, 12 Jun 2024 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTmhKbuc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DFC171E70;
	Wed, 12 Jun 2024 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200934; cv=none; b=rprD+uzmYJRVDinAavaNFIzETn+2+9Wca1web/IfPaoo6PhuEkaEADFplcrf6hVNVkhCU/w2BeHrfEhQ5nTXcBONHIQQjI9sNV8MuwhdwhoFSqa4nDF7fWEt0gm56f+XLErZzv45tXyxc2eqbELyrxYJ/WyXMFrPZNx2qfeDILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200934; c=relaxed/simple;
	bh=eX92Qy5bBbTvqj1rZW1BZWOEF8jJThi6VroQb/e/KDE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CadSyP/ovRoKlzXQ/22a+OeT8OfExxLlfZ1S+R2ESLR5gTJ+IbRGsCJnKUNmsptYVYZkNG1ToOadQ02EjpmZ/BXRsVTELU/n2i6hunn0Tl8whE2VyoUSAtokJqTYws76bpm3sfxblyPfr0DPtOoIspNGMVVuoFFN5fMq+7mk2vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTmhKbuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F57C116B1;
	Wed, 12 Jun 2024 14:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718200933;
	bh=eX92Qy5bBbTvqj1rZW1BZWOEF8jJThi6VroQb/e/KDE=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=BTmhKbucnDuEtueX2mqWsxi3l0U+qHJnfPaoCg30YwnXvATwGTaAx34g+62SNl4hZ
	 /Yznn88XbrM/n7iZjZXZbE18sVs6wM5F5KaREoGPwCIRB6H+DTAUVBOBoyMAnxHAYo
	 k4nU7z7BXjwTQWMa2L+z7VW5vVA8t5CyhMfWXFIjjTgIe/RV8paY3Ti/tfFFv2UfxQ
	 US34jUqyhWXVFaFYel1To6uXVmFjiTpBu4bHvGAx5WzN0wR9id1uNhVW5BauMaD08d
	 rQJXAFtfl/FO2ufhGj+l6KimCGBB3EM2avaynF2ifZzIMgxacVFFgdIqydGImQl0CO
	 mFzs9Knngkohg==
Date: Wed, 12 Jun 2024 15:02:08 +0100
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Dave Ertman <david.m.ertman@intel.com>,
	Lizhi Hou <lizhi.hou@amd.com>, clement.leger@bootlin.com
Subject: Re: Raspberry Pi5 - RP1 driver - RFC
Message-ID: <20240612140208.GC1504919@google.com>
References: <ZmhvqwnOIdpi7EhA@apocalypse>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmhvqwnOIdpi7EhA@apocalypse>

On Tue, 11 Jun 2024, Andrea della Porta wrote:

> Hi,
> I'm on the verge of reworking the RP1 driver from downstream in order for it to be
> in good shape for upstream inclusion.
> RP1 is an MFD chipset that acts as a south-bridge PCIe endpoint sporting a pletora
> of subdevices (i.e.  Ethernet, USB host controller, I2C, PWM, etc.) whose registers
> are all reachable starting from an offset from the BAR address.

It's less of an MFD and more of an SoC.

Please refrain from implemented entire SoCs in drivers/mfd.

Take a look in drivers/soc and drivers/platform.

-- 
Lee Jones [李琼斯]


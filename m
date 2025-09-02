Return-Path: <linux-pci+bounces-35312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5688BB3F899
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 10:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B961A8368B
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 08:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4122E9EBB;
	Tue,  2 Sep 2025 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eexVNZZO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BEB2E9EB2;
	Tue,  2 Sep 2025 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802003; cv=none; b=chjKQwMMS1B1nCGdUmZVs5NkyJnSz7UCldlwATtiD+aF2b7O1PLBBQ121BKJcrzplKsNETs+hOeDyl1p4Q09cxsSzA63XlLI1HHNeVaDxPTAJWn0kyJhUSEwYrekNwnbP9zP+sp2VroMEyddtjeLhGa81Kh7uCprwlD29kWK2Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802003; c=relaxed/simple;
	bh=Hqr2PkWeqj78bgEo/ix/HnyM3/D2QqFTKb1SDJ42Iko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5kYoeXZFX/QTE4Kq3SduV8i6zRqM77u8p29JiA4ReZJRrCgWPvv08LnIZV1p1Yw0PQ82uz9AnCYyWoAK9pwNaybUiDtmFP36vRA9OCKg4aMNCqXgkDaOtXYVad4KBcTI6nIXUlTuY7S4uRS07qmhvoekgsHieMy039QaNHMLs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eexVNZZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC295C4CEF7;
	Tue,  2 Sep 2025 08:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802002;
	bh=Hqr2PkWeqj78bgEo/ix/HnyM3/D2QqFTKb1SDJ42Iko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eexVNZZOyCZ752U7B0Hxcl7iDb0v3eqNyGVNEJNzf0PCN5A3mrQ0AScJt5LA06Hf8
	 a5sf4rqTHCA59xQlkbFYGFgseE5b3iaP3LEVm/20ZJspA8j5cy22VIF+SVI9igcSgz
	 0UlRax8yYiV6MUzZXJbGEAZWizY2Zbj39kpJnvfo8/I0NyNYCiVGbUpt2+IQaDmq0L
	 vc9Y3Prxj+tY0TBlksdY/5gts7JPJHy/mZCpxdYkUbWOgVxD7JuiK6wKZJbtvOYKwk
	 qPcfUTqYDxqxCBibyub+dc0VK8JsdVpshCG+MpMFB7DMdDvni4nEY0L6G7UG+G/O6F
	 AgY1n5wtbq6Aw==
Date: Tue, 2 Sep 2025 10:33:16 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, mani@kernel.org, yue.wang@amlogic.com,
	pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 0/2] Configure root port MPS during host probing
Message-ID: <aLarzJZI3E_sb7_Y@flawful.org>
References: <20250620155507.1022099-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620155507.1022099-1-18255117159@163.com>

On Fri, Jun 20, 2025 at 11:55:05PM +0800, Hans Zhang wrote:
> Current PCIe initialization exhibits a key optimization gap: Root Ports
> may operate with non-optimal Maximum Payload Size (MPS) settings. While
> downstream device configuration is handled during bus enumeration, Root
> Port MPS values inherited from firmware or hardware defaults often fail
> to utilize the full capabilities supported by controller hardware. This
> results in suboptimal data transfer efficiency throughout the PCIe
> hierarchy.

(snip)

Gentle ping.



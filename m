Return-Path: <linux-pci+bounces-44682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EF4D1B8A5
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 23:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF5EB3017112
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 22:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996763559F8;
	Tue, 13 Jan 2026 22:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALdKK/qY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D80355048;
	Tue, 13 Jan 2026 22:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768342009; cv=none; b=sGUUSJCxJSgZ1xdYzGY6YzgjdfPJs7saM3eOLUXnEAhSFJXLC6YH9cSAbI48xFrJagchF+8Xy8KnbDO+bmKdYHmDZi3EvrQ+TQZgWl6M1zHaitN2s4kG+cC6J4h6FXLJVS0d7t6UlgkiWOp6F9WxKvDYbdrCy1J/XLn3RePprV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768342009; c=relaxed/simple;
	bh=NegEUsO0Ota85lCaBFHxVe1ITKjDvmjQpJOqGtlFsz4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VhjmEUAiYUni7wg2Un6fFOi2uMgUpLr1gXPh0HvIwXKeuCT4P9Wv2aoQRpJ11en18awjNTeSgEAvx7l9Rt3nvVthtC/tqayPbI220I0BfAp0AtjafQgzEivVXxhuU0X7EajJP6klozGDS3Z1AgYiDJtFgq6P6BQQwAtn/BXDqDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALdKK/qY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE027C16AAE;
	Tue, 13 Jan 2026 22:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768342009;
	bh=NegEUsO0Ota85lCaBFHxVe1ITKjDvmjQpJOqGtlFsz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ALdKK/qYZa7NSJD4MO8XaZ+koCs5rf1za2Gk7w708Xwkm6BMWHZIYBzEJannT1kaL
	 zajUcL3vWLJ8xG8Tk8PwoPrBdWGWr96R3ClubDYde2QTwOcLnXqy9/itFp3ZUjBKwv
	 8cdBI41fy3i5sVHbcNKYs0uEzWoFfBT0KqwcxjLvbn4TGdFJDPyWeTUUJSOCShEAH0
	 bYC8wajTJYfScpe5O4lrJxyWP0DUStwAf65rvph8EPFgb8WuBZZVhOkKp3poY3Eq8a
	 JJ1MLDnJgjogdmMe7gpDtuiCK1SZtIjI4w+kAH89IBzbRiw5kU7evDTiGGu+E3hnq+
	 pdijCp3gKnXGg==
Date: Tue, 13 Jan 2026 16:06:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: liziyao@uniontech.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	niecheng1@uniontech.com, zhanjun@uniontech.com,
	guanwentao@uniontech.com, Kexy Biscuit <kexybiscuit@aosc.io>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org, Lain Fearyncess Yang <fsf@live.com>,
	Ayden Meng <aydenmeng@yeah.net>, Mingcong Bai <jeffbai@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH v5] PCI: loongson: Override PCIe bridge supported speeds
 for Loongson-3C6000 series
Message-ID: <20260113220647.GA783058@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113-loongson-pci1-v5-1-264c9b4a90ab@uniontech.com>

On Tue, Jan 13, 2026 at 03:58:48PM +0800, Ziyao Li via B4 Relay wrote:
> From: Ziyao Li <liziyao@uniontech.com>
> 
> Older steppings of the Loongson-3C6000 series incorrectly report the
> supported link speeds on their PCIe bridges (device IDs 0x3c19, 0x3c29)
> as only 2.5 GT/s, despite the upstream bus supporting speeds from
> 2.5 GT/s up to 16 GT/s.
> 
> As a result, since commit 774c71c52aa4 ("PCI/bwctrl: Enable only if more
> than one speed is supported"), bwctrl will be disabled if there's only
> one 2.5 GT/s value in vector `supported_speeds`.
> 
> Also, amdgpu reads the value by pcie_get_speed_cap() in amdgpu_device_
> partner_bandwidth(), for its dynamic adjustment of PCIe clocks and
> lanes in power management. We hope this can prevent similar problems
> in future driver changes (similar checks may be implemented in other
> GPU, storage controller, NIC, etc. drivers).

Don't split amdgpu_device_partner_bandwidth() across lines; that makes
it hard to copy and grep for it.

Bjorn


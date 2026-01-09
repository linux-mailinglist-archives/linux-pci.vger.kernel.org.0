Return-Path: <linux-pci+bounces-44343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFD6D07DF3
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 09:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 951723067DE9
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 08:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BA3350D45;
	Fri,  9 Jan 2026 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsCBqrk0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3470350D68;
	Fri,  9 Jan 2026 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947926; cv=none; b=jZQ4nuG6uR4k/cPUK681LQMJDzXZludLnh6TnoPygCMGYF+QjIShILl31cxEsa+uLcYQc31CldPiyL1+oebzJ4fqPEthoWK3gGuKtUGAt/HQa1K/EwlBsoP8uxK9fppNCCh0LG8/bjpZk63CRFfFuDC9etNSNJ2ijjRRtku3cl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947926; c=relaxed/simple;
	bh=a98W+72H+QrvZTa+W7QmD1B9sIhKMP4/j8pKEcILt+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKK49hNnhfzDxsON41esNJ0jCSSxgCz5rbsV2W0oqm/DHsoUt1PrkHiNsi2J1NbQqpYDiqBKgCP4ipyRvlp2lzRR32XRdHmxKPZ7ab8QU4BXazqUi9OHtaQseqTk8uLoE8SegCKUKaX7pWOuMsAMbEec8dtBUps9XCj7ns/V7/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsCBqrk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B998C2BCB0;
	Fri,  9 Jan 2026 08:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767947925;
	bh=a98W+72H+QrvZTa+W7QmD1B9sIhKMP4/j8pKEcILt+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AsCBqrk0vvLVhmih7qPc+AeKhH4Pu47oQfOdgYtmjO9go4kvStnPT8U3A8pvQHnNI
	 j/2kTuMLpbzENN+/r4sdyNRrbMSiLsPU71fe7eBoMNvAgrKGKZLhzrjeuwruQMKK74
	 wJ+PPJWdBrCml+yurM4+bZY6f7ptpb3sNGKBg7TAlvPCnZCfYLvW19QGbfJTO0W2YC
	 hnVk5mUB7BbOWQBXqdlnjBBzil5KyFGzn9Z/Op3ivQM9ivLZ5W2d66JSiFwFqDgwMT
	 ZqLE5NpDbCE/od6DnBMdYLvrcwA7gtQwDR96DDsVAghy/rf4TUUsZvH2HFWO2/rybu
	 KFcL9DzNhOKTA==
Date: Fri, 9 Jan 2026 09:38:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	helgaas@kernel.org, heiko@sntech.de, mani@kernel.org,
	yue.wang@amlogic.com, pali@kernel.org, neil.armstrong@linaro.org,
	robh@kernel.org, jingoohan1@gmail.com, khilman@baylibre.com,
	jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 0/2] PCI: Configure Root Port MPS during host probing
Message-ID: <aWC-jkgIR7Q4scxn@ryzen>
References: <20251127170908.14850-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127170908.14850-1-18255117159@163.com>

On Fri, Nov 28, 2025 at 01:09:06AM +0800, Hans Zhang wrote:
> Current PCIe initialization exhibits a key optimization gap: Root Ports
> may operate with non-optimal Maximum Payload Size (MPS) settings. While
> downstream device configuration is handled during bus enumeration, Root
> Port MPS values inherited from firmware or hardware defaults often fail
> to utilize the full capabilities supported by controller hardware. This
> results in suboptimal data transfer efficiency throughout the PCIe
> hierarchy.

Hello PCI maintainers,

any chance for this series to be applied?


Kind regards,
Niklas


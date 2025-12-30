Return-Path: <linux-pci+bounces-43845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3366ACE9A7F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 13:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CBBF3009819
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 12:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DE1280A21;
	Tue, 30 Dec 2025 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZpWdm9y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50922299931;
	Tue, 30 Dec 2025 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767097911; cv=none; b=R8mrr8slJGP+r5toydPurnbAbNMn28fOta/GEPpOFn1307S4gh+uX+pjGA28NsOl68NEMlsa4ZoaJePEQiYaPEie0ByYqUbW4kxs62wn0gdJFy4woTNeUCSgjjgiXfo1C7z5GrrNhTXY04WGHWAecKqlXdtXV78wFoqU3AjPMbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767097911; c=relaxed/simple;
	bh=xQdxrkgcQthC9O2bUcQSKw8nzcN2rjSk2sj5zMsaGis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXG3LCZ1tiEzfzEOJZ9czKWfjl6BmN5LLmxtIlWD2zw1XBnjRVO8PQ9EZHiwIXuZF4FVV9Scju6/jFjexb8lI9edRXkwvrSHGKGoz1XMY9Xsm/DdramSNUaBLYTTMwJV9WIaFNurLbWurdCksU2blu7bQtaEw+/UWsROUAiikTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZpWdm9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABDAC4CEFB;
	Tue, 30 Dec 2025 12:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767097910;
	bh=xQdxrkgcQthC9O2bUcQSKw8nzcN2rjSk2sj5zMsaGis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kZpWdm9yMx3fQHQ934faf7zUG2KbYD/de8M1b21RT6XTNXjON7A4x5g/9wS0bdGK3
	 EyzllH+nqZJh+XekuCLWFXZd658ANj35K7kgTq+dLDuwSVVINJPjgNHHdOu5Ilg8WD
	 wkG4qr3atwJyTDpHiPwBVnaeiNNloo7j61UUcHuaBhItKUjVNb40kQgoIxaTRZcko6
	 6yGeINqgd/7oMqKyFAvg3dX2ng30fc4pexm36bz7UdfzgbwcBx8kf8EhYbFj2kk+CW
	 xNBAcQIDJAonWwoQuaTE7UHuo0D9AbRvCsMQRMXpw2Mf4McfrVyBmgRGmtBIXtjHQV
	 33EvogLizGuMA==
Date: Tue, 30 Dec 2025 13:31:44 +0100
From: Niklas Cassel <cassel@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Alex Elder <elder@riscstar.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 6/7] PCI: qcom: Drop the assert_perst() callbacks
Message-ID: <aVPGMJkleqTJezpX@ryzen>
References: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com>
 <20251229-pci-pwrctrl-rework-v3-6-c7d5918cd0db@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229-pci-pwrctrl-rework-v3-6-c7d5918cd0db@oss.qualcomm.com>

On Mon, Dec 29, 2025 at 10:56:57PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Now that the TC9563 Pwrctrl driver is converted to use the new Pwrctrl
> design, there is no need for these assert_perst() callbacks. With the new
> design, TC9563 will be powered on before PERST# deassert. So explicit
> PERST# handling from the TC9563 driver is not needed.

The commit message is a little bit confusing IMO.
The explicit PERST# handling in the TC9563 driver was removed in the
previous commit, so perhaps it is better to not mention TC9563 driver
explicitly (all pwrctrl drivers need to stop using the assert_perst(),
that TC9563 was the only pwrctrl driver user of this API is a detail).


Perhaps phrase the commit message something like:
""
Previously, the controller drivers probed first, toggled PERST#, and
enabled link training and scanned the bus. By the time the pwrctrl driver
probe got called, link training was already enabled by the controller driver.

The pwrctrl drivers thus had to call the .assert_perst() callback, to assert
PERST#, power on the needed resources, and then call the .assert_perst()
callback to deassert PERST#.

Now when all pwrctrl drivers have been converted to new pwrctrl design,
there is no need for the .assert_perst() callback in the controller drivers,
because with the new design, the actual work by the pwrctrl driver will have
been done before the controller driver enumerates the bus. There is thus no
longer any need for .assert_perst() callbacks in the controller drivers.
""

Perhaps also split this commit in two.
Because with the "PCI: qcom:" prefix it is not clear that you are also
removing the callbacks from pci.h

So perhaps create a second patch with only "PCI: " prefix:
""
Now when all .assert_callback() implementations have been removed from
the controller drivers, drop the .assert_callback callback from pci.h.
""


Kind regards,
Niklas


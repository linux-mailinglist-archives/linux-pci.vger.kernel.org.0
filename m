Return-Path: <linux-pci+bounces-35737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2F0B4A716
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 11:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C594F3B93F8
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 09:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014D927B4EE;
	Tue,  9 Sep 2025 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqnTK/cQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA1279DDB;
	Tue,  9 Sep 2025 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409026; cv=none; b=XWrf+efwoAnPoekz2Ujqcs1toObbzgwNCfLKCLFRAOnWPZY6Kw9Z5Ye+Hyh7hCXDv7j4yVFzuzx4/V53lKnyOQ+l4r8kbNJxTOfdJQBJVgL7D41AyCgiGUi1Aa0M6eAQGu4SAFf9ZO6Y1XTNdUsIpV5bMUW/vwlDp9En0JHUHnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409026; c=relaxed/simple;
	bh=lT+TBUjr1IEMc1JW6nEbwDuFgBshtFR0gCTlV9HCcAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlDlNC3nUG5rHncDt2n9cklVJvu8NJJ9my7rd8YNhpflSoVa8PFCZrzxyJKHL2frqxP7Lk8XrL3DCq2ARw8dYfIlHNZLtmTFgzFvPjkqObeUh1bNBc8mDq0N7fx0C+wN+kTq+scBfUjgRz4zUgIyMJZWq9Tg6de9g01Vk3wxrUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqnTK/cQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43510C4CEF4;
	Tue,  9 Sep 2025 09:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757409026;
	bh=lT+TBUjr1IEMc1JW6nEbwDuFgBshtFR0gCTlV9HCcAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sqnTK/cQWndHfSbaZ2pd+a8nhIRu+tbohS1rrIgk8ZqUso4jSwt+Q6kgDxI3V0Cax
	 a+tAVcn1i3O7VoeQJTEEKjI3K1RHY5XVe5LhHSNWeYzkG/Dizq57kSOjbA0vM22gmX
	 DK24Tv47CPb0Ft0wzPzByQbEFRyGBKvB7JPOt9+xjJ9mj9eGVVXHQLbXrG+YSPzT91
	 RcjvjQYkaEpz2Sr9HVOrCGUbvmJIV9xaN5On4vBHLsHKzBjFZdrbRxovF8eA/VVeXL
	 13S8LxoWwanJQ0QzCs7PBuWp9zy/n89K+beE1y7d9P7UWSz+D9QNTdWuvTq1eDJ5fT
	 y5J9ebFR0BbXw==
Date: Tue, 9 Sep 2025 14:40:18 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 3/5] PCI/pwrctrl: Add support for toggling PERST#
Message-ID: <ijb6xnd5cl6v4cw5lfx5srjtzionx3iyxxg32xhljyylmplciz@dgizpuhv3c4u>
References: <20250903-pci-pwrctrl-perst-v2-3-2d461ed0e061@oss.qualcomm.com>
 <20250908193529.GA1439341@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908193529.GA1439341@bhelgaas>

On Mon, Sep 08, 2025 at 02:35:29PM GMT, Bjorn Helgaas wrote:
> On Wed, Sep 03, 2025 at 12:43:25PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > As per PCIe spec r6.0, sec 6.6.1, PERST# is an auxiliary signal provided by
> > the system to a component as a Fundamental Reset. This signal if available,
> > should conform to the rules defined by the electromechanical form factor
> > specifications like PCIe CEM spec r4.0, sec 2.2.
> > 
> > Since pwrctrl driver is meant to control the power supplies, it should also
> > control the PERST# signal if available.
> 
> Why?  Probably obvious to hardware folks, but a sentence about the
> necessary connection between power supply and reset would help me.
> 
> > But traditionally, the host bridge
> > (controller) drivers are the ones parsing and controlling the PERST#
> > signal. They also sometimes need to assert PERST# during their own hardware
> > initialization. So it is not possible to move the PERST# control away from
> > the controller drivers and it must be shared logically.
> > 
> > Hence, add a new callback 'pci_host_bridge::toggle_perst', that allows the
> > pwrctrl core to toggle PERST# with the help of the controller drivers. But
> > care must be taken care by the controller drivers to not deassert the
> > PERST# signal if this callback is populated.
> > 
> > This callback if available, will be called by the pwrctrl core during the
> > device power up and power down scenarios. Controller drivers should
> > identify the device using the 'struct device_node' passed during the
> > callback and toggle PERST# accordingly.
> 
> "Toggle" isn't my favorite description because it implies that you
> don't need to supply the new state; you're just switching from the
> current state to the other state, and you wouldn't need to pass a
> state.  Maybe something like "set_perst" or "set_perst_state" like we
> do for set_cpu_online(), *_set_power_state(), etc?
> 

Since the spec mentions the state change as 'assertion' and 'deassertion', how
about:

	 pci_host_bridge::perst_assert(struct pci_pwrctrl *pwrctrl, bool assert)

- Mani

-- 
மணிவண்ணன் சதாசிவம்


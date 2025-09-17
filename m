Return-Path: <linux-pci+bounces-36332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7938B7FBBD
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 16:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34AE1895D45
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 09:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E680821C9FD;
	Wed, 17 Sep 2025 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToBCSoRZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A902EA483
	for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101203; cv=none; b=Cl3CfuIf7EZAlfqUj6T0evIuh9Ap0rIrMd96nvr6OlUTgOySBaXfB3uP1BQDBe9fza+Uuml4y8VotTZj84TTLjecK3GOkNOTY4Y6PgGYGRpZHHa+icaTmYdmUd3yJgzUG1Gpz7dfZmX/E5xjcB0zEC6CmWLYQ3UQBiFMK3W/g3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101203; c=relaxed/simple;
	bh=IJtYFc3Q9+3XAXBIZkCH7D3WxQhSB0Lo8WibmOq24Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=euWn6PYHmIkTNwakRzWS9PycaSrin/9iyWWPrugl0YdKWT2Q7+c6b1VWvbPelQs+rFRXc1imT4qsrEGBGiqxaToNu2LURdqtsrL0Ray7Te03cgqzwuT6vhMMWRdjT9ZYJaSEW9hDRLNW7cPq3hI395Dqfho6J8F966hMU8m0l/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToBCSoRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034CFC4CEF0;
	Wed, 17 Sep 2025 09:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758101203;
	bh=IJtYFc3Q9+3XAXBIZkCH7D3WxQhSB0Lo8WibmOq24Hk=;
	h=Date:From:To:Cc:Subject:From;
	b=ToBCSoRZH04+bPsRwZgMRyZ3X//PNPzPLp8YXsXb87ti2HBqE0p+Chg8M3H76aJLM
	 pJEe02YO63DjZRwcWNLLl0P5j+rv21UwRwVjFMs3KoZqpJX4pf6vjkv65Ys3Iv1z/p
	 sW5fP4A/7A0azaHR7Ic/Bu4NoDyYH+kHakBWSZTPXA+O/voyYU+r/kPVR4/btmSOKl
	 if/EP3J9v7H+bZ+RDEzf9Hyypfm4l/wXF6Gngtlyo3oAQ3a4ppY9o0XklxWpbLpfnM
	 KRWHyzEhAS38nBstcWgvpLWU1Z553ZAo1PObOsOKaIYUTQPO92O97iokiObdEY3yA+
	 0VCiq24PokdTQ==
Date: Wed, 17 Sep 2025 11:26:39 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: PCIe tegra194 endpoint mode regulator question
Message-ID: <aMp-z6BufaYil30R@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Tegra PCIe maintainers,

Looking at the device tree binding for Tegra PCIe endpoint mode:
Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml

We can see that 'vddio-pex-ctl-supply' is marked as required.

However, when inspecting the driver itself:
drivers/pci/controller/dwc/pcie-tegra194.c

regulator_enable(pcie->pex_ctl_supply);
is only called in tegra_pcie_config_controller().
tegra_pcie_init_controller() is called by tegra_pcie_config_rp()
(Root Complex mode), however regulator_enable(pcie->pex_ctl_supply);
is never called by tegra_pcie_config_ep() or pex_ep_event_pex_rst_deassert(),
or any other function called when the driver is using any of the
PCIe endpoint mode compatible strings.

So, I think there is something wrong here.

Either:
1) 'vddio-pex-ctl-supply' shouldn't be marked as required in the
   PCIe endpoint mode device tree binding (or perhaps not be there
   at all, since regulator_enable(pcie->pex_ctl_supply) is never called.)

2) drivers/pci/controller/dwc/pcie-tegra194.c should call
   regulator_enable(pcie->pex_ctl_supply) even in the endpoint mode case.


Looking forward to your feedback.


Kind regards,
Niklas


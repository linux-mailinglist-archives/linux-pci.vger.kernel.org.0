Return-Path: <linux-pci+bounces-38654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94463BEDF13
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 08:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E318534AB07
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 06:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1496920F08C;
	Sun, 19 Oct 2025 06:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM9Qk7Q3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08C01EE019;
	Sun, 19 Oct 2025 06:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760855167; cv=none; b=CPQuM4x+JlBTlBAe9xAa6s62Dq8C0Pc3aHVgaEnaTFVnBAGz3134IiGaRvwBEu4WrRFbziJ8tMPbTOo9NlruupyVIDtVci+vjx28298miAJhXbizKo++UgNufVI5fpv/NVa8h2Snw+hgoi9u+SDYn9rJG52sKc0CirnC4ggc+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760855167; c=relaxed/simple;
	bh=5drm76qRadzN/MiXV5TorM1Em9uwpzEm1NGdBnBhsDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6HbQtJ+atVRH7lhw2leJUqBWnW0Zs9S47dIZ+uzNPXyILbAUW2c8MBiGOIqkJF3VdjB8U+uWjoN3jRnNdQyKf37WrJfgkvWlrOr0/clTsmm8SCnjHyTKcnOLx/MrppLc+5cCspFRGaJ9B3tppgkDJytqUNIrcEvQFCLKRwCl/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM9Qk7Q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAF1C4CEE7;
	Sun, 19 Oct 2025 06:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760855166;
	bh=5drm76qRadzN/MiXV5TorM1Em9uwpzEm1NGdBnBhsDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eM9Qk7Q3wQJHKvcthQ9pRHExHxk301B5waian5gtkujs13tIF+kUatzBWZ59lJCYp
	 ePALQuqjiQkRyskr6+l7Ul0zg8ES+WBlKzL4QnVNmvUa2etVdUlXBAE9Y/+pF5OzUK
	 t9esr8xOZ0DYIIgr9RvEljsv7/ZipO7S9uMqnU6bb5+fyl1/SKjHhlZuMm3Av6LU5J
	 bcwyGm5PqBa+W5FKLKKlQlbydhSO5vObxEe3uSUo3JV0caLW+5J6rp5r8Pu58qL14l
	 8VwpCEmAZRFqhT6q+qhRTpzAg2+i/ZIyIf/K4+LsjwDMQhFO91oixGAmdmHsUu7B8A
	 Ve/I8yH4+DdZg==
Date: Sun, 19 Oct 2025 11:55:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: dw-rockchip: Simplify regulator setup with
 devm_regulator_get_enable_optional()
Message-ID: <4fqtxx5isbvyypgjzjczm4mxqhawsmcalap5bvkohgpeqxnyar@uy5bo2yb4lwy>
References: <20250905112736.6401-1-linux.amoon@gmail.com>
 <CANAwSgSYvTJ=8hv_BrrF1v7u3hq5AB_BSfT7wj0-LQF87dQMUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgSYvTJ=8hv_BrrF1v7u3hq5AB_BSfT7wj0-LQF87dQMUQ@mail.gmail.com>

On Sat, Oct 18, 2025 at 11:21:49AM +0530, Anand Moon wrote:
> Hi All,
> 
> On Fri, 5 Sept 2025 at 16:57, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Replace manual get/enable logic with devm_regulator_get_enable_optional()
> > to reduce boilerplate and improve error handling. This devm helper ensures
> > the regulator is enabled during probe and automatically disabled on driver
> > removal. Dropping the vpcie3v3 struct member eliminates redundant state
> > tracking, resulting in cleaner and more maintainable code.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 23 +++++--------------
> >  1 file changed, 6 insertions(+), 17 deletions(-)
> >
> If we compile the kernel with phy and regulator as modules,
> I observe this message.
> 
> [   25.473960][   T55] platform 3c0800000.pcie: deferred probe
> pending: platform: supplier regulator-vcc3v3-pcie not ready
> [   25.474071][   T55] platform fe0a0000.hdmi: deferred probe pending:
> platform: wait for supplier /i2c@fdd40000/pmic@20/regulators/LDO_REG9
> [   25.474124][   T55] platform regulator-vcc5v0-usb-otg: deferred
> probe pending: reg-fixed-voltage: can't get GPIO
> [   25.474171][   T55] platform fdc20000.syscon:io-domains: deferred
> probe pending: platform: wait for supplier
> /i2c@fdd40000/pmic@20/regulators/SWITCH_REG1
> [   25.474218][   T55] platform cpufreq-dt: deferred probe pending:
> (reason unknown)
> [   25.474264][   T55] platform regulator-vcc3v3-pcie: deferred probe
> pending: reg-fixed-voltage: can't get GPIO
> [   25.474343][   T55] rockchip-pm-domain
> fdd90000.power-management:power-controller: Timed out. Forcing
> sync_state()
> [   37.744968][ T2415] psi: inconsistent task state!
> task=2280:(udev-worker) cpu=1 psi_flags=4 clear=0 set=4
> [   37.849725][   T50] fan53555-regulator 3-001c: FAN53555 Option[12]
> Rev[15] Detected!
> [   37.990008][ T2216] SCSI subsystem initialized
> 

This is a deferred probe log and not related to this patch or the PCIe
controller driver. The controller drivers should still be functional once the
dependent GPIO driver is probed.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


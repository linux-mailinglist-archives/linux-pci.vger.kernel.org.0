Return-Path: <linux-pci+bounces-22364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1789FA4484B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10553AC5E1
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718DD194C75;
	Tue, 25 Feb 2025 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYDMB0u+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D71946A2;
	Tue, 25 Feb 2025 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504059; cv=none; b=r6WSjPIfJ7cjRRuBgwSCIROyVKp50vsDAhPefjVSRgjZOmA2RI7CbiLbHNJQ5qXhhkpla1pezINeLimOMI8IpYv8MxKmgd7Es7jw4kTNpMhLcag6Oox1ZJvK1cmlx6cuuT/6F92k7vnFL6oYuM0x+cguaFI2gr9cdZS/IdXdDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504059; c=relaxed/simple;
	bh=czI6Fd5JF1+j/TyJHZ73NP2GGsj/fEGgSJ8IOHpG/o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAUgGJLt7nsy0WDyKM7vEkyavLpKE/iwov5DD0QJDvvYyXV/CZmaipo6AVD9MOsbpzvgUb/O1F+FSg0ZbW8PLmYkx2wmljPVl6gq6RYdSk6S4yabPXsGYUofP973PcsPol3C89I+JxjlW/aIUyLFa5EDPk8HDAqYo1fHbXdzYRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYDMB0u+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6766FC4CEDD;
	Tue, 25 Feb 2025 17:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740504058;
	bh=czI6Fd5JF1+j/TyJHZ73NP2GGsj/fEGgSJ8IOHpG/o8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UYDMB0u+LW72BguO3XmUKi317GgaTHspr8I+DQSlZ7ccCFo/RjOOaxUPb/DIgIzA6
	 PsB4RMn3ilTLpkTeipYPmQm6f2mpBcSyKuygmPSADhcO2V+Pxt6lfsDu6P9cnJR+tV
	 u3LdBCfIeDXhTLEfOrQxoIANjq6aP2Kw/9I9UmMfJaF6YJbYrsgblZ0Zd/gtlCdoYN
	 gnaI+RpJ5nKJwRhHDmzoubwT/q7oDDBV+C7OjP73w7CoVGCaS1MewVyVIFy1+UO3Ov
	 b6NAfBVhXj7e0ELJMCJZYBuAYUB1UWRywe0Xwlo2Ebs4ogM+6OzXezqM3hPCeEfkLv
	 BVRT0QjslbwzQ==
Date: Tue, 25 Feb 2025 11:20:56 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, heiko@sntech.de,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Simon Xue <xxm@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-rockchip@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: PCI: dw: rockchip: Add rk3576 support
Message-ID: <174050405630.2722665.6173973387821461837.robh@kernel.org>
References: <20250225102611.2096462-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225102611.2096462-1-kever.yang@rock-chips.com>


On Tue, 25 Feb 2025 18:26:10 +0800, Kever Yang wrote:
> rk3576 is using DWC PCIe controller, with msi interrupt directly to GIC
> instead of using GIC ITS, so
> - no ITS support is required and the 'msi-map' is not required,
> - a new 'msi' interrupt is needed.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> 
> Changes in v7:
> - Move the rk3576 device specific schema out of common.yaml
> 
> Changes in v6:
> - Fix make dt_binding_check and make CHECK_DTBS=y
> 
> Changes in v5:
> - Add constraints per device for interrupt-names due to the interrupt is
> different from rk3588.
> 
> Changes in v4:
> - Fix wrong indentation in dt_binding_check report by Rob
> 
> Changes in v3:
> - Fix dtb check broken on rk3588
> - Update commit message
> 
> Changes in v2:
> - remove required 'msi-map'
> - add interrupt name 'msi'
> 
>  .../bindings/pci/rockchip-dw-pcie-common.yaml | 10 +++-
>  .../bindings/pci/rockchip-dw-pcie.yaml        | 55 +++++++++++++++++--
>  2 files changed, 57 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



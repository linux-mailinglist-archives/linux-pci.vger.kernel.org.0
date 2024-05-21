Return-Path: <linux-pci+bounces-7729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA758CB4CD
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 22:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851CF1F21AE1
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 20:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750461487CE;
	Tue, 21 May 2024 20:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li6hJMQb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B453816;
	Tue, 21 May 2024 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324189; cv=none; b=WTvfGTccwF8EF21qfv8MmL/9lpRTa91PmKsiOaxioDneDxs+uDnyyRk+eGqLwQ0IfgRj+A7xU7wUVJtMsCKhfB8pnwKu/cErDedaNjUNmIoOjr6Dsx9tb54SchVk2WngCKWYiVuaXf3ANHMkmXf+gjshCyDqk9iEPSMPdPoxQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324189; c=relaxed/simple;
	bh=u0/sWcPwXuz9mgx00NMaeZhDHXqwGJKGbChwT6UjuG4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GE74IKs+VJ5dFKa2869EqZ2fhfwiBpHwF5CoHSL8nYPoJRvrLP73FUOJxKEtkI8s3EcVWY9ZEtRoX1pkslbBu890f/zGOQhSVAdoXZwVFzR6ENyLOooTEbBUtpB3KjVcmnl0Tow/eMlni51JK64O6drT57XhwT/UfgMEW5kcVio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li6hJMQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834E9C2BD11;
	Tue, 21 May 2024 20:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716324188;
	bh=u0/sWcPwXuz9mgx00NMaeZhDHXqwGJKGbChwT6UjuG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Li6hJMQbTrMgHsg42pYS8smfFsSbtFfS9jgMyV9jthdaRQnxkJn434yZjyLek+Aeh
	 uA4w8YkD2zsjydT71t3hxPM8joM4bSLO0P783vytA3+yvJ6LE4cCq/qYTqcYJRTiKj
	 FWlD+RipLYy/nfIMomXqoCUqdcwkxKBQkVSr2lr4NHA/NH5A2VgfpIdevXE/lyWpZR
	 xPCBr9P/uNlmR1aV4mnV6WwC20ULoQzcCkKT4D4nr0ysBsvYE7YMvTA7DJwgRUvQ6k
	 LIaSXIsplmceTaUMeVY2FvhtjixK9xm95WZWuMCynMyV56nP6EwVeJpbv2rDlL/40F
	 Y3PHOmHg8dyjg==
Date: Tue, 21 May 2024 15:43:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH v16 19/22] dt-bindings: PCI: Add StarFive JH7110 PCIe
 controller
Message-ID: <20240521204306.GA48525@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328091835.14797-20-minda.chen@starfivetech.com>

On Thu, Mar 28, 2024 at 05:18:32PM +0800, Minda Chen wrote:
> Add StarFive JH7110 SoC PCIe controller dt-bindings. JH7110 using PLDA
> XpressRICH PCIe host controller IP.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

This really should have a Signed-off-by or an Acked-by from Kevin.

> +PCIE DRIVER FOR STARFIVE JH71x0
> +M:	Kevin Xie <kevin.xie@starfivetech.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml


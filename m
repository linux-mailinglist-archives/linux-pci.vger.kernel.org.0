Return-Path: <linux-pci+bounces-16245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF3F9C0968
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 15:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654641F244BB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B645212181;
	Thu,  7 Nov 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUKjHHmn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F029F1DFDB8;
	Thu,  7 Nov 2024 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991439; cv=none; b=PJyAWfL4d0TvaSt0ctNuQNPMiafNGlxJTTZPtRd759cuSaUxGlXclwEs6zdPVtUqjEQdU1uBX8jfQfp254MT6AkmFsQyUUHsXHgm2ylAi09F29nSQql3fSvKRezfUFOCq/RCdH1aiJysb4kEv01eKCRzJ2aHXog4hrZ+DkrU+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991439; c=relaxed/simple;
	bh=C9KmSDR5KFc0giels4Al9MLQh0c4mvvugPsBEyIlPMc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SpXhsujsiO+k5KWM5nnmIvyba4h16mNKnmS5S0L5PhjL8tl8M1VI3EzOu6geX5H8ZhMgjX3zNvQ97dLnd25W32hgmr5PJBmmaI1Cf7g+E4lOl305+stxRBlxA/+XKe1Y3VINn1SSIc5JwB6WHCcb2F31wVcKfVFmhek1jCcHvyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUKjHHmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446C9C4CECC;
	Thu,  7 Nov 2024 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730991438;
	bh=C9KmSDR5KFc0giels4Al9MLQh0c4mvvugPsBEyIlPMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nUKjHHmnRqq4bsnJZ+OZuFrB9YXvC6X4M5misHrpPT1KzbLdS5E4/MVzrNxOkCJV6
	 I2rbgYr86mPtqiO0a1lrHhXuM2ewfE48sz2vOaMGawmaIK1eTa7uBoXQzs2J69gPdS
	 wCXAA/t6HurHqQpmnUvMjzytKtu4ZZn/d2/eU4nJ3nyc4aWJwPsl+0tuoshvxECg77
	 Ptqrj0ON5PC8Cc14u0bbyJeuvq3JBG8EdqeAu1I038TXCm+DGkTUtTaOVXNNsDyGXK
	 0Ua807riaRFvirBS6h+ZWu6YQvkuDwwbncZLaoAxl9nykMT3L1j8ebFBrLbWNbipgG
	 rvnAqAZbPUiHA==
Date: Thu, 7 Nov 2024 08:57:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-pci@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 0/2] PCI: microchip: support using either instance 1
 or 2
Message-ID: <20241107145715.GA1613568@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107-aqueduct-petroleum-c002480ba291@spud>

On Thu, Nov 07, 2024 at 10:59:33AM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The current driver and binding for PolarFire SoC's PCI controller assume
> that the root port instance in use is instance 1. The second reg
> property constitutes the region encompassing both "control" and "bridge"
> registers for both instances. In the driver, a fixed offset is applied to
> find the base addresses for instance 1's "control" and "bridge"
> registers. The BeagleV Fire uses root port instance 2, so something must
> be done so that software can differentiate. This series splits the
> second reg property in two, with dedicated "control" and "bridge"
> entries so that either instance can be used.
> 
> Cheers,
> Conor.
> 
> v6:
> - rework commit messages to use Bjorn's preferred "root port" and "root
>   complex" wording
> 
> v5:
> - rebase on top of 6.11-rc1, which brought about a lot of driver change
>   due to the plda common driver creation - although little actually
>   changed in terms of the lines edited in this patch.
> 
> v4:
> - fix a cocci warning reported off list about an inconsistent variable
>   used between IS_ERR() and PTR_ERR() calls.
> 
> v3:
> - rename a variable in probe s/axi/apb/
> 
> v2:
> - try the new reg format before the old one to avoid warnings in the
>   good case
> - reword $subject for 2/2
> 
> CC: Daire McNamara <daire.mcnamara@microchip.com>
> CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
> CC: Krzysztof Wilczyński <kw@linux.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: linux-pci@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> 
> Conor Dooley (2):
>   dt-bindings: PCI: microchip,pcie-host: fix reg properties
>   PCI: microchip: rework reg region handing to support using either root
>     port 1 or 2
> 
>  .../bindings/pci/microchip,pcie-host.yaml     |  11 +-
>  .../pci/plda,xpressrich3-axi-common.yaml      |  14 ++-
>  .../bindings/pci/starfive,jh7110-pcie.yaml    |   7 ++
>  .../pci/controller/plda/pcie-microchip-host.c | 116 +++++++++---------
>  4 files changed, 87 insertions(+), 61 deletions(-)

Thanks!  The patches themselves are unchanged between v5 and v6.  I
replaced the v5 patches on pci/controller/microchip with these.

I also capitalized "Root Port" and "Root Complex" to give a hint that
they are proper nouns defined by the PCIe spec.


Return-Path: <linux-pci+bounces-22055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E41E9A403D5
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 01:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE419C8274
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 00:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BFE3FD4;
	Sat, 22 Feb 2025 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdNT/KjS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F7C2F44
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740182432; cv=none; b=cgdC3Qvw09ZqeZE9qLrsDjvWvmV5FhPzKpncJRFZ8Y5AnNsOyyzX49KUsI7m4hFJofy//ddSn5Yaq0aofa76CAV9DCFPVChz4fzWHGJR8PxqApS8Eobdxg/6YswNgwqaLTKvxxiYHkFvo3QZ4UcjlW7lt2UyMskGrAIJZbm5e9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740182432; c=relaxed/simple;
	bh=IaOPCrH3kw57a9AP/P15cOXKdwI6oMqM5L5tl5C6SV0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ae/UUTJPrDEgBdxj5tNRAr0MrQeBmHb1ijhEf99Wnp9qWcVdhiCLYTC+qASnTFA0EVjUWeFdCGLKXyLvZVI7SGsXMMMTqcPutRCS0X9pyaamvNkiPo3DkydoATZdJR2m8fQ/xTmufl5BF199tK2TnV1VFU84dDiudXaNE6qVx4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdNT/KjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A97C4CED6;
	Sat, 22 Feb 2025 00:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740182431;
	bh=IaOPCrH3kw57a9AP/P15cOXKdwI6oMqM5L5tl5C6SV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YdNT/KjSojaK2abE6rwyi+ctzkbBJ2TWp3tMtGCwMJH3FcdT4TgNwiMQ9SodstG8l
	 TgNed1ktruibdiLre7E481mfQsMmowjwPIgogVtq2rbWVCWB4B/cfYN/kYryIhSzjp
	 4cchOH+1fNZtfVDPVNs69hhUnolEbEW+Q1mxineVn5L2w44CNWyl1G61AOmyPG6q3Z
	 Sbt9z0I2Hihntk7vsbgdtFMzIPrvUYYckp0CJ9+A4ljinEOGOqh5wfk3G8/1DC1VMs
	 6YqH8QjgH7vuLxaNpVYgmb+ZdqC27cykI3MgJQvfNzb2lcrTSR8M8rx2PQWsiI2O8a
	 Bxkfe8BLpcRsw==
Date: Fri, 21 Feb 2025 18:00:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: dw-rockchip: hide broken ATS capability
Message-ID: <20250222000029.GA373377@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221202646.395252-4-cassel@kernel.org>

On Fri, Feb 21, 2025 at 09:26:48PM +0100, Niklas Cassel wrote:
> When running the rk3588 in endpoint mode, with an Intel host with IOMMU
> enabled, the host side prints:
> DMAR: VT-d detected Invalidation Time-out Error: SID 0
> 
> When running the rk3588 in endpoint mode, with an AMD host with IOMMU
> enabled, the host side prints:
> iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=63:00.0 address=0x42b5b01a0]

Maybe add a blank line and indent the message since it's quoted
material?  E.g.,

  When running the rk3588 in endpoint mode, with an Intel IOMMU, the
  host side prints:

    DMAR: VT-d detected Invalidation Time-out Error: SID 0

  When running the rk3588 in endpoint mode, with an AMD ...

    iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=63:00.0 address=0x42b5b01a0]

Too bad DMAR isn't smart enough to include a device ID in its message ;)

Can you include something here about what the issue is?  Based on the
subject line and the patch, I assume something is wrong with the ATS
Capability?  I guess this is some kind of rk3588 defect, right?

> Usually, to handle these issues, we add a quirk for the PCI vendor and
> device ID in drivers/pci/quirks.c with quirk_no_ats(). That is because
> we cannot usually modify the capabilities on the EP side.
> 
> In this case, we can modify the capabilties on the EP side. Thus, hide the
> broken ATS capability on rk3588 when running in EP mode. That way,
> we don't need any quirk on the host side, and we see no errors on the host
> side, and we can run pci_endpoint_test successfully, with the IOMMU
> enabled on the host side.

s/capabilties/capabilities/

Bjorn


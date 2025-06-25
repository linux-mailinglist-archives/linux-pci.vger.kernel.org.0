Return-Path: <linux-pci+bounces-30595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EA1AE7B80
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 11:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BD41666E8
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 09:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FF227F183;
	Wed, 25 Jun 2025 09:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pud0sBrz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FFF270554;
	Wed, 25 Jun 2025 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842406; cv=none; b=o6grH8MHVextC9qQ/t5XI70gzy9JMn7R4s/7pvTnvMRgUL0nqJtpSpFiemAeU/0pMSaJ4AvdJgRb5QVienSVqtrNgtmnROAfiLSBsODtnXaFol5rpyQeocpFPHM3OEFICkQsGnyEImxNcZ2wbjZOMEzYTj8w8dIyZ4jsUL7/Ebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842406; c=relaxed/simple;
	bh=5X5q++377SBr2aeIbyVxNciPfwLkYCFZEZKG7Vm2QAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hs2w9S4JpPbApfr0br8DIWwVsvstzWYV0HIr6hE4tgLorkoe9RrMbXT8H59ccQKN+Zbav+hb88yo7pVGM701oWfMwm8WCXSVnWSzjlkwK5UC96kVs3wtT8NrhjkB40IoKjb1QPId6zKOys0phzEkw44CoM42aUZx27FkmZHk5M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pud0sBrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878ADC4CEEA;
	Wed, 25 Jun 2025 09:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750842405;
	bh=5X5q++377SBr2aeIbyVxNciPfwLkYCFZEZKG7Vm2QAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pud0sBrzfrNAo6/C+4yjG9NxkZGGpdgPcbE4pUDAV7GKaWdhcX4z4SNj2tcCxgFIg
	 HTe8hVrWrUOwC5m8HkY4Q4GdahmKlhPoNMDISegqI5lDkt8UaTNUeA5l/9Tq2nKbhM
	 aYwWXYweotACP8YDrszz2oHNie044/11YKuWxM5I0/n6xAEca+Txz+dW63Ybb23fak
	 cSs/ABqHAXaNTWuyqPemTBYXZKwxNhH6bGft3LQOyoyTuU84/LZYC8j9UxWqqY7D2l
	 V+eYxNySqCvw1VQib03tpnrsgREGKLGgNwPuYB2YguKPHwG/iCIxMVBHnpwEeaf5bL
	 A2BATULAhBhOw==
Date: Wed, 25 Jun 2025 11:06:40 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 4/6] PCI: qcom: Wait PCIE_RESET_CONFIG_WAIT_MS after
 link-up IRQ
Message-ID: <aFu8IOsQX66mfveW@ryzen>
References: <20250613124839.2197945-8-cassel@kernel.org>
 <20250613124839.2197945-12-cassel@kernel.org>
 <ebrnndrw7kifuyixh4umos6ozhg3a45ya2ooxrf44xytdpiczs@qtd2l4tc63kt>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebrnndrw7kifuyixh4umos6ozhg3a45ya2ooxrf44xytdpiczs@qtd2l4tc63kt>

On Mon, Jun 23, 2025 at 08:27:19AM -0600, Manivannan Sadhasivam wrote:
> On Fri, Jun 13, 2025 at 02:48:43PM +0200, Niklas Cassel wrote:
> > Per PCIe r6.0, sec 6.6.1, software must generally wait a minimum of
> > 100ms (PCIE_RESET_CONFIG_WAIT_MS) after Link training completes before
> > sending a Configuration Request.
> > 
> > Prior to 36971d6c5a9a ("PCI: qcom: Don't wait for link if we can detect
> > Link Up"), qcom used dw_pcie_wait_for_link(), which waited between 0
> > and 90ms after the link came up before we enumerate the bus, and this
> > was apparently enough for most devices.
> > 
> > After 36971d6c5a9a, qcom_pcie_global_irq_thread() started enumeration
> > immediately when handling the link-up IRQ, and devices (e.g., Laszlo
> > Fiat's PLEXTOR PX-256M8PeGN NVMe SSD) may not be ready to handle config
> > requests yet.
> > 
> > Delay PCIE_RESET_CONFIG_WAIT_MS after the link-up IRQ before starting
> > enumeration.
> > 
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
> 
> Shouldn't 36971d6c5a9a be the fixes commit?

See Bjorn's comment:
https://lore.kernel.org/linux-pci/20250611211456.GA869983@bhelgaas/

	I would argue that 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip
	RK356X host controller driver") is the right Fixes: commit here
	because dw_pcie_wait_for_link() *never* waited the required time, and
	it's quite possible that other devices don't work correctly.  The
	delay was about 90ms - <time required for link training>, so could be
	significantly less than 100ms.


Thus, following Bjorn's comment, to put the commit that introduced the driver
as the Fixes tag for dw-rockchip, I did the same thing for qcom.


Kind regards,
Niklas


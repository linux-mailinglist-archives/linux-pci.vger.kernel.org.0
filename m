Return-Path: <linux-pci+bounces-28517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F145AC741B
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 00:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0960188B56E
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 22:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA531F151C;
	Wed, 28 May 2025 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTS9s/t9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A070A55;
	Wed, 28 May 2025 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748471702; cv=none; b=OqngqMPzOQ+zl72dfp9NX+TvKbRYntoKtRmNWNlervrFOFUMAT2kF+5O+R9vgh0bWuBhsMOuYeEEPNaqJubzFvIjoLEdBt/exowJd0f0M9yM2Wa0MsIm6uofKjvtculhi2MrzW5oQbF1xlw3chCKW0F90fPith0ELU3tmXnqws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748471702; c=relaxed/simple;
	bh=G/c8gLq1UOYM2sneyafsU62G5RMVALyJq3J1BkyGhfo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=u/cB3Z8gpMZ4RDNK5sOUbmDCO+qhj2UVJbtYQUJvHT94ocApuyQnCN6dsnQPBjPMc9CwzBik7JdVeedCIK09lWXRUtYFu1SXWTzv8NpfkUsbFdh4KatJHOpsfEaP6boQw54bqrvj8g+1LTISFH4wxtlc9ID7DtJr81dC3rk+d6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTS9s/t9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D324BC4CEE3;
	Wed, 28 May 2025 22:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748471702;
	bh=G/c8gLq1UOYM2sneyafsU62G5RMVALyJq3J1BkyGhfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UTS9s/t9dgzKMS69c26wtss9wbJFXwAdQVw0jYJpOf0PidV1XhhRUQYejNZvNZdlK
	 HeaIovN6Mcj2OQMfrCvy3nHZrJrKlYoKMHhozxBCRXO8C2PhsjzmArrHbPBRrQnubZ
	 rbVClPpcjpNZxQizn8W3Oj6piVhPORsVI/wlef5kpq/P8Pa3WG+04h5IpWKDjZoVwE
	 GZMsZWYRvz9BSd632glvDalgHlYLaT8RWlFn28UaTSo+X94gm1rnSbuZbCr35yZU1Z
	 ZIn0WY7wkryHte585r5iTZnOJtzoeUXqrXA8Uuh3K/axLPciB5TsR3Y2bqeFzN+WDx
	 SYwfxPGqcuwUA==
Date: Wed, 28 May 2025 17:35:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
	Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Marc Zyngier <maz@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>, dingwei@marvell.com,
	cassel@kernel.org, Lukas Wunner <lukas@wunner.de>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 4/5] PCI: host-common: Add link down handling for host
 bridges
Message-ID: <20250528223500.GA58129@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508-pcie-reset-slot-v4-4-7050093e2b50@linaro.org>

On Thu, May 08, 2025 at 12:40:33PM +0530, Manivannan Sadhasivam wrote:
> The PCI link, when down, needs to be recovered to bring it back. But that
> cannot be done in a generic way as link recovery procedure is specific to
> host bridges. So add a new API pci_host_handle_link_down() that could be
> called by the host bridge drivers when the link goes down.
> 
> The API will iterate through all the slots and calls the pcie_do_recovery()
> function with 'pci_channel_io_frozen' as the state. This will result in the
> execution of the AER Fatal error handling code. Since the link down
> recovery is pretty much the same as AER Fatal error handling,
> pcie_do_recovery() helper is reused here. First the AER error_detected
> callback will be triggered for the bridge and the downstream devices. Then,
> pci_host_reset_slot() will be called for the slot, which will reset the
> slot using 'reset_slot' callback to recover the link. Once that's done,
> resume message will be broadcasted to the bridge and the downstream devices
> indicating successful link recovery.

Link down is an event for a single Root Port.  Why would we iterate
through all the Root Ports if the link went down for one of them?


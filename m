Return-Path: <linux-pci+bounces-27772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8442FAB7F2E
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 09:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAE886021E
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 07:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080B52797A1;
	Thu, 15 May 2025 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beyqb5CK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D439D2153C1;
	Thu, 15 May 2025 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747295411; cv=none; b=qZk6dF1MeexEbxSSoCgMkkctuydOxDK/oZteKGuWJWNJtOABHuC4hjz1y8VVNhmi0EiWdumpTthkXctq25jI7KmACauol6O1UDvgS2ivYHJp3ORZxLrdzJCJAzX6ue1HKwg0K+pBAYtnTq1atrzeVLCgqexPGyaME7cZC6q1nr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747295411; c=relaxed/simple;
	bh=okgZ71SlRI1OxrfenXbRvEK2OBzl9XmUUegqvv09zLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+EJGbE3d5pqE8AtaTLk77TJVNFJxWKTJJFWY6BH1ReZgdr8FXlS/5cr47XIxlKyAhEcvaq/6ctR9nXbi78ZLdXiPjq3e0vSxeXInQY+T/Tx2YjdP5ynLzu+tFWSDIjAg8e/6E/NKKdfGuyJg15xg2Ge7ExJCuM1rHv03cQl0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beyqb5CK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC89C4CEE7;
	Thu, 15 May 2025 07:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747295411;
	bh=okgZ71SlRI1OxrfenXbRvEK2OBzl9XmUUegqvv09zLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=beyqb5CK1kmn8uzdSGNFRMhole3qboOUioWcddIYpIVpMkPSCd8EO5j1L8+MpL7Pp
	 +Uxo/BtuRu1DSchP0I71oAf1NaAeChogZTdHmYDUsBAO8f3fOMoYWEf3YDQ1We6cpl
	 9PReyas9Ctyhj0HeQdyMX5ZQQZJKg4EKs8c3CDk4o9fNsJL9rmOndQW4EETTAQQ4il
	 oIpdtgilsh/OkjLx/9tQ5fjMMdz5K+oTpWlzG7wEZnZQycyoA0rjQ/LPHsMRS8MNsX
	 OCD8JsxlFnuPXRXzCz2lazIS5Zt+TiB2OdsoXjV5q1dpwIHekKD0BzK+DCbpB43a4y
	 HAU9Fob+RO6RA==
Date: Thu, 15 May 2025 09:50:05 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alistair Francis <alistair@alistair23.me>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Add support for slot reset on link
 down event
Message-ID: <aCWcrf4V3p7cxcpi@ryzen>
References: <20250509-b4-pci_dwc_reset_support-v3-1-37e96b4692e7@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-b4-pci_dwc_reset_support-v3-1-37e96b4692e7@wdc.com>

On Fri, May 09, 2025 at 12:30:12PM +1000, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> The PCIe link may go down in cases like firmware crashes or unstable
> connections. When this occurs, the PCIe slot must be reset to restore
> functionality. However, the current driver lacks link down handling,
> forcing users to reboot the system to recover.
> 
> This patch implements the `reset_slot` callback for link down handling
> for DWC PCIe host controller. In which, the RC is reset, reconfigured
> and link training initiated to recover from the link down event.
> 
> This patch by extension fixes issues with sysfs initiated bus resets.
> In that, currently, when a sysfs initiated bus reset is issued, the
> endpoint device is non-functional after (may link up with downgraded link
> status). With this patch adding support for link down recovery, a sysfs
> initiated bus reset works as intended. Testing conducted on a ROCK5B board
> with an M.2 NVMe drive.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
> base-commit: 08733088b566b58283f0f12fb73f5db6a9a9de30
> change-id: 20250430-b4-pci_dwc_reset_support-d720dbafb7ea
> prerequisite-change-id: 20250404-pcie-reset-slot-730bfa71a202:v4
> prerequisite-patch-id: 2dad85eb26838d89569b12c19d70f392fa592667
> prerequisite-patch-id: 6238a682bd8e9476e5911b7a59263c3fc618d63e
> prerequisite-patch-id: 37cab00bc255a62b1e8396a48a3afba5e1751abd
> prerequisite-patch-id: ff711f65cf9926374646b76cd38bdd823d576764
> prerequisite-patch-id: 1654cca919d024b9a9190b28e90f722975c797e8

Now when all the prerequisite-patches have been merged to the
pci/slot-reset branch, any chance of getting this patch queued
up on pci/slot-reset branch as well?


Kind regards,
Niklas


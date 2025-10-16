Return-Path: <linux-pci+bounces-38377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAC7BE4AB3
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 18:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA16484C4B
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 16:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C51133CEA2;
	Thu, 16 Oct 2025 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="uKWAdTtm"
X-Original-To: linux-pci@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82152334364;
	Thu, 16 Oct 2025 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633306; cv=none; b=RnBKYcCsjdawM28fUorS9M2MNZkWudDXHS2A7b+Aj4Gc1oUq8gJhW7NXyW/+PQ35KY8cPbZmrdJ0jMIMxGsEmL/VpoE8bP7DsK7yIaw/calFAhXbtAaNwgl6RLvEsyt2qWxVUQ8XwpGX9LZ/jjHFcZvsta1+2caVZ/QFYVxTrsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633306; c=relaxed/simple;
	bh=LRlOTTisb6TkUzL0G01flnluo4y/x/+wjiCDhWMWloE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goAIhbQ/T0nbbqaFWu0hjtiksu+ulxn5QVcF/y9NbpvlTaemHx87m0w/JERYAY3gMA3OVd3Ga1KraML4DbMijIcFcBeRTU3xlugpBssYNxBQZzdv3Y1KlbV+LvEwip7aLUU5kEQsdBseSOUDF9MiOYRGCD7Tafv5tC0ZFpUNlvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=uKWAdTtm; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=9gkcy8583TeLV+YV4+SJjwY1l2WxECBbWEM4z0wYrI4=; b=uKWAdTtm22MCASRx16KB/LNFAI
	y9lpVvkGpyXHDK1VhdEMRj0gfNoBJ4SNB6t0Gm+tuBq1gJUba/367H91NN0eHs9zW9goPY5pfxTTE
	d3hAMWFzXA60K6GKe1hoFlgwewXfReNTkCr9/m4hC7x/zV8+govNCNdzkrMMilDhQYjIzc8or2AgU
	AR05K4SNxWhpQy2BhetpTnmHDD94HWownXfaH3SYXkhnQEmoRxzCURvoMsudoAS0dCEpLo4QbHiVj
	My+V5THMgMACXr/HcPNS8MI3Mh2xRRQHvORUdYxOwbQwKBr8ta4FnOQcqLJv39m2cLuYYk3vseIg7
	IyEqeKNw==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v9R8v-0098Vp-05;
	Thu, 16 Oct 2025 18:47:57 +0200
Date: Thu, 16 Oct 2025 18:47:56 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	dlan@gentoo.org, guodong@riscstar.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, christian.bruel@foss.st.com,
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com, namcao@linutronix.de,
	thippeswamy.havalige@amd.com, inochiama@gmail.com,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Introduce SpacemiT K1 PCIe phy and host controller
Message-ID: <aPEhvFD8TzVtqE2n@aurel32.net>
Mail-Followup-To: Alex Elder <elder@riscstar.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	christian.bruel@foss.st.com, shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
	namcao@linutronix.de, thippeswamy.havalige@amd.com,
	inochiama@gmail.com, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
References: <20251013153526.2276556-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013153526.2276556-1-elder@riscstar.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi Alex,

On 2025-10-13 10:35, Alex Elder wrote:
> This series introduces a PHY driver and a PCIe driver to support PCIe
> on the SpacemiT K1 SoC.  The PCIe implementation is derived from a
> Synopsys DesignWare PCIe IP.  The PHY driver supports one combination
> PCIe/USB PHY as well as two PCIe-only PHYs.  The combo PHY port uses
> one PCIe lane, and the other two ports each have two lanes.  All PCIe
> ports operate at 5 GT/second.
> 
> The PCIe PHYs must be configured using a value that can only be
> determined using the combo PHY, operating in PCIe mode.  To allow
> that PHY to be used for USB, the calibration step is performed by
> the PHY driver automatically at probe time.  Once this step is done,
> the PHY can be used for either PCIe or USB.
> 
> Version 2 of this series incorporates suggestions made during the
> review of version 1.  Specific highlights are detailed below.

With the issues mentioned in patch 4 fixed, this patchset works fine for 
me. That said I had to disable ASPM by passing pcie_aspm=off on the 
command line, as it is now enabled by default since 6.18-rc1 [1]. At 
this stage, I am not sure if it is an issue with my NVME drive or an 
issue with the controller.

Regards
Aurelien

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f3ac2ff14834a0aa056ee3ae0e4b8c641c579961

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net


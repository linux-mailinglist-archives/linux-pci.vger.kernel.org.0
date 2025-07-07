Return-Path: <linux-pci+bounces-31596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F371AFAC09
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 08:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBAB91781F7
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 06:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF04D27A10D;
	Mon,  7 Jul 2025 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="FyAGP6pq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34904824A3
	for <linux-pci@vger.kernel.org>; Mon,  7 Jul 2025 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751870527; cv=none; b=uO9dTOOXMFB++bSt91VgQKFRWwAPGEwGn61QwiOBk+pCVF6WwbIuWo0Bn9OJdizWrLFWnHMFBRofVxZG8VIgDV+A3QKJUX4+hrm7XkEdbxr4IFdVvgtgdgFtVrihyaRFUAfAvocJBvbVOBTMcnvO3/SHiAK2qBiHs2JF3eTDSjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751870527; c=relaxed/simple;
	bh=IiLGpE2uyMrqtwvy9R1BT98d8U7KS311154swWkBZBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ph+HBw9CG0l4YABDiHMSCXQ23VABfd2lICqT0YvXCfn+q0VIpPTp0pDwpzDgAvaTMYrzHuROfhmimVZbqdl/M2weUd17RftN4E0/mV2OH5N746hJN7j85/4bpNmzL3+gL81IJsYFNe5wxP7ixYP2mQc2oW3ojYD4aHUH5IG9PaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=FyAGP6pq; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=IiLG
	pE2uyMrqtwvy9R1BT98d8U7KS311154swWkBZBE=; b=FyAGP6pqhTWS7vDw7fmX
	dh2+VKzogPqkT8l7OQ1SW8LDBGl0c9nIu6jysu18SXB9FsJPMPzaJW8ZSogJ5CAt
	tsVx1qQ+muSk3FGUEJ6A3+jI1vwzUI3S2cI4aSzKrP64vLyAZcnl90oQKOcNHJ/D
	I2DWu8fyMtmzt44cX/vikJV29JXkajR/DGpWjWOdbYnuwqJjj1TXF7gK2SLSG0DM
	mwQ1DwVrlk4iW4W5qmJHxyacHR9cCLsY/PftOZoEqrtRZ/ngo+MwF/m53uNEni/2
	ADhtJUZKvOLguYSRG2ejY+PvgRo3kGuxXRBXRTCa/78msA45BA0exJJV63W1F6lf
	zA==
Received: (qmail 1127800 invoked from network); 7 Jul 2025 08:41:55 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Jul 2025 08:41:55 +0200
X-UD-Smtp-Session: l3s3148p1@I6XGI1E5huogAwDPXxVOAFK6vZd9m4LR
Date: Mon, 7 Jul 2025 08:41:55 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	catalin.marinas@arm.com, will@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de, lizhi.hou@amd.com,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3 0/9] PCI: rzg3s-host: Add PCIe driver for Renesas
 RZ/G3S SoC
Message-ID: <aGtsM22QYqekuiQA@shikoro>
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>


> Please provide your feedback.

What is this based on? I tried v6.16-rc4 and renesas-driver/master. Or
is there a branch I could pull?



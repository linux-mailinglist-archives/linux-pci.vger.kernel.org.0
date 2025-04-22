Return-Path: <linux-pci+bounces-26362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9F6A95E2D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 08:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8702E1899486
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 06:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAA720FAA8;
	Tue, 22 Apr 2025 06:28:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D45230BF2;
	Tue, 22 Apr 2025 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303284; cv=none; b=OCIfZ4eR2PotiERZFlfQOAH8BkXaua4eqfMW5cSQS8KGgqdJkxrXwUYCFIREfM3qR6LMCkO0V5fEJCggJY+g7o6+iPelGuievYPbKkTjFdhxip6u0sia2Su9ZvEOGaNpT4GAw9Q0ZLK4LOhbB21hhvobp9TZVThH5m+W3IE2Pss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303284; c=relaxed/simple;
	bh=b/vwyo75mxMndN1Nz5HnL9ekjjoTmFO3t1a2DFAyEms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TML2sTu4tmiAT6ieLIc+7gR+qkQT3Elm0jlBaR+geBYz1fxqzaq22PrNERD5OMYUJ2hUi6X3OTSfy0VNTXwthUDThKXT2AMV5uH1RYX7Aq7jWSmZWK7cyxfU+eF8CBBrR9yv1cPH+FGIXq2gP7O+wSRaHZx0/LhZkWoXZrXL2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 161B4200A2A3;
	Tue, 22 Apr 2025 08:27:32 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 620411AAC79; Tue, 22 Apr 2025 08:27:52 +0200 (CEST)
Date: Tue, 22 Apr 2025 08:27:52 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: Re: Potential issue with pci_prepare_to_sleep if there's no platform
 support for D3cold transition
Message-ID: <aAc26NTVcXy1BCxU@wunner.de>
References: <62de9027-e4cd-4192-90e8-64f4c4a8fe4b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62de9027-e4cd-4192-90e8-64f4c4a8fe4b@gmail.com>

[cc += Rafael, linux-acpi]

On Mon, Apr 21, 2025 at 10:05:59PM +0200, Heiner Kallweit wrote:
> If there's no platform support for transition to D3cold, then
> pci_set_power_state(dev, D3cold) still returns 0, even though
> power state is transitioned to D3hot only. We called
> pci_enable_wake(dev, D3cold, wakeup) before, therefore PME for
> D3hot may not be enabled. Is this a bug?
> 
> Background:
> In __pci_set_power_state we have the following:
> 
> error = pci_set_low_power_state(dev, PCI_D3hot, locked);
> if (pci_platform_power_transition(dev, PCI_D3cold))
> 	return error;
> 
> The acpi_pci_set_power_state() stub returns -ENODEV.
> Therefore, if error=0,  __pci_set_power_state() will
> return 0 if pci_platform_power_transition() fails.

pci_prepare_to_sleep() calls pci_target_state() right at the top.

If wakeup is supported and enabled, pci_target_state() is supposed
to find the deepest power state supporting wakeup.  If D3cold doesn't
support wakeup, D3hot or a shallower state is returned.

Hence I don't quite understand how the scenario you're describing
could occur in practice.  Are you seeing actual issues and have tracked
them down to incorrect handling in pci_prepare_to_sleep()?

Thanks,

Lukas


Return-Path: <linux-pci+bounces-28623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E35AC7CF6
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5278F3A2FC2
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 11:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EDF28E5F9;
	Thu, 29 May 2025 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Efq02rrH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DF621638D;
	Thu, 29 May 2025 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518288; cv=none; b=QvjFxUGKhJUYbxGGFD1jf+KwtX2JkGmBiNQZL0Yq9OGlJolyEh4ra91FlqfJgTPh1z0EEImSAEmbBmSaKa04Rs9jY6TZsa+RscISc1D+GgkQIiY8WE9x4W3TeHIHm/Msx9h7cSHh9kohAfZ6LAJ+dIcuXXkWiAb6V8rTuQS87js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518288; c=relaxed/simple;
	bh=53yuKezs5ilpcnEdLeOi3VA/lnDiQmGthxtSC8SQoCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYWTlh36LYp4M1HzunxGWEdhjYyaWHFxdwELy2o14/wtrL3Jjb8anFB6EUzeVCRwOiEW0/XDOd979ZVID6tzqtSNAAkKtoXaMPWa4ozbrERRPQli8KNDHukKOnWtrTFy27zxleFCgxuEhSYYI0vnqcB+PlVWw57P1uXhJi914eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Efq02rrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1B1C4CEE7;
	Thu, 29 May 2025 11:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748518287;
	bh=53yuKezs5ilpcnEdLeOi3VA/lnDiQmGthxtSC8SQoCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Efq02rrHVKWrTVeTHqrfz4P8aBiP8S5VoeLVafK3DbQUgDAPNznko4YJddWg9VXT8
	 ZG0GufYhF4BKGiQMjpIettK3p4JBRx9X1WLaFf6i0Y07LdqDYALVtbBNWgMty/AbBZ
	 Jk7Ku0MOSK9fgRcyxZKhbBLbc0q0U6NzKCfeCKqE=
Date: Thu, 29 May 2025 13:31:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com, Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v10 0/13] Add support for RaspberryPi RP1 PCI device
 using a DT overlay
Message-ID: <2025052908-goldmine-ramp-b865@gregkh>
References: <cover.1748516814.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748516814.git.andrea.porta@suse.com>

On Thu, May 29, 2025 at 01:23:35PM +0200, Andrea della Porta wrote:
> *** RESENDING PATCHSET SINCE LAST ONE HAS CLOBBERED SEQUENCE NUMBER ***

Then it needs to be a new version, not the same one please.

thanks,

greg k-h


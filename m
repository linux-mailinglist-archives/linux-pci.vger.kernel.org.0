Return-Path: <linux-pci+bounces-18078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42759EBEAB
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 23:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B605D168FAE
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 22:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220201F1932;
	Tue, 10 Dec 2024 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cM/4Vcru"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E745A211260;
	Tue, 10 Dec 2024 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871309; cv=none; b=pM/lDwmKR54Zs28Zq0z0lsHv/vyaM6+K5AUtar0otVHB+tfzyqLcJ0m/HmC82LY/eNZ9tC7czoIpAwIVU0sJpSzeS1oATnBunbR2tXjlmpx61G871NwgxObRqCAtZZjz8UWTKuvwqYAIamjbkBfQaKhJXmGR4e8z7zwS3vdoRw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871309; c=relaxed/simple;
	bh=9J1aa/Yh3HudPCpHSSxjlghwlr0RlKDY/3giY0+oXAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SV29nzA7LIpizlrO+SAWh35PUhzipxD+SiRa0sDeaQQfUZx4fwze9e6nLPY5H5/3dcF/eEHhM6bjfmqw+Wlg84uxhM+cPT4DrA+TL+Hx0rnDo2rKb5ae29hO0BkJXwNP6u5Jy1d8cqtUXQNVEvJPrd4vci43zvjtyos7Ih1qoyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cM/4Vcru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D0CC4CED6;
	Tue, 10 Dec 2024 22:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733871308;
	bh=9J1aa/Yh3HudPCpHSSxjlghwlr0RlKDY/3giY0+oXAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cM/4VcruTmwaKzBl3kR1lSSTuI66cHreDK5675IsNhiplmDizdIGMfZ+nI44JMql5
	 DH3X4ohXX3l/ep1vMlb7vIzPn9+2AU7LUII2O8Se2NtKiyCJXUMiAmF1f8W6U8gp9G
	 FS8MX3tervSTGlzOXNvMVZt1tmwQCVgj3Rd4lZdFtqMVJJalSKAXgKeZpo2fLKXYNX
	 N2znVb6+Nw+vmeaZl+nMgu0owQDAgr+5DaN49jhV8j22NoPIkhmIMTTMofMhYell/e
	 ReYtTk5PNKoBXB+W/Jds/GnthHUuDkwvBz5wTKmYz9yPN9Hnpc/27Rseyz6KRVtDSV
	 lSM7prZIWZ8vQ==
Date: Tue, 10 Dec 2024 16:55:06 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	linux-kernel@vger.kernel.org, Krzysztof Wilczynski <kw@linux.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Will Deacon <will@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-rpi-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
	linux-pci@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v5 04/10] dt-bindings: misc: Add device specific bindings
 for RaspberryPi RP1
Message-ID: <173387130632.752894.7048832305370106368.robh@kernel.org>
References: <cover.1733136811.git.andrea.porta@suse.com>
 <99c23bd584d7b1b998d2cafb7807e0650db73f20.1733136811.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99c23bd584d7b1b998d2cafb7807e0650db73f20.1733136811.git.andrea.porta@suse.com>


On Mon, 02 Dec 2024 12:19:28 +0100, Andrea della Porta wrote:
> The RP1 is a MFD that exposes its peripherals through PCI BARs. This
> schema is intended as minimal support for the clock generator and
> gpio controller peripherals which are accessible through BAR1.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  .../devicetree/bindings/misc/pci1de4,1.yaml   | 73 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



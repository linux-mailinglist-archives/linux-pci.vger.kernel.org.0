Return-Path: <linux-pci+bounces-17269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912C99D79EE
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 03:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69B41626A1
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 02:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448A6DDBE;
	Mon, 25 Nov 2024 02:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJiMbLUh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA864A2D;
	Mon, 25 Nov 2024 02:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732500412; cv=none; b=EOJdeNuFbDGLsQ1on1m5I5TYnBjaxvu8vXCDXD64GnvsGYkjRAjL96FSoUMxQEkKZdM32HHiAFC9Wn28KxY3xlnulTlgjoUY3KzejKFPFwO2kbv/fJffhCQ+3z/6ZLGVpx3HOCjC5YJMA1zvI/R8gdgxm/le9C2hb2UL0hb29XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732500412; c=relaxed/simple;
	bh=fKuuSMNf+Qy6m8ZOXTb7mpNsw2y4fw7IbYodhFF8XTE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=SgLX/6WRvwbPbBVXQEVCyDgq2wkrgUPkqLvP7ie0Uxv72pOgCZ2smStvDumjLV4bLf9jzF9uCPxpjAltcSTFQnsTnxyEfYMrRkx/LtKBiEVisxk5ACQdn7no/RdTFNIYuk4sLR0gSCVOSPRKrubyBeaOf4uxM9i6nQsHcyHJQm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJiMbLUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D4FC4CECC;
	Mon, 25 Nov 2024 02:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732500411;
	bh=fKuuSMNf+Qy6m8ZOXTb7mpNsw2y4fw7IbYodhFF8XTE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=OJiMbLUhe7rNCTkqgTcbf/1gksuekRvIEHdo7FgaTZ5Krjo4kOrZ8wyXNpfOVwwVX
	 HAQdaEjQ5uFHcYXFHWip4rvCEvkuHnSx1c5Mjl26rB4NyCIca8qjK809oIWHmpk56W
	 rPqk8nLn4mQwyoU6T42DPWnRGe9aK3adMADGzOZd5pWEUcl26NvWVcAnjivNmsMCe4
	 QszW4mn4yLRtHkeu4OXCTVXJKeKrdcYfCMGvafMHTH8kbGuOcven9NrIDzgs3kJkve
	 qKzgN0UMzpEMoSRIsbhhTL1LJgBbiCnV7wCHIcC7QaEbISlV3HZqRThvdlL5Jz1UZL
	 24ZiZnnvzNW0A==
Date: Sun, 24 Nov 2024 20:06:49 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Dragan Cvetic <dragan.cvetic@amd.com>, linux-gpio@vger.kernel.org, 
 Herve Codina <herve.codina@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org, 
 Derek Kiernan <derek.kiernan@amd.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
 Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, 
 Andrew Lunn <andrew@lunn.ch>, Saravana Kannan <saravanak@google.com>, 
 devicetree@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>, 
 linux-arm-kernel@lists.infradead.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Krzysztof Wilczynski <kw@linux.com>
To: Andrea della Porta <andrea.porta@suse.com>
In-Reply-To: <ebb21da5cb41391421b364815705be8b4c415f8a.1732444746.git.andrea.porta@suse.com>
References: <cover.1732444746.git.andrea.porta@suse.com>
 <ebb21da5cb41391421b364815705be8b4c415f8a.1732444746.git.andrea.porta@suse.com>
Message-Id: <173250040873.6640.9720381303445148722.robh@kernel.org>
Subject: Re: [PATCH v4 04/10] dt-bindings: misc: Add device specific
 bindings for RaspberryPi RP1


On Sun, 24 Nov 2024 11:51:41 +0100, Andrea della Porta wrote:
> The RP1 is a MFD that exposes its peripherals through PCI BARs. This
> schema is intended as minimal support for the clock generator and
> gpio controller peripherals which are accessible through BAR1.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  .../devicetree/bindings/misc/pci1de4,1.yaml   | 74 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/pci1de4,1.example.dtb: clocks@c040018000: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/clock/raspberrypi,rp1-clocks.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/ebb21da5cb41391421b364815705be8b4c415f8a.1732444746.git.andrea.porta@suse.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.



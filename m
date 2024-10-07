Return-Path: <linux-pci+bounces-13965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA21992EBF
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 16:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5A61C22F88
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36EE1D89F2;
	Mon,  7 Oct 2024 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhRyqdFm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7891D6DA5;
	Mon,  7 Oct 2024 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310610; cv=none; b=rwfu6fHK1jvRAYAlD6Oukol3LPMII4USlqc8eszDWQQdhJd2iKCGwSll4NFhCOtG3TIpzaxH7y48KwBwyIyfwiEhs4CbOuWydXCk3mLISMx52MgTo0B5+uYRsBuoSZaI+Nwz15CSOBg2mhd0lbbYqGIwDeo3zDKn2QCccYO5T+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310610; c=relaxed/simple;
	bh=I7q9lk59AZpbFzZMPAN1WPpVBY6l66csCEEr9J5+l44=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Tz/iNHsU46OgKMsAwH/OLnVq0NRP+zZi8yskN8UplkR9EgC6vU0zCBc8cFql0yDF2MbAq8NJcoiUtK8JGlcWCMKZLC368QUxmWH2px/UIIP+Riy7wu3d81Od4/saN3r9JmcWL7e7ut5BYX30QfODA2WOAtQev7H/3UQ6Xxl6RAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhRyqdFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279FBC4CEC6;
	Mon,  7 Oct 2024 14:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728310610;
	bh=I7q9lk59AZpbFzZMPAN1WPpVBY6l66csCEEr9J5+l44=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dhRyqdFmMPCSBlCgYzTLbKCgp9Tzmu0mWsCJOU1bwyYXaj0nlMgmihoSPlr9aa9Y/
	 Ta2m0oI7ek8OivzU7TaabaIdVT8EHSCO8AAxV09mkD3F3aXuwycggEwZ3X7sy0/yql
	 wnGu/RX2fLIKdgomfuSLg6zDqg2juGphQegmrhyWSPKryOSGGqhOiU4/dIb81Y/doH
	 7vBdYOOrWBuT61vEf+6lKZw1hjYAl7KtdJbyWE/DbBcTrGZbWY9sv9Ntsllb2rPr0Q
	 OJZ65GfEB5EYoGUhsKmAhvaeC4XS891sQn8ZIv44aVljXpagE8UnSGkGBXOIcB3nym
	 498GXkHQSIITQ==
Date: Mon, 07 Oct 2024 09:16:49 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Derek Kiernan <derek.kiernan@amd.com>, linux-rpi-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Dragan Cvetic <dragan.cvetic@amd.com>, linux-clk@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Stefan Wahren <wahrenst@gmx.net>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will@kernel.org>, 
 Herve Codina <herve.codina@bootlin.com>, Stephen Boyd <sboyd@kernel.org>, 
 linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Masahiro Yamada <masahiroy@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
In-Reply-To: <e1d6c72d9f41218e755b615b9a985db075ce9c28.1728300189.git.andrea.porta@suse.com>
References: <cover.1728300189.git.andrea.porta@suse.com>
 <e1d6c72d9f41218e755b615b9a985db075ce9c28.1728300189.git.andrea.porta@suse.com>
Message-Id: <172831060870.15438.14111281615196403810.robh@kernel.org>
Subject: Re: [PATCH v2 03/14] dt-bindings: pci: Add common schema for
 devices accessible through PCI BARs


On Mon, 07 Oct 2024 14:39:46 +0200, Andrea della Porta wrote:
> Common YAML schema for devices that exports internal peripherals through
> PCI BARs. The BARs are exposed as simple-buses through which the
> peripherals can be accessed.
> 
> This is not intended to be used as a standalone binding, but should be
> included by device specific bindings.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  .../devicetree/bindings/pci/pci-ep-bus.yaml   | 69 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/e1d6c72d9f41218e755b615b9a985db075ce9c28.1728300189.git.andrea.porta@suse.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.



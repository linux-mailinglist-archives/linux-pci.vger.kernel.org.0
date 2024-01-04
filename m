Return-Path: <linux-pci+bounces-1677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074788243D9
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 15:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC281F2522A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 14:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA8C22EE1;
	Thu,  4 Jan 2024 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHJ54JlZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133F5225D0;
	Thu,  4 Jan 2024 14:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CFFC433C7;
	Thu,  4 Jan 2024 14:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704378804;
	bh=aZr4dV3GXhJqOdhebHaFoYyGkow84PQTHg9dzYarFFc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nHJ54JlZbk4BdUkdoP5hZ3kixKIu4DNvGIkcvZqvaXk/2k9hIGXJc4nC9RuELRxVS
	 2yR7pVE4mTE8qeV55ItBYYLXHSSGYiXFP5Hk6UveY08SusZ2aQ2iWs6sfHFEvezEZ8
	 7fUD56Wi8hYHfcMnLUbeBP8eRLOZMHbPtzL0g1anlWGpMOrH6KbrL4JVNqm6X1k3mH
	 CIdjKc5cDwCsnJAL6nkjmy6s3g8lDxR+X50lYqWSP8uaXXzySxRK/gMmGhnLo1sP12
	 /E6h79KFcqRmnzKMBiY7OC9I+/jQlH0hW4zWurvl5ADmehzvcRnEUuQiPEWnaXYWV9
	 RMjUD3feAZY4g==
Received: (nullmailer pid 175802 invoked by uid 1000);
	Thu, 04 Jan 2024 14:33:20 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: =?utf-8?q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>, =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Robert Richter <rrichter@amd.com>, Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Peng Fan <peng.fan@nxp.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Bjorn Andersson <andersson@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Eric Dumazet <edumazet@google.com>, Huacai Chen <chenhuacai@kernel.org>, linux-pci@vger.kernel.org, Kalle Valo <kvalo@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@linaro.org>, linux-arm-msm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Heiko Stuebner <heiko@sntech.de>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Dan Williams <dan.j.williams@i
 ntel.com>, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Chris Morgan <macromorgan@hotmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, Terry Bowman <terry.bowman@amd.com>, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rob Herring <robh+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <20240104130123.37115-7-brgl@bgdev.pl>
References: <20240104130123.37115-1-brgl@bgdev.pl>
 <20240104130123.37115-7-brgl@bgdev.pl>
Message-Id: <170437880007.175780.12569173368621506971.robh@kernel.org>
Subject: Re: [RFC 6/9] dt-bindings: vendor-prefixes: add a PCI prefix for
 Qualcomm Atheros
Date: Thu, 04 Jan 2024 07:33:20 -0700


On Thu, 04 Jan 2024 14:01:20 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Document the PCI vendor prefix for Qualcomm Atheros so that we can
> define the QCA PCI devices on device tree.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/vendor-prefixes.yaml:1116:13: [error] empty value in block mapping (empty-values)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/vendor-prefixes.yaml: patternProperties:^qca,.*: None is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/vendor-prefixes.yaml: ignoring, error in schema: patternProperties: ^qca,.*

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240104130123.37115-7-brgl@bgdev.pl

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.



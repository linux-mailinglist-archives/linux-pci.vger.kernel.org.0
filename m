Return-Path: <linux-pci+bounces-6541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D056E8AD683
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 23:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0EB283C7C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 21:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3541CAB8;
	Mon, 22 Apr 2024 21:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdKQB2mX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E4DEAC7;
	Mon, 22 Apr 2024 21:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821307; cv=none; b=JVZBSzmcc19iRowEeqmOEdhrCehxKb2iJVOGeQacxFnsNhFKieo/2ozmD2ChKqEfvtimSVuKjFOhhkT3eSFI2LjWDKwUrpkOqlUIdX/I2E2kU1Nor/yqWYoGbEUKxW2WCJEAXcAyQDeL5y5vxUDg1W7FNeoLIyLOLehE78S3lIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821307; c=relaxed/simple;
	bh=WaHGXBsM0MuaHIbaQfdNhKENKHsWyZ8D1sqZg8eAJqU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=qzS8npq6JlvYH86M+8ewZF+b8Q3uRfKy1oYV0+plpm8OZpaXk5MsmfX/df8DgQ7mQXu9qxg073C1kUl3Nb64oeK76ND/aerY72O10NJwZa/LW++5fjdErqTzHnutEGN2p+DpmxVMiLEDbOgTznj6Xb+W6qdjPZwzKh7rNV+6qAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdKQB2mX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEC2C113CC;
	Mon, 22 Apr 2024 21:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713821306;
	bh=WaHGXBsM0MuaHIbaQfdNhKENKHsWyZ8D1sqZg8eAJqU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=cdKQB2mXKBtoRSvhAGTGtE+YajDVqN4dNYjCqcDpZ8aY/cc99N/7yWrn4Iv+2TgRn
	 pNRdWhCpnHgh6ICRgI++La2rs8YnQp+DOhkCjtPwuEBAoplT4FAw4igYGAKptaMs+g
	 C15asXjVg7H7rUQAFv4v+JpHohLY5bMs+OstY5f0tR7GsxkNUdgDUSbIyMz2/X1evY
	 b954x0J1Cc3Ml8hZyHs1e2gcVVWdUkoajbG4q7vBkLur1rrN69cOaP7/AGGHgs+hI2
	 snFKHMQsloZxwkDF34yvfqx7l9JUe93Dmy5Vz7Jk3W4xoFtOR7OmH9bd+UcSVxkouz
	 zaWwZk3jlFs1g==
Date: Mon, 22 Apr 2024 16:28:24 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Michal Simek <michal.simek@amd.com>, 
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 devicetree@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>
In-Reply-To: <20240422195904.3591683-2-sean.anderson@linux.dev>
References: <20240422195904.3591683-1-sean.anderson@linux.dev>
 <20240422195904.3591683-2-sean.anderson@linux.dev>
Message-Id: <171382130333.1986303.15938018699322126426.robh@kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: pci: xilinx-nwl: Add phys


On Mon, 22 Apr 2024 15:58:58 -0400, Sean Anderson wrote:
> Add phys properties so Linux can power-on/configure the GTR
> transcievers.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>  Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml: properties:phy-names: {'maxItems': 4, 'items': [{'pattern': '^pcie-phy[0-3]$'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240422195904.3591683-2-sean.anderson@linux.dev

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.



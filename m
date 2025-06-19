Return-Path: <linux-pci+bounces-30162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBC2ADFEAF
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 09:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3C67A6F26
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 07:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1602025DCE9;
	Thu, 19 Jun 2025 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaB5u+bE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FCC2566F7;
	Thu, 19 Jun 2025 07:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750318080; cv=none; b=ZBMMdXi1PYdmDaqz8DTQli1vCx/K1gd5b6fENDwV1eWduSFCfGHKkbePorVxoEZO8hS43s4dlOIK+sRwLJCvJ44QvieX2wOStvq31JheczNRlYEdQ+8BeFMZGUB2nbgsb7LgnpbxKKKQ++r2PfCEKpwodRnoIrVehGOIgRlYfu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750318080; c=relaxed/simple;
	bh=iOlTmiQ7xPFtsZHsUbIdlvX7JUBY0JdnvF8PrsNFm/8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=mbzc3wBslvszedACC+rysZJzfh6cUNLLUXcDHZQSsYz529pYzU/ErHZfju56pyd1DGjnWhvnYBmjZJxs+amtIt20EaJaj5ajH+/ez2Pi0Gg8Sg0tKeIsf8Y2BvHpcjgqfqVYm7N/m6bTacwBpB+e2FYXkNrlE3axhDn2oCyOvYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaB5u+bE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378CFC4CEEA;
	Thu, 19 Jun 2025 07:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750318079;
	bh=iOlTmiQ7xPFtsZHsUbIdlvX7JUBY0JdnvF8PrsNFm/8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=gaB5u+bEVxLD/mYsswxJ16PKoBySIRDFJpEeE1ylH9QSBF3kiOCIzpulEVop8KvxS
	 PV2ZFo5ZCrL91xwCAbpFVz+IA6T8Ra/P67KjkQQBSFnhVt8wu4yX2EnjGHMcSP/95c
	 a1QZPLXopETaPIm08x5jL9alv0s5YBieBIhYFgGImJKFJFiLBv5FxoTN+JOW5qerPy
	 MZ3g8of7MXQ1q3mYdICkEaxh/zQ3xGYS/svB/QWASvSywyUjakkGh9DsvoX4pG9blZ
	 FEBn4gCTXx/dKoOeE0aCxIgmr1vVBBhp1/tApFxKbYP7ii6IC9ZoN3HX0WQdyZCDK1
	 MgooyxDkuJ0jg==
Date: Thu, 19 Jun 2025 02:27:58 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: lpieralisi@kernel.org, l.stach@pengutronix.de, mani@kernel.org, 
 krzk+dt@kernel.org, shawnguo@kernel.org, linux-pci@vger.kernel.org, 
 s.hauer@pengutronix.de, imx@lists.linux.dev, kernel@pengutronix.de, 
 bhelgaas@google.com, frank.li@nxp.com, devicetree@vger.kernel.org, 
 kwilczynski@kernel.org, conor+dt@kernel.org, festevam@gmail.com, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Richard Zhu <hongxing.zhu@nxp.com>
In-Reply-To: <20250619055515.74675-2-hongxing.zhu@nxp.com>
References: <20250619055515.74675-1-hongxing.zhu@nxp.com>
 <20250619055515.74675-2-hongxing.zhu@nxp.com>
Message-Id: <175031807810.3855277.3097205651899770638.robh@kernel.org>
Subject: Re: [RESEND PATCH v1 1/2] dt-binding: pci-imx6: Add external
 reference clock mode support


On Thu, 19 Jun 2025 13:55:14 +0800, Richard Zhu wrote:
> On i.MX, the PCIe reference clock might come from either internal
> system PLL or external clock source.
> Add the external reference clock source for reference clock.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml:224:15: [warning] wrong indentation: expected 16 but found 14 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250619055515.74675-2-hongxing.zhu@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.



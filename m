Return-Path: <linux-pci+bounces-35190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB93B3D0EA
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 06:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE71A17C859
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 04:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE52192B90;
	Sun, 31 Aug 2025 04:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h78myz8E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2A81C27;
	Sun, 31 Aug 2025 04:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756615652; cv=none; b=UF2jbvKhYYuXH9ZchSTAY2nhJZY9vIs4QzLU7+iqLFIFen7PirBo9KiDUNdGtWDaqhgNk6x6HcEg0AFZGcL6r9YZt+TJZ3Nkgn5Xck1bCfbqYVvriPl6HOyeDdqJHbr4pjNOSsGz28fQZ1OTsdhfmHFYlXPwG5xIg7i64YFGnW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756615652; c=relaxed/simple;
	bh=6Xi0K/W1KlUqGgnI90gdjqSztDt8V0ZroZtXizA2odk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS2fYLTevbXrcVEF09IX56DJTxikQM5FUwsIbmUbq4SC2yZrF8iQzHP3+zlhDwgpRvJpwmsdOo91MUAeQ2uJgpTJzpL+Wh1ilch37zkwxTnCU5+EHvUjjk54kZ0oOPV8pwkKEs4/ppsjCib026upYqcRTYBTUu5DaBIUocwMdu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h78myz8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A24C4CEED;
	Sun, 31 Aug 2025 04:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756615652;
	bh=6Xi0K/W1KlUqGgnI90gdjqSztDt8V0ZroZtXizA2odk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h78myz8E/Lpqgkb404MXDyQ/h2vz9IJzk7/Lt2Znqe2z85N0/RPULaLIFOYcqv0na
	 +w7EGs1z14rGeD2aek2/SzcqxSAyeklS9eFRK3qDFVedB29fPEuRtWf0LsFJ5brZAn
	 tqn5/CesHRJOLDD5LLq20N36zjSQpUzB1Y/bmqSFHtfvBnL5GLiQLbRIUSrhzfzWvA
	 QXa2Be4BBwAiQq+ko+LdqTI/Yiv01Kf/6Uq2xORVlmjkgbOypgIf8K9x9vgRXV63pE
	 fiFyrw8smWQCVJgueeXQSiR2dOHLL9o0kQk3jBMBWzOdlTfJ3tW5snqY44yf0sXZ09
	 7cidFvqdI8GwA==
Date: Sun, 31 Aug 2025 10:17:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: kwilczynski@kernel.org, u.kleine-koenig@baylibre.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, arnd@arndb.de, bwawrzyn@cisco.com, 
	bhelgaas@google.com, unicorn_wang@outlook.com, conor+dt@kernel.org, 
	18255117159@163.com, inochiama@gmail.com, kishon@kernel.org, krzk+dt@kernel.org, 
	lpieralisi@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org, 
	s-vadapalli@ti.com, tglx@linutronix.de, thomas.richard@bootlin.com, 
	sycamoremoon376@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, sophgo@lists.linux.dev, 
	rabenda.cn@gmail.com, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, 
	fengchun.li@sophgo.com
Subject: Re: [PATCH 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Message-ID: <qyr73crraruct5dgxfko75gv2mrrxxolkzqnu3bngfelcobgfa@wc4rrzfs27gp>
References: <cover.1756344464.git.unicorn_wang@outlook.com>
 <c9362bb49e4d48647db85d85c06040de8f38cb83.1756344464.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9362bb49e4d48647db85d85c06040de8f38cb83.1756344464.git.unicorn_wang@outlook.com>

On Thu, Aug 28, 2025 at 10:16:54AM GMT, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add binding for Sophgo SG2042 PCIe host controller.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../bindings/pci/sophgo,sg2042-pcie-host.yaml | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
> new file mode 100644
> index 000000000000..2cca3d113d11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/sophgo,sg2042-pcie-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2042 PCIe Host (Cadence PCIe Wrapper)
> +
> +description:
> +  Sophgo SG2042 PCIe host controller is based on the Cadence PCIe core.
> +
> +maintainers:
> +  - Chen Wang <unicorn_wang@outlook.com>
> +
> +properties:
> +  compatible:
> +    const: sophgo,sg2042-pcie-host
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: reg
> +      - const: cfg
> +
> +  vendor-id:
> +    const: 0x1f1c
> +
> +  device-id:
> +    const: 0x2042
> +
> +  msi-parent: true
> +
> +allOf:
> +  - $ref: cdns-pcie-host.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - vendor-id
> +  - device-id

Why are these IDs 'required'? The default IDs are invalid?

- Mani

-- 
மணிவண்ணன் சதாசிவம்


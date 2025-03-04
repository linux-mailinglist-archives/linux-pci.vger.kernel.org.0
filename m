Return-Path: <linux-pci+bounces-22856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D49EA4E2D0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE8377A4FC0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 15:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAF620A5CC;
	Tue,  4 Mar 2025 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCtdR3f0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F95D253B75;
	Tue,  4 Mar 2025 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101012; cv=none; b=CUwMnQ5W6bdCUmrlCvv6AWCBmDo5q74QavS3n97OxQ5qDXRwk14Gghujma7AVcljIHLhromoe1ZagB0rGMcrdbrzZno9QikXk3GxmrQd1xIuDUpkMxJm+qhPstxIK5/ngmipDFrAV4Fj/QQRFw/PzcwVPriWnhYqBElLJksjAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101012; c=relaxed/simple;
	bh=FhKpjo3hcAiaiK1n/W7XQ2upO3brMlYqbq9MJay2QDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAGTYc08K7DXTUKYLARpEC8JrBbmjJviGqP8B5YfLIHafqqs2QnI0ljmswy876QU/fwIhiFHXDYdwFI++sJi6bsJ4Q7jPUPLxFJ63k0ADCGjqrmqsHc1FPOjzSGn56hOAJtKcmBe7a2eaH+/A3Z4/2/k6RzUIRT5vLvonhpwKwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCtdR3f0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE67C4CEE5;
	Tue,  4 Mar 2025 15:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741101011;
	bh=FhKpjo3hcAiaiK1n/W7XQ2upO3brMlYqbq9MJay2QDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCtdR3f0qQnfUb9jBESk9fU6fS7zr8s0lbOS829mYQt41QZYSWf9qfFPZuwZc+ZwO
	 Xb3HS+NnA7KNa7lSPNHNDwNq0xQ552pwk3gmvc4whqM2jDOlKxtW8YjQGWFEEvwqVS
	 cUSjVRGw6Glfps56nMIaw80kMMz//oyyk0/7ABLw0NJrVf0dzFyvf7wOsL+zBuZeiU
	 8oLMtb0R0W262VOEGUtZsSlpMaQRjL6Ba3OVgkQlET1dbGFbPRBg3S1ai4LpOhrrHi
	 8FCnavEfhAcHBt2vTbpY3/P++xIT/oYxnWYDOPwp7UfEOw683+jIdpWCc8seVU1DNl
	 JyuC5IkWJqIlA==
Date: Tue, 4 Mar 2025 09:10:09 -0600
From: Rob Herring <robh@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Johan Hovold <johan+linaro@kernel.org>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pci: Add Sophgo SG2044 PCIe host
Message-ID: <20250304151009.GA2553244-robh@kernel.org>
References: <20250304071239.352486-1-inochiama@gmail.com>
 <20250304071239.352486-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304071239.352486-2-inochiama@gmail.com>

On Tue, Mar 04, 2025 at 03:12:37PM +0800, Inochi Amaoto wrote:
> The pcie controller on the SG2044 is designware based with
> custom app registers.
> 
> Add binding document for SG2044 PCIe host controller.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../bindings/pci/sophgo,sg2044-pcie.yaml      | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> new file mode 100644
> index 000000000000..2860d0f13146
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/sophgo,sg2044-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DesignWare based PCIe Root Complex controller on Sophgo SoCs
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@gmail.com>
> +
> +description: |+

Don't need '|+' if no formatting to preserve.

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


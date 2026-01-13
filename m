Return-Path: <linux-pci+bounces-44654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AAED1A994
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 18:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 019063028D88
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19C7350D47;
	Tue, 13 Jan 2026 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/jeB1KF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AE3502A5;
	Tue, 13 Jan 2026 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325137; cv=none; b=bfCl2To0FLIb3sjrkJ48Pq6ZlE9aOeyyH7eEV3RKUm/AiDjwRm745ex6mnZDzbah3Xu92sW3bwla8gbvPm3LQjXac57rHoDyAZ6vo9x2EOqn7SfSWT4DnEsD2LEmWcP/dDKG5BU2UcOrL86SBD7JrvwuAH+RFc5CjGJc2aWGtio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325137; c=relaxed/simple;
	bh=adh6nRjj4+RlJ7Axtj/4b81J0YYWlHJV3CYCdPPKpyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNpK18fVMGaEThi1VliHv5ZPhbj/RbxqwdfwREPIrNChfFOfes0LOeB9U7uqakRxXgFvfcVohwsfkEAcXhyaxDmXiJa7gBFgQ/qBc3UP/tcLSvlKoz4GD0R4/oot80fN4VKl5Tmz8PMsMZqM95M4CVvadzasxnmYGeTYF/1KVe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/jeB1KF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FEFC116C6;
	Tue, 13 Jan 2026 17:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768325137;
	bh=adh6nRjj4+RlJ7Axtj/4b81J0YYWlHJV3CYCdPPKpyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/jeB1KFdLdMVHHsD1HqYRsMkAl3liD/kCiRpmWWoMPlGFRzzRNRkBYe9gqkpJLKN
	 BSYzreQKE4eFKVNO6PqeZknEPH1mUXiQHwqENmTeY39X7ETTq4AcQf/NDeHJmCCrwZ
	 1Ecn5SOZcv98DTuHdhOf3XDyzPjXHG5p0jP0MiVW39dYICFv849a8cSKIehd7l0PKh
	 uwmOj9kKyOnmIviCtmwsPUCYp2tVaMAezUnxgZBaWh1wpeiCZ5jtV4IrQOvwkaSB0/
	 H06dl/2rPLEnf0+kuRe1wM68+eT4FiDp+ypL++VAzCguGkF+m8pU9Yu2R7LvZang08
	 sa/EO/KXkbDJA==
Date: Tue, 13 Jan 2026 11:25:36 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 6/9] dt-bindings: connector: m2: Add M.2 1620 LGA
 soldered down connector
Message-ID: <20260113172536.GA3975461-robh@kernel.org>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-6-eff84d2c6d26@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-pci-m2-e-v4-6-eff84d2c6d26@oss.qualcomm.com>

On Mon, Jan 12, 2026 at 09:56:05PM +0530, Manivannan Sadhasivam wrote:
> Lenovo Thinkpad T14s is found to have a soldered down version of M.2 1620
> LGA connector. Though, there is no 1620 LGA form factor defined in the M.2
> spec, it looks very similar to the M.2 Key M connector. So add the
> "pcie-m2-1620-lga-connector" compatible with "pcie-m2-e-connector" fallback
> to reuse the Key M binding.

Key M or Key E? I'm confused.

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/connector/pcie-m2-e-connector.yaml       | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> index b65b39ddfd19..9757fe92907b 100644
> --- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> @@ -17,7 +17,14 @@ description:
>  
>  properties:
>    compatible:
> -    const: pcie-m2-e-connector
> +    oneOf:
> +      - items:
> +          - enum:
> +              - pcie-m2-1620-lga-connector
> +          - const: pcie-m2-e-connector
> +      - items:
> +          - enum:
> +              - pcie-m2-e-connector
>  
>    vpcie3v3-supply:
>      description: A phandle to the regulator for 3.3v supply.
> 
> -- 
> 2.48.1
> 


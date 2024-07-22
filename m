Return-Path: <linux-pci+bounces-10625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F504939721
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 01:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F3C1F2220E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 23:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C85E50A6D;
	Mon, 22 Jul 2024 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSdZXSCJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC2617BCD;
	Mon, 22 Jul 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721692263; cv=none; b=Z8pwvMpNEuRe37xTc4Y+WAb9YLkbZvOIW4gMEYMb3kWUKMX2UCLA9n+dpa+aT6o2SOSTaRZpXxWZKRKMhFO4s4uX0GbBPVosZf2oBB8lnzqCd5csVg1u7jI6A1P0GfLRL9rYg38Q85bJ1kQEYIiYEi7hUQtQ6ETuElKWfU62Qe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721692263; c=relaxed/simple;
	bh=iWoGd/pnuwD6hRFYl+KEW8p95X3vPwq+KaaEZPRZLi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpeUdpyEpkbdLSh4D59t0PT0ZmolWyjwy/cZgQBk0VBLB5Rll9mbZgU20HUIofC7FJINy0zRo6nO4eSbIV17TARa58KVV+BhmwvmZtZXBFKw+mSToTJ5a5/qvGL6kPm/dtszhPKqfh5LzkXvqOEOTabED1M+jDGBpRsyBIac3t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSdZXSCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4FDC116B1;
	Mon, 22 Jul 2024 23:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721692262;
	bh=iWoGd/pnuwD6hRFYl+KEW8p95X3vPwq+KaaEZPRZLi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WSdZXSCJiezmSvaaQYljPXz/DNuhJ9d4GOr//ikmNXAfGnzfvL0wyJ8WWeYbUY7aA
	 wa5EmAwU392AtyplKtPKQOudJBKc4fmpyePJSA8074zV7wpaQVYkmSN13XzH4UGjH9
	 IE9pIKBECNRJsgY8aVUOq/etL7e28c9+N3dKaEo261213UD9i8Hdguo2uoXNUnmrun
	 0YabzQXEDodIUsgnUyTe2qvWNqZL5+HWZn0Y3SwA0UZx1i9McAs/WYMs0OliuwFgSR
	 PJMg6VoVV1VhuC+9x99gfC6s/Gt0j3Hl/gDBEWYDXoK9dDr+l1gF5+VOu5PohelxPC
	 MRFAQnIbZiPFw==
Date: Mon, 22 Jul 2024 17:50:51 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 05/14] dt-bindings: PCI: qcom-ep: Document
 "linux,pci-domain" property
Message-ID: <20240722235051.GA378287-robh@kernel.org>
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
 <20240715-pci-qcom-hotplug-v1-5-5f3765cc873a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715-pci-qcom-hotplug-v1-5-5f3765cc873a@linaro.org>

On Mon, Jul 15, 2024 at 11:03:47PM +0530, Manivannan Sadhasivam wrote:
> 'linux,pci-domain' property provides the PCI domain number for the PCI
> endpoint controllers in a SoC. If this property is not present, then an
> unstable (across boots) unique number will be assigned.

You aren't "documenting" it here as the subject says, just using it in 
the example.

> 
> Use this property to specify the domain number based on the actual hardware
> instance of the PCI endpoint controllers in a SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index 46802f7d9482..1226ee5d08d1 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -280,4 +280,5 @@ examples:
>          phy-names = "pciephy";
>          max-link-speed = <3>;
>          num-lanes = <2>;
> +        linux,pci-domain = <0>;
>      };
> 
> -- 
> 2.25.1
> 


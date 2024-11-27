Return-Path: <linux-pci+bounces-17398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BCF9DA419
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 09:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E54BB264C5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 08:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AA5186E2F;
	Wed, 27 Nov 2024 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVCw9g5h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5D15E5CA;
	Wed, 27 Nov 2024 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732696977; cv=none; b=rZFCNi+ocBZ2fR4qa0VMYMFR8cdZsIMAQgCKryqyOnIrlld0vVk85DdSj2aASnMGq7Q5kbruY8gbWf4u8vG4JkKFoczR0YkcMDQgRKzxnxsa/SGmnZ9xIdGzxTK5sN2QEEvxz5QkogV0mLxIsxTsRQnLkjUwkgr+cb0j87h5qMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732696977; c=relaxed/simple;
	bh=e0r9bfon/eutIEC1aFHA8PXjFMiaw6h1Je5WMzlW0k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fff11Q6YMKQOkmefWLlmvIjMe95IOuMVkWz+gOVtpMS2mUfKFr9dy9tFBjlF/fRsMY8qtS4mGYdPvGQgt6IhthnYQwdYAOFc8n41Vn3lbO83C3hcOk44/6IqE26v3EKCwWTEmE9HcWVXSAsX3ZJbzC/cE4vVgXreE8qBj38dgj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVCw9g5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0682EC4CECC;
	Wed, 27 Nov 2024 08:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732696976;
	bh=e0r9bfon/eutIEC1aFHA8PXjFMiaw6h1Je5WMzlW0k0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVCw9g5hsYU55lb7GCKgIR2M7p0t7fo98Zssh//uYOoQ+CJP4r+MQ5VMSq0GIBZwB
	 ONCwD2C8RIKA8IuyjdMP+9UU94bMh58FxnZcMgxtOCE4F/2l+QhDH3lU/8oazeHBbf
	 OzA/qNsXTC+9tlV6EtkUITPe251EOpPLTgA1NcPtXFdbisiey5trtJgGxAZObMHmnU
	 EplXeymmRyAS0LuOc44A0n06c4+Q501vvTAMmHnuUOQ45l+zDVUtCJVWaQSZaq7fBW
	 orBatstQUeDI1C7gaF7Ff4OF24FwDD6a8wCHrcsPjd1nbi7LE+tTMesMyR+cGMnwY/
	 Znn8Sxo8yaHYw==
Date: Wed, 27 Nov 2024 09:42:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: PCI: qcom,pcie-sm8550: document
 'global' interrupt
Message-ID: <nd4codxqdjzoqf6m2ivaofmuzrial7daby2pv62apjsmp6amkp@jxg6fcfh27vu>
References: <20241126-topic-sm8x50-pcie-global-irq-v1-0-4049cfccd073@linaro.org>
 <20241126-topic-sm8x50-pcie-global-irq-v1-1-4049cfccd073@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241126-topic-sm8x50-pcie-global-irq-v1-1-4049cfccd073@linaro.org>

On Tue, Nov 26, 2024 at 11:22:49AM +0100, Neil Armstrong wrote:
> Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
> to the host CPU. This interrupt can be used by the device driver to handle
> PCIe link specific events such as Link up and Link down, which give the
> driver a chance to start bus enumeration on its own when link is up and
> initiate link training if link goes to a bad state. The PCIe driver can
> still work without this interrupt but it will provide a nice user
> experience when device gets plugged and removed.
> 
> Document the interrupt as optional for SM8550 and SM8650 platforms.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



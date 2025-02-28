Return-Path: <linux-pci+bounces-22668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB805A4A496
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 22:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC033BAED0
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 21:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617201CB9F0;
	Fri, 28 Feb 2025 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3j/kmP9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328E323F365;
	Fri, 28 Feb 2025 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777160; cv=none; b=pbPTC8O60HJww1XI9gbkO4TL1KX40Tc1xzNNn0NOiwlLhSXg0RLaeqeawzvYQNoUliEfI4tMx8HpuT+mSnUm+aQnmnqzkaMmDmuGCuy3ylN300wOmoweKci/AMpNvt8m+9qLxMdk0vLcs/ae4aIim7A3aa01rlUAVI3owsuwYNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777160; c=relaxed/simple;
	bh=PGRGH1ZXRV87asUULjB/XOdqinV+t2mPKb9kQiDzmBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EH3eZPDjhTcYeLykpvS9gk9V2x9auDOmVTOo2KHc27O0eMuy/w2YH84slNpUbMdxa8PfS+H+WJ9EYkyCO3v+jdUSIYmVVIAItrokW/+LSs8EkaAzmelZ2hxzj6MquLeJHnyKVdgZtSjDrMG7hmQFHeHTEfsn5o0vUzYxB2qG2Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3j/kmP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552B0C4CED6;
	Fri, 28 Feb 2025 21:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777159;
	bh=PGRGH1ZXRV87asUULjB/XOdqinV+t2mPKb9kQiDzmBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3j/kmP9ShFoJEY1GONkQoH8ih46ZycRf+2GoM9sEn6FIhsuVy+jzuUjgsPCGT9t9
	 dPal8sIMxWLJBoqon0RzTfNi+pkw4f6TFn4esKKWd3LqjPHBpN7ixb8p1xtXrvxQ8X
	 9kIFfGb0QZZV4dUfjYYGfvj2rSvfE5Nz8NafnC46nBYdZ3ni7C/ZfKmvxzPzpptEZB
	 XmV85ONL0FOYank71i1NVMzXHofZxftzZPJba7iQHo1bByDWSkMlGXzCHuOJezdGjI
	 hVUk3wSeW+w5LL2IAqtE4ZEf9jqeiGChoY70O4wze0apHs2j6O3EsfJejTcHiQEMqY
	 d1j2FQzJG4uQw==
Date: Fri, 28 Feb 2025 15:12:38 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: devicetree@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
	linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 05/23] dt-bindings: PCI: qcom,pcie-sm8350: Add 'global'
 interrupt
Message-ID: <174077715756.3726815.4719153028452930450.robh@kernel.org>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-5-2b70a7819d1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-pcie-global-irq-v1-5-2b70a7819d1e@linaro.org>


On Thu, 27 Feb 2025 19:10:47 +0530, Manivannan Sadhasivam wrote:
> 'global' interrupt is used to receive PCIe controller and link specific
> events.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



Return-Path: <linux-pci+bounces-11372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D639495F0
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 18:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36831F22861
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 16:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84B13BB50;
	Tue,  6 Aug 2024 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0lNCnO7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9341918EB0;
	Tue,  6 Aug 2024 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963255; cv=none; b=GQM3ccBX1YwqxQ28at5Db2Si/5m2AdaRr7hlqbksjqPfzisG383mGPmn5lQe48Xz6Nf5VEclbz9hu04IW0JaTq4o5351oROuVHURkdKtbrEgAvrVvqAfFNIHWXUNAK5rgPH4FDPzE/tQCv29qSpgzEbV/jgq8dkvd4UmOa/oCGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963255; c=relaxed/simple;
	bh=OGl7OTeP+UuQWbwPEeanYVgWrUqC6QmWTlkqT9FnYbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxunJl+ugNV8NRQW/3vw2jF6tUCNH1bVSLhH5Dl05z5rPl44v4qF5zoEw6xls/FgXcFI5lrpcfUIosb70Ma4APZcgJkmqsKNB5Pb9StUXtpil0siWbhOVp+3Qm8Q1SEiwtR3XJs665ZFSLZIkbCvD9wDuK6V0kchlbARMT+Pwjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0lNCnO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF6FC32786;
	Tue,  6 Aug 2024 16:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722963255;
	bh=OGl7OTeP+UuQWbwPEeanYVgWrUqC6QmWTlkqT9FnYbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c0lNCnO7RCuLuqrgl1WsgFoXz5nm9aLgAqqu9vfGK/oz8a7ja25K1b5eopZWg+fiF
	 0PEeECqc5lNyHYOnmjCTfH/QLxu2izJ6f/76zxz8sUOCucAFFw5De57k/B6M3Jpkch
	 t/Ni/Rvo6w5Pnw8fZTN4yVebCuCBZOn9qGlHUQZ2jMWAN3Z0iT2nJwJ+CDWTbAIflW
	 T6tsx40T1zdg8sU6DrAk723WM5vFpFCC3bWzZVkjayFGnx1qZDDJjInG5P9jrwH2GQ
	 34Ax4Me3XZm0y1wl9QzvyjqU8XB1/hJ2+3YJHrTFi5DVHTkz4rQASUL2gqSV2uxrsN
	 e/XIiEzrFrUJg==
Date: Tue, 6 Aug 2024 10:54:13 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 11/13] dt-bindings: PCI: qcom,pcie-sm8450: Add
 'global' interrupt
Message-ID: <20240806165413.GA1674220-robh@kernel.org>
References: <20240731-pci-qcom-hotplug-v3-0-a1426afdee3b@linaro.org>
 <20240731-pci-qcom-hotplug-v3-11-a1426afdee3b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-pci-qcom-hotplug-v3-11-a1426afdee3b@linaro.org>

On Wed, Jul 31, 2024 at 04:20:14PM +0530, Manivannan Sadhasivam wrote:
> Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
> to the host CPU. This interrupt can be used by the device driver to
> identify events such as PCIe link specific events, safety events, etc...
> 
> Hence, document it in the binding along with the existing MSI interrupts.
> Though adding a new interrupt will break the ABI, it is required to
> accurately describe the hardware.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Patch 10 should be combined with this. It's one logical change.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


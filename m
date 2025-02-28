Return-Path: <linux-pci+bounces-22670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB7BA4A49D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 22:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5142A18982B8
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 21:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B891CD210;
	Fri, 28 Feb 2025 21:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ug1slQ+c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF50E1CB9F0;
	Fri, 28 Feb 2025 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777181; cv=none; b=a3l5v61oNucXaBvbh9lDm0aYAmgt+a0LKe3xwlex9j2t990jpTniM+Lj9fEbLsG18G2ZahfvjZOUKtsq+Qf6sFwQbnO2adJL5xSUoklPrXjO2Cx+3fdzlfLevLVXc2vQvTEpJVBOiIpPbS9/TlzbK6L1X5ZiDK/6BbewxlYT3cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777181; c=relaxed/simple;
	bh=7BwIIwTcUdeRFZubNrQcWH/3AHUwpP78wu9uzb0CF7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIUJFH3+IomWRUwzoYzTh93gHgLNHlQqUY2vHYnnatq16XW3aZGDrYXkE0lZNNUTJsC2Wqcvjdb5GjTEv8SrmW7jT+in9oNwY4TEr0coZ7ND3PFi3lE8bO7aokMiV01pWippkBGKy5PPBam9p39lQO5K4LdF5giBQpy4XE9P9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ug1slQ+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E6BC4CED6;
	Fri, 28 Feb 2025 21:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777180;
	bh=7BwIIwTcUdeRFZubNrQcWH/3AHUwpP78wu9uzb0CF7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ug1slQ+c7dobcjF9btIiUaOcqWGFyizlggXzjSwQqd91xdW2CAgh+BmGgWOfctLZd
	 Be9egYLQQm3FRCdhg816WMYoUOa+ayZ0EXloabee/4GhkHP70fVWrqRiHZZaf/2Vw7
	 R7uka+Ar5mFGCA8W2TDSoTbyNzTR9jPer1VyF3Z8vFVob4aE9ju9hrLWiiF1D5B4WO
	 VP2cTC6ZIuO2MrIb6zH/UvsG9RvgDWIkL8W1XUqRr5IyaRNlklDQttRGwNb2U23tZA
	 KaIbXJUeSGdioikFWz+3xyx3WKn1eP4OlzJ23vuwqmASJBSyeL0gSYSLmFZwlIIpts
	 hJ3jIkjKg6IWQ==
Date: Fri, 28 Feb 2025 15:12:58 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	cros-qcom-dts-watchers@chromium.org
Subject: Re: [PATCH 09/23] dt-bindings: PCI: qcom,pcie-sc7280: Add 'global'
 interrupt
Message-ID: <174077717701.3727491.12523153935568258459.robh@kernel.org>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-9-2b70a7819d1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-pcie-global-irq-v1-9-2b70a7819d1e@linaro.org>


On Thu, 27 Feb 2025 19:10:51 +0530, Manivannan Sadhasivam wrote:
> 'global' interrupt is used to receive PCIe controller and link specific
> events.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



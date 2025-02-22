Return-Path: <linux-pci+bounces-22082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B2AA40785
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 11:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB963BBFB4
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 10:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F79C2080E8;
	Sat, 22 Feb 2025 10:41:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA442080C1;
	Sat, 22 Feb 2025 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740220878; cv=none; b=YP7n9CdMo2zuqBJ82jCZxw9POVGr59lNBPdJLNGK9ai6X2QqufvrpSwXTChD8zgofhq9FHDJo1J07cH53uLZRtjZl6hlCpNcAJghLjcLijSwhKy28Fw+/aEsr7T2bGnx3A5T5FSKW8NXgUy9HIuvxdx55W9aeeHUDyPexBA4744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740220878; c=relaxed/simple;
	bh=TMtuyg0KY26NyUFljwMHBqOsR5NkaAjdbd71MU6eOqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUqIPm4Hot9uaM6hSQhZJqyaOYza90YnxVNO4sRiBjzf9lPR9wm0TuOu3VapetVXSAHGOWYDiKpYRwSxnLF1YzKoTuuPLI4KQUdapEH3I0xYEZF/Pqpf1bKtsSimas7splq+fWksPiC5fj0kn15GVtfVYx0bUWutf0oOvfA75mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78E7C4CED1;
	Sat, 22 Feb 2025 10:41:16 +0000 (UTC)
Date: Sat, 22 Feb 2025 11:41:13 +0100
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mrinmay Sarkar <quic_msarkar@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] dt-bindings: PCI: qcom-ep: add SAR2130P compatible
Message-ID: <20250222-logical-russet-mastiff-f02b7c@krzk-bin>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
 <20250221-sar2130p-pci-v3-5-61a0fdfb75b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221-sar2130p-pci-v3-5-61a0fdfb75b4@linaro.org>

On Fri, Feb 21, 2025 at 05:52:03PM +0200, Dmitry Baryshkov wrote:
> Add support for using the PCI controller in the endpoint mode on the
> SAR2130P platform. It is impossible to use fallback compatible to any
> other platform since SAR2130P uses slightly different set of clocks.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 36 ++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



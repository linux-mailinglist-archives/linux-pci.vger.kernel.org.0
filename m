Return-Path: <linux-pci+bounces-4348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE88986EAF5
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 22:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E18CB215C1
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 21:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA5156B98;
	Fri,  1 Mar 2024 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsAKURfv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEB656B74;
	Fri,  1 Mar 2024 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709327528; cv=none; b=HmBWxvgQR9KTDiqdSj17joNwSQlryyCFBvnCfBrluaSbcDlBhmCIYyRDkuvvxWx1RhvkB32hhY+hJENNLBCSGyINrKAcdk9LnW4ZwEKVGaX3GkFRf+P1wx+Upj2DDlWOzch7SaC81OSX6TFBc8CnN+6wQ2ahQ3ZHDHvbOg/B8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709327528; c=relaxed/simple;
	bh=6KTnGZojSKiI6qPY5u8jTFRZhiEL7wo7RfslBXaDzuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgbB3u9Qg41pOqfS/o0o4+BxsdA6rhuXd0TIkUzKrDQojdXYsdk5jOB+8KGCF6iWzwfJ78uybU5ZXBq9yyfZdVFm45sMzP4SrgBtA4fMJ3FMTNCndaxCNAs5hOHB4Ntw7YeLwl+PKEvmVi+RiwwGj8D8xvmSZ0dFkdSUVTKa0j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsAKURfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B4EC43394;
	Fri,  1 Mar 2024 21:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709327527;
	bh=6KTnGZojSKiI6qPY5u8jTFRZhiEL7wo7RfslBXaDzuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SsAKURfv9cvIlz08w5+kegYONoMgsqGvskpVzI/MDbVAZqD4hbfXiMABdzK+uXEVt
	 thksY8XfZjlm3mWjGFRmkd6+7xNTX8x7F6HcebhPekqa1Qn+ZDn0QkDrzTzlinuKR8
	 0lV+e8dcoUoVrVBmozyuGfeGzYdz+NaCCdGkxlRb9UxnPgsdbZ6UNTSiSoCjkTlcxI
	 Na4jRP51jmLLFcQ05OemZsL6avYhTePRK8EQLTHOFzIUpaJhV9fJety2CYUBIH0JJF
	 ckAw2eMqsyuxcl4GhlZ/r//ZlJJW/JwcbQkAptPyR+5s4ELXg1vwER5v2TwIZyeGSK
	 yqOzO3QX68qOQ==
Date: Fri, 1 Mar 2024 15:12:05 -0600
From: Rob Herring <robh@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 03/12] dt-bindings: PCI: qcom: Allow 'aspm-no-l0s'
Message-ID: <170932752351.3045588.9363132406112450263.robh@kernel.org>
References: <20240223152124.20042-1-johan+linaro@kernel.org>
 <20240223152124.20042-4-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223152124.20042-4-johan+linaro@kernel.org>


On Fri, 23 Feb 2024 16:21:15 +0100, Johan Hovold wrote:
> Add 'aspm-no-l0s', which can be used to indicate that ASPM L0s is not
> supported, to the binding.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>



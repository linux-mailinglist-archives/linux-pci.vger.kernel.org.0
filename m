Return-Path: <linux-pci+bounces-18626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3719F4C89
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 14:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B27F1893E25
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 13:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6218E1F3D41;
	Tue, 17 Dec 2024 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRn2ED4s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA91E485;
	Tue, 17 Dec 2024 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734442477; cv=none; b=noDy8dTKhZwiH4D1u7dW+Xu1XMjnvNh2qvtevWr7yKtk6pjAksLTQWqN2eekQyx7ehjM11epgeGuOLo3H1dxdiZGKkcSVlw2uQ5ayLsntYdITiVSUrNBfZjxPaqiFK3MfG0NB1p01ecx6jHxQUq6mRibcVmSKcYfPUbEf7Z8tnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734442477; c=relaxed/simple;
	bh=ucFolLl1sZUgzrnDPVtLF6IhpbFiqCmqyONnkRrdE+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PngMbH6I/i9732OCjefHn5N2vll1IzoOnvUcXf6430ZtTdPFQVJlboa3pnaQmSQiiMLbufNH1fS4VTA/N11eLsPTD5euY2+Gx7l6QTu/cMZgL01V+RwGRwN8bALlz4G3l8rCxbzY+HDH1pR5CrCrxNUVGBfPe2WbhoVmYUoAbKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRn2ED4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A71C4CED3;
	Tue, 17 Dec 2024 13:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734442476;
	bh=ucFolLl1sZUgzrnDPVtLF6IhpbFiqCmqyONnkRrdE+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRn2ED4sh4qILlVU7BHXgxEoozwA/RMbdoaVhGEcKkPN+vNYXDuJxy8qayUloqm/N
	 RMfcexFMi+wNefOdjR3W8xQkAuCDrIhUlikXhJI+JhsM0X5WYc8IIdGKg35tb7/ZGd
	 egSD6P8hhcZxGoajETKyIluEC0PfSyNvf2A2e3aL04Z3lA3EjyLTpw2Wk5Wp2uI5tI
	 IWs8OZ2Vd8fCR7FSHg5TLIDQTa8GGxuOuiTtcOdd5DS2bjKqR90xHwr1mkflpOnBlj
	 5Pxdcgkz5gmo8xSrIYoLwOVgsd7iphOXzkt3Oe9jqexrQ56kFlAM+bmlfeiYIn+thz
	 X7az8uCL8R+gg==
Date: Tue, 17 Dec 2024 07:34:35 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Qiang Yu <quic_qianyu@quicinc.com>, linux-pci@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: vendor-prefixes: Document the
 'pciclass' prefix
Message-ID: <173444247437.1427449.10975392578508176366.robh@kernel.org>
References: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
 <20241210-pci-pwrctrl-slot-v1-3-eae45e488040@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-pci-pwrctrl-slot-v1-3-eae45e488040@linaro.org>


On Tue, 10 Dec 2024 15:25:26 +0530, Manivannan Sadhasivam wrote:
> 'pciclass' is an existing prefix used to identify the PCI bridge devices,
> but it is not a vendor prefix. So document it in the non-vendor prefix
> list.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



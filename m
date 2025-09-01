Return-Path: <linux-pci+bounces-35267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EC4B3E3A2
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 14:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE733A2224
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 12:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEE01B4F2C;
	Mon,  1 Sep 2025 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxX66d9R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5C0136351;
	Mon,  1 Sep 2025 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730819; cv=none; b=OAvm8+JV6jKxmz4Az6h2VuvjaHdG586Gk7FCrUthwFXoxqXy8lZOvwnzHnyvl4e1NaOrNR17x+Kt7iHA1CUcpcz8X9oDDruiYCLe6DjDvdWPJvACTZee2psrpt4UA1GMi6ph5CfgtxMEaJ7w1/RohzI6XToPxCafn+s8BkZWnzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730819; c=relaxed/simple;
	bh=2xTXPacSe1TahEgzN+FN8vL/Vg7NTQYpV6LZHrhwp34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKsm1oCpgdoeUAyDqk7PAFa6+HeUePuVR54SYZZzVvm/q+VsRIwVdN/4yuNiOyNo55XMLVTk04U8rXV08EadDEyRE8OLHKrZ12Az4vpIwgWBWgg6Ikx0cCtP03dAxrl18KRjpR13P1LM+pQrGLHRSsIrqiDudOuN/hrO6QXAQfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxX66d9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E110C4CEF0;
	Mon,  1 Sep 2025 12:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756730819;
	bh=2xTXPacSe1TahEgzN+FN8vL/Vg7NTQYpV6LZHrhwp34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VxX66d9RkS6IDXQgwF3xHpuIodVAGUIoOX4J/JfS36R/sf9UxP1kskzR8ctZOtFzZ
	 9UiPxi/wZvxIx1vdyvP1gbl39JDVvBZE+sPJV4liPXmIQd/S83cUFCikXG8MwjuIMz
	 kX7N18myK6CzQaOUMQiNLJeaLKn7qRIw0h/Wj5wxWHXesA3I+a76evSZXoyu6L+vgZ
	 9wRosLhtXhyjPVCIUJ8fyPAvP+rGmFzU/zmDmtBKdV6JNiCP+XOYZjfeLEnqwnZF+j
	 G0XKct1Gy/XqBzLR/PH4HLD/3VFgzHOHCiGGvMcwd4M52EgOCffbEY4t9i0LYeTlqt
	 e7NqXXqdo6m9A==
Date: Mon, 1 Sep 2025 18:16:54 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, konrad.dybcio@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com,
	Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the Glymur QMP PCIe PHY
Message-ID: <aLWVvuGrxL2OQRSd@vaman>
References: <20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com>
 <20250825-glymur_pcie5-v3-1-5c1d1730c16f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-glymur_pcie5-v3-1-5c1d1730c16f@oss.qualcomm.com>

On 25-08-25, 23:01, Wenbin Yao wrote:
> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> The fifth PCIe instance on Glymur has a Gen5 4-lane PHY. Document it as a
> separate compatible.

This does not apply for me, please rebase and send

-- 
~Vinod


Return-Path: <linux-pci+bounces-34327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B28BB2CD22
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 21:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476502A3255
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 19:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C6C33EB1C;
	Tue, 19 Aug 2025 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrF+OeY3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F133EAEB;
	Tue, 19 Aug 2025 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632587; cv=none; b=KyNw1cR+Ahd9Ts7w5ZmzHbrsnkHAtjjPuajkj5hJ/t9rWh5ng1GZaM3BKSn/Z9k8sPc8fDpkcvhJnFewJGAQiXp65KQwavmVvIgfbShmfiYK03JL78I9QB7zA41S4fW8r5xlTZ9KTndpe+vlPhCmttzOm8MIXEXu2rTqCvWhs70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632587; c=relaxed/simple;
	bh=hpVYCvr3sp/UhOyLy0NHGA6743GbDhSFoi4n5LnbXnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6kZVI19EKL5zZj9x9F5CuyNTTWMotfMldp7+0J7mfusattn07ytAgK+UYGWyOLiuL/Cn6oFLq9ufKLx47qEg1BEbnT+SlM14aRfpTPgD6X7rc+l7HIVmQnUeCjgU6n8OJgy70qxXyUwbqHUw0Z6zatU6k/D8XKKsPjNlkFmqPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrF+OeY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC32C4CEF1;
	Tue, 19 Aug 2025 19:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755632586;
	bh=hpVYCvr3sp/UhOyLy0NHGA6743GbDhSFoi4n5LnbXnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HrF+OeY3Q0Wuhu4Ib2pqKGC5IcRp5yFKCii4EknYwRyz4YLiEvJdkCIV82xLXi+Fu
	 sILJlegZSZy1J0/+EqflzewRlVo3PtEvhHQ4/VeS6FrGJsSSDLUyG/2qBAgQ1TEizm
	 jF2baLgI7n2I5LEf8eLxG4gfzrRG/9SNmRy+ETSilaVBM6+SnIvu9OVgpljMc3D6P9
	 wTnOFUSWnz7NKGoOX5lB1f1Gl6SmNpU6tkVeGnhmwWP73SzeZUj9Qm6cEo2IaM+rfY
	 stL1oVvn7RDkk/Qur0UYgCUf6VXvBx3LkyRs2sSyZ0K4NC5XQa1okQt1Jk4mPV61wB
	 qrdLlizNmEDWQ==
Date: Tue, 19 Aug 2025 14:43:05 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	konrad.dybcio@oss.qualcomm.com,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pci@vger.kernel.org,
	qiang.yu@oss.qualcomm.com,
	Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: PCI: qcom: Document the Glymur PCIe
 Controller
Message-ID: <175563258518.1214404.14197292755881169254.robh@kernel.org>
References: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
 <20250819-glymur_pcie5-v1-2-2ea09f83cbb0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-glymur_pcie5-v1-2-2ea09f83cbb0@oss.qualcomm.com>


On Tue, 19 Aug 2025 02:52:06 -0700, Wenbin Yao wrote:
> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> On the Qualcomm Glymur platform the PCIe host is compatible with the DWC
> controller present on the X1E80100 platform. So document the PCIe
> controllers found on Glymur and use the X1E80100 compatible string as a
> fallback in the schema.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



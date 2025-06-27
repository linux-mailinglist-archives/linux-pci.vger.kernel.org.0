Return-Path: <linux-pci+bounces-30905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0C0AEB2D9
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 11:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1A24A14BA
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 09:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC410293C59;
	Fri, 27 Jun 2025 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVM8rqp/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D71F19F10A;
	Fri, 27 Jun 2025 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751016529; cv=none; b=hOPB/eS5B4YODo04WfTyafRTg5MuenhZ8AW8DRrVePCRjghQ9BxL3aJ4H6lUZk6j4E/LY+XEdJtcX8WD0bCPiOoeAMaYDAMIaA/ka9OOpGPVq5+e6B8xRs+XxhPP9TIYtwpV5Zv7Q3P3YsUFXroEPh7O+2/k0U6LvSJlM89Z0us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751016529; c=relaxed/simple;
	bh=NMdUf/+EgOboapTSK2P0BWd2KGOh4vtzeZ1cIy0waMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rs8BXmSYPINYZX8l6jWl3sS/jGRJBReUoz+E6Hr3SXVPUvDbblhoT2O2sevm9Z1NRjbp6n3kDWuRggr2yx3I3ZCj6/0+9wW8FykareMknV6VNGa3q/i3Al0Nm6699F3nnBzMElnumKOBue7vESCBzw/czRyPNGL5c3ZmFzSWMXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVM8rqp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F06C4CEE3;
	Fri, 27 Jun 2025 09:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751016528;
	bh=NMdUf/+EgOboapTSK2P0BWd2KGOh4vtzeZ1cIy0waMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVM8rqp/Jt8lnO6gp/6oOYfJeZkJKCBM65127Pdwzk+90BDjC1vKMC1FrmJWGVrPG
	 Gclq5nLOFnFPmBdIDG6sUiKDVq3maqQzwL5stg7wfdvwuUCyXi9RVeEHvJw/tu0L4T
	 xsxT7uvLHf3J3T+rmGxCmw7ryGYu/mFfZ9pMs2Tpyjc0an87/YFT1sYoYEWU0KteNP
	 +qKzT3oe6M5kAa3FdrHaYy6TqDIp9Hdcp6ZzqiHISl3ahpkJ+eag5e0u/OTwrkWv6T
	 p1v07vNfR5vUWSpk+G+nHWJToQxCBo62O3DXdapdaWNq4fH8TN4x+pwH+9nY24NGtB
	 Kzku7Wpgtspvg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uV5O4-000000000Co-3wci;
	Fri, 27 Jun 2025 11:28:49 +0200
Date: Fri, 27 Jun 2025 11:28:48 +0200
From: Johan Hovold <johan@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
	kw@linux.com, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v3 2/4] dt-bindings: PCI: qcom,pcie-sa8775p: document
 link_down reset
Message-ID: <aF5kUDghdXUbaDo3@hovoldconsulting.com>
References: <20250625090048.624399-1-quic_ziyuzhan@quicinc.com>
 <20250625090048.624399-3-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625090048.624399-3-quic_ziyuzhan@quicinc.com>

On Wed, Jun 25, 2025 at 05:00:46PM +0800, Ziyue Zhang wrote:
> Each PCIe controller on sa8775p includes 'link_down'reset on hardware,
> document it.

Please describe what this reset does here as I asked you to earlier.

> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml  | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> index 4b91b5608013..510c9e1c28e1 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> @@ -66,11 +66,14 @@ properties:
>        - const: global
>  
>    resets:
> -    maxItems: 1
> +    items:
> +      - description: PCIe controller reset
> +      - description: PCIe link down reset
>  
>    reset-names:
>      items:
> -      - const: pci
> +      - const: pci # PCIe core reset
> +      - const: link_down # PCIe link down reset

I think you can drop the comments since you already describe the resets
above.

Johan


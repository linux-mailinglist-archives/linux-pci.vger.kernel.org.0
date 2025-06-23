Return-Path: <linux-pci+bounces-30364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 394E2AE3DA4
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D523A8630
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 11:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF16623C8CD;
	Mon, 23 Jun 2025 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKG/4z2p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA323C4F1;
	Mon, 23 Jun 2025 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676832; cv=none; b=tcb6VMAhAxh9OmD+3c9S9Y9MlkOt2lrf6SmTfcPu7Emsv2WD9gko3LR9xomMDxCCiQ5A3lAsHwFI6ihyzx6en7OND0oPSbb0szZx3da6z+rxTCZyOjZ2+MQb0nJ7fgepEau8+oQRBslcetx4MgNALpLeyfTm9ADDjbKW/eowKR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676832; c=relaxed/simple;
	bh=wzxND8su0nn3xqtiU+RXYbGOxIGLD0gI0nLSQZSkL6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VP+ff0ikv4qHevFsPvuGo5TtGVvjx4h1vV/SmHAkEaJkT40HQ6jda8MHy3OkKj9n8rrCoSybbTm4VZSEPiCuNPCrzV2tU62+y/9OmXZnp90exv5AttF7ym4YxIENO1WkMEsPZGFvoEok/h5lnrtfj5VsZo5EMoNThlbSYj4sgXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKG/4z2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C01C4CEEA;
	Mon, 23 Jun 2025 11:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750676832;
	bh=wzxND8su0nn3xqtiU+RXYbGOxIGLD0gI0nLSQZSkL6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKG/4z2ppClqWj7UDxg/nLGtNNJT7I0SUKuLBS39dKcUvE42HbFs/JZbwpD9OLcpZ
	 3plknMkVVv9m60CXTbonvcZX6hi4jRy+WLmaLHmeX1nrKRNs07lOQR+PhQ8p+eX/WA
	 8lqgwvOfyUh5SlsKLveEzDIheXvAMWy60uiSuZmPT+Fq5fHXox+E71st0T7NXtLY4L
	 G9uoOue8GhKkGeySbGeGj7V9CGK3eon+mSWXbtYWF3OZdAtm+AhbPvT+YOcwZsyDkH
	 naAdHpTC/cnKovxS0puN7W7hi9k/w9IoX3vcnejQ9banW9B8v4txGChjQ5KR48FhbQ
	 OBoV9N3q+0R/Q==
Date: Mon, 23 Jun 2025 05:07:10 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v4 0/2] PCI: qcom: Move PERST# GPIO & phy retrieval from
 controller to PCIe bridge node
Message-ID: <y3umoz5yuofaoloseapugjbebcgkefanqzggdjd5svq5dkchnb@rkbjfpiiveng>
References: <20250605-perst-v4-0-efe8a0905c27@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250605-perst-v4-0-efe8a0905c27@oss.qualcomm.com>

On Thu, Jun 05, 2025 at 02:00:36PM +0530, Krishna Chaitanya Chundru wrote:
> The main intention of this series is to move wake# to the root port node.
> After this series we will come up with a patch which registers for wake IRQ
> from the pcieport driver. The wake IRQ is needed for the endpoint to wakeup
> the host from D3cold. The driver change for wake IRQ is posted here[1].
> 
> There are many places we agreed to move the wake and perst gpio's
> and phy etc to the pcie root port node instead of bridge node[2] as the
> these properties are root port specific and does not belongs to
> bridge node.
> 
> So move the phy, phy-names, wake-gpio's in the root port.
> There is already reset-gpio defined for PERST# in pci-bus-common.yaml,
> start using that property instead of perst-gpio.
> 
> For backward compatibility, don't remove any existing properties in the
> bridge node.
> 
> There are some other properties like num-lanes, max-link-speed which
> needs to be moved to the root port nodes, but in this series we are
> excluding them for now as this requires more changes in dwc layer and
> can complicate the things.
> 
> Once this series gets merged all other platforms also will be updated
> to use this new way.
> 
> Note:- The driver change needs to be merged first before dts changes.
> Krzysztof Wilczyński or Mani can you provide the immutable branch with
> these PCIe changes.
> 

You've dropped the DTS changes in this revision. So the above comment is stale.

> [1] https://lore.kernel.org/all/20250401-wake_irq_support-v1-0-d2e22f4a0efd@oss.qualcomm.com/ 
> [2] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/
> 

I don't have a device to test this series right now. So could you please test
this series with the legacy binding and make sure it is not breaking?

Once you confirm, I'll merge this series.

- Mani

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Changes in v4:
> - Removed dts patch as Mani suggested to merge driver and dt-binding
>   patch in this release and have dts changes in the next release.
> - Remove wake property from as this will be addressed in
>   pci-bus-common.yaml (Mani)
> - Did couple of nits in the comments, function names code etc (Mani).
> - Link to v3: https://lore.kernel.org/r/20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com
> 
> Changes in v3:
> - Make old properties as deprecated, update commit message (Dmitry)
> - Add helper functions wherever both multiport and legacy methods are used. (Mani)
> - Link to v2: https://lore.kernel.org/r/20250414-perst-v2-0-89247746d755@oss.qualcomm.com
> 
> Changes in v2:
> - Remove phy-names property and change the driver, dtsi accordingly (Rob)
> - Link to v1: https://lore.kernel.org/r/20250322-perst-v1-0-e5e4da74a204@oss.qualcomm.com
> 
> ---
> Krishna Chaitanya Chundru (2):
>       dt-bindings: PCI: qcom: Move phy & reset gpio's to root port
>       PCI: qcom: Add support for multi-root port
> 
>  .../devicetree/bindings/pci/qcom,pcie-common.yaml  |  32 +++-
>  .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  |  16 +-
>  drivers/pci/controller/dwc/pcie-qcom.c             | 177 +++++++++++++++++----
>  3 files changed, 192 insertions(+), 33 deletions(-)
> ---
> base-commit: ec7714e4947909190ffb3041a03311a975350fe0
> change-id: 20250101-perst-cb885b5a6129
> 
> Best regards,
> -- 
> krishnachaitanya-linux <krishna.chundru@oss.qualcomm.com>
> 

-- 
மணிவண்ணன் சதாசிவம்


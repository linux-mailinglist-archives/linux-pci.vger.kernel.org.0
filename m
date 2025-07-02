Return-Path: <linux-pci+bounces-31224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C08AF0CBA
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 09:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7671BC72AB
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 07:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C8B225A31;
	Wed,  2 Jul 2025 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbbSCo0m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430322236E8;
	Wed,  2 Jul 2025 07:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751441908; cv=none; b=DlCCVEn5a2VTrEI5rz37EKatZXiyXx5oLx+x/PN5lWKru66dNkQaIOlu1YhkNF7eq6NRy3T309Nkvbu87B2qVL58YMNv2DJxZsqHtUDVqgKOKeM9C/UnTCEI0oYNo5QOZuMqcWJVUkxA0NKT/77msHPFFitZXoWopd1/UP4ypY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751441908; c=relaxed/simple;
	bh=9zW3adiPjXrJwmbHyG9ny09W8n4e+4UMLMC+L3yaw0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9V0qZQHpLggW9VoY2NDov2UAP4muRE0XNWd4lLcp3OFgWlDsyiMw1LZm1RB9L9+PN+o6CrqBEvu/lsUjT+Kt5lR/XZaxu/0gYZedOgAzxKNmY8LlrnifdH3xYChz7SbeL8VdAwy0CVceqLY6MAMLUM8L6Ov3yzX5zwGfK/fdfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbbSCo0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F66C4CEED;
	Wed,  2 Jul 2025 07:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751441907;
	bh=9zW3adiPjXrJwmbHyG9ny09W8n4e+4UMLMC+L3yaw0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kbbSCo0mH+SSG6OaXN+gS5ByUrKWpaEy+tVm/aJ1lHpKRbxvjVlFdXj5SCoVYz6Ek
	 rkuLDfKH4z1TelMx1fksi7ECu8ZfGZjg+TnmeZvs34BKV5G7kaWCKfgflGI0GJKfre
	 ANkypHa1v7Z6GKaWuHm2WFe5+8k2LwMQp5pAjVQpg5ENpDtekGANo5gJ9mFEm3yrt1
	 xRk9zPXU8vz+KkypkwimTPq9q9hnuO75I6a1SJOtO94l7q3zIiunwl/k4kahNPqpmt
	 eD9f6g2nYlCEckiTRLi+ygvUJRthJpd3y6hXR1/vSkxj7x/1GR958UroPrhA+07PnZ
	 XgkfshNrep/Yg==
Date: Wed, 2 Jul 2025 13:08:00 +0530
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
Message-ID: <ktccsjikeez6w6fkmqxkywd357m4cvzdywixnkgdito67sngzo@4p3tu7oxufta>
References: <20250605-perst-v4-0-efe8a0905c27@oss.qualcomm.com>
 <y3umoz5yuofaoloseapugjbebcgkefanqzggdjd5svq5dkchnb@rkbjfpiiveng>
 <4bae822e-e7bd-461f-99cc-866771c0b954@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bae822e-e7bd-461f-99cc-866771c0b954@oss.qualcomm.com>

On Mon, Jun 30, 2025 at 06:00:12PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 6/23/2025 4:37 PM, Manivannan Sadhasivam wrote:
> > On Thu, Jun 05, 2025 at 02:00:36PM +0530, Krishna Chaitanya Chundru wrote:
> > > The main intention of this series is to move wake# to the root port node.
> > > After this series we will come up with a patch which registers for wake IRQ
> > > from the pcieport driver. The wake IRQ is needed for the endpoint to wakeup
> > > the host from D3cold. The driver change for wake IRQ is posted here[1].
> > > 
> > > There are many places we agreed to move the wake and perst gpio's
> > > and phy etc to the pcie root port node instead of bridge node[2] as the
> > > these properties are root port specific and does not belongs to
> > > bridge node.
> > > 
> > > So move the phy, phy-names, wake-gpio's in the root port.
> > > There is already reset-gpio defined for PERST# in pci-bus-common.yaml,
> > > start using that property instead of perst-gpio.
> > > 
> > > For backward compatibility, don't remove any existing properties in the
> > > bridge node.
> > > 
> > > There are some other properties like num-lanes, max-link-speed which
> > > needs to be moved to the root port nodes, but in this series we are
> > > excluding them for now as this requires more changes in dwc layer and
> > > can complicate the things.
> > > 
> > > Once this series gets merged all other platforms also will be updated
> > > to use this new way.
> > > 
> > > Note:- The driver change needs to be merged first before dts changes.
> > > Krzysztof Wilczyński or Mani can you provide the immutable branch with
> > > these PCIe changes.
> > > 
> > 
> > You've dropped the DTS changes in this revision. So the above comment is stale.
> > 
> > > [1] https://lore.kernel.org/all/20250401-wake_irq_support-v1-0-d2e22f4a0efd@oss.qualcomm.com/
> > > [2] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/
> > > 
> > 
> > I don't have a device to test this series right now. So could you please test
> > this series with the legacy binding and make sure it is not breaking?
> > 
> > Once you confirm, I'll merge this series.
> > 
> I have verified with legacy binding with this change and it is working fine.
> 

Thanks! Could you please rebase this series on top of pci/controller/qcom and
resend?

- Mani

-- 
மணிவண்ணன் சதாசிவம்


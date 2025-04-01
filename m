Return-Path: <linux-pci+bounces-25037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D34A774DC
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 09:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3D63AA165
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 07:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C657D1DEFE1;
	Tue,  1 Apr 2025 07:01:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB78727468;
	Tue,  1 Apr 2025 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743490885; cv=none; b=TDOLblzHg1rcLhE0pi7IZc33d8pXqay+hGkhbItQBFpHezHybmLAXdnMGxiTVLTT8fvQ6jLCVoKesw5PePUQRDfg0zb3flowsJeJklIYa2nTgDMcQ8Gbv3CBHoLqr/aUWdmjwfhvh+lwgTAx8gS8xUSjOauP/B+BaBmLqBV5HbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743490885; c=relaxed/simple;
	bh=LYcTnk9vNpR0xE4en0Ur3+c7WTocy2FJx7447PBD7hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDk/cpUtEZ2ublbawwzjKXy+BbgxfukgCSh8LScUevWT/9WoRF1kcMp9CxH7Lrww4DYKPjhz3THFljir5YKsJcZbi2STADptw/XUOa8D/Nhxalg5pGrbxQZ69SfV94NiKrVUB04gEKGOdJpBA+yrIpOm4+Kn+/ZZcTba3OR0QEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C94F02C50694;
	Tue,  1 Apr 2025 09:01:07 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9E4634999; Tue,  1 Apr 2025 09:01:12 +0200 (CEST)
Date: Tue, 1 Apr 2025 09:01:12 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com
Subject: Re: [PATCH 2/2] PCI: Add support for PCIe wake interrupt
Message-ID: <Z-uPOLNPIgm63PWY@wunner.de>
References: <20250401-wake_irq_support-v1-0-d2e22f4a0efd@oss.qualcomm.com>
 <20250401-wake_irq_support-v1-2-d2e22f4a0efd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401-wake_irq_support-v1-2-d2e22f4a0efd@oss.qualcomm.com>

On Tue, Apr 01, 2025 at 10:12:44AM +0530, Krishna Chaitanya Chundru wrote:
> PCIe wake interrupt is needed for bringing back PCIe device state
> from D3cold to D0.
> 
> Implement new functions, of_pci_setup_wake_irq() and
> of_pci_teardown_wake_irq(), to manage wake interrupts for PCI devices
> using the Device Tree.
> 
> From the port bus driver call these functions to enable wake support
> for bridges.
[...]
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -695,6 +695,10 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  	if (type == PCI_EXP_TYPE_RC_EC)
>  		pcie_link_rcec(dev);
>  
> +	status = of_pci_setup_wake_irq(dev);
> +	if (status)
> +		return status;
> +
>  	status = pcie_port_device_register(dev);
>  	if (status)
>  		return status;
> @@ -728,6 +732,8 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>  		pm_runtime_dont_use_autosuspend(&dev->dev);
>  	}
>  
> +	of_pci_teardown_wake_irq(dev);
> +
>  	pcie_port_device_remove(dev);
>  
>  	pci_disable_device(dev);

Why doesn't the teardown order mirror the probe order, i.e. why is
of_pci_teardown_wake_irq() called *before* pcie_port_device_remove()
instead of after?

(pcie_port_device_remove() is the opposite of pcie_port_device_register().)

Also, why is it safe to bail out of probe on failure of
of_pci_setup_wake_irq() without unwinding whatever pcie_link_rcec()
has done?  I think this needs either an explanation or reordering.

Thanks,

Lukas


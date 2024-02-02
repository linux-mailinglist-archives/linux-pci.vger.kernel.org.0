Return-Path: <linux-pci+bounces-2998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BEC846B91
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 10:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD731F280DF
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 09:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D8974267;
	Fri,  2 Feb 2024 09:10:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A83960DF4;
	Fri,  2 Feb 2024 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865017; cv=none; b=ndm4/GUjX3acTBrDbNq62raDIcG/jORlg44eBomtdN8krjrMa4cEVOXF//KVVL6qKYcR4XN6ZpL26feIYe8gG/+G07N5XG36HXAp9yppn5JxdATmjXQKVraxUjuUPDCxpworTcS7+Pd0yeWusESTA8720436EGZJI3rHVSJP75Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865017; c=relaxed/simple;
	bh=9Lw3yyGGfLfAKvtWSVgcJ3MOHZlqdZ5nHi2QTFG85R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ek7OA4WoFSxRM2ZA5m5PqGMi1yhxUQlXgByeIVQQwK6vgsxR6bjTxdTjLdn4212N1q8+4fiZ+dk7xVBMnd06hGSQQtGQrhWzVV1O/UDIqJAlaDWmfqFrI/XyMoQjkXSrSrUX3sI58CiSZP2eE1ImRl1pPvWHtBe1i1z5Rjez55U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 99FF62800B3D2;
	Fri,  2 Feb 2024 10:00:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8C6CE2F6385; Fri,  2 Feb 2024 10:00:33 +0100 (CET)
Date: Fri, 2 Feb 2024 10:00:33 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kw@linux.com>, Rob Herring <robh@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	quic_krichai@quicinc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/2] Enable D3 support for Qualcomm bridges
Message-ID: <20240202090033.GA9589@wunner.de>
References: <20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 02, 2024 at 12:24:16PM +0530, Manivannan Sadhasivam wrote:
> This series enables D3 support for PCI bridges found in Qcom SoCs. Currently,
> PCI core will enable D3 support for PCI bridges only when the following
> conditions are met:
> 
> 1. Platform is ACPI based
> 2. Thunderbolt controller is used
> 3. pcie_port_pm=force passed in cmdline
> 
> While options 1 and 2 do not apply to Qcom SoCs, option 3 will make the life
> harder for distro maintainers. Due to this, runtime PM is also not getting
> enabled for the bridges.
> 
> Ideally, D3 support should be enabled by default for the recent PCI bridges,
> but we do not have a sane way to detect them. So this series adds a new flag
> "bridge_d3_capable" to "struct pci_dev" which could be set by the bridge
> drivers for capable devices. This will allow the PCI core to enable D3
> support for the bridges during enumeration.

I think the right way to do this is to use the existing call to
platform_pci_bridge_d3() in pci_bridge_d3_possible().

Please amend platform_pci_bridge_d3() to call a new of_pci_bridge_d3()
function which determines whether D3 is supported by the platform.

E.g. of_pci_bridge_d3() could contain a whitelist of supported VID/DID
tuples.  Or it could be defined as a __weak function which always
returns false but can be overridden at link time by a function
defined somewhere in arch/arm/, arch/arm64/ or in some driver
whose Kconfig option is enabled in Qualcomm platforms.

Adding a bit to struct pci_dev essentially duplicates the existing
platform_pci_bridge_d3() functionality, which seems inelegant.
It increases the size of struct pci_dev even on platforms which
don't need it (e.g. ACPI).

Thanks,

Lukas


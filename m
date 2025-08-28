Return-Path: <linux-pci+bounces-35007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254E0B39D57
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD968171824
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3B130C605;
	Thu, 28 Aug 2025 12:33:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE3F145B16;
	Thu, 28 Aug 2025 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384386; cv=none; b=KdLaT6cLC9/0JyQrPU2IVGMiTjXeCsNj6jBWhV7cdIxW0ihe4OElPePrXNppDoc2C06iNQhFE3TNtMcIbH7QaOnR7EIqONBcHK/M2VumzY3NdrlO3GjA1Md/AbDL3d29d2sjJmanwHgsmdG4NxwR8l+VENBWGME641AcPQ+UfBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384386; c=relaxed/simple;
	bh=4+KJ+Kkm+a9h5spaJ5UWIVT2oZP76H7I8YbeBR+5ZUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umjDUl3/izrSO3DI1zk0Xxq2Ewf6TLvCov5BDgZXL9TZR4/0HUbmCKcFk/dxmM9dwON4b64O98K2ubx8fORvITS3DjVOLNh2yszyj3cHvKqu2Ndnqvjh0kUfPm6x6b+NpbkXm/4+nXtsbqzN0QRvw5xQ7TA2yIUWoJRUS1INyU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 23AC82C051CD;
	Thu, 28 Aug 2025 14:32:54 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id F2EB14E6B25; Thu, 28 Aug 2025 14:32:53 +0200 (CEST)
Date: Thu, 28 Aug 2025 14:32:53 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, quic_vbadigan@quicnic.com,
	amitk@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	Dmitry Baryshkov <lumag@kernel.org>,
	Shawn Anastasio <sanastasio@raptorengineering.com>,
	Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v6 7/9] PCI: Add pcie_link_is_active() to determine if
 the link is active
Message-ID: <aLBMdeZbsplpPIsX@wunner.de>
References: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
 <20250828-qps615_v4_1-v6-7-985f90a7dd03@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-qps615_v4_1-v6-7-985f90a7dd03@oss.qualcomm.com>

On Thu, Aug 28, 2025 at 05:39:04PM +0530, Krishna Chaitanya Chundru wrote:
> Add pcie_link_is_active() a common API to check if the PCIe link is active,
> replacing duplicate code in multiple locations.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>

I think the submitter of the patch (who will become the git commit author)
needs to come last in the Signed-off-by chain.

> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -614,8 +587,8 @@ static void pciehp_ignore_link_change(struct controller *ctrl,
>  	 * Synthesize it to ensure that it is acted on.
>  	 */
>  	down_read_nested(&ctrl->reset_lock, ctrl->depth);
> -	if (!pciehp_check_link_active(ctrl) || pciehp_device_replaced(ctrl))
> -		pciehp_request(ctrl, ignored_events);
> +	if (!pcie_link_is_active(ctrl_dev(ctrl)) || pciehp_device_replaced(ctrl))
> +		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
>  	up_read(&ctrl->reset_lock);
>  }

You can just use "pdev" instead of "ctrl_dev(ctrl)" as argument to
pcie_link_is_active() to shorten the line.

With that addressed,
Reviewed-by: Lukas Wunner <lukas@wunner.de>


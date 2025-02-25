Return-Path: <linux-pci+bounces-22311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E19A0A43A63
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 10:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C3E167D6F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44E725D541;
	Tue, 25 Feb 2025 09:54:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD53C1519A5;
	Tue, 25 Feb 2025 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477258; cv=none; b=AtDhj+0dSZ9L0v3jet7RRklnK6dQE6wRllPg0bjkcDnbw+sIoiIoxeSLw88X3cGDYDQPeUkarHTSHHgehfh/2d1BQCmkMkAXrkk/z8qJRMyPqNZtB8bTMDkv/csnRNUMsA3IcaGWR493acVucfbvh4VEDPzljfZuDse5Mz4Ia/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477258; c=relaxed/simple;
	bh=W1xxEv4UrVRBlCTYkmzY9cCkgMJhYTDLgWq3+WP6ClQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSUQPEmOWK1dq/xc/fVfUgO57WxdNTdgrvsjThzCGF+HaFWJ8nCgsGvdk3U8sOW/Ks2M3NtoveCAKlxKR8ZvS+omxFraRJg5hpENs9KtW31wIKdeTxbcXPU7dzNx1ncVSacPOZleJC0mjVd++wgSRDH+uzQ9y7iijJiaZt4rNSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id AE190100DA1B4;
	Tue, 25 Feb 2025 10:54:12 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8318D64E7F0; Tue, 25 Feb 2025 10:54:12 +0100 (CET)
Date: Tue, 25 Feb 2025 10:54:12 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
	amitk@kernel.org, dmitry.baryshkov@linaro.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	jorge.ramirez@oss.qualcomm.com
Subject: Re: [PATCH v4 07/10] PCI: PCI: Add pcie_is_link_active() to
 determine if the PCIe link is active
Message-ID: <Z72TRBvpzizcgm9S@wunner.de>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-7-e08633a7bdf8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-qps615_v4_1-v4-7-e08633a7bdf8@oss.qualcomm.com>

On Tue, Feb 25, 2025 at 03:04:04PM +0530, Krishna Chaitanya Chundru wrote:
> Introduce a common API to check if the PCIe link is active, replacing
> duplicate code in multiple locations.
[...]
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -234,18 +234,7 @@ static void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
>   */
>  int pciehp_check_link_active(struct controller *ctrl)
>  {
> -	struct pci_dev *pdev = ctrl_dev(ctrl);
> -	u16 lnk_status;
> -	int ret;
> -
> -	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> -	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
> -		return -ENODEV;
> -
> -	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> -	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
> -
> -	return ret;
> +	return pcie_is_link_active(ctrl_dev(ctrl));
>  }

Please replace all call sites of pciehp_check_link_active() with a call
to the new function.


> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4923,8 +4922,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  		if (!dev->link_active_reporting)
>  			return -ENOTTY;
>  
> -		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
> -		if (!(status & PCI_EXP_LNKSTA_DLLLA))
> +		if (pcie_is_link_active(dev))
>  			return -ENOTTY;

Missing negation.


> +/**
> + * pcie_is_link_active() - Checks if the link is active or not
> + * @pdev: PCI device to query
> + *
> + * Check whether the link is active or not.
> + *
> + * If the config read returns error then return -ENODEV.
> + */
> +int pcie_is_link_active(struct pci_dev *pdev)

Why not return bool?

I don't quite like the function name because in English the correct word
order is subject - predicate - object, i.e. pcie_link_is_active() or
even shorter, pcie_link_active().


> @@ -2094,6 +2095,10 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  {
>  	return -ENOSPC;
>  }
> +
> +static inline int pcie_is_link_active(struct pci_dev *dev)
> +{ return -ENODEV; }
> +
>  #endif /* CONFIG_PCI */

Is the empty inline really necessary?  What breaks if you leave it out?

Thanks,

Lukas


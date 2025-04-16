Return-Path: <linux-pci+bounces-26022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8B5A90972
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 18:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6475A5A0833
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 16:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2E72144D4;
	Wed, 16 Apr 2025 16:57:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBD32135B7;
	Wed, 16 Apr 2025 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822642; cv=none; b=GNGo7LdR6u7dB9+GekoAY9CHZbZId2AfQJobkAtJazN+c87Irf1T47WdK4cic0pO9pefLPcRrvJlxxYVhFXsi98t52fLmjGKb29f4xuUR6OX7xWpRbGtGvm7CgzcNNFZbTr7WRVHLtM4MvBI9T+olwNFWv6Fd5IbyI9Gu393JYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822642; c=relaxed/simple;
	bh=Zt/tQFUbpSmz7S4t/UplGM4xSmdA/oN6XTSYkpTWm80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8ODgZiL4gnsKgvh5PxtEtRHaIcEC+4h4EEZL1RHSE/pKhfl++osiIdd/2OQLR+vsnle3UyieMC/Wx3TcX1qKf+zFMwTBhU0l5+z1iYOZSAMnZGKzIsCPSZMdAkBMKuxa8GdLJRF7ZWJB7aZzSYwKTOJwdCua5z4HM9aCDhopY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2807E200A2AD;
	Wed, 16 Apr 2025 18:57:05 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 674D217601D; Wed, 16 Apr 2025 18:57:11 +0200 (CEST)
Date: Wed, 16 Apr 2025 18:57:11 +0200
From: Lukas Wunner <lukas@wunner.de>
To: manivannan.sadhasivam@linaro.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kw@linux.com>, Rob Herring <robh@kernel.org>,
	dingwei@marvell.com, cassel@kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] PCI: Add link down handling for host bridges
Message-ID: <Z__hZ2M8wDHn2XSn@wunner.de>
References: <20250416-pcie-reset-slot-v2-0-efe76b278c10@linaro.org>
 <20250416-pcie-reset-slot-v2-3-efe76b278c10@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416-pcie-reset-slot-v2-3-efe76b278c10@linaro.org>

On Wed, Apr 16, 2025 at 09:59:05PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -270,3 +270,30 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  
>  	return status;
>  }
> +
> +static pci_ers_result_t pcie_do_slot_reset(struct pci_dev *dev)
> +{
> +	int ret;
> +
> +	ret = pci_bus_error_reset(dev);
> +	if (ret) {
> +		pci_err(dev, "Failed to reset slot: %d\n", ret);
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}
> +
> +	pci_info(dev, "Slot has been reset\n");
> +
> +	return PCI_ERS_RESULT_RECOVERED;
> +}
> +
> +void pcie_do_recover_slots(struct pci_host_bridge *host)
> +{
> +	struct pci_bus *bus = host->bus;
> +	struct pci_dev *dev;
> +
> +	for_each_pci_bridge(dev, bus) {
> +		if (pci_is_root_bus(bus))
> +			pcie_do_recovery(dev, pci_channel_io_frozen,
> +					 pcie_do_slot_reset);
> +	}
> +}

Since pcie_do_slot_reset(), pcie_do_recover_slots() and
pcie_do_recover_slots() are only needed on platforms with a
specific host controller (and not, say, on x86), it would be good
if they could be kept e.g. in a library in drivers/pci/controller/
to avoid unnecessarily enlarging the .text section for everyone else.

One option would be the existing pci-host-common.c, another a
completely new file.

> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -966,6 +966,7 @@ int pci_aer_clear_status(struct pci_dev *dev);
>  int pci_aer_raw_clear_status(struct pci_dev *dev);
>  void pci_save_aer_state(struct pci_dev *dev);
>  void pci_restore_aer_state(struct pci_dev *dev);
> +void pcie_do_recover_slots(struct pci_host_bridge *host);
>  #else
>  static inline void pci_no_aer(void) { }
>  static inline void pci_aer_init(struct pci_dev *d) { }
> @@ -975,6 +976,26 @@ static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline void pci_save_aer_state(struct pci_dev *dev) { }
>  static inline void pci_restore_aer_state(struct pci_dev *dev) { }
> +static inline void pcie_do_recover_slots(struct pci_host_bridge *host)
> +{
> +	struct pci_bus *bus = host->bus;
> +	struct pci_dev *dev;
> +	int ret;
> +
> +	if (!host->reset_slot)
> +		dev_warn(&host->dev, "Missing reset_slot() callback\n");
> +
> +	for_each_pci_bridge(dev, bus) {
> +		if (!pci_is_root_bus(bus))
> +			continue;
> +
> +		ret = pci_bus_error_reset(dev);
> +		if (ret)
> +			pci_err(dev, "Failed to reset slot: %d\n", ret);
> +		else
> +			pci_info(dev, "Slot has been reset\n");
> +	}
> +}
>  #endif

Unusual to have such a large inline function in a header.
Can this likewise be moved to some library file and separated
from the other version via #ifdef please?

Thanks,

Lukas


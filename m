Return-Path: <linux-pci+bounces-25285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11825A7B955
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 10:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBBA3B6711
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 08:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB321A0BE0;
	Fri,  4 Apr 2025 08:52:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1851953AD;
	Fri,  4 Apr 2025 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743756724; cv=none; b=sBkB33p9O6qr116T1mt68fkAeVhOvhbKMPUk448VL7YcW9phNDYCatykhzS+QSraiD9Cirll9mQ1/tOu7H/7gstjl4vlrTM8htNusasq5g7CtiLjqiWVeYld/WhFt7IEX4PWFx2Xl02wkAorWGBHwx8I8lJpY9Iy5qJ+J8b16FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743756724; c=relaxed/simple;
	bh=ytfvydb71SW4qnHu5ZeuDqr6g+dawnF2MysvyNp8mD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJCClfcO1sXX9dGpXND8CTJQsd56pq+CudY3tpqw1in4hq9KKW62OGrbua4ARQLpfv2joLop0h6S6o5ykhn8qTH/tDwbrrK6qrgfyA0GBZl+PW5BUXwWKgMs27q4CvJYe06aK8vKgS7mnTvbJHFluTLwk1lwstd3p7KHhdS5lpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id E74F3200A2A0;
	Fri,  4 Apr 2025 10:46:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 282651212B; Fri,  4 Apr 2025 10:46:27 +0200 (CEST)
Date: Fri, 4 Apr 2025 10:46:27 +0200
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
Subject: Re: [PATCH 2/4] PCI/ERR: Add support for resetting the slot in a
 platforms specific way
Message-ID: <Z--cY5Uf6JyTYL9y@wunner.de>
References: <20250404-pcie-reset-slot-v1-0-98952918bf90@linaro.org>
 <20250404-pcie-reset-slot-v1-2-98952918bf90@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404-pcie-reset-slot-v1-2-98952918bf90@linaro.org>

On Fri, Apr 04, 2025 at 01:52:22PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> When the PCI error handling requires resetting the slot, reset it using the
> host bridge specific 'reset_slot' callback if available before calling the
> 'slot_reset' callback of the PCI drivers.
> 
> The 'reset_slot' callback is responsible for resetting the given slot
> referenced by the 'pci_dev' pointer in a platform specific way and bring it
> back to the working state if possible. If any error occurs during the slot
> reset operation, relevant errno should be returned.
[...]
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -234,11 +234,16 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	}
>  
>  	if (status == PCI_ERS_RESULT_NEED_RESET) {
> -		/*
> -		 * TODO: Should call platform-specific
> -		 * functions to reset slot before calling
> -		 * drivers' slot_reset callbacks?
> -		 */
> +		if (host->reset_slot) {
> +			ret = host->reset_slot(host, bridge);
> +			if (ret) {
> +				pci_err(bridge, "failed to reset slot: %d\n",
> +					ret);
> +				status = PCI_ERS_RESULT_DISCONNECT;
> +				goto failed;
> +			}
> +		}
> +

This feels like something that should be plumbed into
pcibios_reset_secondary_bus(), rather than pcie_do_recovery().

Note that in the DPC case, pcie_do_recovery() doesn't issue a reset
itself.  The reset has already happened, it was automatically done
by the hardware and all the kernel needs to do is bring up the link
again.  Do you really need any special handling for that in the
host controller driver?

Only in the AER case do you want to issue a reset on the secondary bus
and if there's any platform-specific support needed for that, it needs
to go into pcibios_reset_secondary_bus().

Thanks,

Lukas


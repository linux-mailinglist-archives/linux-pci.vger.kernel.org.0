Return-Path: <linux-pci+bounces-41808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD732C7540E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 17:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C0112345B98
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A9B3328F8;
	Thu, 20 Nov 2025 16:04:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EEC34DB4F;
	Thu, 20 Nov 2025 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654682; cv=none; b=JKvCCu2yO+lW1yoEowG/dE/zayPKZOxkSdVSnQXbxVKhj6QSjUgJkId9nUyxkSkmH8bRm0P2Rwmql0qz7rJvGMi78Ss8/qRnjd6eQC7Y6mKei3a2otQxOWEZJ92Q7fDxfLCrB7LTPyo2LOjDwkRpBAIb2dZSIyA4Kstk9vHOxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654682; c=relaxed/simple;
	bh=+o2uOVDrsTJD+u3jFYBePv0pT8Y6GXl+85tbGLhpj5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8D2mTt5m636cMcTuBDfC2Beeh0P2RJ+qnTDaxr1SA4iuezJ384W8BbF0FJG71dmMZmJII6eijMKzCYYlqc+aLIbT8jj033FScVuqvcEgYT2Y18zwOVENJmeNNmY17kkvMnch4dT7FsO6tC/LWityobuyIviOeAtFQK1RFtGqdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 297A72006F73;
	Thu, 20 Nov 2025 17:04:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 15D7018A6B; Thu, 20 Nov 2025 17:04:31 +0100 (CET)
Date: Thu, 20 Nov 2025 17:04:31 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: Add quirk to disable ASPM L1 for Sandisk SN740 NVMe
 SSDs
Message-ID: <aR88DxZST5r9Va2S@wunner.de>
References: <20251120154601.116806-1-mani@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120154601.116806-1-mani@kernel.org>

On Thu, Nov 20, 2025 at 09:16:01PM +0530, Manivannan Sadhasivam wrote:
> +++ b/drivers/pci/quirks.c
> @@ -2525,6 +2525,18 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>   */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>  
> +static void quirk_disable_aspm_l1(struct pci_dev *dev)
> +{
> +       pci_info(dev, "Disabling ASPM L1\n");
> +       pci_disable_link_state(dev, PCIE_LINK_STATE_L1);
> +}

Shouldn't this be using pcie_aspm_remove_cap()?  Existing quirks
were converted to this new helper with 30579eebba6a.

Thanks,

Lukas


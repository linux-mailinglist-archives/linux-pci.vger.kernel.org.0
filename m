Return-Path: <linux-pci+bounces-40853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DCDC4C922
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 10:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607B618906A2
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 09:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD41F220F21;
	Tue, 11 Nov 2025 09:08:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3CC21D5AA
	for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2025 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852101; cv=none; b=PJ24CXnGwwXlo7bLVAAr4P3fRkY/abHZtWUplgWJ/uVC7gprGxk/SvB/ATmOQrGl+pMZNm5xFxL8HNGZKVrc8rz77jS9M/8h9MAHZF57OmTX+/+Hycc0gUrkzqBDetKmXZaKrsoiVmglsexXY6XiXzB+Tkg3Uhu2BjdFVe13j/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852101; c=relaxed/simple;
	bh=SWsV4MBf1/Na31AVl6LetiBxeUNYZ1eAd9MkYpJgxug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQEIat068ErgHeHQgwM2G6BpV5GQKmGs5Eo8JM5Ih9jCTtqWGU7bqRmrcNwrWA1GRt5xzxVfNKSmrwO5yYf0vuWbe34mZwI/R3VNI5dthHeJTYIOSXGtM68MfNsKJqRnWN1SePXrJdGB2bCjhVR7DRyIVI56SuYa5nzPjPVdlkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 010232C05254;
	Tue, 11 Nov 2025 10:00:40 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D14ED2149; Tue, 11 Nov 2025 10:00:39 +0100 (CET)
Date: Tue, 11 Nov 2025 10:00:39 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4] PCI/PTM: Enable PTM only if it advertises a role
Message-ID: <aRL7Nx3J_wasTmll@wunner.de>
References: <20251111061048.681752-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111061048.681752-1-mika.westerberg@linux.intel.com>

On Tue, Nov 11, 2025 at 07:10:48AM +0100, Mika Westerberg wrote:
> +++ b/drivers/pci/pcie/ptm.c
> @@ -144,6 +147,38 @@ static int __pci_enable_ptm(struct pci_dev *dev)
>  			return -EINVAL;
>  	}
>  
> +	switch (pci_pcie_type(dev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +		/*
> +		 * Root Port must declare Root Capable if we want to enable
> +		 * PTM for it.
> +		 */
> +		if (!dev->ptm_root)
> +			return -EINVAL;
> +		break;
> +	case PCI_EXP_TYPE_UPSTREAM:
> +		/*
> +		 * Switch Upstream Ports must at least declare Responder
> +		 * Capable if we want to enable PTM for it.
> +		 */
> +		if (!dev->ptm_responder)
> +			return -EINVAL;
> +		break;
> +
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	case PCI_EXP_TYPE_LEG_END:
> +		/*
> +		 * PCIe Endpoint must declare Requester Capable before we
> +		 * can enable PTM for it.
> +		 */
> +		if (!dev->ptm_requester)
> +			return -EINVAL;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}

Nit:  Inconsistent newline before and after the endpoint case,
the other cases don't have that.  (Can probably be fixed up by
Bjorn when applying.)

Thanks,

Lukas


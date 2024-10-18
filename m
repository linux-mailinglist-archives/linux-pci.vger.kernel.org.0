Return-Path: <linux-pci+bounces-14859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA189A40A8
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 16:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552AD1C258DF
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 14:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E913413D52B;
	Fri, 18 Oct 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQE3CuTR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B217955887;
	Fri, 18 Oct 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260387; cv=none; b=h17AK5afz98lfyAXXP4UpdmZt5BrJDFo3v0fBXVkBNS+ldNzwGSotTai5tV4haO94buCgbG2gOwVVTHUHAo/dWCDsu1M4RmtZN5oH783VNeJA7RWxgo+ZwgpXjeraPmT2Y8UuY4Xcq1Db6ZA9wgS3xmXm9h+Kn7x+X6cfpZQuNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260387; c=relaxed/simple;
	bh=6qedp/1cR/o1KSVjTalt5dmCuTmnV7v54Ah+iXoIESg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz533p05mh4QOlOFe3b8tC+lks1x4ZaNqF7DTDJFY+zWIM8ysiB/aQeshisz9QsCXIBMEHeVQhO2FuVFPsTB5/TiEk1plQo0C1Pf35xfuI3ScD6yQ5pI1QgO8lcx4kSZjIuKWnMCy6nTsuFCW09xhQ829i5P9EKOxBcE2HsALH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQE3CuTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446DEC4CEC7;
	Fri, 18 Oct 2024 14:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729260387;
	bh=6qedp/1cR/o1KSVjTalt5dmCuTmnV7v54Ah+iXoIESg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQE3CuTRCoeagkP5b7EARaM6++2uNat4xsbjHrVnADwEl3AMieOVNbxZJOKTepdQU
	 3HxKm8c0edTAuieETAraX202dX3N2qUXTMl2VZRDosOzQNp+RHQI1Z6w4BQESGRQQa
	 P0pAfUych7wxs2DFWs2O9Qm3dwgWeGLMKbpcWS/AnwHY6K6iQCRgoUa/ZKKSkhWzCF
	 zOtOdCzJqpVCZoSNasPO1q7wWFUrOf2R9BsnnGBeA+yopDzKrjDdq/petRwLWhLIbJ
	 yqBg5Cr0JGU5+oiMtkpzQuRY2Q0A810cPD8CghmzlaZ+Cr1hDpb2WK3Vrc4F/GZcY/
	 18eu0nD20gUkw==
Date: Fri, 18 Oct 2024 16:05:43 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v3 4/6] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <ZxJrNwxEvXHx7QCn@ryzen.lan>
References: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
 <20241015-ep-msi-v3-4-cedc89a16c1a@nxp.com>
 <ZxJqITunljv0PGxn@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxJqITunljv0PGxn@ryzen.lan>

On Fri, Oct 18, 2024 at 04:01:05PM +0200, Niklas Cassel wrote:
> @@ -741,6 +756,32 @@ static void pci_epf_test_clear_bar(struct pci_epf *epf)
>  	}
>  }
>  
> +static void pci_epf_test_init_caps(struct pci_epf *epf)
> +{
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +	const struct pci_epc_features *epc_features = epf_test->epc_features;
> +	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> +	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +	u32 caps = 0;
> +
> +	reg->caps_magic = cpu_to_le32(CAPS_MAGIC);
> +	reg->caps_version = cpu_to_le32(CAPS_VERSION);
> +
> +	if (epc_features->msi_capable)
> +		caps |= CAPS_MSI_SUPPORT;
> +
> +	if (epc_features->msix_capable)
> +		caps |= CAPS_MSIX_SUPPORT;
> +
> +	if (epf_test->dma_supported)
> +		caps |= CAPS_DMA_SUPPORT;
> +
> +	if (epf_test->dma_private)
> +		caps |= CAPS_DMA_IS_PRIVATE;
> +
> +	reg->caps = cpu_to_le64(caps);

opps, this should have been cpu_to_le32(caps);


Kind regards,
Niklas


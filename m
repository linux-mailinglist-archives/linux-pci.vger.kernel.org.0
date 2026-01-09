Return-Path: <linux-pci+bounces-44385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 329CFD0B1B0
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 17:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0B5530A05E5
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 15:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DA5363C4B;
	Fri,  9 Jan 2026 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pB96RwPX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1135248881;
	Fri,  9 Jan 2026 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767974325; cv=none; b=Iv1QX4mNBG8DQMV63cWG61Gu7Bq8QpEsPqb10scUQ6bwXvsiXEFHTkQztgbst3rvfyWIX20Xz10Ea+skldbNi6+bVOsxg2t13M9x3MwxcclApuyyyXS9m7km6YqVoR0myD4CBiS05P3CGu43xpnx4O2TXchyMr/nemLMITugjFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767974325; c=relaxed/simple;
	bh=zfxA5myCPXZNE/DPAuqz+f1GTiaJZS2c+LBCvLR2duE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SM4Xqj7CCRrDcPpx611KccXWWtvkuYUbVGreoQDy6z0IjmFfpo11xjNYJ6BHsDWzbt5lakOaPn6F7LjZ8Ic8+8qJVo/u/lfm/HTNP3IOGCI5UtOMtHXcSZlzXyQhjFXPzx2/g6PgAyV0FLsGduD/KKRwFu2ozAyM+69XS3lNHKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pB96RwPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63875C4CEF1;
	Fri,  9 Jan 2026 15:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767974324;
	bh=zfxA5myCPXZNE/DPAuqz+f1GTiaJZS2c+LBCvLR2duE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pB96RwPX8XHpiGmMKa/7vGRqKCVClkHVAOJY8lETpUvsTPJDOCCN2GR1trYukqR1o
	 UKB20ff0A0eiuyFMiQNK5aBgO3wzZ2UNG4urcWaSmZTHKrTSdyFe/MWHKpZedfXQLh
	 5NpxVeqsfc8wkaghSUr5NrZTJTNzPEVHuoHPxD7jIDJiqER5FlR5DUgj04gVRoLbX4
	 u7PASy4zStXnwfAoapp2oILMwk6sKhyOgSZTQ96SyHocFjJKSEb+hMxumhnYPrVmAo
	 ZPDknLnaKu71DljFCVNympSMpz6UivIeWPoX/WPQO753Xm7EitO5jZhXTz/cGourI6
	 QI2vQz9VDEaoQ==
Date: Fri, 9 Jan 2026 09:58:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mani@kernel.org
Subject: Re: [PATCH] PCI: Add ACS quirk for Qualcomm Hamoa & Glymur
Message-ID: <20260109155843.GA547188@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-acs_quirk-v1-1-82adf95a89ae@oss.qualcomm.com>

On Fri, Jan 09, 2026 at 01:53:32PM +0530, Krishna Chaitanya Chundru wrote:
> The Qualcomm Hamoa & Glymur root ports don't advertise an ACS capability,
> but they do provide ACS-like features to disable peer transactions and
> validate bus numbers in requests.
> 
> So add an ACS quirk for Hamoa & Glymur.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Applied to pci/virtualization for v6.20, thanks!

> ---
>  drivers/pci/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b9c252aa6fe08a864cebe245f5dd7bf41fcc5116..75dee46f474a643cc79d112df1f5a57a9f6b95b1 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5107,6 +5107,10 @@ static const struct pci_dev_acs_enabled {
>  	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
>  	/* QCOM SA8775P root port */
>  	{ PCI_VENDOR_ID_QCOM, 0x0115, pci_quirk_qcom_rp_acs },
> +	/* QCOM Hamoa root port */
> +	{ PCI_VENDOR_ID_QCOM, 0x0111, pci_quirk_qcom_rp_acs },
> +	/* QCOM Glymur root port */
> +	{ PCI_VENDOR_ID_QCOM, 0x0120, pci_quirk_qcom_rp_acs },
>  	/* HXT SD4800 root ports. The ACS design is same as QCOM QDF2xxx */
>  	{ PCI_VENDOR_ID_HXT, 0x0401, pci_quirk_qcom_rp_acs },
>  	/* Intel PCH root ports */
> 
> ---
> base-commit: 623fb9912f6af600cda3b6bd166ac738c1115ef4
> change-id: 20260109-acs_quirk-0f8e83dc945e
> 
> Best regards,
> -- 
> Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 


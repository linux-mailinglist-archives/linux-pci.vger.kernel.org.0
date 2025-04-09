Return-Path: <linux-pci+bounces-25597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0AAA831BF
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 22:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E92719E5D27
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 20:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68751C84AA;
	Wed,  9 Apr 2025 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXKoVTsD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B159A15665C
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744229918; cv=none; b=EAIVmAKHgFz35RhKDPz4xAJuygz1UJXh4MH5IJL+b34C2FdUo0eLLDRd2RX9jfUb1nVqQYcXT2+JeBYuJodNuzx+t6K3jH0MOfbvezucVqKewey65M6Zd2HOx9jOAN60W1VzNUPaWAYViBe8eZ/TUYnqi9ACx/RCWnxstrHH5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744229918; c=relaxed/simple;
	bh=t4V4xiYmSHVkxJ/xl539ihMZlHB3Re6i+om/r9BDGe4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Nu9+mP1QNVjXuVpc/dn+mDX92DHY+fx/k798NJ0bFoWKNCg60bMcTy+Tpata0r3f266zlWb+st4jVV+jjcIoIGgJK4d80XljpB9jUNeKujfhEEtFw0OHHij6rHnF1GlpYo/gnfbXebzl7ZbkA6cxZ8nZmYeCXNxk5sjRdma3y9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXKoVTsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB08C4CEE2;
	Wed,  9 Apr 2025 20:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744229918;
	bh=t4V4xiYmSHVkxJ/xl539ihMZlHB3Re6i+om/r9BDGe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jXKoVTsD5vkOSwbTGLzr/ZPzl8QglrVQYtEIcLVUMtMtDTdrnyNfYr1V3ej5aUyZj
	 75Mzy2ErmERpz/gGSlifxq2+ixyXtAwbPmYPX5YcqPNDMce+y2/BZCdTJVNMawRX4T
	 o0QkfcMavMd/oYMS6gM1DF6LMKnIBf5DV9ofjYvYe4W4UIQgEMSdDoEyYjtbGr8Cj8
	 sVNmKK+WUZfWRdN6FZVBAl7aWm13jMPn6bT5FFgd+PIMxEzRxYW0/ybHVR4dBh7TUm
	 tOrckYzCu3mWhud+YM6xwI+G7Vha+4VDUg4g8bCQHGBmknQTEmlonEtEqgB+74aOee
	 KHu7ZMZTHx7tw==
Date: Wed, 9 Apr 2025 15:18:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 5/7] PCI: cadence: Update the PCIe controller register
 address offsets
Message-ID: <20250409201836.GA295223@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PPF4D26F8E1C900A703D6DA18E55E02FA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>

On Thu, Mar 27, 2025 at 11:41:36AM +0000, Manikandan Karunakaran Pillai wrote:
> Update the address offsets by removing the register bank offsets as
> register bank offset will be passed to the read and write functions

Add period at end of sentence.

> -#define CDNS_PCIE_HPA_LM_EP_FUNC_CFG		0x02c0
> +#define CDNS_PCIE_HPA_LM_EP_FUNC_CFG		(CDNS_PCIE_HPA_IP_REG_BANK + 0x02c0)

Pick either upper- or lowercase hex and use it consistently.  Most of
this patch uses uppercase.

>  static inline u32 cdns_reg_bank_to_off(struct cdns_pcie *pcie, enum cdns_pcie_reg_bank bank)
>  {
> -	u32 offset;
> +	u32 offset = 0x0;

No apparent reason for this initialization, since this doesn't change
the rest of the function.  Either the lack of initialization was a
defect and this should be split out to a bug fix patch, or it's not
needed at all.

>  	switch (bank) {
>  	case REG_BANK_IP_REG:
> @@ -668,7 +682,6 @@ static inline u32 cdns_reg_bank_to_off(struct cdns_pcie *pcie, enum cdns_pcie_re
>  	};
>  	return offset;
>  }
> -

Superfluous change, omit.

>  /* Register access */
>  static inline void cdns_pcie_writel(struct cdns_pcie *pcie, u32 reg, u32 value)
>  {


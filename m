Return-Path: <linux-pci+bounces-21763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24179A3A912
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 21:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D383B7EF2
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 20:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DD21E25E3;
	Tue, 18 Feb 2025 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpEU+jCM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033561D63CC;
	Tue, 18 Feb 2025 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910348; cv=none; b=FE3DRTTc7KJZSBdauVcmrOfN5elSKBLeJsAK2wx6RD4XUXI0p8y+6kF19c45oprBabRHvzL3YfiThBrr5unxHyBpzdZfzSbwZ46pADGwIT2qDUX6kc0TtjqgH0zD8tcmdyj5X+6ztqsR6U2YCKkzLy9H7hX0WH9GH9hC1f+z1A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910348; c=relaxed/simple;
	bh=RLervQf979kstkgoUrYWN04RQ6hrfhFVnDHU20XRDZo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sG1vtIPZzZF/ZC461R7gjDXAiilx5oM+DiWyEq0LsrQ8K18bL8UL+sXC/wr3CGiYpsY5jy2qGEUY8R6zJwjMvLPaCsvrzwVUx2wrmXHoEfNiyTCznAefOhXXw2EhUlPRqVL0EQjd1OTvAh70Ua8iewzNI8ZS//fJCgf8Mzz+SGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpEU+jCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFD6C4CEE4;
	Tue, 18 Feb 2025 20:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910347;
	bh=RLervQf979kstkgoUrYWN04RQ6hrfhFVnDHU20XRDZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cpEU+jCMGRMpzZ2LsCrYuDeOQr8uj/u/3r/DxNIWyPabKIAVhqs3CanHpl/261VjX
	 XJ5sLxzJWt+ZCDBK2kUoTv2hNRPNWQkS67F/PP6pg2bCgB2fZsh4cRRK0k1Lk0tM9F
	 LmqM2gPZ8SftTUPw9sETiM8HuNaZgfM/VVg7y5d49Hr8WF2V+v67WQTnkn8VkOhrsq
	 7Es9mVR/u9JmmCQvr0eFZ3gO3W7D8V6exoIIYASGUwYGcjAquNIG0ZNA78GYRpD2/9
	 ZuP8PKYBRxQzzyYRDIXlPoldtjrVhmsDv2Qlz8e2cEIp5ZdMWtkL5FGVdUnGTWMxxO
	 WKI9clUXzmDow==
Date: Tue, 18 Feb 2025 14:25:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH] PCI: Update Resizable BAR Capability Register fields
Message-ID: <20250218202545.GA177904@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218064003.238868-1-daizhiyuan@phytium.com.cn>

[+cc Christian]

On Tue, Feb 18, 2025 at 02:40:03PM +0800, Zhiyuan Dai wrote:
> This commit modifies the Resizable BAR Capability Register fields to better
> support varying BAR sizes. Additionally, the function `pci_rebar_get_possible_sizes`
> has been updated with a more detailed comment to clarify its role in querying
> and returning the supported BAR sizes.
> 
> For more details, refer to PCI Express庐 Base Specification Revision 5.0, Section 7.8.6.2.

Wrap to fit in 75 columns.

Drop "庐" above.

Update spec citation to r6.x.

Spec r6.0 defines BAR size up to 8 EB (2^63 bytes), but supporting
anything bigger than 128TB requires changes to
pci_rebar_get_possible_sizes() to read the additional Capability bits
from the Control register.

> Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
> ---
>  drivers/pci/pci.c             | 2 +-
>  include/uapi/linux/pci_regs.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 661f98c6c63a..03fe5e6e1d72 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3752,7 +3752,7 @@ static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
>   * @bar: BAR to query
>   *
>   * Get the possible sizes of a resizable BAR as bitmask defined in the spec
> - * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizable.
> + * (bit 0=1MB, bit 31=128TB). Returns 0 if BAR isn't resizable.
>   */
>  u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>  {
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 1601c7ed5fab..ce99d4f34ce5 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1013,7 +1013,7 @@
>  
>  /* Resizable BARs */
>  #define PCI_REBAR_CAP		4	/* capability register */
> -#define  PCI_REBAR_CAP_SIZES		0x00FFFFF0  /* supported BAR sizes */
> +#define  PCI_REBAR_CAP_SIZES		0xFFFFFFF0  /* supported BAR sizes */
>  #define PCI_REBAR_CTRL		8	/* control register */
>  #define  PCI_REBAR_CTRL_BAR_IDX		0x00000007  /* BAR index */
>  #define  PCI_REBAR_CTRL_NBAR_MASK	0x000000E0  /* # of resizable BARs */
> -- 
> 2.43.0
> 


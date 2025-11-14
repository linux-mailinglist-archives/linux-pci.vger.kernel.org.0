Return-Path: <linux-pci+bounces-41215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EDEC5BCD9
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 08:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 188483536BB
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 07:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9B824679F;
	Fri, 14 Nov 2025 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m76C0gKs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760B023D7CD
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763105729; cv=none; b=bJ3wv1ktnx5ha6kRzwye3Y48LEmUtnMfZwHoyM9A56Dj9HezdoMaMu7AeGrC9pXmAV6ySXpy4vsZ1xChefrEbCugxFhwVUQe43k4EnTpf8pIMTBdwdkv4XwUd+rUZ7FYF9hdwoKF0K8oCX9t0jXeR5v1TTc9KCtvFEl7Y9vAmY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763105729; c=relaxed/simple;
	bh=/3QomslLYwqNdjuYlCxTdbbjMi1oe8i67iBLZvyOUDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjJqRCVTUUNzXGtaYm2MVBKVXajkj3Uvat8MMRE8IeZGFYNiBqvjTmt0OIU4hWQ3hL0He7OWf2t3Ao/IwYX9GSluevdExkiueUpdLFuccUDWwFFD/GsZ6Dx0Rs/qlb9CpSwWE+zn3VNGyS7E+b07jxA7nq3qyz3mwqpAzPkaDVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m76C0gKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161C1C4CEF1;
	Fri, 14 Nov 2025 07:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763105729;
	bh=/3QomslLYwqNdjuYlCxTdbbjMi1oe8i67iBLZvyOUDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m76C0gKs5D7E/pcVpf7g9fhOpWaWfZuogb/HUZm5HBdIHTD2GcvRYWSLhq89MLgwb
	 Tnj6ndSA9E71wOqxPCUvOB+aZokHi5izeKuUYbU7Vv6VQlESUKuIk4pSEmldoTSIyH
	 IJAJjlcKk05hyK8bqKfAcS9GImQPUmInQHpSh6A1OUvm9TBjrDP5f+8gveRj2ecXYI
	 umf2cfiIVjFFhMw70KJDq3bwzhFEwqpQqsJNYGVy75mNe8b/5bYwDCNRgBBJOfrWfO
	 Em4Wt+tmTQk+ef8f1dkczf6qpl+KbOBEuDXNDkK92VJM7j3M1XILQo9gbI/v5Uoens
	 GvXhP3GFjHq+A==
Date: Fri, 14 Nov 2025 13:05:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Fix wrong PORT_LOGIC_LTSSM_STATE_MASK
 definition
Message-ID: <cmwjx6qbv57lhpedwpb7o2y2sn3mccf7pbdwtj6kdajoorawhs@fxdgr27cgg7q>
References: <1763102197-130089-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1763102197-130089-1-git-send-email-shawn.lin@rock-chips.com>

On Fri, Nov 14, 2025 at 02:36:37PM +0800, Shawn Lin wrote:
> Per DesignWare Cores PCI Express Controller Register Descriptions,
> section 1.34.11, PL_DEBUG0_OFF is the value on cxpl_debug_info[31:0].
> 
> Per DesignWare Cores PCI Express Controller Databook, section 5.50,
> SII: Debug Signals, cxpl_debug_info[63:0] says:
> "[5:0] smlh_ltssm_state: LTSSM current state. Encoding is same as the dedicated
> smlh_ltssm_state output."
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

No fixes tag?

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index e995f692a1ec..24bfa5231923 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -97,7 +97,7 @@
>  #define PORT_LANE_SKEW_INSERT_MASK	GENMASK(23, 0)
>  
>  #define PCIE_PORT_DEBUG0		0x728
> -#define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
> +#define PORT_LOGIC_LTSSM_STATE_MASK	0x3f
>  #define PORT_LOGIC_LTSSM_STATE_L0	0x11
>  #define PCIE_PORT_DEBUG1		0x72C
>  #define PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
> -- 
> 2.43.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்


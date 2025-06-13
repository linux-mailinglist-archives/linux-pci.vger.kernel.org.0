Return-Path: <linux-pci+bounces-29739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBDFAD90A8
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1542B3AED58
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 15:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF8A1DED5F;
	Fri, 13 Jun 2025 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QxYTl3Ul"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FCB29CEB;
	Fri, 13 Jun 2025 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827004; cv=none; b=bE+4pLqMeiwZvtpI7Qcq5CCES+C/aEnfXGH84xoCQ+TQ4He0xFaWV9k3e7GSndZj5dLQ81iuE2/B/5NerzEIUgNCVFzaqrGaBZehg/HHFCjyXI6Ms3h0L0rSgYdicgpOvq+iwfZ+6fY6nM8NhoP4PbagZ/Smfaizv7hKZdHPWSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827004; c=relaxed/simple;
	bh=lmsC6NuVWnVy+Dsfq0irR7B12PqvUPA3RWEtvjKTL2I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YigiHBovAITx72yoP4KVfGDNAAcobs68rw/IszuOQoUWVrNf1akAt1Zj7GizKGWqhGJfPil6IDNWnNsrfmpetTH5ualTqtHWV6gUzsZVwWZwiM7rctHEjMb2+7lPAyyTASeipxRAgXqN4tn+FJQnmjkSsP522sV9uaXdAP9ACI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QxYTl3Ul; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749827003; x=1781363003;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lmsC6NuVWnVy+Dsfq0irR7B12PqvUPA3RWEtvjKTL2I=;
  b=QxYTl3Ul40DeJ1cPsRk+9ot2dD4OBeg+XsIjI317QPcyB28OU65StIWi
   job1g/2aQihOt8ZPLxC6x/K55cv9hBtnlvZtE/gPOC/ywlec5z7Vuszt9
   SANJgZgJGVzIhpyz9Ky1HR3F/VG1m4ljpMDWcMj6uhNiULxt+PIbaWXGF
   tMrax/rGi+h7bZLfLX1zuahktm4jE2srsEwcDB6mYDH1q8hJXlbGq3UYO
   BMKVYoO23FXHqYjCsLqouqH2rzR2FhUE/m815lqgyHkTSRAThBS9SUWz7
   GXpz9ctJLKZtM2dL7l0BzN7JPOUQqpidRTaTlr29JVVobSd3dx9K7tOSQ
   g==;
X-CSE-ConnectionGUID: nuoWpjn7RGeoLCFpl3VbkA==
X-CSE-MsgGUID: diApV+ZRSB+9V0/wDeJP5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="55718053"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="55718053"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 08:03:23 -0700
X-CSE-ConnectionGUID: wEeUUgUfTD2/YHByLcKAww==
X-CSE-MsgGUID: Zw0bhwMyS9KD3iB4u6xSBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="148320085"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.102])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 08:03:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 13 Jun 2025 18:03:14 +0300 (EEST)
To: Geraldo Nascimento <geraldogabriel@gmail.com>
cc: linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
    Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
    linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 2/5] PCI: rockchip: Drop unused custom registers
 and bitfields
In-Reply-To: <ed25d30f2761e963164efffcfbe35502feb3adc2.1749826250.git.geraldogabriel@gmail.com>
Message-ID: <97114c68-5eb7-18b0-adbd-227e1d7957c6@linux.intel.com>
References: <cover.1749826250.git.geraldogabriel@gmail.com> <ed25d30f2761e963164efffcfbe35502feb3adc2.1749826250.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 13 Jun 2025, Geraldo Nascimento wrote:

> Since we are now using standard PCIe defines, drop
> unused custom-defined ones, which are now referenced
> from offset at added Capabilities Register.

These are quite short lines, please reflow the changelog paragraphs to the 
usual length.

> Suggested-By: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip.h | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 5864a20323f2..f611599988d7 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -155,16 +155,7 @@
>  #define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
>  #define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
>  #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
> -#define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
> -#define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
> -#define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
> -#define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
> -#define PCIE_RC_CONFIG_DCSR		(PCIE_RC_CONFIG_BASE + 0xc8)
> -#define   PCIE_RC_CONFIG_DCSR_MPS_MASK		GENMASK(7, 5)
> -#define   PCIE_RC_CONFIG_DCSR_MPS_256		(0x1 << 5)
> -#define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE + 0xcc)
> -#define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
> -#define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
> +#define PCIE_RC_CONFIG_CR		(PCIE_RC_CONFIG_BASE + 0xc0)

This will cause a build failure because PCIE_RC_CONFIG_CR is used in 1/5 
but only introduced here so you'll need to do this in the same patch as 
any step within a series must build too. IMO it would anyway make sense to 
combine patches 1 & 2.

>  #define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)

Aren't you going to convert this as well?

>  #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
>  #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
> 

-- 
 i.



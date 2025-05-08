Return-Path: <linux-pci+bounces-27467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0250CAB05F8
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 00:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767A11722E1
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 22:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE87420E700;
	Thu,  8 May 2025 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NSlFTtM+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8AF8F6F;
	Thu,  8 May 2025 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746743548; cv=none; b=qbLwnmqQuZtPm+/OEx2Sl6TU8RHOkanmS+4t7E/srtbH8u+UtcLnmY7ElD3aWaFda8gJSIuEWrU5Hhg5GNY1yC0Wjmsc5ykb8B1XB7Sz7+6rC64XtQSJ5m4qHhPjKEE51gLy/HSSWE6CyndzrKAAdCYN8Q9bhowP+cZXCqTRvw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746743548; c=relaxed/simple;
	bh=LN9H+wRwP3Oc6QAiNWdj+F+8WkxOXU1ZzLvlexhRPLs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PhhEVVELbQtGu2pInn+2d2Je37M6o+rtXqMQuRR1j0epZUrmXChqWf4a/lbFAbSQqQsyLQVoUsq9tVWjjFjNkwbggiB0SdiNLgWCxGxf8qJHZSPXHeGqlPPyokE1cd214x8tSrJP2+A0zAX2meivtmRWPIvbGAbpZDmtSKwgNIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NSlFTtM+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746743547; x=1778279547;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LN9H+wRwP3Oc6QAiNWdj+F+8WkxOXU1ZzLvlexhRPLs=;
  b=NSlFTtM+pGLrVe3HsTcU+GspL8A6YHiIHlLj/TH6EZEnTo9PoTB8Pe0A
   O/wD4kgLW5u/8Ij33X6k/clXts9f0ag7ZeWoTvB1DnkMk6p7l9G4F4V7O
   gncKk11qGD+cSiAkrud789dAgXwmxT/Al/D381p7GhT22zKpr0IbMFZtY
   EuEl9iiJsz3Jf5L4Nk/DFYvK9IOvPHiH5rm/DKJz7GgNwq5eEUP5stgya
   NIUbHY4+d0lkGBEWBE8zBiBtGQ9a/06P7Xripvvgh929k0M1rTCAI82Vs
   3llheYVSgY12pKOlQBuk+gXas3S06QT4hQyfXdE2MUqRawT1ByT6/P3FS
   A==;
X-CSE-ConnectionGUID: Hm3cn4ysS5i9pTjQh+Ay9Q==
X-CSE-MsgGUID: 8COFjpLQS4+gGcWZFgK1qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59953211"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="59953211"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 15:32:26 -0700
X-CSE-ConnectionGUID: mEEQIAKWSwyhic4DI5aBoQ==
X-CSE-MsgGUID: M+Se2rK5TliUbPOIBXV3Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="141539203"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 15:32:26 -0700
Date: Thu, 8 May 2025 15:32:25 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
To: "Rob Herring (Arm)" <robh@kernel.org>
cc: Thomas Gleixner <tglx@linutronix.de>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Joyce Ooi <joyce.ooi@intel.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, 
    devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
    matthew.gerlach@altera.com
Subject: Re: [PATCH] dt-bindings: Move altr,msi-controller to interrupt-controller
 directory
In-Reply-To: <20250507154253.1593870-1-robh@kernel.org>
Message-ID: <54171dee-9985-536d-f7a6-b2a4af1ed9bd@linux.intel.com>
References: <20250507154253.1593870-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Wed, 7 May 2025, Rob Herring (Arm) wrote:

> While altr,msi-controller is used with PCI, it is not a PCI host bridge
> and is just an MSI provider. Move it with other MSI providers in the
> 'interrupt-controller' directory.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> .../{pci => interrupt-controller}/altr,msi-controller.yaml      | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> rename Documentation/devicetree/bindings/{pci => interrupt-controller}/altr,msi-controller.yaml (94%)
>
> diff --git a/Documentation/devicetree/bindings/pci/altr,msi-controller.yaml b/Documentation/devicetree/bindings/interrupt-controller/altr,msi-controller.yaml
> similarity index 94%
> rename from Documentation/devicetree/bindings/pci/altr,msi-controller.yaml
> rename to Documentation/devicetree/bindings/interrupt-controller/altr,msi-controller.yaml
> index 98814862d006..d046954b8a27 100644
> --- a/Documentation/devicetree/bindings/pci/altr,msi-controller.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/altr,msi-controller.yaml
> @@ -2,7 +2,7 @@
> # Copyright (C) 2015, 2024, Intel Corporation
> %YAML 1.2
> ---
> -$id: http://devicetree.org/schemas/altr,msi-controller.yaml#
> +$id: http://devicetree.org/schemas/interrupt-controller/altr,msi-controller.yaml#
> $schema: http://devicetree.org/meta-schemas/core.yaml#
>
> title: Altera PCIe MSI controller
> -- 
> 2.47.2
>
>


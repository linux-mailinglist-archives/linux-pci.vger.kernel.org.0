Return-Path: <linux-pci+bounces-40321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5A1C34886
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 09:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173333A4C94
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 08:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31F12D6E6A;
	Wed,  5 Nov 2025 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="auPnU0p5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9338A2C11CB;
	Wed,  5 Nov 2025 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332216; cv=none; b=LTtSRVnl8mrQowLGE3rqQPvTTJkHfbCEaMJqEboPXAiSmiN7m7QXMTdZJ+eACZn69m4kqIsObzEcZ7ZN/RnZX/lGbOCrYtjzZ9t09KvAe5oiD0QO7OXFSzwvp7faplfvX0XY5QEzbccMndzfSaJWs/TelZAxAP5q6bInie3c2us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332216; c=relaxed/simple;
	bh=Jm5vpWG5lhz9geT3g9EURfv4wYR+y8hhhF/kwSAvQfk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LDl+aZBRj4Zs9WfrI/fIYQNRCnelhcR/QjG3DeAvzzTPimdr6aRLVviexXQ5Z6oCL5yWf89B4WLHC5vlkju4t2VLNf4EfcdJN/vXJitGM/yGgk3WUBLrv5aF8PIU/yTMpsCK715s8EYnYgIl83A0673X0x6AR+pYv4kd+o7LKhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=auPnU0p5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762332215; x=1793868215;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Jm5vpWG5lhz9geT3g9EURfv4wYR+y8hhhF/kwSAvQfk=;
  b=auPnU0p5B2IilHTxbTjFeeDeyulaDswKXKynbXvOKSGiSGFOFzGMPyA+
   CayHCfUuJP2kgSip51SKAlGZtXIYsZ4swQ0s1tbVP6Dyopu1Y7c/CKyBZ
   56NPh0uqlT+dJXwD/NWam3sVUcnLsaoNWX8bTBpgUbTI5cTCUuo2TwzMU
   4tSUJFAdW1z8cTNdtuT4x5GInBCJQ7T8wbrHVeCD7e76mVMCipi7Jsh7w
   C8YjAkSJ3MN5f1awBspgb++l8QBSOdkhTjaCapYf4KBAgP3Xr2cCe+n2+
   lHzLwlIVNwrqEP+KxPyZrpRmOGyY0wEJZQBIjCy/ZdhZPLeNHktt0TA5J
   g==;
X-CSE-ConnectionGUID: 0LGFIlVvTqmN/tnmnbnqdg==
X-CSE-MsgGUID: /AEmlJMpT9utRvgG4A8sIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="63644981"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="63644981"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 00:43:34 -0800
X-CSE-ConnectionGUID: 0UXn4DZAT9SxR2F5bWPrxA==
X-CSE-MsgGUID: yADcEnvnTYivVfSyhgfXaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="186685094"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.252])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 00:43:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 5 Nov 2025 10:43:27 +0200 (EET)
To: Hans Zhang <18255117159@163.com>
cc: bhelgaas@google.com, helgaas@kernel.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v3 1/1] PCI: of: Relax max-link-speed check to support
 PCIe Gen5/Gen6
In-Reply-To: <20251101164132.14145-1-18255117159@163.com>
Message-ID: <6fdc4f2c-16fa-9aed-6580-759e229e5606@linux.intel.com>
References: <20251101164132.14145-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 2 Nov 2025, Hans Zhang wrote:

> The existing code restricted `max-link-speed` to values 1~4 (Gen1~Gen4),
> but current SOCs using Synopsys/Cadence IP may require Gen5/Gen6 support.
> 
> While DT binding validation already checks this property, the code-level
> validation in `of_pci_get_max_link_speed` also needs to be updated to allow
> values up to 6, ensuring compatibility with newer PCIe generations.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
> Changes for v3:
> - Modify the commit message.
> - Add Reviewed-by tag.
> 
> Changes for v2:
> https://patchwork.kernel.org/project/linux-pci/cover/20250529021026.475861-1-18255117159@163.com/
> - The following files have been deleted:
>   Documentation/devicetree/bindings/pci/pci.txt
> 
>   Update to this file again:
>   dtschema/schemas/pci/pci-bus-common.yaml
> ---
>  drivers/pci/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f1198..53928e4b3780 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -890,7 +890,7 @@ int of_pci_get_max_link_speed(struct device_node *node)
>  	u32 max_link_speed;
>  
>  	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
> -	    max_link_speed == 0 || max_link_speed > 4)
> +	    max_link_speed == 0 || max_link_speed > 6)
>  		return -EINVAL;
>  
>  	return max_link_speed;
> 

Hi,

IMO, using a literal here is somewhat annoying as it's hard to find this 
spot when adding support to the next PCIe Link Speed. It would be nice if 
it could get updated at the same while the generic support for a new Link 
Speed is added.

Perhaps include/linux/pci.h should have something along the lines of:

static inline int pcie_max_supported_link_speed()
{
	return PCI_EXP_LNKCAP_SLS_64_0GB - PCI_EXP_LNKCAP_SLS_2_5GB + 1;
}

Then replace that 6 with pcie_max_supported_link_speed().

So when the next speed get's added, somebody grepping for 
PCI_EXP_LNKCAP_SLS_64_0GB will find pcie_max_supported_link_speed() has 
to be changed and the change will propagate also to of.c.

-- 
 i.



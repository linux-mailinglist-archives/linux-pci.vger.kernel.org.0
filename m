Return-Path: <linux-pci+bounces-34921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 897DEB38418
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 15:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36C51B6213C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98BE302CDE;
	Wed, 27 Aug 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+pCKIeV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF1928F1;
	Wed, 27 Aug 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302717; cv=none; b=upS+2Ft52UuOwvCKR2FGY7t5WUKUahc43m+HN+mJRqKysBIcPyQ9ci8yiRVQ02wTITDMh0DPIqYwdhjRbnWoihFeZVGH+A+O7/nJ0kECiuN620XHvrh/BpeBdkQeXRln6hX1KrCIqEM4DpbLrHx0GAZck9llyIdcoTqlaU2u2AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302717; c=relaxed/simple;
	bh=bDGV7GGXaBIBhhu9ubPKd1YOpjVPci+GfwgdUO3lnmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1LYZuCAsV9V2foN82X3frgaa7AM2AIdnJD8lX7h76F1Vt9JWbKwa+tGQgBfYiTya5/iMqQ72448g+walths53PogSN9ZdCJpcqT6bxQLg01jdVxDgVXeol/hJwVcTucdHaKUYOQ7YAELilTqOGmZX24PGkds8zlU9ATU4uIt1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+pCKIeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C852DC4CEEB;
	Wed, 27 Aug 2025 13:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756302717;
	bh=bDGV7GGXaBIBhhu9ubPKd1YOpjVPci+GfwgdUO3lnmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r+pCKIeVMtH32tdBaOxBO3TvACFgMOTkkgxI5e7y2Bb8GGOVFE/Uj+8U+IPU+tuVc
	 4yavSlf4bFtz9Qmyb8P8qmAhvOPiqlW08Hz2AWuhg0ZKsoDEza5JsHTgt7dK8558zx
	 aljn3hilRsdK9PpmF1n7jBvSbf8uwqV9px8qCH4HVyRUy59wXmpeLaOVZHFaTaJCBj
	 3l8RQTIwhlnkozB/Y2H1LQB+6K7T/ba7ABMRefkHtm4/1pH3S048T7bLyPKDy5sgTp
	 Csq4mr0zFqr8V7Fd32c2uyIl6fEm4vM2qtBhAazEmMtDufUE234MBCnj1/dt6eEFXZ
	 LXASUBpudX/7A==
Date: Wed, 27 Aug 2025 19:21:51 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/13] PCI: dwc: Refactor code by using
 dw_pcie_clear_and_set_dword()
Message-ID: <wi2mylqrf6szc5iluncle2lj373aoxu46lyy7d2gaqx4dv3abq@sja5aj5mwv3j>
References: <20250813044531.180411-1-18255117159@163.com>
 <20250813044531.180411-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250813044531.180411-3-18255117159@163.com>

On Wed, Aug 13, 2025 at 12:45:20PM GMT, Hans Zhang wrote:
> DesignWare core modules contain multiple instances of manual
> read-modify-write operations for register bit manipulation.
> These patterns duplicate functionality now provided by
> dw_pcie_clear_and_set_dword(), particularly in debugfs, endpoint,
> host, and core initialization paths.
> 
> Replace open-coded bit manipulation sequences with calls to
> dw_pcie_clear_and_set_dword(). Affected areas include debugfs register
> control, endpoint capability configuration, host setup routines, and
> core link initialization logic. The changes simplify power management
> handling, capability masking, and feature configuration.
> 
> Standardizing on the helper function reduces code duplication by ~140
> lines across core modules while improving readability. The refactoring
> also ensures consistent error handling for register operations and
> provides a single point of control for future bit manipulation logi
> updates.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  .../controller/dwc/pcie-designware-debugfs.c  | 66 +++++++---------
>  .../pci/controller/dwc/pcie-designware-ep.c   | 20 +++--
>  .../pci/controller/dwc/pcie-designware-host.c | 26 +++----
>  drivers/pci/controller/dwc/pcie-designware.c  | 75 +++++++------------
>  drivers/pci/controller/dwc/pcie-designware.h  | 18 +----
>  5 files changed, 76 insertions(+), 129 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index 0fbf86c0b97e..ff185b8977f3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -213,10 +213,8 @@ static ssize_t lane_detect_write(struct file *file, const char __user *buf,
>  	if (val)
>  		return val;
>  
> -	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
> -	val &= ~(LANE_SELECT);
> -	val |= FIELD_PREP(LANE_SELECT, lane);
> -	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG, val);
> +	dw_pcie_clear_and_set_dword(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG,
> +				    LANE_SELECT, FIELD_PREP(LANE_SELECT, lane));
>  
>  	return count;
>  }
> @@ -309,12 +307,11 @@ static void set_event_number(struct dwc_pcie_rasdes_priv *pdata,
>  {
>  	u32 val;
>  
> -	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> -	val &= ~EVENT_COUNTER_ENABLE;
> -	val &= ~(EVENT_COUNTER_GROUP_SELECT | EVENT_COUNTER_EVENT_SELECT);
> -	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SELECT, event_list[pdata->idx].group_no);
> +	val = FIELD_PREP(EVENT_COUNTER_GROUP_SELECT, event_list[pdata->idx].group_no);
>  	val |= FIELD_PREP(EVENT_COUNTER_EVENT_SELECT, event_list[pdata->idx].event_no);
> -	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> +	dw_pcie_clear_and_set_dword(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG,
> +				    EVENT_COUNTER_ENABLE | EVENT_COUNTER_GROUP_SELECT |
> +				    EVENT_COUNTER_EVENT_SELECT, val);
>  }
>  
>  static ssize_t counter_enable_read(struct file *file, char __user *buf,
> @@ -354,13 +351,10 @@ static ssize_t counter_enable_write(struct file *file, const char __user *buf,
>  
>  	mutex_lock(&rinfo->reg_event_lock);
>  	set_event_number(pdata, pci, rinfo);
> -	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> -	if (enable)
> -		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_ON);
> -	else
> -		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_OFF);
>  
> -	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> +	val |= FIELD_PREP(EVENT_COUNTER_ENABLE, enable ? PER_EVENT_ON : PER_EVENT_OFF);

So you just added the bitfields to the existing 'val' variable which was storing
the return value of kstrtou32_from_user().

What makes me nervous about this series is these kind of subtle bugs. It is
really hard to spot all with too many drivers/changes :/

I would suggest you to just convert whatever drivers you can test with and leave
the rest to platforms maintainers to convert later. I do not want to regress
platforms for cleanups.

> +	dw_pcie_clear_and_set_dword(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG,
> +				    0, val);

Similar to what Lukas suggested here: https://lore.kernel.org/linux-pci/aKDpIeQgt7I9Ts8F@wunner.de

Please use separate API for just setting the word instead of passing 0 to this
API.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


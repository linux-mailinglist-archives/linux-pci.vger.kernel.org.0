Return-Path: <linux-pci+bounces-38771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20976BF2381
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 17:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599623BABA7
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 15:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09A5275860;
	Mon, 20 Oct 2025 15:48:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B5B274B50;
	Mon, 20 Oct 2025 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975317; cv=none; b=dZVk8ei9FpMnwPcPky5pfjPBMMD5qRtVivvvJNru1d3CN4vcSLQGgfEn2/SmGPy3tZBfkn/ztfnM2YQsUZAKjfcX/ClvwsX2VxDDU+NJy/JK4s3leNQqJE/66k8hfSLuT/Gk9z3+PY63U3xBTlJn2LiHmAsADR/Q8cpfOedVskw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975317; c=relaxed/simple;
	bh=TJa4HRnXYmnNZYp/SmZM7dlE9FLDYxsv2Dt6hSzB7hE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLmQ+XhfxlcBl26vfT95TckhsI4cGGlDaobqbCJAkgR6UsbRStk/zyCiRbR+kj3BI8a0aKELovTv0wlYObLGnMiUC5exd1nC4xDWi1fAmCbL35xDqs04iyMpFMMvd86OZxxpQX969bwv4srS2GZkW8w/4gTkw3ppXjUaKtyhXOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cr09g12vjz6M4PN;
	Mon, 20 Oct 2025 23:44:55 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C8BB1402A5;
	Mon, 20 Oct 2025 23:48:32 +0800 (CST)
Received: from localhost (10.48.157.75) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Oct
 2025 16:48:31 +0100
Date: Mon, 20 Oct 2025 16:48:29 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, LKML
	<linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, "Alex
 Williamson" <alex.williamson@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>, Dan Williams
	<dan.j.williams@intel.com>
Subject: Re: [PATCH v1] PM: runtime: Fix conditional guard definitions
Message-ID: <20251020164829.00000f53@huawei.com>
In-Reply-To: <5943878.DvuYhMxLoT@rafael.j.wysocki>
References: <5943878.DvuYhMxLoT@rafael.j.wysocki>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 20 Oct 2025 17:03:28 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since pm_runtime_get_active() returns 0 on success, all of the
> DEFINE_GUARD_COND() macros in pm_runtime.h need the "_RET == 0"
> condition at the end of the argument list or they would not work
> correctly.
> 
> Fixes: 9a0abc39450a ("PM: runtime: Add auto-cleanup macros for "resume and get" operations")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-pm/202510191529.BCyjKlLQ-lkp@intel.com/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Makes sense.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

These macros are a bit awkward to get right - I'd forgotten the oddity that
conditional locks use != 0 to mean the lock was taken.


> ---
>  include/linux/pm_runtime.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -629,13 +629,13 @@ DEFINE_GUARD(pm_runtime_active_auto, str
>   * device.
>   */
>  DEFINE_GUARD_COND(pm_runtime_active, _try,
> -		  pm_runtime_get_active(_T, RPM_TRANSPARENT))
> +		  pm_runtime_get_active(_T, RPM_TRANSPARENT), _RET == 0)
>  DEFINE_GUARD_COND(pm_runtime_active, _try_enabled,
> -		  pm_runtime_resume_and_get(_T))
> +		  pm_runtime_resume_and_get(_T), _RET == 0)
>  DEFINE_GUARD_COND(pm_runtime_active_auto, _try,
> -		  pm_runtime_get_active(_T, RPM_TRANSPARENT))
> +		  pm_runtime_get_active(_T, RPM_TRANSPARENT), _RET == 0)
>  DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
> -		  pm_runtime_resume_and_get(_T))
> +		  pm_runtime_resume_and_get(_T), _RET == 0)
>  
>  /**
>   * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
> 
> 
> 



Return-Path: <linux-pci+bounces-39353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA7CC0BCF4
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 06:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73483B5F6C
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 05:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF5621770C;
	Mon, 27 Oct 2025 05:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VnR302Zu"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00541E1DFC;
	Mon, 27 Oct 2025 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761542116; cv=none; b=R6NAmNXlNnizRSdI1B5N8XFPWnQT5a/NHcLvi8UHLf69mHuY8+WFv9qjQyNKN8ENpikR/PnOGyywFkF+xn2GO0uEY9xd00C6j9af27ycUZn2qUPqQGXxf6BHRmdnncnnRq3EKFxRVDfwrvBo+PUCBZBjtvN8M2jWYl4I5OursBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761542116; c=relaxed/simple;
	bh=e5xuE5rLbucCcISmIA/XiNYbL29LalusADfloyh+L+8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJzcajWfOXCryMqHNsIggAGUtwDBntxB5PZxig3QZu8/nRqw41p/B8VlwbrZotunt9dm00jnvxHPigZIRY3tqkkdo72m3curkqbc8MWow0JSZ9FuWIY6n61PZOEBrW49fhXlFEfdgahB7DKaFsDfCBtZEVzcBlkcS+xNaKxYbM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VnR302Zu; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59R5EWjH1193164;
	Mon, 27 Oct 2025 00:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761542072;
	bh=tLqAyHlfVGllISEFF8v3MNzZES62GUDsy6UrvOylVXU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=VnR302ZuaKmvdFXakTcKvLEGgh5yGcGK442BMx72FeGfFw22gUWz+WJwLOVbEoKMj
	 Im4m9ezN449UyieS9t5Lbq0ic5/FKDhgbS+DKnXc3VBinjKe5rMX2Wpg2kyQ5+1/l/
	 28h12q5QAKsGRLA6DGStQ7KcpR6tKIIPMk/RNIEs=
Received: from DLEE210.ent.ti.com (dlee210.ent.ti.com [157.170.170.112])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59R5EW0i1433552
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Oct 2025 00:14:32 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 00:14:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 00:14:32 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59R5EVbh118214;
	Mon, 27 Oct 2025 00:14:31 -0500
Date: Mon, 27 Oct 2025 10:44:30 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Cameron
	<jonathan.cameron@huawei.com>,
        Takashi Iwai <tiwai@suse.de>, LKML
	<linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alex
 Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1] PM: runtime: Fix conditional guard definitions
Message-ID: <20251027051430.hmix3vxdqhmt5xfu@lcpd911>
References: <5943878.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5943878.DvuYhMxLoT@rafael.j.wysocki>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Oct 20, 2025 at 17:03:28 +0200, Rafael J. Wysocki wrote:
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

The 3-argument form automatically assumes success, so we were
essentially ignoring RET val. This seems correct now.

Reviewed-by: Dhruva Gole <d-gole@ti.com>

Best regards,
Dhruva Gole
Texas Instruments Incorporated


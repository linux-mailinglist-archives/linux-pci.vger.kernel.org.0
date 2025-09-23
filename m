Return-Path: <linux-pci+bounces-36749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFC5B9515B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 10:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8ADC2E4530
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 08:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB0431D393;
	Tue, 23 Sep 2025 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EN9DwI3Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C847230EF7C;
	Tue, 23 Sep 2025 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617703; cv=none; b=d/JXPYFc+yKQ0SyK7CIjoDL0ELy6gPbCW3adL1ZhlbGJiwvAYfb1Puwa/4cFLnJsT+aGh2B6VbBuO1VS6rqHyxbbpdFcM55/z1hoGhIb90Eo+SGQaFZXGHbsrgXweeoYAT6kYgl2moFRKD6TkKXSkWDx8gzCR01dkEQFVr3IpbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617703; c=relaxed/simple;
	bh=vZlgA378dXJ6IEORBC8flAJLCUujYqv1wPXQt3NpFLA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElHyRT/NPO+6Up8BqtdYWKe/yQg0h4i5rkNR1phsTPBlp75hRZjqv/3nSP9+NWuO6J4teoVlHyheB50d3/rOMTi0r1Xi6k+tQFbP5/vzq8rbvoZc5zzw9iqStsGKr/IpoycjhTMVYoMX/EuiqRp5gWL/QUxxTX6W5RUswvkzdZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EN9DwI3Z; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58N8sX0S1419674;
	Tue, 23 Sep 2025 03:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758617673;
	bh=Rbn5FSmJF2fzCLKPlTqn2gmIfa7r4g3/4yDGMiXqG20=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=EN9DwI3ZGgG7AOxIY0JYym95uutGInhiMyI+Y5Y+9bnV3BcAPIJqxYhuH03qk2lTb
	 UXif/I4ima7OVj8AjLdX0umnOOq1FbawIL3TpB50ey3tQ+w51nRmrWpOlW3acY4QSx
	 rNAvSrHXBg8WwG8Z/jQNsOeYpbEaReOVnc7HLyPA=
Received: from DFLE206.ent.ti.com (dfle206.ent.ti.com [10.64.6.64])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58N8sXSk1536878
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Sep 2025 03:54:33 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Sep
 2025 03:54:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 03:54:32 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58N8sVIM3978416;
	Tue, 23 Sep 2025 03:54:32 -0500
Date: Tue, 23 Sep 2025 14:24:31 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alex
 Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 3/3] PM: runtime: Drop DEFINE_FREE() for
 pm_runtime_put()
Message-ID: <20250923085431.svhwkiug3y7gz5m7@lcpd911>
References: <12763087.O9o76ZdvQC@rafael.j.wysocki>
 <13866828.uLZWGnKmhe@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <13866828.uLZWGnKmhe@rafael.j.wysocki>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 22, 2025 at 17:33:07 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The DEFINE_FREE() for pm_runtime_put has been superseded by recently
> introduced runtime PM auto-cleanup macros and its only user has been
> converted to using one of the new macros, so drop it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3: No changes
> 
> v1 -> v2: No changes
> 
> ---
>  include/linux/pm_runtime.h |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -582,8 +582,6 @@ static inline int pm_runtime_put(struct
>  	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
>  }
>  
> -DEFINE_FREE(pm_runtime_put, struct device *, if (_T) pm_runtime_put(_T))
> -
>  /**

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated


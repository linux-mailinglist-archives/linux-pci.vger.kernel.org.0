Return-Path: <linux-pci+bounces-42065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E5EC85E7E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 17:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00DD3B411C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 16:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE5E236437;
	Tue, 25 Nov 2025 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WdWboLe6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9296C23B63E
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087285; cv=none; b=d6kntU+d8c24ght4VVYzDi5m7Jdt2SfkIuN0F1FzogM/g1iCM8ZtDKv/QqsrlEx/4qaiPaDv6lJ7nlzzmSVk8+acQE1N/L3ieUEC9VBTD5w2owvXkKtjWaDIkXqhH4FOknRWptNiPvy78a5uGNSKmQ480Gs9eygIM+MnKQXI/8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087285; c=relaxed/simple;
	bh=7WpdqrsxKc58eqdMOT/GfNUzGo38GTGSCp96a60kVdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNcx9kmIMmiG5duIetJ/L5mQsaGhgxFT5bzJR09q8EcpKNyyuuAIotpGv6ltZDCSwECA//q5MEKCY6Uwsy0lFTiefhyWT+eTg2ZxuGEyjZzpdOB24GYgeUcjBFAAI+0asuRGhNk+AzSl5uMU6YiR/ZVUx+Y54A32NIJ0QxlgQxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WdWboLe6; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso6278578b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 08:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764087283; x=1764692083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BS22/Jgjgk8LyIJMs2VxEyscWALwx2agFhzMZn6bbEo=;
        b=WdWboLe6k5MY1+5QgdeV8N6a4a/lw+oAOkLuYWAipkAE4GBPSyYIg9/EULlV/mjob/
         w9rSyJztFdKqDUtEUW+aFDjYAEIKQUUnFlghn10Ww07UI4cst6z4vz0IwXm3/bJqhkk0
         L+KXU63ZNt8UtUMLDQ57O6IoRkF7MiXB6gZFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764087283; x=1764692083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BS22/Jgjgk8LyIJMs2VxEyscWALwx2agFhzMZn6bbEo=;
        b=Cmr+MQKTfugY4DtCD+B3BAwGYubpFDpSTlPeclpB8K5KF60XUTvzZkohkRDkW3dE/E
         nopwDZLN7O6cXJAtjbyoOK3ylwJpuS2sTf2P3qyLF6EJ3WLOg/0VeAe7MlzGcmwzVaAT
         FmqaPJkrbCAr7K07WYWm3MVdr1x1V7yQvPgnyZPKQypkVg1RR6KDsq4/WTVt630sal43
         ak0JcRf9KHkPmIj9XyxD18fx51EgJIEDix/zyo0GI0GPjni4NgyC0Btv2kEvkRrtWec4
         n0YYM4dR+p1FC7qYb8xH8PsA4oQAKIlzga1oC6eIXQdARFw+LCMIdSArcmhNnv89YRF5
         dWNw==
X-Forwarded-Encrypted: i=1; AJvYcCWwqytFwRmPKNXbzQXIzKhAgw7R/s+2lrYPimGzH0yyprXIhwG5fk+b125PSwEhpvD7aTLE//ByajI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVixxcXzQUkpnAzD2Lw28VQ76Bd1fGrpj1VV+jkDQWMuX0onaw
	vWg6R2v/Mj+yNW0tqVk4/8mrqhzs6uLH4OwYcMIsiWy43FUFPMWfiR5XbjggONkxiBBToTXNv37
	e5uM=
X-Gm-Gg: ASbGnctbg7ZSRsEtTCV32JZV7fWd38WCI+YWT1UsKmjnqj3UaL2iEPXzYX9g23Y0Y8X
	yS5gidN7Lw9NxLtWorf6AxWXyCZ45u/wEZq/DGrDGuNAS3H89bhcuoFXlrwiW5RzT6VJHrcNcqp
	hBPDs/ESlFHsKc+q02E98GlDkFXfJSxOFcHXjktcgcCVLyk0K8uOK3yn7wfGcWdi+Jfo1EsGV3S
	mdgvrtOBSE9OanoskKCWrO1N8jJbAOYrZ8PJRJsJoHZr2hHjBxTjBr+h67fqZ+dkm4vzp1W/txe
	Ue6Vy7VT5PbhjZQno3nothnn4LaYjFXFoeVo/ntnoKljs0RsFKxOhBaj9Io4kTqfl47R875eCJx
	CEOZ/YHgfCx1QfsY16HOB1ckkMp3iDhR6GsDp2DlW8cbYkQk4KthJ83i5JEr6cg9tGPw2qlZRrz
	9pwEl4ANSPLbVE3A3oxgi4qgbWCuKnyodxb2TFK5On8E2fZQ==
X-Google-Smtp-Source: AGHT+IHXwLO4qNaJvPVHWCGuBXPcsFgzsSjBBHzxsy8o1WTDGbCMGBLQXUoIz6DkSJEImlVVulsTxQ==
X-Received: by 2002:a05:7022:e19:b0:119:e569:f262 with SMTP id a92af1059eb24-11c9d7185c7mr11638583c88.11.1764087282717;
        Tue, 25 Nov 2025 08:14:42 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:62e0:9ddd:dee9:122b])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-11c93e3e784sm61789747c88.5.2025.11.25.08.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 08:14:42 -0800 (PST)
Date: Tue, 25 Nov 2025 08:14:39 -0800
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v4] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
Message-ID: <aSXV7y49lgA1cWmE@google.com>
References: <20251023140901.v4.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023140901.v4.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>

Hi Bjorn,

On Thu, Oct 23, 2025 at 02:09:01PM -0700, Brian Norris wrote:
> Today, it's possible for a PCI device to be created and
> runtime-suspended before it is fully initialized. When that happens, the
> device will remain in D0, but the suspend process may save an
> intermediate version of that device's state -- for example, without
> appropriate BAR configuration. When the device later resumes, we'll
> restore invalid PCI state and the device may not function.
> 
> Prevent runtime suspend for PCI devices by deferring pm_runtime_enable()
> until we've fully initialized the device.
[...] 
> Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> ---
> 
> Changes in v4:
>  * Move pm_runtime_set_active() too
> 
> Changes in v3:
>  * Add Link to initial discussion
>  * Add Rafael's Reviewed-by
>  * Add lengthier footnotes about forbid vs allow vs sysfs
> 
> Changes in v2:
>  * Update CC list
>  * Rework problem description
>  * Update solution: defer pm_runtime_enable(), instead of trying to
>    get()/put()
> 
>  drivers/pci/bus.c | 4 ++++
>  drivers/pci/pci.c | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)

I'm wondering what the status of this patch is, as the next merge window
is approaching. It fixes a critical bug for me, and it has had plenty of
review.

Thanks,
Brian


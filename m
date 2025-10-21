Return-Path: <linux-pci+bounces-38935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B243BF80D9
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 20:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B4419C56EA
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 18:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F9734A3A2;
	Tue, 21 Oct 2025 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jjDF/Mqa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D94034A3B5
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071263; cv=none; b=eUOPPJQAO7VHdhafG6jJhIb8I8ggsrjM+CIAALATy3kuqcFtDeoeznYbeSpsT4NazPUr3LwHAoyNRhED93M5UpwPMvSRIJ2kI+oUHo/6Ye5NtjCQ5lqRUehb3Y1fg7mxCYvDyjkLW1jNTJD1yp6aptjES38c0wj1hpTKmgUk6WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071263; c=relaxed/simple;
	bh=3RjBXAGDusLGx9xDc6Pf9biTKmKASJPpEkqNe3B3qqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv7OC0Xj7CwpG2miVCTYYIpJJwqyu1HOjEO6yM4Jxlp2NFyEG3iQ6l1x3zWQTH5hgh2jB5Tm7tCGxbUmJ2/ccwDsqExlzIaFjf+rcBFaYJHm4xIdO8k66sS6WnW1v2DOrv2PwjdUbe+ikqc1LtcFoXxYNNP5EICsObU2I/P+ALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jjDF/Mqa; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso212947a91.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 11:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761071262; x=1761676062; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HqYzl/UW33J1zC9mz6UdaYFjF9I5n2x84L74tPVphTs=;
        b=jjDF/MqaU5GTQPcB2gFr/gXDPEVkGu8EP0Eq1OctL+/pieLOP1te1UXphA5cmVB9mF
         vwrr/AF5EyNRaia6YwloBstsG8dJRObDmbe/mnFaswYrXHsr4UtsBgjuRwZL1LPDz3Yf
         0BrHoPw+GYuzg/Qycfpq8hWzxheHPthQPTAeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071262; x=1761676062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HqYzl/UW33J1zC9mz6UdaYFjF9I5n2x84L74tPVphTs=;
        b=qR8Bqht3o433mjoagHQcWw91hIM5kpH8CVs3PPGPf22l75cPLBIaltm45QRrf4k58K
         BtiJnntOHZx9oxW2TU4xQEYrjW4yLPwMx7vZilJ1swhyIBNqdrXVaUMX3WIjB/UiSLSb
         YG7gTh21XL1RjmfBRobv+Uw29qi4Wtb3mhG21xyGD16UtIVOjhKJBNwVQMHlKg6prcbX
         h4anPQA/BgrKZIxbGJqPCCM17mpJg2BwyGIdNURAIuzQdD/j7ff3FSlue7OIdmQp0i9u
         pDRoS6+L3FE3VLasCbtGTLFdJmcPuuk7/W6Oq0ynOrKQ+kCOsCWqubBOnZO492420UoT
         Y+Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUz8zJe339DwZ0NwuyvaRYukXkHXtd9hQd/1aEi1mGSbmCWkyEAvTFgI5sNi7lmFrme9kkQ7vp0QDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYorfplZsVMYJBDGqOs/19thFILp1DyU/jKMT/ymX+LnpCBTqa
	x1eal3s5CDcSvtSjnLEJVNtB77N8x9KQDcafY3CDVIUyFmC4aq9yRvH3U46RymiG1Q==
X-Gm-Gg: ASbGncsekIorkI+eOuo8UqNCJZDjqpborzX7GyXbypS4GkxVAx5SRO4a5kh6UgNzq5Z
	b1/6LFNXxccjUJaL2zE3tosA83Qgd5uGiEcUdstGXuyJRTEofoG9RJgfjCUDuJidfyROnshXgl+
	OWcUifMBoqo5SnmfrBnuwc+/YudaebQHoa5hIg4V8ZxLLxkX/YSoiPcr0PTpZIkOFaK69ekUPSe
	6RSEd3RqXlx04j1c7Sj+Z8r7xVo7HoKCNLnNF6UlrELsyP8iMI/YccRKpp/OdIUi9S2Sl+m8FPq
	tfRUCmv8fm1SIcKX7rOQ8LAoNvOB7QblIqHwJ9Nz//0w/pcMkNMPDgbZxrHsTf6EQp5MkUFOUMl
	yBkjCe4dBnWITdhwG2GPQwIF46F4wgr+7Fht4knLpZzuItE7yjIpJfilRDZhCWpNncNY4bWf3+b
	ex+uhEnQJDh5v0XZ6W+oDVgIAzJhcZYHHFuFe0rQ==
X-Google-Smtp-Source: AGHT+IF8cBN5zDoXETXF5lzZV8J3PI7WMOXfoZlFBQttwsFJrfAQjOmOSkixYd7wOfT54VYENlNFKQ==
X-Received: by 2002:a17:90b:1c06:b0:31c:39c2:b027 with SMTP id 98e67ed59e1d1-33e21ef1205mr1063117a91.7.1761071261628;
        Tue, 21 Oct 2025 11:27:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:e63a:4ad2:c410:7d7e])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33dff3adf7bsm1416782a91.4.2025.10.21.11.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 11:27:40 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:27:39 -0700
From: Brian Norris <briannorris@chromium.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully
 initialized
Message-ID: <aPfQmy0-7Cd0I9Jp@google.com>
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <aPH_B7SiJ8KnIAwJ@wunner.de>
 <67381f3b-4aee-a314-b5dd-2b7d987a7794@linux.intel.com>
 <aPKANja_k1gogTAU@google.com>
 <08976178-298f-79d9-1d63-cff5a4e56cc3@linux.intel.com>
 <aPaFACsVupPOe67G@google.com>
 <06cd0121-819d-652d-afa7-eece15bf82a2@linux.intel.com>
 <CAJZ5v0giOw54L6M8rj-Q8ZELpFHx9LPKS2fAnsHHjHfhW_LZWw@mail.gmail.com>
 <41d5c358-e469-3757-8bfb-e88c3d187e02@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41d5c358-e469-3757-8bfb-e88c3d187e02@linux.intel.com>

On Tue, Oct 21, 2025 at 04:18:54PM +0300, Ilpo Järvinen wrote:
> On Tue, 21 Oct 2025, Rafael J. Wysocki wrote:
> > So the purpose of this "forbid" call in pci_pm_init() is to "block"
> > runtime PM for PCI devices by default, but allow user space to
> > "unblock" it later.
> > 
> > Would adding a comment to that effect next to that call be useful?
> 
> It would be useful to improve the wording in PM documentation which is too 
> ambiguous. I suggest changing this:
> 
> "void pm_runtime_forbid(struct device *dev);
> 
> unset the power.runtime_auto flag for the device and increase its
> usage counter (used by the /sys/devices/.../power/control interface to 
> effectively prevent the device from being power managed at run time).
> 
> to:
> 
> "... (used to prevent the device from being power managed at run time 
> until pm_runtime_allow() or /sys/devices/.../power/control interface 
> allows it)."

Looks like a good change to me, even if just scratching the surface. If
this goes in a patch, you can add my:

Reviewed-by: Brian Norris <briannorris@chromium.org>

A separate problem that sorta stopped me from trying to rewrite some of
the Documentation/ is that we have both
Documentation/power/runtime_pm.rst and kerneldoc in
include/linux/pm_runtime.h + drivers/base/power/runtime.c. It doesn't
feel great having separate variations of the same API docs.

But hey, I shouldn't let "perfect" be the enemy of progress.

Brian


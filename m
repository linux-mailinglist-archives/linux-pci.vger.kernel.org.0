Return-Path: <linux-pci+bounces-30740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF638AE9B9A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541643AEDFD
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F02258CEF;
	Thu, 26 Jun 2025 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1hIo8mD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123F2222590
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933883; cv=none; b=bMp9bDHgJfz069iezmX3iWyd8GlTrYOy/yOC+vHyylNdetRWRK9wAyXllbIYl5jN2arJSFuikXDno+TRI16MCKKOylubU42IHV6MOcHrGS55A0wMAJcDV6B0ZiIGeScYRtnt/bkJJ/QW0RlugbPck6XChgEL4YnlngQIbAFTc8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933883; c=relaxed/simple;
	bh=Z+HMGmRN117Ts5fbev7DVAdsIy/tyxpazqxI06YJMls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTagVI82qD57qqdgjDG3uA+3vM1dsVElwfMuE1watbZgKtZORl8/kvump2lhHX2kyab9FBXeY1juB9o3yzC+mN/i2Y+o5SG9Sy1HX3zib5pQjZ/hQWOxoj+rBPIFrirw+odRh2gt1j/p/5Pzc7szsyH7sVk54oaQSMBb1CtXXb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W1hIo8mD; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e819aa98e7aso687129276.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750933881; x=1751538681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=otDF7N1FhmMaIK9N2KC0Z8gh+57rBjHJAOPDBBdmpSg=;
        b=W1hIo8mDxjc4XL8RaKGRZkJ6cuFSVemaDKyeCUxqjY1uLH40BkyXLAcrJqwlFTi7oL
         YM4jeQHzHxzITESFipykSOhGAb2GgA6EE8vBxD6I3b5x29ipTqEj4cSVGJ1cukPLFGws
         8qN9qrvP/Xp4z9ncEHpmaytdBZjdNCNkYwLfjeDPUdiFzVwpzkXp4RTPE35m0CLh72pY
         AYg75X4vWKqLV+DjPb8pDonHhpHR2elnZjL/UqOcIOwldU4D+JH8nGjnsEKUVp4MZ1LV
         rz3l9XjBcJ7tKtAUwn9ToIL2qfNMtQjHkKPbNLO8+RANBy0gGvkSLQpP96PvfSS+WXMW
         5uZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750933881; x=1751538681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otDF7N1FhmMaIK9N2KC0Z8gh+57rBjHJAOPDBBdmpSg=;
        b=P7CNI0Pu60NhIqmWEmwIs4S6R0jla+rKF7NZbDExxCb7bxs9Kw463q+SYj/M7uUNhg
         UlS0JnfcU8Asa/c2YJApw5HhU6NTN2vu2swxCw/j51YOaPxY7LAIroWVWOzhjPZvs/jH
         H5CGvhQk+UR+mDs0tAEZINZBRyaCuX4qw509QgKkgZ5iDPMUt+vobjBKstsqy4kNbGIw
         ijQVXiS9EHE9NCuSNoDqecbFeGPXdGcoTw7p8YMQtkqUh6jr+xHQ2juIWVPtfVtjCR1b
         Lp9C5UbpkrizxjfFyGoxhrawZZKJaLNneFT29d/UGzkYlL0xqh7CYOpGCADA3F3AWIkQ
         cjZw==
X-Forwarded-Encrypted: i=1; AJvYcCVjqT5IUtcmBpBuHyu7ZCAS/uKsbuvC8xBfuomYCDdSPZGuk0AH4waHV+644dg9FP6LbFOfulPOv8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyABF0l8I9sWZRZxTDKolqsfgcu97hJkZJ9dS3qslrFwNaNIbVZ
	2NP1XrQUCe+fn1PQBIAtsa+eDEWNDm2fE2rSu9c/jCGAHILKfPAhz9j6fAfXu0zvN3KsIK5ecia
	JFyWGGVn0wi96ry9Sy+UMDqju9AE+IJMg3lRknNE4SmWSDrnRKn0O
X-Gm-Gg: ASbGncteDbIRWeAHheDYtLbAIPS6QnytM8RT9f44Xe8Dhs8u8EDv44mxQPKAvdAC5fo
	3mE/B22nCoS8Dkdb9UTWtek6DlF110Bc6SYOiey3ugyRFQZ4XkMpsVlpfECedeB/YAe1U+LC/e+
	Z+TVfih+DojjSY2PisM3dPPv47SBNXh8hUcnfkxg0bId20
X-Google-Smtp-Source: AGHT+IEJFJjQjgoF4JDK6/h8YGM8Hnkr8ICuxu9rc5onoooA/kJOCVLg4G5+xe4NPd23fJBgWQaeIr163WvTav7Ioko=
X-Received: by 2002:a05:6902:138c:b0:e84:2160:8d71 with SMTP id
 3f1490d57ef6-e86017c4ad4mr8521092276.40.1750933881094; Thu, 26 Jun 2025
 03:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22759968.EfDdHjke4D@rjwysocki.net>
In-Reply-To: <22759968.EfDdHjke4D@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Jun 2025 12:30:45 +0200
X-Gm-Features: Ac12FXyTZUBODRjJn3UboKy92_g08xem5gzj1b0KboifHaz0N5A-9Sd_QQGZ6zw
Message-ID: <CAPDyKFpZVdf2EnZE_u1xDKB7=Nd98a_ajYimQhLBu6jYwJhJFA@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] PM: Reconcile different driver options for runtime
 PM integration with system sleep
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Jun 2025 at 21:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi Everyone,
>
> This series addresses a couple of issues related to the integration of runtime
> PM with system sleep I was talking about at the OSMP-summit 2025:
>
> https://lwn.net/Articles/1021332/
>
> Most importantly, DPM_FLAG_SMART_SUSPEND cannot be used along with
> pm_runtime_force_suspend/resume() due to some conflicting expectations
> about the handling of device runtime PM status between these functions
> and the PM core.
>
> Also pm_runtime_force_suspend/resume() currently cannot be used in PCI
> drivers and in drivers that collaborate with the general ACPI PM domain
> because they both don't expect their mid-layer runtime PM callbacks to
> be invoked during system-wide suspend and resume.
>
> Patch [1/9] is a preparatory cleanup changing the code to use 'true' and
> 'false' as needs_force_resume flag values for consistency.
>
> Patch [2/9] makes pm_runtime_force_suspend() check needs_force_resume along
> with the device's runtime PM status upfront, and bail out if it is set,
> which allows runtime PM status updates to be eliminated from both that function
> and pm_runtime_force_resume().
>
> Patch [3/9] causes the smart_suspend flag to be taken into account by
> pm_runtime_force_resume() which allows it to resume devices with smart_suspend
> set whose runtime PM status has been changed to RPM_ACTIVE by the PM core at
> the beginning of system resume.  After this patch, drivers that use
> pm_runtime_force_suspend/resume() can also set DPM_FLAG_SMART_SUSPEND which
> may be useful, for example, if devices handled by them are involved in
> dependency chains with other devices setting DPM_FLAG_SMART_SUSPEND.
>
> The next two patches, [4-5/9], put pm_runtime_force_suspend/resume()
> and needs_force_resume under CONFIG_PM_SLEEP for consistency and also
> because using them outside system-wide PM transitions really doesn't make
> sense.
>
> Patch [6/9] makes the code for getting a runtime PM callback for a device
> a bit more straightforward in preparation for the subsequent changes.

I can't find this one. Seems like you did not submit it.

Perhaps make a resend and fixup the patch-numbering too?

[...]

Kind regards
Uffe


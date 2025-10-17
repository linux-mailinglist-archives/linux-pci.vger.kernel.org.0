Return-Path: <linux-pci+bounces-38513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10259BEB5FC
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 21:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEF324E7019
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 19:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3595A2DF3FD;
	Fri, 17 Oct 2025 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jN2bXa+Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B821933F8B7
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728808; cv=none; b=nZRyaty1+9nLSx3RCbylkfCKmfA1Uau8319TYR/rH7Fq1VezM4OFfvMhx7tm4hEUneXxi9nqxBCn13ziHePgVcoT+I3qV+WVk6E7LTNNF/ZuUwaexBptllpBbaHpCoM1gVUPc4eV5z+bZilx8VmjVx/5l9ceiIsVLD0eDU4Eefc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728808; c=relaxed/simple;
	bh=dQc0lw1C6VoW7QAgpMjyWsMfikVa/Qn+q5wJUy/awm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fupJOUD9lkXmpPQuj4sqcs8BpAxTJAXFcLdS692/opYvRGjmAfuYTl9vAT2FoY3CkZ+ktiXEwGvr0lsi3jXMbZZ+fkUhpRQcb/4jDFRNUG5bvM9QCrB7lCBpL7y9Qwb6XL0COKTWwob9M3AVRPQRU2ZqDA+ngB5wsIFYcNhLaUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jN2bXa+Q; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-269639879c3so21470245ad.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 12:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760728804; x=1761333604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHXngnuNlh6itPj8r7imVgK8MxU3nTSTL/IVvz/XXP8=;
        b=jN2bXa+Q2x7zSjnPgGSv1JJ+CmfYRgTXZk0b36p96awMRMI5WYzIoTOM3jMs66DfD5
         lvk8d34iHxWZ0zwAioU4VhSsA0jS1Oku5Ij5PXkMqe4gbRj9LY/ydu9sJeo6DT+RKTwK
         r9ZypfgoLOjJpvb3Z9PlwdG2pN3qtbD+13jbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760728804; x=1761333604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHXngnuNlh6itPj8r7imVgK8MxU3nTSTL/IVvz/XXP8=;
        b=LyeJ14dMtIUKjYY4oo46vyqSKaAoGqQ5p/7xKecSbTMTiaLYBG39GsFvgRQpHGikNC
         zgzBKHwcP29WMmkv3g8iihnpbJRTkgL0nr/Lo2sf0eJd3OZTbdEeJbz9Sh2FcdUYbHCZ
         UCGCelG1J+OA8xibuG13ap3/fJNKd2gpaXfpNlcnW98LfGUHbMKAslMkxNiWnPtDtVgq
         JjTe7aAxqMvyCf1z/Ow8Prsu3UxOTzth9UvkvSi1Sri8WkmB2hc/Hz9feMSGv4ZVhnFj
         WKfr1vQt0AlHWFBDfyD+SWZiOmBpIb55gSKhVI2E4wsCE2AsyZ0EWzV7hicAGLqDlJ4Z
         jK1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX79jCf3tOFj2n2cgyNltD/wIBxqh95sfBNR/pabyuFFMKyElpxsMaJK4Kn7bxJS7gGgZnXBQnZRJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGovL/SXhOjEqCVBoTmPIKNz9GtHgoF6695w0O4zjRYGJJF7Bw
	CsEq3ts9wfV6r9fK4tDIkXBSFkj6MZNo2HA55FfzT3DDq858g3l63nWy0PSih2IPyw==
X-Gm-Gg: ASbGnct0DnX+nmr2FQiIvoa10nhMzmkoJmL4/boqcUxxNn+/wSLfatFL4d6D0KiVuJH
	OOSG1IrSUNZOTXaEj6y28fyCDdEWyUhvviCplUVBNYtd2dPNXnfBFBSF3vTeJHMQJysdLclCCjn
	9hHkv8W6nZkBTL8C8BoRSOlHz6GOWqvJSZw0+dqBx3r/cUt1+H0aRhwxsJdKjSpxKPvUUNMNkws
	m/HX+6Odb+rTpzEwU6eM37fh0FIjAVIKmpCNWsSX/uizA6VZbBLL/xNSu4JVitSV9NcmryJIXtx
	/+DxSbdaet8oIgKqneARL5JaSQwbFomOZ4X43Sin0a8YsY2xWjKJJzy5k3clsAW/CrBn3ECIs4Q
	eMkzPxwnhvb5gsds1EqPHFPdLUTw/bsaO7ECWwWlqLOvzyBAU6/t6KkIxOCweBELFhJPTCqsIeB
	Y82KQo7VpDdptMLYK0YQJOZP3TN4sklbnrbSNW2ej/BbtCYn74
X-Google-Smtp-Source: AGHT+IElkrHhhyNLeAZol7uw4OirIzBxUzQlJYrmC4LJFvDksofq8jEPQXbrqyZan9Zi/uQsogvSNQ==
X-Received: by 2002:a17:902:ce87:b0:26c:2e56:ec27 with SMTP id d9443c01a7336-290c9cbc92amr70205745ad.19.1760728804005;
        Fri, 17 Oct 2025 12:20:04 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5ca9:a8d0:7547:32c6])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-292471fdce3sm2636175ad.90.2025.10.17.12.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 12:20:03 -0700 (PDT)
Date: Fri, 17 Oct 2025 12:20:02 -0700
From: Brian Norris <briannorris@chromium.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully
 initialized
Message-ID: <aPKW4nXfQxl6SmLE@google.com>
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <aPH_B7SiJ8KnIAwJ@wunner.de>
 <67381f3b-4aee-a314-b5dd-2b7d987a7794@linux.intel.com>
 <aPKANja_k1gogTAU@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPKANja_k1gogTAU@google.com>

On Fri, Oct 17, 2025 at 10:43:18AM -0700, Brian Norris wrote:
> git-send-email has --suppress-cc, and maybe I can convince my tools to
> do that. (e.g., `git config sendemail.suppresscc cc`)

For the record, that'd actually be:

  git config sendemail.suppressCc bodycc

I think I'll use that, since I usually track intentional Cc's with other
metadata, not (just) body-trailer "Cc:" lines.

Brian


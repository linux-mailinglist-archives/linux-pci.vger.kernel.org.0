Return-Path: <linux-pci+bounces-1199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DC881966F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 02:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F59284A35
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 01:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD385CB9;
	Wed, 20 Dec 2023 01:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYE+K59H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBB98BEB;
	Wed, 20 Dec 2023 01:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-203fed05a31so510875fac.0;
        Tue, 19 Dec 2023 17:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703036334; x=1703641134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GhYNgs7Y2PEFrlksej0FgbSm5TkOzzFf3rOPpKg2tPc=;
        b=WYE+K59HbomgQzQjD4ukUg6bf98qUw19mSGBGwAzs6B4m1b9Qhx9yOfF3d8eau//in
         BGlTaSSkV6mZm/I3YOOWU7Ev4qKfxz/ohU4URe0n2+hOCfpzi9LWbGCMFk5UhRHYPSE1
         mu+k7h+Fp0svLQyOP8w2bhPxwCuF+qkUCiNfFX53SE90KD7u3RIp5UFlBDuUQIFw3i88
         2pKdk+m840RYc+NsR1+OR8O5pHsei/61e6bgyi0vi9lZB0u3Yvsk8a5Ekyd02SXNEk/z
         QeAQh16hd3pc0JKUZRs0mrAOkyrAG3vrEAksleX5WhffFu+Jy5vmdqgeLV252GBVrCfq
         appw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703036334; x=1703641134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhYNgs7Y2PEFrlksej0FgbSm5TkOzzFf3rOPpKg2tPc=;
        b=L2SKWT2OfGDOR3y0jlX/ZMUpcj4hqWKSeRP5eouloBjW0v94HUGYsZ8c+5I0qliSmR
         hI7akGZEbXZOj1bug1oJhILl0spj3SpLHXMtHGG85Sg7+vKT9Q7RvtiJJ9c2/dthF8QD
         rLBJaT4OqMfkwtF2bNW3GK+WFMy5NW0DJsYwE4eyHR/ffhWhreYswFebFZuiozz7OFtU
         0t4wrsMJnFpNt/+kRoiMeMcZQJ0W052y4wIM+ZVQpu92dMxGoyTxChrpNpsjeGne8vJD
         wPH4S21fHXeAsDzuFVybExBSdPP4px5c19uItCGdYuk5lj7IyyLMikRBQpvxVDyCwaDX
         bDCA==
X-Gm-Message-State: AOJu0YyJJ26NCBjd0kvSesYPYp9z6K6S4AorBJELNl5FTvm3Skapk4K4
	7ZVcGhzfAjqkQqbieF8ttN0=
X-Google-Smtp-Source: AGHT+IFufCwXfONaC0t0YbJVX/GqDXYDfVM3aANqMewsCM3s3EJt4Lu34OxFMH8A1CBI+cvvOAN7vw==
X-Received: by 2002:a05:6870:a50a:b0:203:6298:3185 with SMTP id o10-20020a056870a50a00b0020362983185mr9935253oal.40.1703036334023;
        Tue, 19 Dec 2023 17:38:54 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:b2ca:95aa:9761:8149])
        by smtp.gmail.com with ESMTPSA id q27-20020a63f95b000000b005c6746620cfsm20255385pgk.51.2023.12.19.17.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 17:38:53 -0800 (PST)
Date: Tue, 19 Dec 2023 17:38:51 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Esther Shimanovich <eshima@google.com>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v2] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <ZYJFq6T3uGJVv0Nh@google.com>
References: <20231219-thunderbolt-pci-patch-4-v2-1-ec2d7af45a9b@chromium.org>
 <ZYIWHjr0U08tIHOk@google.com>
 <CAK5fCsA0ecsWeQgV-gk=9KCkjDMcgaBj8Zh6XP8jAam-Cp0COA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK5fCsA0ecsWeQgV-gk=9KCkjDMcgaBj8Zh6XP8jAam-Cp0COA@mail.gmail.com>

On Tue, Dec 19, 2023 at 06:19:39PM -0500, Esther Shimanovich wrote:
> > Maybe use PCI_VENDOR_ID_LENOVO and move the check first - it is cheaper
> > than string comparison. In general, symbolic constants are preferred to
> > magic numbers.
> 
> That makes sense! Will do.
> 
> > Actually, do we really need to check DMI given the checks below?
> 
> I was advised by Rajat Jain to check DMI. This is the reasoning he
> gave me: "I'm not certain if you can use subsystem vendor alone
> because, subsystem vendor & ID are defined by the PCI device vendor I
> think (Intel here). What if Intel sold the same bridges to another
> company and has the same subsystem vendor / ID."

I believe subsystem vendor and product IDs are not baked into the device
but set up by the system firmware, and therefore there should be no
concerns with mixing up IDs, but I am happy to be corrected by people
with more experience with PCI.

Thanks.

-- 
Dmitry


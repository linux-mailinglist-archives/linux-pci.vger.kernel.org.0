Return-Path: <linux-pci+bounces-26530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421FAA989A9
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 14:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C623BA72B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 12:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C757201269;
	Wed, 23 Apr 2025 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrTRneJF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D613C1F;
	Wed, 23 Apr 2025 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410919; cv=none; b=CMBP+VwO/5dajvJ/y9k2+O3pMuZt50d3B2MnFl8Gr2BOrS9u/2FC66wIN+TcePtRJiswky8LaoiRQyXT0G7dIWl+ACs0/7pJzJc/dNpar6DUAMaG9PSUg+WzmXZWt8KLrRxLCGIKxjy9mXmUq9AdPMbEKMOhmE9Yrp6xB/rxalk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410919; c=relaxed/simple;
	bh=WX7rPuPkvDk0XuA2VnYO8jujklzQsPuEfILh7N5cuN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBZ1ScAaPfAxxtf+zz/RqCyAUw+Wge3bG8gcalkRED1b7rDU3JRZVD80JEnIH54hmwj5RSXB6lpnbtcOEPkHwqGJv2WRtdnuZcJDoqZ2lCJ6I3YRwOxIP00OPE9MEe9gvVC3GKikdsPGxeedKg3or58nQ31LG16iZoHrnTsQzTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrTRneJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C77CC4CEEF;
	Wed, 23 Apr 2025 12:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410918;
	bh=WX7rPuPkvDk0XuA2VnYO8jujklzQsPuEfILh7N5cuN8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LrTRneJFCRtGaUQEv02ADQ+9HNdI9A3C1iCxioOhqNvwuYyC+BTo6AoB2Q7iUB+vn
	 Us74GEi/hhikAdR6xJ2S40NDZkyPfcxNB6DJaw7tDzXCAxyn9NJfi8yKUckCl2jtfQ
	 1vrzmQuJsuvu0Ca1o80qd6+3hzLPHULH5ROkBITdGwkScaUrQ6sV9XxRN2Q87IBCO8
	 dL7oQ8OGC6igLFY8Lj4ACJ8zQ2973+AR+5skQm9z6dV2eqLF5qxisXzj+YfcXkGgE3
	 GigYzEAfdF7pAqm/TuSkbqWXIClYoiXm+/I1OjA/GNJbim1SaWvoEuaO9wVFtWY16n
	 QSxTdGbdlj6+g==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2c873231e7bso3904333fac.3;
        Wed, 23 Apr 2025 05:21:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmz6uhVbDcnMJ8/FVZR1WhEXgGts/2G2YGiVfPbmXYF7rAKMMwcf4sKBNDmUWFJ2g/BR5zFKKyvY5n@vger.kernel.org, AJvYcCXD7AdMeEkDL2RIe7O6+RVgnB+wfcjaQHCDdnBA3Wd+vxkkXG4GUJc5FTgokStrbyCv0CYrR6FxGP4=@vger.kernel.org, AJvYcCXSHxvwJ5hxPtRuRgFQuY6OmG2CATsHqJEAW6E7EcV/fkQEAHG6lcyz8UaZly1FYI2wkJJlMizKQuOZigU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG2Zctg3pFP/j6Xv0dgMRlNAhZAk6RMthgod6GiXm7EZUUZscy
	Zaz+bm6IQpt5GZ8ny0R5au9qNpDSjPYnYdqFqLWu9l1KpsTQOWc7Z8cukf1gZXZSLmEFivqx4rZ
	he8GuPimX9hPVjobmeCzdOWnp19A=
X-Google-Smtp-Source: AGHT+IEmpazg5C/baNnLvzuO2g4IFJ0tUqG6TJifhYQZwFMOVgH9K9qTLQUXpHxKCQN6hotN4srKR9cydUu1JLL3UEg=
X-Received: by 2002:a05:6871:20c3:b0:2d4:ea06:b11 with SMTP id
 586e51a60fabf-2d526974c88mr10504842fac.7.1745410917580; Wed, 23 Apr 2025
 05:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422230534.2295291-1-alex.williamson@redhat.com> <20250422230534.2295291-2-alex.williamson@redhat.com>
In-Reply-To: <20250422230534.2295291-2-alex.williamson@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Apr 2025 14:21:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hwjLqGE8CWOVhckCpvvRa1EEazFhh_pcKT_4_CnT7j8Q@mail.gmail.com>
X-Gm-Features: ATxdqUH7A2UksY-_33_U26l7SoK80Yn4VQ-6zfO0xB6TmLDriae28RLvZKG5O1k
Message-ID: <CAJZ5v0hwjLqGE8CWOVhckCpvvRa1EEazFhh_pcKT_4_CnT7j8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: runtime: Define pm_runtime_put cleanup helper
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, rafael@kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 1:05=E2=80=AFAM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> Define a cleanup helper for use with __free to automatically drop the
> device usage count when out of scope.
>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  include/linux/pm_runtime.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 7fb5a459847e..69d4b2929ee6 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -466,6 +466,8 @@ static inline int pm_runtime_put(struct device *dev)
>         return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
>  }
>
> +DEFINE_FREE(pm_runtime_put, struct device *, if (_T) pm_runtime_put(_T))
> +
>  /**
>   * __pm_runtime_put_autosuspend - Drop device usage counter and queue au=
tosuspend if 0.
>   * @dev: Target device.
> --
> 2.48.1
>


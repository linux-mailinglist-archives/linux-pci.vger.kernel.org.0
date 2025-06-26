Return-Path: <linux-pci+bounces-30701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31760AE9AE3
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3AE3A37B5
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC1C220F41;
	Thu, 26 Jun 2025 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKz8j8yZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD05F21CA02
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932672; cv=none; b=T6Gk+rh/zZ1U+WgncNCEj7sORipEyXbdJ4K1pamJO0nqvuNffYUs00ycUI0UWeN6YNgCHfy8QwEjqNfnAeydu5/+kIX6twWoULcc4qTbVtaM11IljaagqKMGgwsXWf/eJ3Nw3u0m8KfKm/+pDgFhDJ7hvMjfstc2DVoazRQGGyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932672; c=relaxed/simple;
	bh=6/CYJDnKQKVbQcwXiQ2rMzs2H9ssDvR6KIpjsUQ6QdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8V3th0dsAfqOjn6nZMWohp24YcFuYB4VEceUjyYX+en8TwCyu+X9n8H3iXJNMb0fDVwtBnY91ZNsnFJEYEiNAvIuOVVAaCoR5/QRQqL38M949JTC4O6sYZih+Mem38L7xIpgqI/185xD/+JEXSR9xN8Bkr1KhXH9yvaMstVbSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jKz8j8yZ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so652222276.3
        for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 03:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750932668; x=1751537468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Q9r85ztpEpS9CYbZbkPRdk5F829Mu+gn5m9UjJJ67w=;
        b=jKz8j8yZKBOa7biATTQpt47NE380p0arVVW2TvzqXbvq5RyIZnCMi7nhD/HhMXYxG9
         14ETF+3PzaHQPT51FU9gAiJNWVJT85d/s62Z/nGx47ZAS3XiL9bxnMyzzcoNRbkZaOLu
         Bkd578TgrI4eXkwPYweFBrsvKq4O9eYvRqwGWeN5V7lULHQgK5mVRsFHG16Azj4t/2SK
         Lft3M3XvrCJQaDOO7S6P7H8OEktGZLHitpS5Y04PLE12f5xCteSaouVLNrkEWLL7i7d2
         mMDby3gOo1GYd2hSAYRcTizT47AXZTWEDaRBRASJzsGv8l5L/L5Nh2agqwAlL8SrnNUn
         x/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750932668; x=1751537468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Q9r85ztpEpS9CYbZbkPRdk5F829Mu+gn5m9UjJJ67w=;
        b=Mm7x82Ga7JPU1o+rsFR/uHLIa1kvYg43O1s8tNWaxhxVTRAYb96sif3ZjD1ZOJ2azy
         v4K4olD7gnZ0GLS/shb9PPhW6pkUofrhgBZmSY2waNHdfyjZ3rhgrnxXX7DO/XpIbzMQ
         oBLIz/M3ZxlgdH5lBhs2rAhhEOrycpIaLf912jFjiqrJ56fGN8stUna35Iyze6EARzkY
         fk9z3TORJPhrS3bAUrNa11wDxvB+LUf7hiu5C3Yu0QbF5jxCzB5iF1nrUV0KmjRVZ6OA
         yFBvU4YvIRe0pmpTugNSaJ14OjdF70fv5oyc8xQMA4Xq5f+YBH7iQe/iYNzUlGwiraCn
         DNvg==
X-Forwarded-Encrypted: i=1; AJvYcCXGjgaYXGZH4P9RxudqGF93SaxeS8qqIuHuYq6fB4CljtppJYRfpC7kyZ5eGledjO1YYDqCHVWHwQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWHWbB/vOobmUIWqWzO0SAiLDHLzbcImVdKj2iVsYTIQWIoZRt
	2h4WU6sKStNuOd/RPmPhph0QfzFnQDNWqMvxtVk1ai+BmMu/5eRbJ2ZszQnBEpcbfAt3stR4vjY
	pNRD5ub2b1uffCd3fBz+U6caCz2eeKMMMTZFsiYmcdw==
X-Gm-Gg: ASbGncucIUskZG/MfiEej7mTiGfQ8StZjjvIZ+SfvFRG1pQ2ft+Aum0S2EHRNPBA9Hu
	d3rH78fry89HGU8fdYwGbD+JlLB+gsCFYTOQJdVD37WuzZffwOMqR9Hy5dN6WWOJmFx2q2bDGaW
	tEqtK3CtBlH1PfJZOmEYgrjKK/Ci3hvFJ8VCbpTjUkO8g4
X-Google-Smtp-Source: AGHT+IFTNjmMODL7y1EvHVTNC82M3od38DyxrG8NO+F9c5mpyvxWXa3dqoy9a/B0A36TiqGlH0TnxzyON/TB5m34CYM=
X-Received: by 2002:a05:6902:210e:b0:e81:9581:4caa with SMTP id
 3f1490d57ef6-e860178bba2mr7662593276.34.1750932668573; Thu, 26 Jun 2025
 03:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22759968.EfDdHjke4D@rjwysocki.net> <3903497.kQq0lBPeGt@rjwysocki.net>
In-Reply-To: <3903497.kQq0lBPeGt@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Jun 2025 12:10:31 +0200
X-Gm-Features: Ac12FXzz6qmhiLsuzk245wnHwdyyM19B97SD0ZUjObz7zXjCLdLDg9DQbgqL-iI
Message-ID: <CAPDyKFqXvNDqZjePwvF+mgs7bba47uoeH-7XvJkqZ2K4-bmXgg@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] PM: Use true/false as power.needs_force_resume values
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Jun 2025 at 21:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since power.needs_force_resume is a bool field, use true/false
> as its values instead of 1/0, respectively.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/power/runtime.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1827,7 +1827,7 @@
>         dev->power.request_pending = false;
>         dev->power.request = RPM_REQ_NONE;
>         dev->power.deferred_resume = false;
> -       dev->power.needs_force_resume = 0;
> +       dev->power.needs_force_resume = false;
>         INIT_WORK(&dev->power.work, pm_runtime_work);
>
>         dev->power.timer_expires = 0;
> @@ -1997,7 +1997,7 @@
>                 pm_runtime_set_suspended(dev);
>         } else {
>                 __update_runtime_status(dev, RPM_SUSPENDED);
> -               dev->power.needs_force_resume = 1;
> +               dev->power.needs_force_resume = true;
>         }
>
>         return 0;
> @@ -2047,7 +2047,7 @@
>
>         pm_runtime_mark_last_busy(dev);
>  out:
> -       dev->power.needs_force_resume = 0;
> +       dev->power.needs_force_resume = false;
>         pm_runtime_enable(dev);
>         return ret;
>  }
>
>
>


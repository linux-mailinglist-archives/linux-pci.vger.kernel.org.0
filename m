Return-Path: <linux-pci+bounces-2434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A75D8370E3
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 19:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E05280A1F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 18:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9179446454;
	Mon, 22 Jan 2024 18:17:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B80646430;
	Mon, 22 Jan 2024 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947428; cv=none; b=UVJ8J22ZR7FfA8lRlkEg+LSMRucxHt7JyWO5gQQEMZB3BkuciZieRHozaVqEvpipVqhwDh44wVLK9WIVtD5zka0mzauMHX7PpukcX+UjGtQgyKK/67NbS45+WtfHYYwAAZigN/gYOltbenCeJn/PQ/4I7u3XYrpa69W/kTsEhpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947428; c=relaxed/simple;
	bh=jsvejlNfKaIARdUpmySnWtohSbLYvftZ4a6cH6XWWIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSttMiQlsK175nZBVIQ+u8t8W2MnmWrVQi4Ea+uheci4Zj4Om4xwJPSueC8pi652rIhMbWZtjlNj1AKM7JPEUEKCl5DQi+W/YmLT+FRiQKO/PrC5Rx8rQjGCcdU3T8T6C+VFwlaGAYq1V1aB3JULcGdyc7jRA1uOuMRwCZNVOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bc21303a35so742252b6e.0;
        Mon, 22 Jan 2024 10:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705947426; x=1706552226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bq9M9cm+CE6WAD/PzAq+M4FYMF5cDyj5a+NJZ7ioaVI=;
        b=BskitE3jxieHuPGqQskc4grRohl6wUHaPsaaeujqrL7xasJL0gQfffAUFHUBI+1wfo
         S5oApeTdYo9uiClOS4ecOZlos8C4qvhw+WAX9nb+6SiRMmGgpPCfJmu3LQG0EOuQCzRv
         NkwdlFLghuFb8FxrwWHJxG/p97Ed1ImBqhODuvnos74pFLtXvhj5siMtgMnIGCxvFq9a
         PeDh5/uC79ibWpfW+1VeLsLsb9AuWEQzxtVHuhqYmvGOfZOl/J6nojn31sQMTGI7ol1C
         Sdy9F9zePYvOPHP64PsYwmyVStQr+nfJq0eU34R+2gypBMRV2itCwb6s+Od+KrYcJ5kv
         vUaQ==
X-Gm-Message-State: AOJu0YyeqZW034nTqR+uWQJZ66diqKeYOkRlNsQFfNDkPK70X1djlqXy
	Ln24s8IUxzxGZfffbWnfATobKR3yROLqE5fPB5K9dyDxf4Pbu1hXetnT5t0JvDTODZfAKGFnGkK
	YDDEs15oxi68VRHp/7kyAYbChdWQ=
X-Google-Smtp-Source: AGHT+IG7X57s+1Hb3UmgWa4B2VhnsQsEmm2qhDCXpsDoekvAtRW8AijnCpEwtrAHQizHxz0U/8KF3rieJlIr+BPH7Us=
X-Received: by 2002:a05:6808:308f:b0:3bd:a741:a048 with SMTP id
 bl15-20020a056808308f00b003bda741a048mr9775473oib.1.1705947426060; Mon, 22
 Jan 2024 10:17:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122114121.56752-2-sakari.ailus@linux.intel.com> <20240122181205.GA275751@bhelgaas>
In-Reply-To: <20240122181205.GA275751@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Jan 2024 19:16:54 +0100
Message-ID: <CAJZ5v0gUpo6Shz2kQzie4XE23=fiPvD0=2yhjGptw8QbCq2SAg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] pm: runtime: Simplify pm_runtime_get_if_active() usage
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-pm@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, laurent.pinchart@ideasonboard.com, 
	David Airlie <airlied@gmail.com>, Paul Elder <paul.elder@ideasonboard.com>, 
	linux-media@vger.kernel.org, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	intel-gfx@lists.freedesktop.org, Lucas De Marchi <lucas.demarchi@intel.com>, 
	Mark Brown <broonie@kernel.org>, Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, intel-xe@lists.freedesktop.org, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Alex Elder <elder@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-sound@vger.kernel.org, 
	Takashi Iwai <tiwai@suse.com>, Daniel Vetter <daniel@ffwll.ch>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 7:12=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Mon, Jan 22, 2024 at 01:41:21PM +0200, Sakari Ailus wrote:
> > There are two ways to opportunistically increment a device's runtime PM
> > usage count, calling either pm_runtime_get_if_active() or
> > pm_runtime_get_if_in_use(). The former has an argument to tell whether =
to
> > ignore the usage count or not, and the latter simply calls the former w=
ith
> > ign_usage_count set to false. The other users that want to ignore the
> > usage_count will have to explitly set that argument to true which is a =
bit
> > cumbersome.
>
> s/explitly/explicitly/
>
> > To make this function more practical to use, remove the ign_usage_count
> > argument from the function. The main implementation is renamed as
> > pm_runtime_get_conditional().
> >
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Reviewed-by: Alex Elder <elder@linaro.org> # drivers/net/ipa/ipa_smp2p.=
c
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Acked-by: Takashi Iwai <tiwai@suse.de> # sound/
> > Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com> # dr=
ivers/accel/ivpu/
> > Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com> # drivers/gpu/drm/i915/
> > Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> # drivers/pci/
>
> > -EXPORT_SYMBOL_GPL(pm_runtime_get_if_active);
> > +EXPORT_SYMBOL_GPL(pm_runtime_get_conditional);
>
> If pm_runtime_get_conditional() is exported, shouldn't it also be
> documented in Documentation/power/runtime_pm.rst?
>
> But I'm dubious about exporting it because
> __intel_runtime_pm_get_if_active() is the only caller, and you end up
> with the same pattern there that we have before this series in the PM
> core.  Why can't intel_runtime_pm.c be updated to use
> pm_runtime_get_if_active() or pm_runtime_get_if_in_use() directly, and
> make pm_runtime_get_conditional() static?

Sounds like a good suggestion to me.


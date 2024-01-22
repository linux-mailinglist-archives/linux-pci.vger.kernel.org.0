Return-Path: <linux-pci+bounces-2432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274AB83708E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 19:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572501C280CF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 18:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4993FE31;
	Mon, 22 Jan 2024 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RD8iuvLT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51A53FE20;
	Mon, 22 Jan 2024 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947128; cv=none; b=Bl2++bUxbMKsSyPrvQWX1g3sLpW8g8s3dJ3r2h6CdrP2q+xa7KizlHKNylpUtjPaG1snWjLnYlmQBRJNlOBXusiZyPN549IQ2iKdRl7s7JlJh9G2FEtCBfZ2pxa7+blHCpkkE96y+N1vMfSkkKou4UWZbG6SeubZ/T/BES8k+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947128; c=relaxed/simple;
	bh=X7GfhZVrnsTjbrFniNSElkwaarUNiRIasEFIuqkBbsc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XpiI4M86cWTacKbd+mR2FtRLgqklB7SvgHVIf8Jv06zoSoDlskFNdTSDMWkxc+MAA5/S7RN8ULrkHAnkcQVJ95+TYhWApD/8t+1cc9pcF5cBwfCdC+AmLE4Hg7SW+xkZpukFcL3o55269DKWGofUbskb0SbjJ2gSS/h8zgcZ4Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RD8iuvLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E09C433C7;
	Mon, 22 Jan 2024 18:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705947127;
	bh=X7GfhZVrnsTjbrFniNSElkwaarUNiRIasEFIuqkBbsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RD8iuvLT4Sv4aBKpW/AH0z/cICipgVW1lAjoC1YM1SyiKLBhrgz3HpvzH1fu0nXxq
	 vQj2C7z9nKhUhA7/137/0FAZ1UBUIJEqX2EfctHJRDcwwbF0B3eM2QUwSTO0EFM+S8
	 Yg16Li20dF9C76zTt/31v+fnBYVns0Nfn05p0rt7gygIitxU3Bb83OBnj1axDQ0+VJ
	 EZwq7+GP7yVeDXZO1XkZwJDVdbVocBqnaLtJc502siNpXTksX+/aFBCBazIDD38kBZ
	 t4xqOKiSwtjFP4ljsbSdg9zoGDHylXjw2ljwv+rHUHDX1WLpXQ1t5goVu8GYMzXfC7
	 VPLhQabcjhzIA==
Date: Mon, 22 Jan 2024 12:12:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Jaroslav Kysela <perex@perex.cz>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	laurent.pinchart@ideasonboard.com, David Airlie <airlied@gmail.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	linux-media@vger.kernel.org,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	intel-xe@lists.freedesktop.org,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-sound@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
	Daniel Vetter <daniel@ffwll.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] pm: runtime: Simplify pm_runtime_get_if_active()
 usage
Message-ID: <20240122181205.GA275751@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122114121.56752-2-sakari.ailus@linux.intel.com>

On Mon, Jan 22, 2024 at 01:41:21PM +0200, Sakari Ailus wrote:
> There are two ways to opportunistically increment a device's runtime PM
> usage count, calling either pm_runtime_get_if_active() or
> pm_runtime_get_if_in_use(). The former has an argument to tell whether to
> ignore the usage count or not, and the latter simply calls the former with
> ign_usage_count set to false. The other users that want to ignore the
> usage_count will have to explitly set that argument to true which is a bit
> cumbersome.

s/explitly/explicitly/

> To make this function more practical to use, remove the ign_usage_count
> argument from the function. The main implementation is renamed as
> pm_runtime_get_conditional().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Alex Elder <elder@linaro.org> # drivers/net/ipa/ipa_smp2p.c
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Takashi Iwai <tiwai@suse.de> # sound/
> Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com> # drivers/accel/ivpu/
> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com> # drivers/gpu/drm/i915/
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com> # drivers/pci/

> -EXPORT_SYMBOL_GPL(pm_runtime_get_if_active);
> +EXPORT_SYMBOL_GPL(pm_runtime_get_conditional);

If pm_runtime_get_conditional() is exported, shouldn't it also be
documented in Documentation/power/runtime_pm.rst?

But I'm dubious about exporting it because
__intel_runtime_pm_get_if_active() is the only caller, and you end up
with the same pattern there that we have before this series in the PM
core.  Why can't intel_runtime_pm.c be updated to use
pm_runtime_get_if_active() or pm_runtime_get_if_in_use() directly, and
make pm_runtime_get_conditional() static?

> +++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
> @@ -246,7 +246,7 @@ static intel_wakeref_t __intel_runtime_pm_get_if_active(struct intel_runtime_pm
>  		 * function, since the power state is undefined. This applies
>  		 * atm to the late/early system suspend/resume handlers.
>  		 */
> -		if (pm_runtime_get_if_active(rpm->kdev, ignore_usecount) <= 0)
> +		if (pm_runtime_get_conditional(rpm->kdev, ignore_usecount) <= 0)
>  			return 0;
>  	}

Bjorn


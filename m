Return-Path: <linux-pci+bounces-2505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 590E6839B64
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 22:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1201C20C17
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 21:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF47C3E47F;
	Tue, 23 Jan 2024 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FB8Yh7m8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25143B2A6;
	Tue, 23 Jan 2024 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046483; cv=none; b=C+CISNHQ9lbA0HRh/B8/70DkT8TqopVSpbqlxkfPZO3q3cZrKPAMoGG33ts8OUm1k93xJ7Lk6GzA4j1d+JDCDIPB2pZGvpnNDLTSEV6FfyAqmyTh2F88iBJ3n4kTNQFUoJrvUi/NbnQCZ0VPdaHpWbcJt4TKWI2eOY4Q17XOJLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046483; c=relaxed/simple;
	bh=lCHfHu6EUXojzzHzheXE7xt3G/zJ41N3IKBiY+lqP0k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zu2Dyp1bsMbNsnxZV+OTZi5gyce60VGN3u+IhzQ0bGg+s6DKe4bNcfXYtPc1B7n95FnY5ZMJuCqSryD8t1aoXcyNSeikpqnn/4agBYVDPpx3X0ZtzD9glYe2d+Q7zkfeqMiL+nTHmjEtR3+g+VlcEtp+eEZUNrIvK+c9H2X8FPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FB8Yh7m8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADADC433C7;
	Tue, 23 Jan 2024 21:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706046483;
	bh=lCHfHu6EUXojzzHzheXE7xt3G/zJ41N3IKBiY+lqP0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FB8Yh7m8pOYpYOeAiLCyS+voeY7F7smKIjPd1R48tio2TEDLdM6AiEiEqhtBn2q4A
	 vk68s1BpElRSXfqEsy0ZQVB2bgbFpAOMsuj6L+lfCPKDLHFHnZd0SOwD6SKdBHCy1q
	 Tt4isjg3ca4S7YLKd3INw4nVouhbKP86dTgaeSEVG8NanW6zL8IrvCR+n5ZakDH9xG
	 5rhQeuoRzar3sj6qaZkQNcGT9+tqVWcKcIoAKjxzH7dy4En63k5CCutR8hmFVuCVnB
	 osZb6XsfznsRDMcPdbrjCwBC1bUZeLf6c+iq09L1FsFUNHBOv4VIrMLZZ8r4Esu8mO
	 vGnoJv/BKxZtw==
Date: Tue, 23 Jan 2024 15:48:01 -0600
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
Subject: Re: [PATCH v4 1/3] pm: runtime: Simplify pm_runtime_get_if_active()
 usage
Message-ID: <20240123214801.GA330312@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbAlFKE_fZ_riRVu@kekkonen.localdomain>

On Tue, Jan 23, 2024 at 08:44:04PM +0000, Sakari Ailus wrote:
> On Tue, Jan 23, 2024 at 11:24:23AM -0600, Bjorn Helgaas wrote:
> ...

> > - I don't know whether it's feasible, but it would be nice if the
> >   intel_pm_runtime_pm.c rework could be done in one shot instead of
> >   being split between patches 1/3 and 2/3.
> > 
> >   Maybe it could be a preliminary patch that uses the existing
> >   if_active/if_in_use interfaces, followed by the trivial if_active
> >   updates in this patch.  I think that would make the history easier
> >   to read than having the transitory pm_runtime_get_conditional() in
> >   the middle.
> 
> I think I'd merge the two patches. The second patch is fairly small, after
> all, and both deal with largely the same code.

I'm not sure which two patches you mean, but the fact that two patches
deal with largely the same code is not necessarily an argument for
merging them.  From a reviewing perspective, it's nice if a patch like
1/3, where it's largely mechanical and easy to review, is separated
from patches that make more substantive changes.

That's why I think it'd be nice if the "interesting"
intel_pm_runtime_pm.c changes were all in the same patch, and ideally,
if that patch *only* touched intel_pm_runtime_pm.c.

Bjorn


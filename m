Return-Path: <linux-pci+bounces-2491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F9683964D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 18:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280EB1C23C36
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 17:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9026E7FBC5;
	Tue, 23 Jan 2024 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeSfU2Sm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4437FBA8;
	Tue, 23 Jan 2024 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030666; cv=none; b=gRZK9yJv0zGbgWFE+YB8ldNr0mVfg3txcBC7coR7kR8nArXej6rBtHkovJB/ap3XSe96P5NIaEXmcUlTRIjAZ7loHaWXcJq8ivt+Q6Ex5/ncXNro3h9welsj2rb6WAZtUm4PVSCtyYbiPb4wH6d2er3CWHymyKCG9BkvVa5R/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030666; c=relaxed/simple;
	bh=Oyao+3/Ux6TZycEPX8L/CtZdSt0adFVr9KdQJvVkrTM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bdfmiHotMcJwCEalqx6XJULQBJdFTXgwfX9s/hhgPNt6pQQj0C8mRJsZOLpn3wO3oywJ8OcLYE3R9O7hzAtWVdC7smdWQiycEp0iyvSRsOd5fx6JWU2IkTsTnzaKhIIuuLV3jxLbjZmEWgEkuSi7ut9u+Qe+kepmRT5OTuWk5Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeSfU2Sm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70157C433C7;
	Tue, 23 Jan 2024 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706030665;
	bh=Oyao+3/Ux6TZycEPX8L/CtZdSt0adFVr9KdQJvVkrTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WeSfU2SmF+MThNV+FwS3jNLbx/lbHqp3O8rGmEOzabcSnXEgrwMlsQB9X+zP4Dj5G
	 wd1fgHH0A7R0Tmo1hzTqTwsERG+4Gn3Cx5lBeFm5nnKu5zpyTImNwviF1z+B9Bs+B5
	 FDxtofh709s2gjhWj2TwrRefwkgnofaBeH2IOycUb4sAH6b1twJSE7eTOxL5ZpB136
	 XW94cTSytbK36zuZLvfHBZJyLBwQtXSssVanGsGSNlbp69amctnSVmvxMuZ0ytbIUw
	 x0q8WUofOp/tNMPpmUcwMX0JnwNQI0b6OZ1iN5n7Qvk/bytqBMVrKlnALAAEsYlcQ0
	 7dIeV9ibAJhkg==
Date: Tue, 23 Jan 2024 11:24:23 -0600
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
Message-ID: <20240123172423.GA317147@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123095642.97303-2-sakari.ailus@linux.intel.com>

On Tue, Jan 23, 2024 at 11:56:42AM +0200, Sakari Ailus wrote:
> There are two ways to opportunistically increment a device's runtime PM
> usage count, calling either pm_runtime_get_if_active() or
> pm_runtime_get_if_in_use(). The former has an argument to tell whether to
> ignore the usage count or not, and the latter simply calls the former with
> ign_usage_count set to false. The other users that want to ignore the
> usage_count will have to explitly set that argument to true which is a bit
> cumbersome.
> 
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

- Previous PM history uses "PM: " in the subject lines (not "pm: ").

- I don't know whether it's feasible, but it would be nice if the
  intel_pm_runtime_pm.c rework could be done in one shot instead of
  being split between patches 1/3 and 2/3.

  Maybe it could be a preliminary patch that uses the existing
  if_active/if_in_use interfaces, followed by the trivial if_active
  updates in this patch.  I think that would make the history easier
  to read than having the transitory pm_runtime_get_conditional() in
  the middle.

- Similarly, it would be nice if pm_runtime_get_conditional() never
  had to be published in pm_runtime.h, instead of being temporarily
  added there by this patch and then immediately made private by 2/3.
  Maybe that's not practical, I dunno.

Bjorn


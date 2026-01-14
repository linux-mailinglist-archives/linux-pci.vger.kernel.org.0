Return-Path: <linux-pci+bounces-44791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CB9D20B56
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F0033016347
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E189532C934;
	Wed, 14 Jan 2026 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXrqNV7M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF5732B98C;
	Wed, 14 Jan 2026 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413605; cv=none; b=qw3Q/fZNStxeN/03y7KXTJGBbYPw86vTHwGQ/IYtZVKerKUJL63xNTXXBn0eo1wn3rueKDIBYfnqHzwdX48LJL897sMrm/VSu2IGiICQlPWkTsqlU+Exw3nGQxq+/cAKeWdloD5yxmOXcOTHIuHs1hiGGcJ70sRpOtcoGnPaG3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413605; c=relaxed/simple;
	bh=Euk489+L+tzF9bfrZrLQCpFbXfk68yttgw2jj78uX1c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YfstonIGQmDwop5320aCUG28DGFg2vu97XAlEr92ab59zKsZaJVE0OSVtFTdzFIwCzc7ABAScr6vudTfuhfd0qROIYp5ZmwdR0nZVgHi6ImchL8qxu+obt3WqQrgXw7W/n8Kslw7/qFzrZDZnVMiwjHNv5RcZrEQT+ujo/xNJoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXrqNV7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F5FC4CEF7;
	Wed, 14 Jan 2026 18:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768413605;
	bh=Euk489+L+tzF9bfrZrLQCpFbXfk68yttgw2jj78uX1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JXrqNV7M889KRN2lWP2/mAtHdJEfJ7qlUsXGZqUYIEgw1QVxK/pVdr0S++3ZDeBS+
	 R90osSaJUfPbwU7OLbw5xvikDFAwWmdT1PJH441VI9Kptvbtz1pM37MZIfBFhELvj9
	 WaTMCwRhSA1EcrxE2sCHjH/ijFH9+YDYb7knC8dmSNecO0ixXu+BJVbJ9ODoUrFcuX
	 cLRAA9OSbfUrVs4eVXuJFn+lGIoCiintELnwxfarYjyd4fAeughwCfDKV2MSE88Gbv
	 XmSXq218SEXSsljvu7ym4UYchUwPERB/1+dlIM/zesQQe71bWs9ruDWakm1FO4N2PL
	 t4NR64Kho3N1A==
Date: Wed, 14 Jan 2026 12:00:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Badal Nilawar <badal.nilawar@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, anshuman.gupta@intel.com,
	rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, rodrigo.vivi@intel.com,
	varun.gupta@intel.com, ville.syrjala@linux.intel.com,
	uma.shankar@intel.com, karthik.poosa@intel.com,
	matthew.auld@intel.com, sk.anirban@intel.com, raag.jadav@intel.com
Subject: Re: [PATCH v6 09/12] drm/xe/pm: Refactor PM Sleep Ops
Message-ID: <20260114180003.GA827167@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113164200.1151788-23-badal.nilawar@intel.com>

On Tue, Jan 13, 2026 at 10:12:10PM +0530, Badal Nilawar wrote:
> Refactor PM Sleep OPS to indicate xe_pm_suspend/resume is called
> during hibernation (S4) or suspend (S3/S2idle).

> +	 * Enabling D3Cold is needed for S2Idle/S0ix.
> +	 * It is save to allow here since xe_pm_suspend has evicted
> +	 * the local memory and the direct complete optimization is disabled.

s/save/safe/ ?

> +	/* Give back the D3Cold decision to the runtime P M*/

s/P M/PM/


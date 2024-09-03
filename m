Return-Path: <linux-pci+bounces-12707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9791E96AC51
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 00:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F9D1F25440
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 22:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FC71C62A7;
	Tue,  3 Sep 2024 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5ikGzHt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C175D168D0;
	Tue,  3 Sep 2024 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403160; cv=none; b=evPbJKFaEHmFSufYyg2zPl4aEuJnM2b8h/z598iC2A/nSyArzgZ5Phs0rNtSEFpGf50q4O/AimOpJR2DvTH5EjSzaap6mVsg65iMvsxAqSO+ilWEi+0H6tA1X6aH90Z8GdUxsbiaoCb4F/psZoq8RlNIQsuH2VUnNUpZNs8yEd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403160; c=relaxed/simple;
	bh=NFLvBypMWx0Lw7211t/yzeX6xqZ71qCeGWxd1ZzjlF8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zf7qYHzZJxexIPMhKdavZ0tZJgaUSoQ3UurnL6fb+McX6ky1bXl69rcyb1i1Qk8yLw4ixqMJXN6lzyB1CpEUc8hd7XjW/E4C4aFWzO6gU4VjSt6hP54TErIG8YsOvoMfEdg9XxW85ZXzutrfJLsYYwNgJFqrwRWJfsGDVZuz+qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5ikGzHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28447C4CEC4;
	Tue,  3 Sep 2024 22:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725403160;
	bh=NFLvBypMWx0Lw7211t/yzeX6xqZ71qCeGWxd1ZzjlF8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=P5ikGzHtU2CLCtR6YiBVKmpjvukZS++tkvryAuhztdwDzKR+WawMjzrmk+igI3hJ5
	 5Cv1Dz5Hby1sbkMPaC2WESiUh4lishIXqNkUaNgwEglyHcZP8BgIpX5P/FGlfWQch7
	 vCRO0y1OB13OzROdIWcjc/YLv+u/G1vKgwOaQjQXt/HiIDOtRP7Sj4OzZJINnbtEyr
	 Gss69fphADbcYUnj6V1Qt5yPajCMsPTPyaO3EwphxhxHewsvPQw/wia8IcFHePEq2H
	 t3UbmBDNUPyKMqVlIpEIDi6RnSdyzqKNDkge4UHa84YFh/7gWyNGKLzJuE9xtiU3u6
	 H6R84kha5nTzw==
Date: Tue, 3 Sep 2024 17:39:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: scott@spiteful.org, bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	wsa+renesas@sang-engineering.com, lukas@wunner.de,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] PCI: hotplug: check the return of hotplug bridge
Message-ID: <20240903223918.GA307750@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831132822.22103-1-trintaeoitogc@gmail.com>

On Sat, Aug 31, 2024 at 10:28:21AM -0300, Guilherme Giacomo Simoes wrote:
> In some pci drivers, when the pci bridge is added if the process return an error,
> the drivers don't check this and continue your execute normally.
> Then, this patch change this drivers for check return of pci_hp_add_bridge(), and
> if has an error, then the drivers call goto lable , free your mutex and return the
> error for your caller.
> 
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>

Did you see Lukas' response at
https://lore.kernel.org/r/ZsAzM8K9PnN5jxR9@wunner.de ?

AFAICT the discussion he pointed to is very relevant and needs to be
considered before we apply a patch like this.

If you have addressed those comments, please describe how you
addressed them in the commit log, and include links to Nam Cao's work
and cc them as well.

Bjorn


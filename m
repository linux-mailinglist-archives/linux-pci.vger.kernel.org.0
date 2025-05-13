Return-Path: <linux-pci+bounces-27663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29662AB5D51
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 21:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0CC3A1575
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 19:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2221B3950;
	Tue, 13 May 2025 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkPY5pL2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D973596B
	for <linux-pci@vger.kernel.org>; Tue, 13 May 2025 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165510; cv=none; b=WLN3Kcyf/XgJpxj2M/UYXOLrfQGNDc0mnUJf//Bxz+lwJZUuEuPkOn8E/Kl64XHwUwuN+9Rgr+5CQS5rq7aSDsNycnXUceBV7AjjcL+X7eAV85/injAw52n9kiKFFNp+C+KK/wMGJPuYfbjxM1yo6mVL/mjUuX9OgR/FoDhsMxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165510; c=relaxed/simple;
	bh=m9PROLho9+GpxfHp1Yilj0rhBbOgkLCMH6RLWWDqqQU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m02Nav4ofZBFYP3G5+hjpuxryVVyiJFsRed0KwBESuEdKnREgXfXz0yJmmw9f2mOML1lk+bA2xGn4BVXq/nzompDweB05SluuBpXP1M6IUzxUUdiRE+pEwKNsAi/adJVbjuwNDByL90XmL8j+jMkTUrd4AcFb+dyBK4XCobdRow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkPY5pL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A754FC4CEE4;
	Tue, 13 May 2025 19:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747165510;
	bh=m9PROLho9+GpxfHp1Yilj0rhBbOgkLCMH6RLWWDqqQU=;
	h=Date:From:To:Cc:Subject:From;
	b=PkPY5pL2cqq/9uWKgMH02QSDVG0wir6GfxHhwQbqZq9vdSLF0ozqAZfByn9uU88aQ
	 3mgsQT9ALs1nLRF8N8BD4e0qXJ2KUviUbG8aNoTQ84gMQ+1410vnvkH4H76JA3iu5p
	 L2ShPEGIkk9AagaGaPTUFoataB3//rndG5/J1o5YYUjJKCnQ1kSxcwbLw+Y1OkUjBK
	 v7e2Ls6IlFrICjHtZCGJdTq5lf4Hv6nD2YiIKXfjAtqmbHnc+7G7zG7D9WO9FnpuWg
	 AMLB7czEtbNqIfM5ONCw8e62VyayTzomZczmA0kACJBssioOHdp3t4mnkRxNymg1QQ
	 MID06mosndBJA==
Date: Tue, 13 May 2025 14:45:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Denis Benato <benato.denis96@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yijun Shen <Yijun_Shen@dell.com>, David Perry <david.perry@amd.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	AceLan Kao <acelan.kao@canonical.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Merthan =?utf-8?Q?Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	amd-gfx@lists.freedesktop.org
Subject: [Bug 220110] probably thunderbolt or pci leads to pci usage counter
 underflow
Message-ID: <20250513194506.GA1155899@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From Denis's report at https://bugzilla.kernel.org/show_bug.cgi?id=220110:

> I am having problems with my laptop that has a thunderbolt
> controller to which I connected an AMD 6750XT.
> 
> The topology of my system is described in this bug:
> https://gitlab.freedesktop.org/drm/amd/-/issues/4014 yet I don't
> know if this is related or not.
> 
> I experienced PC attempting to enter s2idle while playing a YT
> video; PC has become totally unresponsive to input in any
> keyboard/mouse and power button after turning off screens attached
> to the AMD card (the built-in screen was off already).
> 
> From a look at the logs it appears one uncorrectible AER pci error
> triggered a pci root reset, and that comes with a bug where the
> usage counter assumes a wrong value; this in turn seems to cause all
> sorts of weird bugs.
> 
> That however is my interpretation of the attached log, that might be
> very wrong.
> 
> This is the first time I experience this bug in a year with this
> laptop and I don't know how easy it is to reproduce.
> 
> The kernel has been compiled from sources and it has
>
>   [PATCH v2] PCI: Explicitly put devices into D0 when initializing
>   [PATCH v4] PCI/PM: Put devices to low power state on shutdown
> 
> as I am helping testing things. I find unlikely any of those might
> cause these issues especially "PCI: Explicitly put devices into D0
> when initializing" that has been there for a few weeks now.
> 
> Thanks in advice to whoever will help me.


Return-Path: <linux-pci+bounces-12170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C97D495E341
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 14:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22601C20B0D
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 12:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B576D38F91;
	Sun, 25 Aug 2024 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wekktgtE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nqm73YxG"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBA34A2C;
	Sun, 25 Aug 2024 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724588532; cv=none; b=MtzeFiG7A9CHBwmafgI1GwYFIRSi2OGj57UsrAY0UeBW9Y0YMH1H5HNxmRGtWsMCKEpBGDSIrlZGxW8xxil1Wwj9W517RW/7L3bdCGqXBtcoUtWx82KLFzr1ncfQAjZgx5OVMnAMbVwJkbbCGuOr/nFy7rCo1fLrPTxRluTTMdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724588532; c=relaxed/simple;
	bh=PaZ3gkK7BW4zjJh2O4S3YcY9cxxZbVbiqcRgQ/9z0oI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h8OnvGBHUgsK9hXDKrbc2Yq4pEaFDGBEXDIEQI5fFLptzGcty2NIwnerVa0mJroFFfSA18FVjlsBjIBJo6C95GuNAFOR5TbKtWm9ZYVYhto0KvDIpqdM9stnKuTVXAlDiT7Kd/WyX6mazx3Umu8/BzE/3rkXzSRM12XQTlx996s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wekktgtE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nqm73YxG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724588529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TvDebQL130PXgRqRzd/ZewCYQHAzeccg/U2iwVkVr0=;
	b=wekktgtE/ba7qg2rtEKFNctCrisDl184b4ixuH3+slztEb+EnIdAzBRq4FVDblbw0foAyI
	q2QSVM07rxIWpnJ9bI9kvDWOYIBq5gxVk8REYNn+9Yu5VF9wpnQM3/N+ZSuWQjEugWUZ7H
	WZSh3BxPQ4jrgK1gegJw5c08A3utl9qzTYBz8id5CMvS+VrHRyzTKJUMTkwCozNYV+WYg1
	LrspcPdTT182e/p+zbdcowdLojOCoQ+FYQ9FhjNtZcDh9IPOJnvRjKp/N9GO05ctWgRjxC
	07r9mCHVdU3Kcx2zQ34JxOHOuveZPnU8GRI/pVIJIdEOe555p8jxSl3UA7oBNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724588529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TvDebQL130PXgRqRzd/ZewCYQHAzeccg/U2iwVkVr0=;
	b=nqm73YxG2F0LLA2+N30jhceXOlcYJqz+4Ohc7yNOIxqNbobplQYDZ+mF72uyp4D3JGpRQh
	cT30jBKaamF37bCw==
To: Mario Limonciello <superm1@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Mathias Nyman <mathias.nyman@intel.com>, Mika
 Westerberg <mika.westerberg@linux.intel.com>
Cc: "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, "open list : USB XHCI DRIVER"
 <linux-usb@vger.kernel.org>, Daniel Drake <drake@endlessos.org>, Gary Li
 <Gary.Li@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Mario
 Limonciello
 <mario.limonciello@amd.com>
Subject: Re: [PATCH] x86/tsc: Use rdtsc_ordered() when RDTSCP or
 LFENCE_RDTSC are supported
In-Reply-To: <20240823042508.1057791-3-superm1@kernel.org>
References: <20240823042508.1057791-1-superm1@kernel.org>
 <20240823042508.1057791-3-superm1@kernel.org>
Date: Sun, 25 Aug 2024 14:22:09 +0200
Message-ID: <8734msg5ce.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 22 2024 at 23:25, Mario Limonciello wrote:

Why is this hidden in a reply to the middle of a PCI patch series?

Sigh.

> From: Mario Limonciello <mario.limonciello@amd.com>
>
> On AMD processors the TSC has been reported drifting on and off for
> various platforms.  This has been root caused to becaused by out of order
> TSC and HPET counter values.  When the SoC supports RDTSCP or LFENCE_RDTSC
> use ordered tsc reads instead.

This really wants a fixes tag.


Return-Path: <linux-pci+bounces-3420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0744853E61
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 23:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCA21C21B5D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 22:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58DA62A1E;
	Tue, 13 Feb 2024 22:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMpBcMB0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7549D62170;
	Tue, 13 Feb 2024 22:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707862447; cv=none; b=CXt8fXaevsUSPR9UmdLaj6CrWBUDGPX9pV/FIJJSvYnW6XVEU/ej0DfRwr8hmyjezoweUVmccFVRtkzrHQADAoIG5QKTZ1MoGq8bfr0OCXKpq72Hu2TdkNuWoVYxfZOnXSeU4xTF/yyrNhZmZPtw6hRVgfYA5xYCbSM59HSdhaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707862447; c=relaxed/simple;
	bh=ENAzlVwIn8iATwoFyUwcJu/H29SD7Tn0lylWDcYosr8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b3Vl7MokJVK+UD6fSQ+3xIxIsqjRzTMK9uY1+6knEpiohr45LSCYAtnhjWsWWYBLN/YtoX/qlwVhOpTjVzJknEJPPDK336OEzU/NQr9hJE43swB6tSWivsRPh44xdt6t6EvpDvAHzKHxQoVItAAeEWR86qFLfXm/2BoOkA0cEYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMpBcMB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6C5C433C7;
	Tue, 13 Feb 2024 22:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707862447;
	bh=ENAzlVwIn8iATwoFyUwcJu/H29SD7Tn0lylWDcYosr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dMpBcMB0bqcExy+SMPIE6oNVejB8baAtAjplWDwOD2B6k8kGwjuI0/NQl+O8tzRF7
	 QujJNg/mpCJHqHhYHSQTUfuMjJda8qKGQ8Kf1ExJ2q8RrPgMXWnIy94zy/afn/87cX
	 OR9JP308n6DDYd9RTjclQSqM0ktukBbp6gJPyYLrahIaMBVqcjsAwptVqOrhKRTkeF
	 QyH63FRx3olmW3W/RRvgx0pHw1k2NG/bgQYU9RTz1eZA+P/7f3SasoNgw8NzXbjf6x
	 q3emff/jhAkt5aWFIVpSwNYt0BtCT0zaRNHd3Tacp84EUAAy4R3UK3cYUDCaDWbaKe
	 jWs5VIvX3/4rw==
Date: Tue, 13 Feb 2024 16:14:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Onkarnarth <onkarnath.1@samsung.com>
Cc: rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	r.thapliyal@samsung.com, maninder1.s@samsung.com,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: Re: [PATCH v3 1/2] ACPI: use %pe for better readability of errors
 while printing
Message-ID: <20240213221405.GA1230483@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213074416.2169929-1-onkarnath.1@samsung.com>

On Tue, Feb 13, 2024 at 01:14:15PM +0530, Onkarnarth wrote:
> From: Onkarnath <onkarnath.1@samsung.com>
> 
> As %pe is already introduced, it's better to use it in place of (%ld) for
> printing errors in logs. It would enhance readability of logs.

Here are some more candidates that I see regularly:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/dd.c?id=v6.7#n590

Something like:

  git grep "\(_info(\|_warn(\).*%d"

finds a ton of them (plus a lot of unrelated hits, of course).  If you
were to do this for drivers/pci/, I would want them all for the whole
directory in a single patch, and I would take the opportunity to make
minor changes so the style is more consistent, e.g.,
"... failed (%pe)" or something.

Bjorn


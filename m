Return-Path: <linux-pci+bounces-45093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A01BD38EB7
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 14:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC1743002536
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 13:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741A519AD5C;
	Sat, 17 Jan 2026 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltWExw04"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC5126C02;
	Sat, 17 Jan 2026 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768656987; cv=none; b=V5I/wVma3IXNOzl+CxTeH5QiBgadGVF3cvvfjHlHmFfj9IW/FA5rEnL3nCVpfxIP+v1TvwbzXFoWVTfZ9Du75cASTF3y7L507x4B11XYvxpmraCEh3d8RFQqgtP9UKsRC6sOPWnmufWv/7BCWMCPcLwsB+ltE3W9WerKAb8QGeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768656987; c=relaxed/simple;
	bh=vnwT158Epxhe04CU4LK8h34v5kHqeexLFo/E08FU7KQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=Sc7Ah/v8OqODYetGigJW5gnARe5xEtdEVsBcZIPq8HOKDur0aTqRGYiZqI/l47wbM9nMg+B7p348D0tXUtFfhsPaeXHM8A73iS45rzeRCEj3AgGuaNx+WfiqU9NeBmMvv/iV1zChfqSC70MFF/XHRWa4ek3qcQaxgtKs1tNs9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltWExw04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A27C19421;
	Sat, 17 Jan 2026 13:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768656986;
	bh=vnwT158Epxhe04CU4LK8h34v5kHqeexLFo/E08FU7KQ=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=ltWExw04d20+qef0fjPpX/viXeda3fD4C3SRA3ifl4TRGgb50ylnLBUY7srMoHz+P
	 Dmay7GMa3+FQQW74YoBc7q+pXSWVx+cS3PxKCkO55ZrbhYn/F4KezJ4XESNeTVeQSu
	 Io3i3eUXy95bN6BooQdwZ9X0WeS92Wx82789uElJ35IA5iUynQr4LHbvOq9Hucxivj
	 qQ/YL0JTKyp6YeYJXlA9P676GIfIbmV3EbHnj9i1HhITWaBydBAXTGY7pqgZLBogku
	 UoSzGFDP4BsS+kCOe+TOtp7HWoDwtEEYpA4F0rxF3POpUSoFGA4TUj1Gwko9mGq3HD
	 tXGmKf9QrhSYA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Jan 2026 14:36:22 +0100
Message-Id: <DFQWKP2W9NET.2BA7CCOTLFK3J@kernel.org>
To: "Jinhui Guo" <guojinhui.liam@bytedance.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/3] driver core: Introduce helper function
 __device_attach_driver_scan()
Cc: <alexander.h.duyck@linux.intel.com>, <alexanderduyck@fb.com>,
 <bhelgaas@google.com>, <bvanassche@acm.org>, <dan.j.williams@intel.com>,
 <gregkh@linuxfoundation.org>, <helgaas@kernel.org>, <rafael@kernel.org>,
 <tj@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
References: <20260107175548.1792-1-guojinhui.liam@bytedance.com>
 <20260107175548.1792-2-guojinhui.liam@bytedance.com>
In-Reply-To: <20260107175548.1792-2-guojinhui.liam@bytedance.com>

On Wed Jan 7, 2026 at 6:55 PM CET, Jinhui Guo wrote:
> Introduce a helper to eliminate duplication between
> __device_attach() and __device_attach_async_helper();
> a later patch will reuse it to add NUMA-node awareness
> to the synchronous probe path in __device_attach().
>
> No functional changes.
>
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>


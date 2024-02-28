Return-Path: <linux-pci+bounces-4174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E770386AA2D
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 09:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D32228A0DA
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 08:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF113613E;
	Wed, 28 Feb 2024 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="GNrYvLqP"
X-Original-To: linux-pci@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99C8339A1
	for <linux-pci@vger.kernel.org>; Wed, 28 Feb 2024 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109298; cv=none; b=kSW4IYJnGarQyB3tVP7u88sF4nTn8nQX0tYXLAf2ltNcBxZdYT9VsKbHVNcU0KNAUT4+tWYxihQIjLlYBY9/f5VJIL0Ba6l46ckv1IC9jyiI3p0Mza9GBCju7lhpKDPfBrYl+rSYWh/lRnRKgjhqBZo8h+DJd1Kz9eL7OVbbTKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109298; c=relaxed/simple;
	bh=n295qIbpvY/+rh8OUlBCkpxsEe7pzRcpAtG/jiUFWR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKYpzsGo71KRde8ZRVq49xYMdO1Oaqhpi3xaFNNlD5c6OuPhAXHeMZR1GrmZjyz37JWyntdzpN6lmDyhQFOrlZ/ZtnksVvgjM4cjH5r+d3lM/MXv13O/zLYrW0FfDKglhuLRrK3lEmMaIlDfHQHk62UL3w3MTNvlbZmioHCyrlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=GNrYvLqP; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id BA903283E3E; Wed, 28 Feb 2024 09:34:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1709109287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TO0KebetWmsyxUqbipCxflfdiZDixsVMk/BoIhk4EsI=;
	b=GNrYvLqPFtP41wuLo4daPme0xY5DLnDpz2F2krNQh1PZPgAVtZAplR4xJOps7J6tUfqocG
	KZ4RX/8nImWx97i9PMuK25tcGolZiSsFw7Tv1KLGr7OCc1GUsqtY0opuCIfSdZhHgMJ5IA
	HziBXf4lrkK9+DB87AVPeDQeKt7cShs=
Date: Wed, 28 Feb 2024 09:34:47 +0100
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Cc: kobayashi.da-06@jp.fujitsu.com, linux-cxl@vger.kernel.org,
	y-goto@fujitsu.com, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com
Subject: Re: [RFC PATCH v2 3/3] lspci: Add function to display cxl1.1 device
 link status
Message-ID: <mj+md-20240228.082836.19016.nikam@ucw.cz>
References: <20240227083313.87699-1-kobayashi.da-06@fujitsu.com>
 <20240227083313.87699-4-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227083313.87699-4-kobayashi.da-06@fujitsu.com>

Hello!

> This patch adds a function to output the link status of the CXL1.1 device
> when it is connected.
> 
> In CXL1.1, the link status of the device is included in the RCRB mapped to
> the memory mapped register area. The value of that register is outputted
> to sysfs, and based on that, displays the link status information.

I like using sysfs to access the RCRB, but since it is specific to Linux,
you cannot do it in ls-caps.c (everything in this file is platform-independent).

The right way is to extend libpci and its interface to platform-specific
back-ends to provide this functionality. However, I am not sure that we should
add special functions just for this purpose. I will think of something more
general and let you know soon.

Otherwise, please follow the coding style of the rest of the file.

				Martin


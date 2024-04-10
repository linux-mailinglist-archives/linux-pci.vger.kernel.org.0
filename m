Return-Path: <linux-pci+bounces-6079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EAB8A00FD
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 22:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558581F247CB
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 20:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F1818133A;
	Wed, 10 Apr 2024 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poKjChGY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9DE18132B;
	Wed, 10 Apr 2024 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712779426; cv=none; b=dylt2snQwyaUZwMV6HHy6eGYgoiDRRjO86OuOPs/PSpcuqJ2ux3zvUuDIA1kpVq3fqzKbfA9u8wvqt+ZHMvbbREbem6vKFwAQtGWdaxh0soLt0ELMh5jCsmvPvMDigreEO621MP2F+xUlf4BPImTQpmaYCAVjp8XjQKTjYaourM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712779426; c=relaxed/simple;
	bh=fgfKsB/fGZU/LvMCIubsUr0QwnLuGK+aV9HTKLwAaOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDCcUxO7lJxKBfaIaG0AsmSSaoXy1URs0sGrpM817bbY1zMAg7YU8Z325sTwiy6KNke9hCCkxL4hwLSuUyXVBioMQ2mHAfVIhyhHwDoiGkdN3U8PrWIKO01bNNsgulpx/si/JfejxA7YOP9rqqtn6exHA9fPNuRD5cIeg4OCTt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poKjChGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684E8C433F1;
	Wed, 10 Apr 2024 20:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712779425;
	bh=fgfKsB/fGZU/LvMCIubsUr0QwnLuGK+aV9HTKLwAaOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=poKjChGYwJW0JiDLoaI7U8L7osIThOIHfjN16wtAhAVHmFc42xl1jb+hGVOpPNSac
	 Jw7LNmyo+6cRU9dPbfjtaKdgiwK9NGGWoQNO6NUz89eOXFgwTc7QVBKtwTbY3tzlgh
	 Gsz26j250nE0XCuIXNUDuY0K20ncDUWqJhq8QLdcAEhA+TPDM8oPKBVOdvHwZhuJqX
	 AGgpGly14f1FD4TECCoFmfaYCWYF+lH9B1WtC+MjK8yxpJH2UqYKUzV+1Ezkd4P1i9
	 oHYO6HwgkOOdjgNVPCboUffNURvceco2AsJXCQJrz3lmioKpvuCkGLkSVFybbQIHHr
	 deUPnKO3iZFfQ==
Date: Wed, 10 Apr 2024 13:03:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, pabeni@redhat.com, John Fastabend
 <john.fastabend@gmail.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Andrew Lunn <andrew@lunn.ch>, Daniel
 Borkmann <daniel@iogearbox.net>, Edward Cree <ecree.xilinx@gmail.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org, Alexander Duyck
 <alexanderduyck@fb.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240410130344.11292750@kernel.org>
In-Reply-To: <d8433563-f867-428a-bd8a-9bfffe744da4@gmail.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
	<20240409135142.692ed5d9@kernel.org>
	<ZhZC1kKMCKRvgIhd@nanopsycho>
	<20240410064611.553c22e9@kernel.org>
	<ZhasUvIMdewdM3KI@nanopsycho>
	<20240410103531.46437def@kernel.org>
	<c0f643ee-2dee-428c-ac5f-2fd59b142c0e@gmail.com>
	<20240410105619.3c19d189@kernel.org>
	<d8433563-f867-428a-bd8a-9bfffe744da4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 11:00:35 -0700 Florian Fainelli wrote:
> although I cannot really think about an "implied" metric that we could 
> track, short of monitoring patches/bug reports coming from outside of 
> the original driver authors/owners as an indication of how widely 
> utilized a given driver is.

Not metric, just to clarify. I think the discussion started from 
my email saying:

 - help with refactoring / adapting their drivers more actively

and that may be an empty promise if the person doing the refactoring
does not know they could ask. It's not uncommon for a relative
newcomer to redo some internal API. Not that it's usually a hard
transformation.. Dunno, a bit hypothetical.


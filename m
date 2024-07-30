Return-Path: <linux-pci+bounces-11013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15C3940DF6
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 11:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5332824BD
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 09:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D55F194C76;
	Tue, 30 Jul 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fqnrwhtW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B1C18EFE0;
	Tue, 30 Jul 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332432; cv=none; b=VcECSEUf/PKeFjwvkyhV1lm5QdYQaiARiVAS3cBjmOzWHLAw70KQaDUhuGtDCrG01Ikc3JpO3a3jEPv1OnVUvupuAYkEN8AGyUHOEhTHQSewgoxS22yblFgosyCRTp0pWRTYX28KzoQtEgA+oToPmvFwENdSVHSw9LcmeZJGQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332432; c=relaxed/simple;
	bh=D5RnQCFJ217lJmZG+Sy/gnJt/5wrPqceaiX58e6Fw7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts/J1IWf7883H8VVqRRf9DEhrLbxvmPDxjUcl80oIfeOA88C3v4wElnqTJyp6YHfGvrlRZXia5lZtrle5HLY4vsDgbkuRcAREm+RxKdRW3VlhGsZqucLw/m8luYDHI6qasQjRuTZBz6/KFjKFAh3LXWDsXx6+vZes0CjYqGlr9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fqnrwhtW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43208C4AF0B;
	Tue, 30 Jul 2024 09:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722332431;
	bh=D5RnQCFJ217lJmZG+Sy/gnJt/5wrPqceaiX58e6Fw7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqnrwhtW5PYpnknOyoZNJgTiZdciXkrkVBTl+Hve10Kv0x2Vb1yB12/bVigcqIfIt
	 09q/yN7aUqNDDbPTALSD5ibN5EwSjyu1oHgoUvKrSCGMXyfvltKqjoVhHbuOvqB0HI
	 Ce8BiyETtkMsqOkz4RByoxMY6HCElQZuvPyBCtwE=
Date: Tue, 30 Jul 2024 11:40:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5.10-stable 1/3] locking: Introduce __cleanup() based
 infrastructure
Message-ID: <2024073039-palace-savings-1849@gregkh>
References: <3c1751533b20c5ece6ff2296c1d79ac7580200a0.1722331565.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c1751533b20c5ece6ff2296c1d79ac7580200a0.1722331565.git.lukas@wunner.de>

On Tue, Jul 30, 2024 at 11:30:51AM +0200, Lukas Wunner wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> commit 54da6a0924311c7cf5015533991e44fb8eb12773 upstream.
> 
> Use __attribute__((__cleanup__(func))) to build:
> 
>  - simple auto-release pointers using __free()
> 
>  - 'classes' with constructor and destructor semantics for
>    scope-based resource management.
> 
>  - lock guards based on the above classes.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Link: https://lkml.kernel.org/r/20230612093537.614161713%40infradead.org

Do we really want this in 5.10?  Are there any compiler versions that
5.10 still has to support that will break with this?

Same for 5.15.y, I'm loath to apply this to older kernels without loads
of testing.

thanks,

greg k-h


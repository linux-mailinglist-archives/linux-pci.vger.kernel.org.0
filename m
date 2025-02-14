Return-Path: <linux-pci+bounces-21526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0477A36787
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 22:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3584F3AED4F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 21:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE461990BA;
	Fri, 14 Feb 2025 21:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8N+iRKX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C6917E;
	Fri, 14 Feb 2025 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568504; cv=none; b=AzrRbqgOJh0yzTqMHTL65hnu3HHFurud+Ah3UAq2GtUMi+wGkW400CYryw8ikuBezP2bNgJNkNjKPX1I57bOtZhyqqIktwTjFCbwf7tHiEA4japaUl+1HnpusjYIRxvyQOkIv2SYFA/g7iUXC8E45T9mW28iYXSJpw48yq23SRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568504; c=relaxed/simple;
	bh=uZ7pFdGHtxMYUQf/oTtmPLljCythjv8DZAJvwpwFS10=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jmUiRVgzgpzo1kI4TRnlLMmAtk5T7DVDnBhHObhRTUs04hlVRJQoLgY6zpFNOlMWMv8cZpsxcyDEfkKqaCJ1cKzQ6qSqFsDUbYpA9R4NpW4i9Z4xRwThAw7Ak81ESYnIml10BOlbP3jxwQqz2osoOwCQNmGIHmNMyg/Qf1BPYi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8N+iRKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146D6C4CED1;
	Fri, 14 Feb 2025 21:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739568503;
	bh=uZ7pFdGHtxMYUQf/oTtmPLljCythjv8DZAJvwpwFS10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g8N+iRKXxeQd05o77sZwu+JAByvpvdbX2U9OvGLvSTd3wdPpmF9D/nKAlaHFr/+UC
	 O+TLB7WmABCBNOe1CP98JnY0k2Bc/u/WbjbRPqEhQxAVNWorPsIFqmhNp6ZgHQ8fAf
	 76p5Azu5+EmueGeQ94aFkKKhzTdNWMR9CUGLaIc5GJEkbZOgNAEr25BnQ64bClTu7V
	 V3xw7eFZOHEKntqXz1U4eBR3ViMFTLIJENumeu/aQju/fOF7/1gMFCL6OM98e5+aaw
	 Gp2DXyr8rZMLme4FYwDvI1rQFnEw7kS1xe9B2xzlzmGIwZlW87FuSQiME7BgWs4PGa
	 /8vhIk3SHXgcA==
Date: Fri, 14 Feb 2025 15:28:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Xiaochun XC17 Li | =?utf-8?B?5p2O5bCP5pil?= Xavier <lixc17@lenovo.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 00/25] PCI: Resource fitting/assignment fixes and cleanups
Message-ID: <20250214212821.GA157531@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc575157-ab4b-c287-2ba5-b277aeb8c5ef@linux.intel.com>

On Fri, Feb 14, 2025 at 01:53:24PM +0200, Ilpo Järvinen wrote:
> Hi Bjorn,
> 
> Can you please add to the last patch of the series:
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219547
> 
> ...And also Xiaochun's tested by tag from below to the series.

Done!  How exciting to have somebody step up to work on this resource
assignment mess, thank you!

Bjorn


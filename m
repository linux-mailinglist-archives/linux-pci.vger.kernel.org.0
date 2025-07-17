Return-Path: <linux-pci+bounces-32449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD8FB094FD
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 21:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B0B5A209F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 19:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D55A2F7D0D;
	Thu, 17 Jul 2025 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEE7+Fcp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24642153CE;
	Thu, 17 Jul 2025 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780592; cv=none; b=dfO+HIfPFU5BBUMJZpQVAMjExvukU7MafxE4LPSP70wRy0Jb/l4pOR9xE4b1obKaUNN5OCrqQXpkPrYrsk2abFHBW5dlAXxERL2/F4CAY6gEdpP6I+YC7QwULqga/BL7fMUYlOtKD6rMWYeC2cSTVBv3ExQb4Cc0CR5WTPHWzqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780592; c=relaxed/simple;
	bh=8HmzSzAM98imvYalhA76pwzsh+2wkE6ilBhKt2HWPqY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AuM9vxBRSFWvQAMgGaN+d0DqftRb0MRJAKHMuuBsIybNXK9eD3CG9+cksEku8Ms/zN1Ckb1CXewT3naHfRl/cQoOBI+Y0OxJifzjF/5IRLAHWhHUV6eBqsPyGNdk7vaVh5ekkiQ4wNMwoh7VsxBvwKPX0AKMJTrI03N3w1ffjS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEE7+Fcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E726C4CEE3;
	Thu, 17 Jul 2025 19:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752780592;
	bh=8HmzSzAM98imvYalhA76pwzsh+2wkE6ilBhKt2HWPqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IEE7+Fcpsm1LD73FG6QqvI0LCbwPBKdhMZpHtQU3S5y3frbcfkHACDnR3b6L864KU
	 cmaRTJc+FOiB73uwHNfPS4JwiNP4Cs5pNDLj/Gyke5C0D1II8q0wdT80UgiWaq358F
	 9jwYAKXOXGOFzPYe6bn1JYVm5IdL0RnAfxdqkbu6MbqnzguYb2MruxI3GLeB9B9wpI
	 gIDuIayLAf2v9Gf/a9jwg7SpopdCWs7anP3HZTqNT1JOS07FdrYT6mcFxEovAoW/uW
	 g0+v+CZS79BLZirVaPcsyujNZoSAlyKrI7xRBa5kGUhKXGBxuSWj2WKxoYSCJVLBAc
	 PtH837DiZDeMg==
Date: Thu, 17 Jul 2025 14:29:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: rostedt@goodmis.org, lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bhelgaas@google.com,
	tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
	davem@davemloft.net, anil.s.keshavamurthy@intel.com,
	mark.rutland@arm.com, peterz@infradead.org,
	tianruidong@linux.alibaba.com,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <20250717192950.GA2594528@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2687d27d-09ed-429d-9ec7-463c69a3fff7@linux.alibaba.com>

On Thu, Jul 17, 2025 at 02:00:14PM +0800, Shuai Xue wrote:
> 在 2025/7/17 06:25, Bjorn Helgaas 写道:
> ...
> Thank you again for applying this to pci/trace for v6.17. If there’s
> anything more to tweak in the commit log or event text, please let me
> know.

Is there any convention for documenting tracepoints somewhere?  It
looks like there's some doc in Documentation/trace/?  Should we be
adding something there?


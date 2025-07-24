Return-Path: <linux-pci+bounces-32903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6448B113DD
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 00:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BA01CE4462
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 22:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CBE23BF8F;
	Thu, 24 Jul 2025 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeXOFXZR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E7123BCF8;
	Thu, 24 Jul 2025 22:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396081; cv=none; b=kwNNX4ZyU1zxxLteTTet8NcIQeATgiJ1V9mWVh7Yknrw+QCz9xHGm2gLK3/XODsaTUufQ9gi2NdCMT8KjOi46rnb+55fMQh6NYCBlQLzj3bOiSWYzHVjnc0jQv8231C/Up5rFYTHkmut2L3AMZOkrGdMim3sa1+HkmOa9yVLnRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396081; c=relaxed/simple;
	bh=5Mi1MrIvyK+NS2mhD3bJUCU+gR5f3VI3C/LV/hs1Ab8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hXscTOt7UCKd4hDVFAYNwu814NZV4SzxB0JeMw1Rd4su9+fdotxvvd5Q2EjxqRzoiHd2PzOReGuDF8XynQlN6xaK2ey58BiKDCOpsgJ45jMp5GnX25NqdS7S/EbGiS/Xgu/HFco9LgSf0DeyEiocnwZ1lKbLYtNphuvyeIgsANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeXOFXZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751A4C4CEED;
	Thu, 24 Jul 2025 22:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753396080;
	bh=5Mi1MrIvyK+NS2mhD3bJUCU+gR5f3VI3C/LV/hs1Ab8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oeXOFXZR4Cb/UJtrNlULV+ynESujQ3/jeng1dEDxsph6bgl6vODr0H8OZSphlf8lk
	 z8xWw/ZlTUNtOTLerhWYFav5LiuYXE7i6ib3Qgn8yZr3VRtZMGRBBafPQYbgrPt/As
	 OnCBsJiY5WmRqgNKs682/cU23zfE9z6Uds+h0XNNxfQDVtGCs73VDQZqU84r2IBgZ2
	 3vbfzQ/zQJ7B2+U1Fz47X5Sp1//HbpbN1ekBW4wupZBOrM7bvYcKoJGnkxvZXQ2hz2
	 5HWYsYFbhTkeVmLXmSG8nkE0LQ2bZiOSHAvjgViY082nGo+u5ATan/eCI4915whasd
	 whf35ynZJIisA==
Date: Thu, 24 Jul 2025 17:27:59 -0500
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
Message-ID: <20250724222759.GA3065374@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716222533.GA2559636@bhelgaas>

On Wed, Jul 16, 2025 at 05:25:33PM -0500, Bjorn Helgaas wrote:
> ...

> Anyway, I applied this on pci/trace for v6.17.  If there's anything
> you want to tweak in the commit log or event text, we can still do
> that.
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=trace

Given the ongoing discussion, I deferred this series so we don't end
up adding trace events and immediately changing them next cycle.

Bjorn


Return-Path: <linux-pci+bounces-38769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0CBBF2222
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B46B04F8EB1
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 15:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6CF264612;
	Mon, 20 Oct 2025 15:30:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78936217704;
	Mon, 20 Oct 2025 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974256; cv=none; b=nyBdymq6AvjfjjrE36rGIQSCw9fBIB9f0zVD2xfeBQC5+YtRPpOyU2kSZs4ZZxgNDu7BdIMlqbxKyTI/F0i2jxXCjix5u+koWtFd0dTTbb2C/zKAKVcWVw+oTSK8jnz7TAwz9ApOdz7MW2yz/40MvcnVacBEj9VfC+yuKDrb6Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974256; c=relaxed/simple;
	bh=yXu/aPFPd22saUrdFwVxRLUKqp+7tQb6E2xRDecSqYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxCbPgtHVSS8R5iZNuR/e8FIPbGhSNxIPPDThhRYCLOniBfLm5TD65q4vc+zPp8jrTOOSC/pDb//D0C2zXuhC0mf3nHSrUIcRm+BpwR5iLn5HYUv+bBtQNtG2bSBxyyatFEqtQj1+lWbebvmGTmxTvlcN52nJPba4sN49qm/Yks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 79A73C01EE;
	Mon, 20 Oct 2025 15:30:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id C7E372000D;
	Mon, 20 Oct 2025 15:30:39 +0000 (UTC)
Date: Mon, 20 Oct 2025 11:30:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: lukas@wunner.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, helgaas@kernel.org,
 ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
 Jonathan.Cameron@huawei.com, bhelgaas@google.com, tony.luck@intel.com,
 bp@alien8.de, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 oleg@redhat.com, naveen@kernel.org, davem@davemloft.net,
 anil.s.keshavamurthy@intel.com, mark.rutland@arm.com, peterz@infradead.org,
 tianruidong@linux.alibaba.com
Subject: Re: [PATCH v12 1/3] PCI: trace: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <20251020113058.0d245002@gandalf.local.home>
In-Reply-To: <82098b0d-d460-4657-9db6-3721dcc9a162@linux.alibaba.com>
References: <20251014123159.57764-1-xueshuai@linux.alibaba.com>
	<20251014123159.57764-2-xueshuai@linux.alibaba.com>
	<20251014114029.4c59bb1a@gandalf.local.home>
	<b6353617-048a-4e12-a1d4-6d1484619927@linux.alibaba.com>
	<20251015103757.3d6f6cf7@gandalf.local.home>
	<82098b0d-d460-4657-9db6-3721dcc9a162@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: sbz6fc6mr3sdntjm11j69wqbha6b3m5d
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: C7E372000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/aj93rMfMtQSQXPJ8Zy1ywqsFOi0yQcK8=
X-HE-Tag: 1760974239-962848
X-HE-Meta: U2FsdGVkX1/4v5hsBwz1QuFoJ2VSKd8GMWu6NDBGUoTHclOYdzzzBlYj/rkKevvf+yX9rmX7cllLc97CfukDvBlhCgzQYFwJm7lbJrXHd4/eW0mKiQofC7oOmZBt5P1cUtlGTVuGiCqm5GkdH34jH2aV3WxWzEnhFRbuZul2EdzHdX/CcnnhC0o9QX7yAn1Gclpb+9j1/2rvhCPRrIGalG37LQDT4q6YL1KeU9WlrpeWB8xRqxaAr8oYZFwFUcefnmKbWOjFyUg3z6U0PNbogO4S+k+ZlGSrxXLYFUKDvMWQJ55D1MXG+6ZoVLQxSQR5tzCRi3TeYIwVQGDA9xN3+OZ8KsNMGmGFc0oAfkO+6ZzUkOMqIxM+UO58l3BruDnuK4LWLAdopl2i4THE48eVpQ==

On Mon, 20 Oct 2025 09:32:59 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> Got it, will add a comment.
> 
> If you don't have any other concerns with this patch, would you mind
> adding your Reviewed-by tag?

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org> # for trace event

-- Steve


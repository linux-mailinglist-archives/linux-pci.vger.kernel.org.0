Return-Path: <linux-pci+bounces-32915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4E4B116EB
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 05:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2DA1CE19B7
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 03:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C204A143756;
	Fri, 25 Jul 2025 03:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H5gQu3yG"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4262746A;
	Fri, 25 Jul 2025 03:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753413541; cv=none; b=mA8mMjSvFWMzil9Vf31PWMOFVt75XHqdl/xvNhq2hILT7p4khiLEHRHnSe7W8X6aQ2ZeuH6py5xdxlhyJgbeWg24v4wzQXMTu9l8yp49ZE4F21UcnEDU4Ug94n+ntjOeXqIvZ5cBKfXA0hSJKiqvacfDlmv3r2mSN1z+v91tZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753413541; c=relaxed/simple;
	bh=TEqYYAEow7cTJWGY/Qg3LDgEzrccaNSe6l7CjMXk+Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7E8oe19mr/1Ggt+CRIsu/jMhSOPqo5vlCjAoqjmgINCDylL6+ZEemZRtQfW5d2M4mxDPSz64Uitq4xtKuDAyN4OTcNpbMW85RqXY6jI1UwLQGZ/zTD8S+nKdr+Qx/KcD25E4x7klG12WGQ+EzPaNaqM/1gQEmg3UwHRr1D3vRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H5gQu3yG; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753413529; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+cenDW8BUZ7NZFo6zkJ0qfqRUtzCEhoXkgxlwGs3dvY=;
	b=H5gQu3yG+RhEdKJ1x7uJh67xHuMSi5jZOZv+CoZx0m6SEei6e87hTba1sR54Z6/i/EnmSy7bnzMWHLHz2NSjlRGtBxssrgnUNWp2vrS3oXhTbWqWExccUtZVS/h7nM+4xwr+o8chcm7s2y+RBtKvPNzMOF9x8vk706IYzZwRQo0=
Received: from 30.246.181.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WjvNXY._1753413526 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 11:18:47 +0800
Message-ID: <df38380f-c546-4de8-b228-9b1db319545a@linux.alibaba.com>
Date: Fri, 25 Jul 2025 11:18:45 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <lkp@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 lukas@wunner.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
 Jonathan.Cameron@huawei.com, oe-kbuild-all@lists.linux.dev,
 tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20250723033108.61587-3-xueshuai@linux.alibaba.com>
 <202507240322.nJGdyXsy-lkp@intel.com>
 <20250724100659.697b5972@batman.local.home>
 <4b41e3e2-ebac-48c3-b1a3-ce24a5bed475@linux.alibaba.com>
 <20250724225752.42af5c45@gandalf.local.home>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250724225752.42af5c45@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/25 10:57, Steven Rostedt 写道:
> On Fri, 25 Jul 2025 10:31:45 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> I'm leaning toward option 1 (dedicated trace.c file) as it's the
>> cleanest approach and follows the pattern used in other subsystems. Does
>> that sound reasonable to you?
> 
> That's fine, but make sure you have #ifdef CONFIG_FOO around tracepoints
> that are only used when those configs are enabled, otherwise you will get
> warnings.
> 
> Well, if they are exported, then the warnings are suppressed.
> 
>    https://lore.kernel.org/all/20250725025149.726267838@kernel.org/
> 
> -- Steve

Hi Steve,

Got it. Thanks for the important reminder about the CONFIG guards!

Best regards,
Shuai


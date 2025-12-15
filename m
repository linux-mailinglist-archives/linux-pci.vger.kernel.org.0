Return-Path: <linux-pci+bounces-43026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C48AECBC3C2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 03:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83FD63007693
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 02:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21873210F59;
	Mon, 15 Dec 2025 02:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="caVZJRxp"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C4D1A5B8B
	for <linux-pci@vger.kernel.org>; Mon, 15 Dec 2025 02:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765764727; cv=none; b=TiVnK8z8Ggg3M6RrQusByp4SFWwlaKqUCIQH7BjkKJtzL9f9qoSM9+iXDhIDkFSmvGZTPDHKzQc3WYO/RxZWYVT3tz5w0nKLtq76VxiVXrQClbbUYjCgpdVoTr6bT4oUfsV/l294Yv6VkcT/GTgN7L2z1RFEQyVDmdeizCQ6FYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765764727; c=relaxed/simple;
	bh=DGhvYxPOSJxF6A3FHR1/E0HNQrYs5FvkUVSH/vdrUI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhwdCWueZ68wvGw4dFlD8xUW5kbsToMYmnywn4AtVzaCW4Qsbj6BQeIA0FDcbpu5/q0WDTbbphuesUvNQYDOhQdhSgkeZs6H21HhNsK8joVI9sj2Ceuwyrss8iexvMFjAZr1RMrFWDM1gvf7Furk+SNGxaApzGkE0Avjw7H4ltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=caVZJRxp; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765764715; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gZs3K7E83pePuwjkLmGkdO4Rur5tiLjdtu1ZtUQUp7w=;
	b=caVZJRxpI5RdygjtSYiJG5M3ock1pOIUlvjyWwxqc9KiGZCUsRqZPgkaThGmA7oXxw820xlP0AIFPBlxUq16pWYtxlo3mnizS3CfqxKD6kFd5f4hs5R2MG+ihG8q6EtVAfCtNvBxCQxeA/b7oLLG/ZW1x/X2oNAfXsDcTmW/I74=
Received: from 30.178.82.189(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WulLi1F_1765764396 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 15 Dec 2025 10:06:37 +0800
Message-ID: <774fe3d9-b6e1-45b1-8c01-9233459ea1a3@linux.alibaba.com>
Date: Mon, 15 Dec 2025 10:06:36 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v10 1/2] PCI: Introduce named defines for pci rom
To: Bjorn Helgaas <helgaas@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, linux-pci@vger.kernel.org
References: <20251212181308.GA3649201@bhelgaas>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20251212181308.GA3649201@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/13 02:13, Bjorn Helgaas 写道:
> On Fri, Dec 12, 2025 at 05:17:23PM +0200, Ilpo Järvinen wrote:
>> On Fri, 12 Dec 2025, Guixin Liu wrote:
>>
>> The subject still seems to have lowercase "pci rom" :-(.
> We can fix that when applying.  The cadence here is crazy, no need to
> post these so fast:
>
>    Dec 09:  v5
>    Dec 10:  v6
>    Dec 11:  v7, v8
>    Dec 12:  v9, v10
>
> We don't add anything to linux-next until at least -rc1, and I'll be
> on vacation until Dec 22 anyway, so there's no rush.
>
> Bjorn
Thanks, so I don't need to send v11, and thanks for the reviewing by Andy
and Ilpo.

Best Regards,
Guixin Liu


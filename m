Return-Path: <linux-pci+bounces-38835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3198BF4514
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 03:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C363189740E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 01:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5EC226CF1;
	Tue, 21 Oct 2025 01:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sWW7hbsV"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDAF13C3F2;
	Tue, 21 Oct 2025 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011471; cv=none; b=DcqYuE4Z4mA4HB2BbKNkTb+gY87pm0Wi9phO2OmANZNnEoPF0ycDFz5bY7qh+Qq6IZ0rxNZ82gcfT5RkL1iHp2WaviqNdef9NTnJBC5DtoKqocd1aEa38yOdjwTFTs5i+M/xKIsO+Xdb0gpC/Ez/SPfXDS5KfivFHubenasHBPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011471; c=relaxed/simple;
	bh=+9HZJH0JIQ+sa1cUOL4Asj0JAEfRDWZSuWK0R/TQZn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGxMpPolCJT5AoFKbhONVpTHB7YU0dP165SnH1ga4PBZtZ0zOihNl0Okw73LqEhvlnPV97HoPI+0yMJZFp6Ac1hBYj3DZqKaXlvo1hulD3y5qQNl3n6AsuH1yI32pi59OMp/1W2Vz8LrCwS0B425hWv0Gu64isSnEswM19WKv7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sWW7hbsV; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761011462; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dQI2txfhmzidT6hivp5HraunrbQHNklIU7+0FiUu5rM=;
	b=sWW7hbsVwMJ9KiC3lpFPKeYG3b0evoyeXH5p0AGUWpt+Crm0hzCSUlGS9h2Xv6r1vfsGuYCs4i2916wuIUYSkiPtm0BhPMB3ijDahIh0YaEgB911/xkoIqmrNICsrOOL6Kf1UJ9bzs0Q7XsH0g1otDLbQ9QDi9/K7tI7iU0lJm0=
Received: from 30.246.161.241(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wqh4OWF_1761011459 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Oct 2025 09:51:00 +0800
Message-ID: <a253b5aa-e98f-4617-9a1f-1dc30a5ab990@linux.alibaba.com>
Date: Tue, 21 Oct 2025 09:50:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/3] PCI: trace: Add a generic RAS tracepoint for
 hotplug event
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lukas@wunner.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
 Jonathan.Cameron@huawei.com, bhelgaas@google.com, tony.luck@intel.com,
 bp@alien8.de, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 oleg@redhat.com, naveen@kernel.org, davem@davemloft.net,
 anil.s.keshavamurthy@intel.com, mark.rutland@arm.com, peterz@infradead.org,
 tianruidong@linux.alibaba.com
References: <20251014123159.57764-1-xueshuai@linux.alibaba.com>
 <20251014123159.57764-2-xueshuai@linux.alibaba.com>
 <20251014114029.4c59bb1a@gandalf.local.home>
 <b6353617-048a-4e12-a1d4-6d1484619927@linux.alibaba.com>
 <20251015103757.3d6f6cf7@gandalf.local.home>
 <82098b0d-d460-4657-9db6-3721dcc9a162@linux.alibaba.com>
 <20251020113058.0d245002@gandalf.local.home>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20251020113058.0d245002@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/20 23:30, Steven Rostedt 写道:
> On Mon, 20 Oct 2025 09:32:59 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> Got it, will add a comment.
>>
>> If you don't have any other concerns with this patch, would you mind
>> adding your Reviewed-by tag?
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org> # for trace event
> 
> -- Steve

Thanks.
Shuai


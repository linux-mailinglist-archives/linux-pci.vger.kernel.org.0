Return-Path: <linux-pci+bounces-32815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43107B0F4E0
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 16:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699DA1892F27
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 14:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2317D2F2348;
	Wed, 23 Jul 2025 14:06:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ACF78F3E;
	Wed, 23 Jul 2025 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279574; cv=none; b=rm5wO1BqgqDVYzwYLpm9LK8qVM14OVILDwH1oO5rEDIAnA5ymG8JVLscpD+QeyoNvtTBkpFahnLSJhIAyTqF24OZ0uO5X9qYFusA8EIGMCAEVafkEcxlbCyaoFvXuO9lB72tp7hIWV8ySlhl1VkSwCR2oHvWAjIvERrH1alo6PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279574; c=relaxed/simple;
	bh=lMxJ452v0orPlmOr+epyAVHrDfvjemEaQSUKSAWFW5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KL7SGWoyPD/Px5crPXlR4z2falztOU35ksK15DYHkkRIfUo8BwiSInQXccVk8HKudp7eT7GYMiFUt87mKyf+X7v8G/NQE3sc7l0jQa3hc+hO9mul7YykU/TE33ZbOYy/bRE+1BZ68hD50dyjrC+Ftj571MrUd1cmKtEbVxs43zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 7C56F1606A4;
	Wed, 23 Jul 2025 14:06:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id BCD5E2D;
	Wed, 23 Jul 2025 14:05:58 +0000 (UTC)
Date: Wed, 23 Jul 2025 10:05:59 -0400
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
Subject: Re: [PATCH v9 2/2] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
Message-ID: <20250723100559.7f0adb3c@batman.local.home>
In-Reply-To: <20250723033108.61587-3-xueshuai@linux.alibaba.com>
References: <20250723033108.61587-1-xueshuai@linux.alibaba.com>
	<20250723033108.61587-3-xueshuai@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kfh95roe4azn51jwbc9w8snmy97e6oiu
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: BCD5E2D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19uu5kwrnovz3Zkv5N+cwHtWAyPjoGFzaM=
X-HE-Tag: 1753279558-65806
X-HE-Meta: U2FsdGVkX18EcBzxU5d2jMMvSMTDBFTAbWnieQrV6k8YfBJ6MEAHk+B+CAbikFXBJnqLIQgSVt445rKrwaBBa6Auvns6OK++ZmErCE8sU0Ez50ansF+A7gQWzAunWcOuyXUpE0S5IXv00CqWQvSwxPxwA1YuvU3QmvEzJd+FTgggGliPepeJs5OylpcMMbnJjaIdkdc1rHmyv7I0NFYDYCLcMJjJwWO1xF3gXEeUqxO35xy5UuQL06DMgxSusYQOx7opywjLHRjhmiCQlmu9xF8Vp4xoroRkSJ6ZtHFCGISfrPnqpLcwGY9Hs1QHCVopk5puHRuaJqXpEi2u8yVgmiBaXTZAx/Ed

On Wed, 23 Jul 2025 11:31:08 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> +	TP_printk("%s type:%d, reason:%d, cur_bus_speed:%s, max_bus_speed:%s, width:%u, flit_mode:%u, status:%s\n",
> +		__get_str(port_name),
> +		__entry->type,
> +		__entry->reason,
> +		pci_speed_string(__entry->cur_bus_speed),
> +		pci_speed_string(__entry->max_bus_speed),

Hmm, I guess pci_speed_string() should be added to libtraceveent so
that perf and trace-cmd parses it correctly. I guess rasdaemon would
want that too (which also uses libtraceevent).

-- Steve


> +		__entry->width,
> +		__entry->flit_mode,
> +		__print_flags((unsigned long)__entry->link_status, "|",
> +				LNKSTA_FLAGS)
> +	)
> +);


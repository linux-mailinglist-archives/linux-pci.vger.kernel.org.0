Return-Path: <linux-pci+bounces-16678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B899C78DE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 17:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1AF1F2587D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 16:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668B21DE8A2;
	Wed, 13 Nov 2024 16:27:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E7F7C0BE;
	Wed, 13 Nov 2024 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515276; cv=none; b=SJoaDnEjuSnvC3fGl3kDfAxqud2Ddj0Bi0wJXUBmThmCzBpdfoEQP6nFw9lZv8WkBPAwyf1GJh+zxW4x/A0w9NjWs3m8ks0czpgmv4VcXABFiUnRIOYCq3x1hhv4N9vNvfz4vKLYYetFjI78cEWEOa9SiyXYUJpfGAAJn18Ys2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515276; c=relaxed/simple;
	bh=sYwbMKY5opAsCzogcj5xjEOlKi9M9iZtDQwq3bcGCcU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a+JOq4hW1gWCtdI2GM3XK6GfqbPdIixT0Ig3l9mbMBWYYlQAuboMgCN6FpOw6zMuQ+Sy79q9w2PbAl9tisy58olxuRjub1GgN2hponYNELYAnvwB8lvAngYp6NPPwc/l3XfIQOcn6LMnslrpVI1KJa2FRnanjtd2j22+cKQDpBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 5DDE22800B4BD;
	Wed, 13 Nov 2024 17:27:44 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 476EA3A0809; Wed, 13 Nov 2024 17:27:44 +0100 (CET)
Date: Wed, 13 Nov 2024 17:27:44 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, bhelgaas@google.com,
	tony.luck@intel.com, bp@alien8.de
Subject: Re: [PATCH v2 1/2] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <ZzTTgOoCSqfC4cVR@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112115852.52980-3-xueshuai@linux.alibaba.com>
 <20241112115852.52980-2-xueshuai@linux.alibaba.com>

On Tue, Nov 12, 2024 at 07:58:51PM +0800, Shuai Xue wrote:
> Hotplug events are critical indicators for analyzing hardware health,
> particularly in AI supercomputers where surprise link downs can
> significantly impact system performance and reliability. The failure
> characterization analysis illustrates the significance of failures
> caused by the Infiniband link errors. Meta observes that 2% in a machine
> learning cluster and 6% in a vision application cluster of Infiniband
> failures co-occur with GPU failures, such as falling off the bus, which
> may indicate a correlation with PCIe.[1]
> 
> Add a generic RAS tracepoint for hotplug event to help healthy check.

It would be good if you could mention in the commit message that
you intend to use rasdaemon for monitoring these tracepoints
and that you're hence adding the enum to a uapi header.
So that if someone wonders later on why you chose a uapi header,
they will find breadcrumbs in the commit message.

I think both patches can be squashed into one.

I'm not an expert on tracepoints, so when respinning, perhaps you
could cc linux-trace-kernel@vger.kernel.org and maybe also tracing
maintainers so that subject matter experts can look the patch over
and ack it.


> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM hotplug

Maybe "pci_hotplug" to differentiate this from, say, cpu hotplug?


> +#define PCI_HP_TRANS_STATE					\
> +	EM(PCI_HOTPLUG_LINK_UP,			"Link Up")	\
> +	EM(PCI_HOTPLUG_LINK_DOWN,		"Link Down")	\
> +	EM(PCI_HOTPLUG_CARD_PRESENT,		"Card present")	\
> +	EMe(PCI_HOTPLUG_CARD_NO_PRESENT,	"Card not present")

PCI_HOTPLUG_CARD_NOT_PRESENT would be neater I think.
                   ^

> +PCI_HP_TRANS_STATE

Not sure what "trans state" stands for, maybe "state transition"?
What if we add tracepoints going forward which aren't for state
transitions but other types of events, such as "Power Failure"?
Perhaps something more generic such as "PCI_HOTPLUG_EVENT" would
be more apt?


> +enum pci_hotplug_trans_type {
> +	PCI_HOTPLUG_LINK_UP,
> +	PCI_HOTPLUG_LINK_DOWN,
> +	PCI_HOTPLUG_CARD_PRESENT,
> +	PCI_HOTPLUG_CARD_NO_PRESENT,
> +};

I note that this is called "pci_hotplug_trans_type", perhaps for
consistency use "pci_hotplug_trans_state" as everywhere else
(or whatever you choose to substitute the name for, see above).

Other than these cosmetic things, the patches LGTM.
Again, my knowledge on tracepoints is superficial, but broadly
it looks reasonable.

Thanks,

Lukas


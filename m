Return-Path: <linux-pci+bounces-43975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AA1CF11CB
	for <lists+linux-pci@lfdr.de>; Sun, 04 Jan 2026 17:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00BC63008EBF
	for <lists+linux-pci@lfdr.de>; Sun,  4 Jan 2026 16:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5C419D07A;
	Sun,  4 Jan 2026 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fx1kBwZG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1A81FD4;
	Sun,  4 Jan 2026 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767542516; cv=none; b=aLVyYPMK0aDljpm5sjf1Y17cOW76r0jc98H07YgXNQAmPetTbVfB43zWQVUziVlZp4Eg/A6CWH4gLIyNVvLYFg7pomGOEdzprdG5ZNKMZLXgh571fkeOKBIhFE3ufM+sUXqkIdODiMqIipUMxmupOcbRz9VGgPQ92PoBRQ/PGCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767542516; c=relaxed/simple;
	bh=llU+eA7rYLtn1wOGYwKsFZKSdtLGEWYqaLgaLqZu6nQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mYEwELVmp6j7ePF6Wwvf5yvmpudEzsgjut/RwggH+QHlhL1UPuyXz1MWelx45sLDuqRDJmqMRNUDgPE+t9Lgn8BtRtTQJp7cBek7Q/gc8ni6B779ZCnIOPBTlxDy1WC59b45vmKKvnUBrTZ8SCEj17agUNlJZ2V9s664TZx/dJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fx1kBwZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D475CC4CEF7;
	Sun,  4 Jan 2026 16:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767542515;
	bh=llU+eA7rYLtn1wOGYwKsFZKSdtLGEWYqaLgaLqZu6nQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=fx1kBwZGEA9NUHvoxp+lTYWrLwrGU0rvKrCkXnOoUvgseRFKvqSJ8dylO8QlQsDuq
	 HU7Xks3Kvz1arWjAUH1qB7a1+ct4hDTiGOqbFugl0YwsEVHWOBvfd/FGlDdJ40YxSY
	 IYLlStEYU07AyGjS38gxkMEAosqeTUfgGs0Yllapz0Foq+Qp3qYx4cJgTUZrIq0Puk
	 DFwiAuSK6f5DDC8pGzac73ATfhrT7s74a/hslCKNEg9E+KjOJ0UyrOTThcc4Ayu4Fl
	 FzWrTLGjcB9qjP4fojP6YiJEN1z3rR5lR9kSDSIbmq/hbIesASY5xIwC2CF4U0/kZH
	 DBny8g+vWF9LQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 04 Jan 2026 17:01:50 +0100
Message-Id: <DFFXIZR1AGTV.2WZ1G2JAU0HFQ@kernel.org>
Subject: Re: [PATCH] PCI: Avoid work_on_cpu() in async probe workers
Cc: "Jinhui Guo" <guojinhui.liam@bytedance.com>,
 <alexander.h.duyck@linux.intel.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Bart Van Assche" <bvanassche@acm.org>, "Dan Williams"
 <dan.j.williams@intel.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <stable@vger.kernel.org>, "Tejun Heo"
 <tj@kernel.org>, "Alexander Duyck" <alexanderduyck@fb.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>
To: "Bjorn Helgaas" <helgaas@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251231075105.1368-1-guojinhui.liam@bytedance.com>
 <20251231165503.GA159243@bhelgaas>
In-Reply-To: <20251231165503.GA159243@bhelgaas>

On Wed Dec 31, 2025 at 5:55 PM CET, Bjorn Helgaas wrote:
> On Wed, Dec 31, 2025 at 03:51:05PM +0800, Jinhui Guo wrote:
>> Hi, Bjorn
>>=20
>> Thank you for your time and kind reply.
>>=20
>> As I see it, two scenarios should be borne in mind:
>>=20
>> 1. Driver allowed to probe asynchronously
>>    The driver core schedules async workers via async_schedule_dev(),
>>    so pci_call_probe() needs no extra queue_work_node().
>>=20
>> 2. Driver not allowed to probe asynchronously
>>    The driver core (__driver_attach() or __device_attach()) calls
>>    pci_call_probe() directly, without any async worker from
>>    async_schedule_dev(). NUMA-node awareness in pci_call_probe()
>>    is therefore still required.
>
> Good point, we need the NUMA awareness in both sync and async probe
> paths.
>
> But node affinity is orthogonal to the sync/async question, so it
> seems weird to deal with affinity in two separate places.

In general I agree, but implementation wise it might make a difference:

In the async path we ultimately use queue_work_node(), which may fall back =
to
default queue_work() behavior or explicitly picks the current CPU to queue =
work,
if we are on the corresponding NUMA node already.

In the sync path however - if we want to do something about NUMA affinity -=
 we
probably want to queue work as well and wait for completion, but in the fal=
lback
case always execute the code ourselves, i.e. do not queue any work at all.

> It also
> seems sub-optimal to have node affinity in the driver core async path
> but not the synchronous probe path.
>
> Maybe driver_probe_device() should do something about NUMA affinity?

driver_probe_device() might not be the best place, as it is the helper exec=
uted
from within the async path (work queue) and sync path (unless you have some=
thing
else in mind than what I mentioned above).

I think __device_attach() and __driver_attach() - probably through a common
helper - should handle NUMA affinity instead.


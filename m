Return-Path: <linux-pci+bounces-44265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7B6D026E8
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 12:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED5E4301F279
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 11:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2743C3644BE;
	Thu,  8 Jan 2026 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UA/Hw8uO"
X-Original-To: linux-pci@vger.kernel.org
Received: from sg-1-103.ptr.blmpb.com (sg-1-103.ptr.blmpb.com [118.26.132.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39F364EAB
	for <linux-pci@vger.kernel.org>; Thu,  8 Jan 2026 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767860932; cv=none; b=AGQhAi8p9Y4RdgKOG4K6cG81e8EXyZhF/NAM+YtSW58mSWoQW5RFsJ0bhVY5cbDOzpABE5LiZUyCi32M4hGj/QOz81eIROyCEh2CXO0NTOBX9vNBV78269qFcBUphvIFA8tUnTrCeVUZcAZNWIErmVTru/ICyUBdYjTQPXVidks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767860932; c=relaxed/simple;
	bh=mwnJrZWPXIaLG7KaOAcx9poRq9UaSU4JRhalg1pUm6c=;
	h=In-Reply-To:Content-Type:To:From:Date:Cc:Subject:Message-Id:
	 Mime-Version:References; b=jPFKcr3I28WeMciMVOxLtHJiu3UOrcQvoUtMf0ddgkIS/6XYmSa3/BWwH1iB0rRi9mwzWkiNXtHKiObARz0L4ktgEh1pCuV+/5oYFmu64MB0mtuP0yT1nLp6nbTdIxRhrcysG8Pnxy2zLOU+HhZy79HKn3+h+oN4MtUDRhMecAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UA/Hw8uO; arc=none smtp.client-ip=118.26.132.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1767860913; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=0oFlzEd1qG/Ys1FkKORrFGPUh3+n4nltMfCmkuN0TwI=;
 b=UA/Hw8uOdUxy7H9LtKJfC2pPFovS81K46NuxVCW7uTl+Zma5ryMbAVbONUThkMoFcn5Txb
 0yXuz29rVpmN84+obdivZ2vuFFbfWlYQYAOWN783Zz/DvazIdd0Unmikbq2kJ64P6mDin2
 kbpVHzYxn8QqqlXXEMjUN37R/+YB4OBWPaCno8Z9ElPAg1wRo8r19FrM+gtlx/6etHQCzq
 lR9X7CMibGcOkRVxjWCPRFX5wPLGnHpFhxoMqA6WpZeQddcoUBa3KMt1b1KYKMfz3cSG40
 Zjqkx9PlM+HvohbjkfE0f7g4/7XHntzdAAQcWf3FmvlNZOv2CJ+bTalnLXAcKA==
In-Reply-To: <DFIKE4Z23Q0O.2ZC7FR40XO8SR@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.17.1
To: <dakr@kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Date: Thu,  8 Jan 2026 16:28:15 +0800
Cc: <alexander.h.duyck@linux.intel.com>, <alexanderduyck@fb.com>, 
	<bhelgaas@google.com>, <bvanassche@acm.org>, <dan.j.williams@intel.com>, 
	<gregkh@linuxfoundation.org>, <guojinhui.liam@bytedance.com>, 
	<helgaas@kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-pci@vger.kernel.org>, <rafael@kernel.org>, <tj@kernel.org>
Subject: Re: [PATCH 2/3] driver core: Add NUMA-node awareness to the synchronous probe path
Message-Id: <20260108082815.1876-1-guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: quoted-printable
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2695f6aaf+b3ce36+vger.kernel.org+guojinhui.liam@bytedance.com>
References: <DFIKE4Z23Q0O.2ZC7FR40XO8SR@kernel.org>

On Wed Jan 07, 2026 at 19:22:15 +0100, Danilo Krummrich wrote:
> On Wed Jan 7, 2026 at 6:55 PM CET, Jinhui Guo wrote:
> > + * __exec_on_numa_node - Execute a function on a specific NUMA node sy=
nchronously
> > + * @node: Target NUMA node ID
> > + * @func: The wrapper function to execute
> > + * @arg1: First argument (void *)
> > + * @arg2: Second argument (void *)
> > + *
> > + * Returns the result of the function execution, or -ENODEV if initial=
ization fails.
> > + * If the node is invalid or offline, it falls back to local execution=
.
> > + */
> > +static int __exec_on_numa_node(int node, numa_func_t func, void *arg1,=
 void *arg2)
> > +{
> > +	struct numa_work_ctx ctx;
> > +
> > +	/* Fallback to local execution if the node is invalid or offline */
> > +	if (node < 0 || node >=3D MAX_NUMNODES || !node_online(node))
> > +		return func(arg1, arg2);
>=20
> Just a quick drive-by comment (I=E2=80=99ll go through it more thoroughly=
 later).
>=20
> What about the case where we are already on the requested node?
>=20
> Also, we should probably set the corresponding CPU affinity for the time =
we are
> executing func() to prevent migration.

Hi Danilo,

Thank you for your time and helpful comments.

Relying on queue_work_node() for node affinity is safer, even if the thread
is already on the target CPU.

Checking the current CPU and then setting affinity ourselves would require
handling CPU-hotplug and isolated CPUs=E2=80=94corner cases that become com=
plex
quickly.

The PCI driver tried this years ago and ran into numerous problems; delegat=
ing
the decision to queue_work_node() avoids repeating that history.

- Commit d42c69972b85 ("[PATCH] PCI: Run PCI driver initialization on local=
 node")
  first added NUMA awareness with set_cpus_allowed_ptr().
- Commit 1ddd45f8d76f ("PCI: Use cpu_hotplug_disable() instead of get_onlin=
e_cpus()")
  handled CPU-hotplug.
- Commits 69a18b18699b ("PCI: Restrict probe functions to housekeeping CPUs=
") and
  9d42ea0d6984 ("pci: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch"=
) dealt
  with isolated CPUs.

I considered setting CPU affinity, but the performance gain is minimal:

1. Driver probing happens mainly at boot, when load is light, so queuing a =
worker
   incurs little delay.
2. With many devices they are usually spread across nodes, so workers are n=
ot
   stalled long within any NUMA node.
3. Even after pinning, tasks can still be migrated by load balancing within=
 the
   NUMA node, so the reduction in context switches versus using queue_work_=
node()
   alone is negligible.

Test data [1] shows that queue_work_node() has negligible impact on synchro=
nous probe time.

[1] https://lore.kernel.org/all/20260107175548.1792-1-guojinhui.liam@byteda=
nce.com/

If you have any other concerns, please let me know.

Best Regards,
Jinhui


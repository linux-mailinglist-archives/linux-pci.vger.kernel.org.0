Return-Path: <linux-pci+bounces-43851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AFACE9EE7
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 15:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28B1E3021E60
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 14:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727B826561D;
	Tue, 30 Dec 2025 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gquT33qw"
X-Original-To: linux-pci@vger.kernel.org
Received: from sg-1-104.ptr.blmpb.com (sg-1-104.ptr.blmpb.com [118.26.132.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5379B2494F0
	for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767104899; cv=none; b=FHseliTAB979tMhxnHW9cmmXFTK6WGG7SdI2JodrGzF2vdef6fPvESz+VWobIOe7NXfOBIzlQxeFsiqE6akHNNiuLJKH9nwCLLOND/wNBeXh8nGUH2xwS4h7XWBnIHhckoFj54lcVDCo4JvmhFadQF0wWRIxJC84HNX4SsH8ugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767104899; c=relaxed/simple;
	bh=nFpyggCAJPDq5oXUs3Bae+IdegNospRc1h8mMGujJYU=;
	h=Message-Id:Mime-Version:Cc:Date:Subject:Content-Type:References:
	 To:In-Reply-To:From; b=S6/fnnURlBltwuEAySSM6X6kdAs5g3KjHt3oShaeirqNh/RwxJqML/EO3ledzC+H4DV6Comp5RTGAmdAuFCg8OfYcFppzLIG8MjIkjlEDrQAxJLs/2iTeWJitfVv1lKzneQYXcIDXWX274PGM3pPnSONfA7BFzMWQku4r4JJpcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gquT33qw; arc=none smtp.client-ip=118.26.132.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1767104877; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=znWFlGmHmidmc0zgKcG15wJ0w7PYxFCIv3V2NH/gn1k=;
 b=gquT33qwb8Ns83p2y1XG7NPONzRE9HnJxL4NEyBaggTERWz09ctzN27fRqDsgfpecvIMbf
 H9k781JBC5JSojxiwujFwoFIm/qYoiuOynmGHkaQpwtt9utduBnf/Ni0hT69qb5uxn1yli
 kyY+P/Qwu8I/dCAF80yYQHQUlIixAOpIQh1cv6xAe1Crr3b0U48I+kVVeFaNvsPoLpM3SR
 Z6Lo3h0TloiW06qgPvJdItae3vK6DG3myX9nrFxEb64i05Ge5uxSC+7MSw6JlkR4+P1kd1
 ecp2bQfqvQqj89gmPM4sccgwGgivC2oxZ6rkjjcJmDcXeXw4W8izW7ZOnDctvg==
Message-Id: <20251230142736.1168-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.17.1
Cc: <alexander.h.duyck@linux.intel.com>, <bhelgaas@google.com>, 
	<bvanassche@acm.org>, <dan.j.williams@intel.com>, 
	<gregkh@linuxfoundation.org>, <guojinhui.liam@bytedance.com>, 
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, 
	<stable@vger.kernel.org>
Date: Tue, 30 Dec 2025 22:27:36 +0800
X-Lms-Return-Path: <lba+26953e16b+3cc537+vger.kernel.org+guojinhui.liam@bytedance.com>
Subject: Re: [PATCH] PCI: Avoid work_on_cpu() in async probe workers
Content-Type: text/plain; charset=UTF-8
References: <aVLDuUAHw0egvFfr@slm.duckdns.org>
To: <tj@kernel.org>
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
In-Reply-To: <aVLDuUAHw0egvFfr@slm.duckdns.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 08:08:57AM -1000, Tejun Heo wrote:
> On Sat, Dec 27, 2025 at 07:33:26PM +0800, Jinhui Guo wrote:
> > To fix the issue, pci_call_probe() must not call work_on_cpu() when it =
is
> > already running inside an unbounded asynchronous worker. Because a driv=
er
> > can be probed asynchronously either by probe_type or by the kernel comm=
and
> > line, we cannot rely on PROBE_PREFER_ASYNCHRONOUS alone. Instead, we te=
st
> > the PF_WQ_WORKER flag in current->flags; if it is set, pci_call_probe()=
 is
> > executing within an unbounded workqueue worker and should skip the extr=
a
> > work_on_cpu() call.
>=20
> Why not just use queue_work_on() on system_dfl_wq (or any other unbound
> workqueue)? Those are soft-affine to cache domain but can overflow to oth=
er
> CPUs?

Hi, tejun,

Thank you for your time and helpful suggestions.
I had considered replacing work_on_cpu() with queue_work_on(system_dfl_wq) =
+
flush_work(), but that would be a refactor rather than a fix for the specif=
ic
problem we hit.

Let me restate the issue:

1. With PROBE_PREFER_ASYNCHRONOUS enabled, the driver core queues work on
   async_wq to speed up driver probe.
2. The PCI core then calls work_on_cpu() to tie the probe thread to the PCI
   device=E2=80=99s NUMA node, but it always picks the same CPU for every d=
evice on
   that node, forcing the PCI probes to run serially.

Therefore I test current->flags & PF_WQ_WORKER to detect that we are alread=
y
inside an async_wq worker and skip the extra nested work queue.

I agree with your point=E2=80=94using queue_work_on(system_dfl_wq) + flush_=
work()
would be cleaner and would let different vendors=E2=80=99 drivers probe in =
parallel
instead of fighting over the same CPU. I=E2=80=99ve prepared and tested ano=
ther patch,
but I=E2=80=99m still unsure it=E2=80=99s the better approach; any further =
suggestions would
be greatly appreciated.

Test results for that patch:
  nvme 0000:01:00.0: CPU: 2, COMM: kworker/u1025:3, probe cost: 34904955 ns
  nvme 0000:02:00.0: CPU: 134, COMM: kworker/u1025:1, probe cost: 34774235 =
ns
  nvme 0000:03:00.0: CPU: 1, COMM: kworker/u1025:4, probe cost: 34573054 ns

Key changes in the patch:

1. Keep the current->flags & PF_WQ_WORKER test to avoid nested workers.
2. Replace work_on_cpu() with queue_work_node(system_dfl_wq) + flush_work()
   to enable parallel probing when PROBE_PREFER_ASYNCHRONOUS is disabled.
3. Remove all cpumask operations.
4. Drop cpu_hotplug_disable() since both cpumask manipulation and work_on_c=
pu()
   are gone.

The patch is shown below.

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 7c2d9d5962586..e66a67c48f28d 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -347,10 +347,24 @@ static bool pci_physfn_is_probed(struct pci_dev *dev)
 #endif
 }

+struct pci_probe_work {
+    struct work_struct work;
+    struct drv_dev_and_id ddi;
+    int result;
+};
+
+static void pci_probe_work_func(struct work_struct *work)
+{
+       struct pci_probe_work *pw =3D container_of(work, struct pci_probe_w=
ork, work);
+
+       pw->result =3D local_pci_probe(&pw->ddi);
+}
+
 static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
                          const struct pci_device_id *id)
 {
        int error, node, cpu;
+       struct pci_probe_work pw;
        struct drv_dev_and_id ddi =3D { drv, dev, id };

        /*
@@ -361,38 +375,25 @@ static int pci_call_probe(struct pci_driver *drv, str=
uct pci_dev *dev,
        node =3D dev_to_node(&dev->dev);
        dev->is_probed =3D 1;

-       cpu_hotplug_disable();
-
        /*
         * Prevent nesting work_on_cpu() for the case where a Virtual Funct=
ion
         * device is probed from work_on_cpu() of the Physical device.
         */
        if (node < 0 || node >=3D MAX_NUMNODES || !node_online(node) ||
-           pci_physfn_is_probed(dev)) {
-               cpu =3D nr_cpu_ids;
-       } else {
-               cpumask_var_t wq_domain_mask;
-
-               if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
-                       error =3D -ENOMEM;
-                       goto out;
-               }
-               cpumask_and(wq_domain_mask,
-                           housekeeping_cpumask(HK_TYPE_WQ),
-                           housekeeping_cpumask(HK_TYPE_DOMAIN));
-
-               cpu =3D cpumask_any_and(cpumask_of_node(node),
-                                     wq_domain_mask);
-               free_cpumask_var(wq_domain_mask);
+           pci_physfn_is_probed(dev) || (current->flags & PF_WQ_WORKER)) {
+               error =3D local_pci_probe(&ddi);
+               goto out;
        }

-       if (cpu < nr_cpu_ids)
-               error =3D work_on_cpu(cpu, local_pci_probe, &ddi);
-       else
-               error =3D local_pci_probe(&ddi);
+       INIT_WORK_ONSTACK(&pw.work, pci_probe_work_func);
+       pw.ddi =3D ddi;
+       queue_work_node(node, system_dfl_wq, &pw.work);
+       flush_work(&pw.work);
+       error =3D pw.result;
+       destroy_work_on_stack(&pw.work);
+
 out:
        dev->is_probed =3D 0;
-       cpu_hotplug_enable();
        return error;
 }


Best Regards,
Jinhui


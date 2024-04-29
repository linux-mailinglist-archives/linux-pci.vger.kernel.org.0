Return-Path: <linux-pci+bounces-6751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D391B8B4FF0
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 05:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2CC1F20F76
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 03:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0A58BEE;
	Mon, 29 Apr 2024 03:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NFRyUeZU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB738479
	for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2024 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714362102; cv=none; b=dNiFoO95tON/2kiQ5fVGkQ7LeAhQ2BfZgeRjAeguZG9u2Py6u2/adNx+0mz8JDPhfooiHZheC0+eABg6aKGrFIn0cpETprYJqsB6Ild57Ds92LB1YlF3tbdjcFY1hnwpBZ5Jf0V5fRHkNNmtofBvRHCHzwtIj+o7dl4JOIFL4JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714362102; c=relaxed/simple;
	bh=XcC2SQ+hyRPVOuSGKyLwXqtjOb9L2X26n5bIqzPSuos=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pYsp5/+/kY8O21NLs0NcUjP9p6qTMBW/vKGVArIknk86CCz7cPQkQLJGY+QeHS8QkG6zVUEG9dVIKQHxtFK2AsfoC4RXHpD3Q45hOkR7sjfzUOh6QKD3jWqNt9PyusDnaPcXYUIRmODocHHtcMhQDJDM7BvoH1J7vVnXRyUBEwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NFRyUeZU; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-41681022d82so17656035e9.1
        for <linux-pci@vger.kernel.org>; Sun, 28 Apr 2024 20:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714362099; x=1714966899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9jmX3QxBB0ptLSuKTUjjV92gcfpZ8FtQn0+7RhIfec=;
        b=NFRyUeZUldSCicbDBMoR+9dqD4t38VnXs6qOTsc2UDom4nzzetWwbI0T70jYQWh+nS
         8UR0mCx9SnMoZzg01hbpY55IHl0Gim2v8k+bk567wzzOP1dt+6auMtNd9aMjMCy4moxr
         8dnthUQg16ZHfsXSeeFG1wkC6zjztRh3rIlEOFjNdNWa/Z+PBUMDq1gFB+LzvXipRDWr
         BRRyEXHbSLmjFrEKB3p4s9IIH4tFhKAJSuBE6ugTG7QAL324lzeFuyRfJ12zngFfBGY4
         /+eVHh5WrgTKKraP2Fj4+w7bThTTE+6HGwvdJ8eY3CNdef5HOe1sQVR/3nINKH+Xnfyf
         FF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714362099; x=1714966899;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9jmX3QxBB0ptLSuKTUjjV92gcfpZ8FtQn0+7RhIfec=;
        b=g8EHMAN3a74WLFWH9EMLnad0Z1k7I3jvB5DE2LyRma4e94YfAgg0zUivnPM79dNuEw
         R/sctLtPinaYqDbSlmKEzTUYlN+GqdmUlpwgwwl4j/iMLEKk9c0qswU7vxR4oKD0Tgic
         mdSQ/LsML8cOxvJIKda6jF1z9sMoGzM+4hz4KA01eLkz1iBZE61s0K+cFN44eSh17b8K
         GfIy5TJhDHadePul2cD50kMFJTb9f52PxvwcwVsNYz+upAVXNI6C4s0w12dndQ2RjsyS
         xN4v15PrVw/expj9pAaF0s11v2c46Qg3E+e2hzk8MhPedQeD/QqmTqHhXQizuZenyBD9
         y6RA==
X-Forwarded-Encrypted: i=1; AJvYcCVtY/UU3LT0VCFDjyg4EBCBABTDDBbJqomRrjEoqI/lwi9IKkGSDzfsOebMhum7wdv36zYjTDpKoyRbEAjEn53bz2R3+9Z6ftXu
X-Gm-Message-State: AOJu0YyJwPxP4e7/S7IUHuZNGgLhyT4DcYO+GvqwOEnaXdoTIl1JLrvC
	1JxAwwcoL9eqSFfKKQ9bUgSuIj63LxjUEwoAqPaZsP2ckOMWAbF+AYP7GLDUJv0+x4Z32hbEie9
	PFBKl3fMTIA==
X-Google-Smtp-Source: AGHT+IEfXkUgHUjB1E8RP2G4K8gsuLdAN8GK0mvfTfa0cd18WhB6TgcyB7zjI8UPl5fJo6iEBvE4V92w+u23RA==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a7b:cc0d:0:b0:416:3e78:2a2b with SMTP id
 f13-20020a7bcc0d000000b004163e782a2bmr41613wmh.6.1714362098699; Sun, 28 Apr
 2024 20:41:38 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:41:12 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429034112.140594-1-smostafa@google.com>
Subject: [PATCH] PCI/MSI: Fix UAF in msi_capability_init
From: Mostafa Saleh <smostafa@google.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com, tglx@linutronix.de, kernel-team@android.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

While running Android15-6.6 and hacking on latest Qemu, I observed
the following with KFENCE:

[   10.761992][   T81] pcieport 0000:00:03.0: Adding to iommu group 0
[   10.782536][   T81] pcieport 0000:00:03.0: enabling device (0000 -> 0003=
)
[   10.814259][   T81] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   10.816534][   T81] BUG: KFENCE: use-after-free read in __pci_enable_msi=
_range+0x2c0/0x488
[   10.816534][   T81]
[   10.820189][   T81] Use-after-free read at 0x0000000024629571 (in kfence=
-#12):
[   10.822652][   T81]  __pci_enable_msi_range+0x2c0/0x488
[   10.824304][   T81]  pci_alloc_irq_vectors_affinity+0xec/0x14c
[   10.826129][   T81]  pci_alloc_irq_vectors+0x18/0x28
[   10.827606][   T81]  pcie_portdrv_probe+0x1e0/0x608
[   10.828979][   T81]  pci_device_probe+0xa8/0x174
[   10.830316][   T81]  really_probe+0x150/0x2b8
[   10.831717][   T81]  __driver_probe_device+0x7c/0x130
[   10.833368][   T81]  driver_probe_device+0x40/0x118
[   10.834899][   T81]  __device_attach_driver+0xc4/0x108
[   10.836464][   T81]  bus_for_each_drv+0x8c/0xf0
[   10.837915][   T81]  __device_attach+0xa4/0x198
[   10.839260][   T81]  device_initial_probe+0x18/0x28
[   10.840684][   T81]  bus_probe_device+0xb0/0xb4
[   10.842174][   T81]  deferred_probe_work_func+0xac/0xf8
[   10.843760][   T81]  process_one_work+0x18c/0x414
[   10.845129][   T81]  worker_thread+0x41c/0x53c
[   10.846611][   T81]  kthread+0x114/0x118
[   10.847841][   T81]  ret_from_fork+0x10/0x20
[   10.849298][   T81]
[   10.850435][   T81] kfence-#12: 0x0000000008614900-0x00000000e06c228d, s=
ize=3D104, cache=3Dkmalloc-128
[   10.850435][   T81]
[   10.853455][   T81] allocated by task 81 on cpu 7 at 10.808142s:
[   10.856329][   T81]  __kmem_cache_alloc_node+0x1f0/0x2bc
[   10.857988][   T81]  kmalloc_trace+0x44/0x138
[   10.859299][   T81]  msi_alloc_desc+0x3c/0x9c
[   10.860582][   T81]  msi_domain_insert_msi_desc+0x30/0x78
[   10.862058][   T81]  msi_setup_msi_desc+0x13c/0x184
[   10.862942][   T81]  __pci_enable_msi_range+0x258/0x488
[   10.863847][   T81]  pci_alloc_irq_vectors_affinity+0xec/0x14c
[   10.864821][   T81]  pci_alloc_irq_vectors+0x18/0x28
[   10.866011][   T81]  pcie_portdrv_probe+0x1e0/0x608
[   10.867047][   T81]  pci_device_probe+0xa8/0x174
[   10.867937][   T81]  really_probe+0x150/0x2b8
[   10.868774][   T81]  __driver_probe_device+0x7c/0x130
[   10.869755][   T81]  driver_probe_device+0x40/0x118
[   10.870665][   T81]  __device_attach_driver+0xc4/0x108
[   10.871654][   T81]  bus_for_each_drv+0x8c/0xf0
[   10.872585][   T81]  __device_attach+0xa4/0x198
[   10.873581][   T81]  device_initial_probe+0x18/0x28
[   10.874645][   T81]  bus_probe_device+0xb0/0xb4
[   10.875610][   T81]  deferred_probe_work_func+0xac/0xf8
[   10.876696][   T81]  process_one_work+0x18c/0x414
[   10.877573][   T81]  worker_thread+0x41c/0x53c
[   10.878468][   T81]  kthread+0x114/0x118
[   10.879331][   T81]  ret_from_fork+0x10/0x20
[   10.880238][   T81]
[   10.880767][   T81] freed by task 81 on cpu 7 at 10.811436s:
[   10.882311][   T81]  msi_domain_free_descs+0xd4/0x10c
[   10.883318][   T81]  msi_domain_free_locked.part.0+0xc0/0x1d8
[   10.884401][   T81]  msi_domain_alloc_irqs_all_locked+0xb4/0xbc
[   10.885519][   T81]  pci_msi_setup_msi_irqs+0x30/0x4c
[   10.886549][   T81]  __pci_enable_msi_range+0x2a8/0x488
[   10.887537][   T81]  pci_alloc_irq_vectors_affinity+0xec/0x14c
[   10.888576][   T81]  pci_alloc_irq_vectors+0x18/0x28
[   10.889693][   T81]  pcie_portdrv_probe+0x1e0/0x608
[   10.890719][   T81]  pci_device_probe+0xa8/0x174
[   10.891623][   T81]  really_probe+0x150/0x2b8
[   10.892534][   T81]  __driver_probe_device+0x7c/0x130
[   10.893541][   T81]  driver_probe_device+0x40/0x118
[   10.894491][   T81]  __device_attach_driver+0xc4/0x108
[   10.895433][   T81]  bus_for_each_drv+0x8c/0xf0
[   10.896381][   T81]  __device_attach+0xa4/0x198
[   10.897359][   T81]  device_initial_probe+0x18/0x28
[   10.898401][   T81]  bus_probe_device+0xb0/0xb4
[   10.899268][   T81]  deferred_probe_work_func+0xac/0xf8
[   10.900314][   T81]  process_one_work+0x18c/0x414
[   10.901279][   T81]  worker_thread+0x41c/0x53c
[   10.902138][   T81]  kthread+0x114/0x118
[   10.902916][   T81]  ret_from_fork+0x10/0x20
[   10.903816][   T81]
[   10.904429][   T81] CPU: 7 PID: 81 Comm: kworker/u16:2 Not tainted 6.6.2=
3mostafa+ #224
[   10.906362][   T81] Hardware name: linux,dummy-virt (DT)
[   10.907934][   T81] Workqueue: events_unbound deferred_probe_work_func
[   10.909959][   T81] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Looking at the upstream code, it seems to have the same issue where:

Descriptor allocation done in:
__pci_enable_msi_range
    msi_capability_init
        msi_setup_msi_desc
            msi_insert_msi_desc
                msi_domain_insert_msi_desc
                    msi_alloc_desc
                        ...

Freed in case of failure in __msi_domain_alloc_locked()
__pci_enable_msi_range
    msi_capability_init
        pci_msi_setup_msi_irqs
            msi_domain_alloc_irqs_all_locked
                msi_domain_alloc_locked
                    __msi_domain_alloc_locked =3D> fails
                    msi_domain_free_locked
		        ...

That failure would propagate back till pci_msi_setup_msi_irqs() call
in msi_capability_init() which have "goto err" which would access the
descriptor to clear the mask.

However, we can=E2=80=99t make assumptions if the descriptor is freed or no=
t
as it depends on the failure location and on MSI_FLAG_FREE_MSI_DESCS,
so one simple solution is to re-read it.

Also, calling pci_free_msi_irqs() after will trigger
msi_domain_free_locked() again, however it re-iterates through the xa
array, which should be safe.

I hit this only once, but I can confirm the bug(and verify the fix)
for the upstream kernel through stubbing return of
__msi_domain_alloc_locked() to fail and with KASAN enabled.

bf6e054e0e3f ("genirq/msi: Provide msi_device_populate/destroy_sysfs()")
is the first commit that introduced the free logic from the context
of pci_msi_setup_msi_irqs()

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/pci/msi/msi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 682fa877478f..dd961151fecf 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -393,7 +393,10 @@ static int msi_capability_init(struct pci_dev *dev, in=
t nvec,
 	goto unlock;
=20
 err:
-	pci_msi_unmask(entry, msi_multi_mask(entry));
+	/* Re-read the descriptor as it might have been freed */
+	entry =3D msi_first_desc(&dev->dev, MSI_DESC_ALL);
+	if (entry)
+		pci_msi_unmask(entry, msi_multi_mask(entry));
 	pci_free_msi_irqs(dev);
 fail:
 	dev->msi_enabled =3D 0;
--=20
2.44.0.769.g3c40516874-goog



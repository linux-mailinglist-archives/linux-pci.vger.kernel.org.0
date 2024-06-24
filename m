Return-Path: <linux-pci+bounces-9210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD76091581B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 22:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8556C1F26B89
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 20:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C66E1A08C9;
	Mon, 24 Jun 2024 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jv9ImBV9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4E2233B
	for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2024 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261462; cv=none; b=GBw3ZCzaWWEbhjwin0VlyoEy+J4tBOKp32nm0fwtm6Q7/MGKZQvI5BuaWoOjE0ZnoLSxvUR8IWIyFJXfPcrK/YN6mofEZCpo2mYLQoDkEKy04mh5//il7tFkaRkZn6uDMSpT8/j0RqoVtgjPHelSR1V35w03EBazHvU+YpxlSb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261462; c=relaxed/simple;
	bh=L1XzsnQ5ppnBmJf57nQ/6lkOFbCpO6dak2DD3MMJKZA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oUn8HADOWA4Ac68mhb5CMqKs8qABv4a3mv16049g8mNUPKBxbHq0L/8gRGfB+opH9pAogr1uIl/fVCIlbCU/79wv0vVvQBwJtpwcGdShhkdQ7Dm35NoL2XumwztbHva3WQgYc20lBOkkQqMldP00T2ka+oC276mKei6asSqo1rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jv9ImBV9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64507372362so33962577b3.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2024 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719261458; x=1719866258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5dKeLxUmv3HgmiGH705T5CoJNHkqK9018W7aVFo2og8=;
        b=Jv9ImBV9PKpd6t9q8nyg9jA4mBo0OUK6e7bcxBm0Qpz8PqEmHLchqWsAnSHbZUHOjA
         UieduNWuJ15885NENV5V+U/QtgVfvHfvOjA9hMmJ+EZ5ppFURgyk/UHTMypl98EOal+/
         GrCNdUHGDKP38OC8QNN06WVXEvSC9F9+vz3PDXPK0l1/If/mmt2x4hc67dtqCS9t0G7Z
         /0W1RWzOGzSdgRLRNg77ANmnPsTJv4lKZcEEDvE4hzuR3Abj0qpRVohJuVk3YWGeF280
         Q45BhCGte8vC4cpHJtGg0hhXTBKBTJW2hlKrWQjy2jAOtAEIkUP/rc5CROAHRsMD08/g
         6GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719261458; x=1719866258;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dKeLxUmv3HgmiGH705T5CoJNHkqK9018W7aVFo2og8=;
        b=NzcUAsh3aAaF3iwGn0/9DhBSFp5aLur7LCwkKMmTxq8uzYEXEV+nX11z8oqL8KHqSv
         DCgZAJ/qtCBu9AKXyr4G02BNKQUM184jZy6fmKqrAPj2Xy6O08sclMkZTEXd+QIgk6l3
         DPeYufp8nuEXsN6cZ4gX8Plga5HBLHfzOcMA5UjNwRXkUGnDAYZMD3ROjqrrdF9jYGZE
         eebSuoMUWmAH0o8RHrptRQEy2z3qLWrIG9bj2J6D3rgR5tADY0EHH1A07PWfOxTTP+5s
         wKnHV+8OU4pd47vxRMFssn5H0qb5JcNzI0YPv0+Bh5vVX5zrhfvHXa1qC7bPAsBPxIB7
         mWKw==
X-Forwarded-Encrypted: i=1; AJvYcCVRPAgG5rO0suUjo+fogwHkJXLwK8Sk6ZxuAoQ6SmkTMrXAMglo4q8Lqb3DfoPowAvnoCXzyIqN9S3tHzrQcSCBPoznHsqQG5RQ
X-Gm-Message-State: AOJu0YxnO3ofs7/434km9Mdnu8Fqz+6rSJ8PInYeJZ6BPQWGa/Blms5F
	7qlZXztP9UKDSavT/3iwddo91NVEOurfhJBfn+pDn1ypULsDIP53zH2auY/kI6bWLZJENRgWrsS
	kLpoR3ekTsw==
X-Google-Smtp-Source: AGHT+IFUmftJzFzSicOwlW4xqueM1UIIHWLNoT5xwsgp5HjSPkbGGEeKz0ssI1rvcaSszZuXR3m8K1ZwAomG6A==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:690c:25c7:b0:62a:45ce:a268 with SMTP
 id 00721157ae682-6429db2094cmr236737b3.9.1719261458314; Mon, 24 Jun 2024
 13:37:38 -0700 (PDT)
Date: Mon, 24 Jun 2024 20:37:28 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624203729.1094506-1-smostafa@google.com>
Subject: [PATCH v2] PCI/MSI: Fix UAF in msi_capability_init
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
so we copy it and use the copy to mask it in case of error.

Also, calling pci_free_msi_irqs() after will trigger
msi_domain_free_locked() again, however it re-iterates through the xa
array, which should be safe.

I hit this only once, but I can confirm the bug(and verify the fix)
for the upstream kernel through stubbing return of
__msi_domain_alloc_locked() to fail and with KASAN enabled.

bf6e054e0e3f ("genirq/msi: Provide msi_device_populate/destroy_sysfs()")
is the first commit that introduced the free logic from the context
of pci_msi_setup_msi_irqs()

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mostafa Saleh <smostafa@google.com>

---
v2:
- Copy descriptor as suggested by tglx to unmaks freed msis
---
 drivers/pci/msi/msi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index c5625dd9bf49..3a45879d85db 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -352,7 +352,7 @@ static int msi_capability_init(struct pci_dev *dev, int=
 nvec,
 			       struct irq_affinity *affd)
 {
 	struct irq_affinity_desc *masks =3D NULL;
-	struct msi_desc *entry;
+	struct msi_desc *entry, desc;
 	int ret;
=20
 	/* Reject multi-MSI early on irq domain enabled architectures */
@@ -377,6 +377,12 @@ static int msi_capability_init(struct pci_dev *dev, in=
t nvec,
 	/* All MSIs are unmasked by default; mask them all */
 	entry =3D msi_first_desc(&dev->dev, MSI_DESC_ALL);
 	pci_msi_mask(entry, msi_multi_mask(entry));
+	/*
+	 * Copy the MSI descriptor for the error path because
+	 * pci_msi_setup_msi_irqs() will free it for the hierarchical
+	 * interrupt domain case.
+	 */
+	memcpy(&desc, entry, sizeof(desc));
=20
 	/* Configure MSI capability structure */
 	ret =3D pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
@@ -396,7 +402,7 @@ static int msi_capability_init(struct pci_dev *dev, int=
 nvec,
 	goto unlock;
=20
 err:
-	pci_msi_unmask(entry, msi_multi_mask(entry));
+	pci_msi_unmask(&desc, msi_multi_mask(&desc));
 	pci_free_msi_irqs(dev);
 fail:
 	dev->msi_enabled =3D 0;
--=20
2.45.2.741.gdbec12cfda-goog



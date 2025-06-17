Return-Path: <linux-pci+bounces-29973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF938ADDCAA
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 21:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160AE189A550
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 19:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44999238151;
	Tue, 17 Jun 2025 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="XOzGSRoQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04031E2312
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189674; cv=none; b=g9Ur+XK06cWCmWmgocXkR6EdN9vERBWG1pi2a6xk/TGiXQA3HV8Per88Jkjd3V/4GqVvuhKrYRgimcNyzF7VV+/bh2qemy0j4UwgDZZ4GUgEu20n2oJ+Z0BXB7tnNaiFGULEj4SUeMPo6n5yXyj/+GnwfNUZw7uVltV7sG9yft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189674; c=relaxed/simple;
	bh=Q9tOR5c22jHIpcYcZ9y8ymWBNo0vDkkcxoGswVJQd9g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sqUhehYBDx50wJcPmrBvyGB/7ZQO4vRpYFYxPIbz4pZKfhkQYTy0Qv2MOeB/ZA8/oZ2+qNKLlYHQRWAzd4uoXSUuSQba4iimr31xpvgcu+MgQogX2SZzF2T0HokMGhtmoh72JKE5yZ/oM/YudBMi7k7feK4R0uwchjHPZ8Q4oaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=XOzGSRoQ; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id BD70C552F52E;
	Tue, 17 Jun 2025 19:47:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BD70C552F52E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1750189668;
	bh=Ky902UmEJ2rxlwfcpu5ICzPaQwIKBWouHsS2V00UnZU=;
	h=Date:From:To:Cc:Subject:From;
	b=XOzGSRoQedoSyNgwuYswoFa9hiFGpmMHTrZX0tWFC6BpC5axO37pXAr1AqrvpAkJB
	 baWWxB0GBAuvvTjVHrCdRcxo63zfWolg6KWXH2xVOoVVjVdmOMZraEhGTgQAZe1I+v
	 v0pv66CjUrvxAZjaamGS4RbcRxzN+WAxxon8JJ8c=
Date: Tue, 17 Jun 2025 22:47:48 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Lukas Wunner <lukas@wunner.de>, Ben Hutchings <ben@decadent.org.uk>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, linux-pci@vger.kernel.org, iommu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>, lvc-project@linuxtesting.org
Subject: amd-iommu / agpgart-amd64 problem: Resources present before probing
Message-ID: <wpoivftgshz5b5aovxbkxl6ivvquinukqfvb5z6yi4mv7d25ew@edtzr2p74ckg>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,

there is a 

  [    0.579232] pci 0000:00:00.2: Resources present before probing

error message observed after

  commit 3be5fa236649da6404f1bca1491bf02d4b0d5cce
  Author: Lukas Wunner <lukas@wunner.de>
  Date:   Fri Apr 25 11:24:21 2025 +0200
  
      Revert "iommu/amd: Prevent binding other PCI drivers to IOMMU PCI devices"


After tracking this down I've found that it's agpgart-amd64 driver trying
to bind to the IOMMU device:

  00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Family 17h-19h IOMMU
          Subsystem: Lenovo Device 3803
          Flags: bus master, fast devsel, latency 0, IRQ 25
          Capabilities: <access denied>

IOMMU device itself has no pci_driver attached to it but has a pci_dev,
and its struct device already has some devres associated with it.

agpgart-amd64 driver booting with 'agp_try_unsupported=1' (turns out it's
a default behavior) traverses the devices on the PCI bus and tries to
attach:


static const struct pci_device_id agp_amd64_pci_promisc_table[] = {
	{ PCI_DEVICE_CLASS(0, 0) },
	{ }
};

...

int __init agp_amd64_init(void)
{
...
		/* Look for any AGP bridge */
		agp_amd64_pci_driver.id_table = agp_amd64_pci_promisc_table;
		err = driver_attach(&agp_amd64_pci_driver.driver);
		if (err == 0 && agp_bridges_found == 0) {
			pci_unregister_driver(&agp_amd64_pci_driver);
			err = -ENODEV;
		}


IOMMU device is busy at the moment but, to my mind, lack of pci_driver
associated with it leads driver core trying to bind it, too.

But registering a pci_driver for IOMMU device is no good.

Initial commit cbbc00be2ce3 ("iommu/amd: Prevent binding other PCI drivers
to IOMMU PCI devices") was added in 2015, not sure whether the problem
manifested before that. At least the commit message doesn't state that
it tried to fix such kind of a bug.

The problem on itself is no harm at the end as driver core handles the
error and skips the device. But it still indicates a logical bug.


The partial revert of the revert does work, obviously. Though it badly
contradicts the intention to hide priv_flags manipulation in the PCI core.

So I wonder whether agpgart-amd64 should be somehow fixed instead... to
skip IOMMU device from its wildcard promiscuous PCI ID table? Or drop this
'try_unsupported' feature entirely? 

Would be glad to hear your thoughts on this.

Found by Linux Verification Center (linuxtesting.org).

--
Thanks,
Fedor


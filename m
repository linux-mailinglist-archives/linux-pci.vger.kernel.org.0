Return-Path: <linux-pci+bounces-43636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF02CDB5A7
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 05:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA65D30245EE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 04:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D54C21D3DC;
	Wed, 24 Dec 2025 04:52:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5F918859B;
	Wed, 24 Dec 2025 04:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766551940; cv=none; b=Pa+umfLLBONZPFW0k+JTDQZ/76+J8RdYoiQmdL+qCNO6Xyq/cMVuKmESfSQLcX7Q4YJe3DJggzAx/DbVMNucpmPph3yjy5V/eGKOqdvERDvsXY13IZol9czPuVbO1nHnyOI1WhxQ0IisdcilVGxbf8ZBcN7T7jl8MQU0ZTpSEJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766551940; c=relaxed/simple;
	bh=l3CCrJ+c2k6AUWpACP9eTGThKPDgGk8UuAh6i2CCU8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rb/DVvEe8mdNn7pZw5WD996Z6hZWOHt27MV6/fTdOxOpaFb3XEk0NyhCZabMidJVV3EZ37T2tKGVjqsBykeO7M9s3GVSF7luH2k7jkdpj0XlE7NvJivq0sv80mVPf437FhLcS3WrT4VHe1q5Xce8KHwds4ljp3tcK5a8dG/pdSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.109] (unknown [114.241.82.59])
	by APP-05 (Coremail) with SMTP id zQCowADHWAxmcUtp2LW8AQ--.30082S2;
	Wed, 24 Dec 2025 12:51:51 +0800 (CST)
Message-ID: <2eb2ad42-67e7-4f5b-bade-4a3627eb270c@iscas.ac.cn>
Date: Wed, 24 Dec 2025 12:51:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] PCI/MSI: Generalize no_64bit_msi into msi_addr_mask
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: Han Gao <gaohan@iscas.ac.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20251224-pci-msi-addr-mask-v1-0-05a6fcb4b4c0@iscas.ac.cn>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20251224-pci-msi-addr-mask-v1-0-05a6fcb4b4c0@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowADHWAxmcUtp2LW8AQ--.30082S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1rGFyUZF4fuFW7AFW8Zwb_yoW8Jw4rpF
	4UGFW3uFWFy3yftFWay3Wj9F15Z3Z3K343W3y3Kwn3ZFnIqr17XrnrGF13JwnFqrWxJr40
	qFy7Gwn0gFnxWr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUn1v3UUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 12/24/25 11:10, Vivian Wang wrote:
> The Sophgo SG2042 is a cursed machine in more ways than one.
>
[...]

> ---
> Vivian Wang (5):
>       PCI/MSI: Conservatively generalize no_64bit_msi into msi_addr_mask
>       PCI/MSI: Check msi_addr_mask in msi_verify_entries()
>       drm/radeon: Raise msi_addr_mask to 40 bits for pre-Bonaire
>       ALSA: hda/intel: Raise msi_addr_mask to dma_bits
>       [RFC net-next] net: ionic: Set msi_addr_mask to IONIC_ADDR_LEN-bit everywhere
>
>  arch/powerpc/platforms/powernv/pci-ioda.c           |  2 +-
>  arch/powerpc/platforms/pseries/msi.c                |  4 ++--
>  drivers/gpu/drm/radeon/radeon_irq_kms.c             |  4 ++--
>  drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c |  4 +---
>  drivers/pci/msi/msi.c                               | 11 +++++++----
>  drivers/pci/msi/pcidev_msi.c                        |  2 +-
>  drivers/pci/probe.c                                 |  7 +++++++
>  include/linux/pci.h                                 |  8 +++++++-
>  sound/hda/controllers/intel.c                       | 10 +++++-----
>  9 files changed, 33 insertions(+), 19 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251223-pci-msi-addr-mask-2d765a7eb390
>
> Best regards,

+cc linux-riscv and sophgo lists. Please see:

    https://lore.kernel.org/r/20251224-pci-msi-addr-mask-v1-0-05a6fcb4b4c0@iscas.ac.cn/

This is what happens when I rely on get_maintainers.pl too much...



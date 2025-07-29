Return-Path: <linux-pci+bounces-33135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04465B15208
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 19:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28AA44E4D91
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 17:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6353A293462;
	Tue, 29 Jul 2025 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Qlqq1BIk"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D755F1A00F0;
	Tue, 29 Jul 2025 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753809777; cv=none; b=q80oahFL/4Yoz+Q0lGvvUm3pAi0H6gopimV5kiGqnAEKrmt0vO8nFMk17RkOS8op7XhU/kRKWRJZAJmrqIFCh+D7Z9ljhILhj2TxKJxUfwoqO8gEXztjEDz9wCF/jOb5MpfQUIqo4QLLSoNtFRe9pOFt9P0lVnkDDjkU/g3pdgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753809777; c=relaxed/simple;
	bh=KA6ZAtGQiJlSVjmLuiTBgDLX1BiB5uiH9Ra4fiesJvs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hudbxwIiER0x3hCrLQYLVmMqalfKNw56TQqgC/IMSmrOvddRLFUGCi5RcOnZs2dczHtFVPkBxjuHdVoAnQqHZ5B6mvmVhmZ6/UUeGjTjZnbcot134lOu87aX4c3zY3wldkpI+ihMRiw+3HhjsF11BpLmoLtgsC+o9j8qumcM+IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Qlqq1BIk; arc=none smtp.client-ip=119.8.177.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=G7Eom1blsic0Jqst4S9mppt/c2c/URlaFiHl3j3NJjQ=;
	b=Qlqq1BIkB+Do2b2sP2P4EN2oBBv87w9LfLduhwHkuCc+M1NwCdnqeiLGIW+XxalvvW/mdIe8+
	VhoehCCaWN9c0oksJa5Z1szmgvyctqqWDR1E9eaa6gOJ8dEVJz/ZvdCYW+zUmwl+T/+NOpB8dR5
	SssciBQII81b0haM1borJMQ=
Received: from frasgout.his.huawei.com (unknown [172.18.146.36])
	by sinmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4bs2FM3p8Sz1P7K0;
	Wed, 30 Jul 2025 01:21:27 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bs2Dj6bwHz6L5Fk;
	Wed, 30 Jul 2025 01:20:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 051D01402EC;
	Wed, 30 Jul 2025 01:22:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Jul
 2025 19:22:46 +0200
Date: Tue, 29 Jul 2025 18:22:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 12/38] coco: host: arm64: CCA host platform
 device driver
Message-ID: <20250729182244.00002f4f@huawei.com>
In-Reply-To: <20250728135216.48084-13-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-13-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Jul 2025 19:21:49 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> This driver registers the pci_tsm_ops with tsm subsystem.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Hi Aneesh,

For this main comment is around use of __free..  Dan wrote up guidance and
added to cleanup.h after many email threads kept running into same issues
and Linus added his requirements for that stuff to be acceptable.

Anyhow, easy to fix - comments inline.

> diff --git a/drivers/virt/coco/arm-cca-host/Kconfig b/drivers/virt/coco/arm-cca-host/Kconfig
> new file mode 100644
> index 000000000000..0f19fbf47613
> --- /dev/null
> +++ b/drivers/virt/coco/arm-cca-host/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TSM (TEE Security Manager) host drivers
> +#
> +config ARM_CCA_HOST
> +	tristate "Arm CCA Host driver"
> +	depends on ARM64
> +	depends on PCI_TSM
> +	select TSM
> +
> +	help
> +	  The driver provides TSM backend for ARM CCA

That's going to make for grumpy checkpatch!   More help.


> diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
> new file mode 100644
> index 000000000000..c8b0e6db1f47
> --- /dev/null
> +++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 ARM Ltd.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/pci-tsm.h>
> +#include <linux/pci-ide.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/tsm.h>
> +#include <linux/vmalloc.h>
cleanup.h and maybe others missing.  Basically follow include what you use principles
(flexed a little for headers that are front ends to others).

> +
> +#include "rmm-da.h"
> +
> +/* Number of streams that we can support at the hostbridge level */
> +#define CCA_HB_PLATFORM_STREAMS 4
> +
> +/* Total number of stream id supported at root port level */
> +#define MAX_STREAM_ID	256
> +
> +DEFINE_FREE(vfree, void *, if (!IS_ERR_OR_NULL(_T)) vfree(_T))
> +static struct pci_tsm *cca_tsm_pci_probe(struct pci_dev *pdev)
> +{
> +	int rc;
> +	struct pci_host_bridge *hb;
> +	struct cca_host_dsc_pf0 *dsc_pf0 __free(vfree) = NULL;

Read the stuff in cleanup.h and work out why this needs
changing to be inline below and not use this NULL pattern here
(unless you like grumpy Linus ;)

Note that with the err_out, even if you do that you'll still be
breaking with the guidance doc (and actually causing undefined
behavior :)  Get rid of those gotos if you want to use __free()


> +
> +	if (pdev->is_virtfn)
> +		return NULL;
> +
> +	if (!is_pci_tsm_pf0(pdev)) {
> +		struct pci_tsm *tsm = kzalloc(sizeof(*tsm), GFP_KERNEL);
> +
> +		if (!tsm)
> +			goto err_out;
> +
> +		pci_tsm_initialize(pdev, tsm);
> +		return tsm;
> +	}
> +
> +	if (!pdev->ide_cap)
> +		goto err_out;
> +
> +	dsc_pf0 = vcalloc(sizeof(*dsc_pf0), GFP_KERNEL);
> +	if (!dsc_pf0)
> +		goto err_out;
> +
> +	rc = pci_tsm_pf0_initialize(pdev, &dsc_pf0->pci);
> +	if (rc)
> +		return NULL;
> +	/*
> +	 * FIXME!!
> +	 * update the hostbridge details. This should go into
> +	 * some host bridge probe/init routine.
> +	 * than the selective index supported by the endpoint
> +	 */
> +	hb = pci_find_host_bridge(pdev->bus);
> +	pci_ide_init_nr_streams(hb, CCA_HB_PLATFORM_STREAMS);
> +
> +	pci_info(pdev, "tsm enabled\n");

Ok. RFC I guess.  Still pci_dbg()

> +	return &no_free_ptr(dsc_pf0)->pci.tsm;
> +
> +err_out:

Why? Random mix of direct returns of NULL above and goto here.

> +	return NULL;
> +}
> +
> +static void cca_tsm_pci_remove(struct pci_tsm *tsm)
> +{
> +	struct pci_dev *pdev = tsm->pdev;
> +	struct cca_host_dsc_pf0 *dsc_pf0;
> +
> +	if (WARN_ON(pdev->is_virtfn))
> +		return;
> +
> +	if (!is_pci_tsm_pf0(pdev)) {
> +
> +		pci_dbg(tsm->pdev, "tsm disabled\n");
> +		kfree(pdev->tsm);
> +		return;
> +	}
> +
> +	dsc_pf0 = to_cca_dsc_pf0(pdev);
> +	pci_dbg(tsm->pdev, "tsm disabled\n");
> +	vfree(dsc_pf0);
> +}
> +
> +/* per root port unique with multiple restrictions. For now global */
> +static DECLARE_BITMAP(cca_stream_ids, MAX_STREAM_ID);

> +
> +static void cca_tsm_disconnect(struct pci_dev *pdev)
> +{
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +	struct cca_host_dsc_pf0 *dsc_pf0;
> +	struct pci_ide *ide;
> +
> +	if (WARN_ON(!is_pci_tsm_pf0(pdev)))
> +		return;
> +
> +	dsc_pf0 = to_cca_dsc_pf0(pdev);
> +	ide = dsc_pf0->sel_stream;
> +	dsc_pf0->sel_stream = NULL;
> +	pci_ide_stream_disable(pdev, ide);
> +	tsm_ide_stream_unregister(ide);
> +	pci_ide_stream_teardown(rp, ide);
> +	pci_ide_stream_teardown(pdev, ide);
> +	pci_ide_stream_unregister(ide);
> +	clear_bit(ide->stream_id, cca_stream_ids);
> +	pci_ide_stream_free(ide);

Ordering subtly different from error path above.
If there is a reason for that add a comment.

> +}

> +static void cca_tsm_remove(void *tsm_core)
> +{
> +	tsm_unregister(tsm_core);
> +}
> +
> +static int cca_tsm_probe(struct platform_device *pdev)
> +{
> +	struct tsm_core_dev *tsm_core;
> +
> +	tsm_core = tsm_register(&pdev->dev, NULL, &cca_pci_ops);
> +	if (IS_ERR(tsm_core))
> +		return PTR_ERR(tsm_core);
> +
> +	return devm_add_action_or_reset(&pdev->dev, cca_tsm_remove, tsm_core);

So this makes two with the one in Dan's test code. 
devm_tsm_register() seems to be a useful generic thing to add (implementation
being exactly what you have here.

> +}
> +
> +static const struct platform_device_id arm_cca_host_id_table[] = {
> +	{ RMI_DEV_NAME, 0},
Space before } and don't provide data until there is a use for it.
	{ RMI_DEV_NAME }

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, arm_cca_host_id_table);
> +
Consistency on spacing.  I'd go for just 1 blank line for separation
of things.
> +
> +static struct platform_driver cca_tsm_platform_driver = {
> +	.probe = cca_tsm_probe,
> +	.id_table = arm_cca_host_id_table,
> +	.driver = {
> +		.name = "cca_tsm",
> +	},
> +};
> +
> +MODULE_IMPORT_NS("PCI_IDE");
> +module_platform_driver(cca_tsm_platform_driver);
> +MODULE_DESCRIPTION("ARM CCA Host TSM driver");
> +MODULE_LICENSE("GPL");




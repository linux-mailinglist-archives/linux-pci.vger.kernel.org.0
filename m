Return-Path: <linux-pci+bounces-33126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FDDB1508B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 17:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21EBF189F54A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167E8296156;
	Tue, 29 Jul 2025 15:59:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA5628F933;
	Tue, 29 Jul 2025 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804741; cv=none; b=bthXWs+5FJZL4EsH+PHp5EZPPNNOcmwBk8RBf1ikwKVlqMkUJaiBONMtzxBKGuFQ96js6TV6SJsSfDScEjNV+iRXwM1uX8qha1Gasa2Kg2Us1/Ux0Un2zL+iXfI+S00rruuPTSItofKQC/w/qUQfqgRpzJQr3QfPcL+gUXPAX6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804741; c=relaxed/simple;
	bh=aZj/mu1CQVQDKQkQiWcywZWnT6g2giUw31KyKB0NMQw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITHqWb4H0U07zT51QKfZ73vFSrzxWfqNqZM28KKe5PZTBNoIaBKYR7mgwQKn22jBSU+eGiPM7L21dXWbmTfzLloD0CGablm2RO3AkB5GfNAIQW1tymyTzkr0dGboT66NRVF10aNvSWxGt0MVbmjwAv5JrMuGuoahyqtfqrsSsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bs0My43v8z6L5Wj;
	Tue, 29 Jul 2025 23:57:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 838521402FD;
	Tue, 29 Jul 2025 23:58:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Jul
 2025 17:58:55 +0200
Date: Tue, 29 Jul 2025 16:58:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v4 09/10] PCI/TSM: Report active IDE streams
Message-ID: <20250729165853.00007b3d@huawei.com>
In-Reply-To: <20250717183358.1332417-10-dan.j.williams@intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
	<20250717183358.1332417-10-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Jul 2025 11:33:57 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Given that the platform TSM owns IDE Stream ID allocation, report the
> active streams via the TSM class device. Establish a symlink from the
> class device to the PCI endpoint device consuming the stream, named by
> the Stream ID.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Trivial stuff only
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  Documentation/ABI/testing/sysfs-class-tsm | 10 ++++++++
>  drivers/pci/ide.c                         |  4 ++++
>  drivers/virt/coco/tsm-core.c              | 28 +++++++++++++++++++++++
>  include/linux/pci-ide.h                   |  2 ++
>  include/linux/tsm.h                       |  4 ++++
>  5 files changed, 48 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
> index 2949468deaf7..6fc1a5ac6da1 100644
> --- a/Documentation/ABI/testing/sysfs-class-tsm
> +++ b/Documentation/ABI/testing/sysfs-class-tsm
> @@ -7,3 +7,13 @@ Description:
>  		signals when the PCI layer is able to support establishment of
>  		link encryption and other device-security features coordinated
>  		through a platform tsm.
> +
> +What:		/sys/class/tsm/tsmN/streamH.R.E
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) When a host bridge has established a secure connection via
> +		the platform TSM, symlink appears. The primary function of this
> +		is have a system global review of TSM resource consumption
> +		across host bridges. The link points to the endpoint PCI device
> +		and matches the same link published by the host bridge. See
> +		Documentation/ABI/testing/sysfs-devices-pci-host-bridge.

> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index 093824dc68dd..b0ef9089e0f2 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c

> +/* must be invoked between tsm_register / tsm_unregister */
> +int tsm_ide_stream_register(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_tsm *tsm = pdev->tsm;
> +	struct tsm_dev *tsm_dev = tsm->ops->owner;
> +	int rc;
> +
> +	rc = sysfs_create_link(&tsm_dev->dev.kobj, &pdev->dev.kobj,
> +			       ide->name);

Fits on one line under 80 chars (just)

> +	if (rc == 0)
> +		ide->tsm_dev = tsm_dev;

I'd prefer 

	if (rc)
		return rc;

	ide->tsm_dev = tsm_dev;

	return 0;

but don't care that much.

> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(tsm_ide_stream_register);
> +
> +void tsm_ide_stream_unregister(struct pci_ide *ide)
> +{
> +	struct tsm_dev *tsm_dev = ide->tsm_dev;
> +
> +	sysfs_remove_link(&tsm_dev->dev.kobj, ide->name);
> +	ide->tsm_dev = NULL;
> +}
> +EXPORT_SYMBOL_GPL(tsm_ide_stream_unregister);

> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index ce95589a5d5b..4eba45a754ec 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -120,4 +120,8 @@ const char *tsm_name(const struct tsm_dev *tsm_dev);
>  struct tsm_dev *find_tsm_dev(int id);
>  const struct pci_tsm_ops *tsm_pci_ops(const struct tsm_dev *tsm_dev);
>  const struct attribute_group *tsm_pci_group(const struct tsm_dev *tsm_dev);
> +struct pci_dev;

Not used.

> +struct pci_ide;
> +int tsm_ide_stream_register(struct pci_ide *ide);
> +void tsm_ide_stream_unregister(struct pci_ide *ide);
>  #endif /* __TSM_H */



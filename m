Return-Path: <linux-pci+bounces-20576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F21DA22DF5
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 14:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA93516395E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7181E493C;
	Thu, 30 Jan 2025 13:39:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1698462
	for <linux-pci@vger.kernel.org>; Thu, 30 Jan 2025 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738244365; cv=none; b=Z1yP/iyFvk0Y0/oqwStHwJAV3LSWoOVqq0gjhh0258zY73Yu5YPOElbmQGc54Z8FMYVaWDFTteViQOemZvH3jwloKXkgRM9NBdbQJDD3ZU+vl2eTAM6MbkR2/YT51DS7qNxQ3KWCynWRKXi9FWSI9wRIlcRP9YpwcPWYr2P43ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738244365; c=relaxed/simple;
	bh=RIgKt8HHQqmlMNi4T8tsn4Qnv0Ra7e4iPjx6SVS2Esk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RaH7y42sr87REsLDmeapc5sQgDV0QXY4F8LqFtrVwQeetV2grQLWwngKaPT8Wlk4qKXESybw0fGH79DTQYjRNZyKjTM4DR3YoEzNvAU9SA1uUtLOX/3yvTE0DrEcbM7kElQWWpUG6m7BR3BcEspTI1ZK5QuHnNE5prtUNtFpc4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YkKnj4ynPz6K8lH;
	Thu, 30 Jan 2025 21:37:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F066140B18;
	Thu, 30 Jan 2025 21:39:20 +0800 (CST)
Received: from localhost (10.47.30.69) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 30 Jan
 2025 14:39:20 +0100
Date: Thu, 30 Jan 2025 13:39:17 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, "Alexey
 Kardashevskiy" <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 11/11] samples/devsec: Add sample IDE establishment
Message-ID: <20250130133917.0000539c@huawei.com>
In-Reply-To: <173343745958.1074769.12896997365766327404.stgit@dwillia2-xfh.jf.intel.com>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
	<173343745958.1074769.12896997365766327404.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 05 Dec 2024 14:24:19 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Exercise common setup and teardown flows for a sample platform TSM
> driver that implements the TSM 'connect' and 'disconnect' flows.
> 
> This is both a template for platform specific implementations and a test
> case for the shared infrastructure.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Trivial comments inline.

>  static int devsec_tsm_connect(struct pci_dev *pdev)
>  {
> -	return -ENXIO;
> +	struct pci_ide *ide;
> +	int rc, stream_id;
> +
> +	stream_id =
> +		find_first_zero_bit(devsec_stream_ids, DEVSEC_NR_IDE_STREAMS);
> +	if (stream_id == DEVSEC_NR_IDE_STREAMS)
> +		return -EBUSY;
> +	set_bit(stream_id, devsec_stream_ids);
> +	ide = &devsec_streams[stream_id].ide;
> +	pci_ide_stream_probe(pdev, ide);
> +
> +	ide->stream_id = stream_id;
> +	rc = pci_ide_stream_setup(pdev, ide, PCI_IDE_SETUP_ROOT_PORT);
> +	if (rc)
> +		return rc;
> +	rc = tsm_register_ide_stream(pdev, ide);
> +	if (rc)
> +		goto err;
> +
> +	devsec_streams[stream_id].pdev = pdev;
> +	pci_ide_enable_stream(pdev, ide);
> +	return 0;
> +err:
> +	pci_ide_stream_teardown(pdev, ide, PCI_IDE_SETUP_ROOT_PORT);

I'd kind of expect to see more of what we have in disconnect here.
Like clearing the bit.

> +	return rc;
>  }
>  
>  static void devsec_tsm_disconnect(struct pci_dev *pdev)
>  {
> +	struct pci_ide *ide;
> +	int i;
> +
> +	for_each_set_bit(i, devsec_stream_ids, DEVSEC_NR_IDE_STREAMS)
> +		if (devsec_streams[i].pdev == pdev)
> +			break;
> +
> +	if (i >= DEVSEC_NR_IDE_STREAMS)
> +		return;
> +
> +	ide = &devsec_streams[i].ide;
> +	pci_ide_disable_stream(pdev, ide);
> +	tsm_unregister_ide_stream(ide);
> +	pci_ide_stream_teardown(pdev, ide, PCI_IDE_SETUP_ROOT_PORT);
> +	devsec_streams[i].pdev = NULL;
If this setting to NULL needs to be out of order wrt to what happens
in probe, add a comment.  If not move it to after pci_ide_disable_steram()

> +	clear_bit(i, devsec_stream_ids);
>  }
>  
>  static const struct pci_tsm_ops devsec_pci_ops = {
> @@ -63,16 +113,44 @@ static void devsec_tsm_remove(void *tsm)
>  	tsm_unregister(tsm);
>  }
>  
> +static void set_nr_ide_streams(int nr)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	for_each_pci_dev(pdev) {
> +		struct pci_host_bridge *hb;
> +
> +		if (pdev->sysdata != devsec_sysdata)
> +			continue;
> +		hb = pci_find_host_bridge(pdev->bus);
> +		if (hb->nr_ide_streams >= 0)
> +			continue;
> +		pci_set_nr_ide_streams(hb, nr);
> +	}
> +}
> +
> +static void devsec_tsm_ide_teardown(void *data)
> +{
> +	set_nr_ide_streams(-1);
> +}
> +
>  static int devsec_tsm_probe(struct platform_device *pdev)
>  {
>  	struct tsm_subsys *tsm;
> +	int rc;
>  
>  	tsm = tsm_register(&pdev->dev, NULL, &devsec_pci_ops);
>  	if (IS_ERR(tsm))
>  		return PTR_ERR(tsm);
>  
> -	return devm_add_action_or_reset(&pdev->dev, devsec_tsm_remove,
> -					tsm);
> +	rc = devm_add_action_or_reset(&pdev->dev, devsec_tsm_remove, tsm);
> +	if (rc)
> +		return rc;
> +
> +	set_nr_ide_streams(DEVSEC_NR_IDE_STREAMS);
> +
> +	return devm_add_action_or_reset(&pdev->dev, devsec_tsm_ide_teardown,
> +					NULL);
>  }
>  
>  static struct platform_driver devsec_tsm_driver = {
> @@ -109,5 +187,6 @@ static void __exit devsec_tsm_exit(void)
>  }
>  module_exit(devsec_tsm_exit);
>  
> +MODULE_IMPORT_NS(PCI_IDE);
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Device Security Sample Infrastructure: Platform TSM Driver");
> 
> 



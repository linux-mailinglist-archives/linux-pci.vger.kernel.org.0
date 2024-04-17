Return-Path: <linux-pci+bounces-6361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F688A87E3
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 17:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 500DCB23729
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 15:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEC51474DA;
	Wed, 17 Apr 2024 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCMzOZ9N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B28146D58
	for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368289; cv=none; b=DuFU6ExUzU5C6RupoN2VT0QOvL/vAyACbuXrBEut/hVZqD/kOO54svRSztGYBv+sO1rHMzH2TxhBHcBIAro35JTGzoLI+laJxWotdVWVwp96+4B+egPVwNCxoN6PCjYko0TY9VIXzrr+9B8+P9RyN5e6mT7geJbOpH4Af9eSsO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368289; c=relaxed/simple;
	bh=qEhVyvZnNGVS9A7n9cMUXixdvpj55tBUm0dmbMQMGv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0sxKe9UiZOYAvveF8exzYEKaehgY1Jl2iGaVmbhFaaK1WbKR4T0bHqxgEg4b5TCD0n6OPZkIPDYRudcutz2UW7D3/MSCyrEiQw2GdvLK8sn/C/d5ppHyBLbA62cq9yMmgiAgzKbNeqZn98K/orxP/ThDexjc4wFs5YBX0WHx7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCMzOZ9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E59CC072AA;
	Wed, 17 Apr 2024 15:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713368289;
	bh=qEhVyvZnNGVS9A7n9cMUXixdvpj55tBUm0dmbMQMGv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCMzOZ9NDb6050ecU0cMKIL11XeHGLy1FXu4WfDO5OXhqOyHXF8Mj9mSWDotVoCgg
	 t/Gv5esQ0x5Nw2lR3rryvNBghJ23gTo0wmSbwmp7hxFIJ6QjLkg1+t5ozwyrkh5QFA
	 hCY4p93SK0UTQfnaDFZLsjhxOhL1d0sKjZ1QoULnXA9LFvEfM2iEZOERShtkOToqr7
	 5MdTqDMKkZFSFtYpWdilH6pgqX+QPq4dhbTrdd4czRYnxO6lpNyk9DLeir1ybKyiN2
	 ypaQ2j+WCyzVZuJ8tHhg1NtMYFMUkZGN9jTB64HgOohdWjREGgKKO6eyjgcGSrNxeL
	 8P5hKjC7sT8Aw==
Date: Wed, 17 Apr 2024 17:38:05 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: manivannan.sadhasivam@linaro.org, linux-pci@vger.kernel.org
Subject: Re: [bug report] PCI: endpoint: Remove "core_init_notifier" flag
Message-ID: <Zh_s3WdFURyll54l@ryzen>
References: <024b5826-7180-4076-ae08-57d2584cca3f@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <024b5826-7180-4076-ae08-57d2584cca3f@moroto.mountain>

On Wed, Apr 17, 2024 at 03:47:48PM +0300, Dan Carpenter wrote:
> Hello Manivannan Sadhasivam,
> 
> Commit a01e7214bef9 ("PCI: endpoint: Remove "core_init_notifier"
> flag") from Mar 27, 2024 (linux-next), leads to the following Smatch
> static checker warning:
> 
> 	drivers/pci/endpoint/functions/pci-epf-test.c:784 pci_epf_test_core_init()
> 	error: we previously assumed 'epc_features' could be null (see line 747)
> 
> drivers/pci/endpoint/functions/pci-epf-test.c
>     734 static int pci_epf_test_core_init(struct pci_epf *epf)
>     735 {
>     736         struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>     737         struct pci_epf_header *header = epf->header;
>     738         const struct pci_epc_features *epc_features;
>     739         struct pci_epc *epc = epf->epc;
>     740         struct device *dev = &epf->dev;
>     741         bool linkup_notifier = false;
>     742         bool msix_capable = false;
>     743         bool msi_capable = true;
>     744         int ret;

We check pci_epc_get_features() in ->bind(), which comes before ->core_init()
so in practice, this shouldn't be able to be NULL here.


>     745 
>     746         epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
>     747         if (epc_features) {
>                     ^^^^^^^^^^^^
> epc_features can be NULL

We should probably just chge this to:

"""
if (!epc_features)
	return some_error;

msix_capable = epc_features->msix_capable;
msi_capable = epc_features->msi_capable;
"""

Such that we don't need another check further down for linkup_notifier.


Kind regards,
Niklas

> 
>     748                 msix_capable = epc_features->msix_capable;
>     749                 msi_capable = epc_features->msi_capable;
>     750         }
>     751 
>     752         if (epf->vfunc_no <= 1) {
>     753                 ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no, header);
>     754                 if (ret) {
>     755                         dev_err(dev, "Configuration header write failed\n");
>     756                         return ret;
>     757                 }
>     758         }
>     759 
>     760         ret = pci_epf_test_set_bar(epf);
>     761         if (ret)
>     762                 return ret;
>     763 
>     764         if (msi_capable) {
>     765                 ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
>     766                                       epf->msi_interrupts);
>     767                 if (ret) {
>     768                         dev_err(dev, "MSI configuration failed\n");
>     769                         return ret;
>     770                 }
>     771         }
>     772 
>     773         if (msix_capable) {
>     774                 ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
>     775                                        epf->msix_interrupts,
>     776                                        epf_test->test_reg_bar,
>     777                                        epf_test->msix_table_offset);
>     778                 if (ret) {
>     779                         dev_err(dev, "MSI-X configuration failed\n");
>     780                         return ret;
>     781                 }
>     782         }
>     783 
> --> 784         linkup_notifier = epc_features->linkup_notifier;
>                                   ^^^^^^^^^^^^^^
> Unchecked dereference.
> 
>     785         if (!linkup_notifier)
>     786                 queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
>     787 
>     788         return 0;
>     789 }
> 
> regards,
> dan carpenter


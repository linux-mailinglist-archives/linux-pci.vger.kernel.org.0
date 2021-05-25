Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE5738FBF1
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 09:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhEYHp7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 03:45:59 -0400
Received: from verein.lst.de ([213.95.11.211]:58036 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231477AbhEYHp6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 May 2021 03:45:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E209367357; Tue, 25 May 2021 09:44:26 +0200 (CEST)
Date:   Tue, 25 May 2021 09:44:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Henrik Juul Hansen <hjhansen2020@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use
 npss.
Message-ID: <20210525074426.GA14916@lst.de>
References: <20210520033315.490584-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520033315.490584-1-koba.ko@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 20, 2021 at 11:33:15AM +0800, Koba Ko wrote:
> After resume, host can't change power state of the closed controller
> from D3cold to D0.

Why?

> For these devices, just avoid to go deeper than d3hot.

What are "these devices"?

> @@ -2958,6 +2959,15 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
>  
> +	if (pm_suspend_via_firmware() || !dev->ctrl.npss ||
> +	    !pcie_aspm_enabled(pdev) ||
> +	    dev->nr_host_mem_descs ||
> +	    (dev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND)) {

Before we start open coding this in even more places we really want a
little helper function for these checks, which should be accomodated with
the comment near the existing copy of the checks.

> +		pdev->d3cold_allowed = false;
> +		pci_d3cold_disable(pdev);
> +		pm_runtime_resume(&pdev->dev);

Why do we need to both set d3cold_allowed and call pci_d3cold_disable?

What is the pm_runtime_resume doing here?

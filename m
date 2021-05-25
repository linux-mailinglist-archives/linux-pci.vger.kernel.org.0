Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34083390A5E
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 22:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhEYUQO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 16:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhEYUQO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 May 2021 16:16:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 794A4611C2;
        Tue, 25 May 2021 20:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621973683;
        bh=4eLLwykJYynzNm459FPtdgPrTAnn33wst0rMYCkOU6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HTWN/rIH0T/pNnwNyFsmSHoaGAH/eZSEHCY9TvoNATshqQLMhl0teiRI0WWBpwZqo
         /bmKOorVeE+rogPlzyTi3mzuo1i6tZoD3VOhBOyQ2J5k7/TnqAzex1xGRoLZIrlEDQ
         uvMBuOn0uxShN4BuhRj2xehSEwzm7+9vVc4B6GUk0i4/E6dy5/u7wH86Py7rjVabY9
         mQbeF//j/sHo/wNPcxsvChia0YhPvYUTTY0B4lToMNvXal5v8IrhCaisqCjZU/oGWc
         MFF2zsQSHIQMAOSiSYXJCyp58er5N+OV9f7l6h4Q6i7heSLHa97+XlKvfUAy1phPdK
         XlyyWGG/xw6Xw==
Date:   Tue, 25 May 2021 15:14:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Koba Ko <koba.ko@canonical.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Henrik Juul Hansen <hjhansen2020@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use
 npss.
Message-ID: <20210525201442.GA1223038@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525074426.GA14916@lst.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 25, 2021 at 09:44:26AM +0200, Christoph Hellwig wrote:
> On Thu, May 20, 2021 at 11:33:15AM +0800, Koba Ko wrote:

> > @@ -2958,6 +2959,15 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  
> >  	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
> >  
> > +	if (pm_suspend_via_firmware() || !dev->ctrl.npss ||
> > +	    !pcie_aspm_enabled(pdev) ||
> > +	    dev->nr_host_mem_descs ||
> > +	    (dev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND)) {
> 
> Before we start open coding this in even more places we really want a
> little helper function for these checks, which should be accomodated with
> the comment near the existing copy of the checks.
> 
> > +		pdev->d3cold_allowed = false;
> > +		pci_d3cold_disable(pdev);
> > +		pm_runtime_resume(&pdev->dev);
> 
> Why do we need to both set d3cold_allowed and call pci_d3cold_disable?

Ugh, this looks pretty hard to maintain.

I don't see why setting d3cold_allowed=false is useful.

pci_d3cold_disable() already sets dev->no_d3cold=true, and the only place
we look at d3cold_allowed is pci_dev_check_d3cold():

  if (dev->no_d3cold || !dev->d3cold_allowed || ...)

so we won't even look at d3cold_allowed when no_d3cold is set.

I don't know why we need both no_d3cold and d3cold_allowed in the
first place.  448bd857d48e ("PCI/PM: add PCIe runtime D3cold support")
added them, but without explanation for that.

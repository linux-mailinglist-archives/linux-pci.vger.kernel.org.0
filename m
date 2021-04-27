Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC0A36CB24
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 20:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbhD0Sd5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 14:33:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhD0Sd5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Apr 2021 14:33:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 179A3613EA;
        Tue, 27 Apr 2021 18:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619548393;
        bh=oaKkuyPY/D66iyy2+256QhEioSd9T/D9GzmndqAEGiQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kIVjU5pCyiSXe6LiNKerJ52ZD5ZThXaNLXlgqOjm049FabxHNAvRmJ7fnKAD0ifI4
         fdDlNOHqAr0bhyVnou9XF9QW2AaWIGNqYXwrdiP4YJz1qBs7aeYBZ7focZYVk01pWe
         K2oWG5PJrP7XcaNf4aCsqGO+oswUJQm8T8bbJDlChr/4IJVyNBl6vdzi/VCkmAlRfm
         WN+j9eb8VkdjSminK3jDL0OWLfJC1kBqf0o+14sW+uqeS5mnkcoBmbthANq9RVBEZI
         cIB5lRwYaY5vjBvfLsBjrnStcE357sAopIZ4wkivv7LMoxCStwvOxH5QrH1SxLQo+a
         m4QFBGj9AaE5g==
Date:   Tue, 27 Apr 2021 13:33:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Christian.Koenig@amd.com" <Christian.Koenig@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
Subject: Re: DMA operations by device when device is fake removed using PCI
 sysfs 'remove' interface
Message-ID: <20210427183311.GA121994@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c188623-49ec-a958-1dd1-bdbb1f46987e@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 22, 2021 at 11:05:27AM -0400, Andrey Grodzovsky wrote:
> Hi Bjorn, I am working on graceful device removal on PCI for our amdgppu
> driver. As part of it I am triggering device remove by writing echo 1 >
> /sys/bus/pci/drivers/amdgpu/xxxx:xx:xx.x/remove
> 
> Question - in case there is a DMA operation in flight while I hit the
> 'remove', is there a way to wait for completion of all the DMA operations of
> the device being removed ? Is PCI core taking care of this
> or is there an API we can use to do it in the driver's pci_remove callback ?
> We are concerned with possible system memory corruptions otherwise.

As far as I am aware, the PCI core does not wait for completion of DMA
operations during remove.

The only generic way to do this that I can see would be to clear the
Bus Master Enable bit and then wait on the PCIe Device Status
Transactions Pending bit.  Obviously that would only work for PCIe,
not Conventional PCI.  There is one driver that calls
pci_wait_for_pending_transaction(), in ice_remove().

Bjorn

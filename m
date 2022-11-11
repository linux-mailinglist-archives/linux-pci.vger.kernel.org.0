Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8049662659F
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 00:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiKKXjO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 18:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiKKXjN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 18:39:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F27E2B623;
        Fri, 11 Nov 2022 15:39:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D207FB82836;
        Fri, 11 Nov 2022 23:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB48C433C1;
        Fri, 11 Nov 2022 23:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668209949;
        bh=Vlb+/7QojmhhvH1wfSO9VCLJ7Gp43IqzkXJWqxZOk0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DDta3/Dz1CRlZBWgtSaqjUxwEJCUBrvTLhf6rLi5V6AIPcQoLraYaQN2FK+pXV14N
         sh/2rxaYiZrJRFXkdYH7zi7f3Y7tSJuED20GyZiNYt1rbqOHU6+cJ2rI7UxsGVV5YA
         atztOz3slba/5EuGcfJ9KSx5VWjjZhg+xVd8K/q6ijvWFR3UP1thFKg4Zf8V8xlvzO
         6vH6J1PcvgKA7UDLZkxPEdTcARWY2s3efkbfKwns6MK4xkIhatNqG58rzaWBpJY02m
         P4g3flw86vTnoTs4KhQzqLLviznl5MG/qEbIJDA+Y9sTRsWwEBe07OdlAhZZOQb9/D
         uTdnowRJ99v1Q==
Date:   Fri, 11 Nov 2022 17:39:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Wei Gong <gongwei833x@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221111233907.GA763281@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026060912.173250-1-mst@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 26, 2022 at 02:11:21AM -0400, Michael S. Tsirkin wrote:
> virtio uses the same driver for VFs and PFs.  Accordingly,
> pci_device_is_present is used to detect device presence. This function
> isn't currently working properly for VFs since it attempts reading
> device and vendor ID. As VFs are present if and only if PF is present,
> just return the value for that device.
> 
> Reported-by: Wei Gong <gongwei833x@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied as below to pci/enumeration for v6.2, thanks!

commit 98b04dd0b457 ("PCI: Fix pci_device_is_present() for VFs by checking PF")
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Wed Oct 26 02:11:21 2022 -0400

    PCI: Fix pci_device_is_present() for VFs by checking PF
    
    pci_device_is_present() previously didn't work for VFs because it reads the
    Vendor and Device ID, which are 0xffff for VFs, which looks like they
    aren't present.  Check the PF instead.
    
    Wei Gong reported that if virtio I/O is in progress when the driver is
    unbound or "0" is written to /sys/.../sriov_numvfs, the virtio I/O
    operation hangs, which may result in output like this:
    
      task:bash state:D stack:    0 pid: 1773 ppid:  1241 flags:0x00004002
      Call Trace:
       schedule+0x4f/0xc0
       blk_mq_freeze_queue_wait+0x69/0xa0
       blk_mq_freeze_queue+0x1b/0x20
       blk_cleanup_queue+0x3d/0xd0
       virtblk_remove+0x3c/0xb0 [virtio_blk]
       virtio_dev_remove+0x4b/0x80
       ...
       device_unregister+0x1b/0x60
       unregister_virtio_device+0x18/0x30
       virtio_pci_remove+0x41/0x80
       pci_device_remove+0x3e/0xb0
    
    This happened because pci_device_is_present(VF) returned "false" in
    virtio_pci_remove(), so it called virtio_break_device().  The broken vq
    meant that vring_interrupt() skipped the vq.callback() that would have
    completed the virtio I/O operation via virtblk_done().
    
    [bhelgaas: commit log, simplify to always use pci_physfn(), add stable tag]
    Link: https://lore.kernel.org/r/20221026060912.173250-1-mst@redhat.com
    Reported-by: Wei Gong <gongwei833x@gmail.com>
    Tested-by: Wei Gong <gongwei833x@gmail.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: stable@vger.kernel.org

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9f3cc829dfee..fba95486caaf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6447,6 +6447,8 @@ bool pci_device_is_present(struct pci_dev *pdev)
 {
 	u32 v;
 
+	/* Check PF if pdev is a VF, since VF Vendor/Device IDs are 0xffff */
+	pdev = pci_physfn(pdev);
 	if (pci_dev_is_disconnected(pdev))
 		return false;
 	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);

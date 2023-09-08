Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CC07990DF
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 22:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbjIHULW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 16:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjIHULV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 16:11:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13CDA7;
        Fri,  8 Sep 2023 13:11:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FDFC433C8;
        Fri,  8 Sep 2023 20:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694203866;
        bh=PNgysYno3H1Cwk4d1QkgMgkiUpWYM+j+uutlH71z4Rw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nuJaSGP0cu1NPGrKUDGnFQg7BgNK7xIsEX0D1ToXKT1AojCOlrM2sAIMU1f1OjXeF
         SPnf7NFht7N2F8SNia5VmPBqZJHNCXdqV2c/ntmXZXy0R9PnZbTY46EwtJDedpikrf
         YzhsvYnFc20WecuVjkG8CX3EnKQ0i9w0dZjo1NkYqZOK5EdPpsEoBoVDhp+nzJ5pZi
         ARToLdQxxyvlI6j5Ywe0kWf6AZeMerROmSsTmqSLYTv8xRiOUGPXGUbKmWcmmFFwkD
         StHI3ZIejn1r9DBIQ8z/D7DzummE/Z3FZOp+y7XhmKbI143s0heXdCywFIGVn2AIfp
         oN8+jBV/y3i1g==
Date:   Fri, 8 Sep 2023 15:11:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Wu Zongyong <wuzongyong@linux.alibaba.com>, lukas@wunner.de,
        sdonthineni@nvidia.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        wllenyj@linux.alibaba.com, wutu.xq2@linux.alibaba.com,
        gerry@linux.alibaba.com, pjaroszynski@nvidia.com
Subject: Re: [PATCH] PCI: Mark NVIDIA T4 GPUs to avoid bus reset
Message-ID: <20230908201104.GA305023@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907214037.7f35f26a.alex.williamson@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 07, 2023 at 09:40:37PM -0600, Alex Williamson wrote:
> On Fri, 8 Sep 2023 10:50:48 +0800
> Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> 
> > On Wed, Aug 09, 2023 at 06:05:18PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Apr 10, 2023 at 08:34:11PM +0800, Wu Zongyong wrote:  
> > > > NVIDIA T4 GPUs do not work with SBR. This problem is found when the T4
> > > > card is direct attached to a Root Port only. So avoid bus reset by
> > > > marking T4 GPUs PCI_DEV_FLAGS_NO_BUS_RESET.
> > > > 
> > > > Fixes: 4c207e7121fa ("PCI: Mark some NVIDIA GPUs to avoid bus reset")
> > > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>  
> > > 
> > > Applied to pci/virtualization for v6.6, thanks!  
> > 
> > I talk about the issue with NVIDIA, and they think the issue is probably related
> > the pci link instead of the T4 GPU card.
> > 
> > I will try to describe the issue I met in detail.
> > 
> > The T4 card which is direct attached to a Root Port and I rebind it to
> > vfio-pci driver. Then I try to use to call some vfio-related api and the
> > ioctl VFIO_GROUP_GET_DEVICE_FD failed.
> > 
> > The stack is (base on kernel v5.10):
> >     vfio_group_fops_unl_ioctl
> >          vfio_group_get_device_fd
> >             vfio_pci_open
> >                 vfio_pci_enable // return value is -19
> >                     pci_try_reset_function
> >                         __pci_reset_function_locked
> > 
> > After the __pci_reset_function_locked(), the dmesg shows:
> >    [12207494.508467] pcieport 0000:3f:00.0: pciehp: Slot(5-1): Link Down
> >    [12207494.508535] vfio-pci 0000:40:00.0: No device request channel registered, blocked until released by user
> >    [12207494.518426] pci 0000:40:00.0: Removing from iommu group 84
> >    [12207495.532365] pcieport 0000:3f:00.0: pciehp: Slot(5-1): Card present
> >    [12207495.532367] pcieport 0000:3f:00.0: pciehp: Slot(5-1): Link Up
> > 
> > NVIDIA people thinks this root port is not going through this reset logic and getting the
> > link down/hot plug interrupts[1].
> > 
> > Can you revert the patch I sent and maybe we should dig it deeply.
> 
> Yes, please revert, we do testing with T4 and have not seen any issues
> with bus reset.  The T4 provides neither PM nor FLR reset, so masking
> bus reset compromises this device for assignment scenarios.  I can send
> a revert patch if requested.  Thanks,

Reverted as below.  Hopefully this will make v6.6-rc1.

commit 42f5c40846f3 ("Revert "PCI: Mark NVIDIA T4 GPUs to avoid bus reset"")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Sep 8 14:55:30 2023 -0500

    Revert "PCI: Mark NVIDIA T4 GPUs to avoid bus reset"
    
    This reverts commit d5af729dc2071273f14cbb94abbc60608142fd83.
    
    d5af729dc207 ("PCI: Mark NVIDIA T4 GPUs to avoid bus reset") avoided
    Secondary Bus Reset on the T4 because the reset seemed to not work when the
    T4 was directly attached to a Root Port.
    
    But NVIDIA thinks the issue is probably related to some issue with the Root
    Port, not with the T4.  The T4 provides neither PM nor FLR reset, so
    masking bus reset compromises this device for assignment scenarios.
    
    Revert d5af729dc207 as requested by Wu Zongyong.  This will leave SBR
    broken in the specific configuration Wu tested, as it was in v6.5, so Wu
    will debug that further.
    
    Link: https://lore.kernel.org/r/ZPqMCDWvITlOLHgJ@wuzongyong-alibaba
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 5de09d2eb014..eeec1d6f9023 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3726,7 +3726,7 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
  */
 static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
 {
-	if ((dev->device & 0xffc0) == 0x2340 || dev->device == 0x1eb8)
+	if ((dev->device & 0xffc0) == 0x2340)
 		quirk_no_bus_reset(dev);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,

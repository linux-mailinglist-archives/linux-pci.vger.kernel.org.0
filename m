Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D529E7980AE
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 04:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjIHCu6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Sep 2023 22:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjIHCu5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Sep 2023 22:50:57 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295451BD8;
        Thu,  7 Sep 2023 19:50:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VrauHsx_1694141448;
Received: from localhost(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0VrauHsx_1694141448)
          by smtp.aliyun-inc.com;
          Fri, 08 Sep 2023 10:50:49 +0800
Date:   Fri, 8 Sep 2023 10:50:48 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Wu Zongyong <wuzongyong@linux.alibaba.com>, lukas@wunner.de,
        sdonthineni@nvidia.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        wllenyj@linux.alibaba.com, wutu.xq2@linux.alibaba.com,
        gerry@linux.alibaba.com, pjaroszynski@nvidia.com
Subject: Re: [PATCH] PCI: Mark NVIDIA T4 GPUs to avoid bus reset
Message-ID: <ZPqMCDWvITlOLHgJ@wuzongyong-alibaba>
Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <2dcebea53a6eb9bd212ec6d8974af2e5e0333ef6.1681129861.git.wuzongyong@linux.alibaba.com>
 <20230809230518.GA12130@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809230518.GA12130@bhelgaas>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 09, 2023 at 06:05:18PM -0500, Bjorn Helgaas wrote:
> On Mon, Apr 10, 2023 at 08:34:11PM +0800, Wu Zongyong wrote:
> > NVIDIA T4 GPUs do not work with SBR. This problem is found when the T4
> > card is direct attached to a Root Port only. So avoid bus reset by
> > marking T4 GPUs PCI_DEV_FLAGS_NO_BUS_RESET.
> > 
> > Fixes: 4c207e7121fa ("PCI: Mark some NVIDIA GPUs to avoid bus reset")
> > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> 
> Applied to pci/virtualization for v6.6, thanks!

I talk about the issue with NVIDIA, and they think the issue is probably related
the pci link instead of the T4 GPU card.

I will try to describe the issue I met in detail.

The T4 card which is direct attached to a Root Port and I rebind it to
vfio-pci driver. Then I try to use to call some vfio-related api and the
ioctl VFIO_GROUP_GET_DEVICE_FD failed.

The stack is (base on kernel v5.10):
    vfio_group_fops_unl_ioctl
         vfio_group_get_device_fd
            vfio_pci_open
                vfio_pci_enable // return value is -19
                    pci_try_reset_function
                        __pci_reset_function_locked

After the __pci_reset_function_locked(), the dmesg shows:
   [12207494.508467] pcieport 0000:3f:00.0: pciehp: Slot(5-1): Link Down
   [12207494.508535] vfio-pci 0000:40:00.0: No device request channel registered, blocked until released by user
   [12207494.518426] pci 0000:40:00.0: Removing from iommu group 84
   [12207495.532365] pcieport 0000:3f:00.0: pciehp: Slot(5-1): Card present
   [12207495.532367] pcieport 0000:3f:00.0: pciehp: Slot(5-1): Link Up

NVIDIA people thinks this root port is not going through this reset logic and getting the
link down/hot plug interrupts[1].

Can you revert the patch I sent and maybe we should dig it deeply.

> 
> > ---
> >  drivers/pci/quirks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 44cab813bf95..be86b93b9e38 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3618,7 +3618,7 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
> >   */
> >  static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
> >  {
> > -	if ((dev->device & 0xffc0) == 0x2340)
> > +	if ((dev->device & 0xffc0) == 0x2340 || dev->device == 0x1eb8)
> >  		quirk_no_bus_reset(dev);
> >  }
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> > -- 
> > 2.34.3
> > 

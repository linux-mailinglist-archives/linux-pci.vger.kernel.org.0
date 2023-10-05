Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62397BAEA3
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 00:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjJEWKx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 18:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjJEWKw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 18:10:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCA6D8;
        Thu,  5 Oct 2023 15:10:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB93C433C7;
        Thu,  5 Oct 2023 22:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696543851;
        bh=UoU4cn3m/iQDeTvZ6sJCJc+J83ON7noH/i6xOi4WLLw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N+1tqzKxM8k5U6oPZNf+PbjiiKdMm854tLVYikTTC5eIDDeVyg+N+NTEIrli6XAe9
         AYJvP4opqpuj/fwoMKh9l3oTV2QNACLfQNXHsca4VUbGX/t7yMWk1ahpiMV16G3KI2
         gVxDw5TYrM003BVXZYcEqNJi6Vf6nVXVw44yULSR14G2i/UPDrXwH3zM2QxvlfqlaT
         vKWPyNRZK4xcdUICXbjPso4zu+95Lit1pfcb3uTNBnaEqfpU0++MC6xignIlkdGzMh
         lJLcoGIjhWwBePNWlzuSPrTtXJkEPpJFxq3ht7XnhWrObZP78PjziFHLMjYQ0GcThX
         Ikd5tEHIkCbqA==
Date:   Thu, 5 Oct 2023 17:10:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Sui Jingfeng <suijingfeng@loongson.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [-next 4/5] drm/virgpu: Switch to pci_is_vga()
Message-ID: <20231005221049.GA793091@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005215714.GA792609@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 05, 2023 at 04:57:14PM -0500, Bjorn Helgaas wrote:
> In subject: "drm/virtio" to match previous history.
> 
> On Wed, Aug 30, 2023 at 07:15:31PM +0800, Sui Jingfeng wrote:
> > From: Sui Jingfeng <suijingfeng@loongson.cn>
> > 
> > Should be no functional change, just for cleanup purpose.
> > 
> > Cc: David Airlie <airlied@redhat.com>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: Gurchetan Singh <gurchetansingh@chromium.org>
> > Cc: Chia-I Wu <olvaffe@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > index add075681e18..3a368304475a 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > @@ -51,7 +51,7 @@ static int virtio_gpu_pci_quirk(struct drm_device *dev)
> >  {
> >  	struct pci_dev *pdev = to_pci_dev(dev->dev);
> >  	const char *pname = dev_name(&pdev->dev);
> > -	bool vga = (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
> > +	bool vga = pci_is_vga(pdev);
> 
> This *is* a functional change: Previously "vga" was only true for
> PCI_CLASS_DISPLAY_VGA (0x0300).  Now it will be true for both
> PCI_CLASS_DISPLAY_VGA (0x0300) and PCI_CLASS_DISPLAY_OTHER (0x0380).

Oops, sorry, my mistake here.  I meant PCI_CLASS_NOT_DEFINED_VGA, not
PCI_CLASS_DISPLAY_OTHER.  pci_is_vga() is true for either of:

  PCI_CLASS_DISPLAY_VGA       0x0300
  PCI_CLASS_NOT_DEFINED_VGA   0x0001

(PCI_CLASS_NOT_DEFINED_VGA is defined in the PCI Code and Assignment
spec r1.15, sec 1.1; PCI_CLASS_DISPLAY_VGA is sec 1.4.)

> Is that desirable?  I can't tell.  Maybe the GPU folks will chime in.
> 
> >  	int ret;
> >  
> >  	DRM_INFO("pci: %s detected at %s\n",
> > -- 
> > 2.34.1
> > 

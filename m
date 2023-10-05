Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8527BAE3D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 23:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjJEV5T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 17:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJEV5T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 17:57:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7A1DB;
        Thu,  5 Oct 2023 14:57:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2377FC433C7;
        Thu,  5 Oct 2023 21:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696543036;
        bh=vaHJxIHe4zRt2ghkUleXPakGs+EDbrcTc1rXqc3MsKg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KAE6vQh542k4VeuofajcdFNi7UAR0AHGTAwk6fcvUpWM5DwqusqTcyZnRQoWRSIR0
         wYjFVNuURnB1QjY/Qb9DF6Diq7rsAUmimE/zSlLYtW3USLdRgg3FEQIf6bVS/XGpfO
         I3WqidB3O7HNh59ixD49Rii8SrxWj9EhBNVYvMMhwFTMyWgl96grV8AbY0IkP+GTR+
         jU+Fo0j6zuMdYCTgMoYsXStu3ZbFLm8B7bomR77EVstC3H4dxtITqujpsNzF8Gf/D4
         hH+2Q9BqVILErLxtzHhW2TlCJLG7E/Z7A4yUhP7cErgkT0vFZqzp1dSM9sBTqlO04S
         +7f70D4DMQ42A==
Date:   Thu, 5 Oct 2023 16:57:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        David Airlie <airlied@redhat.com>
Subject: Re: [-next 4/5] drm/virgpu: Switch to pci_is_vga()
Message-ID: <20231005215714.GA792609@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830111532.444535-5-sui.jingfeng@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject: "drm/virtio" to match previous history.

On Wed, Aug 30, 2023 at 07:15:31PM +0800, Sui Jingfeng wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> Should be no functional change, just for cleanup purpose.
> 
> Cc: David Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Gurchetan Singh <gurchetansingh@chromium.org>
> Cc: Chia-I Wu <olvaffe@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index add075681e18..3a368304475a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -51,7 +51,7 @@ static int virtio_gpu_pci_quirk(struct drm_device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  	const char *pname = dev_name(&pdev->dev);
> -	bool vga = (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
> +	bool vga = pci_is_vga(pdev);

This *is* a functional change: Previously "vga" was only true for
PCI_CLASS_DISPLAY_VGA (0x0300).  Now it will be true for both
PCI_CLASS_DISPLAY_VGA (0x0300) and PCI_CLASS_DISPLAY_OTHER (0x0380).

Is that desirable?  I can't tell.  Maybe the GPU folks will chime in.

>  	int ret;
>  
>  	DRM_INFO("pci: %s detected at %s\n",
> -- 
> 2.34.1
> 

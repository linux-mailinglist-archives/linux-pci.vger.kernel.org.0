Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B0160E272
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbiJZNrD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiJZNq3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 09:46:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0797FF9D;
        Wed, 26 Oct 2022 06:46:17 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso2519930pjz.4;
        Wed, 26 Oct 2022 06:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DS94dEp0e9NHK0r6We47z3gX45ynSmkIbkLaicVI9l8=;
        b=GJUIllsYCyg7dI68FJOGWGtr4l/6Trz8Lgcs6kGbfQH+nB7VbuwI/iOdDzGkVFVOYL
         B+lLtiJRg97boon6rTFBdW83CqYzJ+xCVcYXbREI6gVkCh+EbHAVgIGHhHYlmmLm0YpH
         jfcMZqQLvuxM5NFomgpSGYBi9Ut2kb0ivhuo6IJYPhH1mswhSej7SV9ycA07TsO2ycbu
         Bpzh0z/Hw4S6FNGdGFGQZtuE/wJY360jRt8iXpXHAk0XBTI4vfSYobBTjlscK2tKJHYK
         GyS5e3+DvZXpM+EHqXT3Jo0Gvg12ENDTFalQd0yqNIlrvbWaC+in/SCi1BR9Sfo2Wt1u
         hovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DS94dEp0e9NHK0r6We47z3gX45ynSmkIbkLaicVI9l8=;
        b=DiZlL0RjaqSdStKvjyH3dC8E8zAeCQvzTG/oHAIm5gZTRoFjB1lDW4f7ws5eqggk1x
         Dg3iYyBi8tSohSYID0v2RYpan1f5aKhyZaskaXzq54qZe74FIGxr5vSGUJXsOvPZc55K
         Zr1sutP1gp7Rzvz0BdGFjikl1E0rYe9W4i/wU+cRQK+IjUhVfQL/T8S4iRcF2eL4n64f
         otee9K6/Jmq9R/d4Js8gWtyHtsgv4oJ2tJxVUxmhOnJ2rJq7h1jDmApFE91zeNqffPXG
         vmUVjYD5MDOwPps2m0htYIwJjhzA5Ktvwi8SAD29suqTGNCNxdRdvTaWFRVR62Hp4ywM
         ag7Q==
X-Gm-Message-State: ACrzQf2uQE9mVbjYZwaQgDiV+1QefjL6ZrwDcly6wfwUwyyUAgy7Zjkd
        zTRKg3FDmMppqQNQw++KfWw=
X-Google-Smtp-Source: AMsMyM7s9x2+PNH3mrIKPeaHjt5Mzs/LCp1QFpv+GIrWqv5NSrC00ilnlFZ6ZnCZFFGbTQolmwXB2g==
X-Received: by 2002:a17:90a:588a:b0:212:fa50:7dec with SMTP id j10-20020a17090a588a00b00212fa507decmr4404836pji.190.1666791976561;
        Wed, 26 Oct 2022 06:46:16 -0700 (PDT)
Received: from localhost ([36.152.119.226])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ce8c00b001869f2120a4sm2945132plg.94.2022.10.26.06.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:46:16 -0700 (PDT)
Date:   Wed, 26 Oct 2022 13:46:11 +0000
From:   Wei Gong <gongwei833x@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221026134611.GA361392@zander>
References: <20221026060912.173250-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026060912.173250-1-mst@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Tested-by: Wei Gong <gongwei833x@gmail.com>

> ---
> 
> Wei Gong, thanks for your testing of the RFC!
> As I made a small change, would appreciate re-testing.

I updated your change and retested in my environment.
It worked well and fixed my problem.

> 
> Thanks!
> 
> changes from RFC:
> 	use pci_physfn() wrapper to make the code build without PCI_IOV
> 
> 
>  drivers/pci/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 2127aba3550b..899b3f52e84e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6445,8 +6445,13 @@ bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
>  
>  bool pci_device_is_present(struct pci_dev *pdev)
>  {
> +	struct pci_dev *physfn = pci_physfn(pdev);
>  	u32 v;
>  
> +	/* Not a PF? Switch to the PF. */
> +	if (physfn != pdev)
> +		return pci_device_is_present(physfn);
> +
>  	if (pci_dev_is_disconnected(pdev))
>  		return false;
>  	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
> -- 
> MST
> 

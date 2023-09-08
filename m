Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1F2798103
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 05:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbjIHDlb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Sep 2023 23:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjIHDlb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Sep 2023 23:41:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440CE1BD8
        for <linux-pci@vger.kernel.org>; Thu,  7 Sep 2023 20:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694144443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cwYR0/Qm2VVNI1B/P7BIC9YTst/KBlfH4kIWfjIj5gE=;
        b=K4f6If2FiGHKFTE4NWmr2qawmoEa+YJ4hp3Nfruba4P8h6vXw7UU7F2zs6OhgPteXPhuk4
        EFnbJjLXHSABFDepIn+5F7HprCuu8AX92PY2aGrUN6KsTwEFk10q4cp14SzbC1s9EH1D4s
        yw7nrAFueCRKF7yqtlY/J7MDLxb/5ng=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-MICPzsUAOx2MkIE264zcrA-1; Thu, 07 Sep 2023 23:40:41 -0400
X-MC-Unique: MICPzsUAOx2MkIE264zcrA-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-34670b3089dso14354605ab.1
        for <linux-pci@vger.kernel.org>; Thu, 07 Sep 2023 20:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694144440; x=1694749240;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwYR0/Qm2VVNI1B/P7BIC9YTst/KBlfH4kIWfjIj5gE=;
        b=THY7pL4Bap+6u7sI3Cy1PfDseQIK+ndKZK+DqhmVXb4pQNmUNboIKXzfPEog7jGg8u
         BYUoZrXskH9h2ZCYzvB7Aw4DW4WiKMEyl5M2OYMuEtqT/Mhv6KhCYorP+u6XFZTFpjyO
         kgSmOczuEvMiABj/0oMnovwD2H0YyvFBg7rZhg8Vc+vcWwWB3JpxZzRHz3PUAp04KCEk
         HyyaBpIwvs/dbMK4NgdkjTuygV43xOa3Ehhx1WoqMCc97igy6wwiR7nNzT++P3AYa8SO
         wOjGEM8JYtjLmQMhwsU8RMklSt3owmBpO6LjbcsE1sjYr+NUBBnOacik5Uv82PlI/Tsi
         Alvg==
X-Gm-Message-State: AOJu0YxDZPEzBLRt38hEVQQl/S5AC6BzH3Nhco6VasFV+r9i8CSrypnC
        HfbjKqtoD0thoA2D443O9B0XQBrAVVX1KzM6VNOTNRlwfVJWgmb7s/zaJlvYdyt73lV3ZorMIbU
        KvhUoAkPq0YD7gYnbR4hGd3sjszs3
X-Received: by 2002:a05:6e02:1543:b0:34f:20d9:74a9 with SMTP id j3-20020a056e02154300b0034f20d974a9mr4455025ilu.11.1694144440318;
        Thu, 07 Sep 2023 20:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBJXnjAjKKvqNPoWU0cFG4wqyOH3Mgi6EwXX9rE6gxuLa5hWqDwWfJkmoq1YaVnMpZdduoGg==
X-Received: by 2002:a05:6e02:1543:b0:34f:20d9:74a9 with SMTP id j3-20020a056e02154300b0034f20d974a9mr4455014ilu.11.1694144440062;
        Thu, 07 Sep 2023 20:40:40 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id u21-20020a02aa95000000b0042b2d43ee3fsm223438jai.82.2023.09.07.20.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 20:40:39 -0700 (PDT)
Date:   Thu, 7 Sep 2023 21:40:37 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, lukas@wunner.de,
        sdonthineni@nvidia.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        wllenyj@linux.alibaba.com, wutu.xq2@linux.alibaba.com,
        gerry@linux.alibaba.com, pjaroszynski@nvidia.com
Subject: Re: [PATCH] PCI: Mark NVIDIA T4 GPUs to avoid bus reset
Message-ID: <20230907214037.7f35f26a.alex.williamson@redhat.com>
In-Reply-To: <ZPqMCDWvITlOLHgJ@wuzongyong-alibaba>
References: <2dcebea53a6eb9bd212ec6d8974af2e5e0333ef6.1681129861.git.wuzongyong@linux.alibaba.com>
        <20230809230518.GA12130@bhelgaas>
        <ZPqMCDWvITlOLHgJ@wuzongyong-alibaba>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 8 Sep 2023 10:50:48 +0800
Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:

> On Wed, Aug 09, 2023 at 06:05:18PM -0500, Bjorn Helgaas wrote:
> > On Mon, Apr 10, 2023 at 08:34:11PM +0800, Wu Zongyong wrote:  
> > > NVIDIA T4 GPUs do not work with SBR. This problem is found when the T4
> > > card is direct attached to a Root Port only. So avoid bus reset by
> > > marking T4 GPUs PCI_DEV_FLAGS_NO_BUS_RESET.
> > > 
> > > Fixes: 4c207e7121fa ("PCI: Mark some NVIDIA GPUs to avoid bus reset")
> > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>  
> > 
> > Applied to pci/virtualization for v6.6, thanks!  
> 
> I talk about the issue with NVIDIA, and they think the issue is probably related
> the pci link instead of the T4 GPU card.
> 
> I will try to describe the issue I met in detail.
> 
> The T4 card which is direct attached to a Root Port and I rebind it to
> vfio-pci driver. Then I try to use to call some vfio-related api and the
> ioctl VFIO_GROUP_GET_DEVICE_FD failed.
> 
> The stack is (base on kernel v5.10):
>     vfio_group_fops_unl_ioctl
>          vfio_group_get_device_fd
>             vfio_pci_open
>                 vfio_pci_enable // return value is -19
>                     pci_try_reset_function
>                         __pci_reset_function_locked
> 
> After the __pci_reset_function_locked(), the dmesg shows:
>    [12207494.508467] pcieport 0000:3f:00.0: pciehp: Slot(5-1): Link Down
>    [12207494.508535] vfio-pci 0000:40:00.0: No device request channel registered, blocked until released by user
>    [12207494.518426] pci 0000:40:00.0: Removing from iommu group 84
>    [12207495.532365] pcieport 0000:3f:00.0: pciehp: Slot(5-1): Card present
>    [12207495.532367] pcieport 0000:3f:00.0: pciehp: Slot(5-1): Link Up
> 
> NVIDIA people thinks this root port is not going through this reset logic and getting the
> link down/hot plug interrupts[1].
> 
> Can you revert the patch I sent and maybe we should dig it deeply.

Yes, please revert, we do testing with T4 and have not seen any issues
with bus reset.  The T4 provides neither PM nor FLR reset, so masking
bus reset compromises this device for assignment scenarios.  I can send
a revert patch if requested.  Thanks,

Alex

> > > ---
> > >  drivers/pci/quirks.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 44cab813bf95..be86b93b9e38 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -3618,7 +3618,7 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
> > >   */
> > >  static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
> > >  {
> > > -	if ((dev->device & 0xffc0) == 0x2340)
> > > +	if ((dev->device & 0xffc0) == 0x2340 || dev->device == 0x1eb8)
> > >  		quirk_no_bus_reset(dev);
> > >  }
> > >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> > > -- 
> > > 2.34.3
> > >   
> 


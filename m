Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44346621B64
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 19:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiKHSDh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 13:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiKHSDg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 13:03:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11F150F2C
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 10:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667930563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X/6YPcfQ3OHCxcTVYe00PAa4barWuyYRCkyxGpkjxyY=;
        b=IKhn8EFDGQ6vFiMq5oSNSmc29Tj2F1Hq8CQTPPoJCiC3h2FSHE2Je5zSaCSvLUj8rZPyLi
        gRYPH8xKOdj/eY7oZG63e2cuJz8ytoYUb/pJgqXX6fD1wHwHbbHf5qDaW0l350Y4RN66aX
        xxk/EfY3X3d99aXsoxcoEoq66IdgTb8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-373-r8uuwHhpPlSDqHBQTh7MDw-1; Tue, 08 Nov 2022 13:02:41 -0500
X-MC-Unique: r8uuwHhpPlSDqHBQTh7MDw-1
Received: by mail-qt1-f200.google.com with SMTP id cd6-20020a05622a418600b003a54cb17ad9so10766591qtb.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Nov 2022 10:02:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/6YPcfQ3OHCxcTVYe00PAa4barWuyYRCkyxGpkjxyY=;
        b=GPUkobnLodnUEh5hx2CnEJnzH5Zo+o3vPFXcvYnr8Y6iejIX4Nfk+fJCB/hs1W6UeZ
         jj6mWw+eG8rQ4RFqNZz0xSSn0uyaLGo3E0YmQWJICoxTzdl4PD5yU1hARwYXTk9ZRvVv
         nCZbrdc/slJWRUvu8GX5GEPQW3RTnkJwoX1aKCzyiGH5OOcspGpKCEnY6jZ4fhDrkYOy
         mpxlBnbBsdFMJAXAoVF/atoXilqU55ei9VwS/zEbtc6zahNzibQ9t9IrT30H+F+Awtgx
         KnhpOIkwOEtMFcxlleV/gW5k54eU8Dd0kahWuikhmIdll/jn2iLB+BE84YuOpPl2LeRr
         l0NA==
X-Gm-Message-State: ACrzQf1L9lOcvXJVAb42O2urOSaQmxrwmYpsEJZm0bRZRgrbBjAp0TNe
        hzKzJNpyO2PARbjSbyj4gIR2yMw2n2DElkCC1mkpYpo2O+8m5Lh44uj9U3aMF8bQ/JzscjqtuKj
        VQmjeP8vLhzs5RLF3j5Hj
X-Received: by 2002:ac8:785:0:b0:3a5:46b0:ffd7 with SMTP id l5-20020ac80785000000b003a546b0ffd7mr26189393qth.632.1667930560885;
        Tue, 08 Nov 2022 10:02:40 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4eVKiHfOBQwciLJy4AwZpVqIFR506igUyNWrvRf/5jIesFD5LUP07eh3jEWVya/YWWbgFORA==
X-Received: by 2002:ac8:785:0:b0:3a5:46b0:ffd7 with SMTP id l5-20020ac80785000000b003a546b0ffd7mr26189363qth.632.1667930560614;
        Tue, 08 Nov 2022 10:02:40 -0800 (PST)
Received: from redhat.com ([185.195.59.50])
        by smtp.gmail.com with ESMTPSA id l21-20020a37f915000000b006fa9d101775sm9815931qkj.33.2022.11.08.10.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:02:40 -0800 (PST)
Date:   Tue, 8 Nov 2022 13:02:35 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Wei Gong <gongwei833x@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221108130203-mutt-send-email-mst@kernel.org>
References: <20221108101209-mutt-send-email-mst@kernel.org>
 <20221108175853.GA484920@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108175853.GA484920@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 08, 2022 at 11:58:53AM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 08, 2022 at 10:19:07AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Nov 08, 2022 at 09:02:28AM -0600, Bjorn Helgaas wrote:
> > > On Tue, Nov 08, 2022 at 08:53:00AM -0600, Bjorn Helgaas wrote:
> > > > On Wed, Oct 26, 2022 at 02:11:21AM -0400, Michael S. Tsirkin wrote:
> > > > > virtio uses the same driver for VFs and PFs.  Accordingly,
> > > > > pci_device_is_present is used to detect device presence. This function
> > > > > isn't currently working properly for VFs since it attempts reading
> > > > > device and vendor ID.
> > > > 
> > > > > As VFs are present if and only if PF is present,
> > > > > just return the value for that device.
> > > > 
> > > > VFs are only present when the PF is present *and* the PF has VF Enable
> > > > set.  Do you care about the possibility that VF Enable has been
> > > > cleared?
> 
> I think you missed this question.

I was hoping Wei will answer that, I don't have the hardware.

> > > Can you also include a hint about how the problem manifests, and a URL
> > > to the report if available?
> > 
> > Here you go:
> > lore.kernel.org/all/20221108044819.GA861843%40zander/t.mbox.gz
> > 
> > is it enough to include this link or do you want me
> > to repost copying the text from there?
> 
> Uh, well, OK, I guess I could dig through that and figure what what's
> relevant.  I'd like the commit log to contain a hint of what the
> problem looks like and some justification for why it should be
> backported to stable.
> 
> I still look at Documentation/process/stable-kernel-rules.rst
> occasionally to decide things like this, but I get the feeling that
> it's a little out-of-date and more restrictive than current practice.
> 
> But I do think the "PF exists but VF disabled" situation needs to be
> clarified somehow, too.
> 
> Bjorn


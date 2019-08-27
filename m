Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05FAD9F1FA
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 20:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfH0SBS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 14:01:18 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40670 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0SBR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 14:01:17 -0400
Received: by mail-yw1-f68.google.com with SMTP id z64so8196451ywe.7
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2019 11:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=buRd+oaYTniBe098opDcjSma8LR23N54U7H6uBYOk28=;
        b=NBEZ1XptxSKUz1z0TH3DnNeYuNzrjdDvrIqpIsyOdkWR1qilCZew88ogpUNAZl598D
         XIx4f8EQU2etJVEKNV8PJuH44DTZ2K5Ie8WrQK/buvYnNUQNC2OPdB6VYEReG1fMc24m
         B575wuW4rV51rfz7FcyhND/KemilkRxByI+uz2MKXAJf1ZeXGge3pVxeukXic7/iiqyR
         s/IApE8/XPIsGu+OthvMeKOSZ8WzlX7zDXtb+AQY2BR+coQZiEXC33fNFq2G1RY6dOIT
         oXRzZ59oiAK1Kg85nbJomzCX5LaQN1c2VFSsnugjPPy8sNp+e4h1dKgxhdS2YQDv93Gf
         IcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=buRd+oaYTniBe098opDcjSma8LR23N54U7H6uBYOk28=;
        b=DozAY7YezR6Xl79XgEM4Lcnag6G930/Us8bWEIS+Kp4P6Ct0VCZ99zeZW6EksACTwW
         AFgFjQIjlpyCK5kkmdA0qkRtMksxSNQ3555ufGe1ECU5272WOboatEHogpcu4pu+sApX
         zbVBNyz7Dw87+kIAQKhuH2DqhaQolfd5rokTBRIGhlOoZxtwY3NHyhZQ2VBbnjd8Ybpa
         EHATSLEvyPlSFb6DOhvI22clEyroBjY1R76C68XnCgK3LGx2G54Ns10hkHBQM2cPH/YE
         yrUf1cwyYXNYzMAVDc/OCcjjGnSZ4KYdfq7Awv/1+ahSQfB05chZNkcPwbo/U035OaNf
         mQRg==
X-Gm-Message-State: APjAAAUS8rYzcxa71DvuZ0gP0nicDCyeo2rKRM9jB+j29oIM4CdxdHuN
        IiV/63fqcZQrtOZ4fEj7+xKS6A==
X-Google-Smtp-Source: APXvYqyGs7zSbCiHYXBhl+PwQTlmoQwUJvXULrhhIj4PQBor38VhVFPYMVwSYToPtJrNJvKuVV/K+w==
X-Received: by 2002:a81:4854:: with SMTP id v81mr133927ywa.412.1566928876193;
        Tue, 27 Aug 2019 11:01:16 -0700 (PDT)
Received: from jaxon.localdomain ([152.3.43.56])
        by smtp.gmail.com with ESMTPSA id z9sm3121956ywj.84.2019.08.27.11.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 11:01:15 -0700 (PDT)
From:   Haotian Wang <haotian.wang@sifive.com>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     mst@redhat.com, jasowang@redhat.com, linux-pci@vger.kernel.org,
        haotian.wang@duke.edu
Subject: Re: [PATCH] pci: endpoint: functions: Add a virtnet EP function
Date:   Tue, 27 Aug 2019 14:01:14 -0400
Message-Id: <20190827180114.5979-1-haotian.wang@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <442f91a5-be7f-c4c2-dd24-81c510aab86b@ti.com>
References: <442f91a5-be7f-c4c2-dd24-81c510aab86b@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On Tue, Aug 27, 2019 at 4:13 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>> +CONFIG_PCI_HOST_LITTLE_ENDIAN must be set at COMPILE TIME. Toggle it on to build
> >>> +the module with the PCI host being in little endianness.
> >> It would be better if we could get the endianness of the host at runtime. That
> >> way irrespective of the host endianness we could use the same kernel image in
> >> endpoint.
> > There are two ways I can imagine of achieving this. The first is to
> > change the whole endpoint function into using modern virtio interfaces,
> > because those specify little endianness to be used in all of __virtio16,
> > __virtio32 etc. I didn't take that path because the development platform
> > did not allow me to access some PCI configuration space registers, such
> > as the vendor-specific capabilities. These were required to configure a
> > virtio_device representing the PCI host.
> 
> I would prefer this approach.
> Do you need any vendor specific capabilities for virtio_device?
The virtio modern interfaces write addresses of virtqueues, queue
selections and some other important notification into the
vendor-specific capabilities chain registers, while the legacy
interfaces simply write to some offset of address stored in BAR 0.

> >>> +/*
> >>> + * Initializes the virtio_pci and virtio_net config space that will be exposed
> >>> + * to the remote virtio_pci and virtio_net modules on the PCI host. This
> >>> + * includes setting up feature negotiation and default config setup etc.
> >>> + *
> >>> + * @epf_virtio: epf_virtio handler
> >>> + */
> >>> +static void pci_epf_virtio_init_cfg_legacy(struct pci_epf_virtio *epf_virtio)
> >>> +{
> >>> +	const u32 dev_feature =
> >>> +		generate_dev_feature32(features, ARRAY_SIZE(features));
> >>> +	struct virtio_legacy_cfg *const legacy_cfg = epf_virtio->reg[BAR_0];
> >>
> >> virtio_reg_bar instead of BAR_0
> > The dilemma was that the virtio_pci on PCI host will only write to BAR
> > 0. I may need to throw an error if the first free bar is not BAR 0.
> 
> hmm.. We need a better way to handle it. Just having
> PCI_VENDOR_ID_REDHAT_QUMRANET in virtio_pci may not be sufficient then.
Sorry I did not get the connection between these two issues. One is
about the bar number used, the other is about satisfying the triggering
the probe function of virtio_pci on the host side.

As a reference, the code on the host side legacy probe is:

vp_dev->ioaddr = pci_iomap(pci_dev, 0, 0);
if (!vp_dev->ioaddr)
	goto err_iomap;

That's why only BAR 0 is used.

> >> Please add a description for each of these structures.
> > I had to copy these structures exactly as they were from virtio_ring.c
> > unfortunately, because they were not exposed via any header file. If
> > virtio_ring.c has some struct changes, this endpoint function will have
> > to change accordingly.
> 
> Some of the structures are exposed in virtio_ring.h. We probably need to use
> that instead of using the structures from virtio_ring.c.
struct vring_virtqueue is not present in include/linux/virtio_ring.h or
include/uapi/linux/virtio_ring.h. struct virtnet_info is not present in
include/linux/virtio_net.h or include/uapi/linux/virtio_net.h. These two
structures are only present in .c files, but they are necessary to this
endpoint function.

vring_virtqueue is a critical struct used by virtio_ring, and epf_virtio
relies entirely on the vanilla virtio_ring for doing its work. Therefore
all the memory allocation and field offsets must be exactly the same. I
do not see an easy solution to this.

virtnet_info on the other hand is used in only one line in epf_virtio:

netdev = ((struct virtnet_info *)epf_vdev->vdev.priv)->dev;
while (!(READ_ONCE(netdev->flags) & IFF_UP))
	schedule();

The local virtual net_device is created by virtio_net and the only way
to access it is through virtnet_info. I need this net_device because I
cannot start handling the two transfer handler threads before the
net_device is brought up by `ifconfig eth0 up` in the userspace on the
endpoint.

> Great work in attempting to add virtnet driver.
> How many hours are you planning to spend working on kernel? I'm interested in
> seeing this completed and getting merged in kernel.
Thank you! Honestly I cannot give an exact number of hours I can work.
One reason is because now I have to deal with some school stuff. The
other is simply that I do not have access to the FPGA anymore. I may
have to rely on the goodwill of colleagues to do the testing on hardware
for me. That's why I am a bit unsure about how to make major changes to
the patch, such as modifying vhost, adding more layers, or switching to
virtio modern interfaces (which will probably require talking to the
hardware team at my previous company).

> > Thank you so much for taking time to review this patch. Now that I came
> > back to university and continued my undergrad study, my kernel
> > development work will probably slow down a lot. The heavy-lifting work
> 
> Good luck with your studies :-)
Thank you so much! Good luck with your work.

What's your feedback on the dma engine?

Cheers,
Haotian

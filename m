Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CA03F7DB1
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 23:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhHYV0S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 17:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232906AbhHYV0P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Aug 2021 17:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629926728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a8WjHoFBXc0jwAZ/Pzv1m1K7J4OWtNmWsJJuNT1URQ8=;
        b=U3LUOgGwsbOFZQ1PNqBh0/0Nza3r9tFgbqKLgmzl7e6xnUoR+jmIZSOKyT6YXdxdTZqR6p
        IzsgROSabeyytiVUrL8XTH/Qj8NeU0zHiUJ+QCnhi953PdhViHrlghuUGeofeK6clZgbJx
        fDV+bDD3KE/11hgi0zi9KoTshxR1bcY=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-iYVvofx3Pzq23RX-ErWGhg-1; Wed, 25 Aug 2021 17:25:27 -0400
X-MC-Unique: iYVvofx3Pzq23RX-ErWGhg-1
Received: by mail-oo1-f69.google.com with SMTP id v9-20020a4ae6c9000000b0029003c3f017so292454oot.23
        for <linux-pci@vger.kernel.org>; Wed, 25 Aug 2021 14:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=a8WjHoFBXc0jwAZ/Pzv1m1K7J4OWtNmWsJJuNT1URQ8=;
        b=hX5sPUTQI06Y5taNOiY6+gd0n6yXjIdPYIaF5rF6VvDI51sERJPJPsAKyG1djfsGRE
         LLy2md6weH1i9YEYkx9vM5RZ8qujPg4wEruF2Ie8Vf6o6yH5N5p1baaWJKa3cjRK47IM
         rlseyn2clRe2raCXjmRQbhyG/sGJDeqABDO4y+EyDJ2eYT6XY5TC8doRyRlcXv8+3pBa
         l4eysfkTvOEQ0KT3M5T0mrR6z79yk0Ote5EIoOy09fDOi1rek/7zfXYSyE5BSZIxCzZo
         9gv6714d9vTodGjHT7BRTFi/Af2kYRnEurIL/wpKXOaVDWldcYLbKfuoXev3reVHT0qH
         lHwg==
X-Gm-Message-State: AOAM530G4o+qB2HG3FWmEh5DBkmUTfyFHMHnuhdajIaTCrz3oB0Af8V8
        aCmR0Eh0de/nZS9n8Fl4G/fzrLzIi2XneAHqQNWSbCa/1IYdap0LR12f7vckZGxQgefBI5bb0BM
        kH3qkZwV1U80xLK0fr5Hp
X-Received: by 2002:aca:59c6:: with SMTP id n189mr8927966oib.44.1629926726455;
        Wed, 25 Aug 2021 14:25:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2TQ0tVP/G/91e1rsMJxtfNj9JdiJU9bbsFApswvKRzxaqgLUrbQuFPpCCzIEKetVt2wAhqA==
X-Received: by 2002:aca:59c6:: with SMTP id n189mr8927948oib.44.1629926726248;
        Wed, 25 Aug 2021 14:25:26 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id y7sm178910oov.36.2021.08.25.14.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 14:25:25 -0700 (PDT)
Date:   Wed, 25 Aug 2021 15:25:24 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yishai Hadas <yishaih@nvidia.com>, bhelgaas@google.com,
        corbet@lwn.net, diana.craciun@oss.nxp.com, kwankhede@nvidia.com,
        eric.auger@redhat.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kbuild@vger.kernel.org,
        mgurtovoy@nvidia.com, jgg@nvidia.com, maorg@nvidia.com,
        leonro@nvidia.com
Subject: Re: [PATCH V4 09/13] PCI: Add 'override_only' field to struct
 pci_device_id
Message-ID: <20210825152524.45437035.alex.williamson@redhat.com>
In-Reply-To: <20210825155446.GA3575423@bjorn-Precision-5520>
References: <20210825135139.79034-10-yishaih@nvidia.com>
        <20210825155446.GA3575423@bjorn-Precision-5520>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 25 Aug 2021 10:54:46 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Aug 25, 2021 at 04:51:35PM +0300, Yishai Hadas wrote:
> > From: Max Gurtovoy <mgurtovoy@nvidia.com>
> > 
> > Add 'override_only' field to struct pci_device_id to be used as part of
> > pci_match_device().
> > 
> > When set, it means that matching is true only when dev->driver_override
> > is this driver.  
> 
> Maybe:
> 
>   When set, a driver only matches the entry when dev->driver_override
>   is set to that driver.

I've made this change locally, thanks Bjorn.

Alex

> 
> > In addition, add a helper macro named 'PCI_DEVICE_DRIVER_OVERRIDE' to
> > enable setting some data on it.
> > 
> > Next patch from this series will use the above functionality.
> > 
> > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>  
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>


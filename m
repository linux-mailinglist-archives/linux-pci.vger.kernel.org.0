Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F053C6658
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 00:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhGLW1d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 18:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24904 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229725AbhGLW1d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 18:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626128683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=drKUA4nwMjP/GDMz9npESW8OtIE/cQEPCzkNW7Et1q8=;
        b=Z2GYGFNY9S+vXnQ08g0268zMHu1FrExJb6lGdwvWlXGjLOteVUG2b6+Hj59joOQzvCRK9p
        vgcyajGJJvubZw4EIWXnGn+YeVpkQ7QpIr34qE0tSYeoGVPmDx2E1WlUWUVALj7iW8pE5k
        AbcwIXjwzaiMaj/Ihoc/9gDciroQDs8=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-WUCMiwXvPligrNBLOf5sRQ-1; Mon, 12 Jul 2021 18:24:42 -0400
X-MC-Unique: WUCMiwXvPligrNBLOf5sRQ-1
Received: by mail-ot1-f69.google.com with SMTP id g3-20020a9d6c430000b02904b65ff39c8cso9088223otq.4
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 15:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drKUA4nwMjP/GDMz9npESW8OtIE/cQEPCzkNW7Et1q8=;
        b=iWeb3Wub2gIAwoI6X70MxJD1nPBwbV8tyiSPEkgH+BKoAHM2sITUP5QeGVxmzdXIMj
         mxLvsybiSepOU/fDF490WpI1s6K6wI/KbiEPnpcUaIBUV2V1BsxFsvfu1u9vA4LfNWoX
         +dWfCJ/oSZsjIAykWOjg1vxzp9ELWzzQeZbKWsHqNnDTLEA8iHUiHR7YturGHok/mZEZ
         rEXtkXalFTrHG3ug3gzrX4Nq/Ivjj2Q3PHLSFrYghh7AX+PhFb3Qw+eA+hsxRhLYqegs
         D0xgFiVkubMc2EvAWwoo58ObwZg0ihtukQ/mZJJtRW+yjuEpO2JHKzH3W6TupT+155km
         siAA==
X-Gm-Message-State: AOAM532CSu+QvAh39b1YoNK7PKOeghEDKgGKAIHJ7ERO1kriMUSOpWVL
        Ja64uOfGesUPm4ttbdw/qbKzeTIPgt2Nf7fUdfSco4a7prlCGiiZMDo5ZlF1ocRoo5a5NNJP5Mg
        TcCSBt+pJkmrx9vQXWp78
X-Received: by 2002:aca:fc12:: with SMTP id a18mr730217oii.85.1626128682052;
        Mon, 12 Jul 2021 15:24:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlh7YpGsdl3xu+jtvQbH2ONvaZf8h5Bn0ZTADCYnXLcl6LUj0+zDsVISGYhqCTuXdO+g3Qjw==
X-Received: by 2002:aca:fc12:: with SMTP id a18mr730203oii.85.1626128681869;
        Mon, 12 Jul 2021 15:24:41 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id o63sm3492320oih.32.2021.07.12.15.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 15:24:41 -0700 (PDT)
Date:   Mon, 12 Jul 2021 16:24:40 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 8/8] PCI: Change the type of probe argument in reset
 functions
Message-ID: <20210712162440.6338346a.alex.williamson@redhat.com>
In-Reply-To: <20210709123813.8700-9-ameynarkhede03@gmail.com>
References: <20210709123813.8700-1-ameynarkhede03@gmail.com>
        <20210709123813.8700-9-ameynarkhede03@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri,  9 Jul 2021 18:08:13 +0530
Amey Narkhede <ameynarkhede03@gmail.com> wrote:

> Introduce a new enum pci_reset_mode_t to make the context of probe argume=
nt
> in reset functions clear and the code easier to read.  Change the type of
> probe argument in functions which implement reset methods from int to
> pci_reset_mode_t to make the intent clear.
>=20
> Add a new line in return statement of pci_reset_bus_function().
>=20
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Suggested-by: Krzysztof Wilczy=C5=84ski <kw@linux.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_main.c    |  2 +-
>  .../ethernet/cavium/liquidio/lio_vf_main.c    |  2 +-
>  drivers/pci/hotplug/pciehp.h                  |  2 +-
>  drivers/pci/hotplug/pciehp_hpc.c              |  4 +-
>  drivers/pci/hotplug/pnv_php.c                 |  4 +-
>  drivers/pci/pci-acpi.c                        | 10 ++-
>  drivers/pci/pci-sysfs.c                       |  6 +-
>  drivers/pci/pci.c                             | 85 ++++++++++++-------
>  drivers/pci/pci.h                             | 12 +--
>  drivers/pci/pcie/aer.c                        |  2 +-
>  drivers/pci/quirks.c                          | 37 ++++----
>  include/linux/pci.h                           |  8 +-
>  include/linux/pci_hotplug.h                   |  2 +-
>  13 files changed, 107 insertions(+), 69 deletions(-)

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2010B3F90AC
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 01:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243728AbhHZWXG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 18:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243685AbhHZWXG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Aug 2021 18:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630016536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZgK0Vzj/PyGVf287gkB5KcGajjxflHWYHigJAJkYE8o=;
        b=eyvqtB6ibK55UwL17FL9G0pP/vNCxrC9xlzyLfTmm/0ulTZUPTLjjhfRaUTi5o+uZejaDH
        CkWW5D7yqXuCCxTJqnROPlN32qctOuGIKadCTDzfsia4XaWwC04uAESB5g4PfxJHiOLQta
        eWe/uDlb3Fzh0HGYoEx1QtjilxoxyKc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-L5q3eovHM7uMQRvlyWzwZw-1; Thu, 26 Aug 2021 18:21:10 -0400
X-MC-Unique: L5q3eovHM7uMQRvlyWzwZw-1
Received: by mail-ot1-f71.google.com with SMTP id 8-20020a9d0588000000b0051defe13038so1838098otd.9
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 15:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZgK0Vzj/PyGVf287gkB5KcGajjxflHWYHigJAJkYE8o=;
        b=JN/BkrbIXgiwtqh3ddSKYcE4SxoIiHKqkyP4ivL3jjkRVmgZfRFk/1F7F9xdQ58M0O
         Y6AODrSU6kVOXr/7UO+9YW2teJbAriBiCgSSFRnVraPw84MmD0Gc/J01lr0zM2iSHbEm
         FtgwWKjtDNb8JMJmdlSs5FB/bwH7EI4Ww5vkXPFW68otgcNJvhev9sBBcs1JQf8jLa4N
         7hCkQZ78ByjWOftELDX3gJ+pRoVHUiy9fKCdfHcIdN6eUxmXS+P3ZcCfuX07V8aiGLcJ
         v6TtsSsCh5seQyIO29pSUtjPNB2Vt6+0ThuJ0mczhm9IgaHYkpdYqGXX4g1U+Ukqt5qA
         7D2w==
X-Gm-Message-State: AOAM531wvLkwjsd44II6/TFObNbK1DYaUBIdvt7YL64EhrWys2M9LcF0
        /wDLpcIr93bOmgaq6tI4nyGeQRyXIR4tJ+v6wHIbIBoDwxMGxYxA2ePChnXikNtrCVRURSW0TUa
        iNp0OQR04+QbS/ErGQCem
X-Received: by 2002:a05:6808:7:: with SMTP id u7mr12965323oic.63.1630016469674;
        Thu, 26 Aug 2021 15:21:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4wg/4PueI4scRfq8vf8o5WoWu5Cqwvs4cYyqbBPHaHmLY1mmgaQFiaPn6NoNF0UOWDizXew==
X-Received: by 2002:a05:6808:7:: with SMTP id u7mr12965308oic.63.1630016469544;
        Thu, 26 Aug 2021 15:21:09 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id s24sm840218otp.37.2021.08.26.15.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 15:21:09 -0700 (PDT)
Date:   Thu, 26 Aug 2021 16:21:08 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     <bhelgaas@google.com>, <corbet@lwn.net>,
        <diana.craciun@oss.nxp.com>, <kwankhede@nvidia.com>,
        <eric.auger@redhat.com>, <masahiroy@kernel.org>,
        <michal.lkml@markovi.net>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
        <mgurtovoy@nvidia.com>, <jgg@nvidia.com>, <maorg@nvidia.com>,
        <leonro@nvidia.com>
Subject: Re: [PATCH V5 00/13] Introduce vfio_pci_core subsystem
Message-ID: <20210826162108.4fc8b844.alex.williamson@redhat.com>
In-Reply-To: <20210826103912.128972-1-yishaih@nvidia.com>
References: <20210826103912.128972-1-yishaih@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 26 Aug 2021 13:38:59 +0300
Yishai Hadas <yishaih@nvidia.com> wrote:
> 
> Jason Gunthorpe (2):
>   vfio: Use select for eventfd
>   vfio: Use kconfig if XX/endif blocks instead of repeating 'depends on'
> 
> Max Gurtovoy (10):
>   vfio/pci: Rename vfio_pci.c to vfio_pci_core.c
>   vfio/pci: Rename vfio_pci_private.h to vfio_pci_core.h
>   vfio/pci: Rename vfio_pci_device to vfio_pci_core_device
>   vfio/pci: Rename ops functions to fit core namings
>   vfio/pci: Include vfio header in vfio_pci_core.h
>   vfio/pci: Split the pci_driver code out of vfio_pci_core.c
>   vfio/pci: Move igd initialization to vfio_pci.c
>   PCI: Add 'override_only' field to struct pci_device_id
>   PCI / VFIO: Add 'override_only' support for VFIO PCI sub system
>   vfio/pci: Introduce vfio_pci_core.ko
> 
> Yishai Hadas (1):
>   vfio/pci: Move module parameters to vfio_pci.c
> 
>  Documentation/PCI/pci.rst                     |    1 +
>  MAINTAINERS                                   |    1 +
>  drivers/pci/pci-driver.c                      |   28 +-
>  drivers/vfio/Kconfig                          |   29 +-
>  drivers/vfio/fsl-mc/Kconfig                   |    3 +-
>  drivers/vfio/mdev/Kconfig                     |    1 -
>  drivers/vfio/pci/Kconfig                      |   40 +-
>  drivers/vfio/pci/Makefile                     |    8 +-
>  drivers/vfio/pci/vfio_pci.c                   | 2262 +----------------
>  drivers/vfio/pci/vfio_pci_config.c            |   70 +-
>  drivers/vfio/pci/vfio_pci_core.c              | 2158 ++++++++++++++++
>  drivers/vfio/pci/vfio_pci_igd.c               |   19 +-
>  drivers/vfio/pci/vfio_pci_intrs.c             |   42 +-
>  drivers/vfio/pci/vfio_pci_rdwr.c              |   18 +-
>  drivers/vfio/pci/vfio_pci_zdev.c              |    4 +-
>  drivers/vfio/platform/Kconfig                 |    6 +-
>  drivers/vfio/platform/reset/Kconfig           |    4 +-
>  include/linux/mod_devicetable.h               |    6 +
>  include/linux/pci.h                           |   29 +
>  .../linux/vfio_pci_core.h                     |   89 +-
>  scripts/mod/devicetable-offsets.c             |    1 +
>  scripts/mod/file2alias.c                      |   17 +-
>  22 files changed, 2525 insertions(+), 2311 deletions(-)
>  create mode 100644 drivers/vfio/pci/vfio_pci_core.c
>  rename drivers/vfio/pci/vfio_pci_private.h => include/linux/vfio_pci_core.h (56%)

Applied to vfio next branch for v5.15.  Thanks,

Alex 


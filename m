Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE8936FDCF
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 17:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhD3PfD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 11:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhD3PfD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 11:35:03 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA71C06174A;
        Fri, 30 Apr 2021 08:34:14 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id m37so7084515pgb.8;
        Fri, 30 Apr 2021 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MBtQXIuz0RClowwZW8Ko8/n93yatHQjUxvwMgIZ/ols=;
        b=BpIlpnOIRbYwdrtdI+RnhNzdlHTUO4McLiJAe0rmXL3wCJfWY53kMh7F8ygjgsOT4O
         UUA3XkuncRlF7eEaSEFJmj1EzZb6eA4iFEtFUcrf6S+47bJWQ3r//ZfKesmgW/QCVhFw
         kRmKgpw8LCV8YkfkFdeVrzpioYXy5GCvMBIc6kOtXMEWzBo0cAOWTmIvH1XRQC2NAPUD
         rNjy17J7H1/xvkllWSfHT3tcLcvUlzLj40w6uZlaqTJcNH0lTzosi96wKfdPJWSCjF9G
         PJ/mSgunQqakXBF66NdAvlnMQkTTad033P81c+lPiNYBRZscAYyC/DPLrNqDocUg/0QC
         xZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MBtQXIuz0RClowwZW8Ko8/n93yatHQjUxvwMgIZ/ols=;
        b=fUUJ5f24te3slu/YZeFdPRkPZzwXtndTHu2c4GcmIy1cQY06+/K/0CKEsOvJJqG0sf
         zEPb0k8fXFGdJaZ7pXtB2fLr7Il4xYYUQlJb451HrRSOvaCbfy8r2YpfPXiPZeix96ns
         GXxrcjEnqIjvvB/ieYFupujxdh5xNOgvqewkTWNUe+FcA5lIEi/PUv05iKOIExSQceNi
         Hwd6AAny8TM+5yB7Cf3jhioYw23KUv+JarZGgp2iSwkhZdzBdoUClICB9wx0c2uXrUee
         qSfV9aZv1avVqzwuVmquKKibVN4X4AhwnNSenJ8gUXUkB5NI1qFqGc4SJ6LwEp+GZVeV
         taDA==
X-Gm-Message-State: AOAM530nZCKZEm7xNDpqufM3OdlWWTWHshlWFCCSHtpYcwFoi6XXc8hn
        fiD+VJSDXpkVnckpO4T7DOw=
X-Google-Smtp-Source: ABdhPJwgkfHS86Ko5WhyiumCJ0unIge6BjUrc+q8bm51WAZFkLIN+617yp41tGS8K5cnhh5bVFK5mg==
X-Received: by 2002:aa7:82cc:0:b029:213:db69:18d9 with SMTP id f12-20020aa782cc0000b0290213db6918d9mr5773309pfn.36.1619796854517;
        Fri, 30 Apr 2021 08:34:14 -0700 (PDT)
Received: from localhost ([103.248.31.161])
        by smtp.gmail.com with ESMTPSA id h8sm2422396pjt.17.2021.04.30.08.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:34:13 -0700 (PDT)
Date:   Fri, 30 Apr 2021 21:04:11 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 0/5] Expose and manage PCI device reset
Message-ID: <20210430153411.6xp6t4q2qmqbmkgj@archlinux>
References: <20210409192324.30080-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409192324.30080-1-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/04/10 12:53AM, Amey Narkhede wrote:
> PCI and PCIe devices may support a number of possible reset mechanisms
> for example Function Level Reset (FLR) provided via Advanced Feature or
> PCIe capabilities, Power Management reset, bus reset, or device specific reset.
> Currently the PCI subsystem creates a policy prioritizing these reset methods
> which provides neither visibility nor control to userspace.
>
> Expose the reset methods available per device to userspace, via sysfs
> and allow an administrative user or device owner to have ability to
> manage per device reset method priorities or exclusions.
> This feature aims to allow greater control of a device for use cases
> as device assignment, where specific device or platform issues may
> interact poorly with a given reset method, and for which device specific
> quirks have not been developed.
>
> Changes in v2:
> 	- Use byte array instead of bitmap to keep track of
> 	  ordering of reset methods
> 	- Fix incorrect use of reset_fn field in octeon driver
> 	- Allow writing comma separated list of names of supported reset
> 	  methods to reset_method sysfs attribute
> 	- Writing empty string instead of "none" to reset_method attribute
> 	  disables ability of reset the device
>
> Sending Raphael's patch again as this series depends on it.
>
> Amey Narkhede (4):
>   PCI: Add pcie_reset_flr to follow calling convention of other reset
>     methods
>   PCI: Add new array for keeping track of ordering of reset methods
>   PCI: Remove reset_fn field from pci_dev
>   PCI/sysfs: Allow userspace to query and set device reset mechanism
>
> Raphael Norwitz (1):
>   PCI: merge slot and bus reset implementations
>
>  Documentation/ABI/testing/sysfs-bus-pci       |  16 ++
>  drivers/crypto/cavium/nitrox/nitrox_main.c    |   4 +-
>  .../ethernet/cavium/liquidio/lio_vf_main.c    |   2 +-
>  drivers/pci/pci-sysfs.c                       |  93 ++++++++-
>  drivers/pci/pci.c                             | 176 ++++++++++--------
>  drivers/pci/pci.h                             |  10 +-
>  drivers/pci/pcie/aer.c                        |  12 +-
>  drivers/pci/probe.c                           |   4 +-
>  drivers/pci/quirks.c                          |  11 +-
>  include/linux/pci.h                           |  11 +-
>  10 files changed, 236 insertions(+), 103 deletions(-)
>
> --
> 2.31.1

A gentle ping ;)

Thanks,
Amey

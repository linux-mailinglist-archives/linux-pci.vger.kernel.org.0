Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FC63814CF
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 02:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhEOBA7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 21:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhEOBA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 21:00:58 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9727C06174A;
        Fri, 14 May 2021 17:59:46 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y32so523502pga.11;
        Fri, 14 May 2021 17:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iLidNNz+WtR1nek5df3fCPxu8o8cBt8SPQCZTnExBng=;
        b=jwtP5Pq1MW/1L/XG9M7KJaHCBfLFqo7+7aqcSxkukvYPx6cmzHZyDG6tuzfn9qr8dL
         xSIHYITF6PUyVoZmMXtrz90yvdunAv+PyVleUXhoxGQGA6HejPqWmUsDtsecoB55xu7a
         mnfI+ZGa4F0NeCnvGuIr3Vra2elO/RIOtHwnvu4zSL8ln4p7gc6p1wsNZRkdhT9mgGPG
         6CL5uP6XK8dG9iiZpoKw8a5zfuWDTzX85JlPeB82lfZ3ezoE9pKbORQirlJM/yyujGoQ
         UlAEmYCV2Ba2M5mbYUzviydMGfJZj+7rciSfMsQHG4PgJozFZ9mvyn0pmBDlh01B1k2h
         k2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iLidNNz+WtR1nek5df3fCPxu8o8cBt8SPQCZTnExBng=;
        b=OUxRy/T22HhQVAspBsSfWfqrkTqK9+vsehyKszspOzBeHVbeF+KsAe4Y8oklUeSh+0
         09SzTJyWlOrhkXaN/rn2C3FrFRlf99sbHH6Rw5GLTzsdPrbG8+X7uxhz5Et9s6boXX6U
         485z9mgefgUqjdRtZn5RoKeLt4bStEHw8FkAvY9XrwzQoxssojVsiB5oqmqTdTvLDjoe
         KDyUk1hG+QrW2c5toGxe+AXpeoCYmmQztbUMyw75irBApa1fHi8HztVgmJS6fxKzBiPX
         z91i0CFYRA5VR7KlzJvnUcJI3fjIDtkvUtwVulMsDInPincw4IWOkTSwXb9A4p66zvRX
         kZYg==
X-Gm-Message-State: AOAM532vsQ8Zaqv2W78i64B9q4pQ+qg0q7+JTQ6Apg7m6xdhpXFldVY6
        f5FZjpGvHhQJ563KcutB4mA=
X-Google-Smtp-Source: ABdhPJx/OfD+1usR2aT0BWRW12kq2Jswbv5m0EV5BzOX1nOxHKVmF6COldRGuPZf3QE2Qt3aBcVQBA==
X-Received: by 2002:a63:5d13:: with SMTP id r19mr13295013pgb.379.1621040386394;
        Fri, 14 May 2021 17:59:46 -0700 (PDT)
Received: from localhost ([103.248.31.157])
        by smtp.gmail.com with ESMTPSA id z3sm4696589pfe.78.2021.05.14.17.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 17:59:46 -0700 (PDT)
Date:   Sat, 15 May 2021 06:29:42 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v2 0/5] Expose and manage PCI device reset
Message-ID: <20210515005942.nfcbdyn6fssuhld7@archlinux>
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

Hi Bjorn,
I guess as the merge window is closed this patch
won't get merged in 5.13. I was wondering if you
have any suggestions on this patch series so that I can
make changes meanwhile.

Thanks,
Amey

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EE73BBE51
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 16:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhGEOkV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 10:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhGEOkU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 10:40:20 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04C8C061574;
        Mon,  5 Jul 2021 07:37:43 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e17so1024228plh.8;
        Mon, 05 Jul 2021 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5AWHaVvPh49d+yaBwH+MAs4OHpj+/HGOPc2h2Rb/xD4=;
        b=pXt7ANSog9P+dNjEnSHjySU2MSmjgnj4acVntPMYeTEW5v9QbswEW1HAaEmmNu8Eus
         HVh6kSrA1cgPP7ph4IgCJsxKh0mWnFYFWj0H5Fk77Pavtbkl9jtLuAQaFYRVmgIx3ZdG
         3lHZYDHlbUVK3R6wYCOcF2tJN8/mVoGt9m+RlNNPyfiasgb05tGyHYByPwB2ga4d5tFY
         4IiKSn98ELn0Wo8yzRMnyG+bojKjeLb0LH989M1BJTRH0ZwnfcVIzfmlruH1qmXWWowT
         sIslVjCwz1VbK+G+o3H1cNy1bvXPkPRJ4F3BuA3+XleXnOIIw+0wCcwhT3IighmI1FD7
         ZqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5AWHaVvPh49d+yaBwH+MAs4OHpj+/HGOPc2h2Rb/xD4=;
        b=EqagKAMpCs+1LEw2mWUcDwVr/NZFnPRqef2iias1VPsuBId81SQjZxy48Y5NhjGeko
         /xkzth4z9X6ihyt49yXaURXf8SCrX6FqFSomv70HCuxsGFQ2lds6psBoNIAVYJyYa1Wz
         RZ7zPlvIZknzgMoMFLlQNzYxlXOrNmFP38JMmqcuxi3PbFRQz29dSOB83SHhVR7NRe9i
         i41D2jyHmqvOvgrLS4nskaupl1S+Y/CLJ7bzQ7orOruvkxTASjuKlp0ews3uJPCUJYpF
         aqX5XamiXXtvqfvFP+jXkxZAt6ZN9FmPzTaLC2UvGg1De/1ynPJ7REYAsCNE4jomuli9
         ZZCQ==
X-Gm-Message-State: AOAM532C+hMwzTCsO6njwTSnrXRk7C97OwELUjXxSdi8x580v+c+zeaf
        zzrqgwneD0Isx5xvHzgEjyk=
X-Google-Smtp-Source: ABdhPJytY/GUVq+b2uUVvcM6KpeDwzmzhxtujICoJEEYS6A9K+SdewcJ1MPvEcfgCjiW6T9BcrfoZQ==
X-Received: by 2002:a17:90a:65c8:: with SMTP id i8mr15848356pjs.207.1625495863565;
        Mon, 05 Jul 2021 07:37:43 -0700 (PDT)
Received: from localhost ([2409:4042:2696:1624:5e13:abf4:6ecf:a1f1])
        by smtp.gmail.com with ESMTPSA id fa22sm11398412pjb.42.2021.07.05.07.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 07:37:43 -0700 (PDT)
Date:   Mon, 5 Jul 2021 20:07:39 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH v9 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210705143739.nghgqghnskp7emai@archlinux>
References: <20210705142138.2651-1-ameynarkhede03@gmail.com>
 <20210705142138.2651-2-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705142138.2651-2-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/07/05 07:51PM, Amey Narkhede wrote:
> Add has_pcie_flr bitfield in struct pci_dev to indicate support for PCIe
> FLR to avoid reading PCI_EXP_DEVCAP multiple times.
>
> Currently there is separate function pcie_has_flr() to probe if PCIe FLR
> is supported by the device which does not match the calling convention
> followed by reset methods which use second function argument to decide
> whether to probe or not. Add new function pcie_reset_flr() that follows
> the calling convention of reset methods.
>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +-
>  drivers/pci/pci.c                          | 59 +++++++++++-----------
>  drivers/pci/pcie/aer.c                     | 12 ++---
>  drivers/pci/probe.c                        |  6 ++-
>  drivers/pci/quirks.c                       |  9 ++--
>  include/linux/pci.h                        |  3 +-
>  6 files changed, 45 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
[...]
> index 3a62d09b8..a95252113 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1487,6 +1487,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  {
>  	int pos;
>  	u16 reg16;
> +	u32 reg32;
>  	int type;
>  	struct pci_dev *parent;
>
> @@ -1497,8 +1498,9 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  	pdev->pcie_cap = pos;
>  	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
>  	pdev->pcie_flags_reg = reg16;
> -	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
> -	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
> +	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &reg32);
> +	pdev->pcie_mpss = reg32 & PCI_EXP_DEVCAP_PAYLOAD;
> +	pdev->has_pcie_flr = reg32 & PCI_EXP_DEVCAP_FLR ? 1 : 0;
On the side note, removing ternary here as Alex suggested doesn't work
for some reason.
[...]

Thanks,
Amey

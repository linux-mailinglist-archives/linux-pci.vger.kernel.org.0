Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CC93FE31A
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 21:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245074AbhIATe3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 15:34:29 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:40804 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244879AbhIATe2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Sep 2021 15:34:28 -0400
Received: by mail-ot1-f52.google.com with SMTP id 107-20020a9d0bf4000000b0051b8be1192fso1107581oth.7;
        Wed, 01 Sep 2021 12:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MN8A84FtJZYLcjJOsAhof11b/DtEYUBV+PxXI/9y4CI=;
        b=QegkAfuyT+Iqwsa/wkUcPKB/ENaiTT2bMZbsVFjWW7HDqd+LqwxycMzsw+A3C88uyF
         QhQTNMR2ADTdDunXKPfkda0bc0UpXOLIpBvHcMFkmtm1BBHetJbrEZWhVowyloW2zxXf
         mmy1YkA5ZURVwTMS6tlrUOwwZlsR/KHJqnqNYPtoY9z1F+2lZHaEeZ2JVjiElfV9PTXU
         oBKEfEdceE4rchVtOT0PY0u+hYgUaL2EcHWCD34BZRusyw5q2uCvOF9gJsv1FPGNFzvI
         gIE2wBCAs1DCbvR/XEvFGiPg1UY13sTSE2K5rAEfbTkHeGSgOxKpXXjxSYlVCQGEGLyT
         xZyA==
X-Gm-Message-State: AOAM531BoEkkcLWorT+kez/hO0kXjXK8n+BNLjt7IjV1epiCJPnMU7He
        QMZ4vdFXTknWfcDxkbPbFRI8VRR2X0cPdWqoP0A=
X-Google-Smtp-Source: ABdhPJwZWzfXpat3iSK/prDXMONscYHzvSJ1A+J23/4E9AH0hNKTvNz2tYR+TH8I/hrS5liTFQASeeDGXz3idsQnoxI=
X-Received: by 2002:a9d:705d:: with SMTP id x29mr944614otj.260.1630524811473;
 Wed, 01 Sep 2021 12:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210824122054.29481-1-joro@8bytes.org>
In-Reply-To: <20210824122054.29481-1-joro@8bytes.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Sep 2021 21:33:20 +0200
Message-ID: <CAJZ5v0jqwgvmRrRts4Nf4ySmrp5gwmv_iJWBh3OjN54ZU+qneQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] PCI/ACPI: Simplify PCIe _OSC feature negotiation
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 24, 2021 at 2:21 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Hi,
>
> here is the third version of my patches to simplify the _OSC
> negotiation of PCIe features between Linux and the firmware.
>
> This version is a complete rewrite, so there is no changelog to the
> previous version. Patches 1-3 are cleanups and small restructurings of
> the code as a preparation for patch 4.
>
> The last patch gets rid of the dedicated _OSC query to check for _OSC
> support and merges that functionality into acpi_pci_osc_control_set().
>
> This allows to simplify and/or remove other functions and consilidate
> error handling in negotiate_os_control().
>
> I have tested the patches with and without 'pcie_ports=compat' and
> found no regressions on my test machine.

I have reviewed the patches, so if you want me to queue up this
series, please let me know.

Thanks,
Rafael


> Joerg Roedel (4):
>   PCI/ACPI: Remove OSC_PCI_SUPPORT_MASKS and OSC_PCI_CONTROL_MASKS
>   PCI/ACPI: Move supported and control calculations to separaten
>     functions
>   PCI/ACPI: Move _OSC query checks to separate function
>   PCI/ACPI: Check for _OSC support in acpi_pci_osc_control_set()
>
>  drivers/acpi/pci_root.c | 161 +++++++++++++++++++++-------------------
>  include/linux/acpi.h    |   2 -
>  2 files changed, 84 insertions(+), 79 deletions(-)
>
> --
> 2.32.0
>

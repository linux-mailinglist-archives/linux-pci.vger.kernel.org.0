Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA437495F0E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 13:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380377AbiAUMbs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 07:31:48 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40456
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350448AbiAUMbr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 07:31:47 -0500
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 147B94000F
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 12:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642768300;
        bh=c9fVUVKjIOT3MSffUOaIGaq4Du3Knv0i592KDvMBOMI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QH5v1rF1NMiBOzjXpeohZJIga9BuA7jJQiwKmidxrPBqr5Y4QvXS63DJk4cH7mQ/W
         3p6IZ6K8ReoTDQ9qK/IBopCIo5Vn+f8oPcjC0ksuYH2XKbL5OhVTxE+SYAqsxl7NUW
         TeaZDY/dBvHWgu4gs43CYThxchq3kaj0gYc6jCZCiM5p3NquDTsL6Wxa+rpw66n8rp
         Lh/PB8SsxZvpT6O4Z3uhe5l13F2RmZ+c5OJwwu01wSSdXESmLxl8aeNpCglQzXtXao
         4rJI5QWxx0k5o5W0vw1H6leQdM4cRCrPUna+U2oc8pj6oYGzRdCVgq6i2SKGpAyZLg
         /85/4Zu1wDCnQ==
Received: by mail-ot1-f69.google.com with SMTP id 39-20020a9d0eaa000000b0058f56d89582so5421062otj.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 04:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9fVUVKjIOT3MSffUOaIGaq4Du3Knv0i592KDvMBOMI=;
        b=ODPMruv/hZmTNLzO+eskj4P+ln/+wECJdguKzfDrcucFrnK+Uu4THQ9YOcJ7Ic0MfS
         +9F5LbbWAH3zI1pAU0p4TZMNRwOYffVdjth5K3x3pHsC9iYwtVZD7zGi2q6UW6Eca0hH
         xFy2Vo7ANsO+ZvsEKXKg1g5DBIrciH9VTPX4ZItIDxwFv3MGJnkzgSaNnxRErWHQrzQH
         gTUoOopS7NKzK57eNaKDmQ9T8RjMYno8Z5xBUA0DW4d7Z5YWWPanQz7skYoKgG2lFIVC
         J5di0G6M4uABLMjyIYfC9SgGam7g3FNXiPlVS8cAMkOt4b7ZjJYUOn/3lGWwWYS6lEmP
         O1ww==
X-Gm-Message-State: AOAM532EVG61fMYklbzDUQSkhO+MZf3Wu3G3BXz8Fjgyz/LtPqJ532Iw
        PXYwh1YFU7LhQmOU3MFD4oK3ZqRITS411+LVbyNzQSDUuDkxlqqUvjMJxwbleu1404mJz9bu3MW
        /EMNncDfT8DkTOh+HCaXaD0tpc9Vqrokgnm09KkfxZzfS3g+nURULPA==
X-Received: by 2002:a4a:9d1c:: with SMTP id w28mr2418644ooj.24.1642768298887;
        Fri, 21 Jan 2022 04:31:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzW17D8VH503b1QySQdOAtIlH3veXyQ7VSCK0fq7QOKhO4G6m/7Y1i1PSfEwTOTLY0EyKg6GOUwzBk2BdkEEH0=
X-Received: by 2002:a4a:9d1c:: with SMTP id w28mr2418630ooj.24.1642768298604;
 Fri, 21 Jan 2022 04:31:38 -0800 (PST)
MIME-Version: 1.0
References: <20220105060643.822111-1-kai.heng.feng@canonical.com>
 <20220105201226.GA218998@bhelgaas> <CAAd53p5V9gCCc6v9Wdo-bONYfASnhtyGHVPPb6vOneft2XewQQ@mail.gmail.com>
 <YeqRGQoPKy389ct5@lahna>
In-Reply-To: <YeqRGQoPKy389ct5@lahna>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 21 Jan 2022 20:31:27 +0800
Message-ID: <CAAd53p4ej6FA0dM4ahngnGAccSLe=-bsUVkt-eGb2jZkms1UYA@mail.gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Skip enabling AER on external facing ports
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        koba.ko@canonical.com, Lukas Wunner <lukas@wunner.de>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mika,

On Fri, Jan 21, 2022 at 6:55 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Kai-Heng,
>
> On Fri, Jan 07, 2022 at 12:09:57PM +0800, Kai-Heng Feng wrote:
> > Only from root ports of thunderbolt devices.
> >
> > The error occurs as soon as the root port is runtime suspended to D3cold.
> >
> > Runtime suspend the AER service can resolve the issue. I wonder if
> > it's the right thing to do here?
>
> I think you are right here. It seems that AER "service driver" is
> completely missing PM hooks. Probably because it is more used in server
> type of systems where power management is not priority.

Here is my previous attempt to suspend AER:
https://lore.kernel.org/linux-pci/20210127173101.446940-1-kai.heng.feng@canonical.com/

>
> > D3cold should also mean the PCI link is gone, disabling AER seems to
> > be a reasonable approach.
>
> Indeed - I think AER might trigger here because the link does "down" /
> low power state if left enabled while the root port enters D3. Something
> like below hack should disable it over low power transitions:

Ubuntu kernel has been carrying the patch for quite some time:
https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/unstable/commit/?id=e82f15f1a26273b004054a81ef45937fb1b632e5

>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 9fa1f97e5b27..64138cf82db8 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1432,6 +1432,22 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>         return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>  }
>
> +static int aer_suspend(struct pcie_device *dev)
> +{
> +       struct aer_rpc *rpc = get_service_data(dev);
> +
> +       aer_disable_rootport(rpc);
> +       return 0;
> +}
> +
> +static int aer_resume(struct pcie_device *dev)
> +{
> +       struct aer_rpc *rpc = get_service_data(dev);
> +
> +       aer_enable_rootport(rpc);
> +       return 0;
> +}
> +
>  static struct pcie_port_service_driver aerdriver = {
>         .name           = "aer",
>         .port_type      = PCIE_ANY_PORT,
> @@ -1439,6 +1455,10 @@ static struct pcie_port_service_driver aerdriver = {
>
>         .probe          = aer_probe,
>         .remove         = aer_remove,
> +       .suspend        = aer_suspend,
> +       .resume         = aer_resume,
> +       .runtime_suspend = aer_suspend,
> +       .runtime_resume = aer_resume,
>  };

This patch is exactly what I tested.

Maybe only suspend/runtime_suspend AER when the target PM state is D3cold?
PCIe spec doesn't say how to handle AER in Link L2/L3Ready/L3, but I
think it's reasonable to suspend AER when power is loss.

Let me come up with a patch with that idea.

Kai-Heng

>
>  /**

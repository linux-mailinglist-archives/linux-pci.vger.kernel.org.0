Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9782435B32
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 08:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhJUG7R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 02:59:17 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:52684
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230020AbhJUG7Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 02:59:16 -0400
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 58FD140010
        for <linux-pci@vger.kernel.org>; Thu, 21 Oct 2021 06:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634799420;
        bh=Rd3TVdQEYYGJqY8LDfz2Z1r48P6bx1rBEWI+EufroyU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=umkzWiRY13oM/kghiElvyGLgnZKnuN83uL8ZIo3quyXGAO4OAbw+STWoFu2cMNWUp
         LkrXj/nIoPTk5SCPZ3m3uHPmDvf9kaLwc8egkxQ+U6S6o7y7vLJqSMVjPxk624udio
         fN8lfkG/S3gakU2qh0CJ/d2XCwEcZrH00Ih0eyfL6s6pQOi1Op3WBFjd395alv4C9k
         qUVH0i/JtBztIIh91A51SdU5CVXnFxgnwGpfRWyg9mkhylWdx+VBOXtUhgJmDDNtFj
         qj5BMgckef/Ui0eHflfr5thmFH+Io3ASNR7bWTQSmgXibLWYWk+M+cUJihGZQsnmcx
         bqQWKIMU9SVaQ==
Received: by mail-oo1-f71.google.com with SMTP id h15-20020a4a6b4f000000b002b6fa118bfeso4436385oof.18
        for <linux-pci@vger.kernel.org>; Wed, 20 Oct 2021 23:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rd3TVdQEYYGJqY8LDfz2Z1r48P6bx1rBEWI+EufroyU=;
        b=gsZMjc5ZiTRlhFOeo7cRi38Orb2RMvedONjVEUvmOXcZUd8oB4HyOYRXv8Sbfpwv8D
         v0MiTMsCsU//nTz+VGiQSBgR1HVLssz/N69UxoBaZ8dFmde65SGVyzTZofTYODZGyIm0
         53tgI07+f8RskDvNCvAJdgLisC8N0eGYIzklqJOXMIN8lYMLNpo9cS7PakR2hmX7lkov
         5I4LgYQB4WcD5HmTTCwVSe8CbDUCQLqxqQfOtMPq01s5s0rlSiuQz7TVrMT/a51p2zrx
         EmXpJTwommiHhIO4R2nStVqeMSFHxsyKFW8uWWXe6WrRp0B5e+eEQdCzN1Auw4p410Zn
         z1aA==
X-Gm-Message-State: AOAM531e3BWDEJHVhKiGml5bc4oieSd0+kBCpcYN3tzLs5m3R8hleeNb
        Huz3PVB/B281+wzsGT7pR6MubhtXXvVdShwrWWzDHY5uAfDJhl0PupZMMSMAcaafPn0G+54uN2E
        lZi4wuWkbxFVxcZLEiN5lbWZGCDmz617jnR/NnwvsRYOtChwOf2/KyQ==
X-Received: by 2002:a05:6830:1655:: with SMTP id h21mr3231139otr.269.1634799419089;
        Wed, 20 Oct 2021 23:56:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaYn3FbEBxku8Kok2yHwhmklId4ImFtFhqY4JjhPXK85xs7ZL633jFo032YpkEt8eGC9C94nu73DSS69nCpw0=
X-Received: by 2002:a05:6830:1655:: with SMTP id h21mr3231119otr.269.1634799418770;
 Wed, 20 Oct 2021 23:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210812153944.813949-1-kai.heng.feng@canonical.com>
In-Reply-To: <20210812153944.813949-1-kai.heng.feng@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 21 Oct 2021 14:56:47 +0800
Message-ID: <CAAd53p7sPoH-MD9VMh1u+mf_E7Mc2xVfkHbhN4PCdxQM+v274g@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Check PCIe upstream port for PME support
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 12, 2021 at 11:39 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Some platforms cannot detect ethernet hotplug once its upstream port is
> runtime suspended because PME isn't granted by BIOS _OSC. The issue can
> be workarounded by "pcie_ports=native".
>
> The vendor confirmed that the PME in _OSC is disabled intentionally for
> system stability issues on the other OS, so we should also honor the PME
> setting here.
>
> So before marking PME support status for the device, check
> PCI_EXP_RTCTL_PMEIE bit to ensure PME interrupt is either enabled by
> firmware or OS.
>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=213873
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

A gentle ping...

> ---
> v2:
>  - Instead of prevent root port from runtime suspending, skip
>    initializing PME status for the downstream device.
>
>  drivers/pci/pci.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index aacf575c15cf..4344dc302edd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2294,6 +2294,32 @@ void pci_pme_wakeup_bus(struct pci_bus *bus)
>                 pci_walk_bus(bus, pci_pme_wakeup, (void *)true);
>  }
>
> +#ifdef CONFIG_PCIE_PME
> +static bool pci_pcie_port_pme_enabled(struct pci_dev *dev)
> +{
> +       struct pci_dev *bridge = pci_upstream_bridge(dev);
> +       u16 val;
> +       int ret;
> +
> +       if (!bridge)
> +               return true;
> +
> +       if (pci_pcie_type(bridge) != PCI_EXP_TYPE_ROOT_PORT &&
> +           pci_pcie_type(bridge) != PCI_EXP_TYPE_RC_EC)
> +               return true;
> +
> +       ret = pcie_capability_read_word(bridge, PCI_EXP_RTCTL, &val);
> +       if (ret)
> +               return false;
> +
> +       return val & PCI_EXP_RTCTL_PMEIE;
> +}
> +#else
> +static bool pci_pcie_port_pme_enabled(struct pci_dev *dev)
> +{
> +       return true;
> +}
> +#endif
>
>  /**
>   * pci_pme_capable - check the capability of PCI device to generate PME#
> @@ -3095,7 +3121,7 @@ void pci_pm_init(struct pci_dev *dev)
>         }
>
>         pmc &= PCI_PM_CAP_PME_MASK;
> -       if (pmc) {
> +       if (pmc && pci_pcie_port_pme_enabled(dev)) {
>                 pci_info(dev, "PME# supported from%s%s%s%s%s\n",
>                          (pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
>                          (pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
> --
> 2.32.0
>

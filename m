Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD984D2E98
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 18:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbfJJQ2l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Oct 2019 12:28:41 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42815 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJQ2l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2019 12:28:41 -0400
Received: by mail-oi1-f195.google.com with SMTP id i185so5427930oif.9;
        Thu, 10 Oct 2019 09:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vR2xgB+PJ4hryKhIu/ABDp/zNbHr4xtzKP74nw4y8Ik=;
        b=XMS1zZbbKaMWK8LNn5z0tClByULY6OAKohFZbMx/x7Tl8/4BeC/tDrN2gTBDSDkR4D
         MXTeeKbpzwUcX2+h04Zx9oOuUhmhkF0cNfIJAVN1ZVmmWH0p6GijsknWaJyEMqpNupDh
         ajJMfTPN3K8noNqELHvH8u5I9LfetsRFb/J9LnbpK6dI6xzk025DsmEGHwbVJBcfGBIQ
         hAKgKgM+lCzy+g/MNN7V8nVjqtmT7mEXExtwiFFaq7rbzHrfUv2EEo9yKaWEqT40v0O7
         /fhybe2JIBHrdwuALuR/pNGvG87BwF2Wds+L3ysGY5ir4dkLvveR8Y6bG5y/uScDJM+b
         qScQ==
X-Gm-Message-State: APjAAAUZ1Ijvqc/0fnYAHRCoQnr/XmMemLQWtZb4kpplHMIq145RI8uC
        bTKRlSNGsFWZHaWVJbAjPqmF+WGQwX69pf7A8iU=
X-Google-Smtp-Source: APXvYqzbrJOhGfBWBTIglV05BZrFqcToiafb4MWI8sJuPR1PbO7wyzrGsiSbiAiZYgYzUUKgvZH6WdjUdOkyQrTiF2o=
X-Received: by 2002:aca:5885:: with SMTP id m127mr8546117oib.110.1570724920583;
 Thu, 10 Oct 2019 09:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191010124746.2882-1-helgaas@kernel.org> <20191010124746.2882-2-helgaas@kernel.org>
In-Reply-To: <20191010124746.2882-2-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Oct 2019 18:28:29 +0200
Message-ID: <CAJZ5v0i7EApH4rHjAqKJ1T96M57ONn+dNPUSwC9ZQ6UJi53Jqg@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI/ASPM: Remove pcie_aspm_enabled() unnecessary locking
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajat Jain <rajatja@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 10, 2019 at 2:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> The lifetime of the link_state structure (bridge->link_state) is not the
> same as the lifetime of "bridge" itself.  The link_state is allocated by
> pcie_aspm_init_link_state() after children of the bridge have been
> enumerated, and it is deallocated by pcie_aspm_exit_link_state() after all
> children of the bridge (but not the bridge itself) have been removed.
>
> Previously pcie_aspm_enabled() acquired aspm_lock to ensure that
> link_state was not deallocated while we're looking at it.  But the fact
> that the caller of pcie_aspm_enabled() holds a reference to @pdev means
> there's always at least one child of the bridge, which means link_state
> can't be deallocated.
>
> Remove the unnecessary locking in pcie_aspm_enabled().
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

(also for the further changes you and Christoph have been discussing).

> ---
>  drivers/pci/pcie/aspm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 652ef23bba35..f5c7138a34aa 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1172,20 +1172,20 @@ module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
>  /**
>   * pcie_aspm_enabled - Check if PCIe ASPM has been enabled for a device.
>   * @pdev: Target device.
> + *
> + * Relies on the upstream bridge's link_state being valid.  The link_state
> + * is deallocated only when the last child of the bridge (i.e., @pdev or a
> + * sibling) is removed, and the caller should be holding a reference to
> + * @pdev, so this should be safe.
>   */
>  bool pcie_aspm_enabled(struct pci_dev *pdev)
>  {
>         struct pci_dev *bridge = pci_upstream_bridge(pdev);
> -       bool ret;
>
>         if (!bridge)
>                 return false;
>
> -       mutex_lock(&aspm_lock);
> -       ret = bridge->link_state ? !!bridge->link_state->aspm_enabled : false;
> -       mutex_unlock(&aspm_lock);
> -
> -       return ret;
> +       return bridge->link_state ? !!bridge->link_state->aspm_enabled : false;
>  }
>  EXPORT_SYMBOL_GPL(pcie_aspm_enabled);
>
> --
> 2.23.0.581.g78d2f28ef7-goog
>

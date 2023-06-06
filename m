Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE75E724B1F
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 20:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbjFFSWE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 6 Jun 2023 14:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjFFSWD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 14:22:03 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CCF170A;
        Tue,  6 Jun 2023 11:22:01 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-94ea38c90ccso134752066b.1;
        Tue, 06 Jun 2023 11:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686075720; x=1688667720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aSoUhgWHV+y0z5uQRB4bpTRujGWxzEc2UA+6UXy9cs=;
        b=jFy19WcYQlBTrUBU+G3boknctIqF8uIa3RgGAZYqZ4HB5Y5u4vAkqOAADMtF6YaalR
         DxFlr4NSb39ahvOF3WDkfrV2zzyQgj219uY+2ddEz9y+BMPSbaRe57hNjbXWbksgvqR5
         SEYhFG6q3zgelUqgWWAIdJcR38v5/0YZbMtr9xprrhbCBU59ZkuJaarCG5+reB4jjrad
         iMhO1YLhMlVWyjL3iTGyZ1TRp64c32MTtuWwQxUpo0Q1bVzVB1TPmoU0Ga1QYkYDZ5VF
         ZKUWZSPbLNE3I3l/E7v3cLFL9xWrBb/gc9tESN4RodGAX0xtxajlhF3MKurowvcvv/Oh
         hnpQ==
X-Gm-Message-State: AC+VfDwNFlFu77e1QT2QEl0ZNjOZsCqYxiauQJAp9bgVM3McMU7kdRtH
        ZbX81u1qESofel64IaaQcGAk9SFRjDpls4yYonuFRosFJS8=
X-Google-Smtp-Source: ACHHUZ7YuScGoMETviGDVvAQazZaXPkDUlJp6Gx+OG0u97ZqDuhFL76sDBrkGVrU8k5ymyZSK1j+gA3kCwzNqvUdgo0=
X-Received: by 2002:a17:906:209d:b0:977:c446:3a24 with SMTP id
 29-20020a170906209d00b00977c4463a24mr3104628ejq.7.1686075719569; Tue, 06 Jun
 2023 11:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230606162321.34222-1-mario.limonciello@amd.com>
In-Reply-To: <20230606162321.34222-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Jun 2023 20:21:48 +0200
Message-ID: <CAJZ5v0gzfCXmPm7Jckt02FF_PJY8VJPPUeoE0gb8twbP+M8CxA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Call _REG when saving/restoring PCI state
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 6, 2023 at 6:23 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> ASMedia PCIe GPIO controllers fail functional tests after returning from
> suspend (S3 or s2idle). This is because the BIOS checks whether the
> OSPM has called the `_REG` method to determine whether it can interact with
> the OperationRegion assigned to the device.
>
> As described in 6.5.4 in the APCI spec, `_REG` is used to inform the AML
> code on the availability of an operation region.
>
> To fix this issue, call acpi_evaluate_reg() when saving and restoring the
> state of PCI devices.
>
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Handle case of no CONFIG_ACPI
>  * Rename function
>  * Update commit message
>  * Move ACPI calling code into pci-acpi.c instead
>  * Cite the ACPI spec
> ---
>  drivers/pci/pci-acpi.c | 10 ++++++++++
>  drivers/pci/pci.c      | 14 ++++++++++++++
>  drivers/pci/pci.h      |  2 ++
>  3 files changed, 26 insertions(+)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 1698205dd73c..abc8bcfc2c71 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1209,6 +1209,16 @@ void acpi_pci_remove_bus(struct pci_bus *bus)
>         acpi_pci_slot_remove(bus);
>  }
>
> +void acpi_pci_set_register_access(struct pci_dev *dev, bool enable)
> +{
> +       int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
> +       int ret = acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
> +                                   ACPI_ADR_SPACE_PCI_CONFIG, val);
> +       if (ret)
> +               pci_dbg(dev, "ACPI _REG %s evaluation failed (%d)\n",
> +                       val ? "connect" : "disconnect", ret);

s/val/enable/ ?

Then I don't have to remember that ACPI_REG_DISCONNECT is 0.

<bikeshedding>

I would call this function something like
acpi_pci_config_space_access(), because technically it is about
allowing AML to access the PCI configuration space.

</bikeshedding>

> +}
> +
>  /* ACPI bus type */
>
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e38c2f6eebd4..b2f1f603ec62 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1068,6 +1068,14 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>         return acpi_pci_bridge_d3(dev);
>  }
>
> +static inline void platform_set_register_access(struct pci_dev *dev, bool en)
> +{
> +       if (pci_use_mid_pm())
> +               return;
> +
> +       acpi_pci_set_register_access(dev, en);
> +}
> +
>  /**
>   * pci_update_current_state - Read power state of given device and cache it
>   * @dev: PCI device to handle.
> @@ -1645,6 +1653,9 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
>  int pci_save_state(struct pci_dev *dev)
>  {
>         int i;
> +
> +       platform_set_register_access(dev, false);
> +
>         /* XXX: 100% dword access ok here? */
>         for (i = 0; i < 16; i++) {
>                 pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
> @@ -1790,6 +1801,8 @@ void pci_restore_state(struct pci_dev *dev)
>         pci_enable_acs(dev);
>         pci_restore_iov_state(dev);
>
> +       platform_set_register_access(dev, true);
> +
>         dev->state_saved = false;
>  }
>  EXPORT_SYMBOL(pci_restore_state);
> @@ -3203,6 +3216,7 @@ void pci_pm_init(struct pci_dev *dev)
>         pci_read_config_word(dev, PCI_STATUS, &status);
>         if (status & PCI_STATUS_IMM_READY)
>                 dev->imm_ready = 1;
> +       platform_set_register_access(dev, true);
>  }
>
>  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ffccb03933e2..78961505aae2 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -703,6 +703,7 @@ void acpi_pci_refresh_power_state(struct pci_dev *dev);
>  int acpi_pci_wakeup(struct pci_dev *dev, bool enable);
>  bool acpi_pci_need_resume(struct pci_dev *dev);
>  pci_power_t acpi_pci_choose_state(struct pci_dev *pdev);
> +void acpi_pci_set_register_access(struct pci_dev *dev, bool enable);
>  #else
>  static inline int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
>  {
> @@ -742,6 +743,7 @@ static inline pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
>  {
>         return PCI_POWER_ERROR;
>  }
> +static inline void acpi_pci_set_register_access(struct pci_dev *dev, bool enable) {}
>  #endif
>
>  #ifdef CONFIG_PCIEASPM
> --
> 2.34.1
>

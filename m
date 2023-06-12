Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE54A72CC3E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 19:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjFLRRu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 12 Jun 2023 13:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjFLRRo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 13:17:44 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CF010F3;
        Mon, 12 Jun 2023 10:17:37 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-97ea801b0d0so49101566b.1;
        Mon, 12 Jun 2023 10:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686590255; x=1689182255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhUmdQnfi0GqNSRcqyI8HlOzdT8gEARQN6Ki8wJOOtU=;
        b=Q3ALGHJ8LATbelgLdPXiphnyphfGamlSX9nQO+zv2yePVnD2B3yu88tdgNhTRY/9XX
         8iJjYdJVMqWMOmOHGqNZP3SqgBm3Smpgnj7shrskcmcvv+kIHE1KnlOGhA2MsHtsN+ED
         lDe20UBwsvJDJzb+RlWvG3jwUz1ggZUT5pv3NbJLb1J7ZcFppAuyFh/6X+WMxE4X3nfd
         Ft8tuwoh5+KUxpO54TJM95QrnR2MgG9i7fJRcsMHT5EV/5YQcaK/jOTTLqrvbLeqOuXS
         U5cJbHT3U7vg/aEyb6AnClC2sViRlsRH5YdeyUQUpy1+vgW2tYmpKwVMKiRQdttmAcGY
         EhHA==
X-Gm-Message-State: AC+VfDydXXXzwLP9RfP3vMchDe3oq6NdRv8EPLNb/C5wLPu9rai2tWdx
        k4eOWhwiBulVLH/QtOKIybzj9Z4QCK7duM24NQk=
X-Google-Smtp-Source: ACHHUZ6ZIRCVBDnfwfbNvrL01g++Xec9QUSL50It3xoN3gK5H50U71VMlL9ICBvlI9hpAX1207znlbccloVGQIAljRo=
X-Received: by 2002:a17:906:7785:b0:976:7c67:4bf8 with SMTP id
 s5-20020a170906778500b009767c674bf8mr7978496ejm.5.1686590255587; Mon, 12 Jun
 2023 10:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230607025718.29636-1-mario.limonciello@amd.com>
In-Reply-To: <20230607025718.29636-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jun 2023 19:17:24 +0200
Message-ID: <CAJZ5v0gd=1qijdxrz=yF3Tf972XGTesJyto1ezVTXqov9ZOnmQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Call _REG when transitioning D-states
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 7, 2023 at 6:05 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Section 6.5.4 of the ACPI 6.4 spec describes how AML is unable to access
> an OperationRegion unless `_REG` has been called.
>
> "The OS runs _REG control methods to inform AML code of a change in the
> availability of an operation region. When an operation region handler
> is unavailable, AML cannot access data fields in that region.
> (Operation region writes will be ignored and reads will return
> indeterminate data.)"
>
> The PCI core does not call `_REG` at anytime, leading to the undefined
> behavior mentioned in the spec.
>
> The spec explains that _REG should be executed to indicate whether a
> given region can be accessed.
>
> "Once _REG has been executed for a particular operation region, indicating
> that the operation region handler is ready, a control method can
> access fields in the operation region. Conversely, control methods
> must not access fields in operation regions when _REG method execution
> has not indicated that the operation region handler is ready."
>
> An example included in the spec demonstrates calling _REG when devices are
> turned off: "when the host controller or bridge controller is turned off
> or disabled, PCI Config Space Operation Regions for child devices are
> no longer available. As such, ETH0’s _REG method will be run when it
> is turned off and will again be run when PCI1 is turned off.".
>
> It is reported that ASMedia PCIe GPIO controllers fail functional tests
> after the system has returning from suspend (S3 or s2idle). This is
> because the BIOS checks whether the OSPM has called the `_REG` method
> to determine whether it can interact with the OperationRegion assigned
> to the device as part of the other AML called for the device.
>
> To fix this issue, call acpi_evaluate_reg() when devices are
> transitioning between power states.
>
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3:
>  * Move call site
>  * Rename static function to better describe behavior
>  * call _REG with disconnect /before/ going into D3
>  * call _REG with connect /after/ going into D0/D1/D2
>  * Update commit message
> v1->v2:
>  * Handle case of no CONFIG_ACPI
>  * Rename function
>  * Update commit message
>  * Move ACPI calling code into pci-acpi.c instead
>  * Cite the ACPI spec
> ---
>  drivers/pci/pci-acpi.c | 42 +++++++++++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 1698205dd73c..2c80ae4ed362 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1043,6 +1043,16 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>         return false;
>  }
>
> +static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
> +{
> +       int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
> +       int ret = acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
> +                                   ACPI_ADR_SPACE_PCI_CONFIG, val);
> +       if (ret)
> +               pci_dbg(dev, "ACPI _REG %s evaluation failed (%d)\n",
> +                       enable ? "connect" : "disconnect", ret);
> +}
> +
>  int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  {
>         struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> @@ -1053,32 +1063,38 @@ int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>                 [PCI_D3hot] = ACPI_STATE_D3_HOT,
>                 [PCI_D3cold] = ACPI_STATE_D3_COLD,
>         };
> -       int error = -EINVAL;
> +       int ret;
>
>         /* If the ACPI device has _EJ0, ignore the device */
>         if (!adev || acpi_has_method(adev->handle, "_EJ0"))
>                 return -ENODEV;
>
>         switch (state) {
> +       case PCI_POWER_ERROR:
> +       case PCI_UNKNOWN:
> +               return -EINVAL;
>         case PCI_D3cold:
>                 if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
> -                               PM_QOS_FLAGS_ALL) {
> -                       error = -EBUSY;
> -                       break;
> -               }
> +                                    PM_QOS_FLAGS_ALL)
> +                       return -EBUSY;
>                 fallthrough;
> -       case PCI_D0:
> -       case PCI_D1:
> -       case PCI_D2:
>         case PCI_D3hot:

The PCI PM spec (which should be followed by all PCIe devices AFAICS)
mandates that the config space be available in D3hot as well as in
D1-2.  I guess this is not the case on the affected systems?

Or is this about the config space of devices below dev, which is a bridge?

> -               error = acpi_device_set_power(adev, state_conv[state]);
> +               /* Notify AML lack of PCI config space availability */
> +               acpi_pci_config_space_access(dev, false);
> +               break;
>         }
>
> -       if (!error)
> -               pci_dbg(dev, "power state changed by ACPI to %s\n",
> -                       acpi_power_state_string(adev->power.state));
> +       ret = acpi_device_set_power(adev, state_conv[state]);
> +       if (ret)
> +               return ret;
> +       pci_dbg(dev, "power state changed by ACPI to %s\n",
> +               acpi_power_state_string(adev->power.state));
>
> -       return error;
> +       /* Notify AML of PCI config space availability */
> +       if (state < PCI_D3hot)
> +               acpi_pci_config_space_access(dev, true);

I would be careful here.

I'm not sure why it is necessary to do this on transitions, say, from
D0 into D1.

It looks like it would be sufficient to do it only when state == D0.

> +
> +       return 0;
>  }
>
>  pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
> --

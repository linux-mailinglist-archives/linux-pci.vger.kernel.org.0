Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6122738309
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 14:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjFUL0P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 21 Jun 2023 07:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjFUL0P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 07:26:15 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A2E135;
        Wed, 21 Jun 2023 04:26:13 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-98771dde617so143226266b.1;
        Wed, 21 Jun 2023 04:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687346772; x=1689938772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+hhxEKxHxo0FVXzuRJqeTB65frIlGm+Gfp8aKBl/wg=;
        b=AWeXuJwNfZ2QNcTOXKgZG5j3OVzCKu+SUDSycvizytJ+81gu3+ONGiwVa73sLye8Rh
         +aaPy4ZUGcdKo5SJlSYKWrf5DNZH/KdtDB4lFvAORkHZejp391duK/sRrP47PeHz3VcQ
         IygkrLCndus9jCvjZUctatOKJxjbzw0Ea2wnMZuZDVXVKp5yYDlu6In9X9qh1arujIAG
         dUtHQ/xtJV20d0qziAKAhDU//jkjE5cWuJQXGAPvS7s5up9atipjTIFdA4kFVC/UcHzf
         3wxzu4tfj1qwDg4SGDqpc+TTRtmLs6rQNBDj8OJA2sskMyLjRCb12lQb0LvQl6vhCXG9
         V+qw==
X-Gm-Message-State: AC+VfDyK8ANvrTy2xAmnDqbtXndH8syDrfrC1Fnb1riE3UGsmJFKVDzh
        ikSbUqOntc0wXRi5SUs0iCotEdYnDbWH+60dGxk=
X-Google-Smtp-Source: ACHHUZ4VQCG8vtjvCWS+qOYfQhfmZsu27Tns8K738Nt4JOJk0ae2XFvOPB2OXWrvkq9gW6s4LDPPz3aooiA+YdpyYa8=
X-Received: by 2002:a17:906:64cc:b0:987:115d:ba05 with SMTP id
 p12-20020a17090664cc00b00987115dba05mr11787562ejn.3.1687346771859; Wed, 21
 Jun 2023 04:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230620140451.21007-1-mario.limonciello@amd.com>
In-Reply-To: <20230620140451.21007-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Jun 2023 13:25:59 +0200
Message-ID: <CAJZ5v0hHcY4RQSu8JT8xJM7mJs6WTQ2+TJsVZ02EoizaBGkAvQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Call _REG when transitioning D-states
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

On Tue, Jun 20, 2023 at 4:23 PM Mario Limonciello
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
> transitioning to D3cold or D0.
>
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3->v4:
>  * Only enable config space access for D0 state instead of D1/D2 states.
>  * Only disallow config space access for D3cold state.

I would ACPI to the patch subject, like "PCI: ACPI: Call ...", but
that can be done when applying the patch, and it is the only comment I
have to this version, so

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

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
>  drivers/pci/pci-acpi.c | 44 ++++++++++++++++++++++++++++--------------
>  1 file changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 052a611081ec..182cac535250 100644
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
> @@ -1053,32 +1063,36 @@ int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
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
> -               fallthrough;
> -       case PCI_D0:
> -       case PCI_D1:
> -       case PCI_D2:
> -       case PCI_D3hot:
> -               error = acpi_device_set_power(adev, state_conv[state]);
> +                                    PM_QOS_FLAGS_ALL)
> +                       return -EBUSY;
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
> +       if (state == PCI_D0)
> +               acpi_pci_config_space_access(dev, true);
> +
> +       return 0;
>  }
>
>  pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
> --
> 2.34.1
>

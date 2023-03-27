Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92B36C9B70
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 08:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjC0GjU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 02:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjC0GjT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 02:39:19 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0382140C3;
        Sun, 26 Mar 2023 23:39:16 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id bn14so4474932pgb.11;
        Sun, 26 Mar 2023 23:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679899155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cA+h4cW7bS5QMhc2GeLujGQv7axs1KyDCUQ4H4EHlTc=;
        b=RStl+2N5eEXhnZ4ov2uhIPwX1sDuAhSn04jchEuqxcQgRE+5BydO7SCs2hj1IvJJdT
         KeSjrwrqTo7nYCCm/QHVvfbtfcJ4RN/OoLd1koDuAXbDRMLINtaoJJSmRerykc04YskV
         ltpsYSJa+4SjlXYY27qtm94fZ/cUCJavLtBl/gTciG2KTWd1J2xWF7sykbW5DkmGyQP/
         vLeaAe1MpjekfF2+absdHbVNcC+CsPODsrwjtv20zF569iV/S+mL2yOyTifWTV3SkcQa
         hvXTjNC43Ej/Y1hlPGs0W0pM6B9esB7TUwtnYYNCiSSoTW2P0GeyC2QsqqS95Nz8y4vX
         O9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679899155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cA+h4cW7bS5QMhc2GeLujGQv7axs1KyDCUQ4H4EHlTc=;
        b=JXE1EMj8ZZoIdlh5fSy3lMnP7fpCPAXpjGRd21K1aPD/oskAU0WJvrLkeV5Hl3xvMM
         XZSuuM84ziO9Y/iIufHMldsA8D63Yvr6mCojJAQFArj5UwWDLRQDdPqzbNrqNRSjLft6
         W2qH9yWLQo/B1xUUR6g3G9XFWf1xCPDsMZ1S4BL/JWl2tYpURtWL/aSc5SSx50vbnDpS
         h86Cu60UBuSTEetH0DPgp+TbfzwiD2llcAEGmUXI4GotDccnRgQM85B/1ds5AxjW3mi7
         ajDLPwCaQbUG0yVFd9LhA/fWFo4pYxn6dfad4yVEFcUbqeKunQ/IBBz3LCKydvoJ1dtE
         WPow==
X-Gm-Message-State: AAQBX9e/jaic1ikV1UoNZcUpSM5586YLOig1h6ZnZZIzxPikhp4fWmY/
        TaeN4hn5n9Kr4xXOgr+Bz7fx7JILPBRMVn3FiuM=
X-Google-Smtp-Source: AKy350b+JjOeVv1nh07UqJAH32FY6Z3m4WsW1Y4L12/UPCjLAd3AirzoLohYzQ87C9JLJXEuSeSF23BSPBtxFl4pAC8=
X-Received: by 2002:a05:6a00:1a8b:b0:625:dac0:5263 with SMTP id
 e11-20020a056a001a8b00b00625dac05263mr5956249pfv.0.1679899155457; Sun, 26 Mar
 2023 23:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230320132316.3126838-1-korantwork@gmail.com>
In-Reply-To: <20230320132316.3126838-1-korantwork@gmail.com>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Mon, 27 Mar 2023 14:39:04 +0800
Message-ID: <CAEm4hYXDwkjt9hYUkerkD6KvtCCdLXtz1D34WFrmjPNsTxLANw@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: vmd: Add the module param to adjust MSI mode
To:     helgaas@kernel.org, nirmal.patel@linux.intel.com,
        kbusch@kernel.org, jonathan.derrick@linux.dev,
        lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Friendly ping~


On Mon, Mar 20, 2023 at 9:23=E2=80=AFPM <korantwork@gmail.com> wrote:
>
> From: Xinghui Li <korantli@tencent.com>
>
> In the legacy, the vmd MSI mode can only be adjusted by configuring
> vmd_ids table. This patch adds another way to adjust MSI mode by
> adjusting module param, which allows users easier to adjust the vmd
> according to the I/O scenario without rebuilding driver. There are two
> params that could be recognized: on, off. The default param is NULL,
> the goal is not to effect the existing settings of the device.
>
> Signed-off-by: Xinghui Li <korantli@tencent.com>
> Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 990630ec57c6..fb61181baa9e 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -34,6 +34,19 @@
>  #define MB2_SHADOW_OFFSET      0x2000
>  #define MB2_SHADOW_SIZE                16
>
> +/*
> + * The VMD msi_remap module parameter provides the alternative way
> + * to adjust MSI mode when loading vmd.ko other than vmd_ids table.
> + * There are two params could be recognized:
> + *
> + * off: disable MSI remapping
> + * on:  enable MSI remapping
> + *
> + */
> +static char *msi_remap;
> +module_param(msi_remap, charp, 0444);
> +MODULE_PARM_DESC(msi_remap, "Whether to enable MSI remapping function");
> +
>  enum vmd_features {
>         /*
>          * Device may contain registers which hint the physical location =
of the
> @@ -875,6 +888,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, uns=
igned long features)
>                         return ret;
>
>                 vmd_set_msi_remapping(vmd, true);
> +               dev_info(&vmd->dev->dev, "init vmd with remapping MSI\n")=
;
>
>                 ret =3D vmd_create_irq_domain(vmd);
>                 if (ret)
> @@ -887,6 +901,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, uns=
igned long features)
>                 irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_V=
MD_MSI);
>         } else {
>                 vmd_set_msi_remapping(vmd, false);
> +               dev_info(&vmd->dev->dev, "init vmd with bypass MSI\n");
>         }
>
>         pci_add_resource(&resources, &vmd->resources[0]);
> @@ -955,6 +970,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, un=
signed long features)
>         return 0;
>  }
>
> +static void vmd_config_msi_remap_param(unsigned long *features)
> +{
> +       if (msi_remap) {
> +               if (strcmp(msi_remap, "on") =3D=3D 0)
> +                       *features &=3D ~(VMD_FEAT_CAN_BYPASS_MSI_REMAP);
> +               else if (strcmp(msi_remap, "off") =3D=3D 0)
> +                       *features |=3D VMD_FEAT_CAN_BYPASS_MSI_REMAP;
> +       }
> +}
> +
>  static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id=
)
>  {
>         unsigned long features =3D (unsigned long) id->driver_data;
> @@ -984,6 +1009,8 @@ static int vmd_probe(struct pci_dev *dev, const stru=
ct pci_device_id *id)
>         if (err < 0)
>                 goto out_release_instance;
>
> +       vmd_config_msi_remap_param(&features);
> +
>         vmd->cfgbar =3D pcim_iomap(dev, VMD_CFGBAR, 0);
>         if (!vmd->cfgbar) {
>                 err =3D -ENOMEM;
> --
> 2.31.1
>

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4FC6A3B67
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 07:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjB0G44 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 01:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0G4z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 01:56:55 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8373414EA8;
        Sun, 26 Feb 2023 22:56:51 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id gi3-20020a17090b110300b0023762f642dcso5191566pjb.4;
        Sun, 26 Feb 2023 22:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFne0so2RLlbAsf94ASsGCwVWQNiBU45K9xYyay0Ac4=;
        b=QJvMuh5vTpiOwjkcodrulfr0g+ZGfpwYmtLMVXUBqogkNdsuV2Scmatq2u+2ySdye1
         DMTgp5OmwISYHTi83e3lZFdVUCCNerPHkS+TM5DYZ4UQST0ykHhGnzTx4dF7wnBGmhCO
         9jaZjW/31TOZrbc0658LelrBxUfoWkCnN9tnxWR9Hq+zoHeqe3Q+cq+d4b7R8jvXnml5
         ZCjcTEINwx5P2TfdBdBRVzxBk+RWtCDXu2VOX0lswuPn846xxpsjHzuQB6qHrP28j1/N
         LM/lMTlb6y9uLlxgkJdunOgcrVU06J8Jj3JDU8OG9WS+bn+g3CbW8JIwmh+DepLXoFZ6
         LHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFne0so2RLlbAsf94ASsGCwVWQNiBU45K9xYyay0Ac4=;
        b=PI+47512Aa5FT6cmSpG2e0rYe400pXIBrjJcFhmtJTyiCKieBqTarGkJRPYIorr3XR
         eQPSYLtWWUl/wIu6k1sOZwTVITPLAyNgvYq50INW4tvJjTzTyFNnY8nL+Mqgj0jQBkrN
         62JmzTN7y2H3Jv3NsYZ61pGAiyBHr6OmcdjaB9aa9v8iyUUlXRwCx6XJhg5v5DcOq+NF
         VBGWxRqwnGVeNTmGnBXg6NeRgCIK51Ua4uGV26i8ic8ouHiV3qKYULA1xV9/P0LB10QE
         PccvkIzB2Nn79z9BWnloevO3n7rx0PvI8GIsvs5xcSJ2iGSI+4UB09um2uuDtc8+SRpt
         keKQ==
X-Gm-Message-State: AO0yUKU19/Ps0j4ByYdxPUJiRIzDvKyVC5AtYNZL6WCL1Y/0E9jsF2Ro
        PFWGIGdWVgwA2yxQ3Vae4dFckj3K9agh8YMPANg=
X-Google-Smtp-Source: AK7set8wP28czRVvzxMxwDHPHLavc0JERLBBY+tVp8pznO7VxJq0w4C8BdHYj+AYalcOhLduh9vOyIH7aftpL+WVNFI=
X-Received: by 2002:a17:90a:c296:b0:234:1fac:f291 with SMTP id
 f22-20020a17090ac29600b002341facf291mr4404939pjt.8.1677481010962; Sun, 26 Feb
 2023 22:56:50 -0800 (PST)
MIME-Version: 1.0
References: <20230227064800.340833-1-korantwork@gmail.com>
In-Reply-To: <20230227064800.340833-1-korantwork@gmail.com>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Mon, 27 Feb 2023 14:57:50 +0800
Message-ID: <CAEm4hYU0tnq2epaCUAeq=vpsfAfX2Sr_Z7cJa_-fHsjhc2epUw@mail.gmail.com>
Subject: Re: [PATCH] PCI:vmd: add the module param to adjust msi mode
To:     nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

<korantwork@gmail.com> =E4=BA=8E2023=E5=B9=B42=E6=9C=8827=E6=97=A5=E5=91=A8=
=E4=B8=80 14:48=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Xinghui Li <korantli@tencent.com>
>
> In the legacy, the vmd msi-mode can only be adjusted by configing
> vmd_ids table.This patch adds another way to adjust msi mode by
> adjusting module param, which allow users easier to adjust the vmd
> according to the I/O scenario without rebuilding driver.There are two
> params could be recognized: remapping, bypass.
>
> Signed-off-by: Xinghui Li <korantli@tencent.com>
> ---
>  drivers/pci/controller/vmd.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 769eedeb8802..6d3272f5598d 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -34,6 +34,18 @@
>  #define MB2_SHADOW_OFFSET      0x2000
>  #define MB2_SHADOW_SIZE                16
>
> +/*
> + * The VMD msi_mode module parameter provides the alternative way
> + * to adjust msi_mode when load vmd.ko other than vmd_ids table.
> + * There are two params could be recognized:
> + *
> + * 1-remapping
> + * 2-bypass
> + *
> + */
> +char *msi_mode =3D "default";
> +module_param(msi_mode, charp, 0444);
> +
>  enum vmd_features {
>         /*
>          * Device may contain registers which hint the physical location =
of the
> @@ -820,6 +832,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, uns=
igned long features)
>                         return ret;
>
>                 vmd_set_msi_remapping(vmd, true);
> +               dev_info(&vmd->dev->dev, "init vmd with remapping msi-x\n=
");
>
>                 ret =3D vmd_create_irq_domain(vmd);
>                 if (ret)
> @@ -832,6 +845,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, uns=
igned long features)
>                 irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_V=
MD_MSI);
>         } else {
>                 vmd_set_msi_remapping(vmd, false);
> +               dev_info(&vmd->dev->dev, "init vmd with bypass msi-x\n");
>         }
>
>         pci_add_resource(&resources, &vmd->resources[0]);
> @@ -898,6 +912,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, un=
signed long features)
>         return 0;
>  }
>
> +static void vmd_config_msi_mode_param(unsigned long *features)
> +{
> +       if (strcmp(msi_mode, "remapping") =3D=3D 0)
> +               *features &=3D ~(VMD_FEAT_CAN_BYPASS_MSI_REMAP);
> +       else if (strcmp(msi_mode, "bypass") =3D=3D 0)
> +               *features |=3D VMD_FEAT_CAN_BYPASS_MSI_REMAP;
> +}
> +
>  static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id=
)
>  {
>         unsigned long features =3D (unsigned long) id->driver_data;
> @@ -927,6 +949,8 @@ static int vmd_probe(struct pci_dev *dev, const struc=
t pci_device_id *id)
>         if (err < 0)
>                 goto out_release_instance;
>
> +       vmd_config_msi_mode_param(&features);
> +
>         vmd->cfgbar =3D pcim_iomap(dev, VMD_CFGBAR, 0);
>         if (!vmd->cfgbar) {
>                 err =3D -ENOMEM;
> --
> 2.34.1
>

Hi all:
As we discussed in last patch (PCI: vmd: Do not disable MSI-X
remapping in VMD 28C0 controller).
I add the module param in vmd driver to adjust msi-x working mode. I
try not to modify the default mode.
And as for the `programmatic way`, I design to add the `automatic`
parameter in the next patch, which needs
more testing of different IO scenarios.

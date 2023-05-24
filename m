Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6A270ED2F
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 07:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbjEXFkR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 May 2023 01:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239424AbjEXFkN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 01:40:13 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18A918B
        for <linux-pci@vger.kernel.org>; Tue, 23 May 2023 22:40:11 -0700 (PDT)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A96973F4D5
        for <linux-pci@vger.kernel.org>; Wed, 24 May 2023 05:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684906808;
        bh=mkqBjgsXEnqUgI19bHhjtHZnSln537X6UG+qVPFXPi4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=uX/ikWSgrAPklaLmqjS23/NHaK94mmu5yXY5b7iUXJ2OR9UUhbSEgooTs08sV0TEC
         xaGV5nsgTfeC5LXSd5NqprVfmFC36lagtuX22zd4+r4sC2WWR1sCYfVdsxBeafhhqu
         eHSgvtAfVspyq91XCSGvP6tuBDFaJrypRzZBZcomQRL61qXMuR6wS/D1As2GmK4J6G
         TFcWCS8VcHz+C58cQkWt6CNIBreyq/9OBmyLM0vMwmDXCoLY5Dr467BVvIr1lt3Onc
         jwq9VsTCwkn6fbw2M4uypsAX3J+vApsw3yz40PM5oD6A4J9eiudBg0YmjxO20eJZLT
         Jhj2u3TtGsJSw==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-254b056a36dso289789a91.1
        for <linux-pci@vger.kernel.org>; Tue, 23 May 2023 22:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684906806; x=1687498806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkqBjgsXEnqUgI19bHhjtHZnSln537X6UG+qVPFXPi4=;
        b=XTnGJY1sd02ILTI3EI5lXsQNP2qRjP62+31HC3u5obhWRDBKOsZC7OS8+osXSTFwla
         j97Mmds1yCCp0GiiAdEaxdM6QWrCIBk/r8UBAK5ebE64TnTlRXx5FAFZKG1VXi+Ns8IK
         XPQq+dSPYAHEHRjRRJ27uyO5rYYS5CwkpehVgJRlggjay3/X+WduJ98RVAETKasaAUsq
         6P9ow4bvWe+X+77jmVlJ8qtL4EnpsTy5+SZHrQ9z5drqcSfqkSFkenBAbnWLjjHdPdo4
         gxPBSr9xPQocPuEl/Od1gnVJYmrFV1bzLUX2yE1OyO8AgExIlTB7o5t7fGC8gqfXuL68
         Vi2Q==
X-Gm-Message-State: AC+VfDzlElv1I5zNcRKem9Ab8syRB0tiQdO/SDG3pUZ71ComDYmTckeD
        5BOCZdLl5C+Xy6A9l7KkZPwAuy4ATlt22wtn4vpL/feIdwRG1lmP9r82RMZ5K1UNToKwO9JkmoY
        gaRoyG6elo8Fe+p4UTtPVsF3BHU9xRuz5PtIxg4id9l5Zkbvs4pDXzg==
X-Received: by 2002:a17:90b:1112:b0:255:a7ed:94a1 with SMTP id gi18-20020a17090b111200b00255a7ed94a1mr4546975pjb.41.1684906806731;
        Tue, 23 May 2023 22:40:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ66a/YFsioQJzWAMMZm6QJ/C879R0FzI+s++JhPPfkNt8VQQ1tqNYRy6IyOtPNMdQv+p+ljCuVHYDzlbNGYqV8=
X-Received: by 2002:a17:90b:1112:b0:255:a7ed:94a1 with SMTP id
 gi18-20020a17090b111200b00255a7ed94a1mr4546954pjb.41.1684906806415; Tue, 23
 May 2023 22:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230512000014.118942-1-kai.heng.feng@canonical.com>
In-Reply-To: <20230512000014.118942-1-kai.heng.feng@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 24 May 2023 13:39:54 +0800
Message-ID: <CAAd53p5QS3c0P3K3LOt1pJRmrLZtK-z7+vbUk2GqEypQuvRz9Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] PCI/AER: Factor out interrupt toggling into helpers
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Fri, May 12, 2023 at 8:01=E2=80=AFAM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> There are many places that enable and disable AER interrupt, so move
> them into helpers.

Do you think the series is good to be be merged now?

Kai-Heng

>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v6:
>  - No change.
>
> v5:
>  - Fix misspelling.
>
> v4:
>  - No change.
>
> v3:
>  - Correct subject.
>
> v2:
>  - New patch.
>
>  drivers/pci/pcie/aer.c | 45 +++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f6c24ded134c..1420e1f27105 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1227,6 +1227,28 @@ static irqreturn_t aer_irq(int irq, void *context)
>         return IRQ_WAKE_THREAD;
>  }
>
> +static void aer_enable_irq(struct pci_dev *pdev)
> +{
> +       int aer =3D pdev->aer_cap;
> +       u32 reg32;
> +
> +       /* Enable Root Port's interrupt in response to error messages */
> +       pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> +       reg32 |=3D ROOT_PORT_INTR_ON_MESG_MASK;
> +       pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +}
> +
> +static void aer_disable_irq(struct pci_dev *pdev)
> +{
> +       int aer =3D pdev->aer_cap;
> +       u32 reg32;
> +
> +       /* Disable Root's interrupt in response to error messages */
> +       pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> +       reg32 &=3D ~ROOT_PORT_INTR_ON_MESG_MASK;
> +       pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +}
> +
>  /**
>   * aer_enable_rootport - enable Root Port's interrupts when receiving me=
ssages
>   * @rpc: pointer to a Root Port data structure
> @@ -1256,10 +1278,7 @@ static void aer_enable_rootport(struct aer_rpc *rp=
c)
>         pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);
>         pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, reg32);
>
> -       /* Enable Root Port's interrupt in response to error messages */
> -       pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -       reg32 |=3D ROOT_PORT_INTR_ON_MESG_MASK;
> -       pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +       aer_enable_irq(pdev);
>  }
>
>  /**
> @@ -1274,10 +1293,7 @@ static void aer_disable_rootport(struct aer_rpc *r=
pc)
>         int aer =3D pdev->aer_cap;
>         u32 reg32;
>
> -       /* Disable Root's interrupt in response to error messages */
> -       pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -       reg32 &=3D ~ROOT_PORT_INTR_ON_MESG_MASK;
> -       pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +       aer_disable_irq(pdev);
>
>         /* Clear Root's error status reg */
>         pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> @@ -1372,12 +1388,8 @@ static pci_ers_result_t aer_root_reset(struct pci_=
dev *dev)
>          */
>         aer =3D root ? root->aer_cap : 0;
>
> -       if ((host->native_aer || pcie_ports_native) && aer) {
> -               /* Disable Root's interrupt in response to error messages=
 */
> -               pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &=
reg32);
> -               reg32 &=3D ~ROOT_PORT_INTR_ON_MESG_MASK;
> -               pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, =
reg32);
> -       }
> +       if ((host->native_aer || pcie_ports_native) && aer)
> +               aer_disable_irq(root);
>
>         if (type =3D=3D PCI_EXP_TYPE_RC_EC || type =3D=3D PCI_EXP_TYPE_RC=
_END) {
>                 rc =3D pcie_reset_flr(dev, PCI_RESET_DO_RESET);
> @@ -1396,10 +1408,7 @@ static pci_ers_result_t aer_root_reset(struct pci_=
dev *dev)
>                 pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &r=
eg32);
>                 pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, r=
eg32);
>
> -               /* Enable Root Port's interrupt in response to error mess=
ages */
> -               pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &=
reg32);
> -               reg32 |=3D ROOT_PORT_INTR_ON_MESG_MASK;
> -               pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, =
reg32);
> +               aer_enable_irq(root);
>         }
>
>         return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
> --
> 2.34.1
>

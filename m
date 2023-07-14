Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382EC7534D7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 10:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbjGNIQE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 04:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbjGNIPk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 04:15:40 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7C51FCD
        for <linux-pci@vger.kernel.org>; Fri, 14 Jul 2023 01:14:47 -0700 (PDT)
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 54F1B3F723
        for <linux-pci@vger.kernel.org>; Fri, 14 Jul 2023 08:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689322485;
        bh=3orHT4JM0Iv/tV5GPFY3h6ErKAXsnmT8WOqTtcRm+2w=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=pPULnrhluQ6I1pvUTo9pzd9hVmFL2eYQnIHwU90v36zXdhlFhUu6PsvI0oJ56CZ+I
         vJaZqT5fqvtz/RhK+ACDyAMRPbuUUbc2g3U1aa28KAopBKcIQHMsgeGLvC9vM2THZW
         xRfsNxABIFc118BDwUVEomGVRi6KW1jAUSWUnTtbITHbB+yxmIGLESb4h+72aHIEH0
         OJb2OWowLuA/KNSgOuXEAU4XmuHI828RbroQpIKYuxTfYism1LJSZ25iHmEwXfBMOD
         NGXpoOOkUohZPpRjvWzr8dQOf1rIMNm17yzzLLZbuvns7NLkRam1totJDlJtlR7oo3
         f1ok9PhDLMDdA==
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-565d30b4311so2378631eaf.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Jul 2023 01:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689322484; x=1691914484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3orHT4JM0Iv/tV5GPFY3h6ErKAXsnmT8WOqTtcRm+2w=;
        b=fuWzPjhEmOnWFM9NosTuBhWkwawlUBolPuTCmUqRJhQEdi7PLZ/aMOiQx+i+d2iI2T
         EjLKpF+TSc7o8jjaH4X/bYTPuHHWlX2M8SmX8Za9GKM9EfWB6bS4AfpSBmat9aCDJ172
         Axl21imB/u4jZX5yr+s2LlA+w1W/wkZy2mowX/qEv6BSLs6wDuzf1pUrYwzIAJL/ptmk
         +++V9Ygq6TZyiGSdqtwAcqTKxxfTTPIEATrlUZcnX6AlGDO+B9EfprSIY3XTQvQRY7al
         SR9JZPPNqISn/PMhVRTRQqbCJuoAvm/lVAtouU7MxVw/S5MzbYuHRpVc8yofe2m3XxiX
         +lEA==
X-Gm-Message-State: ABy/qLZdat5lUoTKHCe2+hpd0EpcYYZKGWmbAgCiqhFMBi+mNJCxB+ob
        3lBfpBguYjcvkKDE4eDXzq/j8wfPynK502s+AqtQynCzlQvVOJafDXVWfJrgwOc8AG2yCYwM44v
        GARWVCHZB1Rea5dlXfkH+8P/fYORfUEZb0/eYP9BqPaEJMz0xxjBXcQ==
X-Received: by 2002:a05:6358:5e0c:b0:134:ddad:2b51 with SMTP id q12-20020a0563585e0c00b00134ddad2b51mr4160618rwn.14.1689322484234;
        Fri, 14 Jul 2023 01:14:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHUGLglEJ2G95ivnaP/bf04GjYDd7FiIIQuh2B1oRfEBSPuFJkdc0euxQBZvVLKwTeqwDaQ+Vo90vDAhQelD+8=
X-Received: by 2002:a05:6358:5e0c:b0:134:ddad:2b51 with SMTP id
 q12-20020a0563585e0c00b00134ddad2b51mr4160605rwn.14.1689322483950; Fri, 14
 Jul 2023 01:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230512000014.118942-1-kai.heng.feng@canonical.com> <20230512000014.118942-2-kai.heng.feng@canonical.com>
In-Reply-To: <20230512000014.118942-2-kai.heng.feng@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 14 Jul 2023 16:14:32 +0800
Message-ID: <CAAd53p6KEMJzraFn5GWGfEWQQ6WJmKGxtuGRuP2esAib+6s+Lw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] PCI/AER: Disable AER interrupt on suspend
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 12, 2023 at 8:01=E2=80=AFAM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> PCIe services that share an IRQ with PME, such as AER or DPC, may cause a
> spurious wakeup on system suspend. To prevent this, disable the AER inter=
rupt
> notification during the system suspend process.
>
> As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power Manageme=
nt",
> TLP and DLLP transmission are disabled for a Link in L2/L3 Ready (D3hot),=
 L2
> (D3cold with aux power) and L3 (D3cold) states. So disabling the AER
> notification during suspend and re-enabling them during the resume proces=
s
> should not affect the basic functionality.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216295
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

A gentle ping...

> ---
> v6:
> v5:
>  - Wording.
>
> v4:
> v3:
>  - No change.
>
> v2:
>  - Only disable AER IRQ.
>  - No more check on PME IRQ#.
>  - Use helper.
>
>  drivers/pci/pcie/aer.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 1420e1f27105..9c07fdbeb52d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1356,6 +1356,26 @@ static int aer_probe(struct pcie_device *dev)
>         return 0;
>  }
>
> +static int aer_suspend(struct pcie_device *dev)
> +{
> +       struct aer_rpc *rpc =3D get_service_data(dev);
> +       struct pci_dev *pdev =3D rpc->rpd;
> +
> +       aer_disable_irq(pdev);
> +
> +       return 0;
> +}
> +
> +static int aer_resume(struct pcie_device *dev)
> +{
> +       struct aer_rpc *rpc =3D get_service_data(dev);
> +       struct pci_dev *pdev =3D rpc->rpd;
> +
> +       aer_enable_irq(pdev);
> +
> +       return 0;
> +}
> +
>  /**
>   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
>   * @dev: pointer to Root Port, RCEC, or RCiEP
> @@ -1420,6 +1440,8 @@ static struct pcie_port_service_driver aerdriver =
=3D {
>         .service        =3D PCIE_PORT_SERVICE_AER,
>
>         .probe          =3D aer_probe,
> +       .suspend        =3D aer_suspend,
> +       .resume         =3D aer_resume,
>         .remove         =3D aer_remove,
>  };
>
> --
> 2.34.1
>

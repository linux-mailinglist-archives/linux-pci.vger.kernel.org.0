Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9137C9D59
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 04:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjJPCML (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Oct 2023 22:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjJPCML (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Oct 2023 22:12:11 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C8FAB
        for <linux-pci@vger.kernel.org>; Sun, 15 Oct 2023 19:12:08 -0700 (PDT)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B4D2240517
        for <linux-pci@vger.kernel.org>; Mon, 16 Oct 2023 02:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697422325;
        bh=3CWqp/Rvnyitv/UP+j1Mm6bfBH+M3WyBXY1aKPmDGSQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=cgJfrsKu5QiE+MFFe5vGVLM1QLvOeHvHRZuSoZ2ghYhV1jA0h8chCQfF/ksClw5iK
         D061xR6Qs5lr3ZHeoF2zmUzl8Tsgj8IMCsJ7JMFMDXg50hvVGBHqxZNzDYQlCvdhve
         m3z0cv5KkK4SmURiyO8zPowzTd9d4AFSJHwxkM7aiEYezhBFymwBg4UzcwWn45jKGp
         kYhzXLkPi5cl1pZeSaMq+D9cTqRvxMaHvVyTivpuLWMgXLTgoI2/m4qzleRKVSftaI
         9iQf+jnl0X5xol+F2r7qEz/7fD5SGgcsAP4WHwvJ9SIsRFoqC6i/lFIFBUyfODBfvN
         EDLX8DPctJa/g==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-27d5568e99bso1394380a91.0
        for <linux-pci@vger.kernel.org>; Sun, 15 Oct 2023 19:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697422323; x=1698027123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CWqp/Rvnyitv/UP+j1Mm6bfBH+M3WyBXY1aKPmDGSQ=;
        b=vHU7LscbGg1g72iD4YTt3/0z6p2Jn9a2buiTQ0/Z3aR3wmQnf3Ek44ep2/v/LDPjJD
         H5D8zCTtU8Rgjf6ZhK0at3A4OT2cDC8ZWaLW5mE3yBYGa2cIiRQl16Y+f9qF10kyHzWI
         0It+I0wiZrukwjm1Q8vsUACkfx495tw7jHw99wjZJ9fGqFtWsNhvJP8rXNlQc0fnzuaQ
         Ie9dPY58ofNXJ37vfaWQ5wo9xCdm6LNeCi9XlM3/jhKVKYiWH4oJAhuYN45ru5aLMJxd
         a2dP373EpGad/xaO0fe1WsWptb16yA9NtnT/N2lVY3kleh3K1c0jNNrCuIxmxB5h/JFZ
         DmDg==
X-Gm-Message-State: AOJu0YwP288FIZn6kzSdVSUipLDlkzUbLTMa/KeTCCrzl8ZqO5fPLKlO
        lKZohx/GgMhMGP59aLEVC2bCvVQ/I/u8r6o/Qu1rLASKBXoUftAU0RrhkdhN/jq0QIPKGc0OJjA
        Iwz6FNRPfyu2ply3D2hoKZz/8zJAq7eT8Lij7PutRe9rsGnkl9vZHLluewdKjrY4c
X-Received: by 2002:a17:90b:fc7:b0:27d:1369:515e with SMTP id gd7-20020a17090b0fc700b0027d1369515emr8853843pjb.22.1697422323009;
        Sun, 15 Oct 2023 19:12:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5Ns0TOWQbb1kcSjj8hcas8vlsHO5Lqvb6DUbzJ+Au/4KaaJfw0M9iFaybR04eUTZQYRcgJEtNdW68XbwawCE=
X-Received: by 2002:a17:90b:fc7:b0:27d:1369:515e with SMTP id
 gd7-20020a17090b0fc700b0027d1369515emr8853825pjb.22.1697422322658; Sun, 15
 Oct 2023 19:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231009225653.36030-1-mario.limonciello@amd.com> <20231009225653.36030-5-mario.limonciello@amd.com>
In-Reply-To: <20231009225653.36030-5-mario.limonciello@amd.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 16 Oct 2023 10:11:50 +0800
Message-ID: <CAAd53p52668p46Bocx2z4VejGFvWz+JUHuz_J762zsD3sJPgUA@mail.gmail.com>
Subject: Re: [RFC v1 4/4] platform/x86/amd: pmc: Add support for using
 constraints to decide D3 policy
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mario,

On Tue, Oct 10, 2023 at 6:57=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The default kernel policy will allow modern machines to effectively put
> all PCIe bridges into PCI D3. This policy doesn't match what Windows uses=
.
>
> In Windows the driver stack includes a "Power Engine Plugin" (uPEP driver=
)
> to decide the policy for integrated devices using PEP device constraints.
>
> Device constraints are expressed as a number in the _DSM of the PNP0D80
> device and exported by the kernel in acpi_get_lps0_constraint().
>
> Add support for SoCs to use constraints on Linux as well for deciding
> target state for integrated PCI bridges.
>
> No SoCs are introduced by default with this change, they will be added
> later on a case by case basis.
>
> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-ex=
periences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc=
-dram
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/platform/x86/amd/pmc/pmc.c | 59 ++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/am=
d/pmc/pmc.c
> index c1e788b67a74..34e76c6b3fb2 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -570,6 +570,14 @@ static void amd_pmc_dbgfs_unregister(struct amd_pmc_=
dev *dev)
>         debugfs_remove_recursive(dev->dbgfs_dir);
>  }
>
> +static bool amd_pmc_use_acpi_constraints(struct amd_pmc_dev *dev)
> +{
> +       switch (dev->cpu_id) {
> +       default:
> +               return false;
> +       }
> +}
> +
>  static bool amd_pmc_is_stb_supported(struct amd_pmc_dev *dev)
>  {
>         switch (dev->cpu_id) {
> @@ -741,6 +749,41 @@ static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *p=
dev)
>         return 0;
>  }
>
> +/*
> + * Constraints are specified in the ACPI LPS0 device and specify what th=
e
> + * platform intended for the device.
> + *
> + * If a constraint is present and >=3D to ACPI_STATE_S3, then enable D3 =
for the
> + * device.
> + * If a constraint is not present or < ACPI_STATE_S3, then disable D3 fo=
r the
> + * device.
> + */
> +static enum bridge_d3_pref amd_pmc_d3_check(struct pci_dev *pci_dev)
> +{
> +       struct acpi_device *adev =3D ACPI_COMPANION(&pci_dev->dev);
> +       int constraint;
> +
> +       if (!adev)
> +               return BRIDGE_PREF_UNSET;
> +
> +       constraint =3D acpi_get_lps0_constraint(adev);
> +       dev_dbg(&pci_dev->dev, "constraint is %d\n", constraint);
> +
> +       switch (constraint) {
> +       case ACPI_STATE_UNKNOWN:
> +       case ACPI_STATE_S0:
> +       case ACPI_STATE_S1:
> +       case ACPI_STATE_S2:

I believe it's a typo?
I think ACPI_STATE_Dx should be used for device state.

> +               return BRIDGE_PREF_DRIVER_D0;
> +       case ACPI_STATE_S3:
> +               return BRIDGE_PREF_DRIVER_D3;

I've seen both 3 (i.e. ACPI_STATE_D3_HOT) and 4 (i.e.
ACPI_STATE_D3_COLD) defined in LPI constraint table.
Should those two be treated differently?

> +       default:
> +               break;
> +       }
> +
> +       return BRIDGE_PREF_UNSET;
> +}
> +
>  static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
>  {
>         struct rtc_device *rtc_device;
> @@ -881,6 +924,11 @@ static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev=
_ops =3D {
>         .restore =3D amd_pmc_s2idle_restore,
>  };
>
> +static struct pci_d3_driver_ops amd_pmc_d3_ops =3D {
> +       .check =3D amd_pmc_d3_check,
> +       .priority =3D 50,
> +};
> +
>  static int amd_pmc_suspend_handler(struct device *dev)
>  {
>         struct amd_pmc_dev *pdev =3D dev_get_drvdata(dev);
> @@ -1074,10 +1122,19 @@ static int amd_pmc_probe(struct platform_device *=
pdev)
>                         amd_pmc_quirks_init(dev);
>         }
>
> +       if (amd_pmc_use_acpi_constraints(dev)) {
> +               err =3D pci_register_driver_d3_policy_cb(&amd_pmc_d3_ops)=
;
> +               if (err)
> +                       goto err_register_lps0;
> +       }

Does this only apply to PCI? USB can have ACPI companion too.

Kai-Heng

> +
>         amd_pmc_dbgfs_register(dev);
>         pm_report_max_hw_sleep(U64_MAX);
>         return 0;
>
> +err_register_lps0:
> +       if (IS_ENABLED(CONFIG_SUSPEND))
> +               acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
>  err_pci_dev_put:
>         pci_dev_put(rdev);
>         return err;
> @@ -1089,6 +1146,8 @@ static void amd_pmc_remove(struct platform_device *=
pdev)
>
>         if (IS_ENABLED(CONFIG_SUSPEND))
>                 acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
> +       if (amd_pmc_use_acpi_constraints(dev))
> +               pci_unregister_driver_d3_policy_cb(&amd_pmc_d3_ops);
>         amd_pmc_dbgfs_unregister(dev);
>         pci_dev_put(dev->rdev);
>         mutex_destroy(&dev->lock);
> --
> 2.34.1
>

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61387D47EA
	for <lists+linux-pci@lfdr.de>; Tue, 24 Oct 2023 09:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjJXHGR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Oct 2023 03:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjJXHGQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Oct 2023 03:06:16 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183FE10C
        for <linux-pci@vger.kernel.org>; Tue, 24 Oct 2023 00:06:13 -0700 (PDT)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 91B253F140
        for <linux-pci@vger.kernel.org>; Tue, 24 Oct 2023 07:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698131171;
        bh=EndD1DBjqJwdCmtzp2faXNuo/OEsYvRMoLmrkZTQZzk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=lZsboZhYgGiv+obNaJBC1X27a3wqy00xAaF8cOm38kOCBPxW59xjy2Z0QjtJJzEYS
         7+csNNVvWRRABwOWi2reSMEyYnG/GiNHaz6k2CQJLCRc5QkAcQPpMUl6fXZCI2uaHP
         KeqpJuI7W1VKzH9reyDOu6/TNjJI08hZptJs/GYosgU2AxP54LReUjHv0PuYMNTyXE
         PDkssJvCdG9jmtgDC7CXSICtMN1VKGjR2JPsL2PYluZHXo7yLfBWppgBxBB7N6EMQr
         yU2dc6T9ugGrbrXHnBuVrgvT+8Or5+0ylb4IYA6+X05as5jtM0HiAZRfKJ5DEX0qK0
         fyRDKdo0o54uw==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5b83bc7c7b4so2431517a12.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Oct 2023 00:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698131170; x=1698735970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EndD1DBjqJwdCmtzp2faXNuo/OEsYvRMoLmrkZTQZzk=;
        b=EQL9N6TTfThSc9rtUw9byKvH9REuVs96ZVip11Q8LqKiAAyiwPuGS4Hfitt3BDs3jA
         sD0dk8vTFLkuV35wj5Q9GKhPdorP+BTfczkSvu+xxfgwhGgjCY2JH0TGtmkQvpMMZi8S
         hhLieFQuhLa9CACVMj590hl0mtWCGuF723sSmpKTZfqfx6jUJDBaMZuuaAK5/lzKMheL
         2nevN8gZTXfQhMlEchqH19IGPNpQ6ZUEZEdbvV7j+ie3LlQZFdDr8rve2KAOG5VVqm7e
         1jr7MrGEQEYG8lOD6/rXGLOlXbLpmpCzQmANMID1eDKXwEjYcBGDCa8Z/3J7o29BYte5
         bU5Q==
X-Gm-Message-State: AOJu0Ywsd/9PJK6R2WyIfBpe1y+ySqDLBcWSX5xX/cYgVESFmYdkGSDK
        MQC3Ot1JaEDAJ/f6vcgO+iIT9nyM2qHXSQmU9c/x4JRAiP5IxqKEr0cTY0p2mSfjWB1WaVAOh00
        nk7q4UVRKyTn1Yr3idekXFx63NrwY6PIaAJLF35H8Xqy30I9KQwBfdw==
X-Received: by 2002:a17:903:2002:b0:1c9:e072:3398 with SMTP id s2-20020a170903200200b001c9e0723398mr6127578pla.41.1698131169864;
        Tue, 24 Oct 2023 00:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE20e4aBaj4KbKdJ4L0DU/v/Z2owGwslyDee1e0RTX3xHd+Eu4b8Q7LAEY9Iv1UYue+9z54R4R2jTZ4e/9jLPY=
X-Received: by 2002:a17:903:2002:b0:1c9:e072:3398 with SMTP id
 s2-20020a170903200200b001c9e0723398mr6127567pla.41.1698131169523; Tue, 24 Oct
 2023 00:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231009225653.36030-1-mario.limonciello@amd.com>
 <20231009225653.36030-5-mario.limonciello@amd.com> <CAAd53p52668p46Bocx2z4VejGFvWz+JUHuz_J762zsD3sJPgUA@mail.gmail.com>
 <1ff61826-0cf4-441e-9e7c-7d8e4cce0606@amd.com>
In-Reply-To: <1ff61826-0cf4-441e-9e7c-7d8e4cce0606@amd.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 24 Oct 2023 15:05:56 +0800
Message-ID: <CAAd53p620SFMetOeig-JE7mJzMt7jpFcB8tA=SNSOhi93QMA2Q@mail.gmail.com>
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

On Tue, Oct 17, 2023 at 5:34=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 10/15/2023 21:11, Kai-Heng Feng wrote:
> > Hi Mario,
> >
> > On Tue, Oct 10, 2023 at 6:57=E2=80=AFAM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> The default kernel policy will allow modern machines to effectively pu=
t
> >> all PCIe bridges into PCI D3. This policy doesn't match what Windows u=
ses.
> >>
> >> In Windows the driver stack includes a "Power Engine Plugin" (uPEP dri=
ver)
> >> to decide the policy for integrated devices using PEP device constrain=
ts.
> >>
> >> Device constraints are expressed as a number in the _DSM of the PNP0D8=
0
> >> device and exported by the kernel in acpi_get_lps0_constraint().
> >>
> >> Add support for SoCs to use constraints on Linux as well for deciding
> >> target state for integrated PCI bridges.
> >>
> >> No SoCs are introduced by default with this change, they will be added
> >> later on a case by case basis.
> >>
> >> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device=
-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-=
soc-dram
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/platform/x86/amd/pmc/pmc.c | 59 ++++++++++++++++++++++++++++=
++
> >>   1 file changed, 59 insertions(+)
> >>
> >> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86=
/amd/pmc/pmc.c
> >> index c1e788b67a74..34e76c6b3fb2 100644
> >> --- a/drivers/platform/x86/amd/pmc/pmc.c
> >> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> >> @@ -570,6 +570,14 @@ static void amd_pmc_dbgfs_unregister(struct amd_p=
mc_dev *dev)
> >>          debugfs_remove_recursive(dev->dbgfs_dir);
> >>   }
> >>
> >> +static bool amd_pmc_use_acpi_constraints(struct amd_pmc_dev *dev)
> >> +{
> >> +       switch (dev->cpu_id) {
> >> +       default:
> >> +               return false;
> >> +       }
> >> +}
> >> +
> >>   static bool amd_pmc_is_stb_supported(struct amd_pmc_dev *dev)
> >>   {
> >>          switch (dev->cpu_id) {
> >> @@ -741,6 +749,41 @@ static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev=
 *pdev)
> >>          return 0;
> >>   }
> >>
> >> +/*
> >> + * Constraints are specified in the ACPI LPS0 device and specify what=
 the
> >> + * platform intended for the device.
> >> + *
> >> + * If a constraint is present and >=3D to ACPI_STATE_S3, then enable =
D3 for the
> >> + * device.
> >> + * If a constraint is not present or < ACPI_STATE_S3, then disable D3=
 for the
> >> + * device.
> >> + */
> >> +static enum bridge_d3_pref amd_pmc_d3_check(struct pci_dev *pci_dev)
> >> +{
> >> +       struct acpi_device *adev =3D ACPI_COMPANION(&pci_dev->dev);
> >> +       int constraint;
> >> +
> >> +       if (!adev)
> >> +               return BRIDGE_PREF_UNSET;
> >> +
> >> +       constraint =3D acpi_get_lps0_constraint(adev);
> >> +       dev_dbg(&pci_dev->dev, "constraint is %d\n", constraint);
> >> +
> >> +       switch (constraint) {
> >> +       case ACPI_STATE_UNKNOWN:
> >> +       case ACPI_STATE_S0:
> >> +       case ACPI_STATE_S1:
> >> +       case ACPI_STATE_S2:
> >
> > I believe it's a typo?
> > I think ACPI_STATE_Dx should be used for device state.
>
> Yes; typo thanks.
>
> >
> >> +               return BRIDGE_PREF_DRIVER_D0;
> >> +       case ACPI_STATE_S3:
> >> +               return BRIDGE_PREF_DRIVER_D3;
> >
> > I've seen both 3 (i.e. ACPI_STATE_D3_HOT) and 4 (i.e.
> > ACPI_STATE_D3_COLD) defined in LPI constraint table.
> > Should those two be treated differently?
>
> Was this AMD system or Intel system?  AFAIK AMD doesn't use D3cold in
> constraints, they are collectively "D3".

Intel based system.

So the final D3 state is decided by the presence of power resources?

>
> >
> >> +       default:
> >> +               break;
> >> +       }
> >> +
> >> +       return BRIDGE_PREF_UNSET;
> >> +}
> >> +
> >>   static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg=
)
> >>   {
> >>          struct rtc_device *rtc_device;
> >> @@ -881,6 +924,11 @@ static struct acpi_s2idle_dev_ops amd_pmc_s2idle_=
dev_ops =3D {
> >>          .restore =3D amd_pmc_s2idle_restore,
> >>   };
> >>
> >> +static struct pci_d3_driver_ops amd_pmc_d3_ops =3D {
> >> +       .check =3D amd_pmc_d3_check,
> >> +       .priority =3D 50,
> >> +};
> >> +
> >>   static int amd_pmc_suspend_handler(struct device *dev)
> >>   {
> >>          struct amd_pmc_dev *pdev =3D dev_get_drvdata(dev);
> >> @@ -1074,10 +1122,19 @@ static int amd_pmc_probe(struct platform_devic=
e *pdev)
> >>                          amd_pmc_quirks_init(dev);
> >>          }
> >>
> >> +       if (amd_pmc_use_acpi_constraints(dev)) {
> >> +               err =3D pci_register_driver_d3_policy_cb(&amd_pmc_d3_o=
ps);
> >> +               if (err)
> >> +                       goto err_register_lps0;
> >> +       }
> >
> > Does this only apply to PCI? USB can have ACPI companion too.
>
> It only applies to things in the constraints, which is only "SOC
> internal" devices.  No internal USB devices.

So sounds like it only applies to PCI devices?

Kai-Heng

>
> >
> > Kai-Heng
> >
> >> +
> >>          amd_pmc_dbgfs_register(dev);
> >>          pm_report_max_hw_sleep(U64_MAX);
> >>          return 0;
> >>
> >> +err_register_lps0:
> >> +       if (IS_ENABLED(CONFIG_SUSPEND))
> >> +               acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
> >>   err_pci_dev_put:
> >>          pci_dev_put(rdev);
> >>          return err;
> >> @@ -1089,6 +1146,8 @@ static void amd_pmc_remove(struct platform_devic=
e *pdev)
> >>
> >>          if (IS_ENABLED(CONFIG_SUSPEND))
> >>                  acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
> >> +       if (amd_pmc_use_acpi_constraints(dev))
> >> +               pci_unregister_driver_d3_policy_cb(&amd_pmc_d3_ops);
> >>          amd_pmc_dbgfs_unregister(dev);
> >>          pci_dev_put(dev->rdev);
> >>          mutex_destroy(&dev->lock);
> >> --
> >> 2.34.1
> >>
>

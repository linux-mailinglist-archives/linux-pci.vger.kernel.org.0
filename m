Return-Path: <linux-pci+bounces-978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9184E812AE9
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 10:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128B41F2120F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0562575F;
	Thu, 14 Dec 2023 09:00:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C2110A;
	Thu, 14 Dec 2023 01:00:44 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6d9db92bd71so1256231a34.1;
        Thu, 14 Dec 2023 01:00:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702544443; x=1703149243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8O4nwF4I2AcPkJT1QIWI/cJrF4RlMzbwWSkhPeiGBko=;
        b=LGWqyRVyHZb9pVLfkZrBr7AsOC12sZshnYVJzOYSlrAkOIdIn5Ukc301HueLdQ4X5q
         Ks7NzmoQk1K/ko6PW6LDQdusghU3CfYWnShHUgsacEdvMDZiNj7JYY0MYgS8UXqsROeh
         5f/xcKrHR8/3EyOxNw5aSxT3oeej+7pMzRbSbSNpbCPdoUlSKhjFq/1KUNYTqde8NDI9
         6Gw1sbwzQoO3KEqVdZjHDT+Zox0DwTrRBAAG+Ah/gp9VLUIyv6YFhaoDzCuQXvEo176J
         aYr2vyBGCfbvx0WRQC1Fmtq97/vrgN/4jtDBmumfeOeGvwwthpIJ1r54s7YUvI1VhMwu
         beHQ==
X-Gm-Message-State: AOJu0YxSqdQGQatT9H/2ooBWPBF7aTc4OLbg+i4zo6qpWx9ageFZkIwW
	aeMufkyJLrLbUxE0MPAdwA4Ns3VlRW9zDw00Ez8=
X-Google-Smtp-Source: AGHT+IFZpYa60lAareQ3ZEHnFSchBYPlLSAoD2qxfcpPXZR+Pl2p1AyfjRB4ecQ+l9wRAvWJSQttijM7lHh1wtroqYc=
X-Received: by 2002:a05:6870:b028:b0:1fb:e5f:c530 with SMTP id
 y40-20020a056870b02800b001fb0e5fc530mr17409236oae.4.1702544443386; Thu, 14
 Dec 2023 01:00:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213182656.6165-1-mario.limonciello@amd.com>
 <20231213182656.6165-3-mario.limonciello@amd.com> <CAJZ5v0gDjwEpx-WNSY0=qchoSGxizsD3XM7Bgq=i0xufBm=Cag@mail.gmail.com>
 <766d621c-695d-4ae7-87cf-690cb8d066df@amd.com> <CAJZ5v0i95EeS40pzkBH=jgB1wbMP6SNO_s=pNZ8FPOtcMywgAA@mail.gmail.com>
 <CAAd53p6XynUJimepnXDzcVa4Dps4-F0BNEXxGZh_O38LvSdkkg@mail.gmail.com>
In-Reply-To: <CAAd53p6XynUJimepnXDzcVa4Dps4-F0BNEXxGZh_O38LvSdkkg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Dec 2023 10:00:30 +0100
Message-ID: <CAJZ5v0ijf9-faD-bDaGi9U0JR4iQ68DECyPM8c-AeECOfhQ=Bg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI/portdrv: Place PCIe port hierarchy into D3cold at shutdown
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mpearson-lenovo@squebb.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 4:46=E2=80=AFAM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Mario and Rafael,
>
> On Thu, Dec 14, 2023 at 2:46=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Wed, Dec 13, 2023 at 7:42=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > >
> > > On 12/13/2023 12:38, Rafael J. Wysocki wrote:
> > > > On Wed, Dec 13, 2023 at 7:27=E2=80=AFPM Mario Limonciello
> > > > <mario.limonciello@amd.com> wrote:
> > > >>
> > > >> When a system is being powered off it's important that PCIe ports
> > > >> have been put into D3cold as there is no other software to turn
> > > >> off the devices at S5.
> > > >>
> > > >> If PCIe ports are left in D0 then any GPIOs toggled by the ACPI
> > > >> power resources may be left enabled and devices may consume excess
> > > >> power.
> > > >
> > > > Isn't that a platform firmware issue?
> > > >
> > > > It is the responsibility of the platform firmware to properly put t=
he
> > > > platform into S5, including power removal from devices that are not
> > > > armed for power-on.
> > >
> > > The specific issues that triggered this series were tied to the PCIe
> > > ports for dGPUs.  There is a GPIO that is toggled by _ON or _OFF.
> > >
> > > Windows calls _OFF as part of S5..
> >
> > I see.
> >
> > > >
> > > >> Cc: mpearson-lenovo@squebb.ca
> > > >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > >> ---
> > > >>   drivers/pci/pcie/portdrv.c | 11 ++++++++---
> > > >>   1 file changed, 8 insertions(+), 3 deletions(-)
> > > >>
> > > >> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv=
.c
> > > >> index 14a4b89a3b83..08238680c481 100644
> > > >> --- a/drivers/pci/pcie/portdrv.c
> > > >> +++ b/drivers/pci/pcie/portdrv.c
> > > >> @@ -734,9 +734,14 @@ static void pcie_portdrv_remove(struct pci_de=
v *dev)
> > > >>   static void pcie_portdrv_shutdown(struct pci_dev *dev)
> > > >>   {
> > > >>          if (pci_bridge_d3_possible(dev)) {
> > > >> -               pm_runtime_forbid(&dev->dev);
> > > >> -               pm_runtime_get_noresume(&dev->dev);
> > > >> -               pm_runtime_dont_use_autosuspend(&dev->dev);
> > > >> +               /* whole hierarchy goes into a low power state for=
 S5 */
> > > >> +               if (system_state =3D=3D SYSTEM_POWER_OFF) {
> > > >> +                       pci_set_power_state(dev, PCI_D3cold);
> > > >> +               } else {
> > > >> +                       pm_runtime_forbid(&dev->dev);
> > > >> +                       pm_runtime_get_noresume(&dev->dev);
> > > >> +                       pm_runtime_dont_use_autosuspend(&dev->dev)=
;
> > > >> +               }
> > > >>          }
> > > >
> > > > Wouldn't it be better to remove power from the port after running t=
he
> > > > code below?
> > > >
> > >
> > > Yes; I think you're right.  I'll do some more testing with this.
> > >
> > > >>          pcie_port_device_remove(dev);
> > > >> --
> >
> > IIRC, to do this all properly, you'd need to rework the shutdown path
> > to look like the hibernation power-off one.  Or even use the latter
> > for shutdown?
> >
> > There was no reason to do that till now, so it has not been done, but
> > it looks like you have one.
> >
>
> I am working on exactly same thing but with a different approach.
> Because this is needed for more than just PCI devices.
> I haven't written a proper commit message yet, but the implementation
> is quite simple:

As I said, doing this properly requires something like the hibernation
power-off transition to be carried out for S5.

I think that the existing hibernation power-off code can be used as-is
for this purpose even.

> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index f007116a8427..b90c6cf6faf4 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -967,15 +967,17 @@ EXPORT_SYMBOL_GPL(acpi_pm_set_device_wakeup);
>   * @adev: ACPI device node corresponding to @dev.
>   * @system_state: System state to choose the device state for.
>   */
> -static int acpi_dev_pm_low_power(struct device *dev, struct acpi_device =
*adev,
> -                 u32 system_state)
> +static int acpi_dev_pm_low_power(struct acpi_device *adev, void* data)
>  {
>      int ret, state;
> +    u32 *system_state =3D data;
>
>      if (!acpi_device_power_manageable(adev))
>          return 0;
>
> -    ret =3D acpi_dev_pm_get_state(dev, adev, system_state, NULL, &state)=
;
> +    acpi_dev_for_each_child(adev, acpi_dev_pm_low_power, data);
> +
> +    ret =3D acpi_dev_pm_get_state(&adev->dev, adev, *system_state, NULL,=
 &state);
>      return ret ? ret : acpi_device_set_power(adev, state);
>  }
>
> @@ -1016,7 +1018,7 @@ int acpi_dev_suspend(struct device *dev, bool wakeu=
p)
>          wakeup =3D false;
>      }
>
> -    error =3D acpi_dev_pm_low_power(dev, adev, target_state);
> +    error =3D acpi_dev_pm_low_power(adev, &target_state);
>      if (error && wakeup)
>          acpi_device_wakeup_disable(adev);
>
> @@ -1386,6 +1388,7 @@ static struct dev_pm_domain acpi_general_pm_domain =
=3D {
>  static void acpi_dev_pm_detach(struct device *dev, bool power_off)
>  {
>      struct acpi_device *adev =3D ACPI_COMPANION(dev);
> +    u32 state =3D ACPI_STATE_S0;
>
>      if (adev && dev->pm_domain =3D=3D &acpi_general_pm_domain) {
>          dev_pm_domain_set(dev, NULL);
> @@ -1400,7 +1403,7 @@ static void acpi_dev_pm_detach(struct device
> *dev, bool power_off)
>              dev_pm_qos_hide_latency_limit(dev);
>              dev_pm_qos_hide_flags(dev);
>              acpi_device_wakeup_disable(adev);
> -            acpi_dev_pm_low_power(dev, adev, ACPI_STATE_S0);
> +            acpi_dev_pm_low_power(adev, &state);
>          }
>      }
>  }
> @@ -1514,4 +1517,16 @@ bool acpi_dev_state_d0(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_state_d0);
>
> +void acpi_dev_shutdown(struct device *dev)
> +{
> +    struct acpi_device *adev =3D ACPI_COMPANION(dev);
> +    u32 state =3D ACPI_STATE_S5;
> +
> +    if (!adev)
> +        return;
> +
> +    acpi_device_wakeup_disable(adev);
> +    acpi_dev_pm_low_power(adev, &state);
> +}
> +EXPORT_SYMBOL_GPL(acpi_dev_shutdown);
>  #endif /* CONFIG_PM */
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 6ceaf50f5a67..7e7c99eade63 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -45,6 +45,15 @@ static void __fw_devlink_link_to_consumers(struct
> device *dev);
>  static bool fw_devlink_drv_reg_done;
>  static bool fw_devlink_best_effort;
>
> +#ifdef CONFIG_ACPI
> +static inline void fw_dev_shutdown(struct device *dev)
> +{
> +    acpi_dev_shutdown(dev);
> +}
> +#else
> +static inline void fw_dev_shutdown(struct device *dev) {  }
> +#endif
> +
>  /**
>   * __fwnode_link_add - Create a link between two fwnode_handles.
>   * @con: Consumer end of the link.
> @@ -4780,6 +4789,8 @@ void device_shutdown(void)
>              dev->driver->shutdown(dev);
>          }
>
> +        fw_dev_shutdown(dev);
> +
>          device_unlock(dev);
>          if (parent)
>              device_unlock(parent);
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 641dc4843987..374f9eb75c22 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1130,6 +1130,7 @@ int acpi_subsys_runtime_resume(struct device *dev);
>  int acpi_dev_pm_attach(struct device *dev, bool power_on);
>  bool acpi_storage_d3(struct device *dev);
>  bool acpi_dev_state_d0(struct device *dev);
> +void acpi_dev_shutdown(struct device *dev);
>  #else
>  static inline int acpi_subsys_runtime_suspend(struct device *dev) { retu=
rn 0; }
>  static inline int acpi_subsys_runtime_resume(struct device *dev) { retur=
n 0; }
> @@ -1145,6 +1146,7 @@ static inline bool acpi_dev_state_d0(struct device =
*dev)
>  {
>      return true;
>  }
> +static inline void acpi_dev_shutdown(struct device *dev) { }
>  #endif
>
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
>


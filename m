Return-Path: <linux-pci+bounces-930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15567812610
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 04:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB50EB21084
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 03:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CE017F1;
	Thu, 14 Dec 2023 03:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FN0DgIcc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3095ED5
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 19:46:53 -0800 (PST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5395B3F2A2
	for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 03:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702525610;
	bh=mAj5KY1nspINqw/SCbRzykUa333yY3abgaSC16X+Xik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=FN0DgIccb0df/rRJNGoYM8u2+nNUaXPsZEHZVsZ02DgM9TZx9V85vWRbQXUfThC+C
	 cW1LYYK3dnYHIuQhGtbuS1e1LxfOSYF4iilZ/t8jTiGM/yeZ3Rx57Ea/4rKFBwTYum
	 md8BeWkcT/JaT1t/u9CwTxAqpfw3ewCZeTZWmUi5Ixc/twfdAx6iXdtESaBltPc99U
	 w7W/HLw24/YVIHVZczkrHqLL8GnpEk3lyeJ0i/tKZ4EqemuWdQcCTwozYvrgC/4K+r
	 Wsz2Za5BKgBEbVeVaX0dgdPJXs/JOJy4WrxDqwfs6KMExOXX8OqqjXcx151d4Hy0Gq
	 mKjpCMOLcn/SQ==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-286a4fc4e9eso9258764a91.2
        for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 19:46:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702525609; x=1703130409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAj5KY1nspINqw/SCbRzykUa333yY3abgaSC16X+Xik=;
        b=S5SKHBT9XiXgN5kKAalgKLA6HpF3/YtT9yuludNHO6I2vVPOXsEgW28cZPcB7+QaE8
         k0/ZZKGzXyZy5Lut3pMFqTyITMYXXdAc82cTyCiBc7PzwBGKNzPyZ4MuYd9CphkXNIFd
         OZdcK8WDkQ3gLCOjLgoKESmo9IHVNNlvYUzNicU96djs0Qp/8KqBD8N+brt1VEUHdRv4
         IRheAck9F1j8K2jA88wYE7awwZ+63SZvx50cYYtCTPUjndRXuIutPHvoDSvfRpwLJoa2
         uDLz4qYFBUE7o3vzl1sAlm+nzcSnfF4bq8RTsa2N+uCWy8TsgELCO+F8fB340D8TYQxT
         WF0A==
X-Gm-Message-State: AOJu0YxrsUtUj/ReZXOHFLcqu4JMzRNdiRmQociSSsMae78fD30RHjXR
	k3lY09cd+HURN2A83D01QtnM7CoqewMjyUemBzlodYjyUzXqXgV+Q7gfT81IG8AYG3AMm3mOwp9
	N91jNTKMGW1EvvsbWxV/eBclIHizN/JUpLDIRX8UiAODms2z65hGguQ==
X-Received: by 2002:a05:6a20:9481:b0:18b:4a28:6e15 with SMTP id hs1-20020a056a20948100b0018b4a286e15mr9199560pzb.34.1702525608893;
        Wed, 13 Dec 2023 19:46:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+jMwj//+47Gy0XOAIsVnk/FONKC8nacpKm8Mvphdg0ANxd9HVQ//KT49KW30Ybqi3HynexSqMVLvzm890jYw=
X-Received: by 2002:a05:6a20:9481:b0:18b:4a28:6e15 with SMTP id
 hs1-20020a056a20948100b0018b4a286e15mr9199548pzb.34.1702525608527; Wed, 13
 Dec 2023 19:46:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213182656.6165-1-mario.limonciello@amd.com>
 <20231213182656.6165-3-mario.limonciello@amd.com> <CAJZ5v0gDjwEpx-WNSY0=qchoSGxizsD3XM7Bgq=i0xufBm=Cag@mail.gmail.com>
 <766d621c-695d-4ae7-87cf-690cb8d066df@amd.com> <CAJZ5v0i95EeS40pzkBH=jgB1wbMP6SNO_s=pNZ8FPOtcMywgAA@mail.gmail.com>
In-Reply-To: <CAJZ5v0i95EeS40pzkBH=jgB1wbMP6SNO_s=pNZ8FPOtcMywgAA@mail.gmail.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 14 Dec 2023 11:46:37 +0800
Message-ID: <CAAd53p6XynUJimepnXDzcVa4Dps4-F0BNEXxGZh_O38LvSdkkg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI/portdrv: Place PCIe port hierarchy into D3cold at shutdown
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mpearson-lenovo@squebb.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mario and Rafael,

On Thu, Dec 14, 2023 at 2:46=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Dec 13, 2023 at 7:42=E2=80=AFPM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > On 12/13/2023 12:38, Rafael J. Wysocki wrote:
> > > On Wed, Dec 13, 2023 at 7:27=E2=80=AFPM Mario Limonciello
> > > <mario.limonciello@amd.com> wrote:
> > >>
> > >> When a system is being powered off it's important that PCIe ports
> > >> have been put into D3cold as there is no other software to turn
> > >> off the devices at S5.
> > >>
> > >> If PCIe ports are left in D0 then any GPIOs toggled by the ACPI
> > >> power resources may be left enabled and devices may consume excess
> > >> power.
> > >
> > > Isn't that a platform firmware issue?
> > >
> > > It is the responsibility of the platform firmware to properly put the
> > > platform into S5, including power removal from devices that are not
> > > armed for power-on.
> >
> > The specific issues that triggered this series were tied to the PCIe
> > ports for dGPUs.  There is a GPIO that is toggled by _ON or _OFF.
> >
> > Windows calls _OFF as part of S5..
>
> I see.
>
> > >
> > >> Cc: mpearson-lenovo@squebb.ca
> > >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > >> ---
> > >>   drivers/pci/pcie/portdrv.c | 11 ++++++++---
> > >>   1 file changed, 8 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > >> index 14a4b89a3b83..08238680c481 100644
> > >> --- a/drivers/pci/pcie/portdrv.c
> > >> +++ b/drivers/pci/pcie/portdrv.c
> > >> @@ -734,9 +734,14 @@ static void pcie_portdrv_remove(struct pci_dev =
*dev)
> > >>   static void pcie_portdrv_shutdown(struct pci_dev *dev)
> > >>   {
> > >>          if (pci_bridge_d3_possible(dev)) {
> > >> -               pm_runtime_forbid(&dev->dev);
> > >> -               pm_runtime_get_noresume(&dev->dev);
> > >> -               pm_runtime_dont_use_autosuspend(&dev->dev);
> > >> +               /* whole hierarchy goes into a low power state for S=
5 */
> > >> +               if (system_state =3D=3D SYSTEM_POWER_OFF) {
> > >> +                       pci_set_power_state(dev, PCI_D3cold);
> > >> +               } else {
> > >> +                       pm_runtime_forbid(&dev->dev);
> > >> +                       pm_runtime_get_noresume(&dev->dev);
> > >> +                       pm_runtime_dont_use_autosuspend(&dev->dev);
> > >> +               }
> > >>          }
> > >
> > > Wouldn't it be better to remove power from the port after running the
> > > code below?
> > >
> >
> > Yes; I think you're right.  I'll do some more testing with this.
> >
> > >>          pcie_port_device_remove(dev);
> > >> --
>
> IIRC, to do this all properly, you'd need to rework the shutdown path
> to look like the hibernation power-off one.  Or even use the latter
> for shutdown?
>
> There was no reason to do that till now, so it has not been done, but
> it looks like you have one.
>

I am working on exactly same thing but with a different approach.
Because this is needed for more than just PCI devices.
I haven't written a proper commit message yet, but the implementation
is quite simple:

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index f007116a8427..b90c6cf6faf4 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -967,15 +967,17 @@ EXPORT_SYMBOL_GPL(acpi_pm_set_device_wakeup);
  * @adev: ACPI device node corresponding to @dev.
  * @system_state: System state to choose the device state for.
  */
-static int acpi_dev_pm_low_power(struct device *dev, struct acpi_device *a=
dev,
-                 u32 system_state)
+static int acpi_dev_pm_low_power(struct acpi_device *adev, void* data)
 {
     int ret, state;
+    u32 *system_state =3D data;

     if (!acpi_device_power_manageable(adev))
         return 0;

-    ret =3D acpi_dev_pm_get_state(dev, adev, system_state, NULL, &state);
+    acpi_dev_for_each_child(adev, acpi_dev_pm_low_power, data);
+
+    ret =3D acpi_dev_pm_get_state(&adev->dev, adev, *system_state, NULL, &=
state);
     return ret ? ret : acpi_device_set_power(adev, state);
 }

@@ -1016,7 +1018,7 @@ int acpi_dev_suspend(struct device *dev, bool wakeup)
         wakeup =3D false;
     }

-    error =3D acpi_dev_pm_low_power(dev, adev, target_state);
+    error =3D acpi_dev_pm_low_power(adev, &target_state);
     if (error && wakeup)
         acpi_device_wakeup_disable(adev);

@@ -1386,6 +1388,7 @@ static struct dev_pm_domain acpi_general_pm_domain =
=3D {
 static void acpi_dev_pm_detach(struct device *dev, bool power_off)
 {
     struct acpi_device *adev =3D ACPI_COMPANION(dev);
+    u32 state =3D ACPI_STATE_S0;

     if (adev && dev->pm_domain =3D=3D &acpi_general_pm_domain) {
         dev_pm_domain_set(dev, NULL);
@@ -1400,7 +1403,7 @@ static void acpi_dev_pm_detach(struct device
*dev, bool power_off)
             dev_pm_qos_hide_latency_limit(dev);
             dev_pm_qos_hide_flags(dev);
             acpi_device_wakeup_disable(adev);
-            acpi_dev_pm_low_power(dev, adev, ACPI_STATE_S0);
+            acpi_dev_pm_low_power(adev, &state);
         }
     }
 }
@@ -1514,4 +1517,16 @@ bool acpi_dev_state_d0(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(acpi_dev_state_d0);

+void acpi_dev_shutdown(struct device *dev)
+{
+    struct acpi_device *adev =3D ACPI_COMPANION(dev);
+    u32 state =3D ACPI_STATE_S5;
+
+    if (!adev)
+        return;
+
+    acpi_device_wakeup_disable(adev);
+    acpi_dev_pm_low_power(adev, &state);
+}
+EXPORT_SYMBOL_GPL(acpi_dev_shutdown);
 #endif /* CONFIG_PM */
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6ceaf50f5a67..7e7c99eade63 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -45,6 +45,15 @@ static void __fw_devlink_link_to_consumers(struct
device *dev);
 static bool fw_devlink_drv_reg_done;
 static bool fw_devlink_best_effort;

+#ifdef CONFIG_ACPI
+static inline void fw_dev_shutdown(struct device *dev)
+{
+    acpi_dev_shutdown(dev);
+}
+#else
+static inline void fw_dev_shutdown(struct device *dev) {  }
+#endif
+
 /**
  * __fwnode_link_add - Create a link between two fwnode_handles.
  * @con: Consumer end of the link.
@@ -4780,6 +4789,8 @@ void device_shutdown(void)
             dev->driver->shutdown(dev);
         }

+        fw_dev_shutdown(dev);
+
         device_unlock(dev);
         if (parent)
             device_unlock(parent);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 641dc4843987..374f9eb75c22 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1130,6 +1130,7 @@ int acpi_subsys_runtime_resume(struct device *dev);
 int acpi_dev_pm_attach(struct device *dev, bool power_on);
 bool acpi_storage_d3(struct device *dev);
 bool acpi_dev_state_d0(struct device *dev);
+void acpi_dev_shutdown(struct device *dev);
 #else
 static inline int acpi_subsys_runtime_suspend(struct device *dev) { return=
 0; }
 static inline int acpi_subsys_runtime_resume(struct device *dev) { return =
0; }
@@ -1145,6 +1146,7 @@ static inline bool acpi_dev_state_d0(struct device *d=
ev)
 {
     return true;
 }
+static inline void acpi_dev_shutdown(struct device *dev) { }
 #endif

 #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)


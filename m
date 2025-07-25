Return-Path: <linux-pci+bounces-32945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 991BEB11FA1
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 15:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B40188B861
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 13:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9982E36EC;
	Fri, 25 Jul 2025 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+ZPx3xL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA141E51EF;
	Fri, 25 Jul 2025 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753451632; cv=none; b=Dq2oQgteboTZo7PTnSlEPFhEVtncIsDcOEtNUxASQj7IUtq34hlTEsejDLxsP1lCbHGFtdTFiO19wHXzqLJBA6x6qcsDJqWhBgW55O/a209qRXj+sM7H32Zitkc38covpuF5s27Ur9jnkPKCNrdqbAHugIJ80DNqL7cweIu25eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753451632; c=relaxed/simple;
	bh=eOB7yXo2LoXF2GIMVzJWuRIXM7ag/qKFdH7POf8TuI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iowBoBCgPDUYaZS9RJx7tc9VsKEDPRYTOmn79NeeF0IBhy4P1LYou2saiskEYmzHggln3REJyVhyJ13o6F5Z8gu2pqlWK0nNoWzS2Ev/tJTT809x7IlXwPV0FYOCnMtg7djkViXDTcOjT8BuvdVpLvl6B2FnvSr2+Nf6dm0yOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+ZPx3xL; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32ce1b2188dso18355531fa.3;
        Fri, 25 Jul 2025 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753451629; x=1754056429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fWdhR0VBfiS/L09WfJDV+7CjbZeT3b1nXdFbi2Z3Bg=;
        b=R+ZPx3xLuL2KTOFzYE00WN5jdNiOkKyApSRjJFeCl24wqqNUGCXE4e/PomWf4rmGPH
         QSGl59NRu9xM1pKnIAkBltxjGDMh/K7tWWRDHFfd5PSbcnFbxycbitWWSf7wf9r7RGJW
         UHBZKmOT09qgrGoQAXpnigV5+yGEd+ZOgBcbUCuyCTb5Aw1RdX/8dQgxMQOlurXh57tH
         9n5wYo5z5HnTaKGBQ416SRJO8lqD8Vy+QdNDSBmaNYHrCvJKpSMiC92GE8xzzjN+pIAG
         0TLtLmgPKJlbLa0W5HR3+fWBnj9/8zr6oPmORCeiTTLqQivJQ1Y2e3Cw3+MIFyNzyzkQ
         UOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753451629; x=1754056429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fWdhR0VBfiS/L09WfJDV+7CjbZeT3b1nXdFbi2Z3Bg=;
        b=Dz3NpBzK3Txnj1NtZoRK056/p4thZ6uUCTQxA2JUyOdlgzGfbHnXBTpnNk6WHFmd3P
         u9Yb5eBPAkka8UstyfbSjOQXok5++UwpY1HPMbGO7qGpIUUNK78/Gd3VTXPeJb+0Vk6K
         n9TJ4cf+/0IlV3DTn3U9aKuEKLoDxTyAR/UrFIVM3aOPw3cAOmflnkSfBTR4n6f5AkoE
         dgx0RNODWlcY2A+69XEkUMkn7Vn2Hzrn+w2LcMK1pO3H1YSCx2QKAMBJEcq3R6Ec1eoR
         gxm3gztm6FUFWjqnhb3H7Q564Aus6zjz6rmMjS0SPVZj/LmJOyE3zrnz7nGZbrqLzZiG
         ZOgw==
X-Forwarded-Encrypted: i=1; AJvYcCU+tZ5a2Ka2Q++2K+8IoTuGxOrOAhCbF96AT2dVhpwMP4NB/IUFLutmg4pjrHt8oRpNLk/5RwPF2lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9QbzgtV5b5PqY7NAyuV0VdKSMyU8xA2ePzlzQiPgOTmc0FCrW
	hFLP8fzJlp1urL7W7GKaMLzD6ZbbfB8+Bb7zb5OaJhMNbmjS4JJIrX9WSIHb8+5HGomhCcMOzub
	iG/Pb8kSktofJlveZ+YVtoio01fzzmpI=
X-Gm-Gg: ASbGnct96S0L9t1bDjdFIscRJPu3ykgfZ3f/F28QIXd0BjQKj8T3S40WPLSZKvNU/Ml
	zpertaYoYzgNvJO4U+oATI3isPyCKFda1rit3XCpP4A79qpPkkr6aUlQRqbWGfh7Pu5vw56ljgb
	/i3a+DUgajPtT4x5/xNymBeC5wKo0T8ZerEMQMKHLYLA8K0xUUC4j6XJhaKZyEPO8QdrW/shj0b
	s2zxg==
X-Google-Smtp-Source: AGHT+IGSjJBjVeIF1UiOOZx7zrUyhUUvmR7dt5xoYizfxKDueOSb41cniJIQvhqsIC4AGtjyNkKon8kDnFPOf5OSx+M=
X-Received: by 2002:a05:651c:1585:b0:32a:869e:4c13 with SMTP id
 38308e7fff4ca-331ee6bde7bmr4926761fa.14.1753451628096; Fri, 25 Jul 2025
 06:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725090133.1358775-1-kiran.k@intel.com>
In-Reply-To: <20250725090133.1358775-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 25 Jul 2025 09:53:35 -0400
X-Gm-Features: Ac12FXwyzqNHfLPdHqEA0hYTNkMUgglGxxQQ1Y7JFYBSg_MQ752ng7-zdHJ5DaY
Message-ID: <CABBYNZLJyT=z5gLCArU6pMo1sVq-0PSPpvV5yYXHCaxCp2GOZg@mail.gmail.com>
Subject: Re: [PATCH v6] Bluetooth: btintel_pcie: Add support for _suspend() / _resume()
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, 
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Fri, Jul 25, 2025 at 4:45=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
>
> This patch implements _suspend() and _resume() functions for the
> Bluetooth controller. When the system enters a suspended state, the
> driver notifies the controller to perform necessary housekeeping tasks
> by writing to the sleep control register and waits for an alive
> interrupt. The firmware raises the alive interrupt when it has
> transitioned to the D3 state. The same flow occurs when the system
> resumes.
>
> Command to test host initiated wakeup after 60 seconds
> sudo rtcwake -m mem -s 60
>
> dmesg log (tested on Whale Peak2 on Panther Lake platform)
> On system suspend:
> [Fri Jul 25 11:05:37 2025] Bluetooth: hci0: device entered into d3 state =
from d0 in 80 us
>
> On system resume:
> [Fri Jul 25 11:06:36 2025] Bluetooth: hci0: device entered into d0 state =
from d3 in 7117 us
>
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com=
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> changes in v6:
>      - s/delta/delta_us/g
>      - s/CONFIG_PM/CONFIG_PM_SLEEP/g
>      - use pm_sleep_pr()/pm_str() to avoid #ifdefs
>      - remove the code to set persistance mode as its not relevant to thi=
s patch
>
> changes in v5:
>      - refactor _suspend() / _resume() to set the D3HOT/D3COLD based on p=
ower
>        event
>      - remove SIMPLE_DEV_PM_OPS and define the required pm_ops callback
>        functions
>
> changes in v4:
>      - Moved document and section details from the commit message as comm=
ent in code.
>
> changes in v3:
>      - Corrected the typo's
>      - Updated the CC list as suggested.
>      - Corrected the format specifiers in the logs.
>
> changes in v2:
>      - Updated the commit message with test steps and logs.
>      - Added logs to include the timeout message.
>      - Fixed a potential race condition during suspend and resume.
>
>  drivers/bluetooth/btintel_pcie.c | 90 ++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 6e7bbbd35279..c419521493fe 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2573,11 +2573,101 @@ static void btintel_pcie_coredump(struct device =
*dev)
>  }
>  #endif
>
> +#ifdef CONFIG_PM_SLEEP
> +static int btintel_pcie_suspend_late(struct device *dev, pm_message_t me=
sg)
> +{
> +       struct pci_dev *pdev =3D to_pci_dev(dev);
> +       struct btintel_pcie_data *data;
> +       ktime_t start;
> +       u32 dxstate;
> +       s64 delta_us;
> +       int err;
> +
> +       data =3D pci_get_drvdata(pdev);
> +
> +       dxstate =3D (mesg.event =3D=3D PM_EVENT_SUSPEND ?
> +                  BTINTEL_PCIE_STATE_D3_HOT : BTINTEL_PCIE_STATE_D3_COLD=
);
> +
> +       data->gp0_received =3D false;
> +
> +       start =3D ktime_get();
> +
> +       /* Refer: 6.4.11.7 -> Platform power management */
> +       btintel_pcie_wr_sleep_cntrl(data, dxstate);
> +       err =3D wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> +                                msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TI=
MEOUT_MS));
> +       if (err =3D=3D 0) {
> +               bt_dev_err(data->hdev, "Timeout (%u ms) on alive interrup=
t for D3 entry",
> +                               BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
> +               return -EBUSY;
> +       }
> +
> +       delta_us =3D ktime_to_ns(ktime_get() - start) / 1000;
> +       bt_dev_info(data->hdev, "device entered into d3 state from d0 in =
%lld us",
> +                   delta_us);
> +       return 0;
> +}
> +
> +static int btintel_pcie_suspend(struct device *dev)
> +{
> +       return btintel_pcie_suspend_late(dev, PMSG_SUSPEND);
> +}
> +
> +static int btintel_pcie_hibernate(struct device *dev)
> +{
> +       return btintel_pcie_suspend_late(dev, PMSG_HIBERNATE);
> +}
> +
> +static int btintel_pcie_freeze(struct device *dev)
> +{
> +       return btintel_pcie_suspend_late(dev, PMSG_FREEZE);
> +}
> +
> +static int btintel_pcie_resume(struct device *dev)
> +{
> +       struct pci_dev *pdev =3D to_pci_dev(dev);
> +       struct btintel_pcie_data *data;
> +       ktime_t start;
> +       int err;
> +       s64 delta_us;
> +
> +       data =3D pci_get_drvdata(pdev);
> +       data->gp0_received =3D false;
> +
> +       start =3D ktime_get();
> +
> +       /* Refer: 6.4.11.7 -> Platform power management */
> +       btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
> +       err =3D wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> +                                msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TI=
MEOUT_MS));
> +       if (err =3D=3D 0) {
> +               bt_dev_err(data->hdev, "Timeout (%u ms) on alive interrup=
t for D0 entry",
> +                               BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
> +               return -EBUSY;
> +       }
> +
> +       delta_us =3D ktime_to_ns(ktime_get() - start) / 1000;
> +       bt_dev_info(data->hdev, "device entered into d0 state from d3 in =
%lld us",
> +                   delta_us);
> +       return 0;
> +}
> +
> +const struct dev_pm_ops btintel_pcie_pm_ops =3D {
> +       .suspend =3D pm_sleep_ptr(btintel_pcie_suspend),
> +       .resume =3D pm_sleep_ptr(btintel_pcie_resume),
> +       .freeze =3D pm_sleep_ptr(btintel_pcie_freeze),
> +       .thaw =3D pm_sleep_ptr(btintel_pcie_resume),
> +       .poweroff =3D pm_sleep_ptr(btintel_pcie_hibernate),
> +       .restore =3D pm_sleep_ptr(btintel_pcie_resume),
> +};
> +#endif
> +
>  static struct pci_driver btintel_pcie_driver =3D {
>         .name =3D KBUILD_MODNAME,
>         .id_table =3D btintel_pcie_table,
>         .probe =3D btintel_pcie_probe,
>         .remove =3D btintel_pcie_remove,
> +       .driver.pm =3D pm_ptr(&btintel_pcie_pm_ops),

This doesn't seem quite right, btintel_pcie_pm_ops is behind
CONFIG_PM_SLEEP not just CONFIG_PM, so it would be undefined if just
CONFIG_PM is set, so we might as well do:

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_p=
cie.c
index 5b32f5a6b0b0..2f1b1be94080 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2654,12 +2654,12 @@ static int btintel_pcie_resume(struct device *dev)
 }

 const struct dev_pm_ops btintel_pcie_pm_ops =3D {
-       .suspend =3D pm_sleep_ptr(btintel_pcie_suspend),
-       .resume =3D pm_sleep_ptr(btintel_pcie_resume),
-       .freeze =3D pm_sleep_ptr(btintel_pcie_freeze),
-       .thaw =3D pm_sleep_ptr(btintel_pcie_resume),
-       .poweroff =3D pm_sleep_ptr(btintel_pcie_hibernate),
-       .restore =3D pm_sleep_ptr(btintel_pcie_resume),
+       .suspend =3D btintel_pcie_suspend,
+       .resume =3D btintel_pcie_resume,
+       .freeze =3D btintel_pcie_freeze,
+       .thaw =3D btintel_pcie_resume,
+       .poweroff =3D btintel_pcie_hibernate,
+       .restore =3D btintel_pcie_resume,
 };
 #endif

@@ -2668,7 +2668,7 @@ static struct pci_driver btintel_pcie_driver =3D {
        .id_table =3D btintel_pcie_table,
        .probe =3D btintel_pcie_probe,
        .remove =3D btintel_pcie_remove,
-       .driver.pm =3D pm_ptr(&btintel_pcie_pm_ops),
+       .driver.pm =3D pm_sleep_ptr(&btintel_pcie_pm_ops),
 #ifdef CONFIG_DEV_COREDUMP
        .driver.coredump =3D btintel_pcie_coredump
 #endif


>  #ifdef CONFIG_DEV_COREDUMP
>         .driver.coredump =3D btintel_pcie_coredump
>  #endif
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz


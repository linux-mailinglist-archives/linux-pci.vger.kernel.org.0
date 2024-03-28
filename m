Return-Path: <linux-pci+bounces-5301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738F988F447
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 02:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA575B219C1
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 01:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBE914011;
	Thu, 28 Mar 2024 01:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYx+HLra"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B465ED8;
	Thu, 28 Mar 2024 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711587712; cv=none; b=YZmRiobntaw6niMU9psJZG3BZEt8144YV8qozl4kMpANkmxYe9/fa47ZvfSM/k+xnWf3c14k7lJzwG/ur78glMbqWwc38V2ClPV87a8Ggmicrrelub3mOucCsHBDSfpiZSxy0zp3cRLvmz0sSlNvykbsxD8VAnve1RlrR/IEB3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711587712; c=relaxed/simple;
	bh=2cfHzOeZI9Z39CzJ/8BNbKRI3djDCKB8bHXvwRGu0Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpNXdFPD2WS0EV8CG+S7vNjGupSzaHd8GC/4w4vqwFqo7HDxwHC5GFc1CSF6LOWtWAxq05inyaCWKYl93kvcJJlx3YOUPuu7CvmHZnVCgywZbkuPRSzZ8ObQ/Z7Hf5EytxRxELcvksVOA7ISYP+p0G7RJ4D+49WrBfBGieSmf1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYx+HLra; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56c2c41cbdaso218563a12.2;
        Wed, 27 Mar 2024 18:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711587709; x=1712192509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVMPOgXiwV6xXIBa4FmJiAt/efk5dy0MaILdoXE0w4A=;
        b=NYx+HLraYKv81LwJy2p4DS27KEY6U3sJD7mvNm8fDLYfqOZB3aCXJK3dEdhiXScLbh
         KzzSf75SBIo68jwWC7x+Psn66a9q46gS4dM+KEt6b7s4LNL4KRjw36gvXcl0bEvqi3P0
         40C/b1po4KEWqPkP16AsgGOEgn3dXCreXepUu5qOQhEaDQ+03lfEvzs2Ul4bw8rCmXh/
         h2JrAJzrTzedLrIs6k0pp8tJewYZoMAnc+Y3TKbh0BoOyACk1XCaiyP5XpBwI3HjvehG
         HeCf6EgTfsRYbOQG21ya4mJCcG6NToz4tVp1li7cu/5u1fTRqjCtr2Z4FL7qvFhViXie
         /pKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711587709; x=1712192509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVMPOgXiwV6xXIBa4FmJiAt/efk5dy0MaILdoXE0w4A=;
        b=u1Uwmfku0zQNbxirUxaARW2t21oJcOZLeLL4+MW/43x8gic4NRyXRcgZRJtw+hLF1b
         cNkgOt7e1uiRys269b4INDThtJyfEinxbQrQlW2HDlpAJpTvJJMi5SvB/3ukH8sDrqJp
         cRt4gaNCb82wDSGHG/RbnHqp34/591Tcgu6WXvQqTwk+tgVyHDUYSScENA6yaYINY58e
         AB+YuCZX35XseSkPZWoQeDODGsxxGvxAkVHWlnvXHRXoAhiIrX/vnXYmYbsYyIPWWw45
         tUEeHKFC7BxvY+AAEivQwP75ttSmppS3puSJKxrcyUXfyNVfD8B9PToP0UFF/oKruVBC
         PXwA==
X-Forwarded-Encrypted: i=1; AJvYcCVbv1/k5GoQSUKWoloiVFvFpMqBmUNxpdC2Y862FKj1PG8qRDyHS34Cc3DavktC6/+bJ2rLLu4clAUPnwHjlqZLmXzds7uTSjsh+AmnGp9oYFNPe8itE5qmvr7FRgYIAUHnAXbVIdkSpKpc006vpFl/u9e5oprDl+wd5FUTkNBOCZAv
X-Gm-Message-State: AOJu0YzvQr7UkCwoKZEWouCcA/Q9nhWIGmumkmurkCoPAekr9dtfjUlF
	yKQ8Uz0SWs8sMJS49dDa6z6w8U4jTvYjCWGzi2JIEmAXbqaSQUZtAui+uu3ns5TsExDXdlOuk4J
	xO8Hfr9kxSOmraSKxD66CEVINOMY=
X-Google-Smtp-Source: AGHT+IEVlIyJhQ6HxIzqq7Q5sGErXONlDcW77WKjJYQRC2KjOqtAmGKq33df+o5TBuuUG/8ZMsEdI7NhLu6jizZM5aA=
X-Received: by 2002:a50:9302:0:b0:56b:7f43:5a49 with SMTP id
 m2-20020a509302000000b0056b7f435a49mr1004214eda.40.1711587708441; Wed, 27 Mar
 2024 18:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327214831.1544595-1-helgaas@kernel.org> <20240327214831.1544595-3-helgaas@kernel.org>
In-Reply-To: <20240327214831.1544595-3-helgaas@kernel.org>
From: Ben Chuang <benchuanggli@gmail.com>
Date: Thu, 28 Mar 2024 09:01:39 +0800
Message-ID: <CACT4zj9BFwMLsDSzNQ=wHSBCHqoydggtM-7-7rsfo0pRV2iLEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci-gli: Use pci_set_power_state(), not
 direct PMCSR writes
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Kai-Heng Feng <kai.heng.geng@canonical.com>, Sven van Ashbrook <svenva@chromium.org>, 
	Stanislaw Kardach <skardach@google.com>, Brian Norris <briannorris@chromium.org>, 
	Jason Lai <jasonlai.genesyslogic@gmail.com>, Renius Chen <reniuschengl@gmail.com>, 
	linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 5:49=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> d7133797e9e1 ("mmc: sdhci-pci-gli: A workaround to allow GL9750 to enter
> ASPM L1.2") and 36ed2fd32b2c ("mmc: sdhci-pci-gli: A workaround to allow
> GL9755 to enter ASPM L1.2") added writes to the Control register in the
> Power Management Capability to put the device in D3hot and back to D0.
>
> Use the pci_set_power_state() interface instead because these are generic
> operations that don't need to be driver-specific.  Also, the PCI spec
> requires some delays after these power transitions, and
> pci_set_power_state() takes care of those, while d7133797e9e1 and
> 36ed2fd32b2c did not.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Hi Bjorn,

Thanks. It looks better than the vendor specific.

Best regards,
Ben Chuang

> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pc=
i-gli.c
> index 3d5543581537..0f81586a19df 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -25,9 +25,6 @@
>  #define   GLI_9750_WT_EN_ON        0x1
>  #define   GLI_9750_WT_EN_OFF       0x0
>
> -#define PCI_GLI_9750_PM_CTRL   0xFC
> -#define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
> -
>  #define SDHCI_GLI_9750_CFG2          0x848
>  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
>  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> @@ -149,9 +146,6 @@
>  #define PCI_GLI_9755_MISC          0x78
>  #define   PCI_GLI_9755_MISC_SSC_OFF    BIT(26)
>
> -#define PCI_GLI_9755_PM_CTRL     0xFC
> -#define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> -
>  #define SDHCI_GLI_9767_GM_BURST_SIZE                   0x510
>  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET    BIT(8)
>
> @@ -556,11 +550,8 @@ static void gl9750_hw_setting(struct sdhci_host *hos=
t)
>         sdhci_writel(host, value, SDHCI_GLI_9750_CFG2);
>
>         /* toggle PM state to allow GL9750 to enter ASPM L1.2 */
> -       pci_read_config_dword(pdev, PCI_GLI_9750_PM_CTRL, &value);
> -       value |=3D PCI_GLI_9750_PM_STATE;
> -       pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
> -       value &=3D ~PCI_GLI_9750_PM_STATE;
> -       pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
> +       pci_set_power_state(pdev, PCI_D3hot);
> +       pci_set_power_state(pdev, PCI_D0);
>
>         /* mask the replay timer timeout of AER */
>         aer =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
> @@ -774,11 +765,8 @@ static void gl9755_hw_setting(struct sdhci_pci_slot =
*slot)
>         pci_write_config_dword(pdev, PCI_GLI_9755_CFG2, value);
>
>         /* toggle PM state to allow GL9755 to enter ASPM L1.2 */
> -       pci_read_config_dword(pdev, PCI_GLI_9755_PM_CTRL, &value);
> -       value |=3D PCI_GLI_9755_PM_STATE;
> -       pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
> -       value &=3D ~PCI_GLI_9755_PM_STATE;
> -       pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
> +       pci_set_power_state(pdev, PCI_D3hot);
> +       pci_set_power_state(pdev, PCI_D0);
>
>         /* mask the replay timer timeout of AER */
>         aer =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
> --
> 2.34.1
>
>


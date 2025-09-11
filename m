Return-Path: <linux-pci+bounces-35926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E4EB53A94
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 19:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3BD18830EB
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 17:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D911D36206A;
	Thu, 11 Sep 2025 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3ftaxQ0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E57A326D4A
	for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612686; cv=none; b=nH9dBzaxE3SBUzawSmw2jW4ioCma/XX4W/UJhUYOtF8P8fNXTfCGJNzX/FoSritCnSyI++W0XPKJJAX4KtdMK/dln6tTT82rtkAjcpgNnEUKuU3CtmcFaZE60TCiaw7rzrlGWHG1hcy/azMfWhV1dpBJHlRdErfThEjn63Uo+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612686; c=relaxed/simple;
	bh=pbhMO13ZY5GqoqdYOtMMsHmtwMybBAHzcr1+lrCzXbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1mCqGqJ9amCIMV9Z1VAub6ewQwSdBMGbe91KP/hMTRV7YmdTVV9PgdzwbvObBBoGYwb4AWWng2xX8UMfw+ljYodRWJI1634JJO0TYOYxhJ++KTN4wRxRHR+oBSo3sskm+Ycw0CdqRyuyIDjqhivdIwoJs4jc0oO0bdQCzMsvXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o3ftaxQ0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-251ace3e7caso12868385ad.2
        for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757612684; x=1758217484; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rz1KF1fng6KUijdJHOF61HINUn1DY6RMLW+n7igx57A=;
        b=o3ftaxQ0jcC/wXlHi54vgazVyRwwr4iH8pciBU2bbKJ8AWB9qy3pz4ScKLBtPGF5Xj
         Yvg5pjGAe9epKi7NHbumSBNwqXihUdBSyP4C5UcgI/nKXNafEoYbLGCM87KVbI69Rgui
         uKuiA5fjoow53xNIMCzDrz3Eznwdmsi0C0KZvL4qggBXSVoT6ixtK4l5OV1ULS6GwWEl
         gndOtRw+S3/qU4qKbuqezI2gba/56KPTmsR8QCS0P7tsVEs+oj3IVheafqylgfMb+Jpj
         5TjVk/H6Q37uE7KYm9BnTVgEGlcBFCC6h49fiNHM7GYRrP/2bi4Z4g9VkXO0H9E87vOM
         BoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757612684; x=1758217484;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rz1KF1fng6KUijdJHOF61HINUn1DY6RMLW+n7igx57A=;
        b=DcF81oQdZlhZk330vHiB/RNUptf1mqA080CGOmDEWg/ELreh5WGULU6fzUoUPOqq8R
         5mgwq6ytNwYU94vKH4takqEqW1yCcjh4twauHOwwbwwslQYsn34KZHs5e+VFcyErXwH/
         TWGQV6m76Bje4RrXnn5FitNrlSa3NBlrnCsyB1yU0m8coxAhp9WJVwR0f3YOvzJNRixw
         3N4ACAw6GKpY8gei/1wvWUMeIBA6XGLXHiHIOFbGMtSTYcA0kXKVtksj8vhYQgrjddx8
         v7k+rvztFKSJ0SIPTH0xkNV1+qZXTBr0uFPq7238/8BcUFDK1l5sJKqxGU39e7kjPCMv
         9CYw==
X-Forwarded-Encrypted: i=1; AJvYcCUzc+xN/LYipBcW4Qk7B3w35f01HbSUMxKuptFDfsvbfjKjC9sgW3rB3337TV4VKgaEXNUM8opLdrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtWimf3vT1zXdxnXOD5gvURIhI5yO+z1g08xvi44zT/Vzf/ROR
	oBFaKeCAOdoso2I3Q0JG7BEmgAy/5AnH3JERKq1fKQW9HU1goShedYUE256ty9kqLiyODlETMQU
	57XGh6eObgDFgBIXkhhQLSGByweQ2GosYnlTFE50i7g==
X-Gm-Gg: ASbGncuY2NmX80Vy3FtK/Pjj9/+mWhofgL5NCdWgGVjpG9hI/miaD08OgP7BgAK8vOl
	wdrtQpEC3KPJYtqRyldG5YQHg4Pvvf3gAx/AJDoL4QjBazZZrR1mLbPkCtgwwFvVPqe+CCEInyh
	+4h5NlpG1caL4GBU6//JgrEL6U5MtTfy6imACbRN0fbWNqSIsLREMghCTtVvG5o5Mq+k7GW3KKr
	Uwg50XYHOCGt+OixwhOb+NJJGXfCOaz7fdDNRg2+jwSxWaUKYyIzpGkxW6byQZtqXbZivg=
X-Google-Smtp-Source: AGHT+IHKvaF18ohXsPsL72THHHDkwdYvNLb3qlPEho/vRrC5yGFzk7JsCnpNSS1pajW0C+okn9T5G60r8QGqr7wiZ+k=
X-Received: by 2002:a17:903:41ca:b0:24c:e6a6:9e59 with SMTP id
 d9443c01a7336-25d245dd6f8mr3157985ad.6.1757612684132; Thu, 11 Sep 2025
 10:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>
In-Reply-To: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 11 Sep 2025 23:14:32 +0530
X-Gm-Features: AS18NWC_m5FW6D-agm1h0PvPSN-t5mnK-nNZJhLfFxbja72xJDHUDp2R2a5Rjwc
Message-ID: <CA+G9fYv_h22MCs380DwW+G5_M=H-GdFvGGo4vq_-gARL8trCOQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI: Fix ACS enablement for Root Ports in DT platforms
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev, 
	Anders Roxell <anders.roxell@linaro.org>, Pavankumar Kondeti <quic_pkondeti@quicinc.com>, 
	Xingang Wang <wangxingang5@huawei.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	stable@vger.kernel.org, lkft-triage@lists.linaro.org, LKFT <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Sept 2025 at 23:09, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> Hi,
>
> This series fixes the long standing issue with ACS in DT platforms. There are
> two fixes in this series, both fixing independent issues on their own, but both
> are needed to properly enable ACS on DT platforms (well, patch 1 is only needed
> for Juno board, but that was a blocker for patch 2, more below...).
>
> Issue(s) background
> ===================
>
> Back in 2024, Xingang Wang first noted a failure in attaching the HiSilicon SEC
> device to QEMU ARM64 pci-root-port device [1]. He then tracked down the issue to
> ACS not being enabled for the QEMU Root Port device and he proposed a patch to
> fix it [2].
>
> Once the patch got applied, people reported PCIe issues with linux-next on the
> ARM Juno Development boards, where they saw failure in enumerating the endpoint
> devices [3][4]. So soon, the patch got dropped, but the actual issue with the
> ARM Juno boards was left behind.
>
> Fast forward to 2024, Pavan resubmitted the same fix [5] for his own usecase,
> hoping that someone in the community would fix the issue with ARM Juno boards.
> But the patch was rightly rejected, as a patch that was known to cause issues
> should not be merged to the kernel. But again, no one investigated the Juno
> issue and it was left behind again.
>
> Now it ended up in my plate and I managed to track down the issue with the help
> of Naresh who got access to the Juno boards in LKFT. The Juno issue is with the
> PCIe switch from Microsemi/IDT, which triggers ACS Source Validation error on
> Completions received for the Configuration Read Request from a device connected
> to the downstream port that has not yet captured the PCIe bus number. As per the
> PCIe spec r6.0 sec 2.2.6.2, "Functions must capture the Bus and Device Numbers
> supplied with all Type 0 Configuration Write Requests completed by the Function
> and supply these numbers in the Bus and Device Number fields of the Requester ID
> for all Requests". So during the first Configuration Read Request issued by the
> switch downstream port during enumeration (for reading Vendor ID), Bus and
> Device numbers will be unknown to the device. So it responds to the Read Request
> with Completion having Bus and Device number as 0. The switch interprets the
> Completion as an ACS Source Validation error and drops the completion, leading
> to the failure in detecting the endpoint device. Though the PCIe spec r6.0, sec
> 6.12.1.1, states that "Completions are never affected by ACS Source Validation".
> This behavior is in violation of the spec.
>
> This issue was already found and addressed with a quirk for a different device
> from Microsemi with 'commit, aa667c6408d2 ("PCI: Workaround IDT switch ACS
> Source Validation erratum")'. Apparently, this issue seems to be documented in
> the erratum #36 of IDT 89H32H8G3-YC, which is not publicly available.
>
> Solution for Juno issue
> =======================
>
> To fix this issue, I've extended the quirk to the Device ID of the switch
> found in Juno R2 boards. I believe the same switch is also present in Juno R1
> board as well.
>
> With Patch 1, the Juno R2 boards can now detect the endpoints even with ACS
> enabled for the Switch downstream ports. Finally, I added patch 2 that properly
> enables ACS for all the PCI devices on DT platforms.
>
> It should be noted that even without patch 2 which enables ACS for the Root
> Port, the Juno boards were failing since 'commit, bcb81ac6ae3c ("iommu: Get
> DT/ACPI parsing into the proper probe path")' as reported in LKFT [6]. I
> believe, this commit made sure pci_request_acs() gets called before the
> enumeration of the switch downstream ports. The LKFT team ended up disabling
> ACS using cmdline param 'pci=config_acs=000000@pci:0:0'. So I added the above
> mentioned commit as a Fixes tag for patch 1.
>
> Also, to mitigate this issue, one could enumerate all the PCIe devices in
> bootloader without enabling ACS (as also noted by Robin in the LKFT thread).
> This will make sure that the endpoint device has a valid bus number when it
> responds to the first Configuration Read Request from the switch downstream
> port. So the ACS Source Validation error doesn't get triggered.
>
> Solution for ACS issue
> ======================
>
> To fix this issue, I've kept the patch from Xingang as is (with rewording of the
> patch subject/description). This patch moves the pci_request_acs() call to
> devm_of_pci_bridge_init(), which gets called during the host bridge
> registration. This makes sure that the 'pci_acs_enable' flag set by
> pci_request_acs() is getting set before the enumeration of the Root Port device.
> So now, ACS will be enabled for all ACS capable devices of DT platforms.

I have applied this patch series on top of Linux next-20250910 and
next-20250911 tags and tested.

>
> [1] https://lore.kernel.org/all/038397a6-57e2-b6fc-6e1c-7c03b7be9d96@huawei.com
> [2] https://lore.kernel.org/all/1621566204-37456-1-git-send-email-wangxingang5@huawei.com
> [3] https://lore.kernel.org/all/01314d70-41e6-70f9-e496-84091948701a@samsung.com
> [4] https://lore.kernel.org/all/CADYN=9JWU3CMLzMEcD5MSQGnaLyDRSKc5SofBFHUax6YuTRaJA@mail.gmail.com
> [5] https://lore.kernel.org/linux-pci/20241107-pci_acs_fix-v1-1-185a2462a571@quicinc.com
> [6] https://lists.linaro.org/archives/list/lkft-triage@lists.linaro.org/message/CBYO7V3C5TGYPKCMWEMNFFMRYALCUDTK
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

> ---
> Manivannan Sadhasivam (1):
>       PCI: Extend pci_idt_bus_quirk() for IDT switch with Device ID 0x8090
>
> Xingang Wang (1):
>       iommu/of: Call pci_request_acs() before enumerating the Root Port device
>
>  drivers/iommu/of_iommu.c | 1 -
>  drivers/pci/of.c         | 8 +++++++-
>  drivers/pci/probe.c      | 2 +-
>  3 files changed, 8 insertions(+), 3 deletions(-)
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250910-pci-acs-cb4fa3983a2c
>
> Best regards,
> --
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
>

--
Linaro LKFT


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30708151EEB
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2020 18:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgBDRIJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 4 Feb 2020 12:08:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58056 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgBDRIJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Feb 2020 12:08:09 -0500
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iz1gE-0004xT-Vu
        for linux-pci@vger.kernel.org; Tue, 04 Feb 2020 17:08:07 +0000
Received: by mail-pl1-f197.google.com with SMTP id j8so5990645plk.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Feb 2020 09:08:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VK8o/brIxoX1s4YNqEOpFV00pzKNl1VdxAXl7AvMf/M=;
        b=BNnoZASsXKTZq4vtykD+AyLnjstr195/V2m3cPkpcSmFgTgBMpjCmfZLYzECCA+Up9
         06roc5rWHsH2F3DGkZwU9t80tCId6zOo2/nGSEazozZZKJxcbvhK/gMgZKyj8/H/qfK/
         05CacTvPRvp63kroLl0OXqlMc6++K/TrEMMKP8qVrDZQ+lqht1XVPbogouy14qqxg8vM
         uBmZ8IDRXeS2kMfBjaZGN4ors1dV3bmNngsTHQaUn4pOGI8AwM52xIV2voa0bJlcvwTL
         43iiWYwkGw+an9vbtG/6Jo+IXHNMn2SSyI30vmZwMXhb1WewlKqmKVMuLWy/yNcTT+2G
         3oFA==
X-Gm-Message-State: APjAAAVslwRER8IexW/UN6tNxjRMFnhxQTVzADOAYusaSh1VFKDU8HJk
        CnCu75cPOHXrft8/Mg5QddWsk6LckmnEioq6LGCKxwYds3IIraKxt2sAGjKlWMiCxFNJe0F+GL1
        Nti92GY9jQbBHNYtpc+6bkPWApEaOCtjWRhjB/g==
X-Received: by 2002:a65:620d:: with SMTP id d13mr33097684pgv.252.1580836085681;
        Tue, 04 Feb 2020 09:08:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqwyu4JftCXZjXWe/rkUQ0qIvUvwOzDjWRnR5K/gUoHhVSTeuzXeDQPVaHG+xKV0lD+6RnwKmQ==
X-Received: by 2002:a65:620d:: with SMTP id d13mr33097648pgv.252.1580836085315;
        Tue, 04 Feb 2020 09:08:05 -0800 (PST)
Received: from 2001-b011-380f-35a3-4cfd-361b-ac7d-6a8c.dynamic-ip6.hinet.net (2001-b011-380f-35a3-4cfd-361b-ac7d-6a8c.dynamic-ip6.hinet.net. [2001:b011:380f:35a3:4cfd:361b:ac7d:6a8c])
        by smtp.gmail.com with ESMTPSA id z5sm26260221pfq.3.2020.02.04.09.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2020 09:08:04 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] PCI: Avoid ASMedia XHCI USB PME# from D0 defect
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20191219192006.16270-1-kai.heng.feng@canonical.com>
Date:   Wed, 5 Feb 2020 01:08:00 +0800
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <DECD6DEE-E67C-43BA-8510-067ADBFBD50E@canonical.com>
References: <20191219192006.16270-1-kai.heng.feng@canonical.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> On Dec 20, 2019, at 03:20, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> The ASMedia USB XHCI Controller claims to support generating PME# while
> in D0:
> 
> 01:00.0 USB controller: ASMedia Technology Inc. Device 2142 (prog-if 30 [XHCI])
>        Subsystem: SUNIX Co., Ltd. Device 312b
>        Capabilities: [78] Power Management version 3
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
> 
> However PME# only gets asserted when plugging USB 2.0 or USB 1.1
> devices, but not for USB 3.0 devices.
> 
> So remove PCI_PM_CAP_PME_D0 to avoid using PME under D0.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205919
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Would it be possible to merge this patch? Thanks.

Kai-Heng

> ---
> drivers/pci/quirks.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 79379b4c9d7a..24c71555dc77 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5436,3 +5436,14 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
> DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
> 			      PCI_CLASS_DISPLAY_VGA, 8,
> 			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
> +
> +/*
> + * Device [1b21:2142]
> + * When in D0, PME# doesn't get asserted when plugging USB 3.0 device.
> + */
> +static void pci_fixup_no_d0_pme(struct pci_dev *dev)
> +{
> +	pci_info(dev, "PME# does not work under D0, disabling it\n");
> +	dev->pme_support &= ~(PCI_PM_CAP_PME_D0 >> PCI_PM_CAP_PME_SHIFT);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x2142, pci_fixup_no_d0_pme);
> -- 
> 2.17.1
> 


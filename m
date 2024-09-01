Return-Path: <linux-pci+bounces-12578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68066967B9E
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 20:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DF0281F3B
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 18:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9567D183087;
	Sun,  1 Sep 2024 18:01:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E7353E15;
	Sun,  1 Sep 2024 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725213702; cv=none; b=artRdSVRNNM6RYgSCsEfqXx+SghwngafV2GnewVKF00t4XVce+llG7fM60nRpaZrrWxdebm9NI8ustseYzlGuP2LdknVxrHchCJu3+PkAwP+vlK9DRtZGsNSjiAphCp+2z6p2EnlRYu+Fer7RS6f3Mtip1XhVKUJKhpiqsEabCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725213702; c=relaxed/simple;
	bh=os9In1glNB/P+9xSeD0ffIpoZPFCua1VhAJK02vFRAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s893ALha1ndr5ieDgMxfK1XWjBu6kGlODC1EwQiymu7BU2Q+/+Jnr4JPIJWiBBVD1FZbh+v8pVsuSaHIK7doo6Aw29IOF+ePoAKQSkB1DTZnrePEE4iI6d0jVtCj8wEU0ggJXRMDuZR1SsdNEHK96EV3kfzSixfME7MmGs+cRo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so2507496b3a.1;
        Sun, 01 Sep 2024 11:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725213700; x=1725818500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LHo1+4k3NBJ7PCwXyW4mL26iu3+Ez8AQmnlT23bjP4=;
        b=Lf499MfPDLBXZtveZdCObfR8Bl8EcI95egov5yX8ExYE5bWLkOIz+LrO6IVFxRSZIz
         u8i/4BVHZDPFMH/3F4NkHVkwKcLBBBBcKSHBOb/zT5K4LNdrAALB5E14PMQ0og1pHDUc
         HVgCQUC2qxBzzpz2v5UWLpVUAM9GaKXVCHrISnPTd5E0Jde3VtDH4zDbdX7ThW3pHS9p
         rCbgnGX2ZdrM+4TWAO+V+rrZCx6QEWOUZ2iNGmulRqmtp07dVlxHiqxg5ALXr0Jatqaj
         dD8ABBYSPNXTRA/dV7nI5ZgpJdZQ8cAM7WAoL5Pagg2/xNWvHmxcBHUAa7AcxQoWdVt7
         ATgw==
X-Forwarded-Encrypted: i=1; AJvYcCUQlV8WMjeQynyYdIJNczCCvdMMqyE+QQaO/MqjQKGJhZm2w1yN48RsWhteC6v3HJrZYg+W9djVDXRwDua1@vger.kernel.org, AJvYcCWFGPYZiXREzh+cVORs7ZiKRb7qoYO9RBegLmAQhbZ+9Hfy+tOzXp3Mf2HGjA9KqPyg3YhHq5x1KbAf@vger.kernel.org
X-Gm-Message-State: AOJu0YxA7M1qpOaraRwujnV4xOnIKfDo5ZudlYqJbzYDmbZAWtcXUZKu
	nNrheecsCQhlRBqCdXz2yhRES86UVZYU7GSMRXRtXuktI1u43NQI
X-Google-Smtp-Source: AGHT+IGKXFiHiHFuq5Nrfq/udJ+nSSmcM0g1xxOmMhM3h3XB5KLleGfrMtC+PPBWStrAgysC0fZKxw==
X-Received: by 2002:a05:6a21:e8c:b0:1ce:d125:f8ef with SMTP id adf61e73a8af0-1ced125fa1dmr5578883637.51.1725213700033;
        Sun, 01 Sep 2024 11:01:40 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5749b51sm5585952b3a.184.2024.09.01.11.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 11:01:39 -0700 (PDT)
Date: Mon, 2 Sep 2024 03:01:37 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 00/13] PCI: brcnstb: Enable STB 7712 SOC
Message-ID: <20240901180137.GN235729@rocinante>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815225731.40276-1-james.quinlan@broadcom.com>

Hello,

>   This submission is for the Broadcom STB 7712, sibling SOC of the RPi5 chip.
>   Stanimir has already submitted a patch "Add PCIe support for bcm2712" for
>   the RPi version of the SOC.  It is hoped that Stanimir will allow us to
>   submit this series first and subsequently rebase his patch(es).
> 
>   The largest commit, "Refactor for chips with many regular inbound BARs"
>   affects both the STB and RPi SOCs.  It allows for multiple inbound ranges
>   where previously only one was effectively used.  This feature will also
>   be present in future STB chips, as well as Broadcom's Cable Modem group.

Applied to controller/brcmstb, thank you!

[01/13] dt-bindings: PCI: brcm,stb-pcie: Change brcmstb maintainer and cleanup
        https://git.kernel.org/pci/pci/c/2cd86a7c2346

[02/13] dt-bindings: PCI: brcm,stb-pcie: Use maxItems for reset controllers
        https://git.kernel.org/pci/pci/c/9014c6b92fbe

[03/13] dt-bindings: PCI: brcm,stb-pcie: Add 7712 SoC description
        https://git.kernel.org/pci/pci/c/154051eae687

[04/13] PCI: brcmstb: Use common error handling code in brcm_pcie_probe()
        https://git.kernel.org/pci/pci/c/5ccf0ade7937

[05/13] PCI: brcmstb: Use bridge reset if available
        https://git.kernel.org/pci/pci/c/996a76b913ab

[06/13] PCI: brcmstb: Use swinit reset if available
        https://git.kernel.org/pci/pci/c/50fd71c2d2fb

[07/13] PCI: brcmstb: PCI: brcmstb: Make HARD_DEBUG, INTR2_CPU_BASE offsets SoC-specific
        https://git.kernel.org/pci/pci/c/e42c556de029

[08/13] PCI: brcmstb: Remove two unused constants from driver
        https://git.kernel.org/pci/pci/c/092001a4ebd0

[09/13] PCI: brcmstb: Don't conflate the reset rescal with PHY ctrl
        https://git.kernel.org/pci/pci/c/1bed07ffeccb

[10/13] PCI: brcmstb: Refactor for chips with many regular inbound windows
        https://git.kernel.org/pci/pci/c/22877c1ac638

[11/13] PCI: brcmstb: Check return value of all reset_control_* calls
        https://git.kernel.org/pci/pci/c/363051fc3ab8

[12/13] PCI: brcmstb: Change field name from 'type' to 'soc_base'
        https://git.kernel.org/pci/pci/c/e78bade02796

[13/13] PCI: brcmstb: Enable 7712 SOCs
        https://git.kernel.org/pci/pci/c/1ae791a877e7

	Krzysztof


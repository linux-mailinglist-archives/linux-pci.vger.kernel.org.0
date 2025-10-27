Return-Path: <linux-pci+bounces-39447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A171C0F1DD
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 17:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF6D1884228
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 15:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4A7227B8E;
	Mon, 27 Oct 2025 15:49:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B15486337
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580188; cv=none; b=MtZSUaXnbeqJqeE0V8IUqdr0MYaDHzLAdMSYpKJ83mkRHdcqIzZLeYL39ugSiHBZJy+EbP45mpJd/ihz5A/GFBakUPa+rQXg4Wvc1UyZnqGrIzTJVf+o4uKMgC6i4rpkhGPDkLSyQFFjHZO1VEYS4oYN5uCyDPhGzKUPObQDBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580188; c=relaxed/simple;
	bh=UWXNOia5i2LXFNCxniBhPNy+B3i2b+VOEpseDnBchwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQxGDg3wK2kS0xiABai1Mp8osTFxZMuMNtb/WFj8oyAO9vNFiJ60p0JgViaG3otLTaJZ/d2UQzK7uPbeD6AdifnDxdQ25THwPaiCNKT9zIXgwBaqon2IBnF5yWKfUMA5rTIOmlIY9OcliNat78ndbOc+hF32zVmN+GQiy2BIssQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avm99963.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avm99963.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4270900c887so610390f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 08:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761580185; x=1762184985;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tuFuQd8b6LEtd7q52rQ+yXQJ5DgFrv5WBeJOLMhL0Q=;
        b=LdZc8CPXQsPFCopdKp5xXyO2lTc0URNgAlI9AXOb4o3+LvzHxTHSoJrj7z+q+ctlmN
         +7mJxY4hk4kcc9p6sOfiIERUFWzuwQSpyFi0DRtg7AQJE+/0mB6YxuO5OfHTyRQcCK6U
         PVEKqhWrNTrVwMdWrtbaiRtKGWsBmWMNkOboHVCk828ekPHFTWKajLyGwZ8w5IQ+X+np
         KhDFWfeJkw35x1+loFEKcXygZPDl0Gs0MMPPFEMZI0bsSigPayIjN58SbE506Glgf94H
         BGJBLvYGu9Bh9vlX+6ZgIWKMWIjQDIzLseu4Nx/ZsGVs72QcX1i27DTLGwo2mN2pPaDF
         Jl4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtCjP3meRkh52zPVMD0yog1y7aAxQh04fLpQ1m4iBnVsJxLYeCuHYH0snf1DrtocwnFWlTcd5hQ24=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWisugP/PUjgmeMOIFe1BtRsvxROAbGfVDVU5cxslQaww1nge5
	hYkGEoDk2VlWtadU8ZykZkiltxICHhEOYbjJJaH8juFFy/tw5tH13/2PKG5kQ7VKjmiKlQ==
X-Gm-Gg: ASbGnctm6pXEjpA+sb0z1K0wvWKTWSKmUZu/bO97iT52PAcV+l7wkuiWMI/WvMEDN5H
	qajGCGRUyNb3z8xXyWhCV2mJ20apSZtw5x6073eEnTfA6w3ZvSSZy89n6v/fNUqRuZuxnZs/QJ4
	flCUeN5tKYjulK6qHBo1J37aNyIsk47Q/pXYfSR9cbyqdgxjBUNmldkdQMxgXPmpvrbRYM+d0wv
	UCO2avVsZB4yVuJcNgDjy8xd7YiLRLqWnVgFzdnFtARfeEU3+hu4qKgDkgi/3D/m2QvqUUMc8wP
	S4AHm0agdBofPensSE1yySplcHxEPJH8faEjHA1pwI29QuuEkVZrKbb2BTu29Kd2Pouv6i12zVv
	HI1uJYCbzoGFj8OnOamkBxgjpKhxyeIp2ckB5vUfvsDfDI54PvbufzWA00n4galh4mMqiLXiyIH
	M2GGXK8PwyTO5c1Wnac8sFa4CrPlfrnGgkF9dE8r1XT9Z6
X-Google-Smtp-Source: AGHT+IHbADARTiZwpNXdnPHTBLxEA2kvllMjfgUB3Ibxe0agSvm3wvLxkVZSwu9ItigqgGKwBTJx6A==
X-Received: by 2002:a05:6000:1846:b0:3f7:f02b:d7a with SMTP id ffacd0b85a97d-429a7e7c17bmr98740f8f.5.1761580184600;
        Mon, 27 Oct 2025 08:49:44 -0700 (PDT)
Received: from pixelbook (181.red-83-42-91.dynamicip.rima-tde.net. [83.42.91.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db9d1sm14798750f8f.35.2025.10.27.08.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:49:43 -0700 (PDT)
Date: Mon, 27 Oct 2025 16:49:40 +0100
From: =?utf-8?Q?Adri=C3=A0_Vilanova_Mart=C3=ADnez?= <me@avm99963.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	"Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] Intel Wireless adapter is not detected until
 suspending to RAM and resuming
Message-ID: <qfbtr6dxa37d2rj7e3kiswyuu2jeeys2iceas7v7xhak4h6wi2@s5tloxec4mnm>
References: <149b04c5-23d3-4fd8-9724-5b955b645fbb@kernel.org>
 <20251020232510.GA1167305@bhelgaas>
 <aPc4JpVyhCY1Oqd-@wunner.de>
 <zmkurgnjb4zw7zcg6uucbtvuratxlaau5lvhkgknidpjz7vnb7@dnsyjbrqtvqw>
 <aPj4kUglHgBm4uAt@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPj4kUglHgBm4uAt@wunner.de>
User-Agent: NeoMutt/20250905-dirty

On Wed, Oct 22, 2025 at 05:30:25PM +0200, Lukas Wunner wrote:
> On Tue, Oct 21, 2025 at 03:35:42PM +0200, Adrià Vilanova Martínez wrote:
> pcie_aspm_init_link_state() later does call pcie_config_aspm_path(),
> which should rectify incongruent settings.  But it's only called
> if the aspm_policy is something else than POLICY_POWERSAVE and
> POLICY_POWER_SUPERSAVE.
> 
> Which policy is set in your kernel configuration?
> (Search for CONFIG_PCIEASPM_...)

I have it set to "BIOS default":

CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set

> Does setting it to CONFIG_PCIEASPM_PERFORMANCE change the behavior?

Yes, I no longer see the "pciehp confusion" lines in dmesg and WiFi
works after bootup. I've attached the dmesg in the bug I just opened.

> With 4d4c10f763d7, the Wifi card falls off the bus and the link never
> comes back.  I don't know why the commit is causing that.  As Mario
> suggested, it may be caused by the platform.  Could you provide an
> acpidump for further analysis?  The usual way to share large blobs
> like this (as well as dmesg and lspci output) is by opening a bug
> on bugzilla.kernel.org and attaching it there.

Sure, I've created https://bugzilla.kernel.org/show_bug.cgi?id=220705
with the acpidump attached.

> Thanks,

Thank you!


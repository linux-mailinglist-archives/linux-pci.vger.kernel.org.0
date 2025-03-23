Return-Path: <linux-pci+bounces-24451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1269BA6CEE6
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 12:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96E587A5E50
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 11:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE8322612;
	Sun, 23 Mar 2025 11:25:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E6A15ADA6
	for <linux-pci@vger.kernel.org>; Sun, 23 Mar 2025 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742729101; cv=none; b=oGxdwYu6HRUyA9YIt8aiEC5Aj7q6vba8qXwnya0XqLU7hV3a1hXKtN1MICbRqAYcjvbYxDAWKKAjVnY+DkXI5jaQWT3cJfxmK9xV4iY5FpX9T+IW80fciPSwvphFB8ZMOOLuSWtr0EtYwX9sYWLZWBkoXN2SW2OpjMQGq4ox+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742729101; c=relaxed/simple;
	bh=O67YhVX38giaieRRDLsfgqk0+uDbPDx6MIa9E/qA/SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mf3zeGxtymFf4F9FFq2noT0LqVUegmwdp+BO3VyfYBb57i9p3At4NXOE32kxGjkPrk+HwaKFfGj8U27zBnJFzy7LOuUXnvhKwP5uZMd4AKrfZ/cvr4JLWx0PMpnEmVK66yX+bF98VPNws+r58fe5pga1HUoVFxcvCk6y7bjs/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22580c9ee0aso66519825ad.2
        for <linux-pci@vger.kernel.org>; Sun, 23 Mar 2025 04:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742729099; x=1743333899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFQac0exyW1jtN48EzeSupvVd0BAzATP14EtDe8PXHM=;
        b=SirOuLMRAafY+ew9WYbnFI9qlf0kvu3KROnioTlrePAiVrqWVXLF2kBwQy2+b0fQPK
         2DsU/pjOn+8ODCKl9KQiF0/sfLmxO8RQAV3cSwGpYoo1v5sUhwhUH5Hw3yahhVm4hUpn
         nGS6uiyYwTi2OXaaLs5g/unYwccl/JIYWcm+LmtZhkIkv3mdVexDS8spk4qf0XTZYFI8
         MSFMTF8L5IFtYNN7KG6MXykoZkZELwkN+M1qAIuArPrOzjYD95lsWksvGoFk//+ZgD07
         lDLIsEVrIyqtkfY66c8JBWq8qj+8B5XkiW5R4hLso6fGu3PqQ4vPu+5HlMGycRyUfizR
         TDgg==
X-Forwarded-Encrypted: i=1; AJvYcCW56L4gNNP77rGuqiJaxt70ryndapEuGlpzcYgRoEPBcG4QluyvzutOZp8ydQg106/PCdnSxsCwoR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX/e7uSxW86cNLH+BvIwodZhjH96TslFiqkULTH6eAvE6VzC6/
	VDd83SjWEONHLwYv2TKthQl2eXtOvCOqn9+O2jtjVwjuEZR+WnDW
X-Gm-Gg: ASbGnct8GXJ/o5ziSq02abcODWcOAjN1SawooxkDFUXL2CW9M/LpJnj4LHjNkhSoNqi
	6mLiTPyO6Cyjx3dVhpDSA0MFERrcRbrTUXhfOZiw4TyZ77n4O+mSx857kDlShXM/hqUbhUmGM1s
	Ioxb1cAhgNg9lrb2i85qyKQ2L46tvTHQmlGh+MrHXb7DRimA7Ek0RIPbSQzH2N1q3Lr40lZrFt7
	83wJIwHE8K0b96FJFcQHeRKh926gw7NBa1SpaQjOUYHqmJm3tJhBxBjVHxc7KZ3+SNYjzmD/qyX
	M5P1s6OTFvMJg/FowOj+XjJt7osgxcrTunuAAtVPo5YJpZF0owfEATjR8Tzq65KiTVJh7spkppm
	wfYs=
X-Google-Smtp-Source: AGHT+IFpStmn1lPBaIAQ4pSdUs0t3i8VfM+F8RNt33ywjxXdmRWTKZTBWpFc7dfnd+hjj5CVw6mI8Q==
X-Received: by 2002:a05:6a21:7888:b0:1f5:769a:a4c2 with SMTP id adf61e73a8af0-1fe42f9b78amr15785601637.22.1742729099034;
        Sun, 23 Mar 2025 04:24:59 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af8a2a4c905sm5009481a12.66.2025.03.23.04.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 04:24:58 -0700 (PDT)
Date: Sun, 23 Mar 2025 20:24:56 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Wouter Bijlsma <wouter@wouterbijlsma.nl>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI/bwctrl: Fix NULL pointer deref on bus number
 exhaustion
Message-ID: <20250323112456.GA1902347@rocinante>
References: <3b6c8d973aedc48860640a9d75d20528336f1f3c.1742669372.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b6c8d973aedc48860640a9d75d20528336f1f3c.1742669372.git.lukas@wunner.de>

Hello,

> When BIOS neglects to assign bus numbers to PCI bridges, the kernel
> attempts to correct that during PCI device enumeration.  If it runs out
> of bus numbers, no pci_bus is allocated and the "subordinate" pointer in
> the bridge's pci_dev remains NULL.
> 
> The PCIe bandwidth controller erroneously does not check for a NULL
> subordinate pointer and dereferences it on probe.
> 
> Bandwidth control of unusable devices below the bridge is of questionable
> utility, so simply error out instead.  This mirrors what PCIe hotplug does
> since commit 62e4492c3063 ("PCI: Prevent NULL dereference during pciehp
> probe").
> 
> The PCI core emits a message with KERN_INFO severity if it has run out of
> bus numbers.  PCIe hotplug emits an additional message with KERN_ERR
> severity to inform the user that hotplug functionality is disabled at the
> bridge.  A similar message for bandwidth control does not seem merited,
> given that its only purpose so far is to expose an up-to-date link speed
> in sysfs and throttle the link speed on certain laptops with limited
> Thermal Design Power.  So error out silently.
> 
> User-visible messages:
> 
>   pci 0000:16:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>   [...]
>   pci_bus 0000:45: busn_res: [bus 45-74] end is updated to 74
>   pci 0000:16:02.0: devices behind bridge are unusable because [bus 45-74] cannot be assigned for them
>   [...]
>   pcieport 0000:16:02.0: pciehp: Hotplug bridge without secondary bus, ignoring
>   [...]
>   BUG: kernel NULL pointer dereference
>   RIP: pcie_update_link_speed
>   pcie_bwnotif_enable
>   pcie_bwnotif_probe
>   pcie_port_probe_service
>   really_probe

Applied to bwctrl, thank you!

	Krzysztof


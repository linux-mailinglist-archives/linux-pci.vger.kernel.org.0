Return-Path: <linux-pci+bounces-42218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7D8C8F852
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 17:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1EB3AC5A2
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68DD2D73AE;
	Thu, 27 Nov 2025 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Gwy+s5wS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47E62D4B77
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764261171; cv=none; b=phejHQfLom8/20nGoyvToK2wFnY9SRrrEF18i7kfVcODgin9Fa/6epa3shwmSNNlT6MdFp8r60bqP2V9AOpPiWvN71hbD4uLsczQC4heaA2Bm/x0KrKYK5oEJlGQhm82z5+/gsaVhfncxYGs9WqPnu1WVKNVlXXixj5/A6KZlbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764261171; c=relaxed/simple;
	bh=JvJpadJjLQ8dGtl4sCeVtrxU5nUzF4NTVZ/JEnUCxE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwKBSK/FLcVXzxFxPTwLQITnVmrysJTax02Xdv8Rez+/7wedUSuM7/AhMnVEwhkt3Q7uZ/tOx09DaT6h/MeMeNfOfFj6VtAN5TB79fYeRwPboQjxEL3SwApqRIeb9eH9O1iXx69RCjuDooGr6W64mLvK1w4xqDc9ttS2ZDLg0Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Gwy+s5wS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47755de027eso6408355e9.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 08:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764261166; x=1764865966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKVqbmbYDjt2aG06aO4it6hvCBdhXQa3Fx2jFIE6mes=;
        b=Gwy+s5wSJFoOEIyuToRFU743VrnSC027lHPNEj132O0b1T13hoYQ9OFJGFOcZ5ijVr
         Fh3j7eHdKa7E1p35q7O9tq3R0ozuGaHvJ9G2jSJzgxPpyZ1+aIw+FmgJhik335nFS2/o
         gAjj6bvVK55TBI34cf/lFHM2+J2Ha/iDa2PquZCM7GZ0/17WZn45XXU60DvNeSW1uybj
         vcekWCCRG1U+zGosFYszPbf21U8yjzLKqBG5bmumlQmG1Fmgs9Vso+Q0SBCAS+sgJdjH
         vC6EtMYq8+qCKAprBX4C1e6jSUwnEds8UhrsVCs3jq43vCAuaLkDBhNHWveBmD/A5kPU
         LATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764261166; x=1764865966;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKVqbmbYDjt2aG06aO4it6hvCBdhXQa3Fx2jFIE6mes=;
        b=v0kFzxtkdHePgEVN6p64mrBQ/btYuO7f+6r6gj1z5Dn95Lf11CD5dffuFgwbKzJ7F2
         TkqYZhBXgunxi5jAq1fu1nOeI3204rke3rRbNRAy9Am76oUTXFR/iot98m6OuUaapYNW
         tl2Y+THkjjk840mRLWZpaV4rrIX6rx8WIZvyI0Fv5glWDkyAG980nNPlpZMOlXXA3Kyx
         lXbJjTyZF/8rFCiWhTHRfuxyMt2wfRjCibDpEbi/dIma5xKfkjzxXof71q8Go5PRYk/0
         RVd2N84Zlx/Q958Tc8JStFNiJ4hFT1jZ655KuIs3AF/79mS0/jKo4w3bS8Swzn2xIdo3
         sdbg==
X-Forwarded-Encrypted: i=1; AJvYcCVmXbWtWULjIgXRMKzS56H2NIjpa59roO0mw5HgitBYKJrE0nhq7Xv8e4Hm+/DUskZO+TF9pW9JLK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJYgLEowf/THBwCeq+4I96csYlNVKMrNMI3R38pESfA/XEeoq/
	3xsAKkExhSOap1QwDEzisPMgpo+aMBwkOVBg1t50m/7MD6fvVYCEEfMi1IUwIOgNSio=
X-Gm-Gg: ASbGnctER6zuio+Y6ioBUz1U5U+/rezy2YUHWD6hSRuXt4D7M8rT7wNtnUPZvADR7NG
	Z+4o17DB2WF5X+xThXQWa7vW6qooE5quaA8FDBCl/GUosFllPCIUUhTQQoGzAuyM2M+lyektbaq
	vYG/UwEPsHmI03Q4ZlyWzN85dGXBwTiaxlbrjh+xg2EzCVIjIChW5FZmLxGyeArHGXyZY7qdAOB
	vUbQdZ0oMrNEoMl9iXifOwYsoCa6S+Rz8NyRm9yGHB2M/Um7pVThMAeJt/LGeBd2RFGYlAc2xXx
	7Qfc3aT86lptwoW7iBOJwdrIeH2O02VA08Wecc2VHca5nvzRos7rxk9Q3FDCxyWkOGflOKyC/x+
	T6TATXfxAFQZVqTt0JQZb999n6c560nIgYpI5Q0nnHTk8EFD5u8u0YTK2LsmjfDtqfDTtvkDRiV
	w3sOe7J+ocUZk8078zW/2Vhh13qEN6pA==
X-Google-Smtp-Source: AGHT+IHweSOqzB3IIBKYCWBK73TIqate1XgFcKtrv9s7ofxHH2XF8oDhzaXKQ3OOlO8SCoS1Bn2Jsg==
X-Received: by 2002:adf:ed0c:0:b0:42b:3d93:9a27 with SMTP id ffacd0b85a97d-42e0f3492b2mr9422248f8f.36.1764261165648;
        Thu, 27 Nov 2025 08:32:45 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d607csm4782170f8f.15.2025.11.27.08.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 08:32:45 -0800 (PST)
Message-ID: <04022d6e-0351-4545-94f2-36b583921b58@tuxon.dev>
Date: Thu, 27 Nov 2025 18:32:43 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host
 driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, p.zabel@pengutronix.de,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20251126191940.GA2831320@bhelgaas>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20251126191940.GA2831320@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Bjorn,

On 11/26/25 21:19, Bjorn Helgaas wrote:
> On Wed, Nov 26, 2025 at 07:22:09PM +0200, Claudiu Beznea wrote:
>> On 11/25/25 20:37, Bjorn Helgaas wrote:
>>> On Wed, Nov 19, 2025 at 04:35:19PM +0200, Claudiu wrote:
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
>>>> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
>>>> only as a root complex, with a single-lane (x1) configuration. The
>>>> controller includes Type 1 configuration registers, as well as IP
>>>> specific registers (called AXI registers) required for various adjustments.
>>>
>>>> +/* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
>>>> +static int rzg3s_pcie_root_write(struct pci_bus *bus, unsigned int devfn,
>>>> +				 int where, int size, u32 val)
>>>> +{
>>>> +	struct rzg3s_pcie_host *host = bus->sysdata;
>>>> +	int ret;
>>>> +
>>>> +	/* Enable access control to the CFGU */
>>>> +	writel_relaxed(RZG3S_PCI_PERM_CFG_HWINIT_EN,
>>>> +		       host->axi + RZG3S_PCI_PERM);
>>>
>>> I suppose this has been asked and answered already, but it's curious
>>> that you need this for config writes but not for reads.  Obviously it
>>> must *work*, but it's unusual and might warrant a comment.  "Access
>>> control" must be a hint, but only means something to experts.
>>
>> After initialization, some PCI registers are read only. To enable write
>> access to these registers after initialization, the access control need to
>> be enabled.
> 
> rzg3s_pcie_root_write() is a config accessor.  All the users of this
> expect the semantics documented by the PCI/PCIe spec.  Registers
> documented as read-only *should* be read-only in those situations.
> 
> BIOS and native host bridge drivers like this one may need to
> initialize registers that are read-only to the OS.  Some hardware
> supports that initialization via device-specific addresses outside of
> normal config space.
> 
> It looks like this hardware supports that initialization using the
> PCI/PCIe-documented config addresses, but uses RZG3S_PCI_PERM to
> control whether things are read-only or not.  It's used that way in
> rzg3s_pcie_host_init_port(), rzg3s_pcie_config_init(), etc.
> 
> That's perfectly fine, as long as this all happens before the OS sees
> the devices.  If writes to read-only registers happen *after* the OS
> starts enumerating devices, then we have a problem because the OS may
> cache the values of read-only registers.
> 
> Bottom line, I think:
> 
>   - rzg3s_pcie_root_write() should *not* use RZG3S_PCI_PERM at all.
>     In fact, it should not exist, and rzg3s_pcie_root_ops.write should
>     be pci_generic_config_write().

I confirm all is good by dropping rzg3s_pcie_root_write() and using
pci_generic_config_write() instead.

> 
>   - rzg3s_pcie_config_init() should use RZG3S_PCI_PERM to update
>     RZG3S_PCI_CFG_BARMSK00, but should *not* need it to update the
>     bus info because those registers are read/write per spec.

I confirm adopting this approach lead to no failures on my tests.

> 
> The other users look like they do need RZG3S_PCI_PERM to initialize
> the Vendor and Device IDs (which are read-only per spec) and PHY
> registers (which are not part of the programming model documented by
> the PCIe spec).

Indeed.

> 
> rzg3s_pcie_config_init() looks like a problem because it's called from
> rzg3s_pcie_resume_noirq(), which happens after the OS owns the PCI
> hardware.  The OS may have updated the bus numbers, and
> rzg3s_pcie_config_init() will overwrite them with whatever it got from
> DT.  With a single Root Port, it's not *likely* that the OS would
> change the secondary or subordinate bus numbers, but you can't assume
> they are fixed.
> 
> I don't know if the hardware loses the bus numbers when it is
> suspended.

It can lose it as in one of the suspend modes the power to most of the SoC
components (including PCIe) is turned off.

>  If it does, I think you would need to capture them during
> suspend, save them somewhere like rzg3s_pcie_port, and restore them
> during resume.
> 
> You should be able to verify that this is a problem by booting the
> kernel, decreasing the subordinate bus number via setpci, suspending
> and resuming, and checking the subordinate bus number with lspci.  I
> think you'll see that setpci update lost.

I updated the code as you suggested and added some prints through the code
to test it. Diff used for this is:

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index b123da16b63b..4e6198b2d436 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -114,6 +114,8 @@ int pci_generic_config_write(struct pci_bus *bus,
unsigned int devfn,
        if (!addr)
                return PCIBIOS_DEVICE_NOT_FOUND;

+       if (where == 0x18 || where == 0x19 || where == 0x1a)
+               pr_err("%s(): set %x=%x\n", __func__, where, val);
        if (size == 1)
                writeb(val, addr);
        else if (size == 2)
diff --git a/drivers/pci/controller/pcie-rzg3s-host.c
b/drivers/pci/controller/pcie-rzg3s-host.c
index 667e6d629474..2670907a68d5 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -436,31 +436,15 @@ static void __iomem *rzg3s_pcie_root_map_bus(struct
pci_bus *bus,
        if (devfn)
                return NULL;

-       return host->pcie + where;
-}
-
-/* Serialized by 'pci_lock' */
-static int rzg3s_pcie_root_write(struct pci_bus *bus, unsigned int devfn,
-                                int where, int size, u32 val)
-{
-       struct rzg3s_pcie_host *host = bus->sysdata;
-       int ret;
+       if (where == 0x18 || where == 0x19 || where == 0x1a)
+               dump_stack();

-       /* Enable access control to the CFGU */
-       writel_relaxed(RZG3S_PCI_PERM_CFG_HWINIT_EN,
-                      host->axi + RZG3S_PCI_PERM);
-
-       ret = pci_generic_config_write(bus, devfn, where, size, val);
-
-       /* Disable access control to the CFGU */
-       writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
-
-       return ret;
+       return host->pcie + where;
 }

 static struct pci_ops rzg3s_pcie_root_ops = {
        .read           = pci_generic_config_read,
-       .write          = rzg3s_pcie_root_write,
+       .write          = pci_generic_config_write,
        .map_bus        = rzg3s_pcie_root_map_bus,
 };

@@ -1065,14 +1049,18 @@ static int rzg3s_pcie_config_init(struct
rzg3s_pcie_host *host)
        writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00L);
        writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00U);

+       /* Disable access control to the CFGU */
+       writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
+
+       pr_err("%s(): primary=%u, secondary=%u, subordinate=%u\n", __func__,
+               primary_bus, secondary_bus,
+               subordinate_bus);
+
        /* Update bus info */
        writeb_relaxed(primary_bus, host->pcie + PCI_PRIMARY_BUS);
        writeb_relaxed(secondary_bus, host->pcie + PCI_SECONDARY_BUS);
        writeb_relaxed(subordinate_bus, host->pcie + PCI_SUBORDINATE_BUS);

-       /* Disable access control to the CFGU */
-       writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
-
        return 0;
 }

When resuming, first the RZ/G3S PCIe driver sets the primary, secondary,
subordinate to the values from the DT then pci_restore_state() writes the
values that was set with setpci.

The decoded path on top of v6.18-rc1 is:

[  140.310728]  rzg3s_pcie_root_map_bus
(drivers/pci/controller/pcie-rzg3s-host.c:440)
[  140.310737]  pci_generic_config_write (drivers/pci/access.c:114)
[  140.310748]  pci_bus_write_config_dword (drivers/pci/access.c:79
(discriminator 2))
[  140.310758]  pci_write_config_dword (drivers/pci/access.c:615)
[  140.310766]  pci_restore_config_space_range (drivers/pci/pci.c:1781
drivers/pci/pci.c:1799)
[  140.310774]  pci_restore_state.part.0 (drivers/pci/pci.c:1628
drivers/pci/pci.c:1727 drivers/pci/pci.c:1876)
[  140.310783]  pci_restore_state (drivers/pci/pci.c:1884)

The following is the console output:

root@smarc-rzg3s:~#
root@smarc-rzg3s:~# lspci
[   28.678299] CPU: 0 UID: 0 PID: 238 Comm: lspci Not tainted
6.18.0-rc1-00007-gbd38f075378c #38 PREEMPT
[   28.678335] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[   28.678342] Call trace:
[   28.678347]  show_stack+0x18/0x24 (C)
[   28.678369]  dump_stack_lvl+0x78/0x90
[   28.678388]  dump_stack+0x18/0x24
[   28.678398]  rzg3s_pcie_root_map_bus+0x44/0x5c
[   28.678414]  pci_generic_config_read+0x24/0xd8
[   28.678430]  pci_user_read_config_dword+0x78/0x11c
[   28.678439]  pci_read_config+0x1e0/0x24c
[   28.678452]  sysfs_kf_bin_read+0x7c/0xbc
[   28.678465]  kernfs_fop_read_iter+0xb0/0x1c4
[   28.678472]  vfs_read+0x214/0x2fc
[   28.678486]  __arm64_sys_pread64+0xa4/0xcc
[   28.678495]  invoke_syscall+0x48/0x10c
[   28.678509]  el0_svc_common.constprop.0+0xc0/0xe0
[   28.678519]  do_el0_svc+0x1c/0x28
[   28.678529]  el0_svc+0x34/0xf0
[   28.678539]  el0t_64_sync_handler+0xa0/0xe4
[   28.678546]  el0t_64_sync+0x198/0x19c
00:00.0 PCI bridge: Renesas Technology Corp. Device 0033
01:00.0 Non-Volatile memory controller: Transcend Information, Inc. NVMe
PCIe SSD 110S/112S/120S/MTE300S/MTE400S/MTE652T2 (DRAM-less) (rev 03)
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~# setpci -s 00:00.0 0x1a.b
ff
[   41.844847] CPU: 0 UID: 0 PID: 239 Comm: setpci Not tainted
6.18.0-rc1-00007-gbd38f075378c #38 PREEMPT
[   41.844883] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[   41.844890] Call trace:
[   41.844896]  show_stack+0x18/0x24 (C)
[   41.844918]  dump_stack_lvl+0x78/0x90
[   41.844937]  dump_stack+0x18/0x24
[   41.844947]  rzg3s_pcie_root_map_bus+0x44/0x5c
[   41.844963]  pci_generic_config_read+0x24/0xd8
[   41.844980]  pci_user_read_config_byte+0x70/0xfc
[   41.844990]  pci_read_config+0xf8/0x24c
[   41.845002]  sysfs_kf_bin_read+0x7c/0xbc
[   41.845015]  kernfs_fop_read_iter+0xb0/0x1c4
[   41.845023]  vfs_read+0x214/0x2fc
[   41.845036]  __arm64_sys_pread64+0xa4/0xcc
[   41.845046]  invoke_syscall+0x48/0x10c
[   41.845060]  el0_svc_common.constprop.0+0xc0/0xe0
[   41.845070]  do_el0_svc+0x1c/0x28
[   41.845079]  el0_svc+0x34/0xf0
[   41.845089]  el0t_64_sync_handler+0xa0/0xe4
[   41.845096]  el0t_64_sync+0x198/0x19c
root@smarc-rzg3s:~# setpci -s 00:00.0 0x1a.b=0x3
[   46.429192] CPU: 0 UID: 0 PID: 240 Comm: setpci Not tainted
6.18.0-rc1-00007-gbd38f075378c #38 PREEMPT
[   46.429229] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[   46.429236] Call trace:
[   46.429241]  show_stack+0x18/0x24 (C)
[   46.429263]  dump_stack_lvl+0x78/0x90
[   46.429283]  dump_stack+0x18/0x24
[   46.429293]  rzg3s_pcie_root_map_bus+0x44/0x5c
[   46.429309]  pci_generic_config_write+0x2c/0xf0
[   46.429325]  pci_user_write_config_byte+0x58/0xc8
[   46.429334]  pci_write_config+0x1ac/0x234
[   46.429347]  sysfs_kf_bin_write+0x90/0xb8
[   46.429360]  kernfs_fop_write_iter+0x128/0x1b8
[   46.429368]  vfs_write+0x2ac/0x350
[   46.429381]  __arm64_sys_pwrite64+0xa4/0xcc
[   46.429391]  invoke_syscall+0x48/0x10c
[   46.429404]  el0_svc_common.constprop.0+0xc0/0xe0
[   46.429414]  do_el0_svc+0x1c/0x28
[   46.429423]  el0_svc+0x34/0xf0
[   46.429433]  el0t_64_sync_handler+0xa0/0xe4
[   46.429440]  el0t_64_sync+0x198/0x19c
[   46.429451] pci_generic_config_write(): set 1a=3
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~# setpci -s 00:00.0 0x1a.b
03
[   49.624740] CPU: 0 UID: 0 PID: 241 Comm: setpci Not tainted
6.18.0-rc1-00007-gbd38f075378c #38 PREEMPT
[   49.624775] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[   49.624782] Call trace:
[   49.624788]  show_stack+0x18/0x24 (C)
[   49.624811]  dump_stack_lvl+0x78/0x90
[   49.624831]  dump_stack+0x18/0x24
[   49.624841]  rzg3s_pcie_root_map_bus+0x44/0x5c
[   49.624857]  pci_generic_config_read+0x24/0xd8
[   49.624873]  pci_user_read_config_byte+0x70/0xfc
[   49.624883]  pci_read_config+0xf8/0x24c
[   49.624895]  sysfs_kf_bin_read+0x7c/0xbc
[   49.624908]  kernfs_fop_read_iter+0xb0/0x1c4
[   49.624915]  vfs_read+0x214/0x2fc
[   49.624928]  __arm64_sys_pread64+0xa4/0xcc
[   49.624937]  invoke_syscall+0x48/0x10c
[   49.624951]  el0_svc_common.constprop.0+0xc0/0xe0
[   49.624962]  do_el0_svc+0x1c/0x28
[   49.624971]  el0_svc+0x34/0xf0
[   49.624983]  el0t_64_sync_handler+0xa0/0xe4
[   49.624990]  el0t_64_sync+0x198/0x19c
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~# echo mem > /sys/power/state
[   54.099960] PM: suspend entry (deep)
[   54.104583] Filesystems sync: 0.000 seconds
[   54.124099] Freezing user space processes
[   54.134824] Freezing user space processes completed (elapsed 0.002 seconds)
[   54.141972] OOM killer disabled.
[   54.145216] Freezing remaining freezable tasks
[   54.150975] Freezing remaining freezable tasks completed (elapsed 0.001
seconds)
[   54.192143] ravb 11c30000.ethernet end0: Link is Down
[   54.215075] CPU: 0 UID: 0 PID: 12 Comm: kworker/u4:0 Not tainted
6.18.0-rc1-00007-gbd38f075378c #38 PREEMPT
[   54.215111] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[   54.215118] Workqueue: async async_run_entry_fn
[   54.215150] Call trace:
[   54.215155]  show_stack+0x18/0x24 (C)
[   54.215170]  dump_stack_lvl+0x78/0x90
[   54.215189]  dump_stack+0x18/0x24
[   54.215199]  rzg3s_pcie_root_map_bus+0x44/0x5c
[   54.215213]  pci_generic_config_read+0x24/0xd8
[   54.215230]  pci_bus_read_config_dword+0x7c/0xdc
[   54.215240]  pci_read_config_dword+0x30/0x4c
[   54.215249]  pci_save_state+0x34/0x1b8
[   54.215259]  pci_pm_suspend_noirq+0x1f0/0x26c
[   54.215268]  device_suspend_noirq+0x74/0x248
[   54.215284]  async_suspend_noirq+0x24/0x3c
[   54.215293]  async_run_entry_fn+0x34/0xe0
[   54.215302]  process_one_work+0x150/0x294
[   54.215317]  worker_thread+0x2dc/0x3dc
[   54.215327]  kthread+0x130/0x1fc
[   54.215338]  ret_from_fork+0x10/0x20
[   54.216286] Disabling non-boot CPUs ...
NOTICE:  BL2: v2.7(release):2.7.0/g3s_1.0.0_rc4
NOTICE:  BL2: Built : 11:52:53, Feb 29 2024
NOTICE:  BL2: Booting BL31
[   54.314875] rzg3s_pcie_config_init(): primary=0, secondary=1,
subordinate=255
[   54.412212] rzg3s-pcie-host 11e40000.pcie: PCIe link status [0x100014e]
[   54.610904] CPU: 0 UID: 0 PID: 73 Comm: kworker/u4:4 Not tainted
6.18.0-rc1-00007-gbd38f075378c #38 PREEMPT
[   54.610918] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[   54.610925] Workqueue: async async_run_entry_fn
[   54.610956] Call trace:
[   54.610961]  show_stack+0x18/0x24 (C)
[   54.610975]  dump_stack_lvl+0x78/0x90
[   54.610994]  dump_stack+0x18/0x24
[   54.611003]  rzg3s_pcie_root_map_bus+0x44/0x5c
[   54.611018]  pci_generic_config_read+0x24/0xd8
[   54.611034]  pci_bus_read_config_dword+0x7c/0xdc
[   54.611044]  pci_read_config_dword+0x30/0x4c
[   54.611053]  pci_restore_config_space_range+0x78/0x130
[   54.611063]  pci_restore_state.part.0+0x200/0x354
[   54.611072]  pci_restore_state+0x1c/0x28
[   54.611081]  pci_pm_resume_noirq+0x108/0x184
[   54.611089]  device_resume_noirq+0x128/0x244
[   54.611105]  async_resume_noirq+0x24/0x3c
[   54.611115]  async_run_entry_fn+0x34/0xe0
[   54.611124]  process_one_work+0x150/0x294
[   54.611139]  worker_thread+0x2dc/0x3dc
[   54.611149]  kthread+0x130/0x1fc
[   54.611160]  ret_from_fork+0x10/0x20
[   54.611175] CPU: 0 UID: 0 PID: 73 Comm: kworker/u4:4 Not tainted
6.18.0-rc1-00007-gbd38f075378c #38 PREEMPT
[   54.611184] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[   54.611188] Workqueue: async async_run_entry_fn
[   54.611197] Call trace:
[   54.611200]  show_stack+0x18/0x24 (C)
[   54.611207]  dump_stack_lvl+0x78/0x90
[   54.611219]  dump_stack+0x18/0x24
[   54.611228]  rzg3s_pcie_root_map_bus+0x44/0x5c
[   54.611238]  pci_generic_config_write+0x2c/0xf0
[   54.611247]  pci_bus_write_config_dword+0x64/0xa8
[   54.611257]  pci_write_config_dword+0x30/0x44
[   54.611265]  pci_restore_config_space_range+0xc8/0x130
[   54.611274]  pci_restore_state.part.0+0x200/0x354
[   54.611284]  pci_restore_state+0x1c/0x28
[   54.611292]  pci_pm_resume_noirq+0x108/0x184
[   54.611299]  device_resume_noirq+0x128/0x244
[   54.611311]  async_resume_noirq+0x24/0x3c
[   54.611321]  async_run_entry_fn+0x34/0xe0
[   54.611329]  process_one_work+0x150/0x294
[   54.611340]  worker_thread+0x2dc/0x3dc
[   54.611350]  kthread+0x130/0x1fc
[   54.611359]  ret_from_fork+0x10/0x20
[   54.611368] pci_generic_config_write(): set 18=30100
[   54.854732] nvme nvme0: 1/0/0 default/read/poll queues
[   54.882178] Microchip KSZ9131 Gigabit PHY 11c30000.ethernet-ffffffff:07:
attached PHY driver (mii_bus:phy_addr=11c30000.ethernet-ffffffff:07, irq=57)
[   54.966191] Microchip KSZ9131 Gigabit PHY 11c40000.ethernet-ffffffff:07:
attached PHY driver (mii_bus:phy_addr=11c40000.ethernet-ffffffff:07, irq=59)
[   55.013453] OOM killer enabled.
[   55.016722] Restarting tasks: Starting
[   55.027808] Restarting tasks: Done
[   55.035067] random: crng reseeded on system resumption
[   55.047140] PM: suspend exit
[   57.483265] ravb 11c30000.ethernet end0: Link is Up - 1Gbps/Full - flow
control off
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~# setpci -s 00:00.0 0x1a.b
[   61.102675] CPU: 0 UID: 0 PID: 247 Comm: setpci Not tainted
6.18.0-rc1-00007-gbd38f075378c #38 PREEMPT
[   61.102710] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[   61.102717] Call trace:
[   61.102722]  show_stack+0x18/0x24 (C)
[   61.102745]  dump_stack_lvl+0x78/0x90
[   61.102764]  dump_stack+0x18/0x24
[   61.102774]  rzg3s_pcie_root_map_bus+0x44/0x5c
[   61.102791]  pci_generic_config_read+0x24/0xd8
[   61.102807]  pci_user_read_config_byte+0x70/0xfc
[   61.102817]  pci_read_config+0xf8/0x24c
[   61.102829]  sysfs_kf_bin_read+0x7c/0xbc
[   61.102842]  kernfs_fop_read_iter+0xb0/0x1c4
[   61.102850]  vfs_read+0x214/0x2fc
[   61.102862]  __arm64_sys_pread64+0xa4/0xcc
[   61.102871]  invoke_syscall+0x48/0x10c
[   61.102885]  el0_svc_common.constprop.0+0xc0/0xe0
[   61.102895]  do_el0_svc+0x1c/0x28
[   61.102904]  el0_svc+0x34/0xf0
[   61.102914]  el0t_64_sync_handler+0xa0/0xe4
[   61.102921]  el0t_64_sync+0x198/0x19c
03
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#


If saving primary, secondary, subordinate values in suspend with the
following diff (please let me know if you want me to add the content of
struct rzg3s_pcie_suspend to the struct rzg3s_pcie_port) then the write
from pci_restore_config_space_range() is skipped:

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c
b/drivers/pci/controller/pcie-rzg3s-host.c
index 2670907a68d5..0ee8ddd387ec 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -223,6 +223,18 @@ struct rzg3s_pcie_port {
        u32 device_id;
 };

+/**
+ * struct rzg3s_pcie_suspend - RZ/G3S PCIe suspend
+ * @primary_bus: Primary bus that need to restored after suspend
+ * @secondary_bus: Secondary bus that need to be restored after suspend
+ * @subordinate_bus: Subordinate bus that need to be restored after suspend
+ */
+struct rzg3s_pcie_suspend {
+       u8 primary_bus;
+       u8 secondary_bus;
+       u8 subordinate_bus;
+};
+
 /**
  * struct rzg3s_pcie_host - RZ/G3S PCIe data structure
  * @axi: base address for AXI registers
@@ -251,6 +263,7 @@ struct rzg3s_pcie_host {
        struct rzg3s_pcie_msi msi;
        struct rzg3s_pcie_port port;
        raw_spinlock_t hw_lock;
+       struct rzg3s_pcie_suspend suspend;
        int intx_irqs[PCI_NUM_INTX];
        int max_link_speed;
 };
@@ -1026,20 +1039,21 @@ static int rzg3s_pcie_set_max_link_speed(struct
rzg3s_pcie_host *host)
 static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
 {
        struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
+       struct rzg3s_pcie_suspend *suspend = &host->suspend;
        struct resource_entry *ft;
        struct resource *bus;
-       u8 subordinate_bus;
-       u8 secondary_bus;
-       u8 primary_bus;

        ft = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
        if (!ft)
                return -ENODEV;

        bus = ft->res;
-       primary_bus = bus->start;
-       secondary_bus = bus->start + 1;
-       subordinate_bus = bus->end;
+       if (!suspend->primary_bus)
+               suspend->primary_bus = bus->start;
+       if (!suspend->secondary_bus)
+               suspend->secondary_bus = bus->start + 1;
+       if (!suspend->subordinate_bus)
+               suspend->subordinate_bus = bus->end;

        /* Enable access control to the CFGU */
        writel_relaxed(RZG3S_PCI_PERM_CFG_HWINIT_EN,
@@ -1053,13 +1067,14 @@ static int rzg3s_pcie_config_init(struct
rzg3s_pcie_host *host)
        writel_relaxed(0, host->axi + RZG3S_PCI_PERM);

        pr_err("%s(): primary=%u, secondary=%u, subordinate=%u\n", __func__,
-               primary_bus, secondary_bus,
-               subordinate_bus);
+               suspend->primary_bus, suspend->secondary_bus,
+               suspend->subordinate_bus);

        /* Update bus info */
-       writeb_relaxed(primary_bus, host->pcie + PCI_PRIMARY_BUS);
-       writeb_relaxed(secondary_bus, host->pcie + PCI_SECONDARY_BUS);
-       writeb_relaxed(subordinate_bus, host->pcie + PCI_SUBORDINATE_BUS);
+       writeb_relaxed(suspend->primary_bus, host->pcie + PCI_PRIMARY_BUS);
+       writeb_relaxed(suspend->secondary_bus, host->pcie + PCI_SECONDARY_BUS);
+       writeb_relaxed(suspend->subordinate_bus,
+                      host->pcie + PCI_SUBORDINATE_BUS);

        return 0;
 }
@@ -1622,10 +1637,15 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
 {
        struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
        const struct rzg3s_pcie_soc_data *data = host->data;
+       struct rzg3s_pcie_suspend *suspend = &host->suspend;
        struct rzg3s_pcie_port *port = &host->port;
        struct regmap *sysc = host->sysc;
        int ret;

+       suspend->primary_bus = readl_relaxed(host->pcie + PCI_PRIMARY_BUS);
+       suspend->secondary_bus = readb_relaxed(host->pcie + PCI_SECONDARY_BUS);
+       suspend->subordinate_bus = readb_relaxed(host->pcie +
PCI_SUBORDINATE_BUS);
+
        ret = pm_runtime_put_sync(dev);
        if (ret)
                return ret;

With this the write from pci_restore_config_space_range() is skipped as it
was already updated by the driver. Below is the console output:

root@smarc-rzg3s:~# lspci
[   42.932043] CPU: 0 UID: 0 PID: 240 Comm: lspci Not tainted
6.18.0-rc1-00008-gcb1b33f1dd58 #39 PREEMPT
[   42.932080] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[   42.932086] Call trace:
[   42.932091]  show_stack+0x18/0x24 (C)
[   42.932113]  dump_stack_lvl+0x78/0x90
[   42.932132]  dump_stack+0x18/0x24
[   42.932142]  rzg3s_pcie_root_map_bus+0x44/0x5c
[   42.932158]  pci_generic_config_read+0x24/0xd8
[   42.932174]  pci_user_read_config_dword+0x78/0x11c
[   42.932184]  pci_read_config+0x1e0/0x24c
[   42.932197]  sysfs_kf_bin_read+0x7c/0xbc
[   42.932209]  kernfs_fop_read_iter+0xb0/0x1c4
[   42.932217]  vfs_read+0x214/0x2fc
[   42.932230]  __arm64_sys_pread64+0xa4/0xcc
[   42.932239]  invoke_syscall+0x48/0x10c
[   42.932253]  el0_svc_common.constprop.0+0xc0/0xe0
[   42.932263]  do_el0_svc+0x1c/0x28
[   42.932273]  el0_svc+0x34/0xf0
[   42.932283]  el0t_64_sync_handler+0xa0/0xe4
[   42.932290]  el0t_64_sync+0x198/0x19c
00:00.0 PCI bridge: Renesas Technology Corp. Device 0033
01:00.0 Non-Volatile memory controller: Transcend Information, Inc. NVMe
PCIe SSD 110S/112S/120S/MTE300S/MTE400S/MTE652T2 (DRAM-less) (rev 03)
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~# setpci -s 00:00.0 0x1a.b
ff
[   45.989548] CPU: 0 UID: 0 PID: 241 Comm: setpci Not tainted
6.18.0-rc1-00008-gcb1b33f1dd58 #39 PREEMPT
[   45.989584] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[   45.989590] Call trace:
[   45.989596]  show_stack+0x18/0x24 (C)
[   45.989619]  dump_stack_lvl+0x78/0x90
[   45.989638]  dump_stack+0x18/0x24
[   45.989648]  rzg3s_pcie_root_map_bus+0x44/0x5c
[   45.989664]  pci_generic_config_read+0x24/0xd8
[   45.989680]  pci_user_read_config_byte+0x70/0xfc
[   45.989690]  pci_read_config+0xf8/0x24c
[   45.989703]  sysfs_kf_bin_read+0x7c/0xbc
[   45.989715]  kernfs_fop_read_iter+0xb0/0x1c4
[   45.989723]  vfs_read+0x214/0x2fc
[   45.989736]  __arm64_sys_pread64+0xa4/0xcc
[   45.989745]  invoke_syscall+0x48/0x10c
[   45.989758]  el0_svc_common.constprop.0+0xc0/0xe0
[   45.989768]  do_el0_svc+0x1c/0x28
[   45.989777]  el0_svc+0x34/0xf0
[   45.989787]  el0t_64_sync_handler+0xa0/0xe4
[   45.989795]  el0t_64_sync+0x198/0x19c
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~# setpci -s 00:00.0 0x1a.b=0x3
[   51.231700] CPU: 0 UID: 0 PID: 242 Comm: setpci Not tainted
6.18.0-rc1-00008-gcb1b33f1dd58 #39 PREEMPT
[   51.231736] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[   51.231743] Call trace:
[   51.231747]  show_stack+0x18/0x24 (C)
[   51.231770]  dump_stack_lvl+0x78/0x90
[   51.231789]  dump_stack+0x18/0x24
[   51.231799]  rzg3s_pcie_root_map_bus+0x44/0x5c
[   51.231815]  pci_generic_config_write+0x2c/0xf0
[   51.231832]  pci_user_write_config_byte+0x58/0xc8
[   51.231841]  pci_write_config+0x1ac/0x234
[   51.231854]  sysfs_kf_bin_write+0x90/0xb8
[   51.231866]  kernfs_fop_write_iter+0x128/0x1b8
[   51.231874]  vfs_write+0x2ac/0x350
[   51.231886]  __arm64_sys_pwrite64+0xa4/0xcc
[   51.231896]  invoke_syscall+0x48/0x10c
[   51.231909]  el0_svc_common.constprop.0+0xc0/0xe0
[   51.231919]  do_el0_svc+0x1c/0x28
[   51.231929]  el0_svc+0x34/0xf0
[   51.231939]  el0t_64_sync_handler+0xa0/0xe4
[   51.231947]  el0t_64_sync+0x198/0x19c
[   51.231957] pci_generic_config_write(): set 1a=3
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~# setpci -s 00:00.0 0x1a.b
03
[   81.058526] CPU: 0 UID: 0 PID: 243 Comm: setpci Not tainted
6.18.0-rc1-00008-gcb1b33f1dd58 #39 PREEMPT
[   81.058563] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[   81.058570] Call trace:
[   81.058574]  show_stack+0x18/0x24 (C)
[   81.058598]  dump_stack_lvl+0x78/0x90
[   81.058617]  dump_stack+0x18/0x24
[   81.058626]  rzg3s_pcie_root_map_bus+0x44/0x5c
[   81.058642]  pci_generic_config_read+0x24/0xd8
[   81.058658]  pci_user_read_config_byte+0x70/0xfc
[   81.058668]  pci_read_config+0xf8/0x24c
[   81.058680]  sysfs_kf_bin_read+0x7c/0xbc
[   81.058692]  kernfs_fop_read_iter+0xb0/0x1c4
[   81.058700]  vfs_read+0x214/0x2fc
[   81.058712]  __arm64_sys_pread64+0xa4/0xcc
[   81.058721]  invoke_syscall+0x48/0x10c
[   81.058735]  el0_svc_common.constprop.0+0xc0/0xe0
[   81.058745]  do_el0_svc+0x1c/0x28
[   81.058755]  el0_svc+0x34/0xf0
[   81.058764]  el0t_64_sync_handler+0xa0/0xe4
[   81.058771]  el0t_64_sync+0x198/0x19c
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~# echo mem > /sys/power/state
[   93.245556] PM: suspend entry (deep)
[   93.254834] Filesystems sync: 0.005 seconds
[   93.271372] Freezing user space processes
[   93.277350] Freezing user space processes completed (elapsed 0.005 seconds)
[   93.284385] OOM killer disabled.
[   93.287641] Freezing remaining freezable tasks
[   93.293449] Freezing remaining freezable tasks completed (elapsed 0.001
seconds)
[   93.338170] ravb 11c30000.ethernet end0: Link is Down
[   93.361712] CPU: 0 UID: 0 PID: 12 Comm: kworker/u4:0 Not tainted
6.18.0-rc1-00008-gcb1b33f1dd58 #39 PREEMPT
[   93.361748] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[   93.361755] Workqueue: async async_run_entry_fn
[   93.361787] Call trace:
[   93.361792]  show_stack+0x18/0x24 (C)
[   93.361807]  dump_stack_lvl+0x78/0x90
[   93.361826]  dump_stack+0x18/0x24
[   93.361836]  rzg3s_pcie_root_map_bus+0x44/0x5c
[   93.361851]  pci_generic_config_read+0x24/0xd8
[   93.361868]  pci_bus_read_config_dword+0x7c/0xdc
[   93.361877]  pci_read_config_dword+0x30/0x4c
[   93.361886]  pci_save_state+0x34/0x1b8
[   93.361897]  pci_pm_suspend_noirq+0x1f0/0x26c
[   93.361905]  device_suspend_noirq+0x74/0x248
[   93.361922]  async_suspend_noirq+0x24/0x3c
[   93.361931]  async_run_entry_fn+0x34/0xe0
[   93.361941]  process_one_work+0x150/0x294
[   93.361956]  worker_thread+0x2dc/0x3dc
[   93.361965]  kthread+0x130/0x1fc
[   93.361977]  ret_from_fork+0x10/0x20
[   93.450364] Disabling non-boot CPUs ...
NOTICE:  BL2: v2.7(release):2.7.0/g3s_1.0.0_rc4
NOTICE:  BL2: Built : 11:52:53, Feb 29 2024
NOTICE:  BL2: Booting BL31
[   93.462060] rzg3s_pcie_config_init(): primary=0, secondary=1, subordinate=3
[   93.559227] rzg3s-pcie-host 11e40000.pcie: PCIe link status [0x100014e]
[   93.758234] CPU: 0 UID: 0 PID: 76 Comm: kworker/u4:5 Not tainted
6.18.0-rc1-00008-gcb1b33f1dd58 #39 PREEMPT
[   93.758248] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[   93.758256] Workqueue: async async_run_entry_fn
[   93.758287] Call trace:
[   93.758292]  show_stack+0x18/0x24 (C)
[   93.758306]  dump_stack_lvl+0x78/0x90
[   93.758325]  dump_stack+0x18/0x24
[   93.758335]  rzg3s_pcie_root_map_bus+0x44/0x5c
[   93.758350]  pci_generic_config_read+0x24/0xd8
[   93.758366]  pci_bus_read_config_dword+0x7c/0xdc
[   93.758375]  pci_read_config_dword+0x30/0x4c
[   93.758384]  pci_restore_config_space_range+0x78/0x130
[   93.758394]  pci_restore_state.part.0+0x200/0x354
[   93.758403]  pci_restore_state+0x1c/0x28
[   93.758411]  pci_pm_resume_noirq+0x108/0x184
[   93.758420]  device_resume_noirq+0x128/0x244
[   93.758435]  async_resume_noirq+0x24/0x3c
[   93.758445]  async_run_entry_fn+0x34/0xe0
[   93.758454]  process_one_work+0x150/0x294
[   93.758469]  worker_thread+0x2dc/0x3dc
[   93.758479]  kthread+0x130/0x1fc
[   93.758490]  ret_from_fork+0x10/0x20
[   93.900233] nvme nvme0: 1/0/0 default/read/poll queues
[   93.929276] Microchip KSZ9131 Gigabit PHY 11c30000.ethernet-ffffffff:07:
attached PHY driver (mii_bus:phy_addr=11c30000.ethernet-ffffffff:07, irq=57)
[   94.013294] Microchip KSZ9131 Gigabit PHY 11c40000.ethernet-ffffffff:07:
attached PHY driver (mii_bus:phy_addr=11c40000.ethernet-ffffffff:07, irq=59)
[   94.060633] OOM killer enabled.
[   94.063832] Restarting tasks: Starting
[   94.074838] Restarting tasks: Done
[   94.082174] random: crng reseeded on system resumption
[   94.094271] PM: suspend exit
[   96.530340] ravb 11c30000.ethernet end0: Link is Up - 1Gbps/Full - flow
control off
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~# setpci -s 00:00.0 0x1a.b
03[  104.629484] CPU: 0 UID: 0 PID: 249 Comm: setpci Not tainted
6.18.0-rc1-00008-gcb1b33f1dd58 #39 PREEMPT
[  104.629521] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[  104.629529] Call trace:
[  104.629534]  show_stack+0x18/0x24 (C)
[  104.629557]  dump_stack_lvl+0x78/0x90
[  104.629576]  dump_stack+0x18/0x24
[  104.629586]  rzg3s_pcie_root_map_bus+0x44/0x5c
[  104.629602]  pci_generic_config_read+0x24/0xd8
[  104.629618]  pci_user_read_config_byte+0x70/0xfc
[  104.629627]  pci_read_config+0xf8/0x24c
[  104.629640]  sysfs_kf_bin_read+0x7c/0xbc
[  104.629652]  kernfs_fop_read_iter+0xb0/0x1c4
[  104.629660]  vfs_read+0x214/0x2fc
[  104.629673]  __arm64_sys_pread64+0xa4/0xcc
[  104.629683]  invoke_syscall+0x48/0x10c
[  104.629696]  el0_svc_common.constprop.0+0xc0/0xe0
[  104.629706]  do_el0_svc+0x1c/0x28
[  104.629716]  el0_svc+0x34/0xf0
[  104.629725]  el0t_64_sync_handler+0xa0/0xe4
[  104.629733]  el0t_64_sync+0x198/0x19c

root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~# setpci -s 00:00.0 0x1a.b
03
[  107.216490] CPU: 0 UID: 0 PID: 250 Comm: setpci Not tainted
6.18.0-rc1-00008-gcb1b33f1dd58 #39 PREEMPT
[  107.216527] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[  107.216534] Call trace:
[  107.216538]  show_stack+0x18/0x24 (C)
[  107.216562]  dump_stack_lvl+0x78/0x90
[  107.216581]  dump_stack+0x18/0x24
[  107.216591]  rzg3s_pcie_root_map_bus+0x44/0x5c
[  107.216607]  pci_generic_config_read+0x24/0xd8
[  107.216623]  pci_user_read_config_byte+0x70/0xfc
[  107.216633]  pci_read_config+0xf8/0x24c
[  107.216645]  sysfs_kf_bin_read+0x7c/0xbc
[  107.216658]  kernfs_fop_read_iter+0xb0/0x1c4
[  107.216666]  vfs_read+0x214/0x2fc
[  107.216679]  __arm64_sys_pread64+0xa4/0xcc
[  107.216688]  invoke_syscall+0x48/0x10c
[  107.216702]  el0_svc_common.constprop.0+0xc0/0xe0
[  107.216712]  do_el0_svc+0x1c/0x28
[  107.216721]  el0_svc+0x34/0xf0
[  107.216731]  el0t_64_sync_handler+0xa0/0xe4
[  107.216739]  el0t_64_sync+0x198/0x19c
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#


Could you please let me know if we should rely on pci_restore_state() to
restore this data or we should do it in driver?

> 
>>>> +static irqreturn_t rzg3s_pcie_msi_irq(int irq, void *data)
>>>> +{
>>>> +	u8 regs = RZG3S_PCI_MSI_INT_NR / RZG3S_PCI_MSI_INT_PER_REG;
>>>> +	DECLARE_BITMAP(bitmap, RZG3S_PCI_MSI_INT_NR);
>>>> +	struct rzg3s_pcie_host *host = data;
>>>> +	struct rzg3s_pcie_msi *msi = &host->msi;
>>>> +	unsigned long bit;
>>>> +	u32 status;
>>>> +
>>>> +	status = readl_relaxed(host->axi + RZG3S_PCI_PINTRCVIS);
>>>> +	if (!(status & RZG3S_PCI_PINTRCVIS_MSI))
>>>> +		return IRQ_NONE;
>>>> +
>>>> +	/* Clear the MSI */
>>>> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIS,
>>>> +			       RZG3S_PCI_PINTRCVIS_MSI,
>>>> +			       RZG3S_PCI_PINTRCVIS_MSI);
>>>
>>> Other writes to RZG3S_PCI_PINTRCVIS are guarded by host->hw_lock.  Is this
>>> one safe without it?
>>
>> It should be safe as RZG3S_PCI_PINTRCVIS is a R/W1C type of register.
>>
>> HW manual describes R/W1C registers for PCIe as "Write-1-to-clear status
>> . It can be cleared to 0b by writing 1b with a readable register.
>>  Writing 0b does not change anything."
>>
>> With this, it should be safe to drop the guard from rzg3s_pcie_intx_irq_ack().
>>
>>>
>>>> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSGRCVIS,
>>>> +			       RZG3S_PCI_MSGRCVIS_MRI, RZG3S_PCI_MSGRCVIS_MRI);
>>>> +
>>>> +	for (u8 reg_id = 0; reg_id < regs; reg_id++) {
>>>> +		status = readl_relaxed(host->axi + RZG3S_PCI_MSIRS(reg_id));
>>>> +		bitmap_write(bitmap, status, reg_id * RZG3S_PCI_MSI_INT_PER_REG,
>>>> +			     RZG3S_PCI_MSI_INT_PER_REG);
>>>> +	}
>>>> +
>>>> +	for_each_set_bit(bit, bitmap, RZG3S_PCI_MSI_INT_NR) {
>>>> +		int ret;
>>>> +
>>>> +		ret = generic_handle_domain_irq(msi->domain, bit);
>>>> +		if (ret) {
>>>> +			u8 reg_bit = bit % RZG3S_PCI_MSI_INT_PER_REG;
>>>> +			u8 reg_id = bit / RZG3S_PCI_MSI_INT_PER_REG;
>>>> +
>>>> +			/* Unknown MSI, just clear it */
>>>> +			writel_relaxed(BIT(reg_bit),
>>>> +				       host->axi + RZG3S_PCI_MSIRS(reg_id));
>>>
>>> Other writes to RZG3S_PCI_MSIRS are guarded by host->hw_lock.  Is this
>>> one safe without it?
>>
>> RZG3S_PCI_MSIRS is also a R/W1C type of register. With it, it should be
>> safe to drop the guard from rzg3s_pcie_msi_irq_ack() as well.
>>
>> I'm going to prepare a follow up patch to drop the guard on
>> rzg3s_pcie_intx_irq_ack() and rzg3s_pcie_msi_irq_ack(). Please let me know
>> if you have something against.
> 
> Sounds good.  Maybe add a comment at RZG3S_PCI_PINTRCVIS and
> RZG3S_PCI_MSIRS about them being R/W1C as a hint that they don't need
> locking.

Sure!

> 
>> I can also prepare a patch to detail in a comment the "enable access
>> control to the CFGU" operation in rzg3s_pcie_root_write(), if you prefer.
> 
> I think you should do the patch below.

Sure!

Thank you for your review,
Claudiu

> 
> And also investigate the question about resume and the bus numbers.
> If it is an issue, you'll have to figure out how to fix that.
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index 667e6d629474..547cbe676a25 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -439,28 +439,9 @@ static void __iomem *rzg3s_pcie_root_map_bus(struct pci_bus *bus,
>  	return host->pcie + where;
>  }
>  
> -/* Serialized by 'pci_lock' */
> -static int rzg3s_pcie_root_write(struct pci_bus *bus, unsigned int devfn,
> -				 int where, int size, u32 val)
> -{
> -	struct rzg3s_pcie_host *host = bus->sysdata;
> -	int ret;
> -
> -	/* Enable access control to the CFGU */
> -	writel_relaxed(RZG3S_PCI_PERM_CFG_HWINIT_EN,
> -		       host->axi + RZG3S_PCI_PERM);
> -
> -	ret = pci_generic_config_write(bus, devfn, where, size, val);
> -
> -	/* Disable access control to the CFGU */
> -	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
> -
> -	return ret;
> -}
> -
>  static struct pci_ops rzg3s_pcie_root_ops = {
>  	.read		= pci_generic_config_read,
> -	.write		= rzg3s_pcie_root_write,
> +	.write		= pci_generic_config_write,
>  	.map_bus	= rzg3s_pcie_root_map_bus,
>  };
>  
> @@ -1065,14 +1046,14 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
>  	writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00L);
>  	writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00U);
>  
> +	/* Disable access control to the CFGU */
> +	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
> +
>  	/* Update bus info */
>  	writeb_relaxed(primary_bus, host->pcie + PCI_PRIMARY_BUS);
>  	writeb_relaxed(secondary_bus, host->pcie + PCI_SECONDARY_BUS);
>  	writeb_relaxed(subordinate_bus, host->pcie + PCI_SUBORDINATE_BUS);
>  
> -	/* Disable access control to the CFGU */
> -	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
> -
>  	return 0;
>  }
>  


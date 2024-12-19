Return-Path: <linux-pci+bounces-18778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E6A9F7C85
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 14:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C729616E439
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922C21171C;
	Thu, 19 Dec 2024 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwK5QmIv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9368217836B
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734615355; cv=none; b=TQwgHu+3yq5OUFwTF8Yy8qmu7/UTB6Uq6bUrmmoWHwEm287o2QB3M6EEFiXmEgrEobE/at03yEFakxU4voo33Vvsczb9XgsAgKlZqrG6b9SgydzMVO3WDgNbjEudgzGlQjDfJKYYgdXOqTJwiUECxS6P4ysA2UWKfe3ftxy1tZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734615355; c=relaxed/simple;
	bh=EJgHbZol2Fl97rYUhwXmp3aksKOAB9rhyDkA4DmoCCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4mlhpTomv23XfGJntTOOk/F3lkx95mHwqdsMEaI1buJgVRVYNVIRPwpggcKgGfFi/8LeDXYioQqrQn6AM/mVRTelzy+lzGjrya1l675nmjuKOoqiahfvN46lvcBJxUQVM6Hwt8Q2W+YFVEwxYXIyJ4ZTw90/6wZPYd3qJNe/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AwK5QmIv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725f2f79ed9so633296b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 05:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734615353; x=1735220153; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4A1W3ID+NaKwiLdk4/Dnw0ZsVMCt2bOzxrQeop0Oycc=;
        b=AwK5QmIv9B49lktVJ22qjc+KiupM1WoAjJG9Xi46/mzCdYvYMhHphekA/7Sq67fuRc
         92MpfeloN1xuLXmfoq2pnHLyW/gW9jnLK+hdn++R7J7cLZDa5awJ4TeD14iX6DgE3lQ/
         UDtw8KikKpPJk1A5a5Yml7Xrn8Rhxbp+r5LqIXKGLnnx3WOSQNb8lFTdajIaNNXB5axK
         zi0Ol3fvzB1PglFYT0yOhY5zg1nYxOC/7wk+xXEiGd7jssehhXqSHh3GJfnmaj7WAGwc
         aqw3cjYpuYR+dNlRNCZ7NTMk2+5Z/vmSFzURnjjG+iiQC4CefNkGlramGbdnZXIJm31J
         lHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734615353; x=1735220153;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4A1W3ID+NaKwiLdk4/Dnw0ZsVMCt2bOzxrQeop0Oycc=;
        b=evtfhjsOEy7SdVEiGLIXhw6SOvo+pMxlMSrpSmZYH4WlE+FVuQU6+FgvSLJJKR7xNH
         Vr7Q2J/iZuzU76hiGVhGnqoarKEg0embxhrsx6pymyH5CrUwYVIoLNn4qff4eo43bL0h
         mRYN5K1kb/H4qH/F4qToPTOtX55RnjdgrRBSEaf/vfIPcUfqut3Hc2vdCUUUqRFeVx1D
         mAX1x860pkFvWWuPTEH4pDCXrosiA6Wxn5l5CMk1StJy+SdKjc9mBgTJbrfm47UomOj8
         90ovGrT9+jyxLo08T5cnTR4Z6gUZicXprlM7g33/n4DG/Cw8e2kWn9UC3ATqZnP5Cg7+
         jbQg==
X-Forwarded-Encrypted: i=1; AJvYcCUgwa/mRUHN4hgH/X5mOhHdk74wIApSl6XOB4SXhw5EcqjdZMHzJFg0PoKKgWG0gxmYT2kxii3j73s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVRZXX7j77OaUKtZaSsPzI5v5uMg/W9RO/hZVMhK0Nv1mGE7a
	ZFunQGMe15tghvdbitJB5TmDeUmrRVQwD5W91t9J4oCQwNRzrbuStydR9EfLMg==
X-Gm-Gg: ASbGnctJ/S0l14Y7IkF4gIk7m7Q6+MOU1FzJ1/wq3MPXi5hWXBRsHhXOBO4xz0rLn7N
	T7LGGKUS5N/2KpFTg2NaSysftUyw+Ye/XkCQeRXRRh9zXi7mR4WMUFJFSdJaL+JSgRK8bMtHWev
	Sz8S8N3jQ3q6IexDa7zkt+rhGIzGDDMN9FF7Uboes/lgbnlxzNSufoCXBQIdU2PWHNmf5coxAqu
	kT+kh7BnR109ef1aUORsaM9rLbeaN89LD3vmLmWJtD7qDTl8vSxbf5Jp5RhnmgRb5qN
X-Google-Smtp-Source: AGHT+IFa/i/DGcJFpN/yaIfd1fLRkNaaZk4W81+Id7pu3gvq+oO9R9TAsedVcZ5LU7FKYNsDS08BGg==
X-Received: by 2002:a05:6a00:398b:b0:727:3ac3:7f9c with SMTP id d2e1a72fcca58-72aa8d29dedmr5667070b3a.10.1734615352765;
        Thu, 19 Dec 2024 05:35:52 -0800 (PST)
Received: from thinkpad ([117.193.209.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad816166sm1276149b3a.13.2024.12.19.05.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 05:35:52 -0800 (PST)
Date: Thu, 19 Dec 2024 19:05:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [PATCH] PCI: cadence: Fixed cdns_pcie_host_link_setup return
 value.
Message-ID: <20241219133545.jiyqdzbkpwfu2rcv@thinkpad>
References: <20241219081452.32035-1-18255117159@163.com>
 <hldbrb5rgzwibq3xiak2qpy5jawsgmhwjxrhersjwfighljyim@noxzbf4cre3m>
 <999ad91d-9b61-b939-a043-4ab3f07c72a1@163.com>
 <v623jkaz4u4dpzlr5dtnjfolc5nk7az24aqhjth4lpjffen4ct@ypjekbr4o54q>
 <f2c8be62-7ff6-f0d0-f34a-ddb6915df0a4@163.com>
 <20241219094906.wzn7ripjxrvbmwbh@thinkpad>
 <c16dc225-4116-c966-7278-cc645f16c8a4@163.com>
 <20241219112051.pjr3a4evtftlpxau@thinkpad>
 <3bbb298a-6f84-6be7-69c6-eaeaa088cc0e@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bbb298a-6f84-6be7-69c6-eaeaa088cc0e@163.com>

On Thu, Dec 19, 2024 at 06:46:28AM -0500, Hans Zhang wrote:
> 
> 
> On 12/19/24 06:20, Manivannan Sadhasivam wrote:
> > On Thu, Dec 19, 2024 at 05:29:01AM -0500, Hans Zhang wrote:
> > > 
> > > 
> > > On 12/19/24 04:49, Manivannan Sadhasivam wrote:
> > > > On Thu, Dec 19, 2024 at 04:38:11AM -0500, Hans Zhang wrote:
> > > > > 
> > > > > On 12/19/24 03:59, Siddharth Vadapalli wrote:
> > > > > > On Thu, Dec 19, 2024 at 03:49:33AM -0500, Hans Zhang wrote:
> > > > > > > On 12/19/24 03:33, Siddharth Vadapalli wrote:
> > > > > > > > On Thu, Dec 19, 2024 at 03:14:52AM -0500, Hans Zhang wrote:
> > > > > > > > > If the PCIe link never came up, the enumeration process
> > > > > > > > > should not be run.
> > > > > > > > The link could come up at a later point in time. Please refer to the
> > > > > > > > implementation of:
> > > > > > > > dw_pcie_host_init() in drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > > wherein we have the following:
> > > > > > > > 	/* Ignore errors, the link may come up later */
> > > > > > > > 	dw_pcie_wait_for_link(pci);
> > > > > > > > 
> > > > > > > > It seems to me that the logic behind ignoring the absence of the link
> > > > > > > > within cdns_pcie_host_link_setup() instead of erroring out, is similar to
> > > > > > > > that of dw_pcie_wait_for_link().
> > > > > > > > 
> > > > > > > > Regards,
> > > > > > > > Siddharth.
> > > > > > > > 
> > > > > > > > 
> > > > > > > > If a PCIe port is not connected to a device. The PCIe link does not
> > > > > > > > go up. The current code returns success whether the device is connected
> > > > > > > > or not. Cadence IP's ECAM requires an LTSSM at L0 to access the RC's
> > > > > > > > config space registers. Otherwise the enumeration process will hang.
> > > > > > The ">" symbols seem to be manually added in your reply and are also
> > > > > > incorrect. If you have added them manually, please don't add them at the
> > > > > > start of the sentences corresponding to your reply.
> > > > > > 
> > > > > > The issue you are facing seems to be specific to the Cadence IP or the way
> > > > > > in which the IP has been integrated into the device that you are using.
> > > > > > On TI SoCs which have the Cadence PCIe Controller, absence of PCIe devices
> > > > > > doesn't result in a hang. Enumeration should proceed irrespective of the
> > > > > > presence of PCIe devices and should indicate their absence when they aren't
> > > > > > connected.
> > > > > > 
> > > > > > While I am not denying the issue being seen, the fix should probably be
> > > > > > done elsewhere.
> > > > > > 
> > > > > > Regards,
> > > > > > Siddharth.
> > > > > We are the SOC design company and we have confirmed with the designer and
> > > > > Cadence. For the Cadence's IP we are using, ECAM must be L0 at LTSSM to be
> > > > > used. Cadence will fixed next RTL version.
> > > > > 
> > > > 
> > > > I don't understand what you mean by 'ECAM must be L0 at LTSSM'. If you do not
> > > > connect the device, LTSSM would still be in 'detect' state until the device is
> > > > connected. Is that different on your SoC?
> > > > 
> > > > > If the cdns_pcie_host_link_setup return value is not modified. The following
> > > > > is the
> > > > > log of the enumeration process without connected devices. There will be hang
> > > > > for
> > > > > more than 300 seconds. So I don't think it makes sense to run the
> > > > > enumeration
> > > > > process without connecting devices. And it will affect the boot time.
> > > > > 
> > > > 
> > > > We don't know your driver, so cannot comment on the issue without understanding
> > > > the problem, sorry.
> > > > 
> > > > - Mani
> > > > 
> > > > > [ 2.681770] xxx pcie: xxx_pcie_probe starting!
> > > > > [ 2.689537] xxx pcie: host bridge /soc@0/pcie@xxx ranges:
> > > > > [ 2.698601] xxx pcie: IO 0x0060100000..0x00601fffff -> 0x0060100000
> > > > > [ 2.708625] xxx pcie: MEM 0x0060200000..0x007fffffff -> 0x0060200000
> > > > > [ 2.718649] xxx pcie: MEM 0x1800000000..0x1bffffffff -> 0x1800000000
> > > > > [ 2.744441] xxx pcie: ioremap rcsu, paddr:[mem 0x0a000000-0x0a00ffff],
> > > > > vaddr:ffff800089390000
> > > > > [ 2.756230] xxx pcie: ioremap msg, paddr:[mem 0x60000000-0x600fffff],
> > > > > vaddr:ffff800089800000
> > > > > [ 2.769692] xxx pcie: ECAM at [mem 0x2c000000-0x2fffffff] for [bus c0-ff]
> > > > > [ 2.780139] xxx.pcie_phy: pcie_phy_common_init end
> > > > > [ 2.788900] xxx pcie: waiting PHY is ready! retries = 2
> > > > > [ 3.905292] xxx pcie: Link fail, retries 10 times
> > > > > [ 3.915054] xxx pcie: ret=-110, rc->quirk_retrain_flag = 0
> > > > > [ 3.923848] xxx pcie: ret=-110, rc->quirk_retrain_flag = 0
> > > > > [ 3.932669] xxx pcie: PCI host bridge to bus 0000:c0
> > > > > [ 3.940847] pci_bus 0000:c0: root bus resource [bus c0-ff]
> > > > > [ 3.948322] pci_bus 0000:c0: root bus resource [io 0x0000-0xfffff] (bus
> > > > > address [0x60100000-0x601fffff])
> > > > > [ 3.959922] pci_bus 0000:c0: root bus resource [mem 0x60200000-0x7fffffff]
> > > > > [ 3.968799] pci_bus 0000:c0: root bus resource [mem
> > > > > 0x1800000000-0x1bffffffff pref]
> > > > > [ 339.667761] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > > [ 339.677449] rcu: 5-...0: (20 ticks this GP) idle=4d94/1/0x4000000000000000
> > > > > softirq=20/20 fqs=2623
> > > > > [ 339.688184] (detected by 2, t=5253 jiffies, g=-1119, q=2 ncpus=12)
> > > > > [ 339.696193] Sending NMI from CPU 2 to CPUs 5:
> > > > > [ 349.703670] rcu: rcu_preempt kthread timer wakeup didn't happen for 2509
> > > > > jiffies! g-1119 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
> > > > > [ 349.718710] rcu: Possible timer handling issue on cpu=2 timer-softirq=1208
> > > > > [ 349.727418] rcu: rcu_preempt kthread starved for 2515 jiffies! g-1119 f0x0
> > > > > RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=2
> > > > > [ 349.739642] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OOM
> > > > > is now expected behavior.
> > > > > [ 349.750546] rcu: RCU grace-period kthread stack dump:
> > > > > [ 349.757319] task:rcu_preempt state:I stack:0 pid:14 ppid:2
> > > > > flags:0x00000008
> > > > > [ 349.767439] Call trace:
> > > > > [ 349.771575] __switch_to+0xdc/0x150
> > > > > [ 349.776777] __schedule+0x2dc/0x7d0
> > > > > [ 349.781972] schedule+0x5c/0x100
> > > > > [ 349.786903] schedule_timeout+0x8c/0x100
> > > > > [ 349.792538] rcu_gp_fqs_loop+0x140/0x420
> > > > > [ 349.798176] rcu_gp_kthread+0x134/0x164
> > > > > [ 349.803725] kthread+0x108/0x10c
> > > > > [ 349.808657] ret_from_fork+0x10/0x20
> > > > > [ 349.813942] rcu: Stack dump where RCU GP kthread last ran:
> > > > > [ 349.821156] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G S xxx-build-generic
> > > > > #8
> > > > > [ 349.831887] Hardware name: xxx Reference Board, BIOS xxx
> > > > > [ 349.843583] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
> > > > > BTYPE=--)
> > > > > [ 349.852294] pc : arch_cpu_idle+0x18/0x2c
> > > > > [ 349.857928] lr : arch_cpu_idle+0x14/0x2c
> > > > > 
> > > > > Regards Hans
> > > > > 
> > > > 
> > > 
> > > I am very sorry that the previous email said that I included HTML format, so
> > > I resend it twice.
> > > 
> > > 
> > > > I don't understand what you mean by 'ECAM must be L0 at LTSSM'. If you do
> > > not
> > > > connect the device, LTSSM would still be in 'detect' state until the
> > > device is
> > > > connected. Is that different on your SoC?
> > > 
> > > If a PCIe port is not connected to a device. Then run pci_host_probe and
> > > perform the enumeration process. During the enumeration process, VID and PID
> > > are read. If the LTSSM is not in L0, the CPU send AXI transmission will not
> > > be sent, that is, the AXI slave will hang. This is the problem with the
> > > Cadence IP we are using.
> > > 
> > 
> > This sounds similar to the issues we have seen with other IP implementations:
> > 
> > 15b23906347c ("PCI: dwc: Add link up check in dw_child_pcie_ops.map_bus()")
> > 9e9ec8d8692a ("PCI: keystone: Add link up check to ks_pcie_other_map_bus()")
> > 
> > If the config space access happens for devices that do not exist on the bus,
> > then SError gets triggered and it causes the system hang.
> > 
> > In that case, you need to skip the enumeration in your own
> > 'struct pci_ops::map_bus' callback. Even though it is not the best solution, we
> > have to live with it.
> > 
> > - Mani
> > 
> 
> > In that case, you need to skip the enumeration in your own
> > 'struct pci_ops::map_bus' callback. Even though it is not the best
> solution, we
> > have to live with it.
> 
> I know how pcie-designware-host.c works, but accessing each config space
> register requires checking if it is a link up, which seems inefficient.

Yes.

> We have 5 PCIe controllers, and if a few of them are not connected to the
> device. And it will affect the boot time.
> 

Why are you enabling all controllers? Can't you just enable the ones you know
the endpoints are going to be connected? I'm just trying to see if we can avoid
having a quirk.

If you do not know, then you need to introduce a quirk for your platform.
But that requires your controller driver to be upstreamed. We cannot provide
hooks for downstream drivers in upstream.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


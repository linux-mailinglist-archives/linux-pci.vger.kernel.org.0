Return-Path: <linux-pci+bounces-18770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E2F9F7A42
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 12:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 026217A2C8D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 11:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FA122146C;
	Thu, 19 Dec 2024 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWdML/XI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0AB222D68
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734607261; cv=none; b=cAUW0FCbPD7Zd9G9OPjbgfOam6e0AKqW+8plvXdvRlRF3PyVdFmWgN4aGC48az3xvac1383m6hZzMGZoC+XXQaDD6IOsMTebfN5XBHfZUzS9ALJiegXnwy+5pwPtnNoXFtwXZVTGNe3TzDZDH8K2wvMYZCRbmrlZMmVzAM/E0uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734607261; c=relaxed/simple;
	bh=Y4YUnwbYPoC/ZEgbN1LhTEZdey9oPZZENp6kVKAi55w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwsJMMbAxF6XBWm5bSen+sWFCIruuthPOD0vsIzchx3nbnA7OK1t1dhzHdUyDxpoxCoFlJx5vvir6ZPI447MBL/Ui6f+TsWj3iaRuLtwmSJ0haq0sbew7O2e37TE1K6076+ZLE+UWERARVUrXRvir0+OQFmZjioOFWYmMRZrww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tWdML/XI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21644aca3a0so7214685ad.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 03:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734607259; x=1735212059; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Y96Y7hM8q1jRVTtGN6vH/IdWfoW5GlAsxSABLkaGak=;
        b=tWdML/XIJ9e5YLyDQA6iVbSXSeCkc7BDoQyJcE99MYDuLdwa97a0QOJeSRDON/9rCZ
         JIPJBtm98lryJp/aZWRL/wzXgv9QeRd0Wl0tLKfTho6lWLo12UCvPCm6FDdWnG5rmFnj
         F08Mhck4HpCjJsC7ktmlTm1bLI+JWLNsKrE6h/kJNHTS6u6sMW7evIYCxa74Kj7ZVHYd
         b87Fl1IawCMQ0HCI5zJKzD4PYBzPgzDTbMwiyYYSaq0vK36srCre6Aj2FUfYGgZImDKt
         7skv9OqPf+MZavdNNNRVaKde5vHfh7IK0cIlfRSpSpF0qcHvO9kbej8r6ySYVGCQKS6v
         xPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734607259; x=1735212059;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y96Y7hM8q1jRVTtGN6vH/IdWfoW5GlAsxSABLkaGak=;
        b=GTFI+ffNMoygWstIz7EIK+3w6M2wMtBS3bLSwO7d59zHDWmbQZSsk578jKii9lWej8
         4gwmHdcTf+RoKLOJuSBkSVESc5sZlkACMorle2MB03u5NQKned7dyKQMtlugeCImjThG
         iQs7UMUhiKZHoK45fpXZ3ZN0jhscQyqEtK3GucV4SF9yhuJ46C6tO5kC4BsHL5UgeVMv
         U8WNgKSxh8RqES/GEWtmhaY/UBbVJOMBo52z56lZRcPcryT9Ug/wG6Zzz34ngBticcd7
         8eo2XUrC56k8Q1kgAn7P2xzfST0CboX8WGWk962l8IpUnR9VAyKzhuUPO4sQJntMOTph
         j3zQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5QFJz9AujYJcZIud4Xe2Uptx/T2yWZTfaaw+w/rBrK4Ov9/+QnKZBfzNPRkbQM2Vns3QnLJBT6jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwGFYFWXfgd+UZMwwk/wHtRy3l8dEZQp2B3bu1Mrli0xJHzEHd
	Ey+/VT+BZRPoWZ7OancNDlZaM2ts2gtc5OaZ5h5vCXYitNhqnw9plS55z4ENhg==
X-Gm-Gg: ASbGncufOiBQPlVO5ibRH1dwa0SxCFBFdJk3H7aQFh0F//yLFldf8jxwHPl0csiE5ii
	/ypOcdZ7oXBuy2Ne0/u17Mre3NAXo0GdTRdWwa+54yPWjvm/bIB9CBeKcmcEYl5ZDYoRcPpbN/s
	vCJntou/lfnhqEZxtdLfUKfgSIYAjI6fY1YckkjBdpw0tbIzpKutCdDY6oXbegYwo7cWn9OF3qi
	ZXmaTJHZa0gvG/AWs040EL1hkPQlfesVsYFu8t0WIKxIfaZjyJVyYmHWAHKy6k0L+7G
X-Google-Smtp-Source: AGHT+IGG2MOVIAieERF14kMgmuA/3iGm4052q/qeZeKGHTKhwTI0OpwNYlNbvWNgNBPQfsQbDe7lPw==
X-Received: by 2002:a17:902:c943:b0:215:a57e:88e7 with SMTP id d9443c01a7336-219d965c7d2mr46322635ad.3.1734607258780;
        Thu, 19 Dec 2024 03:20:58 -0800 (PST)
Received: from thinkpad ([117.193.209.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9705ccsm10317045ad.92.2024.12.19.03.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 03:20:58 -0800 (PST)
Date: Thu, 19 Dec 2024 16:50:51 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [PATCH] PCI: cadence: Fixed cdns_pcie_host_link_setup return
 value.
Message-ID: <20241219112051.pjr3a4evtftlpxau@thinkpad>
References: <20241219081452.32035-1-18255117159@163.com>
 <hldbrb5rgzwibq3xiak2qpy5jawsgmhwjxrhersjwfighljyim@noxzbf4cre3m>
 <999ad91d-9b61-b939-a043-4ab3f07c72a1@163.com>
 <v623jkaz4u4dpzlr5dtnjfolc5nk7az24aqhjth4lpjffen4ct@ypjekbr4o54q>
 <f2c8be62-7ff6-f0d0-f34a-ddb6915df0a4@163.com>
 <20241219094906.wzn7ripjxrvbmwbh@thinkpad>
 <c16dc225-4116-c966-7278-cc645f16c8a4@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c16dc225-4116-c966-7278-cc645f16c8a4@163.com>

On Thu, Dec 19, 2024 at 05:29:01AM -0500, Hans Zhang wrote:
> 
> 
> On 12/19/24 04:49, Manivannan Sadhasivam wrote:
> > On Thu, Dec 19, 2024 at 04:38:11AM -0500, Hans Zhang wrote:
> > > 
> > > On 12/19/24 03:59, Siddharth Vadapalli wrote:
> > > > On Thu, Dec 19, 2024 at 03:49:33AM -0500, Hans Zhang wrote:
> > > > > On 12/19/24 03:33, Siddharth Vadapalli wrote:
> > > > > > On Thu, Dec 19, 2024 at 03:14:52AM -0500, Hans Zhang wrote:
> > > > > > > If the PCIe link never came up, the enumeration process
> > > > > > > should not be run.
> > > > > > The link could come up at a later point in time. Please refer to the
> > > > > > implementation of:
> > > > > > dw_pcie_host_init() in drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > wherein we have the following:
> > > > > > 	/* Ignore errors, the link may come up later */
> > > > > > 	dw_pcie_wait_for_link(pci);
> > > > > > 
> > > > > > It seems to me that the logic behind ignoring the absence of the link
> > > > > > within cdns_pcie_host_link_setup() instead of erroring out, is similar to
> > > > > > that of dw_pcie_wait_for_link().
> > > > > > 
> > > > > > Regards,
> > > > > > Siddharth.
> > > > > > 
> > > > > > 
> > > > > > If a PCIe port is not connected to a device. The PCIe link does not
> > > > > > go up. The current code returns success whether the device is connected
> > > > > > or not. Cadence IP's ECAM requires an LTSSM at L0 to access the RC's
> > > > > > config space registers. Otherwise the enumeration process will hang.
> > > > The ">" symbols seem to be manually added in your reply and are also
> > > > incorrect. If you have added them manually, please don't add them at the
> > > > start of the sentences corresponding to your reply.
> > > > 
> > > > The issue you are facing seems to be specific to the Cadence IP or the way
> > > > in which the IP has been integrated into the device that you are using.
> > > > On TI SoCs which have the Cadence PCIe Controller, absence of PCIe devices
> > > > doesn't result in a hang. Enumeration should proceed irrespective of the
> > > > presence of PCIe devices and should indicate their absence when they aren't
> > > > connected.
> > > > 
> > > > While I am not denying the issue being seen, the fix should probably be
> > > > done elsewhere.
> > > > 
> > > > Regards,
> > > > Siddharth.
> > > We are the SOC design company and we have confirmed with the designer and
> > > Cadence. For the Cadence's IP we are using, ECAM must be L0 at LTSSM to be
> > > used. Cadence will fixed next RTL version.
> > > 
> > 
> > I don't understand what you mean by 'ECAM must be L0 at LTSSM'. If you do not
> > connect the device, LTSSM would still be in 'detect' state until the device is
> > connected. Is that different on your SoC?
> > 
> > > If the cdns_pcie_host_link_setup return value is not modified. The following
> > > is the
> > > log of the enumeration process without connected devices. There will be hang
> > > for
> > > more than 300 seconds. So I don't think it makes sense to run the
> > > enumeration
> > > process without connecting devices. And it will affect the boot time.
> > > 
> > 
> > We don't know your driver, so cannot comment on the issue without understanding
> > the problem, sorry.
> > 
> > - Mani
> > 
> > > [ 2.681770] xxx pcie: xxx_pcie_probe starting!
> > > [ 2.689537] xxx pcie: host bridge /soc@0/pcie@xxx ranges:
> > > [ 2.698601] xxx pcie: IO 0x0060100000..0x00601fffff -> 0x0060100000
> > > [ 2.708625] xxx pcie: MEM 0x0060200000..0x007fffffff -> 0x0060200000
> > > [ 2.718649] xxx pcie: MEM 0x1800000000..0x1bffffffff -> 0x1800000000
> > > [ 2.744441] xxx pcie: ioremap rcsu, paddr:[mem 0x0a000000-0x0a00ffff],
> > > vaddr:ffff800089390000
> > > [ 2.756230] xxx pcie: ioremap msg, paddr:[mem 0x60000000-0x600fffff],
> > > vaddr:ffff800089800000
> > > [ 2.769692] xxx pcie: ECAM at [mem 0x2c000000-0x2fffffff] for [bus c0-ff]
> > > [ 2.780139] xxx.pcie_phy: pcie_phy_common_init end
> > > [ 2.788900] xxx pcie: waiting PHY is ready! retries = 2
> > > [ 3.905292] xxx pcie: Link fail, retries 10 times
> > > [ 3.915054] xxx pcie: ret=-110, rc->quirk_retrain_flag = 0
> > > [ 3.923848] xxx pcie: ret=-110, rc->quirk_retrain_flag = 0
> > > [ 3.932669] xxx pcie: PCI host bridge to bus 0000:c0
> > > [ 3.940847] pci_bus 0000:c0: root bus resource [bus c0-ff]
> > > [ 3.948322] pci_bus 0000:c0: root bus resource [io 0x0000-0xfffff] (bus
> > > address [0x60100000-0x601fffff])
> > > [ 3.959922] pci_bus 0000:c0: root bus resource [mem 0x60200000-0x7fffffff]
> > > [ 3.968799] pci_bus 0000:c0: root bus resource [mem
> > > 0x1800000000-0x1bffffffff pref]
> > > [ 339.667761] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > [ 339.677449] rcu: 5-...0: (20 ticks this GP) idle=4d94/1/0x4000000000000000
> > > softirq=20/20 fqs=2623
> > > [ 339.688184] (detected by 2, t=5253 jiffies, g=-1119, q=2 ncpus=12)
> > > [ 339.696193] Sending NMI from CPU 2 to CPUs 5:
> > > [ 349.703670] rcu: rcu_preempt kthread timer wakeup didn't happen for 2509
> > > jiffies! g-1119 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
> > > [ 349.718710] rcu: Possible timer handling issue on cpu=2 timer-softirq=1208
> > > [ 349.727418] rcu: rcu_preempt kthread starved for 2515 jiffies! g-1119 f0x0
> > > RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=2
> > > [ 349.739642] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OOM
> > > is now expected behavior.
> > > [ 349.750546] rcu: RCU grace-period kthread stack dump:
> > > [ 349.757319] task:rcu_preempt state:I stack:0 pid:14 ppid:2
> > > flags:0x00000008
> > > [ 349.767439] Call trace:
> > > [ 349.771575] __switch_to+0xdc/0x150
> > > [ 349.776777] __schedule+0x2dc/0x7d0
> > > [ 349.781972] schedule+0x5c/0x100
> > > [ 349.786903] schedule_timeout+0x8c/0x100
> > > [ 349.792538] rcu_gp_fqs_loop+0x140/0x420
> > > [ 349.798176] rcu_gp_kthread+0x134/0x164
> > > [ 349.803725] kthread+0x108/0x10c
> > > [ 349.808657] ret_from_fork+0x10/0x20
> > > [ 349.813942] rcu: Stack dump where RCU GP kthread last ran:
> > > [ 349.821156] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G S xxx-build-generic
> > > #8
> > > [ 349.831887] Hardware name: xxx Reference Board, BIOS xxx
> > > [ 349.843583] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
> > > BTYPE=--)
> > > [ 349.852294] pc : arch_cpu_idle+0x18/0x2c
> > > [ 349.857928] lr : arch_cpu_idle+0x14/0x2c
> > > 
> > > Regards Hans
> > > 
> > 
> 
> I am very sorry that the previous email said that I included HTML format, so
> I resend it twice.
> 
> 
> > I don't understand what you mean by 'ECAM must be L0 at LTSSM'. If you do
> not
> > connect the device, LTSSM would still be in 'detect' state until the
> device is
> > connected. Is that different on your SoC?
> 
> If a PCIe port is not connected to a device. Then run pci_host_probe and
> perform the enumeration process. During the enumeration process, VID and PID
> are read. If the LTSSM is not in L0, the CPU send AXI transmission will not
> be sent, that is, the AXI slave will hang. This is the problem with the
> Cadence IP we are using.
> 

This sounds similar to the issues we have seen with other IP implementations:

15b23906347c ("PCI: dwc: Add link up check in dw_child_pcie_ops.map_bus()")
9e9ec8d8692a ("PCI: keystone: Add link up check to ks_pcie_other_map_bus()")

If the config space access happens for devices that do not exist on the bus,
then SError gets triggered and it causes the system hang.

In that case, you need to skip the enumeration in your own
'struct pci_ops::map_bus' callback. Even though it is not the best solution, we
have to live with it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


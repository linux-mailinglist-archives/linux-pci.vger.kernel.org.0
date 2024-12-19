Return-Path: <linux-pci+bounces-18762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F98B9F78DC
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 10:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A782F167FB3
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DFE221D87;
	Thu, 19 Dec 2024 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xl6TG9Sq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00674221473
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601755; cv=none; b=u8TX59slcTD1K/yCrQGSCE+fjbEHCujLbeQ9Q+haTBsaq0O3O6TwOCmPQ4HeGxKo94XZ6sqhg3MB779dFzTrU6RbUdmjiF8LeiQQzz4U0Loclq+dTe0FrMrJJS5qKItMHagj2Vu41OYGkDXbHuczh5lBZiYsP/OrkJPUj9dS0jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601755; c=relaxed/simple;
	bh=9tg5mWWPjynnoxV66at9kPiiqoTOv9wGponRytSBrm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=su2BQ4fdenl3Q/QjgUuZHEeb6CXh1NTcNat+IKzfmn+AA3qRcdzU/oxVaPwHoK/McZeyIaTtIzGGXwfTfyKEqkXOkcx8aquYtjW0Oooy234L9PmrbuDTqVPATGWdrBnfTZdicLEaKOlCk74KRGu9LiaWpIT6VVsfkas6UiayDB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xl6TG9Sq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2163dc5155fso5051945ad.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 01:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734601753; x=1735206553; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0FtvdXUpMVhjICAM0j00pKXrMrS96VlwA6tiwK2/p5k=;
        b=Xl6TG9Sqe5kDTH1h6WP46237X+V6urQI8FMbyI5uRPludFy9woBQCryGKIifPjE+mi
         85afKbQQZ0NoTXeajtl9X2UytFjXOxsOQSeOGc6Mf5Nuewf2psCHU1ukXCKJxIXKdiZo
         oBb0zIDK9Iacd/Dv30Ilj9VOqJbSlLMr77dangrU+u7Q0HhgHwN4J//pcsPvoJLPvoYq
         B0Yywd6eluUOpl82iMAhYkwSeQrToX94CLuUF9T73ksxGt4cdiBY88nzIoGoNsariAPr
         TVv/3G7ggrBaAtxnHER3qbMeU2NIX61E41KNSI9hup8Z8/aLo5YfBMmLZ1OEnln31Vwk
         7yGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734601753; x=1735206553;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FtvdXUpMVhjICAM0j00pKXrMrS96VlwA6tiwK2/p5k=;
        b=sL3DEDqhXpWQkupNX3brT0o+hnekRcG6zYk117Y7vlQdpFtAhasoduql/Lw4nDgyon
         3vkfe7EemFmA5+ReiKs6hYlkfDmH58BbA6RzHaCu0ZZpTsm3IkCTqtOADmpUeZTRQrkD
         xyOhHHxVSyGZnPeogVnATCvLz/Kut4eQ/0bO4+ar8Jet+C3BsxSN/6Exn9ir4M/BWmy2
         4NubgLCefhBlvnW7EZS36iql/AjWWIvM1SRfZEubhQdQM4xgEaH63fdCOZ16C/ZlM7Et
         Jv7cHh97ze9gTHIPdUFM3jnVoMf0gyuGnX6R9dt1Km2Uz4IZ1eiXrhTJvmqrHeevZmt+
         Ci5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXERWqvdzQGSXqTJqDTOFJY5RoykTuSHkKtRJ3FfkH3ZyOCfzudxhBMetQY1gFJ3FTJEVuHCQ4fwkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM9frfBQCaM/EJVQF66QDDq0Mumk8keDY4rPy8pj3H98n39QUV
	fP3y0k911tXYV10IinBDi0S4K0c/u2DuS+cQrWparKEPOiQUGqXYeZU0wJB0rA==
X-Gm-Gg: ASbGncvmAco77Fs7e5MRiBu954qsvcUnygHKEFxbxtwGBonk8vF6Le8td8YZmMk9Kag
	a+C280Ad0EJUZ/pBE8IZ/VmzTAckJA1yTZNaBt4YZJbEFQiDCq8XcdepQ9VS1jNUcCeZZYiX9gi
	8EGd9EEJVD0hn+LIZc6Zk5jixXCgJ44PIKN0sXG4DYepUnPJy2Xvjjv9d2+Ux7OgxFdiS9W+QRX
	46mtJ3PEH/E6HwIqCtdvIsS5Ef2OOKNkz19Q7umTmr5jBkRpEYIRo5qolIduf8oTZQm
X-Google-Smtp-Source: AGHT+IGwF213fdw72Wq0u272LDm2c2s1QpwLrS7vLLdiwO99w7ek4nNKzWdJ2kT4smnMygCM/CwSxQ==
X-Received: by 2002:a17:902:cec4:b0:215:8847:435c with SMTP id d9443c01a7336-218d6fcbf66mr105682975ad.12.1734601753273;
        Thu, 19 Dec 2024 01:49:13 -0800 (PST)
Received: from thinkpad ([117.213.97.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96eae7sm8762855ad.85.2024.12.19.01.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 01:49:12 -0800 (PST)
Date: Thu, 19 Dec 2024 15:19:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [PATCH] PCI: cadence: Fixed cdns_pcie_host_link_setup return
 value.
Message-ID: <20241219094906.wzn7ripjxrvbmwbh@thinkpad>
References: <20241219081452.32035-1-18255117159@163.com>
 <hldbrb5rgzwibq3xiak2qpy5jawsgmhwjxrhersjwfighljyim@noxzbf4cre3m>
 <999ad91d-9b61-b939-a043-4ab3f07c72a1@163.com>
 <v623jkaz4u4dpzlr5dtnjfolc5nk7az24aqhjth4lpjffen4ct@ypjekbr4o54q>
 <f2c8be62-7ff6-f0d0-f34a-ddb6915df0a4@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2c8be62-7ff6-f0d0-f34a-ddb6915df0a4@163.com>

On Thu, Dec 19, 2024 at 04:38:11AM -0500, Hans Zhang wrote:
> 
> On 12/19/24 03:59, Siddharth Vadapalli wrote:
> > On Thu, Dec 19, 2024 at 03:49:33AM -0500, Hans Zhang wrote:
> > > On 12/19/24 03:33, Siddharth Vadapalli wrote:
> > > > On Thu, Dec 19, 2024 at 03:14:52AM -0500, Hans Zhang wrote:
> > > > > If the PCIe link never came up, the enumeration process
> > > > > should not be run.
> > > > The link could come up at a later point in time. Please refer to the
> > > > implementation of:
> > > > dw_pcie_host_init() in drivers/pci/controller/dwc/pcie-designware-host.c
> > > > wherein we have the following:
> > > > 	/* Ignore errors, the link may come up later */
> > > > 	dw_pcie_wait_for_link(pci);
> > > > 
> > > > It seems to me that the logic behind ignoring the absence of the link
> > > > within cdns_pcie_host_link_setup() instead of erroring out, is similar to
> > > > that of dw_pcie_wait_for_link().
> > > > 
> > > > Regards,
> > > > Siddharth.
> > > > 
> > > > 
> > > > If a PCIe port is not connected to a device. The PCIe link does not
> > > > go up. The current code returns success whether the device is connected
> > > > or not. Cadence IP's ECAM requires an LTSSM at L0 to access the RC's
> > > > config space registers. Otherwise the enumeration process will hang.
> > The ">" symbols seem to be manually added in your reply and are also
> > incorrect. If you have added them manually, please don't add them at the
> > start of the sentences corresponding to your reply.
> > 
> > The issue you are facing seems to be specific to the Cadence IP or the way
> > in which the IP has been integrated into the device that you are using.
> > On TI SoCs which have the Cadence PCIe Controller, absence of PCIe devices
> > doesn't result in a hang. Enumeration should proceed irrespective of the
> > presence of PCIe devices and should indicate their absence when they aren't
> > connected.
> > 
> > While I am not denying the issue being seen, the fix should probably be
> > done elsewhere.
> > 
> > Regards,
> > Siddharth.
> We are the SOC design company and we have confirmed with the designer and
> Cadence. For the Cadence's IP we are using, ECAM must be L0 at LTSSM to be
> used. Cadence will fixed next RTL version.
> 

I don't understand what you mean by 'ECAM must be L0 at LTSSM'. If you do not
connect the device, LTSSM would still be in 'detect' state until the device is
connected. Is that different on your SoC?

> If the cdns_pcie_host_link_setup return value is not modified. The following
> is the
> log of the enumeration process without connected devices. There will be hang
> for
> more than 300 seconds. So I don't think it makes sense to run the
> enumeration
> process without connecting devices. And it will affect the boot time.
> 

We don't know your driver, so cannot comment on the issue without understanding
the problem, sorry.

- Mani

> [ 2.681770] xxx pcie: xxx_pcie_probe starting!
> [ 2.689537] xxx pcie: host bridge /soc@0/pcie@xxx ranges:
> [ 2.698601] xxx pcie: IO 0x0060100000..0x00601fffff -> 0x0060100000
> [ 2.708625] xxx pcie: MEM 0x0060200000..0x007fffffff -> 0x0060200000
> [ 2.718649] xxx pcie: MEM 0x1800000000..0x1bffffffff -> 0x1800000000
> [ 2.744441] xxx pcie: ioremap rcsu, paddr:[mem 0x0a000000-0x0a00ffff],
> vaddr:ffff800089390000
> [ 2.756230] xxx pcie: ioremap msg, paddr:[mem 0x60000000-0x600fffff],
> vaddr:ffff800089800000
> [ 2.769692] xxx pcie: ECAM at [mem 0x2c000000-0x2fffffff] for [bus c0-ff]
> [ 2.780139] xxx.pcie_phy: pcie_phy_common_init end
> [ 2.788900] xxx pcie: waiting PHY is ready! retries = 2
> [ 3.905292] xxx pcie: Link fail, retries 10 times
> [ 3.915054] xxx pcie: ret=-110, rc->quirk_retrain_flag = 0
> [ 3.923848] xxx pcie: ret=-110, rc->quirk_retrain_flag = 0
> [ 3.932669] xxx pcie: PCI host bridge to bus 0000:c0
> [ 3.940847] pci_bus 0000:c0: root bus resource [bus c0-ff]
> [ 3.948322] pci_bus 0000:c0: root bus resource [io 0x0000-0xfffff] (bus
> address [0x60100000-0x601fffff])
> [ 3.959922] pci_bus 0000:c0: root bus resource [mem 0x60200000-0x7fffffff]
> [ 3.968799] pci_bus 0000:c0: root bus resource [mem
> 0x1800000000-0x1bffffffff pref]
> [ 339.667761] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [ 339.677449] rcu: 5-...0: (20 ticks this GP) idle=4d94/1/0x4000000000000000
> softirq=20/20 fqs=2623
> [ 339.688184] (detected by 2, t=5253 jiffies, g=-1119, q=2 ncpus=12)
> [ 339.696193] Sending NMI from CPU 2 to CPUs 5:
> [ 349.703670] rcu: rcu_preempt kthread timer wakeup didn't happen for 2509
> jiffies! g-1119 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
> [ 349.718710] rcu: Possible timer handling issue on cpu=2 timer-softirq=1208
> [ 349.727418] rcu: rcu_preempt kthread starved for 2515 jiffies! g-1119 f0x0
> RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=2
> [ 349.739642] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OOM
> is now expected behavior.
> [ 349.750546] rcu: RCU grace-period kthread stack dump:
> [ 349.757319] task:rcu_preempt state:I stack:0 pid:14 ppid:2
> flags:0x00000008
> [ 349.767439] Call trace:
> [ 349.771575] __switch_to+0xdc/0x150
> [ 349.776777] __schedule+0x2dc/0x7d0
> [ 349.781972] schedule+0x5c/0x100
> [ 349.786903] schedule_timeout+0x8c/0x100
> [ 349.792538] rcu_gp_fqs_loop+0x140/0x420
> [ 349.798176] rcu_gp_kthread+0x134/0x164
> [ 349.803725] kthread+0x108/0x10c
> [ 349.808657] ret_from_fork+0x10/0x20
> [ 349.813942] rcu: Stack dump where RCU GP kthread last ran:
> [ 349.821156] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G S xxx-build-generic
> #8
> [ 349.831887] Hardware name: xxx Reference Board, BIOS xxx
> [ 349.843583] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [ 349.852294] pc : arch_cpu_idle+0x18/0x2c
> [ 349.857928] lr : arch_cpu_idle+0x14/0x2c
> 
> Regards Hans
> 

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-11312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B03E947E3E
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 17:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44F41C22247
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B269515B54B;
	Mon,  5 Aug 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gbcljqG+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B20315A4AF
	for <linux-pci@vger.kernel.org>; Mon,  5 Aug 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872155; cv=none; b=Nr4jcLF6EZ09CF87xAt2mvWIoSDco9nwv60xTnt9vnBys+jMkP2a0FFMmP6XOPFv0Eu6F2rfdbNgVMdUcakAJbb1s1TWZ5KESRdCa4e9vGq0n2p4Y3TdrCYuvEukB/ccxQ0w6Gb5EcCkzXLQnO4xmDfvXpJ2+66IIu+wbU/whB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872155; c=relaxed/simple;
	bh=v2ERA9o7/xVC+jk2zxDSTBfNpKA5+JJHS1aHhP5v/sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kwdfpn1uvdMa74wi+64fdmcjylUlJsuuNQMP5f1xOOIQmribxFqGSC9WlvBpcZkrnAqSGMPuJXU3FEuBZUPELS3S6GbZ8Eao4z/CPMeRpW+Zi0Qr7xNwLNrr9m6AkEyNZT9YS8IfT1hl5S0xbl5mDaiYW1i2aonx1v4/5bdqRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gbcljqG+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70eb73a9f14so8028389b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Aug 2024 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722872153; x=1723476953; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kaNxJBlznx6y0vjgoBqt7rcaY0nzk8O5nbByfKyVdkM=;
        b=gbcljqG+NpDriZ2wzLDdZYfIEhBjzUYwJJA328LRp3T2z+iTq8Iopvkd0vNy6JO8Pz
         YtGuQzgBNQa6oTBrkt+zv+p6bALdttEp7l2ViQmQ+cVNC4TyT4bwrMHphn+UVka6BHg0
         Q5Zpe3IrWZmT0Xrhzm4DsCA5NrVDWyi3tK1zay97gLUBBTdTi1udpXDgCMBBMDTc4QGp
         u8lRVdvrd8eeKQnLdsmIWVdBu0UqONNipMRiXguERSiY2fJQ9U+/VRowTAkvkA3ZpomX
         yA3DD65e7H2VfuqHf1KRtNtiWtk//GyQeblOvXdpADkU1OHvbYgyH0g233h6BAlc7L18
         cD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722872153; x=1723476953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kaNxJBlznx6y0vjgoBqt7rcaY0nzk8O5nbByfKyVdkM=;
        b=l9He7Simn9fFKoriJGm80K6IWs7g/HjvQ2FJzNW0gY3IZGCjk4uD340cr1pRJZ4WZX
         fjovIdBueIpbq3QYiQZRS62zqAwp6fcediJY/J4APZIJwKKQo1yWrj6Xabtj0turw/FC
         jUCVNvKy8x+lbr5zjYT6Co6I+kKMuQJCNvI4y+a/QlrNaWiCRNqKKoWyuwgvXszU0bGa
         +Q0tgaFY2MX5wbR+1KzADLSz1nfeTWo9LeuVumsOTgzkdeYMFV9Eqj1lk/HldpgI6Pu5
         qPmw73zhXaVsyVR9+RvlEbx8xx85n0TRYZgvckqF4F0Lr/5/akrpfUSCxC5xNB3jo39O
         Yh3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuxX89/iK47ralLni8PBsPmTSkTaOm7U3QAMo+IcMz5wDHOLBhIHVNOuu8MbS4e8Lxlfe1PRyYoHrFRS6ygMMrqRAbW47dtZbs
X-Gm-Message-State: AOJu0YyNiGaTFWxNkGP3j6qYG34Rnv1ufFpKI0hctdT8e8RTX92J5vP+
	fo74EHmcd2jTeHhuuT0Mu4t0R0yRiyFAC36dpHZJisoSh25nOAza0LaLBpya1w==
X-Google-Smtp-Source: AGHT+IF/U0Q1PobUn7t5WL8VXgXR+W38KeWOWYVnqFO/t8f7Bw/Vwj5BN+d89aomfHaopFlJNaJ26g==
X-Received: by 2002:a05:6a00:21cf:b0:70d:281d:ee8c with SMTP id d2e1a72fcca58-7106cfdca5dmr14410623b3a.18.1722872153206;
        Mon, 05 Aug 2024 08:35:53 -0700 (PDT)
Received: from thinkpad ([120.56.197.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfc344sm5543790b3a.151.2024.08.05.08.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:35:52 -0700 (PDT)
Date: Mon, 5 Aug 2024 21:05:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v4 3/4] PCI: Decouple D3Hot and D3Cold handling for
 bridges
Message-ID: <20240805153546.GE7274@thinkpad>
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
 <20240326-pci-bridge-d3-v4-3-f1dce1d1f648@linaro.org>
 <CAJMQK-hu+FrVtYaUiwfp=uuYLT_xBRcHb0JOfMBz5TYaktV6Ow@mail.gmail.com>
 <20240802053302.GB4206@thinkpad>
 <CAJMQK-gtPo4CVEXFDfRU9o+UXgZrsxZvroVsGorvLAdkzfjYmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJMQK-gtPo4CVEXFDfRU9o+UXgZrsxZvroVsGorvLAdkzfjYmg@mail.gmail.com>

On Fri, Aug 02, 2024 at 12:53:42PM -0700, Hsin-Yi Wang wrote:

[...]

> > > [   42.202016] mt7921e 0000:01:00.0: PM: calling
> > > pci_pm_suspend_noirq+0x0/0x300 @ 77, parent: 0000:00:00.0
> > > [   42.231681] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D3hot
> >
> > Here I can see that the port entered D3hot
> >
> This one is the wifi device connected to the port.
> 

Ah, okay. You could've just shared the logs for the bridge/rootport.

> > > [   42.238048] mt7921e 0000:01:00.0: PM:
> > > pci_pm_suspend_noirq+0x0/0x300 returned 0 after 26583 usecs
> > > [   42.247083] pcieport 0000:00:00.0: PM: calling
> > > pci_pm_suspend_noirq+0x0/0x300 @ 3196, parent: pci0000:00
> > > [   42.296325] pcieport 0000:00:00.0: PCI PM: Suspend power state: D0
> >
> This is the port suspended with D0. If we hack power_manageable to
> only consider D3hot, the state here for pcieport will become D3hot
> (compared in below).
> 
> If it's D0 (and s2idle), in resume it won't restore config:
> https://elixir.bootlin.com/linux/v6.10/source/drivers/pci/pci-driver.c#L959,
> and in resume it would be an issue.
> 
> Comparison:
> 1. pcieport can go to D3:
> (suspend)
> [   61.645809] mt7921e 0000:01:00.0: PM: calling
> pci_pm_suspend_noirq+0x0/0x2f8 @ 1139, parent: 0000:00:00.0
> [   61.675562] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D3hot
> [   61.681931] mt7921e 0000:01:00.0: PM:
> pci_pm_suspend_noirq+0x0/0x2f8 returned 0 after 26502 usecs
> [   61.690959] pcieport 0000:00:00.0: PM: calling
> pci_pm_suspend_noirq+0x0/0x2f8 @ 3248, parent: pci0000:00
> [   61.755359] pcieport 0000:00:00.0: PCI PM: Suspend power state: D3hot
> [   61.761832] pcieport 0000:00:00.0: PM:
> pci_pm_suspend_noirq+0x0/0x2f8 returned 0 after 61345 usecs
> 

Why the device state is not saved? Did you skip those logs?

> (resume)
> [   65.243981] pcieport 0000:00:00.0: PM: calling
> pci_pm_resume_noirq+0x0/0x190 @ 3258, parent: pci0000:00
> [   65.253122] mtk-pcie-phy 16930000.phy: CKM_38=0x13040500,
> GLB_20=0x0, GLB_30=0x0, GLB_38=0x30453fc, GLB_F4=0x1453b000
> [   65.262725] pcieport 0000:00:00.0: PM:
> pci_pm_resume_noirq+0x0/0x190 returned 0 after 175 usecs
> [   65.273159] mtk-pcie-phy 16930000.phy: No calibration info
> [   65.281903] mt7921e 0000:01:00.0: PM: calling
> pci_pm_resume_noirq+0x0/0x190 @ 3259, parent: 0000:00:00.0
> [   65.297108] mt7921e 0000:01:00.0: PM: pci_pm_resume_noirq+0x0/0x190
> returned 0 after 329 usecs
> 
> 
> 2. pcieport stays at D0 due to power_manageable returns false:
> (suspend)
> [   52.435375] mt7921e 0000:01:00.0: PM: calling
> pci_pm_suspend_noirq+0x0/0x300 @ 2040, parent: 0000:00:00.0
> [   52.465235] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D3hot
> [   52.471610] mt7921e 0000:01:00.0: PM:
> pci_pm_suspend_noirq+0x0/0x300 returned 0 after 26602 usecs
> [   52.480674] pcieport 0000:00:00.0: PM: calling
> pci_pm_suspend_noirq+0x0/0x300 @ 143, parent: pci0000:00
> [   52.529876] pcieport 0000:00:00.0: PCI PM: Suspend power state: D0
>                 <-- port is still D0
> [   52.536056] pcieport 0000:00:00.0: PCI PM: Skipped
> 
> (resume)
> [   56.026298] pcieport 0000:00:00.0: PM: calling
> pci_pm_resume_noirq+0x0/0x190 @ 3243, parent: pci0000:00
> [   56.035379] mtk-pcie-phy 16930000.phy: CKM_38=0x13040500,
> GLB_20=0x0, GLB_30=0x0, GLB_38=0x30453fc, GLB_F4=0x1453b000
> [   56.044776] pcieport 0000:00:00.0: PM:
> pci_pm_resume_noirq+0x0/0x190 returned 0 after 13 usecs
> [   56.055409] mtk-pcie-phy 16930000.phy: No calibration info
> [   56.064098] mt7921e 0000:01:00.0: PM: calling
> pci_pm_resume_noirq+0x0/0x190 @ 3244, parent: 0000:00:00.0
> [   56.078962] mt7921e 0000:01:00.0: Unable to change power state from
> D3hot to D0, device inaccessible                    <-- resume failed.

This means the port entered D3Cold? This is not expected during s2idle. During
s2idle, devices should be put into low power state and their power should be
preserved.

Who is pulling the plug here?

- Mani

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-11361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D61F949412
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 17:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2583E283B26
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 15:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DB81D6187;
	Tue,  6 Aug 2024 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zrn5f2Bz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE751D6DDB
	for <linux-pci@vger.kernel.org>; Tue,  6 Aug 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956585; cv=none; b=T4FjNWmBOVqzS+6fXRtfnBpo+dh7RWNBoB3qh+ioYVgi3NeVWGC9GCi4UQ1Bdu03fK9DDpZ6Stz71h4xlLAyCOOWYCTsir5kcbLQVrvmPygaM8yIuD6vIM0TuPel0UVoghXh65qLC8YpmaMCp85vLCTRoltaJ95Tu0nMA0DlHAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956585; c=relaxed/simple;
	bh=hi1d1FrOXe1s5CGXLKeX6x1Os0CuClV5+SN3CwIjJAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIOBmro1zn9lscutBckh33AhT9NtQpCOFUzAl8Ahfbbtb1qsTLWYjK3tMxTszZu3fVKn+/k1dhDFwHhjgGcT5htIEQ+pvs9perNYHmgoJMBkc4Zr870Z6FusSn3KdSZDIJzsPPPR4td49/qt5/se0DNoKWdz+Sht2xCwG5EZYFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zrn5f2Bz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc5549788eso6224715ad.1
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2024 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722956583; x=1723561383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y7NaWm6vnq2HlhTf5mfcpx802WStr4xy01hADRwRY50=;
        b=Zrn5f2BzUHAIEXN/9COblY/VVQPUryaQCNotXjeli9CbA3lLDk+BAKiUop5lvDRHlc
         QJVjYTKcI3v+GSw2bw+b6dEylcAYNgK1Jf8HMmCFBrmE1iymEJlsxd9FqxpdzjRTpoDX
         65I/ByIRqOlyj9dxFM0TR8Ai2RdlKPygBxvBpNCpU90B0HAObtyu+5p5Phxnzp368MvE
         JvQpo5leMw+EOziZa5YEVpKCTymV339ajbUArRxl6+w5/gyF3WtAbav2Z9ewwkPWU9G6
         vXkjWJXq0cEQULV7TLIRNtp9Q6hzNNmc+KAZncl6ouJu8oDqDBElxM24fp4wys/HNL6n
         0pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722956583; x=1723561383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7NaWm6vnq2HlhTf5mfcpx802WStr4xy01hADRwRY50=;
        b=HBM7E6btg7SoGCaA1yyInEan0nV7XQTvd7kHaE/npZa9qhi7eCG5KCsAozgmjyueAU
         3RvY3otI7CmGnB92LsdDHEKMdusA8RAgCzkQVl4ZetYZrLQnX6LP2UNnzbHxQ5Z3ew8M
         QOAeo1qZqjScpldNHV7ErftZgTgtqCcKmMFvPp14ekkyT9lEj1lf8SlENZKE2ACrJHLu
         l2wL3TsDkEYf6dlL6FIyJhnvyFsrKKMwb2l8JpNTfx2zCAHXDaNNFLvRibQ7jAeVVWaL
         vCkykDubHI7lnCEQf13rSedqAi04VoPSSI3U+EqMGIthNmVvZbG7tuiWDQsuu2g+VxNt
         x/8w==
X-Forwarded-Encrypted: i=1; AJvYcCUf40aqwtgU7xoxGkeljsUHP2e0/rI/ApmMbuOWR6lZ3XZDYHWjediwGif7wx6Xh1NtqG2nCoHSPvYD5jqdresEw4aYpKaLJPMt
X-Gm-Message-State: AOJu0Ywc3QpX8oLYQALs+9fd8TOt6gapkPmZ3jxu+TveEUtT0+Vy37A4
	hG70HxyKaes2m9N3c1vlkSQtYhH66tbJLr6VGfG0BC2DwsTlC8KasCiLrOnYkA==
X-Google-Smtp-Source: AGHT+IH54jCOac8mAvYH1LhpjUvHCkbyx7DUSwysvPCFc4w9vTAJArOtaYxJNGZ5R6LaaasZnty6uA==
X-Received: by 2002:a17:902:e885:b0:1fc:369b:c1d1 with SMTP id d9443c01a7336-1ff57250f57mr223376635ad.3.1722956582805;
        Tue, 06 Aug 2024 08:03:02 -0700 (PDT)
Received: from thinkpad ([120.60.72.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59058d7dsm88396175ad.142.2024.08.06.08.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:03:02 -0700 (PDT)
Date: Tue, 6 Aug 2024 20:32:50 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v4 3/4] PCI: Decouple D3Hot and D3Cold handling for
 bridges
Message-ID: <20240806150250.GD2968@thinkpad>
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
 <20240326-pci-bridge-d3-v4-3-f1dce1d1f648@linaro.org>
 <CAJMQK-hu+FrVtYaUiwfp=uuYLT_xBRcHb0JOfMBz5TYaktV6Ow@mail.gmail.com>
 <20240802053302.GB4206@thinkpad>
 <CAJMQK-gtPo4CVEXFDfRU9o+UXgZrsxZvroVsGorvLAdkzfjYmg@mail.gmail.com>
 <20240805153546.GE7274@thinkpad>
 <CAJMQK-iZ6s0UmsT91TCRe6E9RMZ-3BndDFtXqCUxdWGcyxPSTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJMQK-iZ6s0UmsT91TCRe6E9RMZ-3BndDFtXqCUxdWGcyxPSTA@mail.gmail.com>

On Mon, Aug 05, 2024 at 12:17:13PM -0700, Hsin-Yi Wang wrote:
> On Mon, Aug 5, 2024 at 8:35 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Fri, Aug 02, 2024 at 12:53:42PM -0700, Hsin-Yi Wang wrote:
> >
> > [...]
> >
> > > > > [   42.202016] mt7921e 0000:01:00.0: PM: calling
> > > > > pci_pm_suspend_noirq+0x0/0x300 @ 77, parent: 0000:00:00.0
> > > > > [   42.231681] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D3hot
> > > >
> > > > Here I can see that the port entered D3hot
> > > >
> > > This one is the wifi device connected to the port.
> > >
> >
> > Ah, okay. You could've just shared the logs for the bridge/rootport.
> >
> > > > > [   42.238048] mt7921e 0000:01:00.0: PM:
> > > > > pci_pm_suspend_noirq+0x0/0x300 returned 0 after 26583 usecs
> > > > > [   42.247083] pcieport 0000:00:00.0: PM: calling
> > > > > pci_pm_suspend_noirq+0x0/0x300 @ 3196, parent: pci0000:00
> > > > > [   42.296325] pcieport 0000:00:00.0: PCI PM: Suspend power state: D0
> > > >
> > > This is the port suspended with D0. If we hack power_manageable to
> > > only consider D3hot, the state here for pcieport will become D3hot
> > > (compared in below).
> > >
> > > If it's D0 (and s2idle), in resume it won't restore config:
> > > https://elixir.bootlin.com/linux/v6.10/source/drivers/pci/pci-driver.c#L959,
> > > and in resume it would be an issue.
> > >
> > > Comparison:
> > > 1. pcieport can go to D3:
> > > (suspend)
> > > [   61.645809] mt7921e 0000:01:00.0: PM: calling
> > > pci_pm_suspend_noirq+0x0/0x2f8 @ 1139, parent: 0000:00:00.0
> > > [   61.675562] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D3hot
> > > [   61.681931] mt7921e 0000:01:00.0: PM:
> > > pci_pm_suspend_noirq+0x0/0x2f8 returned 0 after 26502 usecs
> > > [   61.690959] pcieport 0000:00:00.0: PM: calling
> > > pci_pm_suspend_noirq+0x0/0x2f8 @ 3248, parent: pci0000:00
> > > [   61.755359] pcieport 0000:00:00.0: PCI PM: Suspend power state: D3hot
> > > [   61.761832] pcieport 0000:00:00.0: PM:
> > > pci_pm_suspend_noirq+0x0/0x2f8 returned 0 after 61345 usecs
> > >
> >
> > Why the device state is not saved? Did you skip those logs?
> >
> Right, I only showed the power state of pcieport and the device here
> to show the difference of 1 and 2.
> 
> > > (resume)
> > > [   65.243981] pcieport 0000:00:00.0: PM: calling
> > > pci_pm_resume_noirq+0x0/0x190 @ 3258, parent: pci0000:00
> > > [   65.253122] mtk-pcie-phy 16930000.phy: CKM_38=0x13040500,
> > > GLB_20=0x0, GLB_30=0x0, GLB_38=0x30453fc, GLB_F4=0x1453b000
> > > [   65.262725] pcieport 0000:00:00.0: PM:
> > > pci_pm_resume_noirq+0x0/0x190 returned 0 after 175 usecs
> > > [   65.273159] mtk-pcie-phy 16930000.phy: No calibration info
> > > [   65.281903] mt7921e 0000:01:00.0: PM: calling
> > > pci_pm_resume_noirq+0x0/0x190 @ 3259, parent: 0000:00:00.0
> > > [   65.297108] mt7921e 0000:01:00.0: PM: pci_pm_resume_noirq+0x0/0x190
> > > returned 0 after 329 usecs
> > >
> > >
> > > 2. pcieport stays at D0 due to power_manageable returns false:
> > > (suspend)
> > > [   52.435375] mt7921e 0000:01:00.0: PM: calling
> > > pci_pm_suspend_noirq+0x0/0x300 @ 2040, parent: 0000:00:00.0
> > > [   52.465235] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D3hot
> > > [   52.471610] mt7921e 0000:01:00.0: PM:
> > > pci_pm_suspend_noirq+0x0/0x300 returned 0 after 26602 usecs
> > > [   52.480674] pcieport 0000:00:00.0: PM: calling
> > > pci_pm_suspend_noirq+0x0/0x300 @ 143, parent: pci0000:00
> > > [   52.529876] pcieport 0000:00:00.0: PCI PM: Suspend power state: D0
> > >                 <-- port is still D0
> > > [   52.536056] pcieport 0000:00:00.0: PCI PM: Skipped
> > >
> > > (resume)
> > > [   56.026298] pcieport 0000:00:00.0: PM: calling
> > > pci_pm_resume_noirq+0x0/0x190 @ 3243, parent: pci0000:00
> > > [   56.035379] mtk-pcie-phy 16930000.phy: CKM_38=0x13040500,
> > > GLB_20=0x0, GLB_30=0x0, GLB_38=0x30453fc, GLB_F4=0x1453b000
> > > [   56.044776] pcieport 0000:00:00.0: PM:
> > > pci_pm_resume_noirq+0x0/0x190 returned 0 after 13 usecs
> > > [   56.055409] mtk-pcie-phy 16930000.phy: No calibration info
> > > [   56.064098] mt7921e 0000:01:00.0: PM: calling
> > > pci_pm_resume_noirq+0x0/0x190 @ 3244, parent: 0000:00:00.0
> > > [   56.078962] mt7921e 0000:01:00.0: Unable to change power state from
> > > D3hot to D0, device inaccessible                    <-- resume failed.
> >
> > This means the port entered D3Cold? This is not expected during s2idle. During
> > s2idle, devices should be put into low power state and their power should be
> > preserved.
> >
> > Who is pulling the plug here?
> 
> In our system's use case, after the kernel enters s2idle then ATF (arm
> trusted firmware) will turn off the power (similar to suspend to ram).
> 

This is not acceptable IMO. S2IDLE != S2RAM. Even if you fix the portdrv, rest
of the PCIe client drivers may fail (hint: have you checked the NVMe driver)?

- Mani

-- 
மணிவண்ணன் சதாசிவம்


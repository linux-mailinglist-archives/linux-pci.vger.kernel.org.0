Return-Path: <linux-pci+bounces-3602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E82857FCE
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 15:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB651C21F24
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF4712F363;
	Fri, 16 Feb 2024 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ianPdFhS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7A12EBF4
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095265; cv=none; b=AYmfq5o/RQ4Y2xso0N1plnGFV0Xxhm4cj1ECr/Oi1C7fmKrxHbBZesuzmgilMWncfyPffSboERlrN1yDifexSdGCuCDi/4ufC3Yaa4t/c0tkMgg/NlBDaU+Me24ITaM5S09Bky2bB2W5QZprBPrO+gzqbMNlkuYIiWinWtqO0RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095265; c=relaxed/simple;
	bh=+C8SQjHKPXwZr8+yfS37nIG2SloOZQAZQRlLo8MFMyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8njCfR/v0LrSrZEceOANyvKLaard1DXU7P0niX466eKKJ9oV2ngCoMrWvvh8JlObx1zt4hIwbZNhb/fagqtQtSN1OUpAjTUiwgL8t9R64gqJP7uXOlUrzAcMduNRNtaSwbD8IkrVPd8k/gW2uXLQembt8VwveFn43mZeVNJapY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ianPdFhS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6de3141f041so1706601b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 06:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708095263; x=1708700063; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H5+UrxbRXLOQkrvNam9zPtYfUH7CmHJYGluAwCM/rwk=;
        b=ianPdFhSVhzI9Th/fqAI3ShYYxPw20hycVzaslpZgLpP6SPLRSaW1mLsohvPFQsX59
         I6cRHV+/MamW0t592fUjLVHFMQdPIOWXgIdmrD/BIYuYHMI0NJ9VvJdFva49s126fIe2
         QDL3viwXpcYjygLeFhNrCNyreczL+2lXlMjGqk2YOOT9+KUmuYq9W9qkktJo0l5an08f
         TEHdJgUyjYBOtvPU9H2yM/rIXeTejxAgFQeP2RMeuSpwmfzduitIka7AQk4qyYrWO2og
         2WfOtiFyDnR604TTVhnbMS9btiGnPt6tcciuaJmHlP6G6fmsZXRNOt/j+l3CzP7kPxKH
         WdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708095263; x=1708700063;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5+UrxbRXLOQkrvNam9zPtYfUH7CmHJYGluAwCM/rwk=;
        b=M/vAA0S9rDq+8cPhrdxU3QNEtsnrjyrz42RlFu4IzdTEL1pSqGxCrpVBlOspCPt8NA
         mQumVPDd8Nwe+77HKwN/VNWPZueZE9P4xSYdaIBtQvnrL4c+wJ7Ym79B9CtuXPf6PBGX
         zHc9VxMIVbzb/VYw8UAQl/f9Hyo6Ac6dYYK94Z45l5xku2aViw1KWkXpuu5YynkzDv5K
         D9N+A+WK+Cm1o0F7Cp8bpmf3AqYf8HRzv+y3bCA5YWvOapVb+swTOiPpw3EdsVkqDsEz
         LI8WZIoHFFTS/e57r4q2azo7txeAanTQuFOe/VbULZ46xRbzF+tdujh2Nw7KE1YRRu+9
         BHSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjuLOTYjL+CaS7FKRG3x2BXYLvT8vKB1eEwuEclcTnbL2Aq6TekJ3+Z4NUDIKkrDooBfRvh/dosVTqJmyVgye51MXwAKDn96MZ
X-Gm-Message-State: AOJu0Yypf1OY6WRAm8zdgj9UVT0Rj4CvsxRaAELoY2hYDjTxMINxkLLd
	eC/gCj/h4RQ1gcckN2cDNdvD0D+jbDyfXlyDi+WuhoCDIisP8J9E5NQpHZs++Q==
X-Google-Smtp-Source: AGHT+IFebQpMSN10eafxcqxmHBhmZ61uYkmXBGgYKWbyPo+PGCqfnv3NuYzwqbuIh9R8Q1n23F0ayg==
X-Received: by 2002:a05:6a00:3a81:b0:6e0:392b:c236 with SMTP id fk1-20020a056a003a8100b006e0392bc236mr4809601pfb.11.1708095263219;
        Fri, 16 Feb 2024 06:54:23 -0800 (PST)
Received: from thinkpad ([120.138.12.48])
        by smtp.gmail.com with ESMTPSA id e11-20020a056a0000cb00b006e046085ee8sm21871pfj.174.2024.02.16.06.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:54:22 -0800 (PST)
Date: Fri, 16 Feb 2024 20:24:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] arm64: dts: qcom: sc8280xp: enable GICv3 ITS for
 PCIe
Message-ID: <20240216145416.GA39963@thinkpad>
References: <20240212165043.26961-1-johan+linaro@kernel.org>
 <20240214063554.GC4618@thinkpad>
 <ZcyfW4HSsES7GU-F@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcyfW4HSsES7GU-F@hovoldconsulting.com>

On Wed, Feb 14, 2024 at 12:09:15PM +0100, Johan Hovold wrote:
> On Wed, Feb 14, 2024 at 12:05:54PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Feb 12, 2024 at 05:50:33PM +0100, Johan Hovold wrote:
> > > This series addresses a few problems with the sc8280xp PCIe
> > > implementation.
> > > 
> > > The DWC PCIe controller can either use its internal MSI controller or an
> > > external one such as the GICv3 ITS. Enabling the latter allows for
> > > assigning affinity to individual interrupts, but results in a large
> > > amount of Correctable Errors being logged on both the Lenovo ThinkPad
> > > X13s and the sc8280xp-crd reference design.
> > > 
> > > It turns out that these errors are always generated,
> > 
> > How did you confirm this?
> 
> You can see that error flags being set in the controller and endpoint,
> for example, using lspci -vv:
> 
> 	CESta:  RxErr- BadTLP+ BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> 

Okay.

> > > but for some yet to
> > > be determined reason, the AER interrupts are never received when using
> > > the internal MSI controller, which makes the link errors harder to
> > > notice.
> > 
> > If you manually inject the errors using "aer-inject", are you not seeing the AER
> > errors with internal MSI controller as well?
> 
> I haven't tried that, I'm just reporting that that piece of
> functionality is currently broken and that that partly explains why the
> ASPM problems went unnoticed.
> 

I just gave it a shot and I could see the AER interrupts raised for correctable
errors with internal MSI controller.

Now I'm puzzled why this is not getting triggered by default. I'll check with
the hardware team if they have any clue.

> > > On the X13s, there is a large number of errors generated when bringing
> > > up the link on boot. This is related to the fact that UEFI firmware has
> > > already enabled the Wi-Fi PCIe link at Gen2 speed and restarting the
> > > link at Gen3 generates a massive amount of errors until the Wi-Fi
> > > firmware is restarted.
> > > 
> > > A recent commit enabling ASPM on certain Qualcomm platforms introduced
> > > further errors when using the Wi-Fi on the X13s as well as when
> > > accessing the NVMe on the CRD. The exact reason for this has not yet
> > > been identified, but disabling ASPM L0s makes the errors go away. This
> > > could suggest that either the current ASPM implementation is incomplete
> > > or that L0s is not supported with these devices.
> > 
> > What are those "further errors" you are seeing with ASPM enabled? Are those
> > errors appear with GIC ITS or with internal MSI controller as well?
> 
> Further errors as in further correctable errors that are not related to
> the errors seen when resetting the X13s Wi-Fi link at boot.
> 
> These show up, for example, when accessing the NVMe on the CRD or when
> using the Wi-Fi on the X13s. These errors go away when L0s is disabled.
> 
> And yes, you see them with both the external and internal MSI controller
> (in the latter case, by looking at the error flags mentioned above).
>  

Hmm.

> > > Note that the X13s and CRD use the same Wi-Fi controller, but the errors
> > > are only generated on the X13s. The NVMe controller on my X13s does not
> > > support L0s so there are no issues there, unlike on the CRD which uses a
> > > different controller. The modem on the CRD does not generate any errors,
> > > but both the NVMe and modem keeps bouncing in and out of L0s/L1 also
> > > when not used, which could indicate that there are bigger problems with
> > > the ASPM implementation. I don't have a modem on my X13s so I have not
> > > been able to test whether L0s causes an trouble there.
> > > 
> > > Enabling AER error reporting on sc8280xp could similarly also reveal
> > > existing problems with the related sa8295p and sa8540p platforms as they
> > > share the base dtsi.
> > > 
> > > The last four patches, marked as RFC, adds support for disabling ASPM
> > > L0s in the devicetree and disables it selectively for the X13s Wi-Fi
> > > and CRD NVMe. If it turns out that the Qualcomm PCIe implementation is
> > > incomplete, we may need to disable ASPM (L0s) completely in the driver
> > > instead.
> > 
> > If the device is not supporting L0s, then it as to be disabled in the device,
> > not in the PCIe controller, no?
> 
> Well, we don't know yet where the problem lies, just that enabling L0s
> results in a large number of correctable errors.
> 
> Until yesterday I had not seen any such errors for the Wi-Fi on the CRD,
> which uses essentially the same ath11k controller, so there was no clear
> indication that this was necessarily a problem with the devices either.
> 

I'll confirm the L0s compatibility with the hardware team.

> > > Note that disabling ASPM L0s for the X13s Wi-Fi does not seem to have a
> > > significant impact on the power consumption 
> > > 
> > > The DT bindings and PCI patch are expected to go through the PCI tree,
> > > while Bjorn A takes the devicetree updates through the Qualcomm tree.
> > 
> > Since I took a stab at enabling the GIC ITS previously, I noticed that the NVMe
> > performance got a slight dip. And that was one of the reasons (apart from AER
> > errors) that I never submitted the patch.
> > 
> > Could you share the NVMe benchmark (fio) with this series?
> 
> Did you have any particular benchmark in mind?
> 
> I have run multiple fio benchmarks and while the results vary with the
> parameters, the impact of switching to ITS (so that not all PCIe
> interrupts are processed on CPU0) is generally favourable.
> 
> A raw sequential read shows no change in throughput on either the X13s
> or the CRD even if for some reason this test performs really badly on
> the X13s (i.e. regardless of which MSI controller is used):
> 
> 	crd-rseq-read:	IOPS=11.1k, BW=2764MiB/s (2898MB/s)(81.0GiB/30003msec)
> 	X13s-rseq-read:	IOPS=508, BW=127MiB/s (134MB/s)(3841MiB/30169msec)
> 
> Another benchmark I've used against a mounted ext4 partition shows a 2x
> improvement in throughput with ITS for sequential and random reads and
> writes on the X13s:
> 
> 	seq-read:	IOPS=88.4k, BW=345MiB/s (362MB/s)(10.0GiB/29657msec)
> 	rand-read:	IOPS=21.2k, BW=82.8MiB/s (86.8MB/s)(4967MiB/60001msec)
> 	seq-write:	IOPS=162k, BW=632MiB/s (662MB/s)(10.0GiB/16213msec)
> 	rand-write:	IOPS=142k, BW=555MiB/s (582MB/s)(10.0GiB/18439msec)
> 	
> while the results are essentially unchanged with a larger block size and
> queue depth (32/2m instead of 4/4k):
> 
> 	seq-read:	IOPS=1095, BW=2191MiB/s (2298MB/s)(10.0GiB/4673msec)
> 	rand-read:	IOPS=1020, BW=2041MiB/s (2140MB/s)(10.0GiB/5017msec)
> 	seq-write:	IOPS=918, BW=1837MiB/s (1926MB/s)(10.0GiB/5574msec)
> 	rand-write:	IOPS=826, BW=1653MiB/s (1734MB/s)(10.0GiB/6194msec)
> 

Ok, this looks promising. Long back when I tried the benchmark (seq & rand r/w),
performance dropped slightly with GIC ITS. But looks like things have changed.

> > > Johan Hovold (10):
> > >   dt-bindings: PCI: qcom: Allow 'required-opps'
> > >   dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
> > >   arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
> > >   arm64: dts: qcom: sc8280xp-crd: limit pcie4 link speed
> > >   arm64: dts: qcom: sc8280xp-x13s: limit pcie4 link speed
> > >   arm64: dts: qcom: sc8280xp: enable GICv3 ITS for PCIe
> > 
> > Is this patch based on the version I shared with you long back? If so, I'd
> > expect to have some credit. If you came up with your own version, then ignore
> > this comment.
> 
> No, this patch has beeen created and evaluated from scratch based on the
> downstream direwolf dts, which has these five 'msi-map' properties. 
> 
> I debated whether I should base it on your version instead, but in the
> end it would have a new commit message and only these properties from
> the downstream dtsi would remain (you also removed existing properties
> IIRC). So while it's certainly inspired by your work, this has been done
> from scratch, including the testing.
> 
> If you prefer I can make this clear in the commit message, but adding a
> Co-developed-by didn't seem quite right either as I did this work
> without your involvement. But perhaps that would be better?
> 

Nah. As I said, if you have created the patch without basing on my version,
then no credit is required. I just wanted to know since I shared the patch
earlier.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


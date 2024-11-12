Return-Path: <linux-pci+bounces-16511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F170B9C504D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 09:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEEF8B20AED
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 08:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B0A1CCB50;
	Tue, 12 Nov 2024 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSuvlQDK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF3019D067
	for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2024 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398546; cv=none; b=h4wyQGW9B62zvQiOpX35GdTPjry2EUgdy0pnhRDmwkmsYih3MXCOn4jVtHvv8CJmkrkMvb5KftYyUu024wL63GsvVLFCAfzb0fNKJGe4GWrOKrzsyFDOru5deBFcS3hBb51YYVoeD+yF5K0cpbEYGZAFyI2UlRe1+PwO4flSJss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398546; c=relaxed/simple;
	bh=Gdzfz6nuF3Mv2sztvCsvN7kvDs3V6ahV1Si39NMWwFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8+hiMpv+SyIW08TdA1mu4we/K12NvbDLploOvDf1gCvW/pyGu3F0sDJNuS1W8f496EWrFHPCSIL8/cpYSBZtiMUh2f5iSS5A1sC3kZKuhn9huZiJhTz4lbsi1+bHBodMqPl/X45Xf8WzCoatw3cSODKhzPkCaveCgbwO9Ij5GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WSuvlQDK; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7f12ba78072so4044279a12.2
        for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2024 00:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731398544; x=1732003344; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tdmcDJQb0kxtWtYlqvMLgav0HJpmDO9A2F6bQ8vcVVk=;
        b=WSuvlQDKMgONIbtNGPDIFvCb70GeFTOzCgLON72X9RpI+9yUZWiMhpqTKg83ZIVPUH
         TDIqhdOPuFTJYgXLhTLuKKI/7MekeTLommHP+nVt676qTztAzRAqhtGtUykFm+Xk4Zy2
         Kagmskip+7WnTm++tTxv1HUPn+6uSX2LZSXBTAzNTDYNyA0iAysSiYBTt6i4niOQ3PLI
         cuV31HiUJLdmB37a0nYliTW/yeh8c6AU1MWhSpCPnmxmUwu/4S03yKJF9jfceI9CsKWa
         2LJICTT8G/BOAb00htrr6piqE2PZlleg2tL/EgXh60Pyv3yzsUhluvZvxkgRNZVID3VT
         Yrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731398544; x=1732003344;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdmcDJQb0kxtWtYlqvMLgav0HJpmDO9A2F6bQ8vcVVk=;
        b=g8kUeFr52KAzV6HfijXcz3UfoTjjJZl9Q/mCSTnTpD9amfkZerZHveVBpGA390PtMb
         h/qfzU2l9w9rfaCJLcOx/a+YqZe5YvCoQLHMQm2qmFnZq2/HKC78R9WxZ7aaP3lAWdAN
         vQ+55t426gcqO7SM1sHKTNp7mIVF1iMS1IJBpdG0EME7+nEeZ2yIjEcZOO8ZvSREiRRI
         GV7K6cRt85Qc5AI8eHTrupqBZGC4bhndOaKJobow0k1698JG8htxcZPgGlbFdCG6Mjwr
         Oum/l/AkSGzmsPGxd9p5LoKXX4wiQabp1zi3t6pkgTykRmGIQlKvepT0steOti8n8DJG
         dUyg==
X-Forwarded-Encrypted: i=1; AJvYcCWUjaeTqZVMKVo63gLMTWDvxrhjWiO7u5kPIosF85imtyelXYpPUSNJ4bpb54RevlyZb7XSLOaPJ5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YziuPbiaVQ0GKuGMqUGd37BwUA1asUdF0fkje7yF/HskU0K06FJ
	DO8AQKCqktOrXn2OSeJRgEc7QZT0eQRRHnLbQG0TRfh+N3WDufcRH+i33bju9g==
X-Google-Smtp-Source: AGHT+IGxmuoFDE3JbNsNx57MeL6QGeI+BKO4bDu8QDdKhoNLOa8X4pga/l3/7VWn1aeLrpGmDD9L0Q==
X-Received: by 2002:a17:90b:4a87:b0:2e2:aef9:8f60 with SMTP id 98e67ed59e1d1-2e9b14ddb3bmr20379534a91.0.1731398544255;
        Tue, 12 Nov 2024 00:02:24 -0800 (PST)
Received: from thinkpad ([117.213.103.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9b23a510bsm8093555a91.15.2024.11.12.00.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 00:02:23 -0800 (PST)
Date: Tue, 12 Nov 2024 13:32:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	jingoohan1@gmail.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Message-ID: <20241112080216.6kzdybe2su5ozp44@thinkpad>
References: <20241107111334.n23ebkbs3uhxivvm@thinkpad>
 <20241108002425.GA1631063@bhelgaas>
 <20241111060902.mdbksegqj5rblqsn@thinkpad>
 <ZzJCGkenhxgJxoC4@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzJCGkenhxgJxoC4@lizhi-Precision-Tower-5810>

On Mon, Nov 11, 2024 at 12:42:50PM -0500, Frank Li wrote:
> On Mon, Nov 11, 2024 at 11:39:02AM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Nov 07, 2024 at 06:24:25PM -0600, Bjorn Helgaas wrote:
> > > On Thu, Nov 07, 2024 at 11:13:34AM +0000, Manivannan Sadhasivam wrote:
> > > > On Thu, Nov 07, 2024 at 04:44:55PM +0800, Richard Zhu wrote:
> > > > > Before sending PME_TURN_OFF, don't test the LTSSM stat. Since it's
> > > > > safe to send PME_TURN_OFF message regardless of whether the link
> > > > > is up or down. So, there would be no need to test the LTSSM stat
> > > > > before sending PME_TURN_OFF message.
> > > >
> > > > What is the incentive to send PME_Turn_Off when link is not up?
> > >
> > > There's no need to send PME_Turn_Off when link is not up.
> > >
> > > But a link-up check is inherently racy because the link may go down
> > > between the check and the PME_Turn_Off.  Since it's impossible for
> > > software to guarantee the link is up, the Root Port should be able to
> > > tolerate attempts to send PME_Turn_Off when the link is down.
> > >
> > > So IMO there's no need to check whether the link is up, and checking
> > > gives the misleading impression that "we know the link is up and
> > > therefore sending PME_Turn_Off is safe."
> > >
> >
> > I agree that the check is racy (not sure if there is a better way to avoid
> > that), but if you send the PME_Turn_Off unconditionally, then it will result in
> > L23 Ready timeout and users will see the error message.
> >
> > > > > Remove the L2 poll too, after the PME_TURN_OFF message is sent
> > > > > out.  Because the re-initialization would be done in
> > > > > dw_pcie_resume_noirq().
> > > >
> > > > As Krishna explained, host needs to wait until the endpoint acks the
> > > > message (just to give it some time to do cleanups). Then only the
> > > > host can initiate D3Cold. It matters when the device supports L2.
> > >
> > > The important thing here is to be clear about the *reason* to poll for
> > > L2 and the *event* that must wait for L2.
> > >
> > > I don't have any DesignWare specs, but when dw_pcie_suspend_noirq()
> > > waits for DW_PCIE_LTSSM_L2_IDLE, I think what we're doing is waiting
> > > for the link to be in the L2/L3 Ready pseudo-state (PCIe r6.0, sec
> > > 5.2, fig 5-1).
> > >
> > > L2 and L3 are states where main power to the downstream component is
> > > off, i.e., the component is in D3cold (r6.0, sec 5.3.2), so there is
> > > no link in those states.
> > >
> > > The PME_Turn_Off handshake is part of the process to put the
> > > downstream component in D3cold.  I think the reason for this handshake
> > > is to allow an orderly shutdown of that component before main power is
> > > removed.
> > >
> > > When the downstream component receives PME_Turn_Off, it will stop
> > > scheduling new TLPs, but it may already have TLPs scheduled but not
> > > yet sent.  If power were removed immediately, they would be lost.  My
> > > understanding is that the link will not enter L2/L3 Ready until the
> > > components on both ends have completed whatever needs to be done with
> > > those TLPs.  (This is based on the L2/L3 discussion in the Mindshare
> > > PCIe book; I haven't found clear spec citations for all of it.)
> > >
> > > I think waiting for L2/L3 Ready is to keep us from turning off main
> > > power when the components are still trying to dispose of those TLPs.
> > >
> >
> > Not just disposing TLPs as per the spec, most endpoints also need to reset their
> > state machine as well (if there is a way for the endpoint sw to delay sending
> > L23 Ready).
> >
> > > So I think every controller that turns off main power needs to wait
> > > for L2/L3 Ready.
> > >
> > > There's also a requirement that software wait at least 100 ns after
> > > L2/L3 Ready before turning off refclock and main power (sec
> > > 5.3.3.2.1).
> > >
> >
> > Right. Usually, the delay after PERST# assert would make sure this, but in
> > layerscape driver (user of dw_pcie_suspend_noirq) I don't see power/refclk
> > removal.
> >
> > Richard Zhu/Frank, thoughts?
> 
> Generally, power/refclk remove when system enter sleep state. There is
> signal "suspend_request_b", which connect to PMIC. After CPU trigger this
> signnal, PMIC will turn off (pre fused) some power rail.
> 
> Refclk(come from SOC chip), OSC will be shutdown when send out
> "suspend_request_b".
> 

Thanks for clarifying! Then it would be better to add the 100ns delay after
receiving the L23 Ready message from endpoint.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


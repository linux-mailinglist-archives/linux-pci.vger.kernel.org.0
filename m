Return-Path: <linux-pci+bounces-16588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055AC9C6057
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 19:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C204BE2ED0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 18:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCC72144D8;
	Tue, 12 Nov 2024 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWy1ZmL6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1A148FF3
	for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2024 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434665; cv=none; b=GHs8voaCDWHFJHuuHjzx2alrdokCVYBfKRZ1socCYRTfkHP7Pzyzvdd5djQs4izycjVVcDF+O3d3bkB/+Y6I0BatdE079gxnSeIaJdoSfoO1CoUo7BLntPPFqS6NR/5CRjZEmhyQaPLteuM9WigiF2dAwbF/V+7nTxo/FWuVc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434665; c=relaxed/simple;
	bh=kiHvwDGa1v/MXG+BQ5FjLjKtxIEGVLc8ycijHOantfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caD4xniZzwCKDC61KZjy+EqZ1c+7CUZM6Oszc6AjlggPXc3TYtyfjtQhg9DSypzfPdBy28cU7ePR8+HigHc7jMVJYasNtgIr4D1bE/qCsPHRKMxvKpxLq4abw/annQOuQgGpKAKHWXQnCrxvRCYRk2L4ahC5WxQ6GiH9OFwpMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UWy1ZmL6; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso4492552b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2024 10:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731434663; x=1732039463; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VeXkIgWbLSCzsISs/oTGsSq58/Qd//+A0sauzP5H6WU=;
        b=UWy1ZmL6tjv314zf6fWbWmTX/3dVCgzAffUlbCnl23cgSPiF1Dy06n4jC4cttu+Ece
         R8vXp5n5P0k+VyCZYbs3Z7z2DLKNF0EFHvg/EzUPlg/dlYnxdNFYmuoTkSnzgbNjastF
         XSAgrbBsHhC+297Pg7a6iJ3F00V4qeGZjfKBvIvn00INBKBe/Nc7jAy3wA7oA3G9teJj
         nGX2BhUYZ46rVpyD4R3pCT9mxWlHC+WxyQjCvCJeV6PGFF9qzTO/3ULmHYQVawYLXi4S
         7MHb5ZWQqcep0UmaxbCHZsbYzWTwPSKsGSgatxVeD7V8aA413RGgHMU2AMZK1fDHf9Ef
         iZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434663; x=1732039463;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VeXkIgWbLSCzsISs/oTGsSq58/Qd//+A0sauzP5H6WU=;
        b=tHXBzMkwrd6d8kh9SoBtFxquyRQgKmMEL1s+TmwTcPsTN8112Aof7uVadmFp0O7DAg
         bveFCBUMmHZCV2GJbbPLJXgNqxmrkGDN8q67AVNtHWEGr5waDmQSFlqOR47p6JINmOg8
         EbDFsa+T0irnsx8fL+PZZnvN/Ngk+9TdanjfdeAFSlXlPPEj5dyupmTByCV/w/ge5ULY
         TQIPed5cpFRQTM+GrcbBC2GJh1D572cvdXMAkCptrOphTEuFd86UzLECUJWnSYiT0yRZ
         n1i4WmiVhnermER+PrumvkXkXpLMkcXxNK61ZYLhDWB/wczoTpyEAbxwMnnvD1NdyoWJ
         hf0w==
X-Forwarded-Encrypted: i=1; AJvYcCVJrKwFrlv2u/uYLGX6yNPM4HoSn4t9JCWVgWxg7nfsEmI09HKNAI+ypiZBn7qTRd/VIWBOHsa+wIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTUZ7EuTTVxaE8Ya1NzCh1RmZPM6eolFNNXf3zW5WH1eY0VFUL
	b8X48Rh9D9JbLMG5ysIuVID3QlO5MKzHkGaa1mrEtMGmjaTDARtPNF5i1JT9ajNRRMzSJldoR8g
	=
X-Google-Smtp-Source: AGHT+IF9YlSU/A2R3S+EGE+zy9TUlP6Jr0MK4kIBFc23KyUhQBv+qDrdn7yK6/DV+IBVJHUvw9ppag==
X-Received: by 2002:a05:6a00:14d3:b0:71d:ee1b:c854 with SMTP id d2e1a72fcca58-724132a134dmr24121068b3a.9.1731434663170;
        Tue, 12 Nov 2024 10:04:23 -0800 (PST)
Received: from thinkpad ([117.213.103.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a8a6asm11490854b3a.76.2024.11.12.10.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 10:04:22 -0800 (PST)
Date: Tue, 12 Nov 2024 23:34:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	Frank Li <frank.li@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Message-ID: <20241112180416.ssyivc53h7i6w2wq@thinkpad>
References: <20241107111334.n23ebkbs3uhxivvm@thinkpad>
 <20241108002425.GA1631063@bhelgaas>
 <20241111060902.mdbksegqj5rblqsn@thinkpad>
 <AS8PR04MB8676B2B98473900A6310246C8C592@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676B2B98473900A6310246C8C592@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Tue, Nov 12, 2024 at 09:25:57AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 2024年11月11日 14:09
> > To: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Hongxing Zhu <hongxing.zhu@nxp.com>; jingoohan1@gmail.com;
> > bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> > robh@kernel.org; Frank Li <frank.li@nxp.com>; imx@lists.linux.dev;
> > kernel@pengutronix.de; linux-pci@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
> > dw_pcie_suspend_noirq()
> > 
> > On Thu, Nov 07, 2024 at 06:24:25PM -0600, Bjorn Helgaas wrote:
> > > On Thu, Nov 07, 2024 at 11:13:34AM +0000, Manivannan Sadhasivam
> > wrote:
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
> > I agree that the check is racy (not sure if there is a better way to avoid that),
> > but if you send the PME_Turn_Off unconditionally, then it will result in
> > L23 Ready timeout and users will see the error message.
> > 
> I understand Manivannan' s concerns.
> When check the link is up or not before dumping error message, 
> there is another check racy.

Right.

> How about to replace the dev_err() by dev_info(), and no error return?
> Whatever the timeout is caused by no EP connected or something else. Just
> inform user the real stat it is.
> 

But users don't want the timeout message if no EP is connected, that's my point.

- Mani

> Best Regards
> Richard Zhu
> 
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
> > Not just disposing TLPs as per the spec, most endpoints also need to reset
> > their state machine as well (if there is a way for the endpoint sw to delay
> > sending
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
> > 
> > - Mani
> > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்


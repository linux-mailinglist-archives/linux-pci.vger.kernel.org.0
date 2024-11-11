Return-Path: <linux-pci+bounces-16425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D019C3832
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 07:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1D61F21C4B
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 06:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F4D155327;
	Mon, 11 Nov 2024 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PmsDvpi6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B414B95A
	for <linux-pci@vger.kernel.org>; Mon, 11 Nov 2024 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731305352; cv=none; b=Tnm/RPTkzc6kh/U8wADdWhIj0FUayIDqTF4f/XdeV7rQGS15nBJi0PXG6zgNywP9ZROBvp3rsA84k8Nd0//TSl52TeijxP9HVnb7GAxDF+sBxDkrg0+yZMobanext1vE33xi4wxKqSCl8BstVP2Rc/tAXLnt/eu4ay69r5aRJUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731305352; c=relaxed/simple;
	bh=Y+YcqdGqf+OGKcdRrC+abbyhOx97TLTW0GMdmUmwMpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxAO+w6rqUfXJL2KVnK5wt0H18oJC9JrqsuDHXriOTNlh8xoJh/0O6vmvhBx5O0thGL1RqecxbiWGXRpJCcWSYVNWcfWkkrG4W8FF9YZZrBBbPyk4fM6K6PUDvCUVR9sTmXJsI4TjHXo5eNO3f2zp7t9AkTgg/02X4FUItRsjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PmsDvpi6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cceb8d8b4so26795605ad.1
        for <linux-pci@vger.kernel.org>; Sun, 10 Nov 2024 22:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731305350; x=1731910150; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qkxZN5YdgAuoqBMpfCPX8HcOfpXqfkrH2t/OYEck+/8=;
        b=PmsDvpi6u+JAnulH5pxVpa/KqfbN4ViYYhZ6bSgyb859o5CBM65X2J9wVzMglCeFSx
         WtqU1B/DsOrQmkv1GEpvQmaJ67+SsicT4LDLnxx5sazsept4ACihUaZ6aQipJrD8i7uU
         slgi8dhogNu95xHomeynF2/nKlsDztCst2lSnG/8WJ1zQOPZ4d8AYqJIQMZjNypr6eqz
         y4kF5ez469eeOSlicndkANZfGyUMN2OmZa6SFUxTRb2sb6M9ovqi7SU9PbkDTOIJO506
         F9zrk2F60vKBH3DRXo39YDSJAdlCuZMcufoHr1XZMN2hrEpAL12Rsf4C8MMWZ0gfqB7H
         gZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731305350; x=1731910150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkxZN5YdgAuoqBMpfCPX8HcOfpXqfkrH2t/OYEck+/8=;
        b=IDv85idFz5hG187ymtH0GIRVQ2Y7rnLhKIAGlQKNu7YVm6sOLe4vgFllSv08krdefJ
         XTp+IJJ1p7C5dL9ICeLhz//py2fOfRF6hr6t2YKkXnAouAYf8ViIuSpkeoQi72TfQJyl
         /JtfJWSgDNh4wxaFcYJGa2UVyQuuenFBb7UMMsotE9c43MX/ryfoBHw1eYdDV8wlPcGp
         K3/PV+fA+RWiciNDBtipj3rbSgWHLniaLnJzKXOij4573dXVx8lATSuwDWY1+eSm2kvT
         Kj+2WCqPQhWNflAep62XJ/71wYGq0jbW3iTB895i0JFPYbjjB2m98c5+ali0Rrkk4PFP
         U29g==
X-Forwarded-Encrypted: i=1; AJvYcCXbq8D3KFVs3gu8hMlnZ2izdrSDcMWmsLfgglC4X4RvUL19WxCuOg/Iin/ioi6kGUr9xmYHWIwqMro=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq3FZ0dZcBLwd8uKzIzCc93ef5Ox8M2+yjMx/BrVrC7LqQX4Es
	TFJcR2BrdeWryMSQ0B6LSZfveGprXRSc4xZXPOX8iIFpQ8ujjpG9HIdH6nec3w==
X-Google-Smtp-Source: AGHT+IEl6gQgVgwKnj6tE3Fweh981irdtgKxjVaL3Zp4fjV5+8vkkGC4Z/QsrLc4gCH0NjBzR+4oiw==
X-Received: by 2002:a17:903:1c2:b0:205:7007:84fa with SMTP id d9443c01a7336-211837c3ddemr194720175ad.28.1731305349913;
        Sun, 10 Nov 2024 22:09:09 -0800 (PST)
Received: from thinkpad ([117.193.211.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e4205esm68869915ad.151.2024.11.10.22.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:09:09 -0800 (PST)
Date: Mon, 11 Nov 2024 11:39:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, jingoohan1@gmail.com,
	bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, frank.li@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Message-ID: <20241111060902.mdbksegqj5rblqsn@thinkpad>
References: <20241107111334.n23ebkbs3uhxivvm@thinkpad>
 <20241108002425.GA1631063@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241108002425.GA1631063@bhelgaas>

On Thu, Nov 07, 2024 at 06:24:25PM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 07, 2024 at 11:13:34AM +0000, Manivannan Sadhasivam wrote:
> > On Thu, Nov 07, 2024 at 04:44:55PM +0800, Richard Zhu wrote:
> > > Before sending PME_TURN_OFF, don't test the LTSSM stat. Since it's
> > > safe to send PME_TURN_OFF message regardless of whether the link
> > > is up or down. So, there would be no need to test the LTSSM stat
> > > before sending PME_TURN_OFF message.
> > 
> > What is the incentive to send PME_Turn_Off when link is not up?
> 
> There's no need to send PME_Turn_Off when link is not up.
> 
> But a link-up check is inherently racy because the link may go down
> between the check and the PME_Turn_Off.  Since it's impossible for
> software to guarantee the link is up, the Root Port should be able to
> tolerate attempts to send PME_Turn_Off when the link is down.
> 
> So IMO there's no need to check whether the link is up, and checking
> gives the misleading impression that "we know the link is up and
> therefore sending PME_Turn_Off is safe."
> 

I agree that the check is racy (not sure if there is a better way to avoid
that), but if you send the PME_Turn_Off unconditionally, then it will result in
L23 Ready timeout and users will see the error message.

> > > Remove the L2 poll too, after the PME_TURN_OFF message is sent
> > > out.  Because the re-initialization would be done in
> > > dw_pcie_resume_noirq().
> > 
> > As Krishna explained, host needs to wait until the endpoint acks the
> > message (just to give it some time to do cleanups). Then only the
> > host can initiate D3Cold. It matters when the device supports L2.
> 
> The important thing here is to be clear about the *reason* to poll for
> L2 and the *event* that must wait for L2.
> 
> I don't have any DesignWare specs, but when dw_pcie_suspend_noirq()
> waits for DW_PCIE_LTSSM_L2_IDLE, I think what we're doing is waiting
> for the link to be in the L2/L3 Ready pseudo-state (PCIe r6.0, sec
> 5.2, fig 5-1).
> 
> L2 and L3 are states where main power to the downstream component is
> off, i.e., the component is in D3cold (r6.0, sec 5.3.2), so there is
> no link in those states.
> 
> The PME_Turn_Off handshake is part of the process to put the
> downstream component in D3cold.  I think the reason for this handshake
> is to allow an orderly shutdown of that component before main power is
> removed.
> 
> When the downstream component receives PME_Turn_Off, it will stop
> scheduling new TLPs, but it may already have TLPs scheduled but not
> yet sent.  If power were removed immediately, they would be lost.  My
> understanding is that the link will not enter L2/L3 Ready until the
> components on both ends have completed whatever needs to be done with
> those TLPs.  (This is based on the L2/L3 discussion in the Mindshare
> PCIe book; I haven't found clear spec citations for all of it.)
> 
> I think waiting for L2/L3 Ready is to keep us from turning off main
> power when the components are still trying to dispose of those TLPs.
> 

Not just disposing TLPs as per the spec, most endpoints also need to reset their
state machine as well (if there is a way for the endpoint sw to delay sending
L23 Ready).

> So I think every controller that turns off main power needs to wait
> for L2/L3 Ready.
> 
> There's also a requirement that software wait at least 100 ns after
> L2/L3 Ready before turning off refclock and main power (sec
> 5.3.3.2.1).
> 

Right. Usually, the delay after PERST# assert would make sure this, but in
layerscape driver (user of dw_pcie_suspend_noirq) I don't see power/refclk
removal.

Richard Zhu/Frank, thoughts?

- Mani

-- 
மணிவண்ணன் சதாசிவம்


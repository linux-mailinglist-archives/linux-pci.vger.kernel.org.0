Return-Path: <linux-pci+bounces-21498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EF1A364B2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373DA188FF4B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB2C267AEB;
	Fri, 14 Feb 2025 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfX9S/Ut"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDF1264A80
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554614; cv=none; b=gu2zqTvIVBzUe1ryIvwVtM56q+zTm7vUUTAbl40c5mOXxOtO85BxWTiK+9+vUQ12uAijxpHMM+6Sx3j7nFEOjTvBfrDfdOzrU1+mnemkSNtrJ7s1xSlpQDDgrhSq6khZ1b0+kUnxStEeIVGDwyugZvtfv4Eb9IAuzoV0WW2Uj2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554614; c=relaxed/simple;
	bh=CgVwuAmZaaHCwkq2wGyHJ0bk/+ozIDvB+bJn963eaOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfGD1vz8/haP63M1RkzkMV9ndR4gAXyXAjgw2edolFweewn3/e6XAwT4+aZdmRg4jbbL0KRBcN2QC4VSotPoKui5tRdpQtBmMnN4/dlO2T4q1RMzKlw0NeERDgC535YtIYB+mPoHHdDT7d3/SqnpenU4yezvzSAi2B6plOeF30w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TfX9S/Ut; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f44353649aso3490287a91.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739554612; x=1740159412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x0jY19iaea2nNrTmHpo4mZf39vSCWNkS4XHLE1IKd7s=;
        b=TfX9S/UtU5QpZNKo3ZjQgizPih6egREO3CAer15mv+Mh0Qd7B6g2r4mpQ4czrQJMxD
         5YQl+37wgxgTUipv2lSzk1CrPRUVlheXU2DfUGKe4EMz3HRaRWIS4khaf/Bja6p6obrF
         I+5T1UA3HRPrxpKb3+t6rDjwz68lPCjGOgGmMJPximZ68Quuhu1MXjNNUpXn60KCmrWv
         UOVeLTdhxipzrbBQpRTfDvB0Bg/n8OFnEEmZ1gsoHCoUFDEfqtV4yetuiUM8g+CjXVNo
         c4VMzfKx/4dlSkDp96a1+NFliwCP03/sMYk4yFR5yX4wVTEyA+NhQlg90COXnDKGVP7g
         YWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554612; x=1740159412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0jY19iaea2nNrTmHpo4mZf39vSCWNkS4XHLE1IKd7s=;
        b=NTzDW56V2vw4Clugmq7MxUgon+VQETH/911mwCWNLyvOtjnPPm98pQvO0lXLktLQxN
         LvTEqtJ4Go7FGFwvBlz+0orkxLAN8UKepqt4UnbjpJ78vP+xDvnUTdVJhJOk80RawS5t
         ultlDkw/Ki6WdcQHFaTBH8d3OKIlzy/Ix081TI8zb3z87fPPwDIbEaxV3KvARsQr/54R
         m/JFAhbn1wG1jTiUKQo2qla0XSDB9t9458AYOcqyDinbAAruc3hDDP2R1Z60pgm8E4Kb
         Z2FQDHTM5H1RLQsRmvP8vrETEIAIRhTgYfGOzcZemAgpERlG8llRLQeZQKzS6hcMg6Zr
         NZMA==
X-Forwarded-Encrypted: i=1; AJvYcCW/dDEDapYjnLI0vkSBU9bWDIH0IPHOqMk8yeIsBX6B5vNaAzgVYCAJ86tQ+EvbwD1+HhyV4Sh2hps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEDmSYbpfCaeL1tIGsdN6ICLU01+xBcc2kwMp183QRrTzXHWbg
	KrNBIcHG1rrKynS3KkQipnrAXocMsuOn4d2a/LOZKsexC3sDNul6PcDB+jPnbjDJCsRCPeffWdQ
	=
X-Gm-Gg: ASbGnctaEnRoH1YvbPkFlW6qXuJX1Lkicv4aOcaC/zPD5oJqgflrfoDdgrtg0CpRUI9
	NsxRJSakkBY+/roBdVtxTvNebijn79mQteszrMCxFMdfOpni33g09sWd9jNTSM87ACNdDGLDnnJ
	QUFYkaWjvNi3aT8hJu4VH0E5AlvaXIxQJntxrIpk8T4jSp38JWHL8G7sN+SMgjXkIua57Vy5FZp
	zUWfJ5cvUzvu2PnWyvhSkGRK8eHVmTNuMWppPD0Gh4KpbOX2sL7KUlfr7HJBNkDnstqYk1tKP3M
	J53eeudqmKUuB4vNPSD4jLHLRqU=
X-Google-Smtp-Source: AGHT+IHKfrs4FETuoSjUaKGkOVOod6jMEGCivG1TYtrtM3L4Cegl83GReBakCUd0Jg/vqR4qQAqZ5w==
X-Received: by 2002:a17:90b:54d0:b0:2f4:47fc:7f18 with SMTP id 98e67ed59e1d1-2fbf8f32cddmr17994333a91.10.1739554612431;
        Fri, 14 Feb 2025 09:36:52 -0800 (PST)
Received: from thinkpad ([120.60.134.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98f0facsm5470601a91.23.2025.02.14.09.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:36:52 -0800 (PST)
Date: Fri, 14 Feb 2025 23:06:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>
Subject: Re: [PATCH] PCI: brcmstb: Adjust message if L23 cannot be entered
Message-ID: <20250214173646.gnq2xz3zwxgguqqw@thinkpad>
References: <20250201121420.32316-1-wahrenst@gmx.net>
 <20250208102748.2aytlzgzbvm6u4vi@thinkpad>
 <32e74c11-d6cb-4c42-b9e0-a52bab608c16@gmx.net>
 <9d7ddfdd-4355-4566-a160-770c661281a0@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d7ddfdd-4355-4566-a160-770c661281a0@gmx.net>

On Thu, Feb 13, 2025 at 07:59:38PM +0100, Stefan Wahren wrote:
> Hi Mani,
> 
> Am 08.02.25 um 14:22 schrieb Stefan Wahren:
> > Hi Mani,
> > 
> > Am 08.02.25 um 11:27 schrieb Manivannan Sadhasivam:
> > > On Sat, Feb 01, 2025 at 01:14:20PM +0100, Stefan Wahren wrote:
> > > > The entering of L23 lower-power state is optional, because the
> > > > connected endpoint might doesn't support it. So pcie-brcmstb shouldn't
> > > > print an error if it fails.
> > > > 
> > > Which part of the PCIe spec states that the L23 Ready state is optional?
> > tbh i don't have access to the PCIe spec, so my statement based on
> > this comment [1].
> Please tell, how can we proceed here? In case L23 is required by the
> specs the driver also need adjustment.
> 

I don't think the spec mentions that the L23 Ready state is optional. Atleast, I
cannot find the reference. In that case, I do not see a reason to drop the
error.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


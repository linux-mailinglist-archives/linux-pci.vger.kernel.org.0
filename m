Return-Path: <linux-pci+bounces-4253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA5286C929
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 13:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5C71F23D57
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 12:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9187D07D;
	Thu, 29 Feb 2024 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vUeuY6m5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DD47D076
	for <linux-pci@vger.kernel.org>; Thu, 29 Feb 2024 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209466; cv=none; b=V8u1KRZkajTvwqCdl3RYohCV6mN1P0IF2Ehsa9TF32tjARE9qfcDdx4EA1bFvUZ4NhJhfgzFHKFn2Rx11ODCQjatK8g5tK9BtTHpZhoBi1omP1to607FmW9l72l50QVpqIpgFZ/vz3ZGqDQE4CkHsgWTal6D+7q09sV+bwhJYF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209466; c=relaxed/simple;
	bh=UVFj3luf/OuM91FWElqtuQGNABlen1dm7mEO60GN/Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6uFqzwKLo8MubL2+IDKQYSMAStOUBaRYyhJx3wTOcez+P3Tl1gC9qKbl4FCxBB46krHGZDjzMEG30k5nc7jYF56dhXT74TNrPb4pb0j7bvsR+kW/7NjSRAaK+PJik3xGsW/qO6ZGmhvFruiekA++6WjnB6N7/ZUgUjXJB52RBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vUeuY6m5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc75972f25so7592125ad.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Feb 2024 04:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709209463; x=1709814263; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z/nBppKZ3Dwmy8fY3Oq9whnruT6TOvjmy9666RwwKe0=;
        b=vUeuY6m54i2RXwqNUpa3DRH9yf2SGJ1QsgZGKwt901bYIxqhDFvWajcxzzl9BaiCOp
         N5r1lq4dZPQkO8e5QbgYfEePBy07meISMpPwkTz56WXaMCrvJ2Ndl5C17ttQmRJwB0HT
         wt4gXP7zyIEW7u5gprwBJmAz+/Y1Y1nqxDKQVx9opqGrg9xK1cxTE/LGcxPIpuQBOwfW
         iNzyhxYZo5+rb91/ridfsXOdGZeQ2XJ0MmGZUSZprcq/xJnO9l0TvaZ1QWtQhZ5tDa1R
         iyzah07ay0IR0MeKSWNYoecN8yYvjBvVVKg9McvZT1StV016D5/B2dCnFx+gxDqq5eob
         FLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709209463; x=1709814263;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/nBppKZ3Dwmy8fY3Oq9whnruT6TOvjmy9666RwwKe0=;
        b=ii+3fJdwdpbhcaCJBBrfXZbx6QUS8QtRv6wT6dWUGdnIOkrHCUqRT4IAxcBigzdrj/
         CoEtW92az3/N9n1sBXJmzUBItU+6B1QN9eEbR0S9ED+zlSabs3r930YYJQ+hzcFS0Hjy
         9GGLGMUJCrBQrB4NIoTbTPFiAKhRQI33kuyFlGZayZdnWZnycTFGjSlQsAlrNRxB0Rtc
         0muFI1ZU9+T9E8U8bfGh9Ji4hsz3lmQ7de2bnz9kKgt/S6m9WWzAhWXXL0UsyiZ2Xtcm
         LISISGDdmJOytWM0pTzr26sKzpX8O6YaaOjCVjSwcR4i0l5+DCef7/uC+FjCh/EichoF
         IYsA==
X-Forwarded-Encrypted: i=1; AJvYcCXFgSsiDew7Xj5vXxMsJnwzyS2pxmJOhrGxT30baOxiqbK31ct7LXF4VptW6+gy6yijSIrBQ2fTODAQG+zwhTBOg4KMHo/+D2zt
X-Gm-Message-State: AOJu0YxN9ksnmLAira7WlSHMv40lLMhxNKzkBAok2L/kZRDTxeicQGAX
	kfmzTEe70k/Tp/FH21vu42eFlAjGWXC69cyHvQj2McehFRrwM17vF7gsTHlrRQ==
X-Google-Smtp-Source: AGHT+IFEVW7Kzc/Sh0a1jwwbAk+Ml43zuYzKP023Jb88MYhJZ9kS3njjyEQ94jUlpEOmUZuJeABesQ==
X-Received: by 2002:a17:902:db0e:b0:1dc:c9a8:f164 with SMTP id m14-20020a170902db0e00b001dcc9a8f164mr2074075plx.2.1709209463511;
        Thu, 29 Feb 2024 04:24:23 -0800 (PST)
Received: from thinkpad ([120.138.12.68])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e81000b001dcc1a4631bsm1331627plg.2.2024.02.29.04.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 04:24:23 -0800 (PST)
Date: Thu, 29 Feb 2024 17:54:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] arm64: dts: qcom: sc8280xp: PCIe fixes and
 GICv3 ITS enable
Message-ID: <20240229122416.GD2999@thinkpad>
References: <20240223152124.20042-1-johan+linaro@kernel.org>
 <20240228220843.GA309344@bhelgaas>
 <20240229100853.GA2999@thinkpad>
 <ZeBbrJhks46XByMD@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeBbrJhks46XByMD@hovoldconsulting.com>

On Thu, Feb 29, 2024 at 11:25:48AM +0100, Johan Hovold wrote:
> On Thu, Feb 29, 2024 at 03:38:53PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Feb 28, 2024 at 04:08:43PM -0600, Bjorn Helgaas wrote:
> > > On Fri, Feb 23, 2024 at 04:21:12PM +0100, Johan Hovold wrote:
> 
> > > > Johan Hovold (12):
> > > >   dt-bindings: PCI: qcom: Allow 'required-opps'
> > > >   dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
> > > >   dt-bindings: PCI: qcom: Allow 'aspm-no-l0s'
> > > >   PCI: qcom: Add support for disabling ASPM L0s in devicetree
> > > 
> > > The ASPM patches fix a v6.7 regression, so it would be good to fix
> > > that in v6.8.
> > > 
> > > Mani, if you are OK with them, I can add them to for-linus for v6.8.  
> > > 
> > > What about the 'required-opps' and 'msi-map-mask' patches?  If they're
> > > important, I can merge them for v6.8, too, but it's late in the cycle
> > > and it's not clear from the commit logs why they shouldn't wait for
> > > v6.9.
> > > 
> > 
> > I'm checking with Qcom HW team on the ASPM behavior. So please hold off the ASPM
> > related patches until I get an answer. But 'required-opps' and 'msi-map-mask'
> > patches can be applied for 6.9 (not strictly fixing anything in 6.8).
> 
> As I mentioned, the 'required-opps' binding update is needed to fix the
> missing OPP vote so blocking the binding patch would block merging the
> DT fix which could otherwise go into 6.8.
> 

I agree that the fix gets the priority. But some maintainers perfer to merge fix
patches _only_ if they are fixing the issue introduced in the ongoing release.
But if Bjorn has no issues in merging these for 6.8, then it is fine.

> The 'msi-map-mask' is arguably a fix of the binding which should never
> have had that property, but sure, it's strictly only needed for 6.9.
> 
> And Bjorn A has already checked with the Qualcomm PCI team regarding
> ASPM. It's also been two weeks since you said you were going to check
> with your contacts. Is it really worth waiting more for an answer from
> that part of the team? We can always amend the ASPM fixes later when/if
> we learn more.
> 
> Note that this is also a blocker for merging ITS support for 6.9.
> 

I got it, but we cannot just merge the patches without finding the rootcause. I
heard from Qcom that this AER error could also be due to PHY init sequence as
spotted on some other platforms, so if that is the case then the DT property is
not correct.

Since this is not the hot target now (for Qcom), it takes time to check things.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


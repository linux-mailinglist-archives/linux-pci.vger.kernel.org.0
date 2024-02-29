Return-Path: <linux-pci+bounces-4259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A505886CABB
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 14:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C0E28535D
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034CE12AACE;
	Thu, 29 Feb 2024 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Owc2hXTe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F240128820
	for <linux-pci@vger.kernel.org>; Thu, 29 Feb 2024 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709214856; cv=none; b=umRmqpz4qvwnQpS+4reLbvwLtYSx2Jm8D5qiw1MyDHtWxNMLG1LMP4s/qUcZeNQG1n0GarsvJBc2uLQw8dVQD0vN6u0u6nfqNeRHAnmPWWe1eDgE0CerHfzBIwKylCR6lFbNsCEP+92iZYpqqXEM+/5bWlSkIOgskU6PGyMSJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709214856; c=relaxed/simple;
	bh=v7AgUbrbTmOdYPgovbts9D0RiAJ9tLCiiQRNel8KPYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wbuj+pbdOv8SOT8nzFhFfFNRUrNNK/vBT9o/ZaFT3jNwb879g8A/JsRnLyL/XFRiy3hokrYv5y0WlR6Gu3XR7N1lKhRAtu8zxWwNZVQ0D/NMUCQXPSNanFGSQL75ZDzpPaLx9N5s/SY29Nlmb7oi9BfAK2bB8eXvWPnDE+SOnFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Owc2hXTe; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc1e7c0e29so7838845ad.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Feb 2024 05:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709214855; x=1709819655; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KFi6owlquWpJybLOnBr0GE/gVglg7A135XAv9MGMZ48=;
        b=Owc2hXTe60+izH55CjRTO9K5aSUe3JuxD9OZJ8NjdfVgwMV45B1Oz0/+qXqqDxZ2Z+
         lEZklQlNx0rmhyUZ9RV/rWIdZu650LThYHt8hlvLIq5Lm+TlMinxoQHnI9NnoH0uoTbf
         UKkPPsFSerWzwWmuw34xCccLCeh5GS4Fvezjsk5SciTYI2i7ikmGWce5Np6xVRp8ROKb
         TpGZuTyyo0xOGvDWkt9ac+OEHIV90irQFUbG1jlEXvuH/UM5rPV3XefJeLo8x0MxIKU1
         g7k5a+4Qx2ZcKYgc3q9HSpzN2Hed1qbebTUfkz8Tl+r5FMmoaZX9oSb5VD50tKL7xAYh
         tzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709214855; x=1709819655;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFi6owlquWpJybLOnBr0GE/gVglg7A135XAv9MGMZ48=;
        b=jwGw4o3d0XsNzmn85O7o4URDzudXlWNctpkfwbl85vX7gHfzQ5lLSf0AGhzQ9DjNAu
         Wo/GIo5/f6Y/UtimwMBM+HHbxhHp2m4d99dOKl0Em86Un/k8J4d5Y/KI3aSpeFNyMSOu
         sRpcpfyHU3ujk0CLX+wtPonuX3bz0JA6cUY5jKmW90YaidVgpFbiKgSUoR33DdM/FTHW
         U0Vuw6wFETa5s+4dpURJXFWrldqh/dkYwYY1bZjLIW/eNK1pLQsfKzNa93T1OfeXgEnr
         X9K2Q/XScuYPJ6pGQx5zhYLsEm1Fm84qR9rUqd7DQyX5LK+cDHnSvAV1bCXgv6WlPCVU
         P8eA==
X-Forwarded-Encrypted: i=1; AJvYcCVunTQZx0TbPvTFjduXmc3YYpR391j/ixR/OQj17d36RoSwjP5rCxWR2/hK0KNaWS8gA4wp7t85GR7LysluOQjPaQJwU+QOUwDs
X-Gm-Message-State: AOJu0YwlHtFGxBkmm5G7nSd20A+qcOjmElqMFO34fELxfWa/05Wz5BAV
	WIZ6nOaC/uFVRO/A20DeFpMDpII1yCnFYXp3dWXhFe0+21wcioZX61D4L/+xbbmhFYzeT7J8G7g
	=
X-Google-Smtp-Source: AGHT+IHXl1bXWdS83nD1wqmxu04C1/sqKau8el88o5dRrtYuWLXqrfk+s6o/thw3Tq79HKdbJHBzhg==
X-Received: by 2002:a17:902:c406:b0:1d8:ab27:d76c with SMTP id k6-20020a170902c40600b001d8ab27d76cmr2414876plk.51.1709214854696;
        Thu, 29 Feb 2024 05:54:14 -0800 (PST)
Received: from thinkpad ([120.138.12.68])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b001dca9a6fdf1sm1484066plj.183.2024.02.29.05.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 05:54:14 -0800 (PST)
Date: Thu, 29 Feb 2024 19:24:07 +0530
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
Message-ID: <20240229135407.GE2999@thinkpad>
References: <20240223152124.20042-1-johan+linaro@kernel.org>
 <20240228220843.GA309344@bhelgaas>
 <20240229100853.GA2999@thinkpad>
 <ZeBbrJhks46XByMD@hovoldconsulting.com>
 <20240229122416.GD2999@thinkpad>
 <ZeCCPRVvYCNfMYnd@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeCCPRVvYCNfMYnd@hovoldconsulting.com>

On Thu, Feb 29, 2024 at 02:10:21PM +0100, Johan Hovold wrote:
> On Thu, Feb 29, 2024 at 05:54:16PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Feb 29, 2024 at 11:25:48AM +0100, Johan Hovold wrote:
> 
> > > As I mentioned, the 'required-opps' binding update is needed to fix the
> > > missing OPP vote so blocking the binding patch would block merging the
> > > DT fix which could otherwise go into 6.8.
> 
> > I agree that the fix gets the priority. But some maintainers perfer to merge fix
> > patches _only_ if they are fixing the issue introduced in the ongoing release.
> > But if Bjorn has no issues in merging these for 6.8, then it is fine.
> 
> It also depends on the severity of the issue and to some extent the
> complexity of the fix. These binding fixes are certainly low risk. :)
> 

Right.

> > > The 'msi-map-mask' is arguably a fix of the binding which should never
> > > have had that property, but sure, it's strictly only needed for 6.9.
> > > 
> > > And Bjorn A has already checked with the Qualcomm PCI team regarding
> > > ASPM. It's also been two weeks since you said you were going to check
> > > with your contacts. Is it really worth waiting more for an answer from
> > > that part of the team? We can always amend the ASPM fixes later when/if
> > > we learn more.
> > > 
> > > Note that this is also a blocker for merging ITS support for 6.9.
> 
> > I got it, but we cannot just merge the patches without finding the rootcause. I
> > heard from Qcom that this AER error could also be due to PHY init sequence as
> > spotted on some other platforms, so if that is the case then the DT property is
> > not correct.
> 
> I've verified the PHY sequences both against what the UEFI firmware (and
> hence Windows) uses as well as against the internal Qualcomm
> documentation (with the help of Bjorn A). And Qualcomm did say that such
> errors are also seen under Windows on these platforms.
> 

Well, sometimes the init sequence published by qualcomm could turn out to be
faulty. That's why they publish v2 sequence and such. And I want to rule out
that possibility in this case.

> But the fact that the symptoms differ between the CRD and X13s, which
> use the same Atheros Wi-Fi controller (and the same PHY initialisation)
> also suggests that this may to some extent be due to some property of
> the machine.
> 
> Notably, on the X13s there are lot of errors when pushing data
> (e.g. using iperf3), whereas on the CRD the are no errors when running
> such tests.
> 
> When leaving the CRD on for long periods of time with the Wi-Fi
> disconnected, I do however see occasional correctable errors.
> 

This may be due to hardware design that I agree (possibly influenced by driver
defect).

> > Since this is not the hot target now (for Qcom), it takes time to
> > check things.
> 
> I think that based on the available data it's reasonable to go ahead and
> merge these patches. In the event that this turns out to be a
> configuration issue, we can just drop the 'aspm-no-l0s' properties
> again.
> 

Well the problem is, if you are not sure, then adding the DT properties is
certainly not correct. As that implies a hardware defect, but it may not be.
So let's wait for some time to find out the actual issue.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


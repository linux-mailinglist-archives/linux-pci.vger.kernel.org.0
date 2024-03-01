Return-Path: <linux-pci+bounces-4322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3EF86E0FF
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 13:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51EBB288819
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 12:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD6A6E613;
	Fri,  1 Mar 2024 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFZyELV8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064DC6E60E
	for <linux-pci@vger.kernel.org>; Fri,  1 Mar 2024 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709295856; cv=none; b=hMks3kMaFk30EQdfWdv3ULvybPwN36oW7+Lw7loQ6MkJM3K2ZOkGBfx74SnT3DaL4kBXEsQjrQoJFcCYSNoEboW/CAqCHkFE9q1iuboV0yd8M/2XrNBo+sS1Nd1LRx8SK/wdmZCFPnOT1Odra9cPAc/pe+fmIg6RVfKhQghn+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709295856; c=relaxed/simple;
	bh=GeK7NXU8+bwfBSHzsZlUNBLhTVjfM+PRqah5iO9UP7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CavHTVz4TeBSYae/AqQyZcGKH4wo6sn67r2w9OI9RK/ACONtOjPj7sSTRLV4HOGHHBu+fbPorDWJURwv1eLHBJM3+DkItGrOkSMDOzXEP/40MX1IBj9E299pxVvJLvJ3LW5QLTSCdwIIcC/FMC9jdhxIvEKLWZlXGIezGhYJZ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aFZyELV8; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c78573f294so129304239f.0
        for <linux-pci@vger.kernel.org>; Fri, 01 Mar 2024 04:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709295854; x=1709900654; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/b5kEb7iwEP3csgzWIGJ8JouHXy+H/cUYJXmmRjhdKE=;
        b=aFZyELV89/ojTEZjsaa6LrmkxmcsyGsIIv4IfcnBC5zUmeTiOTe1EYaHtJGWP+goDe
         Myy9og1eWl+voL2fSpJDp3FdKtK+Q6UCQJM+1emF9oWo9dEY4bzPkEjzqet65QFHramv
         yBkfpJtsmcQXtdkkYQNSmpHcNuZiJ1t9EmUXufby7xGTbjxhOzBvfdwJ9wqBByLE1wbU
         olz4U+GHwJcMwtvmJpTYK2Gc+DOjVCv6w1O/D/F5fmwa9KIXVMZNMVT0sC41C5pnLmV1
         TTBAfMXM+mpMFxdidYD0X2PNLoOOVJq316pphS2+59mWcAPW6+Z5t2X2ajcoKQPPE9lp
         ARMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709295854; x=1709900654;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/b5kEb7iwEP3csgzWIGJ8JouHXy+H/cUYJXmmRjhdKE=;
        b=ZiP472djrddCQcGAR7kNJ26FfEk36/dBYgiF1Nlfzu29Xg1e4WNADSyKBhetaGDXYd
         iJJIH8as0Llm5zSqdskgDQudlPPQW0GkglSOxM6ZukXaurFO17zulu4S2gH6vF8HLXb/
         Rec2iUFdgWjRArpZFKO1yCIaXbaF6mw7dCFhs4ICMkCtvNjoX2xt+lkccNOoBIkb3JEK
         RA2ICd5FkcifTnpFSvIvGo/IHEQR9zRLBlWVkdIYxJz5sQ82PY4+n6emlZa7QWt4UEhS
         R98J0TEXcL354JeYTHzT8doB624D2RfGrEhUnSzimc6hS4I9u09UlcCyFg3Ps4yfZO9l
         /poQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo6IyW9tyDBXvQNRZThjjWD8z96VO0IT8hchM8ggbLFA2up6cXO8G36G348vMBPXrzmOU6LcpV4uGKQb+T5eugFpMt8u/DycXJ
X-Gm-Message-State: AOJu0YwkDizYf6YJp++5mIvHSjLqRylTPYpBZ9jtXUCOsRGFmprjnCg0
	FlfyaKicxtuM4m/41clWIJ+ldn4NK6yfOIGd9HjDqCLMSbruqOtegeCJnhSYPg==
X-Google-Smtp-Source: AGHT+IGjonEgf53n7CtJrGJKoHCICELzX7ssAuT3mNd1cdbBKw/KgfiA65RmCI0QdqSvYfVXPwiQRg==
X-Received: by 2002:a6b:ef13:0:b0:7c4:9c09:218c with SMTP id k19-20020a6bef13000000b007c49c09218cmr1513631ioh.7.1709295854030;
        Fri, 01 Mar 2024 04:24:14 -0800 (PST)
Received: from thinkpad ([2409:40f4:13:3cbc:2484:3780:dcff:ebcf])
        by smtp.gmail.com with ESMTPSA id l20-20020a63da54000000b005cd8044c6fesm2934212pgj.23.2024.03.01.04.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 04:24:13 -0800 (PST)
Date: Fri, 1 Mar 2024 17:54:06 +0530
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
Message-ID: <20240301122406.GA2401@thinkpad>
References: <20240223152124.20042-1-johan+linaro@kernel.org>
 <20240228220843.GA309344@bhelgaas>
 <20240229100853.GA2999@thinkpad>
 <ZeBbrJhks46XByMD@hovoldconsulting.com>
 <20240229122416.GD2999@thinkpad>
 <ZeCCPRVvYCNfMYnd@hovoldconsulting.com>
 <20240229135407.GE2999@thinkpad>
 <ZeCktwcEFAfCEVkV@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeCktwcEFAfCEVkV@hovoldconsulting.com>

On Thu, Feb 29, 2024 at 04:37:27PM +0100, Johan Hovold wrote:
> On Thu, Feb 29, 2024 at 07:24:07PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Feb 29, 2024 at 02:10:21PM +0100, Johan Hovold wrote:
> 
> > > I think that based on the available data it's reasonable to go ahead and
> > > merge these patches. In the event that this turns out to be a
> > > configuration issue, we can just drop the 'aspm-no-l0s' properties
> > > again.
> > 
> > Well the problem is, if you are not sure, then adding the DT properties is
> > certainly not correct. As that implies a hardware defect, but it may not be.
> > So let's wait for some time to find out the actual issue.
> 
> Our devicetrees are always going to be a tentative description of the
> hardware, and this especially true for Qualcomm that don't publish any
> documentation so that people are forced to rely on informed guesses
> based on downstream devicetrees and drivers and reverse engineering.
> 
> As far as I can tell, after having spent a lot of time on this and
> checking with sources inside Qualcomm, the hardware is to blame here. If
> this turns out not to be true, we can always revise later. We do this
> all the time, as you know.
> 
> I'm all for digging further into this issue with the help of Qualcomm,
> but I don't think that should block this series as that would leave the
> link errors that we hit since 6.7 in place and effectively prevent us
> from enabling the ITS in 6.9.
> 

Sounds fair. I will report back, perhaps with a fix based on what I get to know.

But I think it is better to disable L0s in the SoC dtsi itself. That's not only
because there are patches to essentially disable L0s in 2 of the available
platforms making use of this Soc, but also you are enabling GIC ITS in the SoC
dtsi and that may affect sa8540p which is making use of this dtsi.

The users of that SoC may have not noticed the errors as you did before, but
enabling GIC ITS will certainly make the issue visible to them (more likely).

Also, if it turns out to be a hardware IP issue, then we can leave the patches
as it is, otherwise we can revert them easily.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


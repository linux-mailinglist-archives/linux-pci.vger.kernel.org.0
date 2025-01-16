Return-Path: <linux-pci+bounces-19993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F362A14066
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 18:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4340A7A1F39
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 17:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E14822BAB0;
	Thu, 16 Jan 2025 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZHiaE2r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983E714F9E7
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047425; cv=none; b=uKQKbW3uYMC4j82FWQr1lvmmi3q+BA3KN9Z7cgKQWXsY1TtH9TyF4VaJJGg3YzvZCN5oJludXbvMDElz/PG7/3jjAEDPcVtVJ+y74PM/7QEJXejgR+XB4NDK9Uihv0W/USMJRiiZD3q4D6jeGlJHH9vT508Xdsz0Rn4HUJ3bc2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047425; c=relaxed/simple;
	bh=0+csCrr4692adIibOQFpvzflsWpcZWDhPh+l7iT1Y+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv0x+v2mC4fGZJo3ZdKM5vYltmbvEosUEd7Zbe/jcK8QtZNXAo4Ernhe1y4fDilQxsB7IYHE3edNrlzOsxnol8A+lbkMtn2HCvWYtJSTv0LNcCnfAb5ItGE93391eelVR5mv2uhT/nJySpZUgauZtfHajKwY9nN3rdEpn++AnTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OZHiaE2r; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21654fdd5daso21102515ad.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 09:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737047423; x=1737652223; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3a4fDQ0edVO3KpLvTInYDMVl/7bZp9NSvT62CDgMNsw=;
        b=OZHiaE2rbNS1j7Yja9O1128UWg6xu6AsmoQu95fwchLzny59DkMqHjuhcZ5ATgOwPL
         e2QUc9NlqvH/w60MgqttRvAl7ZZ4LK4SB8g6CObFPCEpwRZTDh3ARl/fcN8Hpzh786m5
         qgH3q5ekB1Lwoe/2+99qDmll6WG8CLqpzj3C4JsOm0RAeao218ipawLCRiBZ7TSWSJpu
         uE64STa4Z7nQXMf1E90bNAL9DDLT+S+pfI7mNJQNhk3m+D+k6UaF9ri0gxLBG5GCnGDT
         NCIi9DXZECwGNwuk61INsP1viXm74lktMzJZYmgwoORMZnJM46HGAOFUFk0Ce98p62Il
         02Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737047423; x=1737652223;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3a4fDQ0edVO3KpLvTInYDMVl/7bZp9NSvT62CDgMNsw=;
        b=VwBJt6qOSuTExodb3A9F+VU+ame78bLLB9PPy2mQj3zmLUM2CMdGs+8hzC/Bhb24YB
         U3+PsxL3Uxzqm7uUQWEEAc+aKFFwD13ve0i8Fk4P+YcXivC6G9x0aFQcaKRNPUzob8g4
         jrgQLnFSZRpcl951GpWEOrWP35fYvM6Rjrd55KQVxiUu4BlJSsDeETQFSYa8PenX5rrh
         b35koxg0WUq7uvPPfKNtFZpNp3l7ihoOiY6tFPpwcBHIT5VYL1/2O5I9uti9OPeM5DcH
         iqhh6K4HCDweve5zC9cjVIMMWk3X/nkk9VV2GGleIFCIJBIbH7ORFWtbXAWELnKilbif
         MNKg==
X-Forwarded-Encrypted: i=1; AJvYcCUKwJqFqkxKwPSTvaDtf9P1b71jQ8AH/cE2TS9iTHW3OoENjASGEKInp8Lp5v93T/zCaFx33tgJ3Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw7L2NlU7hWaY+6ZrQnDoGoU0JJlCL23lEfLezSptasGeXFRKv
	4eyf0HvEl61Q98AAgolehuCJdVDyvX6aZvvLizKHD0gpVkJbZc9j0dJlkTyob3XTMMmXXYYebro
	=
X-Gm-Gg: ASbGnctW6K5BFqWaUMEgaX5bFTlQgJ0AEp9SWb2vK3GeafaVw3cUBKLizwWWS7bUU19
	L6XDQm+eZ4e8bF1Yl+QEMnzWH6vQHQ92yvJaDYNN6y2VoDwAMzGJ41VMvyo8L0UCuHbSHSHB0cw
	eo9Iy6ZbcmsPcP+sylJAbU5oxje6sjc87aTlX3Pb8rzGKYNl14wtuZ5suXgJreAtHOiNRy6CL0r
	AmpUecbxRDZMEXcjJPywpE8zLSMNPhKJu4wxyYWQGa6MzCsO5637Fwnzr/dziOF/bI=
X-Google-Smtp-Source: AGHT+IE6z2dUwqkoyAySw2Q7XUlUMsfTswTyuxhk+t0IYd3aWtK0Xli9iFaSAAV9AWhDsimgl8t/JQ==
X-Received: by 2002:a17:902:d510:b0:216:5568:38c9 with SMTP id d9443c01a7336-21a83f765dbmr532412725ad.31.1737047423008;
        Thu, 16 Jan 2025 09:10:23 -0800 (PST)
Received: from thinkpad ([120.60.79.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdf0b5153sm243379a12.70.2025.01.16.09.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 09:10:22 -0800 (PST)
Date: Thu, 16 Jan 2025 22:40:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Message-ID: <20250116171015.oe67k57qkrg4p3f7@thinkpad>
References: <20250116135106.19143-1-manivannan.sadhasivam@linaro.org>
 <Z4knZyKrEvVNopeX@ryzen>
 <20250116161227.gk2psmbzpexswgrm@thinkpad>
 <CCADFA64-D3BD-4972-994A-48E2606CCC66@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CCADFA64-D3BD-4972-994A-48E2606CCC66@kernel.org>

On Thu, Jan 16, 2025 at 05:39:30PM +0100, Niklas Cassel wrote:
> 

[...]

> So the output matched the suggested values in the documentation.
> 
> After this series, the documentation still suggests msi == 16 and msi-x == 8,
> but the example output now shows that
> there was no failures.
> 

Ah, I misunderstood what you meant.

> 
> So I think it is most consistent to just update the example in the same commit (in this series) that updates the output to show everything as good.
> 

Yeah, makes sense. Let me change it in next revision, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-19971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD608A13C1E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 15:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B60188DC31
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 14:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA4B1DE2B9;
	Thu, 16 Jan 2025 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rFMeNeIR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5B922A809
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737037537; cv=none; b=DzDv2FiXR20fUuAMovrQqHj/jNc1MTNqxIJ/HsJ7FQUn779UJ4cpxCGlBSBPW/tTFFbApQRQFgajAFkHTE4vJQTAClpeFzPhRT7Sht3SNXKvDaDyzUZqhLwqPZUTiG1hPfBMDtHF050/hbjokgiqEeXNl71ft1nzhrJy+k7qrW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737037537; c=relaxed/simple;
	bh=UbcramhTNZwm1De5kbSQfHhfqzuf3BOXMJzCyzfeH0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsSFAf943jrq91vfkK5vAyC4o8xgAhlY2EAIWVgjuyQENtF32/4zGKfzqDGpEV3YvGUYvxIQp4tJRc0cwxYXnSoxBVVR8tZnyH6uq5v1fbC8Qv+a4ZVyFifOGtLSu3RrxmD+f0+hLdAsFG2rRCRoyYPHZ6Hq4bv4hFzCKAo3hIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rFMeNeIR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2167141dfa1so18368435ad.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 06:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737037535; x=1737642335; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z2Z9j1aYx5W0aVpQKQOgcZqB+XkoiS3ovFAP8lFkso4=;
        b=rFMeNeIRpClUrAvx3qdkmaERSrI3t1fCQfsE6IGwWz3sh6SeRyIKmSYK4vvJo409Q6
         VGE8saFxK6XPw1y/0idIeaVxgeErReNzrg/i5gOpOBvluqlHJagFCmJAodVDCEwNTaQH
         VknlqbrA5FlBqyEWrxMZOXPo4S0gXRB6dOQjx7XJ4dGLjfLJlTG+xXfic2N06gxbLqLw
         eg9WeNV0bErWY6vtOobzhNCGx7iKCgmJLpetUDTWqJLnRf/fLNGGwKDgoV7DC98+bHk/
         0Gdtxuy+Eds9bHL+xrzfhw78Av8YUw3iCkDeCLvItxBC0rFuoLEwB64bNVafkmslYxLi
         va0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737037535; x=1737642335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2Z9j1aYx5W0aVpQKQOgcZqB+XkoiS3ovFAP8lFkso4=;
        b=ZOotHPgf2p85QdfMNlvnD7kMTiGjC7VPPZXFnHuAvNySlDTIDZ2FF7CvSAyEsQVxbX
         LBt3Dw1Ugp0Sni13YXiG7uhJjyOOXG5xhugnQR0qlurZMVhNq8F9otY5A4j6ZWiadJew
         TeXQMp+1RG40ieqQbI7yUcgqQfA2dubhcA0p1aU+9TX8LrWZTvd7xXZD4e7/15eBHsWP
         i9QLsAM2Jeyiu4WIuMNbpXGTP3q+5sTeSx404hSnipc8qhfWRqcPldBPSrVft7O0Lql9
         c2mePSqUC/qGOTqPGcxqD8YFd1AYic+yFIXSTnJhmuvBqDyNh58V1MFl9wvc2cPJovKf
         S6Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXjz8yxCnND8DjKqzk/2QVuq3iJz8GWX7U2dZ1qM0Y8o19HlreFDM44OcPD1PCwWvR0kc8i/6Eow5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ30bLXL+5KXiAtooCW6pCAcBgoX0jUBc1DyMWOb7YBddIcIwW
	mr+tNQ4OyWNq7yGcmhtL1TMouu6HwsukhedDPTG7wm90fRUHwL3vyFdK65gksazZlF9iQYL47eM
	=
X-Gm-Gg: ASbGncsRmDmwhOqRL5iEdLwz+9n6JW1SB2thp+xwk02elz/GilOh6gdhcUMRW3GXDS7
	PNsyuFDSw6VvykjSxOfbWNllKb1Nm8THcdCQDVdx2rJD5Txad+aefw7rdPd6oOk1+JZvhyBF9Y3
	NCCjWlpLe3HpTB4yGnFvADBphXWND83K5W2xfkJLUCOw2s2Eo164FScm2hXkrzXb9BmJy3dam0A
	Iyh4Tjhwm0vjqb5ICzczIMutiCA4mG37JViaQX5UF8PUxeAWXOmQRKzFOlN0kUqpQ8=
X-Google-Smtp-Source: AGHT+IHvmV0y3nKp8UlzrzpeoAP/166UVhB4Q6jwoBQbs6VLa4qlDaF1UR71uVnr8ejzUY/LGsTfYA==
X-Received: by 2002:a17:903:1107:b0:216:5db1:5dc1 with SMTP id d9443c01a7336-21bf0b76a05mr108530515ad.1.1737037534882;
        Thu, 16 Jan 2025 06:25:34 -0800 (PST)
Received: from thinkpad ([120.60.79.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3a8822sm929755ad.140.2025.01.16.06.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 06:25:34 -0800 (PST)
Date: Thu, 16 Jan 2025 19:55:23 +0530
From: 'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: 'Bjorn Helgaas' <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com,
	quic_nitegupt@quicinc.com, quic_krichai@quicinc.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific
 capability search
Message-ID: <20250116142523.56l7aqbxk6imafph@thinkpad>
References: <20250115152742.yhb57c6cbbwrnjcg@thinkpad>
 <20250115161201.GA532637@bhelgaas>
 <CGME20250115163012epcas5p185dd4aebcdf093c2760aadea8480b8a5@epcas5p1.samsung.com>
 <20250115162953.yiwhq2m5s5nf7b33@thinkpad>
 <00fd01db67e5$ff8c7b50$fea571f0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00fd01db67e5$ff8c7b50$fea571f0$@samsung.com>

On Thu, Jan 16, 2025 at 12:42:23PM +0530, Shradha Todi wrote:

[...]

> > > > This series uses:
> > > >
> > > >   dw_pcie_find_vsec_capability(pci, DW_PCIE_VSEC_EXT_CAP_RAS_DES)
> > > >
> > > > in dwc_pcie_rasdes_debugfs_init(), but I don't see any calls of that
> > > > function yet.
> > >
> > > I guess that the caller got missed unintentionally in patch 2/2.
> > 
> > Actually the missing caller is intentional. Jonathan rightly pointed out in the
> > previous version that the function : dw_pcie_setup() was being called in the
> > resume path as well and so I thought it would be best to leave it up to the
> > platform drivers to decide when and how to call the rasdes init. Do you suggest any
> > other approach?
> > 

Adding the API without any in-kernel consumer is not usually recommended.

> 
> On second thoughts, I will add the dwc_pcie_rasdes_debugfs_init and deinit calls in the
> dwc common PCIe files but in the probe/remove path.
> 

Can you please be more specific? There are no probe/remove functions in DWC
common drivers. We have init/deinit only. For pcie-designware-host, you can call
dwc_pcie_rasdes_debugfs_init() from dw_pcie_host_init() and
dwc_pcie_rasdes_debugfs_deinit() from dw_pcie_host_deinit(). But for
pcie-designware-ep, you should call them from dw_pcie_ep_init_registers() and
dw_pcie_ep_cleanup() since reading/writing to these debugfs files will cause
DBI access and that requires active refclk. These APIs are used as a placeholder
for code that require refclk to work.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


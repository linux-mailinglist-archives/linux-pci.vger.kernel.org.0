Return-Path: <linux-pci+bounces-27178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0063EAA99A7
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 18:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193F817CC38
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 16:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FC026A1B4;
	Mon,  5 May 2025 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUJEhyGQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE80265606
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463708; cv=none; b=LWuoror7mw0n0Vj69O4PAdAsuPD8a/SCE0YQYzvWKvl1bpt8ZxhKHHlG1T+0BWCwN9N64E31BJOJQxc0WbvxJSLHz3oinqRIU9S06zQIQri8G6clc1ndhAmAFYAET148wWT6tEeU6IMsAMDAear8Zu68oJRMbQ3X2ojanH6rJQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463708; c=relaxed/simple;
	bh=d/w1uLpQ2W4vbRq5UhqvNe4JuFB6ZDEyYHk1OIfpEqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtjpaNjdeyMVc8JXw5Uzcdtc7GoVhhSF1E7CUqiJLPGVS3adPSGvP/O6TROfgeeOP1WYLBGrgWvzMgGJ81frzkhQ3Pj5SHhIEeQWp2zITc1CEdSdQcK0zSf4ppwX8oUSHiObwG1hKUt5rob+v0vZhg65589OQGnyXOSoXgtlxEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NUJEhyGQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso6672071b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 05 May 2025 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746463706; x=1747068506; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jydswAFnXteQh1UU3QGXjNU3hWHc6hixoWxuLW3YU+Y=;
        b=NUJEhyGQBBoePJ8nFckLgad904tYAh3yKDPsPTjUVd7f+2IG/RTgFLpWf01/Lu2sSk
         OvC5dDjpFceIvjDNgSA31UgRinUaTWl74wdX/Ig/KvvYnADX0jdruzMKVDSFvCjt0e90
         UNv4LGj4zzL+glt3gycV/6xZm8uckjhkNc/+jP1vDbzNnQpgwnH8VTXOfweT/RjFqxFq
         9iCy6IwDcRJbMOQOzRgySHr7GpseVsvcJWfQhB8wkbam3RNEVqQRX+CuYb1fZGdSDC2S
         ZMGraRdSW7WvX4AJfETAY1Q5E2vErRqZZnPILThE29oSZJ0bt1C1SLpnLI5e510qQkIx
         VYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746463706; x=1747068506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jydswAFnXteQh1UU3QGXjNU3hWHc6hixoWxuLW3YU+Y=;
        b=nj4EE9tpYg1aY54c4yJSq479L0EUJ9DcvlId+DHy2l1uW5qSeSfG6Tsyb1WO7ryAjM
         l3PGE5lELUzyLLc+bVnq2DXacHWZ0YD2kaEiug28zserelB5gp5cpPfVzSAi6FkTI9kP
         XyuQe/oAzE6A7mY33/cyOuQqxzbJS5KdjfebsBLQ/FCcuDYvFDSPc1vtf3gTLmW24f/s
         xpjI+1R3sAtCUuREsi7ZW3HIIOvdtDwRw8G5/FXQbJqpbntKJbe1kng4fRroTD9ZYmE0
         njLnhsN+wZC8MZpRDUK6OQ0dMoTUvk8HjQuqRYINtvp3wvQkujqYrE53vK+ulDmDNcvY
         qK9g==
X-Forwarded-Encrypted: i=1; AJvYcCVTztx9gZMwXeEAVmj/fZ7nAVFCwqU6BbdFu6s5MdNc5/GVAchpzAmsvCWzHw3wsAo8pY0pCo+StHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5bDJYvy/JpFFBoXPKUHUR/SVedogSepKHzL9V5JCYYZYFoGLF
	m4Dx1JPePEE6QKMaPI/kC4kWi3we7kHnk/Tnf1mRLf6RDxXdfck2ivqYtjUY+w==
X-Gm-Gg: ASbGncsUPSET8dEGE9QqTrB5oPTnQNQzJhPOYUwysGyDtc+G4MvqdshgJc1J9TfpxGN
	4hzc1wqrf83pD3qGsTLgK0btTM3rTUBxNTM4gv2PGYeWnlxUFkpbNtsYsICp7Edg55PR5iXpPil
	rXltRar2ak8di+DBcWVpyKZ6CYC7JnpBuO2fbLwV193eV/KILbxAnnrZCLspIyyLZAgKrx+l6gY
	D35O3dExA8sTyRsxTlqky0pkvEa26sK3aMWJdjJ0Ib3h2ufizff3GJPXrbt529hRbI61qHuMbev
	l0ZRD52vhYmp1bfhCk79eSiEt3/Kh5vpJ8flfR/DHwpJ0hgm130=
X-Google-Smtp-Source: AGHT+IF0IGm6fDHGPK66O6bg5JTvgXJJb1FD4//3SnxAo7KjM8JdSqs+9ux0Ap+T+I2E+83jN9O/IA==
X-Received: by 2002:a05:6a00:4408:b0:736:3d7c:236c with SMTP id d2e1a72fcca58-7406f0d5d84mr11288854b3a.14.1746463706657;
        Mon, 05 May 2025 09:48:26 -0700 (PDT)
Received: from thinkpad ([120.60.48.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740590616ffsm7268130b3a.140.2025.05.05.09.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 09:48:26 -0700 (PDT)
Date: Mon, 5 May 2025 22:18:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] PCI: tegra: Drop unused remove callback
Message-ID: <gxbuvopbhum3v622gf4olzfspgihxt3dm4z3rsj4gquaabt2c4@peemxrxshjuu>
References: <20250505-pci-tegra-module-v4-0-088b552c4b1a@gmail.com>
 <20250505-pci-tegra-module-v4-4-088b552c4b1a@gmail.com>
 <idddypjxxtiie3tllfk47krcydlno4lnhbkik4wakekcyu7c2d@iurtu6bjzeey>
 <CALHNRZ88VaS6zmmnkQg_WrBVPjMT4e2uPUPEQUj8ARL1TieZPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALHNRZ88VaS6zmmnkQg_WrBVPjMT4e2uPUPEQUj8ARL1TieZPg@mail.gmail.com>

On Mon, May 05, 2025 at 11:43:26AM -0500, Aaron Kling wrote:
> On Mon, May 5, 2025 at 11:32 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, May 05, 2025 at 09:59:01AM -0500, Aaron Kling via B4 Relay wrote:
> > > From: Aaron Kling <webgeek1234@gmail.com>
> > >
> > > Debugfs cleanup is moved to a new shutdown callback to ensure the
> > > debugfs nodes are properly cleaned up on shutdown and reboot.
> > >
> >
> > Both are separate changes. You should remove the .remove() callback in the
> > previous patch itself and add .shutdown() callback in this patch.
> >
> > And the shutdown callback should quiesce the device by putting it in L2/L3 state
> > and turn off the supplies. It is not intended to perform resource cleanup.
> 
> Then where would resource cleanup go?
> 

.remove(), but it is not useful here since the driver is not getting removed.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


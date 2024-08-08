Return-Path: <linux-pci+bounces-11470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E1294B55F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 05:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60929281F06
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 03:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0CD1119A;
	Thu,  8 Aug 2024 03:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnF4M9JL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127B80038;
	Thu,  8 Aug 2024 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723086845; cv=none; b=qVT5R1eoHfdxW2OPzY9CberABfF8cj8TeHQYCgsZH7y86SSw7vYVw7gf7Z8PKAyfq27a8aVNqHQeSG0M3Fu04aFZy/1W3HULCfr9UMxKg/YqREGL2ETijNushyR6LNGTZdYMFlYn5KVYk42TTPvWw6zWnC0YA7DlV3NK2Gj0Gro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723086845; c=relaxed/simple;
	bh=KT4VsCnIfwObiJYulzkkhzxsdYGyRi2W3HStt2Oprys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csxOTAlygSwOfB1RqTJYGg0pq2dnbFvwrPWj7Iw1BtSNZ0Xr4VV1FEq/Z0uracNcfCKj4RNcnM3Hn+KMdnWI14l3j5izJLxXY5IuhXKmjiSwaI4Mbq0JW54HTEe3ljn4KARKcLzWtHdJfif3o485EZqksHkI7MY2p3U/qO2ExAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnF4M9JL; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db14339fb0so319831b6e.2;
        Wed, 07 Aug 2024 20:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723086843; x=1723691643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oGxsg41y4rKazgGVMxhE1DY52aSncTPaS/Nl+tX3Jvg=;
        b=MnF4M9JLrlcWybUQPuc5q5SLvWVJD452pW0PWsu1CZ3QwSTCb++SahyBFQbO4htNx7
         oIkOYw2SktSc8xawkslhw54d8pdE2oTfy0wSDko5k1oyNOy+P/xRI7f52ABE9qYkFFwG
         thzlY6Ib3Z+gSVjg6NoxHJ79bWgNZyj5JLVvDZtOF+rUh1iZvZB8tQmuXaVqSAeGNXhk
         9Gz5KYajRDB4a5Pc0pSM4T+4d06SG6NvMgGOS7d19ALPSnJik4iDQfU/hcBgNT3yONJL
         ZOx3sOkPWzp7yAwfPIKpj5Exd6LKEoHNW2iVcR58HWfLTewdNmNJsTe2q+zSIXkQjkMo
         6RjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723086843; x=1723691643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGxsg41y4rKazgGVMxhE1DY52aSncTPaS/Nl+tX3Jvg=;
        b=r+zL1Kd8OR/EuestZIqwm0i6mj0EwfyXcLy9Xaq5crowksMT0pTrUdgAKh6ERQf5Zw
         z87syoPl8TeCFTFtKyIZjsu7iEVY48PddSyT8aqPF1rq7WCZi+CoQ84bEDkim/oh+Y6/
         3BORAlKTokjAiID4mNKIQeBvNFjvNqCA0jT60FW9+PoDkdlneJcUmVDJqD1PmVep1yW4
         E2SnxNWR0L77dQm9vZ2u272vLCWicMDOVn2/FXIRXQO8o+AuaWvtovmCs5IQEK7jv1CX
         3lbnSx9Ljgfw/TbrXjgQNd3ZZV3yoenFappVUjYAnIYgsLEA6vduSEjxeVUFUQ8pXvRO
         hsaA==
X-Forwarded-Encrypted: i=1; AJvYcCVbofD62O4jTj9/S/6lQzKdj1WRsHnGUQG2sRx8ICdjDrYigVHgVitDZqR0Lw+tf+GlPUBU63RzrZFYiuJU0t1/CE9nv88TuUzqKw+QMkfWVzOWKFSwJoDEOTSt2aOcwqBTA1Iau/Az
X-Gm-Message-State: AOJu0YyOYTdO2Q7fgryPBwkug0NRen6wymzAxRjAcU75aYvGJ3wzD32q
	yp+8qmI5HUW75GMOZPdmFrzX4phFlVsaQvEXfwfQxnY8HIXEwY8qexh1JnjPQWp6t62pI83s5rl
	O8nYXABbP2AMFlMpyaO6xOe9lhr4=
X-Google-Smtp-Source: AGHT+IHUVsNSLMPQ1iqFrOhEti9otWFjGmpwjPDhZiEyullHOArBg+bTWuJD+2iGvLD3v0oc1ScOQe0hmxrPoGe8GjY=
X-Received: by 2002:a05:6870:2050:b0:25e:5ff:758b with SMTP id
 586e51a60fabf-2692b61af69mr562594fac.4.1723086842786; Wed, 07 Aug 2024
 20:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625155759.132878-1-linux.amoon@gmail.com>
 <20240807163106.GA101420@bhelgaas> <20240807170011.GC5664@thinkpad>
In-Reply-To: <20240807170011.GC5664@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 8 Aug 2024 08:43:47 +0530
Message-ID: <CANAwSgReunjBipcJZwneUA3fwnxFT0H4BDREWPsSxDstneekYA@mail.gmail.com>
Subject: Re: [PATCH linu-next v1] PCI: dw-rockchip: Enable async probe by default
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Manivannan, Bjorn

On Wed, 7 Aug 2024 at 22:30, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Wed, Aug 07, 2024 at 11:31:06AM -0500, Bjorn Helgaas wrote:
> > On Tue, Jun 25, 2024 at 09:27:57PM +0530, Anand Moon wrote:
> > > Rockchip PCIe driver lets waits for the combo PHY link like PCIe 3.0,
> > > PCIe 2.0 and SATA 3.0 controller to be up during the probe this
> > > consumes several milliseconds during boot.
> >
> > This needs some wordsmithing.  "driver lets waits" ... I guess "lets"
> > is not supposed to be there?  I'm not sure what the relevance of "PCIe
> > 3.0, PCIe 2.0, SATA 3.0" is.  I assume the host controller driver
> > doesn't know what downstream devices might be present, and the async
> > probing is desirable no matter what they might be?
> >
Ok I will improve this commit message.

Rockchip DWC PCIe driver currently waits for the combo PHY link
(PCIe 3.0, PCIe 2.0, and SATA 3.0) to be established during the probe,
which could consume several milliseconds during boot.
To optimize boot time, this commit allows asynchronous probing.
This change enables the PCIe link establishment to occur in the
background while other devices are being probed.

>
> Since the DWC driver is enabling link training during boot, it also waits for
> the link to be 'up'. But if the device is 'up', then the wait time would be
> usually negligible (few ms). But if there is no device, then the wait time of 1s
> would be evident.
>
> But here the patch is trying to avoid the few ms delay itself (which is fine).
> The type of endpoint might have some impact on the link training also. But async
> probe is always preferred.
>
> - Mani
>
Ok,

Thanks
-Anand


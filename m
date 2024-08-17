Return-Path: <linux-pci+bounces-11789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F042D955815
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 15:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61CFBB219A5
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 13:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348C11514C8;
	Sat, 17 Aug 2024 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF6ioFsg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9453E1527B1;
	Sat, 17 Aug 2024 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723900994; cv=none; b=d0tkJlcLjS/xhTlEDwQ0xpAApxDDTh7nHb4D3EnAXF84TP+c9yomB4K1/0RFYxcoLziW62iq1Pvh6DfOh9nYCv8hXRqlycBkR6wM9095ghqff2suIxkXXLZlhj3JBtmadq8WdrW4KEDP4Xq5g/g4G0oPrDFKEIJYoo6qfMgy4UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723900994; c=relaxed/simple;
	bh=VBQeCvtph5GxzWHRxtfXtJO+Pd2qLOl9HHKe2Up4NBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mL3o0GN4Wg4FiZY6BZLUosNCIsyy5+vcr20j9C9n6NNXdyPx2B1TWxj4SWgz5JIjWd4AStBBjF3rjX518vH39M2TVsl13YunEoVCdPzv0izfD0L5dqUUnEcShGiUp0+SgtWSmCyEvrAoYtrTAKSclKSkQT2ARYV/jxRHUENYpDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dF6ioFsg; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-27032e6dbf2so406788fac.1;
        Sat, 17 Aug 2024 06:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723900991; x=1724505791; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VBQeCvtph5GxzWHRxtfXtJO+Pd2qLOl9HHKe2Up4NBI=;
        b=dF6ioFsg8x1Gp7rvvBWR/tBU88dIfardwbbFpWi1+SWZHOPjpV+PtiOE2IJKCGt+bG
         oSK6NuoIpCSSzV72s0eVxVmqRXGZ7U4HkGy4agV29w6++M6q7rOm2m4jY2vFusyXy6DX
         HngMQmGjG4a3WyRQEIe3jGmoA3SvWuYIB0ybpUWy9OqjdMr+G7a0Vjn1lPKm6aX541Uy
         0DhMYJ5v0YimiPfzgLwRm+dKU2XM3a5PJg5xXgys8cCd4AA37BVfXISX8YwF9UfjguFl
         l/SJnvgzZoHctS/c3iC3F/8juIyXs8gTYzfujQNMLi5m/iDRb3mDeNH68c48NVsWdmYu
         aLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723900991; x=1724505791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBQeCvtph5GxzWHRxtfXtJO+Pd2qLOl9HHKe2Up4NBI=;
        b=VxssdqbJ5cBUiyEzF8OrJ2a/MUXlOwmWsEeZqa9lF+ExOWMY96BqosYT0QkoVH/tsC
         f4sdWQ8V+ialwqfy+XZqQtK6F6eSYXYbYKxZ8E6Mmafn7TGDQsRG1GMjsdoRPOSRcFAy
         YH5ThoACKnsGlIUxFFXnqQx9+WjCo11c6Au27rH/q5HP6ySOMnQDaP8LG0Ut2yqPXWaW
         JneFkbhybGZrtCF5priAN/7U2iS+CVZgO01MqfhNYJL4332IsR8MWy9ckV0BpYFdA3Gx
         ogI8bYZvfJH3IQM/fdrlTOJqbWK231LwjsXCbMKEqSTVCD7+KTt4QPxeibKtmN1IhteU
         meiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFTIz+yirOEmbP1qYd02ck0rLzhEqHVSPUFE6uGSzRd8HnXesQgt7ZPy8+/U8DeKVCVCMVXZLCngBzcL0+p2zZ9NVPgYbscbFi1oE4PV1LQNUs309nBl9yRzORrB/LBLMoL8oc2xxf
X-Gm-Message-State: AOJu0YxT0MZE7LLzOfI+1aGkwvV4Ee1+qDc5ABEoN0U74lzEg1Ib4MDM
	J2HpsdqW4y0gI3lmlVeqHfYg5HTRZNRnzcOQbthFM1+4ZA5Ay3HOncX7/taEYlPUVLedb8uq8ld
	Ii8QNX71Rui/2zZh1SY6Vv2U+Ge0=
X-Google-Smtp-Source: AGHT+IEBrKEcobzpQAyYkf/uRKuBvxHO/wNKbGj7JcxKRPxc5UoEA6yCrWCdUeAQNrTNgQTRS3FZaAuTTVZ70FF3Jng=
X-Received: by 2002:a05:6870:7182:b0:254:96ec:bc44 with SMTP id
 586e51a60fabf-2701c3e5157mr6650443fac.28.1723900991546; Sat, 17 Aug 2024
 06:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625104039.48311-1-linux.amoon@gmail.com> <20240625104039.48311-3-linux.amoon@gmail.com>
 <20240815162459.GG2562@thinkpad>
In-Reply-To: <20240815162459.GG2562@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 17 Aug 2024 18:52:55 +0530
Message-ID: <CANAwSgSqUoO+=GdFRnW5MOvbA+-sHPe2oEpzvd6O9KpzJ1tdmA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] PCI: rockchip: Refactor rockchip_pcie_disable_clocks
 function signature
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Manivannan

Thanks for your review comments.

On Thu, 15 Aug 2024 at 21:55, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Jun 25, 2024 at 04:10:34PM +0530, Anand Moon wrote:
> > Updated rockchip_pcie_disable_clocks function to accept
> > a struct rockchip pointer instead of a void pointer.
> >
>
> Please use imperative tone in all patch descriptions.
>

Ok, I will try to improve.

> s/Updated/Update
>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>
> With above,
>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
Ok
> - Mani

Thanks

-Anand


Return-Path: <linux-pci+bounces-14365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE7E99B184
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 09:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA0E1F22CE5
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 07:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4744A12CDA5;
	Sat, 12 Oct 2024 07:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+8TIAR9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC340BE65;
	Sat, 12 Oct 2024 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728717939; cv=none; b=UjFoEHK4kt96VXrPhz5Y1ylF87pAzJKyzsMrPxsTZTuxhd5S2Sriu/bkm7vlfxfwkU0Ub/nbERm3YmD3R5s2mp2MBLfvKibV1Ifeu/uAzI5TBPwMUx1+7LQi3DmKJdjhoDgM2hsjG7W81GH5uRYnA7xdEQ66GSoURmQ0RZdP8KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728717939; c=relaxed/simple;
	bh=Sh90L7XFjhTZ7aBWMOUuGd+3eneyTSVfF8BV+mVCklI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qd1iDSTjf3gb0xZbAB6lEjtuZFI+/dd5W2ArN4Vp8to8TyoZk3vIRrP/WRbz9D5IOpFgZoYCNB33eZxRcAGexPEGilJK11tYLn7LRS5QUNrQKOeG5CJ63jkC/J0C0R4PULVN00nTrws2YJJJZWkASBE92T2zkIB/Z5SLF0FfTHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+8TIAR9; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5e7ff3c8bbcso1293676eaf.0;
        Sat, 12 Oct 2024 00:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728717937; x=1729322737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qFJHXmWUByEds8clTC1LQB9D0Bv72AC54JwvOCu5Qpc=;
        b=K+8TIAR92bpU8wElc5B/g4geVoVf7+6/E88ILQsn6e5ldAZsGNhyuNYmue0U/e6E6o
         9EDxteATi9BcRkq9dvJGq5eKIks0Vuz316yjX7oXgM8wZOMLPxoYyPQ36/mFsIhSdDot
         KRWyD4NhV38jmIj1/UGbSHAz0+rjhYEIke/71szyH/wbVXLhAPfxbYoLPpqwFDHm+zs1
         D5wWhTaAd6WWTlcdCR8RqEXCSDXQO+d+Ul96bvzKGhUe42sVfX2bzqftvUTBy0y5e1Lg
         a+fhSs5LGZQ/TioA9gcuo/VSaLKipL5/P6Zb2Q9sSDsDlWTgooedt/ZHYE/nfoXSDPvi
         gw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728717937; x=1729322737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFJHXmWUByEds8clTC1LQB9D0Bv72AC54JwvOCu5Qpc=;
        b=cbr0F9TBoDKZqbanh+YlvAdU8KELghicsufnwEiwubZGlcahEnAvSSKmUMMTVxCQ3h
         gVihdJSZHU1st+Qewb8IImgyuvruNl54cN25BWhX6AuWrNEnLZIUu4sT+vVGXLOEhlCi
         21N87iGeeG6hYL1h2r39Giy9uNZGmg0l4rCvxW62ImKWm+OtKs6HKJ3k2oOD+4kOh36/
         hJd1UA4Kfl8LSRl9l7rk0tQK4EJBBRXFzsQOnMxZh03h6q1Fn+keNLTlejc9KG6qsql9
         jGjkWwzCOlnBkuLwWxcGVOU6vRnwPpl72L7M0GGqM9pkkcn0DOjoxsiNNG0CvYNEsRLb
         SBLg==
X-Forwarded-Encrypted: i=1; AJvYcCWP6YM9Upc6DH+vm87y0o2emIsR+o48+bm0UlGj8nw9EhuMHkeZYILqPiCO3cAnrLT+m7FBQgd+tnsI@vger.kernel.org, AJvYcCXw2sh55t4DFiecXv9D6+nPyOITrASgH3ajzwg85+DO37P3EFH/wwnLmkEFlfSzw8yZi8gD+IO9Nm+QoNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94sIKj3PPxaQuZokc40uqiKoTEcKqZmOliROybEXstvwyNFrI
	PZ7pdFq0NKT0CX1yTF0XqYfYVW9nCZb4pECyOpK6XjZgf02SqtiBrTPeUbirU5yU0k8pfANSISk
	+aMTUKl+SiK2yijRXIPB59e/EDXE=
X-Google-Smtp-Source: AGHT+IGxcoo7XIEg/2VGJljTTQoQCqCwZmD3zSNnB3DUpI3w85snogReGnHlzl7eFuZJLLQZl2U++xeT9L1aIakhcwc=
X-Received: by 2002:a05:6870:d88e:b0:26c:5312:a145 with SMTP id
 586e51a60fabf-28887328507mr1145574fac.16.1728717936765; Sat, 12 Oct 2024
 00:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012050611.1908-1-linux.amoon@gmail.com> <20241012050611.1908-2-linux.amoon@gmail.com>
 <20241012060847.6teuutvy2u2es2qw@thinkpad>
In-Reply-To: <20241012060847.6teuutvy2u2es2qw@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 12 Oct 2024 12:55:20 +0530
Message-ID: <CANAwSgQLi5zW4+95-ZRbpm05bzs8tjr2Sr-PpgMxTPAEzjSj9Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] PCI: rockchip: Simplify clock handling by using
 clk_bulk*() function
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Manivannan,

Thanks for your review comments.

On Sat, 12 Oct 2024 at 11:38, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Sat, Oct 12, 2024 at 10:36:03AM +0530, Anand Moon wrote:
> > Refactor the clock handling in the Rockchip PCIe driver,
> > introducing a more robust and efficient method for enabling and
> > disabling clocks using clk_bulk*() API. Using the clk_bulk APIs,
>
> I think I mentioned earlier to use impreative tone in commit messages.
>
I missed your point.
> > the clock handling for the core clocks becomes much simpler.
Will improve this. my focus is just I don't break the functionally.
> >
>
> Could you please elaborate how? i.e., devm_clk_bulk_get_all() allows the driver
> to get all clocks defined in the DT thereby removing the hardcoded clock names
> in the driver.
>
Ok,  I will elaborate on this in the next version.

> > - Replace devm_clk_get() with devm_clk_bulk_get_all().
> > - Replace clk_prepare_enable() with clk_bulk_prepare_enable().
> > - Replace clk_disable_unprepare() with clk_bulk_disable_unprepare().
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>
> With above changes,
>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> - Mani

I will try to improve the next version.

Thanks



-Anand


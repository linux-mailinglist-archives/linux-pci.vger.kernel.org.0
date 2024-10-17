Return-Path: <linux-pci+bounces-14733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577599A1A68
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 08:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACC1AB24BF1
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 06:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2139E16E892;
	Thu, 17 Oct 2024 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9YDgnaX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB014AD2D;
	Thu, 17 Oct 2024 06:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729145020; cv=none; b=tTt72BqjW3arSl+g3fZRh/uzpl8M/LgdMFYRAtsNstPS/0SNZjw2VREFpR+ztGp+Od8970GBFHxOHv4Xl3FsiM++TWTlbd+5sbXYD1VlaXYn+8naXv8snpCAHa4ggzc5T9FgD1YEETZ00wIWcOmBk3oE+Ips6kfkGQcGK1uTjVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729145020; c=relaxed/simple;
	bh=iD9onH6cXMjOVhbOxjnOcgYVA8etcnhKUQF7QMAypMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmQtcY1ZK0jD9ylFb40oLo+wOQ+bi2LZa8PeUpoFG5+fH7NKn704ko6k2n+LxiiHWAPbr4pnIzY0uPmaFKbGjJErBuf73U8+XoILcgIvQNNwKEKL1/waqS214eDnFMLzh1kW5NX0ak77a2mB9i/m8eDUu1x3Dszp9xXIGII/fRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9YDgnaX; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2884a6b897cso235224fac.3;
        Wed, 16 Oct 2024 23:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729145017; x=1729749817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iD9onH6cXMjOVhbOxjnOcgYVA8etcnhKUQF7QMAypMY=;
        b=X9YDgnaXWYyIa9/lReJ7cFrkQEKKVXLbJLtqtT//0wr/MrGrvMI6rvQd5qTyuO5D4h
         +9nz+iK2oyPsfQVOovV0x7RfpJu8eynDFVHDDSi8uQH5L4Qo3m5DX4R2XAmApxWFkfQk
         NT9Tmx4Ro62gp9R3ctTVxPedI+KFCBEBhKGJjWYt3f20Tk0v7PeW5GoMBDvVkdMcdefx
         P9gSn3frDXoAVfthV2aiKJHS9bPyFlDKyHzIO4wBCdO4QqBvT1dSBObpwPIuFO7xKX3C
         2uWmTaH0jgIeV7yceTEHbqcHgd9nem0vjuxQ/HLxA8QYmRTjLu7YAanMwRML41YYmo/F
         9Fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729145017; x=1729749817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iD9onH6cXMjOVhbOxjnOcgYVA8etcnhKUQF7QMAypMY=;
        b=rnd8aLgLakwFFm7AMlGA4J5YPi9h6CApbMx6n0W3t9vmuN2ueCS1JroV3GGeNGvhZ9
         xVwahT3DNhpLjIKw/+eQuxe6iileSXPDXzW8dOxL7dXR7Llhi9NFmgoGzcx8nPDAKocA
         IuuFK2vjXOOXWYyfysriXA/8kEZXmtupI3DZWVpdzdwF1LzCbW3IQJBpNg9ucLWMoFqb
         Xx7V5MC15jq06imkF/zY4nPOXXuPAeEMie9lFg/mX8Ct9viMLzW1nEHKc5SGFrKXhcGf
         SPMJd6werhXbWhhynkLKWnPlxvPT1WEOYd1vUzVU1MsN7pk1Qnz5TGQABOkvx4gcXbtS
         R1Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUDRnd0A1bfCYmsqP5uvS0FNXdHJox5BdUnywrDyluyIyDfaG0I6FKngoUGIEjJLHu41r8XgFhseV31@vger.kernel.org, AJvYcCXwLuZi3Smpg58Td81vZFfxCZPBk3+EGGGaia09T0mF+bmxnNAaDk7OwHtfMfu9gPecm97Ws2VCvESmJAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Fv1pY8/hRnXxenffc7SopCf2huoQBmWEXm91mNZ0aRFVONuG
	Be3TJ7XxegdQgZ3MjzwBlvJsWRK+FRWr5jneG9HEOlPZWNZTcUjF5Q1zUOZhHAyYq8wL5ylftMl
	siGKVvhKqYYhZs7RIGwZGzeDALDg=
X-Google-Smtp-Source: AGHT+IG6y46zeLJj5fn7vo6K0/8lukV4iLeUpBsTMojcWCqJe8Hac7uIw5IEZ3mC1+Jq86JcRevq9Rf2HjUvbpGCrVs=
X-Received: by 2002:a05:6870:911f:b0:287:b133:8aca with SMTP id
 586e51a60fabf-288edead059mr5274887fac.25.1729145017495; Wed, 16 Oct 2024
 23:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016114915.2823-1-linux.amoon@gmail.com> <20241016114915.2823-3-linux.amoon@gmail.com>
 <20241016182343.vocxyi5ry33btw5o@thinkpad> <CANAwSgRnd5jaZjoNtCLcq6nRGz3gC-VwjhxsiG7haiowrmZs_w@mail.gmail.com>
 <20241017052829.umil6en3rwsz7dvr@thinkpad>
In-Reply-To: <20241017052829.umil6en3rwsz7dvr@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 17 Oct 2024 11:33:22 +0530
Message-ID: <CANAwSgSU=EA9NpVt1cBSjVV-MQjhCn0GAJxvjf=k5o4UusfQKA@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] PCI: rockchip: Simplify reset control handling by
 using reset_control_bulk*() function
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

Hi

On Thu, 17 Oct 2024 at 10:58, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Thu, Oct 17, 2024 at 09:17:35AM +0530, Anand Moon wrote:
> > Hi Manivannan,
> >
> > On Wed, 16 Oct 2024 at 23:53, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Wed, Oct 16, 2024 at 05:19:07PM +0530, Anand Moon wrote:
> > > > Currently, the driver acquires and asserts/deasserts the resets
> > > > individually thereby making the driver complex to read. But this
> > > > can be simplified by using the reset_control_bulk APIs.
> > > > Use devm_reset_control_bulk_get_exclusive() API to acquire all
> > > > the resets and use reset_control_bulk_{assert/deassert}() APIs to
> > > > assert/deassert them in bulk.
> > > >
> > > > Following the recommendations in 'Rockchip RK3399 TRM v1.3 Part2':
> > > >
> > > > 1. Split the reset controls into two groups as per section '17.5.8.1.1 PCIe
> > > > as Root Complex'.
> > > >
> > > > 2. Deassert the 'Pipe, MGMT Sticky, MGMT, Core' resets in groups as per
> > > > section '17.5.8.1.1 PCIe as Root Complex'. This is accomplished using the
> > > > reset_control_bulk APIs.
> > > >
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > > v9: Improved the commit message and try to fix few review comments.
> > >
> > > You haven't fixed all of them... Please take a look at all of my comments.
> >
> > It is becoming a nightmare for me, my confidence is a the lowest.
>
> Me too. It makes me go crazy if the trivial comments are not addressed in
> multiple revisions and it results in waste of time for both of us.
>

I must apologize to you for my failure not being able to address this.
I promise to tidy up from my end in the future.

> > Can you fix this while applying or I will resend it with the fix?
>
> I don't merge the dwc patches, so I cannot do that. But what's preventing you
> from addressing those comments. You cannot put the burden on the maintainers for
> your mistake, sorry.
>
Ok I understand this will try to send in the next version
> - Mani
>

Thanks
-Anand


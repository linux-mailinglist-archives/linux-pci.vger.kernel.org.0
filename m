Return-Path: <linux-pci+bounces-14914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C329A520F
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 05:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2FB1C21FFC
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 03:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B9628E7;
	Sun, 20 Oct 2024 03:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScYb+bZ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EFD6AA7;
	Sun, 20 Oct 2024 03:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729394314; cv=none; b=PyAWrbw8rGMNSYYjtpN5Xd2CfReO6r1ZmxqeghnHwDuHdvq1ZU7srq0Eg4rEJ1WfZV6TzcTdEW/FbLdP8ArRqhw9KvxhUyt9s7kILsq171c2uMpFgC8yiUUCLaP4uW/ysj7mlsw9D81SbHpWXJ1EXXje0LhICIBc56cPJ0ccMLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729394314; c=relaxed/simple;
	bh=zMNl3lXt6sftgfJYEPUYpr+Xju9I44mn/0y902I49pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWEuPxNN1y007YaMs7JIwVhMr2/hI9t+L2tCvWg/YpIl5PJh42P736VxgKzi6L0//1XGxWgWEbxZg1pBnYx653Cs0Wp9JdplJyFESLCHMO7tRnz8LjNCLGMsos3Lxg8j2ldz3kfSIfUoSEyVqW6iPOi7ECU8tvDgU2G6LlOS8WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScYb+bZ3; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71817c40110so1210285a34.1;
        Sat, 19 Oct 2024 20:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729394311; x=1729999111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zMNl3lXt6sftgfJYEPUYpr+Xju9I44mn/0y902I49pc=;
        b=ScYb+bZ38HNQP1o5ix0nUC/Reu7q0pHm7dFkdpxQMnMTHxIdVvaDc57IwsFwWL7+9N
         C4Nhmj+S/xzYSPZssa3TsmaOq5WiFABQYeclQk5i0F5QaswdWji+gVEIwmG03eRYiI4l
         p/MMlXZrH1CA2PTj5RtpQHhbZ+HUGRkmi2JHTqXfn8FKwcgMgx44pneGMPAQcDPftAZ3
         KAeuUO0L44M6p5ZKGRcehZldjuPBeiVF/l94ueDctbOSBUu0OE6yebDgrqpFsdZV9dLt
         a6NHwuSWi4oHO+O0st3ts8B2rmlEzQiCjuNn7SZdoXyllqSTYtxreLBJ4s5L8fc3ZHeJ
         dvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729394311; x=1729999111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMNl3lXt6sftgfJYEPUYpr+Xju9I44mn/0y902I49pc=;
        b=Cr34SVnnnnya4E0NqsCGxqpEWYVRC6SVwf/6/rNkC+nbIm7EWMQ6TIm8CmQFjDQh86
         xL6dpIP4v8Fih1H1Nkwndnee8Zz8rjrMEZsRxyiAl+WKOS1ZZPe2xHco9wLyA7WmYBWw
         dtmMZgF/ULpb1MytSL5ufMdXGs1sTj5+dYRqznZBQtqPA3KmxDcQ0NNXHa4X2JT/aTjv
         HaKiuA8akBGD7cc3fpJfWyifG5ZeTXjBBMiTg7hIafukHLc0gxLw24NwGAGpoFVLSPUR
         67p8A72dOIVCN/ujzC678hvBeuovxHSXJSVL4OGo8FZ3M9nEdy3mgA8XIZXKi0kEEQsY
         yS5w==
X-Forwarded-Encrypted: i=1; AJvYcCUsbFTgvg0jfqoeonu3p2CumzeeUXTZlffhWiAxScdo/oRrmnkngXeOgyUbI21ou9o9WZ34uycHWs+L@vger.kernel.org, AJvYcCXi55Hp+GkZdbVsqPD1psin+F0dFlnWtlEr6EpmQZEPXK1oOB3EEu8XH/Ck7gsLPowdAohKR70NK3BG@vger.kernel.org
X-Gm-Message-State: AOJu0YwzYrhQP+m5Ic2dhcsNN0Xtbe8/lNAHciyHlK5cKPOsM1iPM3uE
	tB6V7GR/iygkfoMQX+BV6Wmt1GaCHCPxJMt77ErpEcdiaMzDcfL9if3WnmKj8l1sOp+dntwosQ0
	OJOpUvDwywpYZyN9Ssr/sIpN5zNi+vly1
X-Google-Smtp-Source: AGHT+IGrwwBspEJuIdRw0EUY5MU+OA9HGR9uV4PbDK8TXYqRe4A45jzQegJSNnkf6eomVfzhFpwkkhVZiAAti4Ap7qs=
X-Received: by 2002:a05:6870:d88f:b0:277:f16a:97e8 with SMTP id
 586e51a60fabf-2892c4a5082mr5983257fac.38.1729394311083; Sat, 19 Oct 2024
 20:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011121408.89890-1-dlemoal@kernel.org> <CANAwSgQ+YmSTqJs3-53nmpmCRKuqfRysT37uHQNGibw5FZhRvg@mail.gmail.com>
 <f13618a6-0922-4fc8-af01-10be1ef95f0d@kernel.org> <CANAwSgRDbCCridYMciq=xSDPV0qGhs-OhCJ_uniXFbp-yM5CcQ@mail.gmail.com>
 <0f2cf12b-3f27-403c-802e-bb8b539766b0@kernel.org> <CANAwSgRXfZ9hgdJpSrwucHQfMToZwSC8N-b4MYLZjsryid=Fpw@mail.gmail.com>
 <6aa0a404-9bc8-4b0c-b6f9-a455a3033670@kernel.org>
In-Reply-To: <6aa0a404-9bc8-4b0c-b6f9-a455a3033670@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 20 Oct 2024 08:48:14 +0530
Message-ID: <CANAwSgRzQKAnsqqx_es5MtJy+ZwF8_y27_XGKq6PYfvF2oDOeQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Fix and improve the Rockchip endpoint driver
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, 
	Rick Wertenbroek <rick.wertenbroek@gmail.com>, Niklas Cassel <cassel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Damien

On Sun, 20 Oct 2024 at 06:36, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 10/19/24 15:24, Anand Moon wrote:
> > I have a question can new test external low power GPU with external cables
> > which supports PCI host (RC mode) with external power supply for GPU card.
>
> I do not understand this sentence.
Sorry for my poor English,

I wanted to check the feasibility of testing external GPU on the
Rockchip platform,
Just like Jeff Gearing

[1] https://www.jeffgeerling.com/blog/2024/use-external-gpu-on-raspberry-pi-5-4k-gaming

>
> > Which mode is suitable for the PCIe endpoint controller or PCIe host controller?
>
> If you do not know/understand what PCI endpoint is, you probably do not need it
> at all. If you are using your board to simply connect and use regular PCI
> devices, you do not need the PCI endpoint framework/drivers.
>
Ok.
> --
> Damien Le Moal
> Western Digital Research

Thanks
-Anand


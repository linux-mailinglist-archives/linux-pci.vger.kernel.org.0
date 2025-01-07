Return-Path: <linux-pci+bounces-19397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8304EA03D61
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 12:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69DB21653FC
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 11:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9101E1C02;
	Tue,  7 Jan 2025 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpTT5fSl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FFA1E1044;
	Tue,  7 Jan 2025 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248441; cv=none; b=LacNDNcwTAU4sQIppLllT4NSkoBj+dKZS67+IRbp6O6aeztns4ez9SVsIQO09TjAMGn6w/X3A/9IQNvQdWj0ALAblgy8fmLDQd8kPEHDGQ6i64qFWbxFx2Y89fp3EVqednoaovSWI9kC5EXjibvdXCANa65RuUUGxV9sfnR/l34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248441; c=relaxed/simple;
	bh=D9u8bmW+CIlSZ6T/S3uoblQe9170zPJK8Y9jh7M5yjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/Vwq+Nvn4xjQ7iMPSzfice3xVrbhJciP278POoQCYYWtN7ADpFXyI/QfyxjFBst564s3x0w3b6w1u6wui69jZYf4rTekqMwNJBW74RE/NbUALr+otbMX1YYypn6xZBUtW/7SZeDv7joEJHAPlW4g26JxSAEsEFTVWzYRf/GUVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpTT5fSl; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8dd1so26913116a12.2;
        Tue, 07 Jan 2025 03:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736248437; x=1736853237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e9E/E5WdaG5UpoJCBLLOu4O2PJcFjCjuJagVvXEwtPM=;
        b=HpTT5fSldDZkXsfkdWkVkWt5iVynbGlUblVQ6c+DbZzrrFkHFAJZBcV8SNwAjjUn50
         LzKh8h4i7+C+ijcI6eYdFq8FvA0xehPd7dmLuU7RyPuKEjp8IiOXbbM/TaZbBvXU03Id
         prqxYBN21YC2/g3NfwAnwW0SkihzRlIneYKyHQwj5F+ETGVEEWSkdHPsavgupICruSoI
         301ssQaTkng7TRCnHqauXxTIp5ubq9q8tWI+uqkcGs0J4bSHvwqCksRezqOfa+dUFMc0
         doN3xkzlS5IhBRdOcH8fB8aPbBH9ugzEJEeclsFY7wxFkkhtkhqVR6xwZfXUR4OVLiMW
         Frqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736248437; x=1736853237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9E/E5WdaG5UpoJCBLLOu4O2PJcFjCjuJagVvXEwtPM=;
        b=mMbY3foJRikzbVw/DoB9kLY/zo5vxJfEtlCktH9Y7H/Bv5kwN7HsWOksh1E2CzeAUk
         zEcbpI7igGbu+1dppMwk1pd3SWhB4YEmDCrmi6QW7F0S9pnIGGkLGVpA3wDGfu280kBS
         5O2J3me9kxdBlUoD08XHkyCQcnL7PMLkNtFzbdVdaH2Cv7rV1IMDRt8duGuwgDU3vrQf
         uwUuzHLib2MDtbCQz2Su07n7FLZMatcNFIH5rDP1ShOU1y5zHYvQTqih+I4pijYMtsIi
         WdmW/bXSEGnzg5nQ9KcR6C8ZGv44FyQ6Z6PH3kMH3hyYpOZRziOWofNBe7xZLdWVMtwV
         I0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUZP04wwsX5bFGIBa9N0Hosr8i6wKpTb2kW+zYpBqoKtmGbv2HXRFT6RHnm/lysXo8YJFcTfGjyPFGB@vger.kernel.org, AJvYcCUmrhxoToJjyJzpPvgpWakA9fjxVMc18Pk1KHwc491pAS76WOAFZLzsC/0q/narkbW6E1AgkrDBegUA/X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgFkBRDv2OrvyN2P+oJMTNrHxan3DseRAEwCUTvqPp3IRa0NJ5
	0/wv6mki/XE9032cHjxHttGhfJ9DzQf8JCkKQtswlCUc85XpWCLij6TB8TtE0OFa3wty0V2H2DD
	e/I3v9ACRVsESp/blwFRdOwqloCZ2rmtRPSI=
X-Gm-Gg: ASbGnctBNTJtcs0d0s51itUtdgVKJR5K/oF/BzQ5clr+JNjN0EFzP/cctPVdMWCCLpZ
	PqzzRhA192tBWGZXxjDV9jVaiyxYc0p1GyqD8uA==
X-Google-Smtp-Source: AGHT+IGUW/KivPaqDT8jfIsIOe2JvzgrK1iPNtSEV0SLtUlhQXiILMBCyfvuP0zQQUjJ43RAhpPpPZmm7HFnHQ869Lo=
X-Received: by 2002:a50:858b:0:b0:5d9:b8a:9e08 with SMTP id
 4fb4d7f45d1cf-5d90b8a9feemr13666313a12.16.1736248436820; Tue, 07 Jan 2025
 03:13:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809073610.2517-1-linux.amoon@gmail.com> <Z3fKkTSFFcU9gQLg@ryzen>
 <CANAwSgS5ZWGTP+A11r_qFSrjWZH_DqsM89MLiP+1VAxhz+e+2A@mail.gmail.com>
 <5a3e8fda-f9e4-4c2f-847b-93f521b8313b@lunn.ch> <CANAwSgSUuEvJb2Vn58o0i7Soo3jGzM8EYHvDtUTPxRHekCpruA@mail.gmail.com>
 <c94570db-c0af-4d92-935c-5cc242356818@lunn.ch> <CANAwSgQ_gojVxvi_OyHTyTSdzRrno=Yymn0AdEXyTHTgDTyFcA@mail.gmail.com>
 <Z3vGXrUIII4ixNnF@ryzen> <b49e6147-32c6-4239-bdba-72f25ef04a9f@lunn.ch>
In-Reply-To: <b49e6147-32c6-4239-bdba-72f25ef04a9f@lunn.ch>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 7 Jan 2025 16:43:38 +0530
Message-ID: <CANAwSgQqPREeFQisQZXqB52+w+j54Bwq4RMiHf3qUTXmnTxCAw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
To: Andrew Lunn <andrew@lunn.ch>
Cc: Niklas Cassel <cassel@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrewm,

On Mon, 6 Jan 2025 at 19:14, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > As both me an Manivannan said earlier in this thread,
> > PCIe endpoint devices should not be described in device tree
> > (the exception is an FPGA, and when you need to describe devices
> > within the FPGA).
> >
> > So I think that adding a "ethernet-phy" device tree node in this case is
> > wrong (as the Ethernet PHY in this case is integrated in the PCIe connected
> > NIC, and not a discrete component on the SoC).
>
> There are other cases when PCIe devices need a DT node. One is when
> you have an onboard ethernet switch connected to the Ethernet
> device. The switch has to be described in DT, and it needs a phandle
> to the ethernet interface. Hence you need a DT node the phandle points
> to.
>
> You are also making the assumption that the PCIe ethernet interface
> has firmware driving all its subsystems. Which results in every PCIe
> ethernet device manufacture re-inventing what Linux can already do for
> SoC style Ethernet interfaces which do not have firmware, linux drives
> it all. I personally would prefer Linux to drive the hardware, via a
> DT node, since i then don't have to deal with firmware bugs i cannot
> fix, its just Linux all the way down.
>
>         Andrew
Ok Thanks for clarifying.

I was just trying to understand the call trace for mdio bus which got
me confused.

[0] https://lore.kernel.org/all/Z3fKkTSFFcU9gQLg@ryzen/

Thanks
-Anand


Return-Path: <linux-pci+bounces-19444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08612A0437F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0281885896
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEF81E32DA;
	Tue,  7 Jan 2025 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFXkceVR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AAF13C914;
	Tue,  7 Jan 2025 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261902; cv=none; b=sGFlrOgl1BsVNqU7tO5CeIvA+d2mT+KUxZ8rjY3QaJC79LWyfdGI0go+OCuuBdgh94VCz22OOhXnycwi8r6CLLZrXJQWFmXwsDSht0yDo9XcCNSDmdHfZsdz4KMWbGu94syjpI56DjisNe0owZKv7p/yJtzLABxaHR3QTBfKkWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261902; c=relaxed/simple;
	bh=8Rzl0aaYtU7XWij9DMTB6XAjbq9juChEdgio5qKrZ30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guNvaz/hBgIOkFSFA6+k+T5HjrMCwXKBePD0Kb+axMT95xAn7YexSj3gfHdEHlrzdY3BGIPUJP9OeuuhwCpANyxDOMqPFy/cxFhGun4jRRG0mEIXcvgVY3UDBfW7fkNtrFrY5q1SM7MqHKP3zvPH0EOd3TIKJ9IF/9P/xbpLtjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFXkceVR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d7e527becaso26511697a12.3;
        Tue, 07 Jan 2025 06:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736261896; x=1736866696; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Az2wVx1hCiPjzJ0BVL12MlXicctDopMjOkqCsQ4N3kk=;
        b=UFXkceVRXH2hhsxBUDc1Vwdo8fA8Lxph+9/oKkWZT2jPCqy4V8J5RpNIDZ3EgZJq9j
         68M0uYOa8F834HU55hT/ngIxi0XnCyvDc49ouvGC2J8EEGQBZvQTZ8gYwWfBYbF//J+B
         5cpUCsZ/hXAQmVYCGhZ6IPmqcgpVGsuVXbWhvc0Ca1aBzkWJh/7652alcDNKJuphbHq3
         7WRdO+JjgpluZ/6FniBD5+TQWHnv6SRmonpC7bRo7ajkAUf5wXCNRTDywyOer2yADDKu
         8AjQ+2/FNRZ7YoU/lgkwG5DyM9ddnvJzBT67RLwsCFL0//HaR4TkuHeCqPZoHTmAHxgy
         1UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736261896; x=1736866696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Az2wVx1hCiPjzJ0BVL12MlXicctDopMjOkqCsQ4N3kk=;
        b=Cd7FlIS958hfM8ma+alwiG3of1C4mtT7RI0EDyWSjhssQ/59wyIR0sEJCz98osgxLS
         fQ2/GhITuDYTBFZcFN/WFClfTsyHgKlq8CKTpvi5dkRNYKR+WNhskljP4b+GgUDpYe/A
         VuUynmJuYH/PfHmnkDkfylo4E/nA/W0lgCizazqvmfi1y3B8QQxzLiSWh/VCm5Y7Eyre
         4ijUqUvMLYl65tHS2jT/u1dSEPCJXGdCZmQ9IsRsr4P1ns/UP5vVZQQijwywo8sMXCuu
         crgJiJHz766QodnIZ1XJ78wyyEK4r5PVVuxpfnJOg/Ut2pBwfiOHLfn89kCrMZf1Cc5p
         UqMA==
X-Forwarded-Encrypted: i=1; AJvYcCV+ShekjY4th4NVKhJLyOLFZ7L+AmDJvvru2Y3ydFUH5K/X1QQuDDlWbT01V+Es63hQR/bB0SfXjeNE@vger.kernel.org, AJvYcCXXs7mvchEn6g0LyFCX26unU7Er52aA8B1XtqWmZZfUdeMLUTNd5BK5ScLH2afM6LgUFCx8bUdq/0Jyv7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVAt5vOybrY/A/7bYs8IzG4tnSHYhF1gBMPTgWp6z7BVVKO6F4
	hZzBTtRjFI5lwEZCLHmdxJ+Bc0TBEVyi5AtkgBksAFo5osW6o4ajz1A6C7Pg6ePD86vxAUkU2GD
	M7tPECTz7ThI7T0VvLa79imC0zJQ=
X-Gm-Gg: ASbGnctOyyjiZUUUELQtgX45VeFALt0FMyXRyt61Ba8i9MjCzSL+Kyfs088zoMmO0bj
	YHbdETtEvZN/BPKnxYivmylVKMwDHZL5ccpYqOA==
X-Google-Smtp-Source: AGHT+IHo/aaG2IRziYHWgdJTI7LpsNtYnkQPqpLDzk81p5lbFEu3We9AunbvRFqyiMLdOxqwHKgstcmD7QIW7IPgedI=
X-Received: by 2002:a05:6402:1588:b0:5d3:ba42:e9e3 with SMTP id
 4fb4d7f45d1cf-5d81dd9ce81mr153578555a12.13.1736261896167; Tue, 07 Jan 2025
 06:58:16 -0800 (PST)
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
 <CANAwSgQqPREeFQisQZXqB52+w+j54Bwq4RMiHf3qUTXmnTxCAw@mail.gmail.com> <c08f3d69-1f3d-49a6-96ac-0c2f990f9a8d@lunn.ch>
In-Reply-To: <c08f3d69-1f3d-49a6-96ac-0c2f990f9a8d@lunn.ch>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 7 Jan 2025 20:27:58 +0530
Message-ID: <CANAwSgTWXBhhDk4Yq3U8qTTRBUOx24MvM7moWoKFkKU8Nn6eAw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
To: Andrew Lunn <andrew@lunn.ch>
Cc: Niklas Cassel <cassel@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew

On Tue, 7 Jan 2025 at 18:43, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I was just trying to understand the call trace for mdio bus which got
> > me confused.
> >
> > [0] https://lore.kernel.org/all/Z3fKkTSFFcU9gQLg@ryzen/
>
> There is nothing particularly unusual in there. We see PCI bus
> enumeration has found a device and bound a driver to it. The driver
> has instantiated an MDIO bus, which has scanned the MDIO bus and found
> a PHY. The phylib core then tried to load the kernel module needed to
> drive the PHY.
>
> Just because it is a PCI device does not mean firmware has to control
> all the hardware. Linux has no problems controlling all this, and it
> saves reinventing the wheel in firmware, avoids firmware bugs, and
> allows new features to be added etc.
>
>         Andrew

Thanks for clarifying.

-Anand


Return-Path: <linux-pci+bounces-40687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C23BDC458E2
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 10:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB8E1890467
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 09:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF6A2FE56E;
	Mon, 10 Nov 2025 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQoamAS+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14AE285C8E
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766105; cv=none; b=BcJdKXBEtMx6LorYtX9VgyVBkUqM7hYsHPfL40HCt8NEz2WtQ2PY+s7TWhMenfyUWNyPFIlSSFQQVAn7HcecIJuMhfoO+gUW0c9zi/QHh8YEO0olomZVOv9VGzU7h9rvGwf8sI2xGluyfU1eOldgGzubzJ+0H2DKrVY5jhO8eUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766105; c=relaxed/simple;
	bh=2+PqvTsIgaNTk/7uCk6kfDMTr3xQc57xAYsQHUDudqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqH9pOUeb0rV+wBygb74iMZt82B/7wG2gKXmb2HO6R/TowqlZi6v6kfrWLSmNWnLqK7/oMQ/LMwGLeYbNd4kqwXclTURruskrH2QosEEBuXDLHtZj9znB3/kxrYcEj9x0hCmQlnZCWNQBjZAXrqaew3vunVDhEZRURJrH9s9lKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vQoamAS+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6419e6dab7fso642977a12.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 01:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762766100; x=1763370900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NXFnmmWcp+T86M4X7Xk/v6jPWKY4nv9UjyUBijcqLEQ=;
        b=vQoamAS+F6pl8KkrO4lJUya+bpcXEx8dhbKTFpTLD+It+F8omkDa8RI+2okKpdY6QB
         VSWW434xasv65TJG9tI/z8ZigUUcm9NM372aCXsb+RnA6OZjZAWe40iQCMGPOLX+1SRF
         /aZuGzH7tqG6ATJsXY7zpeiYSb4tdxthPOyPkuiLesZj/AT+4bD84pp+otQIuChATLTa
         Wbuv0xsGlzBav0wTKFJMkUWlvNlxWqXsBmlyKnc3XC4fAyusM5WlPuf3ZyvT2WWX5Aa0
         J1+fVcTxXOjuFtcDGhCGK7uLw2CSnmKodnUBpuuNZQIT6oreu58No8/Tnh1txiziwCiW
         LQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762766100; x=1763370900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXFnmmWcp+T86M4X7Xk/v6jPWKY4nv9UjyUBijcqLEQ=;
        b=MtWLV1cy17ZVlRNPgYOhxhoJWPqast/WW0GLWVSJPkwZfmwkxOvQni+PE3YccwqlgS
         IGV0VvUt5JrN78d18ZSbInLrqrTJSKit0ONVFg2cyBZlgivjIltpWQD1kUiMkj42/zaf
         coM/ffzOQkOz9bMVTjuyqe9/as4BiOPYb4TEpzA6KNX3Ivu7VUjoVadRdlDJq6c3oNU6
         MobDIeLVvwvU3ljJCmoRBjMLFA71iSYQu7WZJ+scaeqOpSNwt+KDX2i9WtY/iamJqCpH
         +WBktJTOg7ZBvl8b1x2b7QLuQ7FhPBgf08Wl2ZGtQEYMYSyyjo5i5hJ2hRLNs7yqY9aj
         Q1aA==
X-Forwarded-Encrypted: i=1; AJvYcCWq7+PiQjp9OJeSBddCQUeaYaYLVzc05jiGud74/Nvc1Qih9akcvWtiwEjzicRAsMdtBBCVAwIL2jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvA+o1Xak/MD23IEHnThgFmb2RYKUZl+2oFFYflo+ZMSRpwrEE
	Zg8Zm54q53g0l8LiueO9EzvlO59VXiiMbVRykeYm35QiSw3wizeCH8ubape1nu0JosgAm037nkh
	1D7+e8nm/WwVqUL40qTZWYsTVcVe8+KM09g768duk0w==
X-Gm-Gg: ASbGncuK6M73HwxzAYrP+WqgpPlP7QYQ5EZcdLrN8qTWLEcRAKOmdDcVIyCBanzuB0L
	mf0Gb+c+1zefOgtzUWser5yyVqLRTTaE/RC6GSvM01LWkvEa0NBFYgl+19JrallSHDB4u2xl/fS
	BwKs1A2hXyb9zKnHT1rWUtJtxH9iDZBWYBVdDYzzIhqG6ca1r/d/Ueh1t0g1oz3uP9rDpjt6J1V
	YM3UGc5Rmei0I36/9NuJvzKHIZfWMtfOCHuGLH7APgknsIax7KzxbczFqq40AaZy9gQWLqwzICc
	hv+fYBUsw+jl7SJ9PcV7MDJ7c/kinavfT64=
X-Google-Smtp-Source: AGHT+IG5jsntiKbL9XDoTScxbX6sK0/o8ty8iuXm+qmOqxUowPC2iS+ovEiKsBoSdXQkOeKy6r5NlaZELkfmqB0OJxc=
X-Received: by 2002:a05:6402:26d0:b0:640:cd2a:3cc1 with SMTP id
 4fb4d7f45d1cf-6415db564bbmr5934589a12.0.1762766100006; Mon, 10 Nov 2025
 01:15:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKfTPtC87w7RVSDAXWXRX1sjgo4s=_Z_k62+mfTXrMZwmkEpFg@mail.gmail.com>
 <20251106173853.GA1959661@bhelgaas>
In-Reply-To: <20251106173853.GA1959661@bhelgaas>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 10 Nov 2025 10:14:48 +0100
X-Gm-Features: AWmQ_bmdJnu871GRec3avwkB2KMRGJUSatF4zpeqoF6tG3-YU67MrrGvp-or-eI
Message-ID: <CAKfTPtD3UUXq=PwBJKx2q5VEBbAie-M1XgTbx3hmxZV1yQGBww@mail.gmail.com>
Subject: Re: [PATCH 1/4 v3] dt-bindings: PCI: s32g: Add NXP PCIe controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, chester62515@gmail.com, mbrugger@suse.com, 
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, Frank.li@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org, Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Nov 2025 at 18:38, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Senchuan]
>
> On Thu, Nov 06, 2025 at 09:09:01AM +0100, Vincent Guittot wrote:
> > On Thu, 6 Nov 2025 at 08:12, Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > On Wed, Oct 22, 2025 at 07:43:06PM +0200, Vincent Guittot wrote:
> > > > Describe the PCIe host controller available on the S32G platforms.
>
> > > > +            phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> > >
> > > PHY is a Root Port specific resource, not Root Complex. So it
> > > should be moved to the Root Port node and the controller driver
> > > should parse the Root Port node and control PHY. Most of the
> > > existing platforms still specify PHY and other Root Port
> > > properties in controller node, but they are wrong.
> >
> > Yeah, we had similar discussion on v1 and as designware core code
> > doesn't support it, the goal was to follow other implementations
> > until designware core is able to parse root port nodes.  I can add a
> > root port node for the phy and parse it in s32 probe function but
> > then If I need to restrict the number of lane to 1 instead of the
> > default 2 with num-lanes then I have to put it the controller node
> > otherwise designware core node will not get it.
>
> I think it's better to put the PHY info, including num-lanes, in Root
> Port DT nodes now even thought the DWC core doesn't explicitly support
> that yet because it's much easier to change the DWC core and the
> driver code than it is to change the DT structure.
>
> That will mean a little extra code in the s32g driver now, but we will
> be able to remove that eventually.  If we leave the PHY in the DT
> controller node, we may eventually end up having to support two s32g
> DT structures: the single RP style with PHY in the controller, and a
> multiple RP style with PHY in the RP.
>
> We'll likely have both structures for many existing drivers, but I
> think it will be simpler if new drivers can avoid the old one.

Okay, i will add a RP node

>
> The eic7700 driver is an example of num-lanes support in the driver:
> https://lore.kernel.org/linux-pci/20251030083143.1341-1-zhangsenchuan@eswincomputing.com/
>
> Bjorn


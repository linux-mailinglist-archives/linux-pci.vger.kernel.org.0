Return-Path: <linux-pci+bounces-37291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE342BAE62E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 20:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986804A0FF1
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 18:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD1527F005;
	Tue, 30 Sep 2025 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNlRUwSh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D7E27FB2F
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258791; cv=none; b=Iblk/k6Q2wi9COuMzbjXiIG03wswEyh/li96SAkom0sOq7NfdOcVjNr5azBA2cZ9SgMNJR7/1dliF35OTrWCMF8bo7wk+dXPXS9MOYIXWYafa5RXl/cHHxhNleB/F3Zma3zDJzfTin3aPLfAE1H9K7xialz3fWF2i57M6t15Dj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258791; c=relaxed/simple;
	bh=6nTNdN8QgQi439b7lJaE73iUb6WNpc9gie2egShamqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttcFvWeSSsiVaoFikqymR5GpyuUelma54ZVNZvvuS9s22jzwM2RGoPe9ynuuNdekQWR/4Ioy0Aso7uLoZp6tr7IRToP3QOOKN7TFzCTgXyLgPddVu5TvuYCxDSLU0eKmGwY9MHnTooh/loX+IAATVtLQKtA0ODpgdGSRLdYL33k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dNlRUwSh; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3682ac7f33fso2358651fa.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759258787; x=1759863587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvDjTcYLd2HV1In46+KbPiFTSYwmuM/iqbqpVCZWQpw=;
        b=dNlRUwShbzHApk2XtI2lUe4HiODWT2iw1/vBuWx52K9gqLkVuOv78YYihxG9O32953
         KtjUgqdWpYvPCmEfQrpKCPOVCn2ohYuPI2iDUFN0qEH81BAMx5UCxT3nvIXZlV7e732n
         xyDPv3/+6fD/S9UFm82QPeCanOxCimS5SWSKjP9wSH9yosIjHztUz69S6zh8F6kBofxP
         xqCpzgSIoBa2RKxLiYDifHK57p9TYOfHSzvXWTiVNYh2Ay4LWPXaztGR+vmbQZlC9Tx/
         RLEaRC7nYjKJWATNGucsm4IAgSIJN7W+ZIF/o4j4BJk5dO557lNeLCc+wMqxIumdo8UG
         Didg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759258787; x=1759863587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvDjTcYLd2HV1In46+KbPiFTSYwmuM/iqbqpVCZWQpw=;
        b=S6rmvr6CkPQ7QrcJo9V4RPo3/CHNTA7lJ7IvX3pbJUsbhQHnB2wWZKS2eSaxlQ8Ux2
         P6vXB7U1jbl6HqMa2weh3VguZ0dYuDVcJ1CWkyTlsv1PkG2nFOGsk8ygm9hZ1Ktch2WB
         p7JWAghr/pMExBgqHELKJyWTyhvBVngqz+KHCksTB5k4HIJf5qEPfx2KPlZmnYenwlEF
         BjlzXniMZejjsKs5gBG7pd2GgX4SyBlEVLxbs851N2/UUZweQyDiJarnEXl2o8sJ/T9i
         lGi5ds06AYjD+2GzbthCc9PzTjAm8SWO9D31yrtzcoHvc1AblZik9NrTdMGBd60B40vm
         Z6zw==
X-Forwarded-Encrypted: i=1; AJvYcCUZl9mt5bBltvKw8NYwuubt58rmQOIRxgLGeGTXGiCxy4AJRe0iL7D/PWjtZ4omQRHMjG7L5/Nhbd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMLAVjmhNeHnaAl94D2aEkQViK4XwZ6ctMqVs5eLXSIv/laWhU
	l8slfB4SsdgrRvU84mxfpILOwFT2RWAgEpBZ2XAkAO4jj3l3opHIsaFKSNILgBAZ2I3jNFut1Pz
	84spW/0yJ4S2pb/tYn4diIHkrN7ZRV9XcTu+Xbn49lA==
X-Gm-Gg: ASbGncvS+G1nQbLe81k+2/v8fBRFIlfTb+N+xqRyK8t5wt8pSBE0OZgOWRnATNgQ/fo
	z3s4WGhk9MSrJSx5ph0ei/Gw6fUqGgrVOKZraPQKC5+kAUluF48ZbtFJfT2vEIjzeLucoD4KZoK
	fQOmE6DIngBeVh8c0eCtF57h6t0h1YFiUyjSKRlMIppqEVvlXhU4Hr+h6XTR48eolo3HRHiTh5+
	g26Qj+wPizhi8yKTI8NLWWiESEjVue8A1IXhSjQ8g==
X-Google-Smtp-Source: AGHT+IF7yHga9ZFNNFlUCnGviYoo6xKxu/Xxa9beEf2FScatMz1T1FuiOO+dTwFx3frzoKVek9xu9weGLn68tdeB/cg=
X-Received: by 2002:a2e:bc86:0:b0:336:ca1d:2289 with SMTP id
 38308e7fff4ca-373a677fdc0mr2955161fa.14.1759258787562; Tue, 30 Sep 2025
 11:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925202738.2202195-1-helgaas@kernel.org>
In-Reply-To: <20250925202738.2202195-1-helgaas@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 30 Sep 2025 20:59:36 +0200
X-Gm-Features: AS18NWC6gpnBlQLHWM2WkfMaHl46t22UwIFLpSG0ECkTHywqRwSwkayxYupfms8
Message-ID: <CACRpkdZFy2Kb0BaEkMiTi3j89H-6G=chuZSijtRRg7QCCktLDA@mail.gmail.com>
Subject: Re: [PATCH] PCI: ixp4xx: Guard ARM32-specific hook_fault_code()
To: Bjorn Helgaas <helgaas@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 10:27=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>
> hook_fault_code() is an ARM32-specific API.  Guard it and related code wi=
th
> CONFIG_ARM #ifdefs so the driver can be compile tested on other
> architectures.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

It looks OK to me
Acked-by: Linus Walleij <linus.walleij@linar.org>

I see some other ARM32 drivers use it too, but we surely do
not have a arch-agnostic way of handling bus errors so perhaps it
need to be like this.

I think Russell created the fault hooks originally so CC:ing him
in.

Yours,
Linus Walleij


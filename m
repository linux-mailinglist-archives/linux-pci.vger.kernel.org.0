Return-Path: <linux-pci+bounces-10949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C47A93F5A8
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 14:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1F5282BFF
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 12:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6713A1487C4;
	Mon, 29 Jul 2024 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcNZaxX9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F731474CF;
	Mon, 29 Jul 2024 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256935; cv=none; b=LIsTQEIzSj2J6E/I1lVN50EJOL3gDp2wG2xEqVPn73cBQJZ3Q5X8EnpdvTeBJbtsy3BgeCylqLulKqm7NVF8/xdsA0JzY2E4sO3LY1rXo+r3lz4kex5N84d/HpKoN3YiJ2WjDEaWL1/ow+jQwRUSYNxE0N9esN9dvfmoYW21NBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256935; c=relaxed/simple;
	bh=50wQBaCWvP3be2O70xJY2fE8pNdwE9rQr3qC/amQcYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FY1Pup1DZ+o7CnXvXRJZAFc/XgqhkZSkgW8aNAokGr2tQXe+v/uLINm0SA2iZpouasm3f09ocLjYPlHcHlN8ojUSWPQrueYFOIHapA/aOwsYaa/okQs2AnUVUXIfymRTTfc9/0o8yyh+Vq7DtGdew75ud6jjQgvTmU2aHsROVpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcNZaxX9; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c6661bca43so2081830eaf.0;
        Mon, 29 Jul 2024 05:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722256933; x=1722861733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=50wQBaCWvP3be2O70xJY2fE8pNdwE9rQr3qC/amQcYw=;
        b=HcNZaxX9wn/c54JPBFq0Feyq6pjH1fzjDCYYdcA7kIHDAGvDCoz0B4qgltXOJ5owp+
         FDJJ5Qp4ADpU005k11/weZMI2lBetwL1UMWgJt6UIo8fxn6q1+yP37ov9BOeUsXRgRmh
         xisJN2xBI2cAlhwLiOvt9+Tl7Ut/PH8KhnESAioUc0MTEK0+scUMh6w0Agt2HM05sfro
         lvwSG3YBDG3ygC27D+CZ3y3jW42H/9nY/sIcu0phXKF8xvMAp+0fhnyEEJHMPfPjTrQD
         ZQW2gau0vm8MwukUAwIEhJv7LQr0O0MNqrS0qr1/9mOlbHr4hD4lqgyNIWgyDweNn9Y+
         1vgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722256933; x=1722861733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50wQBaCWvP3be2O70xJY2fE8pNdwE9rQr3qC/amQcYw=;
        b=u31sL0DdIkVTavqEnm676UOZfzxLVRh511Hf014ByiakZ+2FOTkWfk72s4Zbnax/wm
         n+TfGDI/58rTdDQmT8jjEybBwwH5y8ZJQRSOdSEuF6OItQUfCQNv0CwsI+qf9QPFDaxZ
         xwgTjXM5D2dVEMRncx/+GpToBUvMg99oFIEfnLnkebAuumMEpYqoneoQNnC4hL5v/faD
         RZMG1/Q03zzGCGTPVdhftgEAamy2n5zGdxUzQo/jXfhJ6o/EoowkNHrgchU69+kxg+k3
         1eyjCtpDdA0T0bED0zLrHFfAGgSzvN9pl3EFdIDdIyGH8zSpCDcVcMeazfcXqP3V1FPn
         PfgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9DFFPF2sayH3/BRj+evk0uCRi7QxzQWywxslliO3Lkj7404AQlmjmC18tj8d+nlZkCflh6nYRXWAy26QoZZ8K8STakCfpT023ZJ+z
X-Gm-Message-State: AOJu0YycsxaYPhrrwEEU/WXK30jQSSBs2KtvqkCpgf7AhT5WPzWRIx2q
	cxsln/n781Cpp3XpsnxAR9Ciygn5kRC7iu2FGvN4LUWuN2ZaSVw8BFgpGHU9o0xCCXmbKqdkWtK
	hOEp1ZxBn/nu62GOa6l4yOxnc9GE=
X-Google-Smtp-Source: AGHT+IG/IhY6BOtJ5bNXqiz4PGv+OfLOMpBAfRFh10aPsIJL8RqIWHhrfvsbo4BUlSlSzpFY1NeSsHmByywldigtv6M=
X-Received: by 2002:a05:6820:162b:b0:5ba:ec8b:44b5 with SMTP id
 006d021491bc7-5d5d0ef49afmr8650354eaf.3.1722256933080; Mon, 29 Jul 2024
 05:42:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625104039.48311-1-linux.amoon@gmail.com>
In-Reply-To: <20240625104039.48311-1-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 29 Jul 2024 18:11:56 +0530
Message-ID: <CANAwSgQvJ8YxWwMUfNp3EEMocPCbi0jR=cLWFFgsFrK3QRr3KA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PCI: rockchip: Simplify clock handling by using
 clk_bulk*() function
To: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Tue, 25 Jun 2024 at 16:10, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Refactor the clock handling in the Rockchip PCIe driver,
> introducing a more robust and efficient method for enabling and
> disabling clocks using clk_bulk*() API. Using the clk_bulk APIs,
> the clock handling for the core clocks becomes much simpler.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---

Gentle ping ? Any review comments.

Thanks
-Anand


Return-Path: <linux-pci+bounces-11411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E08EF949EE2
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 06:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC17282C76
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 04:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2AC801;
	Wed,  7 Aug 2024 04:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKCFuj22"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E9C18D63E;
	Wed,  7 Aug 2024 04:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723005611; cv=none; b=rdaaGRajcIs0jnrrSLIfvsmCi1mkYzi6ST3tx6I6oOFCfY7v14qlgRF6exNa/GBXaZsT9eQ86UrRsWo3PQvcrKltqFmei7CXjSwfN2ySv4EZtefiVqQjOFs7mOKaJnLupahlgj/TvbQXnVouIBKqiirOevwHZjj819ho0TUAgXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723005611; c=relaxed/simple;
	bh=vputw6en5UM/U6FW3NvGX277Q4urgiLXbQEtEOomLNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQKp4/udy7IqqaD1APxg1En9aGFbfbsT5c/KryUnhxO1J6vxc57ppNIc51ccWI9EKlo4gejec1I+8UeK1xGal6D4wQQ+jBcqRrcJ4Faten/ygyX8ZD6XsUtTFlAVkOPamlsZsw68ejXI5HFL6HwEjzphjPJdB+1f1ifgjGCpJvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKCFuj22; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d9e13ef9aaso863167b6e.1;
        Tue, 06 Aug 2024 21:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723005608; x=1723610408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vputw6en5UM/U6FW3NvGX277Q4urgiLXbQEtEOomLNY=;
        b=GKCFuj22/vZVX8PdB3vCoIKcaE6jzQC/4+t8gokVojQ99XYyZjtKHjQ6Dd89zCupRs
         KbE9ne0G3WzmETuVw8b87+6iD7mYWFO/Z7WUz6s5JiGWvPXCPEZ5zcwXO6TWt2z0eocN
         /bU19vUXconjUtpBfJLCCOELa9NdpOmi2FF83qcoxRg8HZ2k2y5OXNFv4P80GopaH/bw
         vrAQwcEo4asoWHYMcLBWmxHy+Qbh2Jqxn0bm4yuPwXBRxPmnGcftYzU7zw2AUzF1PpxV
         dPpEOGzxP+SFWwuq52HNu8GfvKwHX0JZ6gaEY1nRR7aN3lDynmSMSKiwnzfMkJsF4lNZ
         AKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723005608; x=1723610408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vputw6en5UM/U6FW3NvGX277Q4urgiLXbQEtEOomLNY=;
        b=f2OxMLbhYkXzQfbHWx1Vy2E76dMrnT4xOHT7YB0rNS1QV++QKnFmYh/rapqHkUwE5Y
         L+EU502y0Z2LoLdokjDN6+YBT5Q/yS0iS6fwDkr4K7R8acvH6IjkOA+ccYMAYFFUZwaC
         o3W2gJvNEfLJnuJR3wnE3QvVaNvSuFSvR0uARKAnf6Lscgq4e73lWBTdSWM9sw1UFFCd
         lQGGFcmaR6fUXk96MvQ3BX7KBS08P6Jac6o3G3cX/YkzXg2P7SfNMniriEQuCuF9J60P
         Nh1dQ1INcVth8r24sWp9mj59RC980AY0Sx+cX6OZrvMYfWQweI+pT7nUkXySsCfpR6hL
         v/Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVIZH9uhAgxhRUOeDJZd5bw4uVwmRbR4NII4C7NqPF7PlWnYtAMZiHg+1rLBfuNQnSg766VQw8j29Ox9tXCMvZOj4VkQrXl5jJh73sD
X-Gm-Message-State: AOJu0YxmQNg8Kd1qNa2X/dtJU6JPXlxmllJ3WVAkrsHTCxNRnH8t/L3L
	jdMMIW/TmGf+GnhwQC8Fl6URf3B0anBLC94atDWp/z3Vmkv/LWsD1UfEAAMjkHKoGRulnrBpmDj
	tJFDu95U8N+n/VKlPxUW0eGD7YFo=
X-Google-Smtp-Source: AGHT+IFroz+WxNH1Yjo2QJuI+bBuCAZqGU9Q0IyIYNW7GfFp1a9rjGaeHs68lxVGlmKdcMqcPiGU0G3y5RuOgJGhM4w=
X-Received: by 2002:a05:6871:3325:b0:261:218:dae with SMTP id
 586e51a60fabf-26891ea8f86mr22541861fac.33.1723005608211; Tue, 06 Aug 2024
 21:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625155759.132878-1-linux.amoon@gmail.com>
In-Reply-To: <20240625155759.132878-1-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 7 Aug 2024 10:09:53 +0530
Message-ID: <CANAwSgRP3m6hY7cNeBv6EXavoApZZ_zmemStg2v__iK3DLm2ig@mail.gmail.com>
Subject: Re: [PATCH linu-next v1] PCI: dw-rockchip: Enable async probe by default
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Tue, 25 Jun 2024 at 21:28, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Rockchip PCIe driver lets waits for the combo PHY link like PCIe 3.0,
> PCIe 2.0 and SATA 3.0 controller to be up during the probe this
> consumes several milliseconds during boot.
>
> Establishing a PCIe link can take a while; allow asynchronous probing so
> that link establishment can happen in the background while other devices
> are being probed.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Gentle ping.

Thanks
-Anand


Return-Path: <linux-pci+bounces-43767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D40CE495F
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 06:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12BB2300C6C3
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 05:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AAC25BEE5;
	Sun, 28 Dec 2025 05:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbfKqeV1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA565258CED
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766900911; cv=none; b=N41IgN54TWX1Hs5V+dnZ3AZp7hT6Y1HQpm0DxGr5ZoMnL8RnO7kVfpAOzvV7VTSl8LQYyOVayinIvGJBVQa5bCZsLKoGuC7etiIr3M2oYWXemWXC7InAVYmx7740LuDpAKtEH9WD9kWnVGblWZsw0/FnSKwDb+DaRPz7P8wj1I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766900911; c=relaxed/simple;
	bh=1pJCobo7skl3IqJjut1/aoDj5JGv6MK8u9FvD8pNb2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xv3y8S+zKS/iC8FLYwR+JkUK+XRX2YyvClE7hq7WD/pVlDpEx7hj9R7pOwHkvyQFrsR9ZclzHhxzUxMU61iDoKlFoaAnbbA+AW0copBAkFOTs/5drCX7uh13cttncv3JVr+rqw5CqI9p5pT1c5I7Ei22cWM5bobmV7LxPlog6ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbfKqeV1; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59581e32163so9646056e87.1
        for <linux-pci@vger.kernel.org>; Sat, 27 Dec 2025 21:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766900908; x=1767505708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpbqpIsug6MH33BRSdVEMnAsF4zSM1dpRpn6fI+y1V8=;
        b=JbfKqeV1R/D9PDEPPrpO1wYpIfzCnjYN8WzGCDsrD7n0KnJV0u3PDx7jcRD+sYwnIA
         eVLB3CpQB849HOmn+7qyvDAGHdjogV/RbhTM5RC3nhmHCZ0TyW6xK3JNdZNaqYQmvrUg
         cdF2N3n6AHfVPNdJ1ryI3wA2QGNWbPVUL4Yf3rtoYhAqO0T+o3WymyughkijcxLCR87V
         +fnF79OAU7EfREe3nNHWZEso4Y17g0IgnlTErD8PjLZJPzIMAvaP5vrtBPD9WVBks/2a
         8UcdzNEASY5xEWPA2yfKwUq+h/WI08DI0xTyf9s2SAxgEpPfJCz/aEfymR47u8T5Gj3+
         bs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766900908; x=1767505708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gpbqpIsug6MH33BRSdVEMnAsF4zSM1dpRpn6fI+y1V8=;
        b=Uw6liEyGTjwwxImVwjz/XcDO02Sa1eEoWJfqaaQaYKsUk3nJ+cfzI2t69msflPjXnu
         4gjpTRGpE7YL3wBf0Cwmy67vVsrWmT7QVvuauHhY0Stz1To8hUkMZxscbTLaWBfgVFyK
         4gff4Ld+QqZNcVfWnzjp9tRTu3CSmcJ3Yu0oRWBO07k7xn5XYErpJ44+bbNv6q1XwLbb
         wOAeg9TiY7+hJIGnRe2XfMw25PUClfJboyvIQBVGiptcf4P/9GXmDns+fLB6zac9TCpN
         fTGy+O+/cktmMkN/8gUPfXsid7IeHKAuOWenm9V4CrWKvWIxmwGtoU7a8aBL8KjrwmW6
         +ghQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEoV2b9hzEOn9FmoyORV7xtowUpp+mUasUVv0LcqOP9QXPjJNpbpHnBPVCkjcfHYTb4cqC4YIg5gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YydtNEb3k3JEPvDVhflXrPi+QVQZqTBCMNv5ZKwSH032F1Mq3Pl
	z1MkEh5lkHN39yRccscFYebRWu6EpnqZxoUSphtz5QHxe919Z8Ys9r89
X-Gm-Gg: AY/fxX7nmQ/Pv/2mcSHVENhK2DIUw90TMWtqpnFvWYPV7o/9WovOg/ie5+G4rD/HuoD
	nfurYSN3CCiSqdR72GvXce3+3+CEQteuqiFVLmSZAb0II5JCB8ZzOAqF1z4Hw6B18/pmO5Ug722
	ZA98f2lIhHsvTWr0IHnRPi7QuTmiJ/oK+WWUaENM6N0/aL8jkpJs/VuZBHBne1XQukZOGke2zBV
	o95CR7HrAaqYk3rvDVn0oxlJR+G+DEuU7yv+A35BUEyU0BUuiLCDQSE0b1t6cFMrOQxiMerpURz
	DD1vYDDnN0oLsiGVZFTId9uyraxXTUKWceZBuz011K52e0PnaZK7bgdiM17mM/lnImCkiC1vLip
	n38Pif0uSmavNRmR/1cu9Tjqe7eQ5IYd3Sgv7xBPXfP9eRO5RgeHerhBvn2sQghV7PBZIAG+yBa
	wheflRbpGSyhYSRzdzW68=
X-Google-Smtp-Source: AGHT+IHbwDkZ0ZrkYZSKb3xcvqlBhmZdaEoQdezjtjNsk1jz3+5apfKEePyLYdpuFJXN8OT07eFG0Q==
X-Received: by 2002:a05:6512:3b9f:b0:595:7cb9:8e51 with SMTP id 2adb3069b0e04-59a17d1fa1dmr9400930e87.12.1766900907593;
        Sat, 27 Dec 2025 21:48:27 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-59a185d5ee4sm8077427e87.17.2025.12.27.21.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 21:48:27 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: nfraprado@collabora.com
Cc: Tim.Bird@sony.com,
	bhelgaas@google.com,
	dan.carpenter@linaro.org,
	davidgow@google.com,
	devicetree@vger.kernel.org,
	dianders@chromium.org,
	gregkh@linuxfoundation.org,
	groeck@chromium.org,
	kernel@collabora.com,
	kernelci@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	robh+dt@kernel.org,
	saravanak@google.com,
	shuah@kernel.org
Subject: Re: [PATCH v4 3/3] kselftest: devices: Add sample board file for XPS 13 9300
Date: Sun, 28 Dec 2025 08:47:42 +0300
Message-ID: <20251228054804.2515185-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20240122-discoverable-devs-ksft-v4-3-d602e1df4aa2@collabora.com>
References: <20240122-discoverable-devs-ksft-v4-3-d602e1df4aa2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

"Nícolas F. R. A. Prado" <nfraprado@collabora.com>:
> Add a sample board file describing the file's format and with the list
> of devices expected to be probed on the XPS 13 9300 machine as an
> example x86 platform.

And now "Dell Inc.,XPS 13 9300.yaml" became the only file in the repository,
which has space in its name:

$ find . -name '* *'
./tools/testing/selftests/devices/probe/boards/Dell Inc.,XPS 13 9300.yaml

I kindly ask you to rename file. New name should not contain space or comma
in it.

The file name in its current form breaks tools. For example, it breaks
"xargs".

For example, the following will work in "fs" directory:

stable/fs$ find . | xargs chmod -w

But it will not work in root of source tree because of this
"Dell Inc.,XPS 13 9300.yaml" file:

stable$ find . | xargs chmod -w
chmod: cannot access './tools/testing/selftests/devices/probe/boards/Dell': No such file or directory
chmod: cannot access 'Inc.,XPS': No such file or directory
chmod: cannot access '13': No such file or directory
chmod: cannot access '9300.yaml': No such file or directory

-- 
Askar Safin


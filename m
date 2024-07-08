Return-Path: <linux-pci+bounces-9919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BA4929F9D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 11:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03011F25068
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 09:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5345D6F2E9;
	Mon,  8 Jul 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IlOzgrDe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D192C41C69
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432459; cv=none; b=K50BHSkr1fmuBJ9Y7ZUF/+bls/C2vOOZg+f0N+tpTKXKqavZGa2FEgSQUyLKHNEx+UNclLSnca4LwLyzJAaHcgcmNAta8RPbIO4f/Vj+4Se/1Iro8iO7mauR4yPYdCbLKKzEaS+m71/DouUoIExteU8WZtLbk9yNGiBbJTTDn5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432459; c=relaxed/simple;
	bh=TEuaV52Fw3AReX5B2xdSJt9o36RSvuVuXFqTGWhfVpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTUmhQAPsQgfjlV1jh7nn9mSrVr0iPIQuzt5CmTsTCkoJZHS66+6hUoqPYC8vyc9E6iBZDMi1MC//MsU0G8JqJsU18HXQ+oRNZqPnmLWsqs2RtDiQM3QkC+4mwi5voZpJaG5KW6H8s1amoXlN0Gcp9yVnnTbG0jUPpNWU01QtDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IlOzgrDe; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4265ff0c964so12014145e9.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2024 02:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720432456; x=1721037256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjLXoVowh+lTUTYcsGJih/+hXZkO7j1LpjGmonKAPpM=;
        b=IlOzgrDe6lVxhrZPpytSjdk3s+/Jc3ZGIGBR4DVhOtAzSaDfVJxSX9iqYcKQGUOFSR
         gNZHnnMi1Quo36S91TUYybd8EdmGgJXnHDKZDl0MEd6vzkzS2or6RYQ0k21yo/1UWGlG
         NsAo1d32mmiEG0JwUxiWIiyiYYCy/98rH8BDUe0OOsD2r6tuzHCUznPzEONrD9M9tel5
         YPs1mCuYeFGVgB3CBTOvdsPb2mV3aqU5boFzdKVDhyN3b/GYCRq3FRE9KlMFMzPvWVbt
         LTXt7avF4Q/OkfF7OBmoPZ4AMHtXISMQzICFUvZPcaLnQTk4gCsPKmpyRy0W8z9ArkiT
         Eidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720432456; x=1721037256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjLXoVowh+lTUTYcsGJih/+hXZkO7j1LpjGmonKAPpM=;
        b=sel+KuRkjbjvwExklqrRCMibELbaJJ+a6lNn7t4DGOqZjYUIbFiatyPPoGCLdZDcEG
         2Ixd60J91eEixS6JWWdfJt4bQQZvlrrOz5oOO6MFU2LCDB25EEqfompNr77goS+U+4hl
         jt0krDSK9hyTckwk3nO6zN9xqnAPvqNXbiz3LL9wiCsBZJLbS2axfPeBCD8E241Gr7N4
         9xBGBt9mT8FoErXNxVURIol+5ioxzSsiqfkeHYl99IACZ6fFI/hxBYduOSUzeTYJ6LIF
         uDN1LhlH412gh9TI9nXwN8qAqDlAZxUTCx0L9cDFn4F8m8WWlZN8JYHfMRv98VeQKehw
         c37Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbWamaTjzk76Eu4cbXAO2EOrIBJ2i2zsavjiIO7hra9UTdxFzq+i1vmvDyKQ7lharXTeO9Wbqeun2yVu8XUbxZBOPpuUomZG7f
X-Gm-Message-State: AOJu0Yz+KTvYA8hhEF8a5XSTVs8OS7zu8k9kkFuv65QCi0elXzZLsLa/
	WyrTkYCT3iMUviDFr/Zl0Ol2jesLqSLeIkIZo1qLlcCghuFPXUmHFpPVqN9CIyQ=
X-Google-Smtp-Source: AGHT+IHALUzocYPlrZWoFdTJs5DD33ZIq+V2Qy2yma1bExbYlrX6OlgqOmXWrumccKIJCVL4il+mUg==
X-Received: by 2002:a05:600c:190b:b0:426:5e91:391e with SMTP id 5b1f17b1804b1-4265e913977mr38910635e9.26.1720432456186;
        Mon, 08 Jul 2024 02:54:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a2a3:9ebc:2cb5:a86a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a5a31a1asm8628598f8f.7.2024.07.08.02.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:54:15 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	caleb.connolly@linaro.org,
	bhelgaas@google.com,
	amit.pundir@linaro.org,
	neil.armstrong@linaro.org,
	Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if CONFIG_OF is enabled
Date: Mon,  8 Jul 2024 11:54:14 +0200
Message-ID: <172043242741.96960.2619738362693641818.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240707183829.41519-1-spasswolf@web.de>
References: <20240707183829.41519-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Sun, 07 Jul 2024 20:38:28 +0200, Bert Karwatzki wrote:
> If of_platform_populate() is called when CONFIG_OF is not defined this
> leads to spurious error messages of the following type:
>  pci 0000:00:01.1: failed to populate child OF nodes (-19)
>  pci 0000:00:02.1: failed to populate child OF nodes (-19)
> 
> Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
> 
> [...]

Applied, thanks!

[1/1] pci: bus: only call of_platform_populate() if CONFIG_OF is enabled
      (no commit info)

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


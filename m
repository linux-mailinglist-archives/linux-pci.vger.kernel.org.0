Return-Path: <linux-pci+bounces-8659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C2390513C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 13:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9B11C21322
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035D116F0CA;
	Wed, 12 Jun 2024 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bO7vusRs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3677C1534EA
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718191311; cv=none; b=LK4xbGc3OthjdHQQcg8nIxv+oPG49DU8Jt6iKhylb98vMx6k+UiAXGwFQuRyG7/PrgNnhVO5AZv6RFZZw+dZab3zAKoHaILqCM3TtJoTNeaktAQDf940C1/g6+8QyZb+mI6sOfNGZtyJT0FOV5mC8RuajLZhm73Lp/VN+KWWSjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718191311; c=relaxed/simple;
	bh=uxlKCAm2txGIagWscbMXXdaokJMxFy7SF3oG6AgNQcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKRryARWpI+OYsdENnyttVQV7dPq2l93XYNZjsqK3pKF4GQWnoggTqJ2l2SJ+cJVSxYJFZx8rI4O6cEzL4vOD658Th58Ilc+Lzu+Gr8vKqVLGV+5/RQFF0zJ1mxPrqpDuzSkIj+R8VJVhfNmXmu2wChWkb/4hHa7HZ0tPP09z/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bO7vusRs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4217926991fso39786135e9.3
        for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 04:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718191308; x=1718796108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gidLaYRgBr4ZiXlMA4QHhxP2ifbUc6V3Fe/pQzts44E=;
        b=bO7vusRsFWcmOJrtLRXJ2Eh8fr3UXfikIwp6QQdYqTbOqCT9ahEDPi2sCX+EKTOe7x
         w5hVFwYVWYA2et+jzdv124TymghwjeKdWDZRStHTf0QJrUFQ89kUGrdMVU/zz4lcqfap
         CiF7l1vrPNDhn0AjHDtAKutGBMt6A5/ONl2FOSmHhEh0uuoDIDOwNXIBqpZfX2yrK0ZO
         DZ/+FojvfzYygjAily7lM4CMjHmyoQkukN1Ymfy7pO1Bdc6YLjvX/UBTzEX/qHwk3cJK
         vMNtSu0/+k/rQz292OucS0VHEYKt+X7UG057E9MsPptjsyBtLVcSh3ZxX+1WkI+1LnpB
         SQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718191308; x=1718796108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gidLaYRgBr4ZiXlMA4QHhxP2ifbUc6V3Fe/pQzts44E=;
        b=ElXm3icWkZrrzhTObezJMoqiDyBYxf1grEoU12saMFrLYnehGU31mHd9g4Y/KETpeG
         4u+PplMUdzHpkl5cRsqN3m+XLeiwOZS0xpetkqTFGjc6OMHQ8Af4qerJv3vm7Om8uNoN
         eR1wnwOZvCgRAFrsAFXTBND5Qe5tyM+1iK/j3ZGyM4ThNSURk5XvlFaEOjW7zIivLPCd
         TZvF8MOt6o1d1uBfh/aiqUrfTYXKBlInjlRWBa8NvFjB+fRCokzdKxO7dps25zlv/n1r
         zRDErl+5mvBZzr1Co1F2j2xScAu5HddUpZv0qAjsZEQh1QdBKankA2X5PEq5cdsQJ5UM
         rXrw==
X-Forwarded-Encrypted: i=1; AJvYcCXT25fWv2dFr74RlGcTcODh5eAnIhgaFmJTtzSI7QHwY7P9bq508Qa9MZ/mXfmkgb0IK9fPCbyepnPEcHXMWG0bw9KXIlaaQMig
X-Gm-Message-State: AOJu0YyxA4/a9rfMMIicDeta9pf1BEUkx9VGuLqOerqcHp9j5rurX05J
	3FnitW/n0rumX/pa5HbORtTijMKMfQzfgUgrcTRjSiyDEZSQlNlbK9QVvy3HDc0XeRgBIqdJWN4
	q
X-Google-Smtp-Source: AGHT+IHcU0QhXukZEQ9aIF8NXpANofNp/2zJEo6ILnTzlDzqhmpsbba99qMIc3kT8Fwfq/Z5s+/NIw==
X-Received: by 2002:a05:600c:1793:b0:421:79e2:c957 with SMTP id 5b1f17b1804b1-422863ae433mr12657625e9.19.1718191308233;
        Wed, 12 Jun 2024 04:21:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:a172:4e8b:453e:2f03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe92c6sm23337985e9.18.2024.06.12.04.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 04:21:45 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 0/5] PCI/pwrctl: initial implementation and first user
Date: Wed, 12 Jun 2024 13:21:44 +0200
Message-ID: <171819130040.25408.1481825727128724197.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612082019.19161-1-brgl@bgdev.pl>
References: <20240612082019.19161-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 12 Jun 2024 10:20:13 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> I'm sending the PCI part separately to keep the history on the list.
> Bjorn acked all of them so I'll pick them up later today into the pwrseq
> tree.
> 
> Changelog:
> 
> [...]

Applied, thanks!

[1/5] PCI: Hold the rescan mutex when scanning for the first time
      commit: 5799eba8eeabe79a476016f22a7aea57467b7638
[2/5] PCI/pwrctl: Reuse the OF node for power controlled devices
      commit: 62c953f0f4fb0b5f67b0ad3096ab38f5c5712d75
[3/5] PCI/pwrctl: Create platform devices for child OF nodes of the port node
      commit: 8fb18619d9102e8f4f6184cdac482422d9293b48
[4/5] PCI/pwrctl: Add PCI power control core code
      commit: 4565d2652a37e438e4cd729e2a8dfeffe34c958c
[5/5] PCI/pwrctl: Add a PCI power control driver for power sequenced devices
      commit: 6140d185a43daa298d43453929560388d6d49b6e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


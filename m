Return-Path: <linux-pci+bounces-44163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B53CFD13D
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 11:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDC27304ED80
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 09:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7714A33032C;
	Wed,  7 Jan 2026 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzYtDwS2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BF132FA2E
	for <linux-pci@vger.kernel.org>; Wed,  7 Jan 2026 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779684; cv=none; b=RngarsRRog1jqbtgAR5gbMZkkjJ46vMi8/YReUigibTzEYVpK638p2h0G9Ws7o4D/yfliLLheI4MdcvwVBA3/Xdu5jL7pTkIpsTV4jYP0l4r6ahoAUK/XMIz7EgEsMQq3JTuyDfRgtnkJYno43R2SBl+IuHwp4XNlHkaK9Yuztw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779684; c=relaxed/simple;
	bh=ANYs6i6trLGcerht4yR1tZmU8onsevcVhIQsE+VbHQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aK4wajbWg95PrZCCzF5o/t1AJMWq7hrWgv925/DpsVY4AY95XHQwU1YiWFFC+6/kGo1Qv5kgTwTAMK04lC4vft0NMB1fJhgIXx8hEDSSlYn8a+V+kg9RtLVC2OFq8IspnwGe2JM6NQkU+bO2RtgfUNIx5uTtDg/jdw/2OOYexPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzYtDwS2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so1944153b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 07 Jan 2026 01:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767779682; x=1768384482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANYs6i6trLGcerht4yR1tZmU8onsevcVhIQsE+VbHQM=;
        b=gzYtDwS2mYC9RovpNcHgNQebi7B/n13yvzxBb01+nbvR0O9Ekau1MxVTry8SSYYc76
         5lK4MiydPKdpaHgyd5m+SJPNHl+RsdFVG+R+semjb3nR3GWatXikB0uoVDhydLJLeeV5
         i/nQ0ETtHM6nzFOontNVJMS4npVCgJfUAknms5BzqneulLzQ8YC1WaDdk1sryfVdN8Ni
         gRIgyPmYEHrnftIgcP3Jh20WEqArGezvvD3K5FHfeCon8OC/178dAqtI0Lg6V9T47lQD
         BXDeCvk1Gel8slQdqBGdY5ioxff8BsUcwvJBoI21LUBgAMvyuZ5P7EzHFCWW+ATvBrt0
         JK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767779682; x=1768384482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ANYs6i6trLGcerht4yR1tZmU8onsevcVhIQsE+VbHQM=;
        b=qC0lM6/s5S+Z0DTfOQL+leco0z7HM2sYR+7+wJNN3AadF+0AHs/FOb8CIEVhQkHT4a
         25go9a/RF5TALcW1Y31aLQJO/v4+qH3LxCEC6OpJSp3/Km8h8DyMgSMSRdKTNbNwWajZ
         MeF5X8TQo9atLFA0aY73uTVRjg5WLH/KkplsK0HNdxDJ1mxiF38YbHgD5jo5NqVh6ZAn
         HCxrhKEM+Bp+OHyaNyIXWK+eHIjqGsZJdzTCLaq+pds2ecm+lSWptNCcvV7ctDYv7Lzv
         +BbP/ekD9zD+aNFfQvPH2y6e/mU4HRxLkOxOjyXVAQGEJ3G6xwzzsICfqr7EmublvVp8
         H8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUSX1tJw9OHeIZpX+gdRfaT2Wv++4J8NV2eEvs6fBNFjQKCc1fU9nKchI7pqhKA8EcDdtmKqsRzhok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTaVdhBc8iwTlHZjFG93a9Szh5TgBkUn+uGDFvaiUtLi04B7oU
	O+HbvNTK08uRCU1wR89+sGraj4DivcinzK3dTa1X4lXA/fvubiLOffU=
X-Gm-Gg: AY/fxX51JvDBkMUx5lv4iRbmvMri4Tf4oN/UtACywDkNkS+8dlXTcC02iArl5wJRR94
	KKghXsrm0J6g0RfUnY+mzu559vDAojGuZM/qdkzeTD2wXW/vJd/6v+SC2SZS+igcoivv9N0Ng7b
	lI1UvzF2WDy/r7Mp85SNs+uZ7Vi7wSiN/HEavCTzXWbKKOoq5vluzwK+789pKxtqXvdGdtNe2SU
	aqB3gzL/L5XX11Lue/zysMpeM7gCU6P1jL7Tc6Oc2VUnFRzmvBe80/X4ICAWUUsM8f1qfJgVL8y
	7VL7/NmLE2f8j5BJvWgA3QHzYN4gQP5uc77snpGGak2qI3HzSwTnzYv8J6/KK+1ckBavOrctZSY
	/DY528p0K+jSrXtzZ8690XTO5b1EDYK8vbO//kF0umBriB1eSEOxItuZtHk7kJOsSNFwJ5J6Wr/
	IqWOLd3dmItU/rd+8=
X-Google-Smtp-Source: AGHT+IGAXBAfvt9+HKGFTfnKpIlZhyLpeWAQmEI7acjOkyIBy2z200DLidZSG3Vic7Jdxr5MpccL5w==
X-Received: by 2002:a05:6a20:7287:b0:35d:d477:a7f1 with SMTP id adf61e73a8af0-3898f99146bmr1696314637.43.1767779682366;
        Wed, 07 Jan 2026 01:54:42 -0800 (PST)
Received: from at.. ([171.61.166.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7c2666sm4557245a91.5.2026.01.07.01.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 01:54:42 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: YehezkelShB@gmail.com,
	andreas.noever@gmail.com,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	dave.jiang@intel.com,
	feng.tang@linux.alibaba.com,
	helgaas@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	lukas@wunner.de,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	westeri@kernel.org
Subject: Re: [PATCH] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Date: Wed,  7 Jan 2026 09:54:33 +0000
Message-ID: <20260107095435.1390-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107093021.GN2275908@black.igk.intel.com>
References: <20260107093021.GN2275908@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I’ve been using the mainline kernel
(which I compiled about two weeks ago),
and the problem still isn’t fixed,
so PTM is most likely not the root cause.


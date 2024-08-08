Return-Path: <linux-pci+bounces-11467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6429E94B4D9
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 04:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27051F231D3
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 02:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38197D2E5;
	Thu,  8 Aug 2024 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gP1BKuTw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F7C8D1
	for <linux-pci@vger.kernel.org>; Thu,  8 Aug 2024 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723082885; cv=none; b=T76w05PRWccDxoSnbWSHexj5HVz2Kueq2AAyh2YfDPJ2LksYtB+1rpsiCFh3Zx6KuP9rXY5JeUgqk/8JLfx2XxK35H2VEKRknS9YC05Ua5h3ag1FTmjzVSiFGJsFA7NOFAtZE2WxkwdYxNOLX7+N15ay3qhldDMDsT41tbH4ecM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723082885; c=relaxed/simple;
	bh=l9YwhAKHI/Hi3XQCTqsr2QfZizhIngyNc507Z4rw21M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TKme6GXMLcWg+0chc6CxbyYRdazy0naEnFdayiX8B/0XW8VADW2e8ZOyNHfHCAgl5tR1/HzhT/l7gGMqUEGMaBI6oZhIp1QZIv59jJI5FWC6LuQE4q2UA6O591MTz8S70HCp85frkdK0o4WdYku+i79d9slXWP4WrFaOGgCsVDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gP1BKuTw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so415000b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 07 Aug 2024 19:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1723082883; x=1723687683; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l9YwhAKHI/Hi3XQCTqsr2QfZizhIngyNc507Z4rw21M=;
        b=gP1BKuTw+a+yYDiqsW1MJHfHlmB8GPulJPULgQzB5celpZpb9Ti454ujZ+RFQXZfa1
         YmP0Z9i6A3OSBh40hTHnRnM2zBzJamYh5qaemwe4SzqhD0+3xvZ8He8Fw0JCW87p/YA3
         VJaVXdfcjbAenwxpZYV1YrUJtZvuVPFmgWSMmX4XGFCTXmuu/A5HbExq4S3750JgDa8S
         x910lGYUW3EAwQ145Xux96IWYNyt0a2o6BR4JJj1Kw3lffjucuXS07HDB3LILqpp340i
         whZhSP7E9KfXNowcpLYccFy8wM5J/jNOnakMRug6nnhDYDun9UqVmkBhAd5WTijxCnTY
         ECLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723082883; x=1723687683;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9YwhAKHI/Hi3XQCTqsr2QfZizhIngyNc507Z4rw21M=;
        b=WkFgTN0ozyBm1KWZMm+FqCrjaNW3/MyIb+WZn5ulrGyn/dh/FESL/Wc1tlmWbuCy8Q
         tVXkRnthfIxo0k9LgNA7KWEnOpTECYtka9Ff/my+biCVlrYmw1bxQCuLoM97Q3XBHBR+
         INEJ6GyVuaEsy8MpIe7QrwklpBnhQW0+MBeP4SX3Ldzy5b39ezIhHEcwazpNC/eT+qwV
         42MYoUHC3Q7vxbhl/gf3NuwOgepccIzXia6ytErtZP4jtEDwB9MohYGUFpd63O/VlmXV
         o/mRl2HMDs6G2GqyXoiILSkq/kbobWtUKu4xHZc16VFO6fCqwjd1Tkfls6rpOeZr8daJ
         Rupg==
X-Forwarded-Encrypted: i=1; AJvYcCVw+TWzK1WUnIx1ew2GXcnNw0t8za0BJZS3PwD1JAsN0mnUIEpvHu/h7pj9apT2IzWos8aU0E4hTNnOeTJuNM9OFJPDDfcA6IBO
X-Gm-Message-State: AOJu0YxT6uapzwPPuEyhZcLNSTnSy0I25vVWj8nh9U/V6icIjm+F03UA
	6OWyaPJqPrRqtOZ4l1Wn32HSdXaOxDfbDailR0i5en9M1BBAmJ7v3cKX1TXg5zQ=
X-Google-Smtp-Source: AGHT+IHrHVJyd5GUPNY5EbdWEh8M+WDzur8o6xEuv0h5JmUwie9vm1fBjf/yn0ON4rdG2GZrCOmcYA==
X-Received: by 2002:a05:6a00:2e1c:b0:706:742a:1c3b with SMTP id d2e1a72fcca58-710cad8df81mr620125b3a.8.1723082882674;
        Wed, 07 Aug 2024 19:08:02 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710cb2e56e0sm161141b3a.153.2024.08.07.19.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 19:08:02 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: macro@orcam.me.uk
Cc: alex.williamson@redhat.com,
	bhelgaas@google.com,
	davem@davemloft.net,
	david.abdurachmanov@gmail.com,
	edumazet@google.com,
	helgaas@kernel.org,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	mattc@purestorage.com,
	mika.westerberg@linux.intel.com,
	netdev@vger.kernel.org,
	npiggin@gmail.com,
	oohall@gmail.com,
	pabeni@redhat.com,
	pali@kernel.org,
	saeedm@nvidia.com,
	sr@denx.de,
	wilson@tuliptree.org
Subject: PCI: Work around PCIe link training failures
Date: Wed,  7 Aug 2024 20:07:53 -0600
Message-Id: <20240808020753.16282-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2408071241160.61955@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408071241160.61955@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

On Wed, 7 Aug 2024 22:29:35 +1000 Oliver O'Halloran Wrote
> My read was that Matt is essentially doing a surprise hot-unplug by
> removing power to the card without notifying the OS. I thought the
> LBMS bit wouldn't be set in that case since the link goes down rather
> than changes speed, but the spec is a little vague and that appears to
> be happening in Matt's testing. It might be worth disabling the
> workaround if the port has the surprise hotplug capability bit set.

Most of the systems I have are using downstream port containment which does
not recommend setting the Hot-Plug Surprise in Slot Capabilities & therefore
we do not. The first time we noticed an issue with this patch was in test
automation which was power cycling the endpoints & injecting uncorrectable
errors to ensure our hosts are robust in the face of PCIe chaos & that they
will recover. Later we started to see other teams on other products
encountering the same bug in simpler cases where humans turn on and off
EP power for development purposes. Although we are not using Hot-Plug Surprise
we are often triggering DPC on the Surprise Down Uncorrectable Error when
we hit this Gen1 issue.

On Wed, 7 Aug 2024 12:14:13 +0100 Maciej W. Rozycki Wrote
> For the quirk to trigger, the link has to be down and there has to be the
> LBMS Link Status bit set from link management events as per the PCIe spec
> while the link was previously up, and then both of that while rescanning
> the PCIe device in question, so there's a lot of conditions to meet.

If there is nothing clearing the bit then why is there any expectation that
it wouldn't be set? We have 20/30/40 endpoints in a host that can be hot-removed,
hot-added at any point in time in any combination & its often the case that
the system uptime be hundreds of days. Eventually the bit will just become set
as a result of time and scale.

On Wed, 7 Aug 2024 12:14:13 +0100 Maciej W. Rozycki Wrote
> The reason for this is safety: it's better to have a link run at 2.5GT/s
> than not at all, and from the nature of the issue there is no guarantee
> that if you remove the speed clamp, then the link won't go back into the
> infinite retraining loop that the workaround is supposed to break.

I guess I don't really understand why it wouldn't be safe for every device
other than the ASMedia since they aren't the device that had the issue in the
first place. The main problem in my mind is the system doesn't actually have to
be retraining at all, it can occur the first time you replace a device or
power cycle the device or the first time the device goes into DPC & comes back.
If the quirk simply returned without doing anything when the ASMedia is not in the
allow-list it would make me more at ease. I can also imagine some other implementations
that would work well, but it doesn't seem correct that we could only give a single
opportunity to a device before forcing it to live at Gen1. Perhaps it should be
aware of the rate or a count or something...

I can only assume that there will be more systems that start to run into issues
with the patch as they strive to keep up with LTS & they exercise the hot-plug
path.



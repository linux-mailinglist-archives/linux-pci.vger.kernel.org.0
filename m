Return-Path: <linux-pci+bounces-10983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B226593FDD8
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 20:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D30E28348F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 18:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F11018734B;
	Mon, 29 Jul 2024 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LuEzdrCs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE666187330
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279401; cv=none; b=TMBsHZDXiBoFyYtioTOzcHHGZYpOVs2jZUJvxOwYBkqRWKvlJiAabXIWLCN7e41sl5/yktZ0FEwd9mlJz65Uh9kNFAvN9Y/lYJqUW+X/dOmbq9efQ31rmn4m5yoTEk/wXvcCSKWBjznZUEq5bp7D5klXogJZ9YJDB3yPB91h7qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279401; c=relaxed/simple;
	bh=KzEwxQGj+0IZOLuTF4KLdIouOQ7maqSg1CPSph8L8J0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJ/d5E1U705gadwydXbeXdfWMepOhB3e3/ss1mEcDowdIS3c7wF9ycncrm23Psd6g/s0YAk7YAWk6CUtRwN31z2bVQK5PS8TC6jlsOUJQn30otcz8lrtEzYxZd/axVH4blzu+Cr18DyrG318wWHjc7z4IMsj0q+Tm61ajWHAecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LuEzdrCs; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so2507389b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1722279399; x=1722884199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzEwxQGj+0IZOLuTF4KLdIouOQ7maqSg1CPSph8L8J0=;
        b=LuEzdrCsOVn1VsRbyBBCfQrgyIJs9c1p2Zvw0TunZnM+nLnDq2xAcR0gtgAnLWW+tZ
         Dmn0r4reZn4Ngq6Pe2ls79ZEYIRaMEjkNp6/AOoFBTHVGyVhNGll97LHhL9GTzOzqFTV
         Y3L3mOWBhHZ9nfsp/zqIrsYMbF0PWwmxWELHU9CPrxcpbYizgO+MDK8NxcwVMoMz2ide
         hcBg7tXsVoOmNV9v+vK5LZerJLscC0QaAWaBcGoRJcE+lXJl21FsPja1UUAeKCq3zeaa
         mZHLtKcF2gFdlbym0OUs531Umqk3ywgemS1WGOnquOhMi+V7YW2FONe4QQ+5gi+ZSwFv
         pmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722279399; x=1722884199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzEwxQGj+0IZOLuTF4KLdIouOQ7maqSg1CPSph8L8J0=;
        b=R50WDpB92xcCdOoJFNXdhzNTOTPSPuHjAnDSM3zurXzcnbY/PQq2JbmdxAYkaimKWS
         de3KybI4cZUT/z4lrA3sWO+ezdFxxhNH8+cC01eGHyLNBRPOsOeeSHHjTnTBXSXJygFh
         h2aR9JWllBPZIkDksS1pyMNZ/waxyMjh7iovKIpa2HtQ5HstxcGvtqm6YSXYio21ROgo
         Ce/R6tYtwoZKNM3ljEoo6DlbgrL1AC7xOZQ0LnYrvz5rGwnfB9jGK6cx3hktfxFfPgQL
         PlEXKVsAcNtd23TJH60ucQEkFgY3nbryY5F8rzIylHyar4xbdBXDkny4enbgpxuvVa82
         Opiw==
X-Forwarded-Encrypted: i=1; AJvYcCUevkYWBJW2ln/hgeXqOtE8SSPpqRcr7BqomrgyvWeFJtnETfUIVh7TG8l5czWEcdNX0yz1bArqjpJOE7FuwsIPxTaRgvAJHygt
X-Gm-Message-State: AOJu0YzXHemsDStdVVOGuxNCZaWaoJPeShXm7Lcnxli04ngGKPZxyl9i
	75Z3IQhm2bGaws4iRIoB1YL+54bIkN03WEgurpFcA31OULWqkHBxAFW6HicMSI0=
X-Google-Smtp-Source: AGHT+IHp4G/eNIx4GLsebVJC5eA3zOPjD4ezvkrqqaLtoBYO/pkdRShKVSU014d6+Yn8k2Pau3dazg==
X-Received: by 2002:a05:6a20:7f94:b0:1c4:8da5:5825 with SMTP id adf61e73a8af0-1c4a0e05515mr7565769637.0.1722279399232;
        Mon, 29 Jul 2024 11:56:39 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7c8cfdasm86722845ad.41.2024.07.29.11.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:56:38 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: macro@orcam.me.uk
Cc: alex.williamson@redhat.com,
	bhelgaas@google.com,
	christophe.leroy@csgroup.eu,
	davem@davemloft.net,
	david.abdurachmanov@gmail.com,
	edumazet@google.com,
	ilpo.jarvinen@linux.intel.com,
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
	mpe@ellerman.id.au,
	netdev@vger.kernel.org,
	npiggin@gmail.com,
	oohall@gmail.com,
	pabeni@redhat.com,
	pali@kernel.org,
	saeedm@nvidia.com,
	sr@denx.de,
	wilson@tuliptree.org
Subject: PCI: Work around PCIe link training failures
Date: Mon, 29 Jul 2024 12:56:31 -0600
Message-Id: <20240729185631.26746-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2407291540120.48387@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2407291540120.48387@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 29 July 2024, Ilpo Järvinen wrote:

> The most obvious solution is to not leave the speed at Gen1 on failure in
> Target Speed quirk but to restore the original Target Speed value. The
> downside with that is if the current retraining interface (function) is
> used, it adds delay.

Tends to be that I care less about how long a device is gone & more about
how it will behave once it reappears. For our purposes we don't even tend
to notice a few seconds of wiggle in this area, but we do notice impact
if the kernel creates the nvme device & it is degraded in some way. Even
though we might have automation to recover the device we will have lost
more time already than by the purposed delay afaik.

Some of the time a human would have hot-insert'ed a new device, but much of
the time perhaps the device will be coming back from downstream port containment
where there won't be a person to ensure the correctness of link speed/width.
In the DPC case perhaps the endpoint itself will have reset/rebooted/crashed
where you already suffer a few hundred ms of delay from EP's boot time.

I would be interested to know what kind of maximum delay we would all be
willing to tolerate & what applications might care.

On Mon, 29 Jul 2024, Maciej W. Rozycki wrote:

> After these many years it took from the inception of this change until it
> landed upstream I'm not sure anymore what my original idea was behind
> leaving the link clamped

A familiar question I have been known to ask myself. - "Why did I do this again?"
The scary/funny thing is that there is almost always a reason.

I do think there might be some benefit to overall system stability to have some
kind of damping on link retraining rate because I have also seen device stuck
in an infinite cycle of many retrains per second, but each time we come through
the hot-insert code path kernel should let the link partners try to get to their
maximum speeds because it could in theory be a totally new EP. In the handful
I have seen there was some kind of defect with a particular device & replacement
resolved it.

- Matt


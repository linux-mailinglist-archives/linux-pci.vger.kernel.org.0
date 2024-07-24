Return-Path: <linux-pci+bounces-10745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4758093B783
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 21:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8E1BB24249
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 19:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8FB1607AB;
	Wed, 24 Jul 2024 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QjBQFpoD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069D715667B
	for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848721; cv=none; b=HwG/UqKhb3mcvP3XAxtmqbtf5Q9yo9epEArkGShFeCSy2Yga1IKNJoAwM1LrpFbG2cJIT7c26r1jNxFzp40c/mr8hW9fY1R8RiKzio6pXbiBNUAusVWbUDvYSg1/0uypjZpy8V7NdECV+j2YRubss58gC5paqUm3Bdd56LEGDhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848721; c=relaxed/simple;
	bh=a02GUhiWbAY4bVUVygn/E4p/MC1dnbGGAe2U0twtjyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=t64cl8Sk6rC2P46D22+aiJfcQ1nmdFeA559bbADcoWipYS3TqKiHykqthNS7NjsqznrzJaihYNwUc1p8XJgdBy1CXP/BDUE0cEyTQ3Lw7RnrXI9txeqVSXP994tWNarWuEbUZoHlAj6skxcN/0a60df4gxw63Q1FLcii9EJWkkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QjBQFpoD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d333d5890so139821b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 12:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1721848719; x=1722453519; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a02GUhiWbAY4bVUVygn/E4p/MC1dnbGGAe2U0twtjyY=;
        b=QjBQFpoDwueoj4zaWBfhpIt1PmvjhP2Y9gai1cprtX9q/W0xgDhg6D1r7Fe0BfRb5T
         Whvz+oHWbAyt+QN0zkgz2uqn33X5T6cyrbEk8yESXM6lfO0vuo6qCPx/awdTKjqgWXRE
         QJU70uNzrK0fyWJ1tMFTihcXFcAj0cxZjBwBCYUojvQ5agXyw9jk76WXAS8M+IrPf/3H
         +k/I9TV/SIcUiM6wXrq0QcU2NkAau0VGiN6HrDOo2C9fsNtcx2BtgasM0sST07zD6Pe4
         9f6PHzti41HELRptWhxDVjE9h1npUjjUOMY0YQVLieuILaIAzF6Xfml0dPynXZeZMPXN
         Z4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721848719; x=1722453519;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a02GUhiWbAY4bVUVygn/E4p/MC1dnbGGAe2U0twtjyY=;
        b=cfgkC0dZ9zxBI20CUWBS669kst+vy2Z6SToNlLBZXeNza5ObTicDh+PhNyId8/lc5n
         G71Ud0p8MdLbi5xQOex/v+A9DZirgeJMWu2hzT3bh9RgNBe7AK9J5Py4x5zwtdiEunvc
         KRIK9I8lANGHSJesigSnai6nRaELLiHDyD++w8MDxuFhBAgXiqH90jrOfJyXrwEnZ8C7
         b0M4wtPiEctBZ7KTQc+skrUHqaA1kHpAbmlZQhRwD4hIfvz/MlnSqnlNzxbdmH9zmWuh
         D9VhehIVfXylBhDG9cmgDyi+6MTQ3R5B/4nl4cRFTJf0L1DD5PZA14tXlRQZt738EAe/
         Fqbg==
X-Forwarded-Encrypted: i=1; AJvYcCV7BZYz7J4AK0gQcTAousCa1HOobkBmxPtRQRejdKz+igwLYk3MnFFUvsnaomfZOHce23AAwqVHrlRV9w5x1a7rxYIbPPAiBTph
X-Gm-Message-State: AOJu0Yw0PmrbJog6QwV0UfP1o8tASkEk8ZOiWjxw3FxL+D032EKu6Ahm
	JsZWgncLhki4lLy7oVT7cSTvTX8+sD974JMUZ+a3jwduUpGG1trkqGiTvwk1QeU=
X-Google-Smtp-Source: AGHT+IFUwWJ+8obz221hJG5x/jzoeJXTY4KS7z9HkU5UcBMvPmWxLk9KdioZD32zMoXRgep0BAh/AA==
X-Received: by 2002:a05:6a00:3cd5:b0:70d:15b9:3ece with SMTP id d2e1a72fcca58-70eaa946a3bmr578402b3a.29.1721848719142;
        Wed, 24 Jul 2024 12:18:39 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70cff4b8166sm8862385b3a.85.2024.07.24.12.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 12:18:38 -0700 (PDT)
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
Date: Wed, 24 Jul 2024 13:18:30 -0600
Message-Id: <20240724191830.4807-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2407222117300.51207@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2407222117300.51207@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Sorry for belated response. I wasn't really sure when you first asked & I
still only have a 'hand wavy' theory here. I think one thing that is getting
us in trouble is when we turn the endpoint device on, then off, wait for a
little while then turn it back on. It seems that the port here in this case
is forced to Gen1 & there is not any path for the kernel to allow it to
try another alternative again without an informed user to write the register.

I'm still trying to barter for the time to really deeply dive into this so
must apologize if this sounds crazy or couldn't be correct.

- Matt


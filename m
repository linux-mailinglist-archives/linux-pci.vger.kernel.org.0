Return-Path: <linux-pci+bounces-6310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF72D8A688D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 12:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADAF1C20A3B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 10:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3243FC2;
	Tue, 16 Apr 2024 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eK/cESzy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92B0127B60
	for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2024 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263730; cv=none; b=ha0hOcllqTaIYNlWvwBBhwlmrrN0DYVdiJZMRG1aM2bz4jVHp4kgrL9NMqVxV9eM+rQi/NioizLvHGfP4+jSi6vnTYEHmknaxfwBxhfPvw72fyhJpDWwlXzae931t+xcKJwQBDlQssa0/0WZ3NgEZOKHPjOnAR7euVSE6dwvLO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263730; c=relaxed/simple;
	bh=cY42OW8UeSirFeqsOJxYe5yMqVTg3yFG09RL5cMYF+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q26L1M/nDATF4ojzHmFEw0M42djcoK7qH/MFZ0o4VY62brr8TP6YgwhKhDN0tdCYjoIrjId7SEj/BuxR5rFOwACmwuQBpdly3h2DUa5R0GgtiE5puqOTJ/iKU13OYpGlyR7JR09ovUNFzbcz70JedSCuyMX/pF8nEVqqsArUneo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eK/cESzy; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6eb7d1a5d39so1425174a34.2
        for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2024 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713263727; x=1713868527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY42OW8UeSirFeqsOJxYe5yMqVTg3yFG09RL5cMYF+A=;
        b=eK/cESzy9DYx6Ftc5nRxf9q2nhW38LXzJ8J2VaEfU/qLoE9I69vVhcV5XNpreTRcnQ
         4ELnTb99LCjNPuHc8+XFUZ/j1WLRcaKPYJGQh3Y/4E7eybenya/0wQkvfd14HRAGU6R6
         mKy3MNtedOEpIBAapZlcr/B8nsPclzrPc09fSJuiisOECKWd+Labx/R9wOU3hjM2duzd
         bzABB2pbVpBzLZuaDbyr7OH8hMWrhRfFgiNOPe9/tGSSKfefot1sXTtNel/87Q0EnYif
         1aaplox588jYLWw3QkaRw/b+Po5roavV3UeZEjo1shRAxHrP5AUKgmi/2ovv8l5Quxf0
         /OpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713263727; x=1713868527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cY42OW8UeSirFeqsOJxYe5yMqVTg3yFG09RL5cMYF+A=;
        b=ZzWahL+ArlXLQEzLNq1yOKOUddAImU8i9FJ2+Fy9CmtkaSzbPOziyrdkDLOOb9i2Z7
         nQ9vS/ILvGXcvXSQmF3kb62jaFNV1Nt5jb+f5gJofl/c7+vpuRIHUYd3TLjNqTdJOesF
         ox2hnyHY3I6neSOYISkG1GZydrZHz9+wgOljVPMNOU2HA1G5wuWhogEkzEBG6jaSt5dO
         xh8QyHkzg9xsc+rFlVz1bFU9iqPL0pj9SySixQ3EA7aCDCzQHZ8KhiF7hm9uYgeZITA0
         ExO4qCo4TnOXfoXYlboyWmMVj6jVoMM9MkRFW/L4ePFK4xCvo7z6R1bFyqUb+lDXPAaZ
         CT0w==
X-Forwarded-Encrypted: i=1; AJvYcCXxHXmjjifCB3SrphpAX4NM3S64G/qWYmdnJW7AJkrTP87aWPFcxbAKHIknttJmtxh5pydr5XEB7PMhgjAevYvOQNAuxYgPXXjy
X-Gm-Message-State: AOJu0Yz1mYt86Ndfed3jFlPl9iCphWjaU4Ld1djfNF/NLZtmDpBFComl
	xFrVqS0hNuJsbgL/pv2AjBtjq0HgcG6dMkMlO5xFaySik5GtnPFS/L0n4BeaCCw=
X-Google-Smtp-Source: AGHT+IEw9cmwM2hIAoklpoZ7SS+Np/6aL4HkLZt9UHslpEDKjbR9asrxOOJl5iBbyhftJP409IHk2A==
X-Received: by 2002:a05:6830:1147:b0:6eb:7260:cbd with SMTP id x7-20020a056830114700b006eb72600cbdmr7828300otq.4.1713263727617;
        Tue, 16 Apr 2024 03:35:27 -0700 (PDT)
Received: from localhost.localdomain ([221.220.135.251])
        by smtp.gmail.com with ESMTPSA id o65-20020a634144000000b005dc36761ad1sm8677293pga.33.2024.04.16.03.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:35:27 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: cassel@kernel.org
Cc: bhelgaas@google.com,
	dlemoal@kernel.org,
	heiko@sntech.de,
	kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	lpieralisi@kernel.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	shawn.lin@rock-chips.com,
	Jianfeng Liu <liujianfeng1994@gmail.com>
Subject: Re: [PATCH] PCI: dw-rockchip: Fix GPIO initialization flag
Date: Tue, 16 Apr 2024 18:35:12 +0800
Message-Id: <20240416103512.330489-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327152531.814392-1-cassel@kernel.org>
References: <20240327152531.814392-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test on rock5b with RTL8822CE connected to M.2 E slot.
Before this patch RTL8822CE is not detected sometimes, and I tried to
fix it by a patch[1] but that could not solve it. And in that thread
Sebastian mentioned this fix. Now with this patch my pcie wifi can get
detected normally.

[1] https://lore.kernel.org/all/20240401081302.942742-1-liujianfeng1994@gmail.com/

Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com>


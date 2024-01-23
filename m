Return-Path: <linux-pci+bounces-2509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AC7839D21
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 00:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25F81F2BE40
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 23:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEFC3BB38;
	Tue, 23 Jan 2024 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BU5AMyBY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2174453E17
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 23:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051923; cv=none; b=U4EAHH/QJcwS90KvhyDCZv8cmHioZFB/KEiKIhxPzajoPsXiL0zserTYLvtKxQTaU88cdw9CC5N6QljYTYshvsNR31VRaF4aHSWmK7FF0WtXP4x6lRYVPBy6PJS5h65pwXFIlRGs7I9/eAg3SO+SauRF6YX8oa5BPk97snXbTKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051923; c=relaxed/simple;
	bh=i9rIOokU6RsS6QmCuiL3cX/YyA1Roci+/uEwk+pGRrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mak7SOYqsCErb8fkYX5MkGdC9Nl58BkMePyk/O+BsXFk+eV2uBtARSt51HwfA2nddNLpdoMrN5FPm7dauif7jXq6bJa+jFel/DV/XlerEwSvEQ6cSwNqkWWpGxiITHnl5i3mY6j5ssboKjaMiK5BOo3PZHbZ3rzAEo2hGl8lhb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BU5AMyBY; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5957ede4deaso2919003eaf.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 15:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1706051920; x=1706656720; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i9rIOokU6RsS6QmCuiL3cX/YyA1Roci+/uEwk+pGRrs=;
        b=BU5AMyBYRnAg6/BVFiPXo7C108aFrO6kkBJPWxFUISQD6e2CRO5vfS0BtMPE668or2
         5KgY/4TK5970tOpXYMsh1Mjre0dR7PuYdMESLjy9Si47v/VwcW9W/3cjxJBEfvwpyCjU
         muvuqeMMfY44VTWoBF1uREU9Rl07P5uIk0qc1E+VOBxZmk6ipMNh8n01rfozVNomq0CT
         aY9k4aavTeTYRHowH8vohps0bFPeK5sDPzOlGzy2Mx6KDpUHFMlJFllTLgxJB3of/2AE
         wDWNMtv3Nzmj2hT/IAZsJi3+BZEdf3g6vYtn7lK66IQNsH9vS1uvQRaPr+jR8BcE60jj
         KJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706051920; x=1706656720;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9rIOokU6RsS6QmCuiL3cX/YyA1Roci+/uEwk+pGRrs=;
        b=nJz6eyoZf+3t8gIEH3L9a9Ii5fxuEZiHZ7GhgirbUGaq4kf2rVf9adgAqGEq2lru1u
         mCpYGLWV9VA4ksCEDQ0Zir1eZAsdPFMeCvnX8Vye6cI3TL0Uj6l7k7d9B6f8nXKzWuFB
         yQGWW079RfsFDJ11j2La5Gsmyjb0C5iLWse0ljqDYssTCI2uAhYu5K72M0450OP76rAX
         lQBGdUhZ6vWRNFjsskEhXZF+hQKPKjTz+Pe3+zdI6m8kZjOhNiVA3JWY/M2uk5CJl0Kb
         y3flL1Z53Hkb12aWdki5Ek9bXn4M15Lh9ifhf1zshdKPHNp0mDOhfPfQzdDQR5YSviZ6
         rnkA==
X-Gm-Message-State: AOJu0Yw97ktIufPwKLTCrFlDQn899Cr/i9PdaFHC87G5bj2bvVW4H7PO
	fP2z6ZV9hVsa/cJKmbdZDKxJB+Fih/O0Mc/RnhOAzOMNSPAtO83xdbNN9ZI7HyA=
X-Google-Smtp-Source: AGHT+IHgkNFEW5OhVohNSnFSnm8qVjakloMxBSTkLqdBqYozBExVAIS6QQFuQZNsDFXzG8MjEIL3Ew==
X-Received: by 2002:a05:6359:5807:b0:175:c51c:c696 with SMTP id nd7-20020a056359580700b00175c51cc696mr5940860rwb.36.1706051920145;
        Tue, 23 Jan 2024 15:18:40 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id fj30-20020a056a003a1e00b006db04fb3f00sm12234240pfb.28.2024.01.23.15.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 15:18:39 -0800 (PST)
From: Matthew W Carlis <mattc@purestorage.com>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	kbusch@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de,
	mattc@purestorage.com,
	mika.westerberg@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH 1/1] PCI/portdrv: Allow DPC if the OS controls AER natively.
Date: Tue, 23 Jan 2024 16:18:34 -0700
Message-Id: <20240123231834.11340-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240123155921.GA316585@bhelgaas>
References: <20240123155921.GA316585@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Hello again! I'm glad that I'm not the only person with a little confusion
about the FW ECN regarding DPC/EDR. I would argue that DPC wasn't tied to EDR
& shouldn't have been because DPC was added in PCI Base Spec Rev 3.1 in 2014,
but there wasn't an EDR ECN till ~2020. Anyway, that's the way it goes..

I don't want to burden the kernel with making some impossible boot time decision
here. Perhaps most of the machines in the world using DPC will soon use EDR/SFI
etc. My use cases are a bit out of the ordinary & the ACPI specifications don't
seem to have given us a mechanism for the kernel to conclude it can use DPC
without EDR support...

Shall I submit a patch removing CONFIG_PCIE_EDR? Perhaps the exercise would
inform me about whether its code should be in CONFIG_PCIE_DPC or CONFIG_ACPI.

Thanks,
-Matt



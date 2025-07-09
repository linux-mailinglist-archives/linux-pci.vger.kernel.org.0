Return-Path: <linux-pci+bounces-31808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D77FBAFF2FA
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 22:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5655F1C85D9E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 20:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CEF24418F;
	Wed,  9 Jul 2025 20:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WkCKA+ia"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E69244186
	for <linux-pci@vger.kernel.org>; Wed,  9 Jul 2025 20:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092871; cv=none; b=YPvmZ2qOEeeLmmpvxhytnzF/bxQ7l0v0z5iIXgCEzzzRUvH+z5mHN9wPNKVqulG1nHWFmfaj0dZhKJPPBMrSmaXce8JRTfUI4x490VtKEiJzTB1kIC1zVLS+oBJZH+OaISRG04+hE3YgujuEydzcfY0v+qWH/oV/rCSFza4AO18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092871; c=relaxed/simple;
	bh=tsP+4WYQCjnsVuKdc6arWEX71VN4+jQ4l2BIGAJ6LdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1EmfaVkSW2ikXdaMbaG++WHZFexQ9wkdCh9O8SsQtJ/khLyg+IsaxXlektLI87AWO0+D2QNEoBcpeZW9aO4mpiGT4hpx1LdkGgk+EvzmoDoLQ1gQChzyLV6A6PWO1U9Yu4ObPW6IEro2Em/3wUx92beYUZ3Sd7Pu0zHDEa+Qvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WkCKA+ia; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b3226307787so343348a12.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2025 13:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752092866; x=1752697666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsP+4WYQCjnsVuKdc6arWEX71VN4+jQ4l2BIGAJ6LdU=;
        b=WkCKA+iaW4pqL4RgiuHjL+2e1yNRWZktsIejaaWfeXKAEvVrOIsSE9arxgTTha6Uxh
         dYvru86dGVgjQ+qKUIsxChgStuNu+4wxqfOqenmCFxDu23qwlj+DRSRRFRpI5cpFOtzp
         4gNjDBMeqluV/Xf0KcwMw49E5gR6m4931lcvynZNhEPypDoHQ9KgZUNcEO+WuXyztv5p
         UrNoNpqmBqbhlZEStHIbY6oOYf6tzGQgtpPKDV1+sDlOguJt41o6poBQpy2E3s0g8Awz
         uWdJdupsRcN0MMqp7/Dj+vETkPbzVBNRFMuHa0n+8QXIp2qMvjxPWv7ccjDbw4ZkAb4f
         wVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752092866; x=1752697666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsP+4WYQCjnsVuKdc6arWEX71VN4+jQ4l2BIGAJ6LdU=;
        b=xG82A0F1v4JNuLXFZNO8BMZyIQ9J1U8JJhaS/YJ5J/5GOp2KZ0coElgATTUDICACz4
         xELnWuaraMnI2Vj4ySv9xYAeTB159JzA8qhaW34yhLqQau9PZKclSuRee3GD3H5xs0Wj
         9X5BqR8j8xOeh4dq1TNhnx1o81EDCJKu3a4kKjoCZqiue0FnZZAqwXitczwV2iHxR5jn
         zQdeCiLI2Zdb+jyq9iBre4Q1rn+ubORdjLHP41HMA85Me7hF7UuBXJExql4R/bqLTOUx
         yx5fPjeU1xJpH/suOnIosEx+eNKhNJaGd/LNYcmR+6ZlZUY+YVVni6y4QijHnP9aGvLY
         uQjg==
X-Forwarded-Encrypted: i=1; AJvYcCXVwxh96HBPvJvk5O8jYNtd/b2eCNTyEoE7BeTHPHGyO3XSh1a+qNmxm4YpW8hVUdsmuACwLnkGOC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBTHAlTY4ZZNRqjKMHRGFSLdlBeP3FvxCNqaIgEvm1rP7+awP2
	cNBSfkAVqHjiQZ+fEwUgLQxQCzcDu3u2pM9YMl4u2IEsrVTciuLyBJ2C5Ixs/SCWvOA=
X-Gm-Gg: ASbGncut36Mc8MC+5r1GbWPV3wZ9jb4/SkSu6xYBW1hbhhwyIkkqBlNbfvQ/Flc5e1Z
	wOuWPhKECszGd058ZPL0POEP7s56AROPaBFABs9Uit9nwHbLRY28tSut+kiIIlZsJQFBeboL8zW
	TyLXrV8EPML6lYpiWTTRPWfxxc2EQLf76a+VMLy+MOY40jul/orkbTndp3CqYWhZnwt6gu0GxWe
	Pg9r5fT060k2LKi3lgRqj1CdqWbjamuQpwVt4Q/GRRvpihmOHguFGqXScjjvCte+3JiZm2NmusT
	b5ySFZETMURz0+OKZLAvAOeNs0wPeJ59DAKDPG9dWxtOCaNOiNEAbl8EEV1XjYW2OODFJDDYlbW
	61gCSXMtcc6+M
X-Google-Smtp-Source: AGHT+IF227oreIBR0xjm0wt0cuQFW86sgYOfbiidg9gJUm4ujM3d0p9LYc1EemEOBDtic1PrOOXRXQ==
X-Received: by 2002:a05:6a21:339f:b0:220:21f3:87ee with SMTP id adf61e73a8af0-22cd846cd46mr7011592637.24.1752092866521;
        Wed, 09 Jul 2025 13:27:46 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74ce35cccfasm16817992b3a.58.2025.07.09.13.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:27:46 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: mattc@purestorage.com
Cc: ashishk@purestorage.com,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	macro@orcam.me.uk,
	msaggi@purestorage.com,
	sconnor@purestorage.com
Subject: [PATCH v2 0/1] PCI: pcie_failed_link_retrain() return if dev is not ASM2824
Date: Wed,  9 Jul 2025 14:27:40 -0600
Message-ID: <20250709202740.30729-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250709185309.29900-1-mattc@purestorage.com>
References: <20250709185309.29900-1-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changing the subject a little here.. Minimally we should do something
along the lines of this patch in kernel releases that do not
have the bwctrl.c, but also have the quirk. I'm happy to continue
discussing what to do in the presence of bwctrl.c, but the behavior
of the quirk with hot-plug is utterly broken without bwctrl.c
based on my testing.


Return-Path: <linux-pci+bounces-39332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B67FC0A294
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 05:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF1D54E211F
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 04:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3781990A7;
	Sun, 26 Oct 2025 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+GChMDq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B9723D7FD
	for <linux-pci@vger.kernel.org>; Sun, 26 Oct 2025 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761453840; cv=none; b=kTiG7ZZFvSrrVXgIWayj8AbnPUO0YfhOJB4BgKhLMCZxulUmSGu2OFhTmcL3/FMNpq+iQ2QcTzc8Dfs7dMiapf3Oon8yAsujbhY1d1afG9LbBviqHfACN1sueeM3ciUxbXRv22OoAorL5u8o264VsCZYxYRfCZBCAxP+790kZTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761453840; c=relaxed/simple;
	bh=Aq74QMuE52R7WYicPBIBj8uAOiBzvycV/ZXDy6HTnQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p5Y4b8TWqJ8K36Ov0xmug2FPcDgydlx9uywnWKXzfzHN4ucxQXfJifURoZK3ZbEc/VwjcvhFq4tpQNrK0irHP+nnk1jbShCAegCDYzcrgZuKoJc8ZCsAfmlCreeHVQOHNtXzwMojXY+QwPntYds0LlL40g23t6L9CJ1XOYWK9bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+GChMDq; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b62e7221351so3092865a12.1
        for <linux-pci@vger.kernel.org>; Sat, 25 Oct 2025 21:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761453838; x=1762058638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3QG/GQcuHlnsVtxELaSyj+sqLVJE39GY4SNmTDM2G0=;
        b=g+GChMDqMHoHGXrhpy/zqFMfrzgizfu8qAUXveFc202Grj+t8c0aI/eSy2b07bvgRj
         AmnrIoW6gOWbvdiTc2ddjQ4mN6q0b+UhN2OvzYbSf9G8HVwokZsfrb+ZNhUkqcSXjql4
         aOC/gsIxHHjco8hsFHDZXUJQ2uDtnZBQnXVJXOJVYr4p6/QiZqIIkpQnzYvkYYZre0LV
         Pc8a2PG+c1SEZV5g2Ffu5s9w0/IHAOUs6+5nEmpUPrDYdtyF8pXJ+RFOyLOb0o9yhrUZ
         hegVbffghgGMIRQAGzH9aC+Z8Xn0pw7K4CsKi+BlUyeZeRCeYHQgpl0D2cP4moxFoDhh
         gK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761453838; x=1762058638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3QG/GQcuHlnsVtxELaSyj+sqLVJE39GY4SNmTDM2G0=;
        b=FNP5hK08w9o+rGbWW2hY+JFd1Bmzd/PLjdQOM1PGWC0TSU7tIe7oziGk5fROU6oDMt
         eGxPGDKZ8YNwzi1SFf55RPK2cpaj/3JDy8YELhisdQd6DCCBQMPWfzPJiAYbki4xmbHY
         NAP1nO6go61gU4tr+bJxRPVUQdGp6RLzGDyx4LnQhYX3r8f//CcHIKIwBnUUdb3DzKM8
         xep7mM3802wGKyRLCFDE2vsWVh3m9ONcTj38iRow/r+KzBZW5zBx7J9Ly8liEUcArlED
         pXRt4lLEHk+ttGHMJ+Xi93Yx8EpFoFCJVX2gBXxg9AFjCvy7GJmlXJTk+nxekK2AGaew
         N9Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVNkX6GizmDgrwx+AnorLj8Q6BVN30ic32C9hOghtxdKRAY7ryImKM4N8i8d2qjCWycCg+6lfZ5AW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa3jYQWTsc44Hba+BtxeQXcKWGIbrZXkLyqPTst6ICTai+s9sI
	ndyuaydTHn98fcJkG5ql7cNLgVkPLnNf/vuiUT74Gev0UuEyp7KVqyZn
X-Gm-Gg: ASbGncula358WzWZ5DLFtbcqBrJ9FBBTvZdzF8O6wj581QOVL9g350cXsiFNxO4PqJ9
	CRXPZqW66aD6bbm8cS8oJhafxwEOWIP+MxnImJKFqVQjOvRwPaBlTcr2/wfLA3pNiraD2oB6nV+
	v0GJkeqc7BPs+vqdK+GXL7ESc9L3umSJFJRi40gsMnb8DqWEy5fytVKwlH958VImFlYszt1kr++
	iRrfyOpblGu9oWQO+pmr0FtW8hqy8hS1+IdnRZFRY1S+JtBN5KfOxO0s0T+PoYRVueKRl+Bbitz
	sAwCnibMMH6RYce14YpTSS/FDqADNCPfKaOY9AN4MGFNMTX6w47fF840hdpRHndfbIHC+FveAI0
	sl4tLcFmrsk4VSPN4crCE+d4Esco5leQaL7UG2LWE3Ue02W/gn0KOcvi3y3lUWjWleYxTq/QCU7
	4B0jjXAlGdlWUXiFL5Q+crgZyoS9ZHnvl6kLLxHzAgAZUL/Sy4EA==
X-Google-Smtp-Source: AGHT+IFB/FjN2j0+IOAja2+xRrNG+5H+gTFghf6JJ7KBtwsp4jcAYxVgOF8JlaL+XVkBPHYqSsE4lg==
X-Received: by 2002:a17:903:8c8:b0:269:87a3:43b8 with SMTP id d9443c01a7336-290c9c93aa1mr330667075ad.4.1761453837832;
        Sat, 25 Oct 2025 21:43:57 -0700 (PDT)
Received: from localhost.localdomain ([119.127.199.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2317csm39315755ad.48.2025.10.25.21.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 21:43:57 -0700 (PDT)
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Waiman Long <longman@redhat.com>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Subject: [PATCH v3 0/2] PCI/aer_inject: Adjust locking for PREEMPT_RT
Date: Sun, 26 Oct 2025 04:43:33 +0000
Message-ID: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series addresses locking issues in the AER injection
path under PREEMPT_RT.

Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
Changes in v3:
- Remove unnecessary lock in aer_inject_exit.
- Link to v2: https://lore.kernel.org/all/20251009150651.93618-1-jckeep.cuiguangbo@gmail.com/

---
Guangbo Cui (2):
  PCI/aer_inject: Convert inject_lock to raw_spinlock_t
  PCI/aer_inject: Remove unnecessary lock in aer_inject_exit

 drivers/pci/pcie/aer_inject.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

-- 
2.43.0



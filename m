Return-Path: <linux-pci+bounces-40060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14185C28DAB
	for <lists+linux-pci@lfdr.de>; Sun, 02 Nov 2025 11:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 154F434757C
	for <lists+linux-pci@lfdr.de>; Sun,  2 Nov 2025 10:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D410621D5BC;
	Sun,  2 Nov 2025 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Shz5f0W2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56210264628
	for <linux-pci@vger.kernel.org>; Sun,  2 Nov 2025 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762081072; cv=none; b=OPOKqzKqzisrT7x9pMK74WxTXyUoldbjKDabm1yyq9BnOoY+NvaozbQ1Jlzm//CfZ1HiUynDx2+/zvERT3hnuf1nBq+XQ3PLCzW7wKDuy94z2GWYubGJYDpOROrdDisH02vuymw/tGyReWvgbbpVvtyScoVVxbY1aEZoiH30OLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762081072; c=relaxed/simple;
	bh=SHEr//40zR6hLobNUNKlzHkrDggRl9UZzzbYH4lErwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xm1lLr9Rl6Efj+1fLyxuB6M21SxrI2K3f7Lp9DRyQBVhpXJDcW3gBq62W7Hqs4Z9es/qqFXpcGdMKF12Wed0m1eFYwiypnXn2CXaY0FBK6wMPjoqAgb0h1tmIPXsZ63HOA/f+MeBjGwWb1v3pIvm0sgw3BBuhbRtjiDpGoqdpMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Shz5f0W2; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a28c7e3577so3485560b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 02 Nov 2025 02:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762081071; x=1762685871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vMHdxPCuQYx37q4+PHeYjwUMtBpJVYVKStqHxBRsAFs=;
        b=Shz5f0W2eaQvA6yepaDocTLtgIomMWfKApVjy/e6LwXAlXHS9jLC9vqoHy0lDqCZ1Y
         WEzJMVxYnh/iSP9V4rZyhR/WrMymVbsnddwHCIUZddZxavq6MpvxQLJkQGmATJES9Ia1
         fI9oeAFritkilA2HaBATKa2zksKmLq9YpEFr2yzJkDPoGLuMtm8aVmHynZSZsK7GQQ5Z
         GQLw6kafUnB81TEbwZDmCl3Zx/G5A+MEybKOE4y4dtiCp4W5mrFuO3hy7wBKvSVR4B8z
         jQ1FdY6GY50dbWJh81Q69nzs0wirkidI5l3NBtWYztKRvo+3qOz4PEtLZd8gpJapYTRD
         SdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762081071; x=1762685871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMHdxPCuQYx37q4+PHeYjwUMtBpJVYVKStqHxBRsAFs=;
        b=JsOiKyk0e89ZJdeKsxzatY1VqSb4fBc0bFOL2IgShn3OIqcVSTYHZXr0p/Reh2t0ny
         N+EhaGXZdcOIXBelOzR4gMqMh6nobqzrMjB47gQS2N8lAbaJzXRX1QRCCuielKbj8BRS
         QKkX26H+GLSKiN0nLJQiDaWWO9iZZkH576fdEeGJzCtRRkrv0PFcZAsv4tLBZ4x5unEH
         CnO+N7Ke9g20hZVYSYNnAMWYAWmUHr0DGOwRo645EHrwbaC205Sv3PtRgmwAvTIWQ/nq
         o468smGzjz8CTuzD76YO2E0POcitx0R85qLvv+OY0TGf0UMgJD6Y3gmUoG3MZ7XMlXtq
         mUuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6syRjD1HEJtim1l2ehWGwJxG0ngGoZPGLn72mYQ2xibOwG7mi/vnTFpXFi4egvb8Zq5roj7QAlZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq4YH3zc7EeAxUhzmd8+r+fRvulo0a+I1AjNu+PWPP7Egpaaa5
	0vioZsmqXZdmS3Y2btToNkmXJ9s4Vs58yJw7ybJQbhESrw95kjc7PIJc
X-Gm-Gg: ASbGncs8Kyg2sff1Z58HYs4xG85rVOrE48DDi+07kCc8dsrv09Xq2uMovLZhmTz7x82
	mtR/ZpvySoOorKrXmSYougJ+r21pMt2uZFDE+cF/UOD70Mj/z6v5s5RwH7M7xBsdY5tCr1QIGGi
	Y0dPr80K8Y1LR1w046FmlhaAYE92MT/uojzlPYOsAQ40hGP+kOZcVSSJnhgXWOstck4A5JkHZDN
	L9aAUDS+buS/EScFtBhc3DqXohwAue8GpG5rqP9K71RtQA7DbR0ER3VzPD0PptYexotjhtx9W1O
	cCQ+5oPukcVMZ+2tmc5asT80NX1e5jsVyCjzFPWUjFevyi6x5ZQo4mmCBcggTqs6vFIkcW80FxC
	zvwHveuuGu8BtN9sH2nA/bN4LrKa8qYcSh2NK1a/xwAQ+vuEu94N19LN/fIPyuNaBxWYw3VtSmp
	mPcDXd1LdUnRgtzj+0ju+K3PxIjIOWHpnnOROQCZc=
X-Google-Smtp-Source: AGHT+IEsI4Z/8PcAT7j2pialDGZiC/BBy4ILYzqkSINF9zrcfL6KP/AE2O0RDl67g6y34Zj7lSoeRQ==
X-Received: by 2002:a05:6a00:886:b0:792:574d:b2c with SMTP id d2e1a72fcca58-7a7794c4f13mr13897182b3a.15.1762081070616;
        Sun, 02 Nov 2025 02:57:50 -0800 (PST)
Received: from localhost.localdomain ([113.102.236.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db67999bsm7488050b3a.56.2025.11.02.02.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 02:57:50 -0800 (PST)
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
Cc: Waiman Long <longman@redhat.com>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Subject: [PATCH v4 0/2] PCI/aer_inject: Adjust locking for PREEMPT_RT
Date: Sun,  2 Nov 2025 10:57:04 +0000
Message-ID: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
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
Changes in v4:
- Reverse the patch ordering.
- Link to v2: https://lore.kernel.org/all/20251026044335.19049-2-jckeep.cuiguangbo@gmail.com/

Changes in v3:
- Remove unnecessary lock in aer_inject_exit.
- Link to v2: https://lore.kernel.org/all/20251009150651.93618-1-jckeep.cuiguangbo@gmail.com/

---

Guangbo Cui (2):
  PCI/aer_inject: Remove unnecessary lock in aer_inject_exit
  PCI/aer_inject: Convert inject_lock to raw_spinlock_t

 drivers/pci/pcie/aer_inject.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

-- 
2.43.0



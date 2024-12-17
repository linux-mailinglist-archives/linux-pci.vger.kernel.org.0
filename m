Return-Path: <linux-pci+bounces-18582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F5C9F45FD
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 09:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F26162B0C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 08:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C214B1DAC95;
	Tue, 17 Dec 2024 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7CtpWqz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A7B1DB92A;
	Tue, 17 Dec 2024 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423774; cv=none; b=G/7o2wIjGPLMW4ics1JVI60M9PPZjWKb6S7fBj2i/8rP4Qv3iP0Qo6HIEcvJioQVJhJKDuI+xSqL4F00GsoMHGHKEwRPlUZPUK0mhbLrgL+MLu0DAhtEM31/uvbpLn10xzWfQoPOk/8WHBURrrZKUr8ItjHr4ZIi5Al7KksWxDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423774; c=relaxed/simple;
	bh=sl89bj/6/Z+mOrYSKIEKRE5nQqIUbFo3iEpWNxCKxNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mut7UnEHhpOZppkmzoUV7/GsHpdEQ1rc2qNXyQ96I2E/gmaHHySnN3XD+8eK3p9Z74hIqkJiKC7xmn+50kfwgr0a+KMla6aydqQkQxykCQmJnhDYD+hRGKb8dzomUOg7rPiFXBYiTcWXzJ05ldQ+IhN1KTFi13EX9dopBnt+vJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7CtpWqz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21661be2c2dso36426625ad.1;
        Tue, 17 Dec 2024 00:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734423772; x=1735028572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4SJHwVm7jGqzHklwEpE/hT2jIFLI2Cr/r40yccH3v0=;
        b=Z7CtpWqz6kMu22qyGAt7mLZDwp/G0LVrXuHk7TAA89hGPkxOQmCTG2dH+RT4H7fnxR
         Mdm1Vy4nAGajwl//glsZz9Dd8/Csg75T1+jw3++aqotDQbfQ+mFsX1/teLk3ISH1vwPh
         gt/VffDdzicuBFX2Fd3QANvqdCcsWNbZUaHe9eTFnYzdJ6GqLCrBmtCC1ny8wFujfE5I
         xlbrpTgNEHonFuupzrLo+WW7/b9UOt4HmlQusB+YaxqOHcUPSUimoa1yK7hCvk2t8D+z
         xFCV7j2V/+8sVJRTSEwPplYMRwiV5HcdY7AA39A4zIVJd4SvPv4Ugi62KCVOyn7Oz0rF
         pk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734423772; x=1735028572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4SJHwVm7jGqzHklwEpE/hT2jIFLI2Cr/r40yccH3v0=;
        b=HZU7KyOUjdg1aTyBCmGMpEOeXiVYN1rs2qRR/Z6CNY/opSVdu99m4Tm6MLB/kTKJ5y
         MHu4DJw77SddMrmhIvwCEgzCrGKdHOy+l8baE4or11iHb7+qZNlsI5piyxQC5gnWwZs9
         9x03MusF6/Hb1P9mCCAbJ015qRursZryCcdHIb03a/2a9tRwRSd3sTBLVeN0TRqTRrpQ
         MI8XYxKdKHwCSg7hAzgeU1EPI3n9Byeyhx+pncmvglfDd0jBpw8Hc/tdPSMHHgr6895S
         3Hmd+jFdFgn/zT+6fW9oYMGqsuHwOFwmdOiX+K/lRLWlVa+dpMvVKz2C2tv8YgzxpAOt
         /YDg==
X-Forwarded-Encrypted: i=1; AJvYcCVYVM2iVjpTu42COkPYcSkOuifUbNY5W6jSa7PYsxxanNjs+3Ad8/g14OIFpcP+vdHgq6hTidG5l6KQ@vger.kernel.org, AJvYcCVzkGVAiBUQoTgC5WG/2kPBe958RJURm3aJoJgFtHTPujkJT+7f7XS0ViectNSKtLvtPNBYrmQdalLYrYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5yGhqVfT74FusefQIxhad0AiyXhm+qH0nePguzy1f41txeRgV
	U1Bx8KY2oMGw2RT2TJJK8TV9dGbpSilnES62Ykuw9+Dp23pbfwvp
X-Gm-Gg: ASbGncvqOiBgS/ut785WlxO0+cc1pLZTqjwlzlPcFLzXhGkS7ZTIalDlSO8YXTCfwdi
	fXB8iE0IXkVmQXxMTKW/F5omxsLXKcHsyYItr2FFshav45oqpJxubT8eQOcxyRhzhlm9sBCnHHT
	SitIWP+9fhEZd41oHNQYPgOpnXvTEnTgR9OMy36OCIVje1bvlxF4ZKdplZzBzeOBdIPeur1M4dp
	sYS3Ry8yNOFvln52hoxYjGibJvhMHsLtg4+ibEl6r6srNLWWiF+VBqch4cZPdw9Z6mY7zmiSGiX
	KupNwtGmO6N5Jx9zjGlyfWzzs6I=
X-Google-Smtp-Source: AGHT+IGtSoyIcGbzwmPUa/naySzySQJyzxPj6rq5R3+shBbBdUyu7Hiij+fD+Rip/wOHzEC6OmFH8w==
X-Received: by 2002:a17:903:22c2:b0:215:8809:b3b7 with SMTP id d9443c01a7336-2189298227cmr195617705ad.7.1734423772455;
        Tue, 17 Dec 2024 00:22:52 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6416csm54419255ad.230.2024.12.17.00.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 00:22:52 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: lgoncalv@redhat.com
Cc: bhelgaas@google.com,
	jonathan.derrick@linux.dev,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	nirmal.patel@linux.intel.com,
	robh@kernel.org,
	rostedt@goodmis.org,
	bigeasy@linutronix.de
Subject: Re: [PATCH] PCI: vmd: Fix spinlock usage on config access for RT kernel
Date: Tue, 17 Dec 2024 17:22:45 +0900
Message-Id: <20241217082245.12514-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z2A6VEMN5jkXg2lr@uudg.org>
References: <Z2A6VEMN5jkXg2lr@uudg.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luis,

On Mon, 16 Dec 2024 11:33:56 -0300, Luis Claudio R. Goncalves wrote:
>On Sun, Dec 15, 2024 at 11:13:21PM +0900, Ryo Takakura wrote:
>> PCI config access is locked with pci_lock which is raw_spinlock.
>> Convert cfg_lock to raw_spinlock so that the lock usage is consistent
>> for RT kernel.
>> 
>> Reported as following:
>> [   18.756807] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>> [   18.756810] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1617, name: nodedev-init
>> [   18.756810] preempt_count: 1, expected: 0
>> [   18.756811] RCU nest depth: 0, expected: 0
>> [   18.756811] INFO: lockdep is turned off.
>> [   18.756812] irq event stamp: 0
>
>This problem has been discussed in the past at:
>
>    [PATCH v6.4-rc5-rt4] rt: vmd: make cfg_lock a raw spinlock
>    https://lore.kernel.org/linux-rt-users/20230608210232.056e731f@gandalf.local.home/T/#t
>
>And there was a suggestion to remove the lock altogether as (at the time) the
>only two call sites of vmd_pci_read() were already protected by pci_lock.
>
>I wrote the patch removing the lock and it worked as expected, but never
>sent it to the list. If you think that for the current code that makes
>sense, please have fun removing the lock. :)

I see, thanks for the link!
I took a look at current the code and I think that cfg_lock can still
safely be removed as explained by Sebastian [0].
I'll send another patch shortly!

>Best regards,
>Luis

Sincerely,
Ryo Takakura

[0] https://lore.kernel.org/linux-rt-users/20230620154434.MosrzRUh@linutronix.de/


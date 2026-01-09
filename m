Return-Path: <linux-pci+bounces-44354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA4CD08CFB
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 12:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 731413055D98
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 11:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EF833BBC0;
	Fri,  9 Jan 2026 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQgfiRaM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8193533B6F5
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956777; cv=none; b=pXp1KOD9YExKm91CjvFxXYTPYyqG9msyZ7lZiEyNHGdve5bydlfBogUkAXzIdTOvClMVkUUDQLKXcCktrr16eL8/FD+8httvI+ZEYqdHzrlqGyE4qT0QXNfUcGr92ywCw4gQbkpLZV1VHc73qtZkp0H2y/ieU8b1gLRq0rjJXHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956777; c=relaxed/simple;
	bh=TxFUMFoBKTYWtOsk/VSHEKe5wy+98xWUwhsYV4V1C8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWqXaP7B1czUKN9SocnJn14cqzrxyIPE3ZAzdYYfnlbm4qofFsJHy1+T/witLGiKOQS0h+9t98F4hSwWPVdIqGqqXG2Xy/9gkZZz8R/61XmmVI+tDP0Y+N3fyePQ/muFisisgtyiDdcIPklGopVvyenR/urSWsQXUoa+1AL4Eq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQgfiRaM; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c3e921afad1so1794046a12.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 03:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767956776; x=1768561576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxFUMFoBKTYWtOsk/VSHEKe5wy+98xWUwhsYV4V1C8A=;
        b=UQgfiRaMGyDqRqVSKgi2xIUXEn7RhDxWTsOLLqmtT9VNknq/UZE+8YsnrbVUBHOEIv
         eWmSvkg34bHvTQwXWsONhdtbhYyhbqM97LAOfZGwYcKKitR40ZLsYQAqo6Vde68DDbp+
         YmfPj8HH0kiOoFx0MoWiBkBJuprgCmfBZF99DTPRKHa0eEdJ1EH/IXee0uk80oj3CFIK
         gxQKe/QBPwIyDCl+331Vov9/pFu2QPPJE1DJqr6MxKzq84mm0Zsgy5Avoy9Mgo8xud8B
         9R1n8JY0Ykv5G/e5YnvWYMv5aUIcBdreKXy6IT2viqhdvXN8qaBd8YgwCm9b7WQYH/X6
         9dZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767956776; x=1768561576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TxFUMFoBKTYWtOsk/VSHEKe5wy+98xWUwhsYV4V1C8A=;
        b=qpcL1L5J9CPoQSPdIO831L0dgeaX3bMv1dLWz7CDyQAYkNjxr1T9iz9AqnVnAY4p1x
         T8oD8BdUSms99Zn7EF1WciFdGerxjnelKHxFT30/eJqwOHPBT2VcI9zgr8Y+e+1bs8IH
         ukkmzwLpaAA+6tw8Ms1H9AePp7xtDZh5FKYJlaz3pbNqxcAEbwzTK3+reNrAVofoNAUT
         7eNS1wzDKNkXrCE3DD+myZrodO4k7n4f0Sk3NIapEHy751JbEpRIj38dPpnaCaYU5v7t
         P6SFLI37MkqiEbbrlb+L4HxRO4vr7Zh/Rl4Yqp4klQVlR/674wEiaGALqOOTPXszqpB8
         oYuw==
X-Forwarded-Encrypted: i=1; AJvYcCUPdo22S789JFZr4AlkHBQ/vmQQnU+MhTSiniDqD82LNlEjzL34ffycN2mXmTq81NrtAe4yhEkxvdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcK8p2SizlMeBBRralt4e/H42DYUmtJR5OdfdpuIWWUHQikWzt
	AyKHJRRk6QdQq6sj3Yjwway/1fBcgUl4i3zXoMXCTILPtdd8JF4s/Fs=
X-Gm-Gg: AY/fxX7QfiuqQj+XcS2RA8t9Lcfp37XavUU4q1c3aEhk2O055kbxAUj2CfikAyF4nJR
	qpZLQS7I1VFvFpyfoNPagFGQ3ehAZw361Ct/fxp79jQoGke+sF+bSoJaW/hWZKOkntb4zRvR867
	41NBGFCEHKW3Aty+cBzdhC9h0UzXcJDvxnO+x0clw/oge/DpZlWr3IaDmYEpni5UAcdTLEjuIwM
	6hGfAwDuL0O6cXiKZ85W+juqqDOTd5WK1ISyqDcI6B5Rl3SahCnkrCF9Xeg0S2zZhWe6Cw+9Nba
	p/uFYDOGfMGiU7FadLxbORmLu3AAf6JkWI8rNGHKCmSqUld54RmRPwM+01mhqUqTxDNGQg7LnIz
	0qImWBIdNaomTD4+Lj2uDgR/0L/zts9OhhMtf9BrmdAKi3CFWught5Vy8BxJWG++ontJdf2YP3w
	M9p8Ejl2B1MT1YikA=
X-Google-Smtp-Source: AGHT+IEcCIF5q4w23kqNSH0TmkW6lcxveVlDrJucdG2n+7nDKHsoEHF08l7LWzBlXmTgd5h9lZyYAA==
X-Received: by 2002:a05:6a20:a103:b0:361:2c56:fca8 with SMTP id adf61e73a8af0-3898f9cd68emr8378899637.50.1767956775758;
        Fri, 09 Jan 2026 03:06:15 -0800 (PST)
Received: from at.. ([171.61.163.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc02ecfccsm10334516a12.13.2026.01.09.03.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:06:15 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: YehezkelShB@gmail.com,
	andreas.noever@gmail.com,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	feng.tang@linux.alibaba.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	mingo@redhat.com,
	oohall@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	tglx@linutronix.de,
	westeri@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v4] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Date: Fri,  9 Jan 2026 11:06:05 +0000
Message-ID: <20260109110607.2971-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109100840.GV2275908@black.igk.intel.com>
References: <20260109100840.GV2275908@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I dont test it, but I do review the code and fix the issues.
For example:
Using DECLARE_PCI_FIXUP_FINAL instead of DECLARE_PCI_FIXUP_EARLY is wrong
because DECLARE_PCI_FIXUP_FINAL runs after PCIe is initialized.

If i cant install linux, I can’t test it—that’s why there are multiple
revisions, each fixing issues found by code review.


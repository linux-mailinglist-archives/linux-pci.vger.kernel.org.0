Return-Path: <linux-pci+bounces-21733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80F3A39E48
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 15:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3D31637FE
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 14:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C9E269822;
	Tue, 18 Feb 2025 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JM2U3cOP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D31207644;
	Tue, 18 Feb 2025 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887677; cv=none; b=SwAFoKNpR51bxDFE+pZ8uG5nHnRV1jfm+aMjkzEQkusmHNB9QMvoE0kYiby+1OQuSpSFNxh5T9b8W+YHnN+Si6612LkQmDtA0agWNNlMoODOKizXKqm5APECr75cArPTur3JnIgScHWhAx5N5UQJOiWY4ZLs9TC5yDwzgdJhYUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887677; c=relaxed/simple;
	bh=FNvj8sCueTrxfOtK1bE8HaMBcrhFqMBwyCdDzbGaNRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oj9Xb9tlt4eL1+Mg7Dd4Fr9gpufktvyHy5ZF0LPaUDN9FzzQNK5jU0Z5op1qR+Mz7sUuhytPSTq21x2BEBbK52imztd6uoCddQwjH6euri6MFwKMSBMBKI+jFEwuIg1XzIt4OIs3qm143dk2dXRguLRPhVyhSgsRjrjGrPI8kyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JM2U3cOP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc042c9290so8344716a91.0;
        Tue, 18 Feb 2025 06:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739887675; x=1740492475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAc3ks8m7sc7B4PDBh8P097QzbrGCXimimGuS9OzNkc=;
        b=JM2U3cOPf6P9xAbUfKtqKmTi6F/djpLJVnmBJdLHlHe8OsVzjdOhmei56T2J3WGVIC
         e4W9B5BR9UvkoNNa7jt5pZzPumgN8b66TEmaoxHz6GSoDWpezwtqhZBLPTaGy4d6uUox
         K3Z039E81LMc7P/Hx57xxR7yb44Dmz/Q6bNBzxOvBFgzk24xLhhtqxwdiUd9FrIhQYpD
         VjFaUQbCcZ8DWE6lKayn0TXgur4TIWA4caKSaqSPi+WDe5KiRKQrroOoNoz0SQLtbzrr
         dO6xCsTE2h+Z1KwzJ0sI8SlncettZOs7BMGNtO0NcOtULAoIwiz9WJYgRlTmQmEgnrQ2
         eXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739887675; x=1740492475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAc3ks8m7sc7B4PDBh8P097QzbrGCXimimGuS9OzNkc=;
        b=OnQJJ69lsSWc0edHTOjGbQalPeBy/senyD5RnpM1kY022wbIGHVOMuFqB63XBNLLp9
         DAxL+xF6inz7fXJ+EQLdKho5u3YPTRSuzxM10fpcU4S2z/DlFzSfrZhkiC7aBH57yHjW
         pd0YAjFO+pn9HCjOfhMsoVa9doUdFKl5RYmLhs1lQSZyc2I0Vj676orQnuXtLcpqrMsx
         4GFJdbb8jCbJWO7EC7r/TZL6kBnblPLd7cOhNp3jhhiH/s4KnX5r3jN1Gni49W8ilaFQ
         s/52ZS6DsmzTV4Pbj9TW65vamtVmXRD5Pt95OpV+oTkYC252eCH0/1Mqn+CO6//pp3TK
         ZJLg==
X-Forwarded-Encrypted: i=1; AJvYcCVQzUeMSPI+eEAkPrbXwhh/m1uoY9pnj9EdHq8/c20vRP5rnAJFrKkeqlNLQlLFIZmOalUVyDQnQiXpqgE=@vger.kernel.org, AJvYcCVsq36IosWHcUTxANsvz63aQbZl0PEE41QFv1KIlt4TSQH7U1ykaRTzoFiF5SrshxqDgBwxi5kmIeKD@vger.kernel.org
X-Gm-Message-State: AOJu0YwakItEx3OgQDjuDpnsxbPhntgLpdEnI0LarBtl+VLbkgrI0meT
	Gm/Uwe4GuoqEGWbe47HHWTMlvr2BtnwXsqtGg+pqjELbmN2bJkqN
X-Gm-Gg: ASbGncv+UGb6UWVKm8Hpve69NErwEwODufLKLEBnZ1hc3b3eMd+y2h3HR/LC/I9ExTW
	nKHmTXKKOwJz8IX0TAV/DtvDMxW2jAwz1QqrBacJI+jAA9u1+G8blxRfBEfgQE6PJKsitdZvruE
	L5sy4OvsV8QUP8GEa9dDgqqbl4QyJI0lcL+ouI7teHW0lxvpQIBscErEilKvJzaXe+WR/JUqJYU
	ftHx4rfWlSwxPe3EH8V84pyGLrDzCjfONhy4igdrkRIsyhb/2wvF+NZ4frAPoJdaHO+/rY1Fapb
	FE/4RGDWcgVm9JiI8g9hPiuhRnGbTSA7LyDOQxWVqIHqKn5wiRFLOgYh2Snugnyv97LPG64lZ/a
	HkCPnbQTahdbI
X-Google-Smtp-Source: AGHT+IFPN68wS30Nt8EqquCKHrPPdtzyNgfnZN8Uy0UGUn+srQLGItB26KLP3BnWcgivH+bNyazbLQ==
X-Received: by 2002:a17:90b:35c9:b0:2ee:ee5e:42fb with SMTP id 98e67ed59e1d1-2fc40f1076emr22333960a91.13.1739887674823;
        Tue, 18 Feb 2025 06:07:54 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13bbeec8sm10037888a91.49.2025.02.18.06.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:07:54 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: bigeasy@linutronix.de,
	lgoncalv@redhat.com
Cc: bhelgaas@google.com,
	jonathan.derrick@linux.dev,
	kbusch@kernel.org,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	nirmal.patel@linux.intel.com,
	robh@kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH v3] PCI: vmd: Fix spinlock usage on config access for RT kernel
Date: Tue, 18 Feb 2025 23:07:45 +0900
Message-Id: <20250218140745.16065-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218080934.IRRZ6B6h@linutronix.de>
References: <20250218080934.IRRZ6B6h@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luis and Sebastian,

Thanks for checking in.

On Tue, 18 Feb 2025 09:09:34 +0100, Sebastian Andrzej Siewior wrote:
>On 2025-02-17 13:50:37 [-0300], Luis Claudio R. Goncalves wrote:
>> On Thu, Dec 19, 2024 at 10:45:49AM +0900, Ryo Takakura wrote:
>> > PCI config access is locked with pci_lock which is raw_spinlock.
>> > Convert cfg_lock to raw_spinlock so that the lock usage is consistent
>> > for RT kernel.
>> 
>> Any movement here?
>
>Reposted as https://lore.kernel.org/all/20250218080830.ufw3IgyX@linutronix.de

Thanks for the update!

Sincerely,
Ryo Takakura


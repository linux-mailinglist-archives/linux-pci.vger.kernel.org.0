Return-Path: <linux-pci+bounces-18746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B149F7180
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 01:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0740B16B09A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 00:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65815171D2;
	Thu, 19 Dec 2024 00:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxmqfVtq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D1F12E4A;
	Thu, 19 Dec 2024 00:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734569747; cv=none; b=Qruz3kpeVJ6faw2oksqtN+I1R5cekToJVyuj7cy4n1iiPbNWG7dC/IjFV34cLHyGATDQNJLA1Wyuq+6NB8SEKf5zjeGYnvGv+cTvECUkRRGpseSADW/mbUKdHinWm51jJ/yQ5TKXCcp/QyJ9uN3BaG6fMuNi6LdM8yF76uLFtWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734569747; c=relaxed/simple;
	bh=hd0ZlzWgSawFh8+8A+rV7uc3ocDRTNeUduIba2FQg1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+MX5H7HG838BMJCg9dg5pZZx/SlpbvWPfW6Ng0w9sSBuP6eKY9Yj/LbMMb7UaLp1Ikp49iutSo1JUrQ8FriyVWMHgHhYbTzC6sXm4Th8QkABizncUqp3dFSydLGxq0GGCtXSlUTcISs40tHK1wMdyu/JrkKbqvM4+axxM27t20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxmqfVtq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2165cb60719so2561945ad.0;
        Wed, 18 Dec 2024 16:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734569745; x=1735174545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z2JJA+VVWbDFlxfMN+TCjx2RUrp/JrvgBtYLZGV9fQ=;
        b=mxmqfVtqumfap0c/3IsLFU0GOSQPifgoNHboDlyovgoDcA+kKaaIr607kolumImFq3
         ueZu2uOsWpSpT6oB2qWxoaAyYNfRQFg+auB3/U3c1y9WunG3QIvcdOeybP70IS9EVCuc
         pRncUSRa1qcWOPBCp4c5Ui9+kuLn/oLdaMNhflifHS5xBkoB1Ss0htyR49VhIVgUlnFW
         RgrPSgFTfIy6SCVvhwiCYRYZumTdB11MXJKthc6GC+3kr7cH8njlj38TcKnGAFbkpwG1
         ojLkKQuiVfzOCOLJ366mgJnaMu2KkbHTEN2OGL3NCIOyxhDkBE25tsRSkq6XI5/RcXYH
         1z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734569745; x=1735174545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Z2JJA+VVWbDFlxfMN+TCjx2RUrp/JrvgBtYLZGV9fQ=;
        b=prd0CURz3PGJOi4/DGsZ+ncqX/gKjHUbcJiLh6bOhOdrLEYu8IC482VFMp8ozWsf9b
         +SBEd7RjJJOXEYcSH9oa84CalEq2SVNSjGbv8GHNI4qGszHD7KuNcRECO4FmNINOgmHY
         qTpNkG4uB0jc/GQebHUBRJHSQ0ibm1VtAIJ84j72DrvwbA3JpqZFVVGPPKBhAgEPb1Jv
         JoKh6b405NtCQg+GiS/W2ZD6MEKI5tZmSRiCYuwzG3rEiWdJzlwDP7d1t07a0mj2qIo5
         0qiged+/mAp8OepTRSDX5ZukxlIEp6Q2RhbB2ZlE2bP7TeEjcYYDJ6m3C6exlmts/vud
         8vRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPrTUC8mIbZcfAjct0VoXQ94XV7vWP1Jm+kExC5uX6/WZRBeIPDYIhq+ei+W+TzdxqOruFBHOimlm6@vger.kernel.org, AJvYcCXVjiM1h9qENgHhjrmG5/W8Mwov++GUlnVIifrEIeusAt90AbW8Ryq57M4GYpKdfpkkTw6NF8ihMYTj3x0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzeKhQ005aDt5uQpSEbaGOxMNptjilh0glA7O3hb3NjeYYHcjb
	UIfSskyB5gtlDfDKheNxfApR+LV91c9G9Iusr3yNRWiq03gFx5DC
X-Gm-Gg: ASbGnctSa8nu3R7u4ZPLVGRktBPHZOh/Cijmx3CZXKK+vzdFRPQ1sklg1YVcz2M926W
	fAcOPEQ6CTT9Usala/8IiCWM8FTrY2mzchcCZsYIYQTRfcOIh67CO/Whj29sZdS8Uybma5AT8dh
	REOtTDG52wn48Tf9fnWxaHgZoJGfYdybGFJFBAcjOvDOHnjKXt+kqXbHkA8MVQwUdLwXN4KwDI+
	VWg28Fi4dT1aJZbzc1gQqGP2J/sINxsM3MtZsyMbWxOSscB28daAX8C/XziPZwpiZPZIOodYV+y
	p/8JzMLquAP1tLcyn7LuzSDPAQA=
X-Google-Smtp-Source: AGHT+IFvQC912dfQQj+RYYrtFJJbdM4bKFikCtfL5Crx1hXDf1k/rw3oosC5thpRzFx/YnswfK/uTw==
X-Received: by 2002:a17:902:ce8c:b0:216:7ee9:220b with SMTP id d9443c01a7336-219d96268a0mr23576035ad.22.1734569745167;
        Wed, 18 Dec 2024 16:55:45 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96e867sm1482065ad.71.2024.12.18.16.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 16:55:44 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: kbusch@kernel.org
Cc: bhelgaas@google.com,
	bigeasy@linutronix.de,
	jonathan.derrick@linux.dev,
	kw@linux.com,
	lgoncalv@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	nirmal.patel@linux.intel.com,
	robh@kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH v2] PCI: vmd: Fix spinlock usage on config access for RT kernel
Date: Thu, 19 Dec 2024 09:55:38 +0900
Message-Id: <20241219005538.9125-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z2LsFoXotl_SHmNk@kbusch-mbp.dhcp.thefacebook.com>
References: <Z2LsFoXotl_SHmNk@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Keith,

On Wed, 18 Dec 2024 08:36:54 -0700, Keith Busch wrote:
>> @@ -385,13 +384,11 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
>>  {
>>  	struct vmd_dev *vmd = vmd_from_bus(bus);
>>  	void __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
>> -	unsigned long flags;
>>  	int ret = 0;
>>  
>>  	if (!addr)
>>  		return -EFAULT;
>>  
>> -	spin_lock_irqsave(&vmd->cfg_lock, flags);
>>  	switch (len) {
>>  	case 1:
>>  		*value = readb(addr);
>
>There's a comment above this function explaining the need for the lock,
>which doesn't make a lot of sense after this patch.

Thanks for pointing it out! It slipped my mind.
I'll leave it as it is for the next patch :)

Sincerely,
Ryo Takakura


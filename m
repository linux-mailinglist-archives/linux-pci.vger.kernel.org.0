Return-Path: <linux-pci+bounces-23716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE6FA60A6E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 08:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B9F189B00E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 07:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4739913C689;
	Fri, 14 Mar 2025 07:53:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1D8632B
	for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938812; cv=none; b=ZE9tQ1DyniWYouHX6URxtKJTTnT4z//oVD+NN4smTsUtoVIsC/lMTfaY3hp0v2uC7TDJ+uB4fARSqiW4vk3qN/dD6brZzhYMuRCiFkNpvZAfxpbIiFT5W7rNnV1dr5q3UgJFwjWYmjSUWt/X/dD1NycIuZJLHwrZTryt+I9VZzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938812; c=relaxed/simple;
	bh=aAuswwHsiuhD3HW8WXSWoakkks1Vr0a3d1bWMDx1xV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1HwoFP4CsWiLK+6I9oAurKleFwJGRWporIwPldQc8oJ4xuCBkTu0h6z8xVAmwr4LSJ5nuua6ZZQdsFDdVTQW1JESdgCyngvM0h24yp2iJnrFEyeOenyE4FqYVJzUmcQe7oRPYRrhaATYgRzh8W+QH/r7F8NwtNAAPrxLqGbaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224191d92e4so37172245ad.3
        for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 00:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741938810; x=1742543610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oN0vK31t5glTKVVqxH3niTQURleFkxhYu1TphChG+wk=;
        b=lK9z9YBY2AQ6y080mEUbPEyjNnjs4f6y7Df10VSCV4xY9bmM+mB7wpFNxko0L3DHTV
         i255GXRjKGNv+wYrIZOGjE7KZzGMTXDFJTEA2/Cij1RHoGTKsrAnJWkAUQhQLGriIUb3
         MzHhZyrKtHmP2yUJwmaaxxUCveafhJWp1sz4NAIBYat1+9tZzzcu2xWhrqcpmakDlBZ5
         l1pzQ6VNZgrevprRPrn72LAFOB9spuaDkPoXpNlGpNJHgk+9N0ZAT1/Q9pTaKVS8xOaq
         C920tKIcprqLck0rEBaU/MBBbzSEJz3yYd9gYCJYt9PfS5qbPRJasFLwdNV0LhnH049Z
         LUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo4jAu3jS5ZPKdiJKM4UdMb0zt4u73goBBYEKkqZW+wIzQdj6goSbKuez+wlJQpalLSD0lrVhMhfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXvPeXaEyYVcTbuJP2UTyPyYeNreK7Sc+xsc7PxLRzyNbIgoeQ
	7m/l72Fu5ZIGF7CYJYnozobjNqjgIHKKdmwRFAO5YJMS+TRD9fEL
X-Gm-Gg: ASbGnctjlQOD54o5UV4tQC94sGG/OowW172FscT9HpTzns/WViIb5o0PUUZfdqywZXc
	4578c6LqS278cqXtFG5l/fd+H4vl22WsubXhwx11sFmRvLwFcpDabAlwGCMjOogBh+uAKTZxta7
	3+GbPo8RfIREw++nOMvtLTdsYG2/u2q6tnlT2oCMoSXcysPKLVwUEdlIMtIrTxMdhiX+m75pbTZ
	FAFdj9XSnNhCxnXSCZV8ZBz/S5TypxYzPm8kYueQrH78IRy3aaKg0SAu56IDHBo3yHaunuObxpx
	7jr5XVbxluNoP7u1UvL8q1eYlgsAFSiAM3Zg3JknvjvyRRYlSUf4rwyh7KUXwuGeTADx0/o/hJ9
	sKrsq5M98EZ0/Ag==
X-Google-Smtp-Source: AGHT+IGgIX7VNOqmih3M7fcNlNO27NHnunNlxQBXQ3mpVz9xqnfWtWUod9nIHjQ2u7YLS+bXhc8Mbg==
X-Received: by 2002:a05:6a20:9d92:b0:1f5:8cc8:9cbe with SMTP id adf61e73a8af0-1f5c110f3b6mr2883040637.5.1741938809949;
        Fri, 14 Mar 2025 00:53:29 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af56e9ccc3bsm2338475a12.7.2025.03.14.00.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 00:53:29 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:53:28 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] PCI: loongson: Add quirk for OHCI device rev 0x02
Message-ID: <20250314075328.GB234496@rocinante>
References: <20250121114225.2727684-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121114225.2727684-1-chenhuacai@loongson.cn>

Hello,

> The OHCI controller (rev 0x02) under LS7A PCI host has a hardware flaw.
> MMIO register with offset 0x60/0x64 is treated as legacy PS2-compatible
> keyboard/mouse interface, which confuse the OHCI controller. Since OHCI
> only use a 4KB BAR resource indeed, the LS7A OHCI controller's 32KB BAR
> is wrapped around (the second 4KB BAR space is the same as the first 4KB
> internally). So we can add an 4KB offset (0x1000) to the BAR resource as
> a workaround.

Applied to controller/loongson, thank you!

	Krzysztof


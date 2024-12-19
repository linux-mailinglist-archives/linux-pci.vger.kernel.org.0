Return-Path: <linux-pci+bounces-18745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACD29F717E
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 01:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DA316A422
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 00:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25408156CA;
	Thu, 19 Dec 2024 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKZklfbJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA768BEE;
	Thu, 19 Dec 2024 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734569625; cv=none; b=OdTkANvrL6a6u7w1IVlUuvUHGWFOCoXctdJfIvn0DFS2YvtfuL4L5dvpYiIJQlQkS2NyuGVqoatPakfYaVwpsPatzZJ1aXY4uKGghurbYCbNgL1VyxUEPTJDZUs35rYOALZNtVA0QzVrvn6AJTckIQJAPf7rnLVsP2994HWncdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734569625; c=relaxed/simple;
	bh=EOPeJWFKkfolyzIs32z2IuWWNI+wX1K+ZvhIv/b7oqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ohEB0LlGQJ6IIEoVd4waMFeqPoUwYq1yw/AHCLxuQsOatGQ3QSo+YX74NogHjdZIKY1qpe4rcykARXHXZM2g6eavT2/TxDAaz+z8JB/Y+SXfYAVUVSly587sq81vtTdHedmH8twn3Xp9Q+sjBxcAGWMiSxDJnEmK6M9QAHv5pFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKZklfbJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2164b662090so2127355ad.1;
        Wed, 18 Dec 2024 16:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734569623; x=1735174423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6P22t71eXplU/Scm9+lQUJ09MBJkdnAjgqbBSgYgXA=;
        b=MKZklfbJB6bsDuGj3coMN4b7TABrmkSvmAn4p/iJcPhdJ4h99+kHIv5Rd+lNLw4vP3
         cpLCPmu6PeuabwVF8+8JeqgTn/eNIopPZDsJYVfbBaB8lDmpzQawiaelRFsZyqjB7S0E
         NWmvYiv9voBjHAFhDJBh55RVAzt5orNlnlq7qDdXwpXpY9enXLSRcju7HBBT6eNgdO/r
         oJDpSMQo45mQB3Dkme5KLjMJMMTR63WX2sfxdCfr3DyKL6wodVSG/UOYvbjh0xW2KoqI
         nw3DCxnhQDRXtQBxeQwXHLBcx/XB/UvRo7BdqmY0ZsSL4st3FOFy3ppdN+BmI86Amzr5
         gl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734569623; x=1735174423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6P22t71eXplU/Scm9+lQUJ09MBJkdnAjgqbBSgYgXA=;
        b=frX9c9ZOZW2nbt26K0mUeV0yDpouzpReFRQBnr15lEUhGV+Say+2etMMbsG9DYUvic
         3aCRTdHk8WBnEdsFljvvuLQG3v+oAyqtqmG96S5nTg1JpRu5uEx9WFS8gQmo7GRCnqVJ
         oqFUVkKaadagLuUn32RIzoIgA3Hi8U6lYPNMOCIAl3VJU6Xs6zIED+F78tCbfhaztMPe
         JEXAVH/Xz/3qRLeqUho/SgN74rAWrYdAwixtfAoBGKY4ooHH8kmFYWCXSSHw2mZUAuxQ
         4fc3QyK374acDLVUZj2Q3wKBc5KLfnX4TkM9wrZMUOzHMGnN+Oexj2QtDx8uqOzmvts4
         mOLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9ie4TSKG3xKfd2uV/NbywbrTiru87/qzBzMUUL8KrrcnClhyR/MS4iuJyMWJeaNSjXbNZSWAtSgcB@vger.kernel.org, AJvYcCXXRD8brtliS3qd1X1IY+4BdAvIYNGrpx08cc6RGnCEkGJy2WEzzMG3WrPknw7F49Iagm3nhqeiHCNXnjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT2pN3e8tCmoAo+zwkL9G8Octz9gWC+bpFyHDOaTd6U4XtWc44
	Eb1a10fo5fBOX55MZzpCZqgvn/PYua2P9tzBMQNLgikE9blQOCbT
X-Gm-Gg: ASbGncs5miP7ti4X6my5SmglzP7+nC7BhkkjBW4Sr8/O9jOv0WDCH/R4w0HhmoLfAOR
	XoZta+JvqP09j4fCgDlI9cj0VQBg14sobU1vM8uc2oPW+okmSwXIh8CTC6d+vNLoz7Q+1LUYTpc
	XV09j0MPNg35cHarz6b7x5saQDFSqQq+TVUThSBrFxg3yUNdHpgC1oYrr/FokW4OJh62fG3Vtmp
	Cxha/4cZA1MiKUajgHbpCElhcYvmMMPFJpPVBpVjEnFPSFLY09RpxsjOOdphUn5IIf7TzrrfeHW
	Lx5vXxYKLG+yVglmC6lIeVQoOhA=
X-Google-Smtp-Source: AGHT+IGW38w6i0YeOQJj9ksqeHVscin8l0lI1gsV4DozSIxV5ul47YixHhCLAMwe/3+S8lF46QC73A==
X-Received: by 2002:a17:902:fc44:b0:216:4c88:d939 with SMTP id d9443c01a7336-218d724d4a4mr85947935ad.38.1734569622823;
        Wed, 18 Dec 2024 16:53:42 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca01965sm1376775ad.240.2024.12.18.16.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 16:53:42 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: lgoncalv@redhat.com,
	bigeasy@linutronix.de,
	kbusch@kernel.org
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
	rostedt@goodmis.org
Subject: Re: [PATCH v2] PCI: vmd: Fix spinlock usage on config access for RT kernel
Date: Thu, 19 Dec 2024 09:53:36 +0900
Message-Id: <20241219005336.8603-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z2L5u40lDvK7_Gdb@uudg.org>
References: <Z2L5u40lDvK7_Gdb@uudg.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all!

on Wed, 18 Dec 2024 13:35:07 -0300, Luis Claudio R. Goncalves wrote:
>On Wed, Dec 18, 2024 at 08:57:53AM -0700, Keith Busch wrote:
>> On Wed, Dec 18, 2024 at 04:48:38PM +0100, Sebastian Andrzej Siewior wrote:
>> > On 2024-12-18 08:36:54 [-0700], Keith Busch wrote:
>> > > On Wed, Dec 18, 2024 at 08:59:51PM +0900, Ryo Takakura wrote:
>> > > > PCI config access is locked with pci_lock which serializes
>> > > > pci_user/bus_write_config*() and pci_user/bus_read_config*().
>> > > > The subsequently invoked vmd_pci_write() and vmd_pci_read() are also
>> > > > serialized as they are only invoked by them respectively.
>> > > > 
>> > > > Remove cfg_lock which is taken by vmd_pci_write() and vmd_pci_read()
>> > > > for their serialization as its already serialized by pci_lock.
>> > > 
>> > > That's only true if CONFIG_PCI_LOCKLESS_CONFIG isn't set, so pci_lock
>> > > won't help with concurrent kernel config access in such a setup. I think
>> > > the previous change to raw lock proposal was the correct approach.
>> > 
>> > I overlooked that. Wouldn't it make sense to let the vmd driver select
>> > that option rather than adding/ having a lock for the same purpose?
>> 
>> The arch/x86/Kconfig always selects PCI_LOCKESS_CONFIG, so I don't think
>> the vmd driver can require it be turned off. Besides, no need to punish
>> all PCI access if only this device requires it be serialized.
>
>Sorry, I also missed that and induced Ryo Takakura to rewrite the patch.

My apologies I missed that as well.
I'll send the first version of the patch once again!

>Luis

Sincerely,
Ryo Takakura


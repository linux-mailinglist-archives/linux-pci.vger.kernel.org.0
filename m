Return-Path: <linux-pci+bounces-32469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675F7B097D9
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 01:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64DA17BE87
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 23:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDC52698A2;
	Thu, 17 Jul 2025 23:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="e2I/Zxow"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41219242927
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 23:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794888; cv=none; b=hpNG1OiAolBQ0yXOdzWn9q+u//u1bhHqK/X7Q4VEusfTK3g7VZaHXER1L+FZUM0BtwrSl878c0s0ThaB5JMqR4TDyM7KGZY2vCqnf1Eo7ym1K8NoQ5TKu5vJ/HDZzMnFBrMrwknVhOH2AvqVwMYlQPI/bYonCk3zx0dIAmdXDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794888; c=relaxed/simple;
	bh=iAu/m/Ked4Yjj7vjRUJ1EMyr8TIJsgKEj/d7vMIV89w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyjqTEE3M1ea6RmL/wYDxpV369KCf4kvrKXyzawP78V6mt4IoFGPqFLYPQ7hyrB4X7RG8OzLm+R6x/89vorPuJtcHgbckiaNc3pNt64ziRZX09TDZNfs0m6VxgCo+sWaLIa9+Ikj4uc7DQOdhi9yLVu3tSAcvP5iFx3OjPBtmmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=e2I/Zxow; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-311c95ddfb5so1218996a91.2
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 16:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752794885; x=1753399685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CqGazWb6yxiRvzTGHHODvUW9Q9sXD371hPyILW32ck=;
        b=e2I/ZxowhVOdfWe4Qr1QfQT1dNLuEcu9Do3YtjLtn3E9MYzOkKwFFuOg9qtC6GGZZF
         T/pNRCyqYmxvroJoDEvMsk1eMtppLJh+PjmAX7G6PP6Uy2jyoc52eBNmiLuOrS/OKCg7
         RwNJfvs5nnGXWfnsLX0I57ghxJlqHmX1AbiSWCq+Lg+UTB7bFWVt3gzGDnPxd09T6R99
         MGnruGj/Q946wZqYEV1DB8yK18LLPp1/85QnRo8V1wEjnvpaaVryvGQ7V3SCy5jNffmA
         Y3Y2iLxmfiWUneLZRES1p3sysdcNci8Kta9lyNtuGooeWgxCHmJ/AXVs6M5yAmUTq1Uc
         Nncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752794885; x=1753399685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CqGazWb6yxiRvzTGHHODvUW9Q9sXD371hPyILW32ck=;
        b=mA1iWlvPNOrkKQHgqG08zn2amm0kj4chwlQkkQvj1y3edJC5JXfQKWdyA2lAPMU2tB
         +hik2/kYhjlsgOqKGyN/qwOG8rOK8Dg0a87RSPq3+IVpH3nrvkjhhkI9B36O6qhH5w8Y
         hxJWqYxVSY7qyUavbmyQ/zT2Qof5xeXa1pNSiQNKsCDppg/UWQt7YYvtP8b+xbV/hbxi
         I3KGSzZ/eRPVK1j3CnD1CyY/50rcPlL1qAYL/JJBhawTGEa5YLlUTGLxlno4yeCMqJJl
         1qsCQV5MItsWc6SeAIWLVhdobDjhy2NiKNNZM0oO497upW8KoZpViu+Y+YGTm9dI3sPC
         79pA==
X-Forwarded-Encrypted: i=1; AJvYcCXwX6c4IBe1TnQhE1sTWFqp3a8JQCozVD4omWUsnVhS/p4k0DYXYjmeNUkq3jTOlSaxAFJ67D5Ef3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzilmb3AlhJN69xcQrEK1ol5/Qgn2QZQJzaTtcTGDEq3HWesKXD
	T5Th3pUHReeRrvj7qcDtd0qErtKFqeYy8Wr81oewtcRHxMlh47tVYO41MkaIrd6f45U=
X-Gm-Gg: ASbGnctQFPjOrfnRgBNyFUabK0NtZ/e16mvj/9ruuJ4SzQPmp9yRoV8dIOqEu5XOcNO
	iwMTezXowmLB6mb0mCtDNKvWmMgrgFz/WLB4nJW9lZt7b4oIhifeyhEJPlJgie7IOxNXh/vQ8gZ
	wOttCGyQaJar9PVv1AEPzxhu8aDpP5fVMpmrGoxNVQwLWviFSGOvG7oDTgkxDFcP91PW4KEQAEn
	gWJsMI/LjVQk197eViDAz4ZtuB9mTnEqsmSlrX0QoNOWGHSCxegHe5/SHw1y4aoiOy3ha3KGGGp
	g/MUfZj7NDsgHijpdXMN8WU15xyvCLZiSOLFrHPyGcQTi4IV96lqrOAW1kh5/8FrtmVZ866kL0v
	PXjMAARdhzkjythIgBjJZxu7YXOt/eEW3+0JAWtC59niPR9Ou5kq9kHwBNYw=
X-Google-Smtp-Source: AGHT+IE2fvU0LI5VyMAsBnS6jAOFpIF2Ch7bsj27Ceh44Xb5VQmNCAIyLSIUVF1pWxqlVk2eBTBkQw==
X-Received: by 2002:a17:90b:5105:b0:311:ad7f:3281 with SMTP id 98e67ed59e1d1-31cc2544404mr1063803a91.12.1752794885293;
        Thu, 17 Jul 2025 16:28:05 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-31cc3d5e765sm101318a91.0.2025.07.17.16.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 16:28:04 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: lukas@wunner.de
Cc: anil.s.keshavamurthy@intel.com,
	bhelgaas@google.com,
	bp@alien8.de,
	davem@davemloft.net,
	helgaas@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	mattc@purestorage.com,
	mhiramat@kernel.org,
	naveen@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	tianruidong@linux.alibaba.com,
	tony.luck@intel.com,
	xueshuai@linux.alibaba.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug event
Date: Thu, 17 Jul 2025 17:27:58 -0600
Message-ID: <20250717232758.24605-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <aHlbtTxO7mR9XfGX@wunner.de>
References: <aHlbtTxO7mR9XfGX@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 17 Jul 2025, Bjorn Helgaas wrote:
> - slot_name() (which I think comes from make_slot_name(); would you
>   want something else?)

afaik it ends up coming from the Slot Cap Register "Physical Slot Number" bits.
I brought up the slot to just say that I was happy to see it & that it is useful
for our purposes & why.

On Thu, 17 Jul 2025, Lukas Wunner wrote:
>> and IIUC, it would be helpful for you to add:
>> 
>>   - DSP Vendor/Device ID (the Root Port or Switch Downstream Port,
>>     which is relatively static, so seems less useful to me than the
>>     USP/EP would be)
>
> Right, this is already logged in dmesg upon enumeration of the hotplug port,
> as well as available via lspci.

I also agree that the DSP Vendor/Device ID is less useful.

>>   - USP/EP Vendor/Device ID
>
> There's no 1:1 relation between link or presence events on the one hand,
> and enumeration of hotplugged components on the other hand:  The link
> may go up but the kernel may fail to enumerate the component, e.g. because
> it was yanked before it could be enumerated, or because the kernel has run
> out of MMIO space or bus numbers.
> 
> Hence this would have to be logged through a separate tracepoint in
> pciehp_configure_device(), not by changing the tracepoints added here.

Ok I think its reasonable to use a separate tracepoint that would have more
information about the EP.



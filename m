Return-Path: <linux-pci+bounces-43551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA15ECD79D2
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 02:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE092301CD3B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 01:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCE7219313;
	Tue, 23 Dec 2025 01:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="aSpD6Prz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC9E2153EA
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 01:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452365; cv=none; b=G5TIga5sHtBMynqfU+6nGtt2ph2TxqUax4tINWKNusF8KMnDlbzL+HiZXkVxqmt5/Ed+KFaLdiQj5bl+14+PEiK0wz5jHMBf0YeJHj4IsT0c3aJVLfdMiemBrcqU2ey9jWB3ovs2rzUQQefjt985egDHHT7rq12ckG593jiJrR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452365; c=relaxed/simple;
	bh=Dbq2j1LZVKLgdsZkaa8mzE3dKHibs/tJYI8Ozs78vHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9yhXTlPV7QKpuy51eVz6GsWSnlWbFlfUE91Y0wHDwnAUlJBnvIFsKfQqprFKcAgFYrrWU2C+VLhvyBqsmN/J+hOt/WAgf5p/GzKc/k7AAB/PIlR/ycgpnsgIA7cZ7GeD238J/N8hkVeKWSLx2rhbVNWr3HCQqWlBn/v7v/flpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=aSpD6Prz; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bfe88eeaa65so3270181a12.1
        for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 17:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766452363; x=1767057163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fy2O1GjSz2ggz/uFuNChfMqNtRim6kmpGc8/7sQ7pV8=;
        b=aSpD6Przszp2FPk4SDIzhMCisVtMFOGLLbI1b2GqtblFKCQk9vXBq3Ux2OJ4QHvIz1
         n156LkkZaDkViBBNWg86DoV7QZN3s6Xa8Dfqpuxu7s+2BtJUJtFHIVpQ5XSHL76Ae+bM
         qUGMqvd5GMnI9VJFBX+bbIDehZXg5JVA22mwnuaqHQUB5XMNTmt/WssUrlgh1q/BOODb
         Pnf4645ILxljwCPDPy2w+zCWfouryy+5B6qiynoQh7BwAt4pUDD+bXOjZ7BPwKbyR2pg
         sXU0SIdctauBZe4k0lM+F1zwbR9AGggxYFGWiA16VIsML7HzQgTvUfC/NhQnjyYXjHET
         bsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766452363; x=1767057163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fy2O1GjSz2ggz/uFuNChfMqNtRim6kmpGc8/7sQ7pV8=;
        b=Dp+paTocfU8Jf/pCeq+4opWAqLuFlloADcrTE3HLhxg1D6pjcfOzUSfSm0xwW5hoUK
         8JQntexSEMWiSxxZiQCxCthYlvJ69y8xyRuoUZRmjSfEmzOCjLZIu1fV5QJ8cJxgHvh7
         5cXGWUgdTZ9WvoaI4zNt5ujTocIamZbHIQieMvrYNCcNlQKjVc8Sxde4jnVS9cz7z3Ew
         IH3eHO/4XZxNi0WIXplGGtJpAnSkvr+z3zQcaAkkPxTU5wmp6oSlxPbahVXZSRcNYDzj
         0sY3UAY58ah23Eewl293hDj6mnrsc6gEPPoC+B0u+IR1G/opnjGoNvSZ3gdkf7DjS3eN
         hKWw==
X-Forwarded-Encrypted: i=1; AJvYcCXj3r4IykgYpnSsTC9vdHuogL4zn7lR9K0aPxTI48roFm0VPpfBskuxSj+mXHz8U8gc32pEX5mUnBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFlR+7L2qObFYsuJdXoIPe++IfPniel+ZeLmxR1YxpvlTue9y3
	J3Yeqgm+SIqGVlqq/E26a5m4BO1nUInPVLpsl72BfY3ZEiaYj72HT+VS4ZbSb9PM57U=
X-Gm-Gg: AY/fxX74G8NYDYEGi3+Gk9EehOtEBmKtweJyaaaQLHFZ9BCoQD+BAUxD0/wZ1tEcv+N
	M9MB4ar2VIgRAzVCL3B+kGCFxcJiS1/W49mhpFifO/IJzbBsnZeY7rzRbujK5oLdgDrgJ2bY4Xz
	qNa3Ts2oOm/eGb49X5OWtmHJApYnSgAMv1HfPqDBThaOBP5aGdLUzpFP/7rc3PcCH4SYt9szLUP
	n7L5cOjUHCIpH+UJMAGyhAVhpqSHvyeTFBOVIjC6auJSdS67LpNVi2VKkreUYxTQj+9xdzNWbvH
	/mYzLK5uwZa5vJn+axnDe+dwYAMvNE5a0Jjz6+fZagM31rwFe3HtrIj0YfTsmGlnJyPIbn2Tj5C
	+hZQuIZXSb6gqkTdm26tWAah0IxU4pqMBeBA/vKieoYsbwwyT165abushCVRFOjUXJhn1+t6yZr
	S7n0aNL/tpucsxxjbm9UqffGeun0aSTw6ozkdg
X-Google-Smtp-Source: AGHT+IFrWMZpEsvZrXYs+Op8kcS1SkODjJG2K98a0YE8noA/gcbOsmuGFtsiKU8j/8WZoB3u1CR/Hw==
X-Received: by 2002:a05:7022:2481:b0:11b:9386:a37e with SMTP id a92af1059eb24-1217230ea4amr14077777c88.45.1766452362466;
        Mon, 22 Dec 2025 17:12:42 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-121724dd7f5sm51781248c88.5.2025.12.22.17.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 17:12:41 -0800 (PST)
From: Matthew W Carlis <mattc@purestorage.com>
To: macro@orcam.me.uk
Cc: ashishk@purestorage.com,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com,
	alok.a.tiwari@oracle.com
Subject: Re: [PATCH v2 0/1] PCI: pcie_failed_link_retrain() return if dev is not ASM2824
Date: Mon, 22 Dec 2025 18:12:17 -0700
Message-ID: <20251223011218.964-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <alpine.DEB.2.21.2512010559060.36486@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2512010559060.36486@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 1 Dec 2025 Maciej W. Rozycki wrote:

>> Root port can tell us if PCIe errors are going to the BIOS. IF any of the
>> ErrCorrectable, ErrNon-Fatal, ErrFatal, are set in the RootCtrl then those
>> error types would most likely go to the BIOS even if the OS thinks it took
>> control. Someone will have to correct me if wrong about ARM. If you sent
>> the full lspci -vvv of root port, USP/DSP/USP combo I could figure out
>> whats going on.
>> 
>
>  I've attached a full `lspci -xxxx' dump instead, just in case anything 
> else turns out useful.  I'll appreciate if you have a look.

I looked through the tree and don't see anything obviously wrong in the error
settings. Those CE's on 02:03.0 might be left-over from boot. In any case I
wouldn't expect to see BadTLP or BadDLLP unless there was something wrong...
It would be interesting to clear them and see if a link reset could trigger
them again.

As for the quirk itself I want to re-ping this review since it looks like the
link speed 'quirk' has also been implicated by Alok here in a CR here:
https://lore.kernel.org/all/c296df33-f9c0-42f7-8add-6966d89d00c4@oracle.com/

We know the quirk can be executed on devices that are functioning completely correctly. 
There might be a justification here to have an additional/new 'pci_fixup_pass'
that would execute after link-training failures & let the specific devices
decide how to handle link recovery, but I don't want this specific quirk running
against any of the devices in my systems.

  Matt


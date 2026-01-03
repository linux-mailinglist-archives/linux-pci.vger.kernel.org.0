Return-Path: <linux-pci+bounces-43955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 799F6CF0129
	for <lists+linux-pci@lfdr.de>; Sat, 03 Jan 2026 15:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40B7930046EC
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jan 2026 14:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A9127A465;
	Sat,  3 Jan 2026 14:31:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16EA35975
	for <linux-pci@vger.kernel.org>; Sat,  3 Jan 2026 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767450704; cv=none; b=KnMjx/qfUYie0zA7N4U76sNt9fYLNUsbMEFMDqDq0I2OavjGx0OXbKFP4RIuIFa1N6attuc/mC+T09qzua3P5o0H9UA2v6qunL3w7Z83IIBAO5iGzbZtu9BPCTP3C0dF0+wyvIH+8uJlvkw8++DOV9JG/eR5vpa2ERaYdsHcLgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767450704; c=relaxed/simple;
	bh=Yo9NiJnTxJkwwB8eCcyZ5gF6vklgPfAHnzpS9T2+4BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG6O6diSuRpHUnY1KjTE9Y4ealwATxJdoX86SHNERzrceYqm/xLyZHlkmDxc6q90RYQhze5d3QwI/kzd6NlV8KBcbQ5gjlx9q6jC6d5Ntwc2hmDtIHo5cEdxfSKUtFlulJBfPDT60wz47yVW71Y/sGN2jsrO4wyXbQ4qBCBHCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info; spf=pass smtp.mailfrom=markoturk.info; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=markoturk.info
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b725ead5800so1811056566b.1
        for <linux-pci@vger.kernel.org>; Sat, 03 Jan 2026 06:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767450701; x=1768055501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeXK/uLet5xBMYnQch/F6aurpQjuvhTk9qorMiPAHMo=;
        b=P1yhqt1Fzld7mZ12P7faOjAP8qPBOS3D09nXRPnv54jdnkkFxfEyfbRi62zSch4h/0
         zmFbQDG6n1+SKevpi2/0vr4FrUBL7MBlvgM5MDyrHnUg4LnJ/ijAqhRdXMoD8kib72pr
         sesexMhl/7bEYw2CVlqPPRkw63hftCgF2iabf4wWwALWIlQfklCov61uDmuu7mBiA+12
         jEMt6iAURn9xNTAecnLkThMi8a5h/a8CBhtr3ewgWxRog1d5We6LkzEA8FFifYGNXLEL
         jSTnx1XcA4RxzJLZBXip8DWTSQQjyvKSk96JL0WVIzLth3gIteiSW9/dz6ALok3DIEBS
         Gb6g==
X-Gm-Message-State: AOJu0YwwZ7PHi3pgCojYqV5dJQ1LrMcHHfcfyXZKvri1JuEvziZVjABu
	P/Jg/BRWPOeHN4AM7yEOfCiMcCFtLxH84rsRlqTybK+H33aau/z2XVTLrDCyCIGE3kQ=
X-Gm-Gg: AY/fxX7/GHj+DqcsMO/ERC+AbcIyjYfFSOS07N1oOq4/XZvVd8BCZEQGQWVHVPQ7n7b
	2k+h8PQSyQ+tdUtM7+AB6uXeui1lXi+IveDP89R0oGSg7mjeh2mUz3u/a6fAXj0qSpYUUPgHO3+
	9VX2k1xruF7+YlSlkmszYHHHmtCkv4AKKjSWZNHkbdfZap78/KwnC5JyIEnGDMm6MPfTqCWdeI5
	5+WPfYII1MPWeTT/7TLijoc8pgaZqVhZ1vbeoIuOfo+s/KganKpifvPo/MPtkVd7L9CkYBaLGDH
	ScQPHxiYAr3G3/SOw9rRY3oWE4srJS2KTi6emVFTD+NAEB8HImyCoZVX1CX7eDmiXMPfGNoLpgM
	yXkcJff79lCtb1jR82KWklrxcAGGGU9ijQvWbfQvnWx5bwiCZS8cyQLTLBm/voGkfu5w0mVEkTW
	1DRZkNC43t/Ds=
X-Google-Smtp-Source: AGHT+IENJSduuZRD1nBhGtGEJjleRZsqM+PDOV1UaW/DiyfEC1lIDZ+R5/jusjphWj25iRZFPeThfw==
X-Received: by 2002:a17:906:6a21:b0:b76:3399:457b with SMTP id a640c23a62f3a-b80371d8c90mr4327536266b.37.1767450700331;
        Sat, 03 Jan 2026 06:31:40 -0800 (PST)
Received: from vps.markoturk.info ([109.60.4.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm4772012366b.57.2026.01.03.06.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 06:31:39 -0800 (PST)
Date: Sat, 3 Jan 2026 15:31:38 +0100
From: Marko Turk <mt@markoturk.info>
To: dakr@kernel.org, dirk.behme@de.bosch.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	mt@markoturk.info
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, Marko Turk <mt@markoturk.info>
Subject: [PATCH 2/2] rust: pci: fix typo in Bar struct's comment
Message-ID: <20260103143119.96095-2-mt@markoturk.info>
References: <20260103143119.96095-1-mt@markoturk.info>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260103143119.96095-1-mt@markoturk.info>
X-Mailer: git-send-email 2.51.0

inststance -> instance

Signed-off-by: Marko Turk <mt@markoturk.info>
---
 rust/kernel/pci/io.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 0d55c3139b6f..fba746c4dc5d 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -20,7 +20,7 @@
 ///
 /// # Invariants
 ///
-/// `Bar` always holds an `IoRaw` inststance that holds a valid pointer to the start of the I/O
+/// `Bar` always holds an `IoRaw` instance that holds a valid pointer to the start of the I/O
 /// memory mapped PCI BAR and its size.
 pub struct Bar<const SIZE: usize = 0> {
     pdev: ARef<Device>,
-- 
2.51.0



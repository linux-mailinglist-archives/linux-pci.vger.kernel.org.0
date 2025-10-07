Return-Path: <linux-pci+bounces-37656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A1CBC0D93
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 11:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53123BDC13
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 09:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E422D77F7;
	Tue,  7 Oct 2025 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="Rl4lxyHt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF22D8DC4
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829023; cv=none; b=DmY/xowJzEOcI/FNY+QZs/Fp3a+Ja+lWArC+Vk0PSBMssDVrEG0CxTRzVqEO0Ur0GKuRJbSjDISlU9FP2/jRZ+wWhumgSjQLzI7Z8I8lyESIiY9Kgiy3a3lHut7sVMV9iRg7oEmSDemHhvDCP3ukYU44XPcrwrLLXdAsdkxsntE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829023; c=relaxed/simple;
	bh=DCke+Rgyj5qSCGTteE3WiBXknhrXT31kjNGo+dEDh6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWutt0t7gqFRoH9MMCTqP/w/BbG2dNOzVkQQWHcz9PGidDlebxqJK9vqdEKY3/v35snAiakohcvk519qzxFee2UEmdVcACBfZMCS2cU/zuVlvxWfy14wgV4Ni+bjVVB6i35Zcqeb6UcutKqRrHLM1cqWwmChd1OxfEhTedJtW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=Rl4lxyHt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so5053656b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 02:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1759829021; x=1760433821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYIeDOuQqkaMDFPi5xbBNKu5rw0w8hiBYlZqsaimji0=;
        b=Rl4lxyHtufz3VMla7gym9bOVGf4ti9qoez2QPJcdrzIS7dX+rMJBW0d9mx6iirsKK1
         SnrJ2+cnQ0/9vVz5AVVXuKhQZ3FxS8S8bap6mbM6OC5pL+r0Au9wiVrb7SO1/o+DCR/d
         X2YvA00r+F7RqHJOQtebPO2tNYQqs78MBadRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759829021; x=1760433821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYIeDOuQqkaMDFPi5xbBNKu5rw0w8hiBYlZqsaimji0=;
        b=csdiqk6wGTnOhKNHoPsMgZVv0cY+FZAqNAm0FnU84OdFW3Fw8AYLvaPr8mOlJy9m08
         wSfue4qqERzksg3sfPvKS/MwX7QUT4v50iYLW2RAiOydzunfcREZNhD549uB3I8buP0j
         VVWaHiLbmAAz/86MYBmTPBNTxyV1fl/Q8r24txWWOFm7bR2oPxjAuU7RTP5EEJNyFU/n
         VZX/yNlYqOXWhhganZ2VWIRiZQyHSHOXMlJPgxK2K9sAV5obNsrDwB1agWgNAcdWYhpT
         MfRTZ4aJJGPmVSeiB/FTkheWVZ8wT/N1CfGH1Izd16t8DK4FFxAYk+2OIZSqoPD+9A42
         LZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW68cpZ6zpt3yo6HPQLchVNN2NINOmaq0JAdPNkRa616bziDQlmopW6xr+ehvnHyQjgJX9FGJuYZnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ZEJYVbR6N5WYP33EATU9OZC5yNxZAMwvxOkXs1KUnd0r7mjL
	8W9W7JwhlHCpxg8h87Tu5GVbMtWM0GTRM8Rnqxq1HfObYpVJmHBXM4KP7KaACbcd3bZZ9E61/ct
	EtcElpZc=
X-Gm-Gg: ASbGnct7orocezzVseZD7WUK1hutCtk/7luKrPrcoBU5nY3D5/pd7RtKnTyuRsfX4LW
	nlXFpsU/QMmIhsDKxZa0wfBFNg2/K+Y5TRAxa+/YITcR6GDoRJbOrQy5ogDGR2gvtY8mIL8P7sD
	J0aAbAYzYP7LgLSuHemX5l9YF8+LqFEsyix/v0/Fo2wOSG25NOQIAwr86r/0WF2jo7qfu9wy9b5
	0/0dRAKzw/TqgeF6pOyJdUfcO5QERltuiMLAWZrIuURS/AwLc8Mv2sLQeOt5mmLfyCaOfG9CCMm
	h62GPDcAK9thqhozbC6TbObmZgw9r95ksKeddx+nVo058XpG73fSoWSBPB3M+abYhgkmNAzMcie
	Cg6mQ/olSqyagZ/fYfRJOKlC+o4fg6EU01ourbzWqH4ATH/72OsGq586wNa0AIiZ2zYRAmAIv5v
	MarTqRomZvwyDfUROYnLKpSRAgS2h7+XprEB0=
X-Google-Smtp-Source: AGHT+IGnvuQXkfGwuAEx+Yb7NtSe2KQaKWhVmybTLT2ISlnYdo/gl3gHqlFXl6t/Wt6B4xnc3vLRCQ==
X-Received: by 2002:a05:6a00:988:b0:781:d163:ce41 with SMTP id d2e1a72fcca58-78c98d5cc70mr15969410b3a.11.1759829021537;
        Tue, 07 Oct 2025 02:23:41 -0700 (PDT)
Received: from kinako.work.home.arpa (p1522181-ipxg00c01sizuokaden.shizuoka.ocn.ne.jp. [122.26.198.181])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-78b01f99acesm15123273b3a.5.2025.10.07.02.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:23:40 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: linux-m68k@lists.linux-m68k.org,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [RFC PATCH 4/5] zorro: Add ids for Elbox Mediator 4000
Date: Tue,  7 Oct 2025 18:23:12 +0900
Message-ID: <20251007092313.755856-5-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007092313.755856-1-daniel@thingy.jp>
References: <20251007092313.755856-1-daniel@thingy.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the two ids for the Elbox Mediator 4000.
There are two because it presents as two boards:
- One that contains the control registers, PCI config + io space
- Another that contains a window that contains the PCI memory space

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 drivers/zorro/zorro.ids | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/zorro/zorro.ids b/drivers/zorro/zorro.ids
index 119abea8c6cb..fda1db905412 100644
--- a/drivers/zorro/zorro.ids
+++ b/drivers/zorro/zorro.ids
@@ -369,6 +369,8 @@
 	1900  FastATA 4000 [IDE Interface]
 	1d00  FastATA 4000 [IDE Interface]
 	1e00  FastATA ZIV [IDE Interface]
+	2100  Mediator 4000 (Control) [PCI bridge]
+	a100  Mediator 4000 (Window) [PCI bridge]
 0a00  Harms Professional
 	1000  030 Plus [Accelerator]
 	d000  3500 Professional [Accelerator and RAM Expansion]
-- 
2.51.0



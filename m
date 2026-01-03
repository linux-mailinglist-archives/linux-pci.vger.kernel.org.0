Return-Path: <linux-pci+bounces-43954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4020CCF0123
	for <lists+linux-pci@lfdr.de>; Sat, 03 Jan 2026 15:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F17C830249C1
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jan 2026 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646DC1DF74F;
	Sat,  3 Jan 2026 14:31:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2AB35975
	for <linux-pci@vger.kernel.org>; Sat,  3 Jan 2026 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767450696; cv=none; b=Au8yO/oETazYZ2TkZnEvGRMMuZlsOVSfZNSmVLA5sZzhG5DKMsUayZg/Q/sLEI4pUTnIpx+ba63t20CawiaRW+5JtfbLydzH7ZfbqryiFbi7fIJF64qXRxx/397R5s+nwgxawnE4VXHlhduRLZl5VjTMl3U7hrLXVtC7KZ5tyko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767450696; c=relaxed/simple;
	bh=OjJEHZbX9DUZYNV7p8GKg1sdBCh5/HJWJkWeJDu+dDM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tyWQRTaIwvpGc98k2nYjqwg5swUCRjgbEK4rRKbIi82rlRTAB/VHcaf9nHQtJMSzY0Jm1sgodl1hjmrAxI4pkbw0+vEXAGjEv7ytdhT1+FT4Py2WU7irhM66feBpbMOP3sgiWJYTmk80X3NYY38kP9XaWQ9cQcWuFketQSzJeSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info; spf=pass smtp.mailfrom=markoturk.info; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=markoturk.info
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64ba9a00b5aso15089440a12.2
        for <linux-pci@vger.kernel.org>; Sat, 03 Jan 2026 06:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767450693; x=1768055493;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+AYUNRl9rbLXc2HwT5sVlUQnauM+p95hRATJcoDG+eg=;
        b=RTdwyFxvB+0/ugOnPDVqRbF0WSKPbycolXP7598vOc9IrViBROJyLAwITQmQK58R2Q
         eHEr+9NPDT1u8YlYrWow4fYGEPaNvGgvg9xFvcAgALemZWOqy07f/44DJJf/XU5i/PJv
         uConuJq0dhXQHNO5aeXfHNsapMWLeSluksrffwgc+9f/AwQukw6s6Q8mnSTFNSmMrdsb
         RmJyPjkc3VS54IPEYzzhqAiwUveIa4gol8hPrgmBSZfLJkfmLPEhznee71qLwpei/0+d
         gx3oJERrNlhkFxs7lHoZLi100TeQouOCYBp5NTQqx/b/0fgtl2gfch396xbSq7BS47dq
         5zrQ==
X-Gm-Message-State: AOJu0Yxp2CT4KvXownMqZj42xRyzgkSLWxfVU7whByAG2mT7L3Ct+RQG
	BTeQXoEKC8h0SW+Q/vcvoJZt73Ja3iYSpRanjHWSrAFVUaDhX2A2HP3t3MT/PpGDH/M=
X-Gm-Gg: AY/fxX43wL5QzhhIdg6UUE+rLQwD14mniIUikFAv+Tvaf/f2caY/KdKLqbMkQ27kHFB
	+c+tujF0zg7UNl7kBjyy8W8YnPON2SMEKA9kjABXL4fn7mtEhYPpARZCWC2ckvnshnrOMSCCW7i
	PP3Kcxt7udMOUZGjIUlFCptaC+boTjbq4XazjEBevjO6Z9EcZg2sT5iUwlZ5cBjT3RhGT4Y4ZjU
	4niX6Ow4dZX12ZTu6Izq4WC4ETKUmv/SqHIjBnXRQkmbGafvdOyF7ukHkQNGMLzvBcVj5UAUnP5
	0+azKgYFhbl/G7O6iR5I72NUXy+GC5/PiAv5JY5bp9y6M1NYqw7IowxpH0xoZ5b88HZKvJTn9a4
	iQNWBex5TaZ6mgLfnNdpS8W9C3SaGTZaTCYWhWSf6AOUOTqrtcxSsB1p68muYLHQixKgTaiu8/m
	GWJG+SouuMyxYXSxFOZ7EnsA==
X-Google-Smtp-Source: AGHT+IEZpVXonSoNsNw9e1t4FvmQEeUM7GlEnGV5J/HtRKd9w8z0N4bgG9lfpaveMKQWaK8M1hT5WA==
X-Received: by 2002:a17:907:6094:b0:b73:9368:ad5e with SMTP id a640c23a62f3a-b8037051288mr4580991066b.34.1767450692708;
        Sat, 03 Jan 2026 06:31:32 -0800 (PST)
Received: from vps.markoturk.info ([109.60.4.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ad83dasm5130254766b.25.2026.01.03.06.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 06:31:32 -0800 (PST)
Date: Sat, 3 Jan 2026 15:31:30 +0100
From: Marko Turk <mt@markoturk.info>
To: dakr@kernel.org, dirk.behme@de.bosch.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	mt@markoturk.info
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, Marko Turk <mt@markoturk.info>
Subject: [PATCH 1/2] rust: io: fix Bar reference in Io struct's comment
Message-ID: <20260103143119.96095-1-mt@markoturk.info>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.0

Bar was moved to a separate pci::io module, update the reference to it.

Signed-off-by: Marko Turk <mt@markoturk.info>
---
 rust/kernel/io.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 98e8b84e68d1..08853f32dae6 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -87,7 +87,7 @@ pub fn maxsize(&self) -> usize {
 /// };
 /// use core::ops::Deref;
 ///
-/// // See also [`pci::Bar`] for a real example.
+/// // See also [`pci::io::Bar`] for a real example.
 /// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
-- 
2.51.0



Return-Path: <linux-pci+bounces-44054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9220CF5B0E
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 22:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8888030B3308
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 21:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024C0311597;
	Mon,  5 Jan 2026 21:37:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029CE30DEC7
	for <linux-pci@vger.kernel.org>; Mon,  5 Jan 2026 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767649069; cv=none; b=Bus0Qv5F6sZE/X8A5EPOY+aCgFayBmpPvTrjI/vfVjg4FImQLj73g/wiGzPsWZyXqbopsp/7vLVoNtOmgnhiokG9EttmwXYRQHcATXZLNVASULRnk9lS7grg1FaVSgib3+RoZ4rYzYcWbE4kSSlxdAxC81x+z/fwvAKfQsKjtXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767649069; c=relaxed/simple;
	bh=5p0sIy50n1r3V3HYFDfPF8gjbX8rGZsROgs5AwmRn+I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LhFIkuYrFThROinEJoFWR22xvrHnJoCy7hqzwKCQLE6MgCYgzMp7nDpXbaScuJXqfJsz5VJcesyVY0WTd9NzwzjRqSK5B4MVGlnPGih6plso0N56yrNg3ogy5Sdv3a9QFf9OF1AoWLn9zJEmILVzYA7y8+WuYu9kmYkOx8rIgmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info; spf=pass smtp.mailfrom=markoturk.info; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=markoturk.info
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7ce5d6627dso79864166b.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 13:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767649065; x=1768253865;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTD9LmkSSsC1Jd4T87qsHfQjMoBI0N5S+52DkRXb/UQ=;
        b=hhdOFqGfaB+phYoOWso7bQDMzrumcpr4imjpzOi5oW/hmEQgt5BiQjk+twuT8qmE8N
         I+yCaWD24ycKW79A8fjfxzJXxYPND8KINyoCqMGE9Qb/qanjFpEVgYr9q4fotsI/HQpf
         Ces/awG88g0/HJP5pgOA6WiuXOm/QXYxtUmVOow/E9KSt/w7yUcFH6dSpixsBMpYEvmb
         2c1pxXHCdvwge5wSEGjWj2D+EI7jvIHFfe+sWOjHt8kFxOv5DvytzO0FX+wr0jmH0Sin
         cpYeZcu0bemEDmremMzM20CNwu6DxAPWt1oKRX/NdIGoicepVY/91NVjYdOT2mH2lo5m
         /IDg==
X-Gm-Message-State: AOJu0YwJrArHt70NGXh5Vj2ZG2NOtJiyxx5GpwaEkbcA/8Qi/KjtZ3Hy
	1mxd9dwLVNShAx+f7k74yoW9aCBrlKzJAY+FjXvZYfdeFpBKJb86eXQWarDqPrz1ydZIwts0lmH
	YMO1Y
X-Gm-Gg: AY/fxX7EvcMjz9C67fwwKXgRlKtuEMhmtAEwa8kzp20W/FJM2yDZN457u2/NEbEo+Nd
	OfVAZgVguDzCl/c/NxqIz05jTqGKDkZVekd5w+xNACk4gGGhaVPR6ROW4Co8mNdHmeG8lq4lGCz
	phyL+dt6f07elXqC0ND7McOGTNjljAvUeYB5C1VKg40ci0hMzxH2zbo+5H7qcIPyOw4V9JEkALt
	LZApwjxqXjx9RqsD48yZ4WbIFIDPH9mojE6Ar9w9Bet/tLPwj2c6iwxUyefWYYLK7sBBRYrRSkv
	ViMfLitM++k6abuYsuFP/cBSGGeErL0Hn5teMzgG15VMjK76u84jOwa9UCedXwLWVey6t/kgRiP
	csyRGtNODyuTVdMQMgTr1Q+7kGDAznIPpZBhjToHIyKwBkelWAzESNixanua61pood6Qi3FkLrt
	nhho73DK12AjRlPHJQkl6VIQ==
X-Google-Smtp-Source: AGHT+IHnjMXaedyKs5tXcCQlJHrztbXwb0K0kypHqcfqy0iQzQ81Ohfv+2XU9rwJA6GN7fm0XXCGUQ==
X-Received: by 2002:a17:907:724e:b0:b76:7f64:77a5 with SMTP id a640c23a62f3a-b8426a6869dmr125033466b.20.1767649064977;
        Mon, 05 Jan 2026 13:37:44 -0800 (PST)
Received: from vps.markoturk.info ([109.60.4.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a230db0sm35636866b.2.2026.01.05.13.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:37:44 -0800 (PST)
Date: Mon, 5 Jan 2026 22:37:42 +0100
From: Marko Turk <mt@markoturk.info>
To: dakr@kernel.org, dirk.behme@de.bosch.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	mt@markoturk.info
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, Marko Turk <mt@markoturk.info>
Subject: [PATCH v2 1/2] rust: io: remove square brackets from pci::Bar
 reference
Message-ID: <20260105213726.73000-1-mt@markoturk.info>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.0

Remove square brackets since this section is not a part of doc-comment
so the reference will not be converted to a link in the generated docs.

Fixes: ce30d94e6855 ("rust: add `io::{Io, IoRaw}` base types")
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Marko Turk <mt@markoturk.info>
---
Changes since v1:
 - pci::Bar is re-exported so no need to change this to pci::io::Bar
 - instead removed the square brackets as suggested by Danilo

Link to v1: https://lore.kernel.org/lkml/20260103143119.96095-1-mt@markoturk.info/

 rust/kernel/io.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 98e8b84e68d1..a97eb44a9a87 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -87,7 +87,7 @@ pub fn maxsize(&self) -> usize {
 /// };
 /// use core::ops::Deref;
 ///
-/// // See also [`pci::Bar`] for a real example.
+/// // See also `pci::Bar` for a real example.
 /// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
-- 
2.51.0



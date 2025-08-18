Return-Path: <linux-pci+bounces-34162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7B9B29712
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 04:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F5C201C0E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 02:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19B6246BC6;
	Mon, 18 Aug 2025 02:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wflwj3zW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C925392A
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 02:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755484335; cv=none; b=tuQnOqVSPQpF+gkoWFdGQ480sgEzvuunizWxXFsI+WTHDJ2pzncRWhpiPGvto4dPoBZpXqjDRMKaOsbicHZojKK1xbvGOK7gUSTP/f6tDFes64PgE37ikSAt+Ipe6sWyYNv2VqGzhgeaMzZk+FFpg63f4iLeJwMDXcPToJBZkHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755484335; c=relaxed/simple;
	bh=KxsWPiE4A9EKKiVKLLnhyfUqEqnG6HN8RlVxs6EVaFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3uytXLyp+LO3hsLlNMAYXf7K2AoA26BQTOhr1IbDxScKkU+ck7KV5dTiqtkzkU+/dXlHpXWYqHeicoo+VSgJhI9Iha0kxDLhU+N9GTc1oe+uHQFSfGbA+IwnaDFKKdWzR27+1/VM1GNEGOatH2MsUXoObpONdcC0ZUUJwohbJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wflwj3zW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b0b42d5so24445795e9.2
        for <linux-pci@vger.kernel.org>; Sun, 17 Aug 2025 19:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755484332; x=1756089132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j9/GXTnQWluh20kRW0SelAKcbnkoiHYkMpsSrIAn/78=;
        b=Wflwj3zWi425Rh8wJ6XQ9OVhu5khgPxYThmoLKfChVDjEDEzf0Tl+QXL77p/6QcMzf
         2pD85FL/jvDaetnqRHSOqmvgNKf6YCWaAyFhL7hIa29fvyK4TOXzt+ds9Nq3wGeS/Jm6
         hpSuepQIuwdoRhVkzoq783rhatzIMNti+yPHWxEY31Ye8CUx/8jp/tHTRPLDp6HfZLSp
         Gqw6dfaVEK/xI08brBjSQsAjVgCIQuG10ndtWet6zgtUQgy+60H8CjRsDbocvrDlVIgN
         SJIjPsMfymIGAWitbz7yrZ6NhDXuV44bOPKbFTRP9lk+C6FZ2PgAlMnrVECo5Y5cXgfb
         liFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755484332; x=1756089132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9/GXTnQWluh20kRW0SelAKcbnkoiHYkMpsSrIAn/78=;
        b=TJwDdi59OAajKum1W1tpRkG3xn/zi2zWQ1xUksjLHXaze4zw813LzzkEC526MZnCce
         AiQ9Am1RqlNIE/qP4kBCIwCKZ0J5P0/LHvAg5J7z9bjgWUA+bFrXEb5kIUf/JLroa9cR
         zFLq0/8C2uVJ7LKioX0BupEjTfCcbOSTijpG8Hk7CD5znOCJkZMYEDi1orI6L25Zhkto
         /J4HIA5kEh6E3WIeOUIXmPVdBTjyKrK/81kaLoum4gDJctV2nDTnwvDwkL1DHa06f+jK
         6Cy6qQgiAruT6kJd5VKYbLWN3k2JgxRE/xB4ZoPzATZAX471aJadUnWUQfZx/b25c8HP
         +IEA==
X-Gm-Message-State: AOJu0YxMcWmC3eoElvIK0PvB5fIE/KAfuHnCXugV8gyQUK82Pr6vn8Lq
	L6kg8zPkfjTn8gytWVTZh9BlhULvdgu8emSTqtWLSpwEhcA5SVuZu3F7//0IO53k
X-Gm-Gg: ASbGnctEOoXJsbGAgN1w5RTmYGmkDswqcU5WKoZqhtxL3mLKGa7L6cyhgK9vjCwx2fX
	9dbBcQMQJ9eRImyqBf6TfSTetVyai4i21KLI9A0A7d3iv+yrRDbNAEw1lhX/jvSHebm1qACJZ6j
	c2L/VgXqeDpHKobs8ar9/v4/ET4r9P76CB8lexBmRjSxoFk0cNQ33wRrJURv7R8c81fM8HxBuaT
	9dz03Zui9nhfixNV+3ouiDz5UoEigiuuPCcSjw1mWptSJPjvWNRXTp+QtJXiAy/TM1HS2JRd3p6
	ZGgZ8JsE+Z7Z+uCXnhbUkl8BzuhR8S6C1uZSMpEbsYf0keW4NB00vQRtPpj8l36GLaa76tGP/Eh
	GJTvLjGhDqB5qSS61r3LckQ==
X-Google-Smtp-Source: AGHT+IFUcC+980UfecVr8z3TgORZJbRklmTv6v0jQ00Xkj2vuw4sEMwU9hvuaDZd+IuFDaIx/7CxJA==
X-Received: by 2002:a05:600c:4746:b0:459:dfde:3329 with SMTP id 5b1f17b1804b1-45a2186db62mr83586215e9.31.1755484332202;
        Sun, 17 Aug 2025 19:32:12 -0700 (PDT)
Received: from vivobook-s-14 ([5.224.242.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a223197fbsm115694905e9.8.2025.08.17.19.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 19:32:11 -0700 (PDT)
From: Emilio Perez <emiliopeju@gmail.com>
To: bhelgaas@google.com,
	corbet@lwn.net
Cc: linux-pci@vger.kernel.org,
	skhan@linuxfoundation.org,
	Emilio Perez <emiliopeju@gmail.com>
Subject: [PATCH] Documentation: pci: Use term requester ID as per standard
Date: Mon, 18 Aug 2025 03:31:21 +0100
Message-ID: <20250818023121.33427-1-emiliopeju@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe standard never use the term requestor ID and therefore it might
lead to confusion.

Signed-off-by: Emilio Perez <emiliopeju@gmail.com>
---
 Documentation/PCI/pcieaer-howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index 4b71e2f43ca7..7b30598b4fde 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -138,7 +138,7 @@ error message to the Root Port above it when it captures
 an error. The Root Port, upon receiving an error reporting message,
 internally processes and logs the error message in its AER
 Capability structure. Error information being logged includes storing
-the error reporting agent's requestor ID into the Error Source
+the error reporting agent's requester ID into the Error Source
 Identification Registers and setting the error bits of the Root Error
 Status Register accordingly. If AER error reporting is enabled in the Root
 Error Command Register, the Root Port generates an interrupt when an
-- 
2.50.1



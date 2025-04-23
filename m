Return-Path: <linux-pci+bounces-26563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE0AA9953B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED1F1B8551B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 16:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB57284B48;
	Wed, 23 Apr 2025 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj12Rar+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E44C284B37;
	Wed, 23 Apr 2025 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425815; cv=none; b=Xiak7zMcVbKpxODmrJxpsBradAspdnc+hzTnPCRTPOQeAYb/Df6aJPYyJ3RqkCaHD56HT82C5AaGDpavZUOECvn4b1eTZvU2QPAbEo8f7oWIb41gy1uNGjv3bsL10s93GXDhYOHYC0um+JrjLQeWdEqRH3qzSSBy5USV15JObJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425815; c=relaxed/simple;
	bh=FgZCSJ5ewBUdDy1Nd+fU7Ri7WIQKor8Y/V4Wo6+vvVY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nCU+tOh+1ta/DuRR4gLzho/07hhuSC/MEGXYQnJ0Us+hhhvQL61cjw5kaHUcs9chuRSkgAzIH2uNzi6XDqMs/4jA7b4qLjLCQP24ditqCLk3nUYr22e3pTTqTh13/hLT4gQrF/zdtZeyj86oQ5q+w8xbfWQa3fWcJQbcnRZMxIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lj12Rar+; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c0e135e953so782585a.2;
        Wed, 23 Apr 2025 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745425813; x=1746030613; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp2vEdLaNIrN+wdIhSJgZH5g+N68G4ZL9WCWKSgxPDo=;
        b=Lj12Rar+u+Sh9R5jZns/rkLmMdzkWkBiOYVtbcV5uTEEoTvT6mKnUzxhYLXUPKJylv
         SyJUlJFoIshLfKlIU07Y2k3tBFYeJnSMS90BvExeIobXUqCwzOqKT1u/fy+VMt7iFCqf
         U/CGN1fnivXv7/U9tzT0jVtMZKX5pyUkS7rkCKaV3dpuWp8T+srT0LBoCHFKtaADRkI3
         aq+lqJYzY77rwbfyS7qxrarnjKfzHcrB3QCQZBEV3eCT0cWUWjm0NsopzoDjk3cgx5ZT
         /iylGn8eqF2LUKrdCQMckB4Xozsc23UgfAR818oxmGEDP/fYPsH9VfNAwj8du9cyPS4h
         7I7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745425813; x=1746030613;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kp2vEdLaNIrN+wdIhSJgZH5g+N68G4ZL9WCWKSgxPDo=;
        b=MnNBP/TLdPx3epSNypYGiIZgqM+vZFNYQqXfFVUJSeKL6RbNEZIaFG2+uMW+cHh99n
         UigpnXCatfe+HOgIUSlDvDGzciubDuO95EYDkQx/YNAHZRGo26xl0Y0Wx+ef0k5glNdp
         jCj3zL/Z30zBgnvmqs49iyOM+PaDFyJ3hCYKTWqHKpt7NH8cUvSIl3oZPSnPmqJWq9Wz
         WE7LEpYw1/0gDzSdIIMgwKyQpKjbacdVe/BUVvkw58QLm56HApU2ML4SRjDy8XaGZ8q8
         2tObRmJhdeiDNlbMZomUHI8lCSgLGZYMQJG/87DrYFc7dr6uzxavB8bqtnlbcfJ7H7xD
         1DmA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Ls8GDty//J2tk88RA26kzUq52UIuDSGGQEfdSeP2mrLGFIWFpP1lXwUa208+/e+P00pzZur9B8kQUa4=@vger.kernel.org, AJvYcCVf9NCvDkmC7H6Dsq2d4lVKgAHSWceEZcNzOu8edWV2Xx9HiC6zd2gLDoJ0/Z/huUqNsS9qnmgAdohX@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkrdv6yCYMk7aOP4uqM9G7I0CC0acrVfrTR4mTdT/imgemLmOL
	/z2n5N9O2lL+BMRlgXgjUhX0XqNxs7NkrOAbjDCRkfdxzFfALTn7
X-Gm-Gg: ASbGnct4t8lIsAdfZVZJiuC5m3+SnvVtY2EDym7BnmJMTuCR3ZCeYxO5lAr2pvHF3Hp
	STV0xyVe7haCOkqOb7OhK+abFRTY9pNGSI4lG13c4EFgoTTjJGjTCwIlYQgTGoqTIJPtsDDBbmj
	LLTrdf3Qjhfsfk063dfpyHLb/iCnuG8ocSaHwiuuvXFFx0NvYldrzRk+tyhBYMAjUARGYIutKsS
	QQwDRZiFVkew1JBo04HC3KE4qlcTKQKU0geZUremsZB7725homMd5jtisprpc1auuJZbsqb44NC
	bMl3U6XoyDmMHZAuHdme5r1g6xmba9lHiCQnwZko5OyhQU776W2k7qBmdDCEORis0r5SCI2ngOC
	qj+DVDfufvcXyMgseY49dZDNZXWpLMqxyLmq0+W+LDWb1TQXLFw==
X-Google-Smtp-Source: AGHT+IFLtOi2dXMspWx/iFc5sgimZpNKtd4BJR3e5j7+G2gmu2lcCedFCIvOeKgEBcJQpYs4CMNCDA==
X-Received: by 2002:a05:620a:19a5:b0:7c5:af73:4f72 with SMTP id af79cd13be357-7c955e7c7e2mr23232785a.42.1745425812725;
        Wed, 23 Apr 2025 09:30:12 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:e2b6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b4dac4sm698031885a.86.2025.04.23.09.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 09:30:12 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v3 0/6] rust: list: remove HasListLinks::OFFSET
Date: Wed, 23 Apr 2025 12:30:01 -0400
Message-Id: <20250423-list-no-offset-v3-0-9d0c2b89340e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIoVCWgC/3WQzW7DIBCEX8XiXCr+TMCnvkeVwwJLghRDCo7VK
 vK7lyRSG6nqcXb3G83slTSsCRuZhiupuKaWSu5CvgzEHyEfkKbQNRFMjEwKRU+pLTQXWmJsuFC
 rMerROwF2JB06V4zp8274vu/62M9L/br7r/w2/ddq5ZRRiEG4XfRKCXg7zJBOr77M5Ga1il9cM
 fsHFx1nDtwOpbcxmGd8e0Sr+HHpFZdHPuKgIe37OS3TwCCKqB1yp4Th0oxOc+Od0RCs0hgwMGP
 BG/L8mmn4ieNLXiBlrD0QnS9Lxtao46MM4JQ0Jky9/37bvgEkmK6VcwEAAA==
X-Change-ID: 20250324-list-no-offset-96ef65cb2a95
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

The bulk of this change occurs in the last commit, please its commit
messages for details.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v3:
- Add a patch to improve macro hygiene.
- Add a patch to include examples for all macros.
- Make it build properly!
- Link to v2: https://lore.kernel.org/r/20250409-list-no-offset-v2-0-0bab7e3c9fd8@gmail.com

Changes in v2:
- Change type parameter delimiter to `{}` for consistency. (Boqun Feng)
- Rebase on v6.15-rc1.
- Extract first commit to its own series as it is shared with other
  series.
- Link to v1: https://lore.kernel.org/r/20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com

---
Tamir Duberstein (6):
      rust: list: simplify macro capture
      rust: list: use consistent type parameter style
      rust: list: use consistent self parameter name
      rust: list: use fully qualified path
      rust: list: add `impl_list_item!` examples
      rust: list: remove OFFSET constants

 rust/kernel/list.rs                    |  18 ++-
 rust/kernel/list/impl_list_item_mod.rs | 233 ++++++++++++++++++++++-----------
 2 files changed, 165 insertions(+), 86 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250324-list-no-offset-96ef65cb2a95
prerequisite-change-id: 20250409-container-of-mutness-b153dab4388d:v1
prerequisite-patch-id: 53d5889db599267f87642bb0ae3063c29bc24863

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>



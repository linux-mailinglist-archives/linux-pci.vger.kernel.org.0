Return-Path: <linux-pci+bounces-25576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC00A8292F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 17:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F5D17235B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 14:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D67269894;
	Wed,  9 Apr 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GglbDtyb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D25266EF8;
	Wed,  9 Apr 2025 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210286; cv=none; b=oYUD1WQFXvsCaHoi8+04amRfk3/KzQFbMsWz7ZRRMveoE4yzyMeZhVXqqWR5+9eXgAhgV27qRRfaNHzWJOxP4pnEIJAA2h/5TkbcJnbOJTTOiAToL5XHyr8+L/95NJWtEdcYFJROSnF+DJ3qGbbI4ezJ1rO+qEL1ETCQdspnMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210286; c=relaxed/simple;
	bh=6ZNRTbRDkv0mz1ZutTn9+djhbORiCLYU4JDZTOzIs2Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cnICDE4JqauF/AyRqvHKh7XAnQCAVaZUU9xDO2T+hff6DdMCPEUAunzgEONQFYAbE7bw9bNplJEEbR5taySnfXGur23Eget4SQTAExvw8uySq7fH67GzxSknF+K0t0GHMMQ+F4BAY0VhnHpZYo04NkfBRs+fizHOon9YF8/Q1Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GglbDtyb; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8f43c1fa0so81969676d6.3;
        Wed, 09 Apr 2025 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744210284; x=1744815084; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HAzhb4wVbbjDuTOHS5YilxLef1hgz+nzXa5NJUtVfng=;
        b=GglbDtybfJhEJXyNhNw6A21ERQcZmXRAx6XJbTcsv2usG+dJhvAkw2Pah+3VTfTvCA
         xqwJ1ElSf6vFgAxvnbsgSbRkWmu5As8c9SQ3/RsqfC5NhbZ5WKBJf3r4WPrPGCAP0g6x
         1PZvVKjbJf5z+/HCZreoHZ7NOYtz4o3gLHOMhh1OxqhjhqyViLhW8FupXgIKvxOjYBc5
         KSkYxXa+8s3aE7AswPtVwbjY1dc15nZ8mg1U0juaoqGWW/ItHZuouYtdd0kSjjNK61Mh
         Z6V+6vHkRBMbfUMbosPKYi1x6KSomzjWP59HL8EqSDklpeepMgKzlPhI2CQNEDiATbwP
         k9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210284; x=1744815084;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAzhb4wVbbjDuTOHS5YilxLef1hgz+nzXa5NJUtVfng=;
        b=f1h9aGzfGIKoRux0fgaSTa4I2u3jzzg5MVyjwybHtpmIlRE4iRuawvdsIZJtR7uVor
         Hxzl9YVxrmAV8H1RFvkeZrHgRWj8l7x/2ymG/4D6JWyUZSnJneAg2mn2d4291fOXz0X/
         qJMZ7YAKF0z70Ne1ZEPRca+Z2g6jEQIxD8CZTvoOiN2Gv8LTb3Iv2lniktcGssUPlvv8
         bUjArjEjxpFvuzetLkwJyIQSBg2WZWtA2y83FUg+uPliD3rvSQThqURR/cEm/dRGorP/
         MRQqSP3qbxGbsd1j5GX03FtzKRzBAnoVR89YWqxHBo7nXAIX5iUH8uV3AY2NoLz+As5T
         65mg==
X-Forwarded-Encrypted: i=1; AJvYcCU/9yiQak6MklIVhqrlyGtNzMX5IWPrK4VIy1IfSP44octOBxggC5zQSTH0svSvKhUlpsO+9azuIG7yyaY=@vger.kernel.org, AJvYcCUj7L8WZejmiAOx2Zoweb9BgeaVrnpP+hufwZccTtu3X4DkwAFjqUQGrhAv44airs8AzFwHQfQpuORQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzQWY47If/XghRPpY9Vfyt6U00CmegCkenTJ9YqwkYsOAN9/TNG
	LtSOWTa9N2bNb663juJvodD0bOw/86BBJBPg4cH4GtCPfnJ0Vub0
X-Gm-Gg: ASbGncszuZ0GnNgU9zSsPvWxe342QEurljD8VBv0BTUni38XqPRJft9U55a/Lm4NErg
	B2d7wkXedgXGDapuHMnYiWRQaZmFhDRqBnIaIEZOi5EfPPXQCLz+GHkEQra/JyRTvI80O40+oKF
	WQ8KMm2ZF/9A8yA0g062roCj+4obfyOGWhahvTI7ZAeAc9nD0jRFDLpnwbJqPsE4E/f9DZ6zOCj
	XPMMFa/b2F6jUuMG0lWjkK6QO/8YNj+gNqAjrU5yU4yaPT6PmMHRfUHVXqgy66ZLGPujS/w5Nmv
	US4QZOVYtu/vuiTl0j0QImCpL2nc3DJKMH1S9zckcQ1QzcCwnTkE0BoElxNS/gfma3quQXeYfl0
	44EidkwzEfm0h5xjoyYTJXiU48S7UPuifRNxxGUU5TdsK
X-Google-Smtp-Source: AGHT+IEI+1r0BjFWD5KnBSWcO5feK0qnKlr7YAv2o0J1Sh4vSh1h6CmGIIsSKC8ij4Sx8U9bnfiM3Q==
X-Received: by 2002:a05:6214:19e1:b0:6ed:19d1:212f with SMTP id 6a1803df08f44-6f0dd025089mr39184886d6.5.1744210283608;
        Wed, 09 Apr 2025 07:51:23 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:3298])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de95fa89sm8229876d6.6.2025.04.09.07.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:51:23 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 0/4] rust: list: remove HasListLinks::OFFSET
Date: Wed, 09 Apr 2025 10:51:17 -0400
Message-Id: <20250409-list-no-offset-v2-0-0bab7e3c9fd8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGWJ9mcC/3WPwW7DIBBEf8XiXCrAmGKf+h+VDwssCVIMLRCrV
 eR/7ya59NLj7M6+nbmxhjVhY8twYxX31FLJJNTLwPwZ8gl5CqSZEmoSo9L8klrnufASY8POZ4P
 RTN4pmCdGR58VY/p+AD9W0meyl/rz4O/yPv0XtUsuOMSg3Fv0Wit4P22QLq++bGw9nuyKX1fK2
 J8PmIOGnPZb6ssgIKpoHEqnlZWjnZyR1jtrIMzaYMAg7Azesr/dqOo9jhYzcXKHlLFSIL5de8b
 WuJPTGMDp0dqwUIH1OH4B6T0MDjQBAAA=
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
messages for details. The first commit exists in 2 other series but was
picked into this series to allow using `container_of!` without the need
to cast from `*const Self` to `*mut Self`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Change type parameter delimiter to `{}` for consistency. (Boqun Feng)
- Rebase on v6.15-rc1.
- Extract first commit to its own series as it is shared with other
  series.
- Link to v1: https://lore.kernel.org/r/20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com

---
Tamir Duberstein (4):
      rust: list: simplify macro capture
      rust: list: use consistent type parameter style
      rust: list: use consistent self parameter name
      rust: list: remove OFFSET constants

 rust/kernel/list.rs                    |  18 +++--
 rust/kernel/list/impl_list_item_mod.rs | 128 +++++++++++++++------------------
 2 files changed, 67 insertions(+), 79 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250324-list-no-offset-96ef65cb2a95
prerequisite-change-id: 20250409-container-of-mutness-b153dab4388d:v1
prerequisite-patch-id: 53d5889db599267f87642bb0ae3063c29bc24863

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>



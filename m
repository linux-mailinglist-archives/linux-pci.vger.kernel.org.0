Return-Path: <linux-pci+bounces-23154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7580BA5743C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 22:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF787A45A1
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 21:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33AF20C468;
	Fri,  7 Mar 2025 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBN6FBZ0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE531E1DFA;
	Fri,  7 Mar 2025 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384734; cv=none; b=FGD6/mS2AU4i/m7eTWoqlcgoI9v7qZ86+MlGP8g8lxwmE3l4fkJIwMkinrQhsYwAVI1x35ETYUPSWewf/txY0tJ536NGB/hTiVGnfXfLQYWrFL04yUCvGDYJiM23vUQVKi8gxl4+Kofrxke6+QMwt/IjVb0WO+q1pY8nF06vJBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384734; c=relaxed/simple;
	bh=aP5nXoeorQ8Nv6BPtWzMXWFPzKF4s2+zRVsJkqyGpwM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VcN9nAj/3MpENW/3Z8QceDk2gkY5P0/f5SkqrKP40EimbluyBF2eb1Hr2vOr+lrI8qfDxVQ3hzoIem/lJAz86RjtX46jirtAcAJMhGm3rg/nQz28SpXYgeZTyGcPQxgdst3PwRIp2UC6yYjYgbc1vtqVViK7S+9q+JDZhCE4zpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBN6FBZ0; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c081915cf3so318122485a.1;
        Fri, 07 Mar 2025 13:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741384732; x=1741989532; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPFGRXFUvlqK7z+xIWz9JClPgsyrMeYx/WWyJxGLAyM=;
        b=UBN6FBZ0k6V9xGYVs9K4BKZJko0PYpHGhUmFuaCpCdoG3jG9QY+DtW4kEgefOAnicA
         5VuDggQPU2rCJb9OBWpULrduZNErifEjpe7c56QraK35/9liT+wdW9M1HvY4JPhcp1hn
         cLYvOs2sDoFTfPwOgXx0/+90ZQ7Oa9AU1cXqocq7BvV2ZKbIiyti09AbbVTBhkqBZWGp
         ZyoQN7C07AIQvHwW7pj4BjQOrfLkccyeV//zdANN5xXH5z/gcubLq4Sj4A7eoMPdcKfi
         NaGsD1jqNUl7G34BggwJ9YTkh2JmvqUiP1bVRuaFdmyNGP2VDEAwwu5XL3Zua3kKqiNn
         akAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741384732; x=1741989532;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPFGRXFUvlqK7z+xIWz9JClPgsyrMeYx/WWyJxGLAyM=;
        b=AgZAETz735R4Oh+qBux5e91eoenqhZSXogyI9FZGaa5Nl/P6K5bIkpuPJHpJg8rPv1
         /jePr4gbEZXktCWzgAGAY/m4HQ6pG3IjtIM2mZt/FOGUJ215BlWaahKYAnXQJCGMNs7u
         e0NLV+wTXOHJZ+BOomXvIf92Rbo57IUc2+mhP2XG68JWdfi+D6V9cOJuplErsTu7z5ZD
         fz2yCCspxpaLokXkuuS1HjPQyXQnTtA3c+z5aY4JEqRYD2UpukJCbUSWsnPtDE4qy3yV
         a26v5oplDODpAbCQB3Vz9E/BuoECTlprB3o4uRpa5NpVMIynCzZzi3NY0yNix/n2yvRk
         jL2A==
X-Forwarded-Encrypted: i=1; AJvYcCVMC20KZ3gTf2YvoZVjrLHz+9ytv70aqC61xviJNMra5tNehVAXytWCU+ykttph7Lm3Io4bq6h5B6uX@vger.kernel.org, AJvYcCXjIMEbreM17/jv4o22H9A9ey7PucJf7q48fjDzUE7hGdmbQogLnUr8fXkE1gQshRsp98hLlGTcVtMFWFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD1rQnNtShSjuCYdecUKKh/ydz3/Im44CBaZS0qQMooNRs9WsY
	YeSW4kTQdUMRNM0LtFcfBB5+Vv3whmhRR9hCGPFXk/BIGCI+NkoI
X-Gm-Gg: ASbGncsWrjGkC6c/Fjs4bdKmnOARHlSSWXmndswPVTWRrwKd8fW0qFgAelDTail1upz
	GUBkey3AnJJ1YyCZp3qAX+FWylSWHt7Oi9Mg5JWzMGLX6hfb7UUI3nPOQxvstgDbO4HMuafrPfD
	o9xCqjLzkLmhccAoKblfYESDKKnp0gmfDzmDWMKNxD4SMBBEcMscUnWmm6fTSKQ8H2E16bJUqCg
	x0qZOIRjsFGdALnvouQmiLZjvRw9dSGJsCK4o9xqbSh7ifdQPFDRPH74bmHwX0jsroDRtIQlCL3
	O8lcrCZDIGuMxX16GUUaC448A60l+UcrYDT7LyQYYbhacHpBW5fgtQ4qO3J6DDuDmoYFN35icEq
	EBOqQ4A==
X-Google-Smtp-Source: AGHT+IEOU047Dule9EI13lxLgI83FA0wmA1xGAKJrU8BOHI+kVlJOXOMMNeA1I6OB0EYIPak3QoT/g==
X-Received: by 2002:a05:620a:261f:b0:7c0:b018:593d with SMTP id af79cd13be357-7c4e61cec29mr700531785a.39.1741384732044;
        Fri, 07 Mar 2025 13:58:52 -0800 (PST)
Received: from 1.0.0.127.in-addr.arpa ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a481sm293735085a.13.2025.03.07.13.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 13:58:51 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH 0/2] rust: workqueue: remove HasWork::OFFSET
Date: Fri, 07 Mar 2025 16:58:47 -0500
Message-Id: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABdsy2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwNz3bx83fy0tOLUEt1UEzNjMzPzRHOjtCQloPqCotS0zAqwWdGxtbU
 AircuVVsAAAA=
X-Change-ID: 20250307-no-offset-e463667a72fb
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

The bulk of this change occurs in the latter commit, please see its
message for details. The first commit was developed in another series
not yet shared with the list but was picked into this series to allow
`HasWork::work_container_of` to return `container_of!` without the need
to cast from `*const Self` to `*mut Self`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Tamir Duberstein (2):
      rust: retain pointer mut-ness in `container_of!`
      rust: workqueue: remove HasWork::OFFSET

 rust/kernel/lib.rs       |  5 ++---
 rust/kernel/pci.rs       |  2 +-
 rust/kernel/platform.rs  |  2 +-
 rust/kernel/rbtree.rs    | 23 ++++++++++-------------
 rust/kernel/workqueue.rs | 45 ++++++++++++---------------------------------
 5 files changed, 26 insertions(+), 51 deletions(-)
---
base-commit: ff64846bee0e7e3e7bc9363ebad3bab42dd27e24
change-id: 20250307-no-offset-e463667a72fb

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>



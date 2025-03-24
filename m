Return-Path: <linux-pci+bounces-24578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237C1A6E5BB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 22:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3673D170A5B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 21:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E41DB128;
	Mon, 24 Mar 2025 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjlCj8kT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EF315E96;
	Mon, 24 Mar 2025 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852041; cv=none; b=HDZADnOBrZj1mthST1/XiWC2UUQNB9JVYVW59ubbUZA8DdGG2Ifei4TXWkcIKq8AtSXb5oy8jn8vLtVTzXuB/yNuS6jjNtwEVuNEw3nSJoA7C2ggDSNJvAnpXjFqTZhzQaSu+6o8WJZ2/I7YNyWt18wMupBx/P2PosFTfJ2BuSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852041; c=relaxed/simple;
	bh=yj29XxXDijy6110W5Qn+nQ++u5/2IdJ6YUbzNqw9a14=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Cs78fl1KImPo3EB5n88yR8zoJJUdATS6LiqkdGE3vAMU84Es9x8gS23mJ27irhhiPx2VyOSBjBAy6JutW5t/aIOu1HKldXQ+ux1ePTdNki/GUYsrIeR++wgIlZ68mFfCTU1Z1fQNOdvrscNt9lXiNt38ZlU6IWTLA3pDL9lVRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjlCj8kT; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c3c4ff7d31so611618485a.1;
        Mon, 24 Mar 2025 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742852036; x=1743456836; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=834hiSajVAxpAwnwfhaB+tqjUdT7ypFb+TjM58nDriM=;
        b=NjlCj8kTUfzVsuBfWL4Xv3fKpPW4yDWvo/zBu/4/+sHfxk6KboTBretr95Tzw2NdcW
         keFb1QOo2do/TC2I7UaNwBOj6z0OsvtNlh7yj/Jq7NXtAoVmJGsvWTnVQGEm8W5YACiz
         P5d6AV1sPrylQ9IWpfgPvUx4y9CAdvPsmTAzZDyqjKyYnZzz/Rgm+/Jloc1XXsPNnEcL
         OH7jjyw2wE3dLpY9NiJhfrA4HxYz4r+/7aDF9xLLDSrONg9Ug4u8nbHMN2TqJ7gsG6Q6
         1eQQFB8H4qn7FuHe58Zo2u7meZGeLDoFIcnz/xIRQ2on0OxeRcoqm1apbPMPbBf9NyLt
         oQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742852036; x=1743456836;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=834hiSajVAxpAwnwfhaB+tqjUdT7ypFb+TjM58nDriM=;
        b=P7BZfpLRI04elyl+neUPAnuW3uDuvNu74YORzYkvlw4FWlkRB9fSd9tZDJ4iayhNeO
         Z5vDvACzrxceR5ncbOEXH+Cwkr4Cn+eAjElTvukR5j/OBc/3Im/MviqdcPmslnl2JgrE
         HB+5vao91caXKU8QxKyjOXF0/pot2gTwaU8hiFALfwO6f31ACoOtejoYPpN5ZXnF1wII
         nZePfLoWKuUWNwGr+87N/x9KtfW5jfpWVbjl0zuaP5SCUBwDRpE7DlRmeTd+BvJ8z0Ut
         yDcBq68aAipwQ4w2Im7C9PsdtljXEt4BCuLiZhDmwNvURsjlK00s1jiP8Or0r6vAeTdC
         LUfA==
X-Forwarded-Encrypted: i=1; AJvYcCUT60KacA3yY6C3WNd/aqzKAAqwBVqWhlVYtn4EBfQNjuheofzC2BJhcvPjw01kBpi2yg1f3o1F/FLW@vger.kernel.org, AJvYcCVHKN9NjGhEmwafsUH4po02UE9dRYAO/+MPPpDACoVqUoKlIK0PFcuWgUVPEuQqT6N1qp+cnOkRbQXsfxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7oarvT2AqfDstB04VExXTf28mB6kqURqW8QysZf4d9Ie5/WWg
	46U58xg36dc/ZD3OYvGX0cjHz+pHzNXD5yTZ7VCS1ovOhikKVUe4
X-Gm-Gg: ASbGnctL1FkYvTQJdC2DzO2lfUf/sbidC+pfI72hNyE9FHqfL2eXKBIf1gOvJ+YNhmm
	C2SoW3vgQPSyrudIcEd/1W2UHTHYFm4kPmf4/Nlt+BlM2Tos+eHHvUPAmiBWub6ffziPEDsGSwx
	YE90WR1bUy4MgbUxigEiDpBc2USDNOJpRPYeOuB41bbP10L47sXzbeJsUeDy3SK5c8YZwAI8nyA
	wvaXeBjvoy//M9F2n4/WHKDg84aMomLIVjrMli+3C3kamPnowfpxnwvrFL7qvj8ez1ZFv/Vxbhr
	0ruKP7gtEyzw4f2THLzjEDiMK0v0L0iEIT/qsbAnXZGVmwzoWUtnN58EBeZUbCJdKXPjmnrAW3H
	yP0mpVU23UCRS6w5WTBRCFE0XBMLM2uWvKF3ewK2kHEI0rzGIzndGMQ==
X-Google-Smtp-Source: AGHT+IFjk+x/dtk5BqihRe8E5S77EDc9lk2a+QfbsXPjiFFYwfARaTe/NB9jnfhThMb3t0ViuBcEpQ==
X-Received: by 2002:a05:620a:269a:b0:7c5:3c0a:ab78 with SMTP id af79cd13be357-7c5ba14428dmr1679197785a.14.1742852035957;
        Mon, 24 Mar 2025 14:33:55 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:43c7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5d7eb96fesm63232185a.90.2025.03.24.14.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 14:33:55 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH 0/5] rust: list: remove HasListLinks::OFFSET
Date: Mon, 24 Mar 2025 17:33:42 -0400
Message-Id: <20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALfP4WcC/x3MQQqAIBBA0avIrBsoy6CuEi3MxhoIDScikO6et
 HyL/zMIJSaBUWVIdLNwDAVNpcDtNmyEvBaDrrWpW93hwXJhiBi9F7pw6Mn3xi3aDgZKdCby/Pz
 DaX7fD4BeAcNgAAAA
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
Tamir Duberstein (5):
      rust: retain pointer mut-ness in `container_of!`
      rust: list: simplify macro capture
      rust: list: use consistent type parameter names
      rust: list: use consistent self parameter name
      rust: list: remove OFFSET constants

 rust/kernel/lib.rs                     |   5 +-
 rust/kernel/list.rs                    |  18 +++--
 rust/kernel/list/impl_list_item_mod.rs | 128 +++++++++++++++------------------
 rust/kernel/pci.rs                     |   2 +-
 rust/kernel/platform.rs                |   2 +-
 rust/kernel/rbtree.rs                  |  23 +++---
 6 files changed, 81 insertions(+), 97 deletions(-)
---
base-commit: 28bb48c4cb34f65a9aa602142e76e1426da31293
change-id: 20250324-list-no-offset-96ef65cb2a95

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>



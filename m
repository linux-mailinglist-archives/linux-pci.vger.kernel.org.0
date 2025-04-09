Return-Path: <linux-pci+bounces-25552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6F2A821A2
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 12:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B8316FA82
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 10:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176632459FF;
	Wed,  9 Apr 2025 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CT9obIVT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC2933EA;
	Wed,  9 Apr 2025 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193017; cv=none; b=Jk/hGGzX/kD/q55vzOzmQzjF80ux8D64K2Ln/Agm1Fx0NNVYTkmMUazKU8Qvr2wbEZykZPQzzT3PJB+pbyQD7nI1UDedWtpci8Qt9GkWXlZ6TdW1P0tcv1uGdQgfI2kp6Y6GlZUeStcO7rds7PoAouxdPwRxIhsZqVSgJ6ZQc/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193017; c=relaxed/simple;
	bh=+504LIaLYH3GYI/X6tn7vfTD+Kd6Xy8aQnJggzTwpvQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rvJNTW5eBivj7FyfH30b5quYXkdLVyIrFi6Rtp3pD8vziuhJ1ddo38Ei+fEiPmSvrVgoleoas6XBEgB1pHx2eddQINi6vDpYCIhc1475eYtf8vcqmLLxgHqBMhQcICbyiMzJgG5CXToNbwv4RnER6oADsqLbaboYIbXyKtvzBhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CT9obIVT; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4766cb762b6so5846321cf.0;
        Wed, 09 Apr 2025 03:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744193014; x=1744797814; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zHcagWealHrg3dEOuPYH3+CM1KwGPAPPijAgx8qVx3M=;
        b=CT9obIVTLDSh5h9tywO84nbd5lne6N63C2dqU9vM+n5eclezPIZlauNUirN2jDbqtD
         y/MXxEEJvBOImiuxa67JHr7iCRmSxvCs1FdmLDoOfnDg82SOo15jRkiCiAd3G11afyPY
         8LJ9DUcisy+FevGKlKlXbtCaX4IJJ5ShdJ2TMa6kUSdlMRxCVIIgj4VFmwMtVxb3BCUY
         PQnvWaZtXD1P07u+uE6Lm7/aHb5/hOGMYRr3RmFK6IE/cni1pcoOSvSByOt5bNSiF/Rt
         UxI3rFe3KUmdeTKIPn+/NvTOFetaf4PiU8H5sKLg3obcA6gRrh/VfjiaPDkDkWeMNkhh
         i0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744193014; x=1744797814;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHcagWealHrg3dEOuPYH3+CM1KwGPAPPijAgx8qVx3M=;
        b=s148pTvRZPix4MzwhdvhyiCCPv2t9Tw8G+VUTbIBFsGC2W6G/mxANcg0RTAiC+cNMy
         Q9sI89G01GTm7P1O+wSJdMInPw5Tf+9A4CApC/3Cxv2hnA5Gs3/DM2uccM48faiR/oV7
         ABCRGS9sL1Gednixu50HBAgN35dXlA8kRMC/an8BYEAZ6bTw50to7iU8+F+D2R7iX/Pe
         W/F0hyO3gYHIicnubS6HcE91ScGBgp2ClpwB/nJEnMDa4gs0YpMxOht5mLS/Nyqmlbk3
         DQwMwcUAseLFjtkS8Gof5eipVdualb447pwbXCHBXa0J5rdAKmBdNNyH7MNi5SJ8+RkI
         MExg==
X-Forwarded-Encrypted: i=1; AJvYcCUHVB2i5/JlidR/d6dphtqGXpZuCcY1pQP/9z5J29rSHRogH52MBuAHRlO6P0NVfR1ilCCaHV2HEDgTA70=@vger.kernel.org, AJvYcCUWjXaDLltE1E+zYJ7L28TnWUbKAsiotMUC4XZUIQpyc2jQ/czRuNtFclJtZFd1MYRm8Say+x9e07VBd7iJKQs=@vger.kernel.org, AJvYcCVGMTC/Jrgkv12NA5sls4nXxSVpGwmLDPCFwmtnX/hhBJ0mTIbgSp3vqdNU144zSV81635p8nOUIPXu@vger.kernel.org
X-Gm-Message-State: AOJu0YzpXDrepyRUocCn5HSZza4WzXSQzuNzxajy+W2JZ9HRryxB7iky
	B9X6U8WrKM/IVwmdNu5G3m4gP/pT/nuxu0yewMAtd56hw3YdGJhV
X-Gm-Gg: ASbGncuwJtGNihrhn0PMm1xcLWt7Uhobs/Z+pfWnfHx9LJAhOgAahJwb0LBPvMY4yoU
	Z3cR4wpJ0ssOlj+xtHMrW5pyasku7n0JUyS15fXYIPHQeRfrc5KE0FCUao31NEXZCmTYnSKdsBv
	rBTrI4WLv0+EoHNHY7yQoN9uHIKUvoBJXwMf9n5TfQ0kpOc5CLzoLIJv419pPSN8MMpYcDbMoxU
	HluJ9UcHq21MM7BDiETY3MCFfbsr2YdpMIbimGKMamwHSTvBQzIKR0+fzrdAo7MNKuTZPz8aw8a
	SmXEVrYBZT9EleHdLBrM0AzQz5KZXssGTe1WMYzg+S7ziJHLKWK84b6TkPCClw==
X-Google-Smtp-Source: AGHT+IFt8wSkfijjEaLr897vxHiQ0DZHjrINMoJ0oDhkAPtuBFkx8Z0oWlKCQjRCwlFk5+YbdEQbJA==
X-Received: by 2002:a05:622a:408:b0:477:bd4:6a4c with SMTP id d75a77b69052e-4795f06c492mr30023241cf.1.1744193014177;
        Wed, 09 Apr 2025 03:03:34 -0700 (PDT)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:70db:4589:e2e1:f14])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47964de11absm5149601cf.34.2025.04.09.03.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 03:03:33 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 0/2] rust: workqueue: remove HasWork::OFFSET
Date: Wed, 09 Apr 2025 06:03:20 -0400
Message-Id: <20250409-no-offset-v2-0-dda8e141a909@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOhF9mcC/23MQQ7CIBCF4as0s3YMBQV15T1MFy0O7SQWGmiIp
 uHuYtcu/5eXb4NEkSnBrdkgUubEwdeQhwbs1PuRkJ+1QQp5FkoY9AGDc4lWpJNWWpveSDdA/S+
 RHL9369HVnjitIX52Ore/9Z+SWxQorJEXp9Wgr/Y+zj2/jjbM0JVSvrEvYYWiAAAA
X-Change-ID: 20250307-no-offset-e463667a72fb
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

The bulk of this change occurs in the later commits, please see their
messages for details. The first commit was developed in another series
not yet shared with the list but was picked into this series to allow
`HasWork::work_container_of` to return `container_of!` without the need
to cast from `*const Self` to `*mut Self`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Rebase on rust-next.
- Add WORKQUEUE maintainers to cc.
- Link to v1: https://lore.kernel.org/r/20250307-no-offset-v1-0-0c728f63b69c@gmail.com

---
Tamir Duberstein (2):
      rust: retain pointer mut-ness in `container_of!`
      rust: workqueue: remove HasWork::OFFSET

 rust/kernel/lib.rs       |  5 ++---
 rust/kernel/rbtree.rs    | 23 ++++++++++-------------
 rust/kernel/workqueue.rs | 45 ++++++++++++---------------------------------
 3 files changed, 24 insertions(+), 49 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250307-no-offset-e463667a72fb

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>



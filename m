Return-Path: <linux-pci+bounces-26807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D056A9DB2E
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 15:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38954A53BC
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 13:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F22C1C5F05;
	Sat, 26 Apr 2025 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFAQNP3o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348D319AA63;
	Sat, 26 Apr 2025 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745674427; cv=none; b=Yi2HQ+X6Me4Be2Jv5PWQ2QESTE+8Q2CCyOvmFmED1FWBFR1p4gaYH0019odx6b5mha2rp+9rwdIXwm3J6lmeNvfytWF1lihgJ+pLki2AkFbRzSTFlQtbmQppu8kdRSgKbjE7/V0C3iMrvHLKcSwy2ZP0eM/0CsC6gcTCdrCoQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745674427; c=relaxed/simple;
	bh=laYEX4TBOsk4CcxMpavBgNe9zSjYXY1+gGE9Nqbpo0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDSrjxsV0H/VHnxwcLw3sjm1ePvQ/T7b2+lLvAl7mVA/0OQrnIwfTES+8rOMhDBa8Cgg4zUkkf7i9Eo6aUhdFIhHYlkHRknfI+wTk4bcHL+EOTmDw+3oe8sA3+vwv9RL+qzSlzFW5CP7ZCqS0+Hv+UTYpJ3kCua2/9CGAs2ZDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFAQNP3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461BEC4CEEB;
	Sat, 26 Apr 2025 13:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745674427;
	bh=laYEX4TBOsk4CcxMpavBgNe9zSjYXY1+gGE9Nqbpo0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YFAQNP3o2dgumNhdt4IINojtRaRI0vPHnjCeANYqFDQAOA9JqJ+uosVRwgYL1fDSt
	 /qxgQo7YqICaJR1znVoKBL94DooX65wr9AmMbcOaxdQYyApo0smumJG/S0RDu0/RNV
	 OHTIm57p1XzQN2+rrmtc39VQHzjV6RJpYeKR077q8Wo649xQ0+NqRtMaVLEKl/dxOL
	 luuD2UPXVLt0WUwCArTj+SkRux7pc/neUb2GgReXgaTeJNkec3v4uSWv3fjj/y27kQ
	 5SLAKmV9WrxznBBd7KZA2rlcSry+OzG2bl6aTzN4nlhpvO9Xc9cWoMBI7TxUvXo2Hj
	 WjfU683UKqmqg==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	zhiw@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	bskeggs@nvidia.com,
	acurrid@nvidia.com,
	joelagnelf@nvidia.com,
	ttabi@nvidia.com,
	acourbot@nvidia.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 3/3] samples: rust: pci: take advantage of Devres::access_with()
Date: Sat, 26 Apr 2025 15:30:41 +0200
Message-ID: <20250426133254.61383-4-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250426133254.61383-1-dakr@kernel.org>
References: <20250426133254.61383-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the I/O operations executed from the probe() method, take advantage
of Devres::access_with(), avoiding the atomic check and RCU read lock
required otherwise entirely.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_pci.rs | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 9ce3a7323a16..3e1569e5096e 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -83,12 +83,12 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
             GFP_KERNEL,
         )?;
 
-        let res = drvdata
-            .bar
-            .try_access_with(|b| Self::testdev(info, b))
-            .ok_or(ENXIO)??;
-
-        dev_info!(pdev.as_ref(), "pci-testdev data-match count: {}\n", res);
+        let bar = drvdata.bar.access_with(pdev.as_ref())?;
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev data-match count: {}\n",
+            Self::testdev(info, bar)?
+        );
 
         Ok(drvdata.into())
     }
-- 
2.49.0



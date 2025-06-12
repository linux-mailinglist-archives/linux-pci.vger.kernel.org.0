Return-Path: <linux-pci+bounces-29549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED833AD7154
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 15:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08DED3AF7F8
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 13:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8350E243371;
	Thu, 12 Jun 2025 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBQb5AXd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5555023D284;
	Thu, 12 Jun 2025 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733912; cv=none; b=l1VeQl6zAMDyqVLcrT9LeQsMmX90M5TnAAmmIc/e3FUUNDy4L1sugj5wzarCPbFcIYS5+Jq1z4qtMN2AwoX0Yahn6Gp4W4Oy4NCscWVS8vSPWeWtd6bp9zr8n72lc/HY3BKkBRgc1rSRp6QXhvaLJg5wCIy5SNbH+vWnKiDhbCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733912; c=relaxed/simple;
	bh=FEZbDGNo2b5jvLwTR6AS8f/hfIVAHrWCGxHahtywlRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=orcT/30rBt/Z8nGvcpdxkiJeUi2VF3qr7g8HkNk1Xjqr8IZCPvF8jLfZBOgFGRffEVACPvDBinVuhvCBM012VyG/5HBycS00VJXk5v1KCvGXL6hZZ8HjKoavvtcGysU/8ujG/tvuCQoMAM9PB+pmTJG6AVWpjTUE72SWDhIuHbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBQb5AXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA3DC4CEED;
	Thu, 12 Jun 2025 13:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749733911;
	bh=FEZbDGNo2b5jvLwTR6AS8f/hfIVAHrWCGxHahtywlRI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EBQb5AXdPKg8hlat83TNEefxlLiX647569L5D5K20A30fKmyS1G2TJLUyVEmaGhJs
	 9WNQoJ3W9yBk+8fhs2GvLzicm01ZM/5h0FFmGEeDgkTfyv1HrFtYeQKJ0PWlOy9sg2
	 IxhKF1ZeGUuggdFKhDzku76XN9JREIcZ8UoI1LB7IRZi3K9nr4PTXsgR8zLkDVU5Wt
	 h3YTMBLquZqCqFKib7FfQD4Fw55F4oT/2C49Pn+7EHxu9RCfn3qv2JWZMzwUMauMER
	 ZYSXFKny1qA3G1ewWiErsJnGr6qduc5YD6/1sN0OlsLGYSNcX0ZmH+nEzkzQ7NhVsI
	 tSh2cuLgCqQsQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 12 Jun 2025 15:09:44 +0200
Subject: [PATCH v3 2/2] rust: types: require `ForeignOwnable::into_foreign`
 return non-null
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-pointed-to-v3-2-b009006d86a1@kernel.org>
References: <20250612-pointed-to-v3-0-b009006d86a1@kernel.org>
In-Reply-To: <20250612-pointed-to-v3-0-b009006d86a1@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tamir Duberstein <tamird@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=FEZbDGNo2b5jvLwTR6AS8f/hfIVAHrWCGxHahtywlRI=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoStGbcMdt+yS2gJghNN/b4cVIuKT+O97uTLGrR
 zSyrUr3tv+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaErRmwAKCRDhuBo+eShj
 d9JEEACma2fr9oZZ1fmy/MeQdkAoD8Kzj+YONLuAcDCKwIf2IWSNDilgPb7jwjmqwjXUnL3cC6i
 XPrJB4L4OFtJBwp/KEee/WfPDfYwz/5DH2lSODwrR5YrjDXl0/JKMRydo7vuLS2xhTUGPb1Grkg
 x+UhSdieLGVWetgDTPYhzpYY4DEqpdmlIWn0DkRGKI2zLbPO1vA4/JHtQEZuM6+2Zwr/3UBAbit
 TY2/qMzmFPghvq6Cy9Yme4gZqbFZyjK2DxTYFoRchgDy12I4RScT1p4+77jTwEszc5wapCmzrml
 G8NvC7K93kR/zrtQvPJbWuqGWB9eYPYKGl+fu8bFJRAeoDPZU5oEtywbCqHR2+PrRKUgyTn631d
 slcUGlC9H4rtDPSfjUVJl0atgG5JGB95f87q0QbJhzhPvnYuJLES6j8e07+qxfSWIqdwpy4mmrh
 5f9p4ScZbDrVWTDUs13K3UD7tJA34Q5I56bIvSRjHP2NPMP/DtTZ3nARtkePzEgVejc3hRyvHuw
 fQB/Ex2buuVkvtOEJULgo7GV4bFmPy5cpcSm+myXcUYIZTXZdIfhA8bg8LKCz26sHctPUW/nHqA
 qcgDlkR6T4nFcJOGkOiSGanAnIepLJgegIzH2HB3IjwBJw05ErTvbecdL5spiwBSG1OtideKG7g
 zihhplbhTTwnHTg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The intended implementations of `ForeignOwnable` will not return null
pointers from `into_foreign`, as this would render the implementation of
`try_from_foreign` useless. Current users of `ForeignOwnable` rely on
`into_foreign` returning non-null pointers. So require `into_foreign` to
return non-null pointers.

Suggested-by: Benno Lossin <lossin@kernel.org>
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/types.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index c156808a78d3..63a2559a545f 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -43,6 +43,7 @@ pub unsafe trait ForeignOwnable: Sized {
     /// # Guarantees
     ///
     /// - Minimum alignment of returned pointer is [`Self::FOREIGN_ALIGN`].
+    /// - The returned pointer is not null.
     ///
     /// [`from_foreign`]: Self::from_foreign
     /// [`try_from_foreign`]: Self::try_from_foreign

-- 
2.47.2




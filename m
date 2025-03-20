Return-Path: <linux-pci+bounces-24266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32340A6B0B7
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 23:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A788288249C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 22:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0998422170A;
	Thu, 20 Mar 2025 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYhcrtN2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CEB1B422A;
	Thu, 20 Mar 2025 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742509709; cv=none; b=F1q+Ka3UC7nUL+q+PgfbZ/iy9Bp4N5N3nxWsyqhJl5+xVYeqXtkVD8dV9Skvb5KUn3L+2aGClGDemDfMCvXB22gjHAfFoQDu8X4PUcykwBesdU1bbm/kRsBpFnwGcW/LIU4mQbLlIaIoj3ijxJPzNCU8FLM01n6MIR/XteTgBwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742509709; c=relaxed/simple;
	bh=/eDF6C2JflWG+9e9o4PLQ+zXIJKnOxeTv4ZNaiuzPc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QOwDqzhYfMAdapAxD4cGcLQhYJMKFR9m2SRcv7BEyu3TmGd9pXatD/5o+dmvksk/x11JVY1+pPjq7NUev4wAbWzDM0f8lL2FbCTrooi11uZDTrjmU7oX5FR8W8Mxy/rV04gqsGG12MAWYX6dOm8ABVmbM1OSngQCAA7DPNu7FrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYhcrtN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F257AC4CEDD;
	Thu, 20 Mar 2025 22:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742509709;
	bh=/eDF6C2JflWG+9e9o4PLQ+zXIJKnOxeTv4ZNaiuzPc0=;
	h=From:To:Cc:Subject:Date:From;
	b=WYhcrtN2N0wRNwHd6ATYSuo0sFbvF/YKHSOAbppAWtbKpmpAnSeo2RYbgmJcfOBEG
	 eqThoGFvlnjvvD0k8Iiu2ZDCbC20+/seNa3QIOykMofN5liwtODQ/BLjhAjOcFp6EV
	 R//JVxNLAi5YCCnBve4Cu6DtjTbk7Xu6lTcIKhjTbIej9BkbcFmqeZElaWPaATbm2u
	 8KK8qw5+XGOwNaSy9KSvl6eTdnVBPlOepDxvoRSIC4YILT6hodxvLNIIN5Awa3mruO
	 gXRn61ASGLzNeFwMF7Fi1yV+WXSg/BL8jYOdJB7jhGSQjYcAP7DbRjwkZyMkT/CWUH
	 56DMNYb4btB/g==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
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
Subject: [PATCH v2 0/4] Implement TryFrom<&Device> for bus specific devices
Date: Thu, 20 Mar 2025 23:27:42 +0100
Message-ID: <20250320222823.16509-1-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series provides a mechanism to safely convert a struct device into its
corresponding bus specific device instance, if any.

In C a generic struct device is typically converted to a specific bus device
with container_of(). This requires the caller to know whether the generic struct
device is indeed embedded within the expected bus specific device type.

In Rust we can do the same thing by implementing the TryFrom trait, e.g.

        impl TryFrom<&Device> for pci::Device

This is a safe operation, since we can check whether dev->bus equals the the
expected struct bus_type.

Additionally, provide an accessor for a device' parent.

A branch containing the patches can be found in [1].

This is needed for the auxiliary bus abstractions and connecting nova-core with
nova-drm. [2]

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/device
[2] https://gitlab.freedesktop.org/drm/nova/-/tree/staging/nova-drm

Changes in v2:
  - s/unsafe { *self.as_raw() }.parent/unsafe { (*self.as_raw()).parent }/
  - expand safety comment on Device::bus_type_raw()

Danilo Krummrich (4):
  rust: device: implement Device::parent()
  rust: device: implement bus_type_raw()
  rust: pci: impl TryFrom<&Device> for &pci::Device
  rust: platform: impl TryFrom<&Device> for &platform::Device

 rust/kernel/device.rs   | 24 ++++++++++++++++++++++++
 rust/kernel/pci.rs      | 21 +++++++++++++++++++--
 rust/kernel/platform.rs | 22 ++++++++++++++++++++--
 3 files changed, 63 insertions(+), 4 deletions(-)


base-commit: 51d0de7596a458096756c895cfed6bc4a7ecac10
-- 
2.48.1



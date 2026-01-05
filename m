Return-Path: <linux-pci+bounces-44055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5BFCF5B08
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 22:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CF353008F59
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 21:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC2D10FD;
	Mon,  5 Jan 2026 21:38:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BE83101C6
	for <linux-pci@vger.kernel.org>; Mon,  5 Jan 2026 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767649082; cv=none; b=la9+pVqPr8ea0Fy3g/CV94pxSMtujzBpMAvUJkb3W7qispC/O+a2l7ncNEC33veoHMIYgByTzsH721KYYjKPRlIdvZemsODvqffX17nFW3NaSVpX+E2PaKhanBRFTQNWuoai9jmDYAIvJjtHy1E02Y8Ab5C3Fm1rGSBdOpZgXtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767649082; c=relaxed/simple;
	bh=3VvKwjncE+fi9dt3jmAeaAVa0VgbTIvjNM+szL3TTHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLAaAGna8n44DtVGu072ZDK8yghjya4MsCpFkSb4P4n45YWvNK8hrOnC1Ca97nnRezs2eghXtSUDa5FdIBbweRxOot8y1n7zDc80+p+s0V4YYY7Y70ex6T6jvWaDC/gPlfnjSp8Qh3csKtSZfm+cQ66JY+42oa8Qgg5VvYwbj60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info; spf=pass smtp.mailfrom=markoturk.info; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=markoturk.info
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so500862a12.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 13:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767649079; x=1768253879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVGhBLas13Sdkp9EBZQEtNUtaw958v3jSwy9njwz9xM=;
        b=vFgUoGtvIlnt2wlG9gw+B+Zp2cQapDn3gQmS0BpACaAwKbO0j0Fx92yd438s1SxJ5Q
         0xLU+aG8kQf/Nev8fFTZTSE3vazHaR2DdsjN+2+U7vm8kIiVpXv6t+YG3Nnsw3hn7fZK
         VAnNLTH/PEFCqGkN90IwPfnEOchADyUNssM282QoVlCp82X+4CRlw1UJmskYIkUoKdXO
         3RgOccipD5zo4ZFi1ccKfvdovsUg5hzAP8KeT8dBEheeRgXj6107OvGmFoG0TAvr0kla
         D7enKkTkJjkN+/W/huPlqQorZRg4qyMGFbrof+osDYVMclM93UUFMYZIe8DCCc3San4A
         zxRw==
X-Gm-Message-State: AOJu0Yyt8mMtSRKqMWElFmt6AkUFysicKoNVeVT8WdDzUb5/rPqTBp9d
	DuqJDW15QTZb12dmSXS8axsnPl+R+Z93Un3ivG8UbsrMdfYd7UP2Qw/KZzZnZkiOWfU=
X-Gm-Gg: AY/fxX7VN8Xt75Gr3Z9dicHRu4YtIjexUqrmD577X0ogGvvTlsAGt0HrcBRuc++9Q4L
	3LAuojYUr0oaYE7N9lc39+Cw4Ab2WsSvTo11qG9sENrDrlOLV78i+f6o2Dsd9R4xMP11cQc7aJA
	k0VZ2M5PuNjSM2/xxlqL+ZURCKE365TeS7XMZU10prktRsgK3e655Ww99KezdGXoXcQ1RhqVqPd
	pG42dM7V5jnS8CKlJ56DO90kC5yytRkDuy8wM6FoMw91u0a+FbWU44YPGxrh8erMGngKpT6BHRU
	fwNXNrboek9d/CDZZMC5fmLcZIXsNdhkpnNPiR322PR4xjowPKcWYEh9R9D5yf/1NVdfh6dE3GN
	2nAUszjYtESMVNvecwnWDgWOGxsb38rygi+WT7uWloJVtH+McMlom1chaEHNFiy817URXiTBw0u
	a9e+7V42aIDG4=
X-Google-Smtp-Source: AGHT+IE7l7WtiE+uRHtEnaDDT+H8lvK5cKT1MXIQsQUNDiS4uD4MKy8ZfA8QmvMTwSezMWz92pqwZg==
X-Received: by 2002:a17:906:c143:b0:b73:5e4d:fae0 with SMTP id a640c23a62f3a-b8426a7fa3bmr94121466b.23.1767649078733;
        Mon, 05 Jan 2026 13:37:58 -0800 (PST)
Received: from vps.markoturk.info ([109.60.4.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d3831sm35034466b.44.2026.01.05.13.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:37:58 -0800 (PST)
Date: Mon, 5 Jan 2026 22:37:57 +0100
From: Marko Turk <mt@markoturk.info>
To: dakr@kernel.org, dirk.behme@de.bosch.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	mt@markoturk.info
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, Marko Turk <mt@markoturk.info>
Subject: [PATCH v2 2/2] rust: pci: fix typos in Bar struct's comments
Message-ID: <20260105213726.73000-2-mt@markoturk.info>
References: <20260105213726.73000-1-mt@markoturk.info>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105213726.73000-1-mt@markoturk.info>
X-Mailer: git-send-email 2.51.0

Fix a typo in the doc-comment of the Bar structure: 'inststance ->
instance'.

Add also 'is' to the comment inside Bar's `new()` function (suggested
by Dirk):
// `pdev` is valid by the invariants of `Device`.

Fixes: bf9651f84b4e ("rust: pci: implement I/O mappable `pci::Bar`")
Suggested-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Marko Turk <mt@markoturk.info>
---
Changes since v1:
  - updated commit msg
  - added Fixes: tag
  - fixed another typo as suggested by Dirk

Link to v1: https://lore.kernel.org/lkml/20260103143119.96095-1-mt@markoturk.info/

 rust/kernel/pci/io.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 0d55c3139b6f..82a4f1eba2f5 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -20,7 +20,7 @@
 ///
 /// # Invariants
 ///
-/// `Bar` always holds an `IoRaw` inststance that holds a valid pointer to the start of the I/O
+/// `Bar` always holds an `IoRaw` instance that holds a valid pointer to the start of the I/O
 /// memory mapped PCI BAR and its size.
 pub struct Bar<const SIZE: usize = 0> {
     pdev: ARef<Device>,
@@ -54,7 +54,7 @@ pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
         let ioptr: usize = unsafe { bindings::pci_iomap(pdev.as_raw(), num, 0) } as usize;
         if ioptr == 0 {
             // SAFETY:
-            // `pdev` valid by the invariants of `Device`.
+            // `pdev` is valid by the invariants of `Device`.
             // `num` is checked for validity by a previous call to `Device::resource_len`.
             unsafe { bindings::pci_release_region(pdev.as_raw(), num) };
             return Err(ENOMEM);
-- 
2.51.0



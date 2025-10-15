Return-Path: <linux-pci+bounces-38258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5EABE05C9
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 21:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BEE13BF85D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 19:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CCA305957;
	Wed, 15 Oct 2025 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbCdb+fM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0230DD3F
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556308; cv=none; b=JVv2o3UcCQCkQAdBUXZalyIt0cKq8LCl/TF3LPRmiwaIDwWasyAD5yIEzTy626rJNi8RhSSXCvjTHZJWMAE/kYzmh+u9ov+/fbUf2BbInJrtriPV0OXcH9rRTQLJaNcsv5RkMu3PyrQYv/uXbg8PFOXk7YiLQN5gaGF9nFVKkP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556308; c=relaxed/simple;
	bh=/6FAAPliz9JMtIVhSN5WM1U6uwaxaWrmdWOweTW7QYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eFbDDsKackrKuKGfKteY3603X7L3Gomw+0kWhw/HdIEC/kQfOJNeoo0gg+AIe1yItPi5nhV6pWGhiz41spiGv/3qmtsIEcyz/wkZlXhqwd9Y7RuIZpAeadNt7kcPrIHk4VPenoH04Do3+zJnuNpLubYe89hDiww5KCc/NK3qE3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbCdb+fM; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-791875a9071so92436366d6.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 12:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556304; x=1761161104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+cfNHruMdPBuLxqLR3jBeCuq6DohSxciPX7+EKAG2M=;
        b=JbCdb+fM+OVabHRFA0Q4ek4JESF0QVGj+1Y+55BDVoMky/bZJokq4LiZQoOYNJo+6+
         7DXUahkxmMERzwdWQZZs0E3KcR3RoK9s/8h0Ro47K8vtrh75OjVFVQAJyl9PdUQBRLlj
         eYJ2bxdgv/4W8p/VXKBJS/lc8Yfrt4CAAWHvxgzjEGm1nCS36OGdoDXpkNW7EQmDMLbt
         r4kuh0925ie7RHRpBJJg+q9zIL+DH58iQIoxaZhmC9Ov7bIgBvUYv6/YoumwSZImbTjb
         cda9nCeWjILwA/5qrqhY/1Q/tGQs6JlncqJi0o0Y/N0marbQ/O0MGe9fiqmkEhmPQ1P7
         i9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556304; x=1761161104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+cfNHruMdPBuLxqLR3jBeCuq6DohSxciPX7+EKAG2M=;
        b=TpoLEMHzYRDDo+XT0C1uC0CgOFnbfOQOTE46tWmsn+nZNABf5dygg+BwTh5OaF+0cO
         kbd78USDxXqGT9X/mIxbUsX4agwIxx5xcqV2cD0kJk7NB8Ww3hJPHrqomOCU6QFORpF6
         HOWzsdzJdrIy6ASBzP2ScQv24sZXZBN9ncbZZe0jgLpaSFcP8WM3WMUZIW/quRlBnIm9
         rEO8wbYzlJwrH6ZU1IpWYS6E0xGAQdtzZgi1sgYIKJyRCz0xC3HyzLZ2wdTYEvH/+iC8
         He6yubfYFYFoya/mB5b2vdei6tW1lfsfd22KINz4Q/Ug0ENzoM6fK14aN8rA1G+TbItR
         B3QA==
X-Forwarded-Encrypted: i=1; AJvYcCX0duwaG7fPhF9lqNeONxm3zt1Gs9WBojO/bank7spckajGZ+jfJQ4RXqxgga3GIB9dbUjaQZu68wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZYTo1sVykYdaVBDBzt+1AU8X7S1sEnzO88qM0SkEKxGhRP7cL
	RFrTDXyvORhavYL6oJNl34PgqHjH5yS/hAMMZruNDcXJ+G13Cu0udah3
X-Gm-Gg: ASbGnctqXw0WaW6mrWoSpFT3/73VKPo9nmS+D37uG3np/cSC31jU/cAXZ2ludwAwZ8Q
	IPwwHdxxVw1Ay2O8FZ7n3Qfsra24v+43JSsBKg+cJqlNjat4RdzUjzXZwW+7tVdfMnOSZ6LNU+B
	BUAmrN4EyohgPTT4hgN5TQ0DA/fVvqV66N3l1mmok5TgoZBizHR0e5iFskM1bwXpCplbUBuyLHc
	jwFpCLjp1MNU0BWZGs6dRpq125v+2Uz1zHDECtfCMalXPzpCZb/XyO3AoGbpqcBf/L7CbPceFNH
	qur3WYADinCR9acOZ9Dl52dc5kBYgKVPv5udnVJ+3BpVTVd8Bka0yvYcRhb1ts5GmABJgCqi2T9
	0/sWYODrgeiJBS2lDpH5AzhGCNDNl4SviPolNNAY3voAggTn6LoIR+qli3EYqE/GmNLtLAzINbT
	bphmgkL0vW3id5NY2+9o2FvYSceTFYeKuZ4JlgnupPK+M/84yOAb14KF3zCcXSLz55nU1SzyccY
	V5+qB2LOCf9h/tbkHsDOEQqZwIs
X-Google-Smtp-Source: AGHT+IEX9u1kD253LkrUXYqr3dEKSTO5L1DiyQsTG96pQUi26l2qBcGyddQYo91Es/OcoCoyz3pFyw==
X-Received: by 2002:a05:6214:2b0e:b0:87c:115e:47c6 with SMTP id 6a1803df08f44-87c115e4a3cmr1082086d6.60.1760556303575;
        Wed, 15 Oct 2025 12:25:03 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:03 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:32 -0400
Subject: [PATCH v17 02/11] rust_binder: remove trailing comma
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-2-dc5e7aec870d@gmail.com>
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
In-Reply-To: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556295; l=933;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=/6FAAPliz9JMtIVhSN5WM1U6uwaxaWrmdWOweTW7QYA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QH7AeKnZyD8ngl4+hPz+8Rz7zx2cNxYrkgP+Fzg1nzu/J1gZ5lAhrwaQqIaNPJOGnMwEnAQZVmN
 mf304LMVVag4=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This prepares for a later commit in which we introduce a custom
formatting macro; that macro doesn't handle trailing commas so just
remove this one.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/android/binder/process.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index f13a747e784c..d8111c990f21 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -596,7 +596,7 @@ pub(crate) fn debug_print(&self, m: &SeqFile, ctx: &Context, print_all: bool) ->
                     "  ref {}: desc {} {}node {debug_id} s {strong} w {weak}",
                     r.debug_id,
                     r.handle,
-                    if dead { "dead " } else { "" },
+                    if dead { "dead " } else { "" }
                 );
             }
         }

-- 
2.51.0



Return-Path: <linux-pci+bounces-24078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EA4A6871B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 09:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6CC1894172
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 08:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7CB211484;
	Wed, 19 Mar 2025 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wihvgUXP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F92512CA
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373683; cv=none; b=hDr7A28xz7JHvz3iJLuVyuZYZQkVfL4z92wTziMQgzv9Uxc8UF/pswCyW3tl66zkaKLX0DK5PyoYL8Xz84hfhCV3pmNX58Z1bQ5isaYoqF1UZ653nzaQjNypr1RBsgao1oAldLTtU4w767LfX8IzX5ZeBW9b1ucZwaYr+lIdYJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373683; c=relaxed/simple;
	bh=yoUiQSYGpSGekAoG2O4E8f17ta3m6ARia8UOtVAr6JI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I6f02U/KqbMVIJUudqRuP/Hc6iE/UuWbt87bqiUI5DzIXLcQGIW4JmvKiR0JSUH74zChr//TGSTUYfoef+T4qoqrD3TQc7Ht+r+82nwWP4YS3NsLFfR+DFfs7pXEsC1w+GiUi1jkr91vJyVqIOT2o1faAwe+EIDb/wytHXnLEmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wihvgUXP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff7cf599beso9829703a91.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 01:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742373681; x=1742978481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pqyah9gjao8rMiwTqNmziiGpp43wpvz0+2z6DdoovpM=;
        b=wihvgUXPjjnWu2BMZ1ZQtQGjjk2wnpumw9ZLBUNx8gI05D71ERRB9C/LBl8tKVhq/w
         8no4nsVY//+/o7VCPUNIw35Jvpq4334HKXQWxTlo8F3YGOvF1qext81VviUH6mQakG2E
         YmolBuQ8ECgWgx9dFmP2F3zCyVs3mptc0P3vekmNIRuek4hd4lz6RMKxLpNRhZLSX5Ve
         mH/iuQq/Cots5D+eJoPosE+ZkSvQeCciKxZDgxdesLkMuCz7fD7Z8gCZ+QuMOfuliYG9
         +K67AV56yIuilGQKENpZiOuDBoHAMocQlEbso/q8mkj2OMWlbPjpLr5JNZ+c6vk/BNEX
         GZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742373681; x=1742978481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pqyah9gjao8rMiwTqNmziiGpp43wpvz0+2z6DdoovpM=;
        b=khckQaUaMFweBIlo+F5mjIGkSckajMIzoz3wt7Rb2UaG2KSzLE5V57BLSGXMaB12bl
         aV2NAQfMe08z2C+2ei80S2R/HyKtRBdF3fNN7E8K0x8QEJ1XUzx/JqmukdyFew6gj8tp
         24pP3sLkiFXfI717ZHLjSUCegtD4jTa7Kl/1c0orJijQ4oTu/Qnx3p/u9Uw34OlQ6znl
         EAzOqNp6k1i0Lf04casnt5as/aGgqtjwdubcltk5Hkwl8mdLRcO5vCNKVm2379OZjQjC
         cK8pp09xdwXn5brSjz2+wuARH8zc/QM1kmVs2RRyu0DgzJoEsv3fwhkjoIG9WAw2HOgA
         nKWA==
X-Gm-Message-State: AOJu0Yzz3nNIfPgcoG0D5dB09EvTyMdx+IrwADaCM2j/9KIEyiWftVph
	Je26SkbcURqdtgYsr+kz0scRnwlNq0cyNFmDIUdn+owUzhdo8CgmD/pyZthZLZcD3/bbTiqYFlC
	JRw==
X-Google-Smtp-Source: AGHT+IEHDNjxg+Ne8KvSr5xhxzIPz/jxzhh1ftjlAiACeDyNjb2JUvc0aF+MknYSfBxTHb8uVrjYcIwRFak=
X-Received: from pgcp23.prod.google.com ([2002:a63:7417:0:b0:af5:fb05:d856])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2d26:b0:1f3:32c1:cc5d
 with SMTP id adf61e73a8af0-1fbeba90c16mr3302848637.21.1742373681021; Wed, 19
 Mar 2025 01:41:21 -0700 (PDT)
Date: Wed, 19 Mar 2025 01:40:47 -0700
In-Reply-To: <20250319084050.366718-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319084050.366718-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319084050.366718-7-pandoh@google.com>
Subject: [PATCH v3 6/8] PCI/AER: Add ratelimits to PCI AER Documentation
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <Terry.bowman@amd.com>, 
	Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add ratelimits section for rationale and defaults.

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 Documentation/PCI/pcieaer-howto.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index f013f3b27c82..896d2a232a90 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -85,6 +85,17 @@ In the example, 'Requester ID' means the ID of the device that sent
 the error message to the Root Port. Please refer to PCIe specs for other
 fields.
 
+AER Ratelimits
+--------------
+
+Since error messages can be generated for each transaction, we may see
+large volumes of errors reported. To prevent spammy devices from flooding
+the console/stalling execution, messages are throttled by device and error
+type (correctable vs. uncorrectable).
+
+AER uses the default ratelimit of DEFAULT_RATELIMIT_BURST (10 events) over
+DEFAULT_RATELIMIT_INTERVAL (5 seconds).
+
 AER Statistics / Counters
 -------------------------
 
-- 
2.49.0.rc1.451.g8f38331e32-goog



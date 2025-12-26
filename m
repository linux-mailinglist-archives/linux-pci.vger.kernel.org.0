Return-Path: <linux-pci+bounces-43726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9B5CDEA88
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 12:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DE05300797D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 11:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FA1298CAF;
	Fri, 26 Dec 2025 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICeUjw+w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F551F3BAC
	for <linux-pci@vger.kernel.org>; Fri, 26 Dec 2025 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766749186; cv=none; b=n07/+Db8bS+uF6IOjgN1j5Xn0zfh+2b8elrOpbk24lUD1CVys2GQoQE/fIlIjjdqdavCfD/Vsol757RZIGA5BUwoY2T8qCYsJr07I/3apkBGhnuRFs0LbRPuYEmTAVuMaZg7hSy3TIOkBfaKdhpn32ZnqzrR3QSk2KXb7D1im4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766749186; c=relaxed/simple;
	bh=ejONzTVU0FdmdyDekUr8YEFyQevob5Y9vbn53RBZ8Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GdteknZsDlqK4IP7SKsot82zDcITfZHpF56vG7fOv+kIkooeNi/n4tI8TAUfwod+culdCaRBgK6Hqv7Ny/CIKf1B5fx67GgOuy8ZNXoua1fiTvL1XKqICQDSOVl4KSngoNXVVlscKU3voZxZtqeU6uiOQzuAQm7QcJRZ0/IZkNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICeUjw+w; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8888a444300so78319536d6.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Dec 2025 03:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766749184; x=1767353984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tmKT01VlgiVDtYWOF8z6L//YBXMRlOGnlMxAj6FU8N0=;
        b=ICeUjw+w5OHQskyKx9agrJ3n5nKEj0nAFhrkZVXcZWgyL48hqGQcm4pcvtWjlJThmq
         8zuT/rHWdvHzuWoWIU8aCFLuXDk8uWvBFwNLxGQH65VcT3dqlYJjhJVFmzTA0GwetecK
         lgWhjTlP1sU4nP7EFIuQ/OxkxBufyOyiwDe27F+nL9Oz7Zq7nyz2CaxdxQIw8MstYiDm
         euw1kx6Rl1lQc3oy9Be0mmJ3WcvSdY5ZpRDGdlelsRzRInQAV3XN3z4q3lYVw5qs1ftE
         mZTW3AwglQ1VP3UBVzffCde64Q6GdiGX9qTbeSJJKsUUVfneSfZvaUhHCHRAiISaVDFk
         aIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766749184; x=1767353984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tmKT01VlgiVDtYWOF8z6L//YBXMRlOGnlMxAj6FU8N0=;
        b=CHxyM44g4o95Jri46i4vzz2RASZRUnxxOziRKaK/N8PXHSzk4OaWAEBS2Y1QQ/G6KB
         v2F0cUm6Mg/dZsR3+NC3stf+pVIAkc6nX0tA28F6alYYxKXE8rl3OMlsNMH4hvtlq0Lt
         xoFarh8XHLWhVuopDrfIEw4p2gvX29N3THGU5EOI30ItcCvTrM5dcda6JdbZyZqMjz8U
         9gQCiXVO82EdsxuhgGYCQz58YGQw+SggHQPi9E040/F/6AgpMBoPoiBH+Ty2m/ZXGnZh
         JBJsH/GZrvZkI8qqp66Cq7iOLeRxG88CwoF1dyFOKYCz0YrTlZ/Di2bzdKsIO3TYPZ+j
         jyRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDsHWhaPhiYB6FyXB9lYE+926nurIHOidrWfqcW+ueM5dTp1XnDp60hP1A5QGTXIYmDPEbVdajptQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU7cmB18n9eT8PqY5oaOxm4Jo3sy3pU0WgLKrBOf0BcSg5/2b6
	EtxKB4GyXJu9IGEWiAhVAB1yXDOVCzQuFKYek0fHAsh7bvVrX/xKlupk
X-Gm-Gg: AY/fxX7jFsJQ+cq9Pb8ce6PLa9u0Ac/fDsvOqTCPJYTZaBK4tCBSVdZMqtVj3EqBbC5
	gEwIDllYr664GJR52G3/HpYXQbb6AyDcDlJc4UZJxfbEaVdQqDAkJwLlVH1xNf3PxDKG8Xpt/qk
	MOdEIGx4fkY/JMcA5qX+tGc+/rozLytzV4q/mzq2fnW3U8Tu77XdIYaFIQbkIFXTlztBJoD+Rn6
	hB2je/Q+e16X7W+L7vSwvJLUJKLG8vsXOPEuVMUybOw6wI6UKxnFoFXTRD1qY1tSH9nRtaafby7
	+LM1LRcMjda11QZ8LZEq94bhp+YoZqE1dA/XT1/k8bpmGWoWK0dtJdSuyiYDTIngy3bE/bvKypB
	eftW/hVh0tdl42hxXmP5nZMAEKeWEM1DtXNRZtbb142NYL3yGK//nqdqds9BaDNNTlgtZro3gIY
	8E+2YvW5CZHF2oQrW/fDt3u9MtOCsyqwo/1FrI6HFF+D2Ntcd3vzUVd4aZXgivc0MBURpcka2U2
	wMtistBNdjpjhw=
X-Google-Smtp-Source: AGHT+IGV8BHHtX/GVo7I0/97UaUQUtAkvaXwseFZpyG4xX7ayE5yjIfCJ/90vxAgzY9uXJbR9su+2A==
X-Received: by 2002:a05:6214:248b:b0:70f:a4b0:1eb8 with SMTP id 6a1803df08f44-88d8203f029mr371419736d6.13.1766749184014;
        Fri, 26 Dec 2025 03:39:44 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d96bec1d3sm165930696d6.17.2025.12.26.03.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 03:39:43 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id DB8BDF40068;
	Fri, 26 Dec 2025 06:39:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 26 Dec 2025 06:39:42 -0500
X-ME-Sender: <xms:_nNOaZz7d5PDPwIEHoTgeLWMoK0trC6INblxeKYyn0mb84Dhg8q4IA>
    <xme:_nNOaeIgxk7dv9vjr8-6y4IEoF1dMRTkkWrTvz2H4jJrrLyWp7KZ0DXoCbQ0GsLNp
    HxxSFWjV0q1FTBTttD9YJeKienGATafTF04wtjr2aZrGUihJhbWcA>
X-ME-Received: <xmr:_nNOab5UiwuM6njQyvoJmfrMZ6X3P47J4zHQX1EYHlCsu5nbGZwzsyjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeikeefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfhvghn
    ghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnh
    epgeegueekgefhvedukedtveejhefhkeffveeufeduiedvleetledtkeehjefgieevnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngh
    eppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghngh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdp
    rhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtph
    htthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgdrhhhinhgu
    sghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgoh
    hoghhlvgdrtghomh
X-ME-Proxy: <xmx:_nNOacwXode_EDdi-iJ4R4d3HemtSSIBt3_7C4tiZqfE2_Vzc5sFIg>
    <xmx:_nNOad9QHGw-4GCVx7menAHWVyWa_upulO2RWYd9m7AWDl4L3fH8Ww>
    <xmx:_nNOaQGzvbsYU46FMowqg0-rE1kbngIdm52hyUtT5heCLhVXj4yYVA>
    <xmx:_nNOaXDW77woyuMzmWjbQOb2dwGkexT6SqPF0SY2ZaYkTqWujGMYLA>
    <xmx:_nNOaUmEYnwCrT1xfj2QtgmcPSQ1CWghtvtvWxbyVCsULNFOUf1-a9PU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Dec 2025 06:39:42 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Dirk Behme <dirk.behme@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Liang Jie <liangjie@lixiang.com>,
	Drew Fustini <fustini@kernel.org>,
	David Gow <davidgow@google.com>
Subject: [PATCH v2] PCI: Provide pci_free_irq_vectors() for CONFIG_PCI=n
Date: Fri, 26 Dec 2025 19:39:38 +0800
Message-ID: <20251226113938.52145-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI
is disabled") fixed a build error by providing rust helpers when
CONFIG_PCI_MSI=n. However the rust helpers rely on the
pci_alloc_irq_vectors() function is defined, which is not true when
CONFIG_PCI=n. There are multiple ways to fix this, e.g. a possible fix
could be just remove the calling of pci_alloc_irq_vectors() since it's
empty when CONFIG_PCI_MSI=n anyway. However, since PCI irq APIs, such as
pci_alloc_irq_vectors(), are already defined even when CONFIG_PCI=n, the
more reasonable fix is to define pci_alloc_irq_vectors() when
CONFIG_PCI=n and this aligns with the situations of other primitives as
well.

Reported-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Closes: https://lore.kernel.org/rust-for-linux/20251209014312.575940-1-fujita.tomonori@gmail.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512220740.4Kexm4dW-lkp@intel.com/
Reported-by: Liang Jie <liangjie@lixiang.com>
Closes: https://lore.kernel.org/rust-for-linux/20251222034415.1384223-1-buaajxlj@163.com/
Fixes: 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI is disabled")
Reviewed-by: Drew Fustini <fustini@kernel.org>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
v1 --> v2:

* Add Reported-by from FUJITA Tomonori, kernel test robot and Liang Jie.
* Add Reviewed-by tags.

Thanks!

Liang Jie, I added you as Reported-by because of [1], if you prefer not
to have that tag, feel free to let me know, thanks!

[1]: https://lore.kernel.org/rust-for-linux/20251222034415.1384223-1-buaajxlj@163.com/

 include/linux/pci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..b5cc0c2b9906 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2210,6 +2210,10 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 {
 	return -ENOSPC;
 }
+
+static inline void pci_free_irq_vectors(struct pci_dev *dev)
+{
+}
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
-- 
2.51.0



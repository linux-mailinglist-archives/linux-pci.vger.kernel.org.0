Return-Path: <linux-pci+bounces-40639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 485C2C4302F
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 17:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2830F4E0341
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 16:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE87E21D3F5;
	Sat,  8 Nov 2025 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9c3GHIv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617531F7586
	for <linux-pci@vger.kernel.org>; Sat,  8 Nov 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762620929; cv=none; b=tXNi5rQjzyPf+oh+lR84K24RpEPaFKt7aVkQzt8HKhxzbgwWDRlXNmnepWTsN1w8UkQYiDN7OdJA7nHPErXgezcOE4sJk6j/I8IUAvDeY78zB6c9uvOe6zrMp1QDyylqUPsvtAexehqX8VRTL+KM4YkI3T15LM7GPNdH8N82RK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762620929; c=relaxed/simple;
	bh=jwOLrkoRqkPeOPBDl31nNUDJya3IFjX8AQzLP7gIsVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gpc6a6SHObn1dhjxEupuiisnPf1BSsqguzVFNGm0bzHMJaXSY2eC/rjjJkm2UnQCN6BKlfuEgDGjE/8jwQ5ibTRFtAyUNAxxIcl3m06dKhIjlvufj3HaD270QNHyrMpmineDOWCxmo8MiaGtYEyCk4sGI6h2XM2DAc8kHrAApi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9c3GHIv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7aca3e4f575so1395560b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 08 Nov 2025 08:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762620928; x=1763225728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OKOkwqrhiH/tVcZkXWMht9KXzTRKBq9BT+UhE+2IcfE=;
        b=E9c3GHIvk8SZ+HjnOjFeg8NruJWIti36H1LyeMXHBunyu5D1zqGF0HauV7NkMg/7P2
         QIRkfc6uQZfRzHWWPhbLN9JIkPrjCwmuRZ9aVKssC51mb9jCDOm3Zz8gWWBG8LvkgJmz
         iuyPHGBmX84wx1MXBDUXwGks+J4MYgx5SbekjrpsRZjjqzWwVIeJZVjx+cUEkJClbZNF
         E7YnHazC8RU2kdJsQkqaZWB0LTwHubwPuX94O1cgghZH17o7bI15dBv2ZfRLRtGjVous
         2g2NtO4KtdfnPPbx5QZg2uoRj8jOAOvS+PqyoHnquYuQQImRbRNY/QrCSle4k8rZUTQH
         XXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762620928; x=1763225728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKOkwqrhiH/tVcZkXWMht9KXzTRKBq9BT+UhE+2IcfE=;
        b=bb989+3E09cC8hwzqXFd6SMaaZOLduSjkEwLJOv7Tk2c5JLLjWgbce6nPBwLF5Uj19
         XIYrH2RFugeuMoYrk9NnHslck/ahXgicW+f3EJAwfJGgmNGorYTJRfpdlVmhxWz4ICnO
         LHCo9R/5iqyYMPBCOLnYOIisQeRy6LkTxosNmLN1B23DqaI+wLEJ87VAv58tPrCOLgIq
         +S5OOB5k8QG0Fl8z/wuRXwsw2ubodQH/Wzbw+SCSwkPJy+mmmQmy3iA3YD+k2ArYoANf
         em1vmy6tBsECcOTAzvGSjABmDSH5x2nmwySB5CdSvmlwUFcvHDjjzsNUBWwdrUmPkNVR
         nMVg==
X-Forwarded-Encrypted: i=1; AJvYcCW+KGL8N+5huXZVgDUe1cBGitM6TQIuFELzz2HUC2DFYDnsY3VEuspIaBmWe3kHIzziIWumY27eaAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFwPGPVLikZWjQDe4ZtanD5xc9m9DtoJaCJXSKW7HdxBp7JlR
	IV/MhSvxlDj6rtRU9y+OclEabwIqJaOy26eI9GxTALbBSsSS7RI0i/jB
X-Gm-Gg: ASbGnct1ZYzdCtzGAfL1wVoecrwM76xZiB4ghYjB83LQ3cME+YZl5n8U79Q0DMmPqBC
	EIZWp6CWZrMVUz83g/tEswSfmHMcl7RyQBqv3Y0VpCbWJVk4BLGQKF/vdfZ28BbwYiu7hRC4xNR
	6EMpQBZh31jCPUXQIhfZGs29/JzC++ZCq5V5xBy/VTun0QO5hNflZ1oVXrMQ1l1YEksRggnH+82
	eqV4ouBT1fpQu+Rl9wp3BwzUXzaERWYO07JVNzfDPzjsU9Y4S3UAAMgV8nJUEacHcz90JbdAo69
	GF1AKcJHltm7wjB2/k7Ml2NW6j0YWZJ7v/tGtXO0w2tN1PDMoHSrEPbFN/kVO+HMgrbj3Twx5ar
	hAEu8eKze7GHMl6kl0mZhl7u4NHm6XuQzs1Jw+Q446hsVu7TORtDIhFXlR5gk6abSRYKjNpyn+/
	IHSiOg5/M7FOww9QWw5PlxxsXXjg5hbF4l3WZfLTY=
X-Google-Smtp-Source: AGHT+IGBRSYfYejPzPUa6G3F+P0qHnfJt8Gfvd2VQxOhkvmZSJiF5/f7Vm00ZiSW3lNcWNhmhQeP/g==
X-Received: by 2002:a05:6a21:99a0:b0:349:c80b:d5e9 with SMTP id adf61e73a8af0-353a21e1f48mr4740818637.23.1762620927662;
        Sat, 08 Nov 2025 08:55:27 -0800 (PST)
Received: from localhost.localdomain ([119.127.199.141])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba901c3817csm8181254a12.30.2025.11.08.08.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:55:27 -0800 (PST)
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Subject: [RFC PATCH v1 0/2] rust: pci: Introduce PCIe error handler support and sample usage
Date: Sat,  8 Nov 2025 16:55:09 +0000
Message-ID: <20251108165511.98546-1-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This RFC patchset introduces basic PCIe Advanced Error Reporting (AER)
support for Rust PCI drivers and provides a simple example to demonstrate
it's usage.

The first patch adds the necessary infrastructure in the Rust PCI layer to
support device-specific PCI error handlers, mirroring the existing C
`struct pci_error_handlers` callbacks.

The second patch updates the Rust PCI sample driver to implement a set of
dummy error handlers. These callbacks simply print messages and return
predefined results, serving as a guide for future Rust PCI driver authors
who want to handle PCIe AER events safely.

This series is an RFC for discussion and not intended for merging yet.

Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---

Guangbo Cui (2):
  rust: pci: add PCIe bus error handler support
  sample: rust: pci: implement dummy error handlers to demonstrate usage

 rust/kernel/pci.rs                    |  11 ++
 rust/kernel/pci/err.rs                | 273 ++++++++++++++++++++++++++
 samples/rust/rust_dma.rs              |   1 +
 samples/rust/rust_driver_auxiliary.rs |   2 +
 samples/rust/rust_driver_pci.rs       |  47 ++++-
 5 files changed, 333 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/pci/err.rs

-- 
2.43.0



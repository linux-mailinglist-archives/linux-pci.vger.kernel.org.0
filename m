Return-Path: <linux-pci+bounces-40079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0340C2A2D7
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 07:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 392A34E962B
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 06:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B4C154BE2;
	Mon,  3 Nov 2025 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEQ1VRQg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1DE28D8D9
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151211; cv=none; b=LswnP4SnDCFg/jdUIwTtip+ylHDi5aekfg3fvjPRIEixndA1ldEEP5VCRVFvIyNT5UiM4zoXZlRLkFVKP5ax5uxNDiNTaKk4BhayvShJZh6T6ZXv7gbMvcAO2z6P/BIPcRBpH71JNkQFQeMX6lhPC7TfkpWYuWM+osjJrj3DGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151211; c=relaxed/simple;
	bh=B7Dys0O6nBI1SpNWYBQ9IszCBqiZCkRXAY8GXR39t74=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lX4sQnlgwIW9KdYNbAlpkFxSGGWd2IMcEsfwzXJTbwSOLDdLZKs6zjgbK6yhz4gR7pZKEtZ7FhyaTL4+McdoHjK2a9Vcvd9JrrgFTvv5cRmbBezA1NduhTS3TpKW47Vi/9s5ljgar82WEF+sy7y/HC/dCtk55117LS+KTirgsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEQ1VRQg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29555415c5fso21413965ad.1
        for <linux-pci@vger.kernel.org>; Sun, 02 Nov 2025 22:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762151209; x=1762756009; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9n+VOC446iMLGSUtF1aVw7jOFyi8anlj6U7DHCW/jPs=;
        b=JEQ1VRQgupn1NMpuLRdeBoTi+6q8d6VjoGKYTxh551g1dX+HOS+Nwq8iJC2yaRE2EY
         DGKX7qZF+RfvJyA4EG2ib9iwQfoCJLVqZBlpHsJ6XT0ZzZwUN/gaCdtTtFoEonsF5Xtr
         j//ayLA5yiZ9cJegS75rrtOc6NWsfkxSj/2jzHYXgEzXUoGsvXS5O/ION6q6+bppAt7W
         VXrmNpV8dlXnsUMj8DMX1b9R8kmo3CndXEXnmebX2zXTvVtP+0Ro1U2hZXyFmMGylIx9
         VT2C/RLI5VSyQBhrheNC0eXA4D1jphQUx59EjohNe+gVTznPRxl5O5i61ZnnMzuWFx3A
         HQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762151209; x=1762756009;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9n+VOC446iMLGSUtF1aVw7jOFyi8anlj6U7DHCW/jPs=;
        b=SJ4bwuxrELbv/kvzEgj3FQkoTUItbWnXAs+bqk28IqP0wSgvqr/YuVaOKJVyMZs8XQ
         xr7AbwX42DfBrKY1aT1AbwHrDciyt8zdsLlu3Zua84kvXMvDWerV53LKMVaHRkgs2WuV
         L9WysY9BQ8xkgsgR1w07cvsaTNUMd5P8wc2zy5m/XjVnI6vnduUtnNW/tHZW16t0bWPO
         k8WRHK9bXC3y5ZT1jfIPL1p7xQRN7zrDVQfqME8qmHxD9NCl5Ma82a40h5hsqGI3cwNq
         w/UBHyWcZHS01Xwi0/vz6ozLAJ+rBCA0eXbpND4H5vz0qSpSiAfhj1XAPoMEct2YqpYV
         fuJg==
X-Forwarded-Encrypted: i=1; AJvYcCWL30KqCE7Z+OaQaJqOfxaqb/8U1epneWXZdy7M1unyR4vBybPZe99+ZKntHLM39mK7V/tK9DrdkQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW+E3q41crAEyqluWYPfRUgmWZk/pOQqtXwy6CXSF5oPRccnxJ
	V+HtVppnEiYxSSF13PDld0D/LsWKkZaMPSo0zOqdBtaS0MZHRQt0HqhS
X-Gm-Gg: ASbGncvLSJYpCSRGDYVhXH9yaZ+2f79nY3QyjxkiLO8dNwx4z9YXUvRkqBzt9DZPzkh
	3srwE99viPJo0EjkwcUYdCJNzCLfP2wRdVUNfZDdZEjSWYMj755nJbBGeeTNrS0LxIPZl+f4ZC1
	qUuLuaG0jHvC788qTjitEttEEVUwnvW1LvqcYYEo/3wJHCI+6naKSlVDLeOag09RauOSwIitSDo
	RzNMqsNdHT8OUC1c3h5jMiUOUDJH8xAQ594iFyQPjfn40/Gl6QqMP2I8WN9S9fzcu1AOdP4lD7l
	Bi7O1opLcBmp76bcZ8W1OCcDgtmyBEdZmny1IRWo+LbIdHYGbJyur8OgbrurVNimjb9tKxmD9Bd
	oJpZKe4LPioM2wUmCgwYhrd44jgkeY+Z40mku/XqDSituceiVLUs0gaHeflWIsEA4YNgseMaWJA
	==
X-Google-Smtp-Source: AGHT+IHE85ZAE05MQ29tDiEe73xuX9q1kSirWYaSnQbdQ95U62fo8gMJxYb1mTHJbA73o23JvHBMaw==
X-Received: by 2002:a17:902:f705:b0:26c:2e56:ec27 with SMTP id d9443c01a7336-2951a3d5107mr152483975ad.19.1762151208773;
        Sun, 02 Nov 2025 22:26:48 -0800 (PST)
Received: from geday ([2804:7f2:800b:fff9::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699b603sm107777285ad.79.2025.11.02.22.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 22:26:48 -0800 (PST)
Date: Mon, 3 Nov 2025 03:26:35 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Geraldo Nascimento <geraldogabriel@gmail.com>
Subject: [RFC PATCH 0/2] PCI: rockchip-host: support quirky devices
Message-ID: <cover.1762150971.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With these two changes I'm able to work with a Samsung PM981a OEM SSD
that is known to be not-working with Rockchip-IP PCIe.

Previously I attempted a contrived solution that mostly worked for my
simple purposes but was rather inelegant and impractical.

Now I have isolated the behavior to the three lines in the two commits.
Omit those three lines and you get a working set with the kernel.

I have no idea how to actually implement this in a way that makes sense
and doesn't break the PCIe spec but it is my sincere wish that
interested RK3399 parties test the change and report any regressions
with already-working devices and specifically, successes or failures of
initial link-training with these changes.

Geraldo Nascimento (2):
  arm64: dts: rockchip: drop PCIe 3v3 always-on/boot-on
  PCI: rockchip-host: drop wait on PERST# toggle

 arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi | 2 --
 drivers/pci/controller/pcie-rockchip-host.c           | 1 -
 2 files changed, 3 deletions(-)

-- 
2.49.0



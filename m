Return-Path: <linux-pci+bounces-39438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41F0C0EC78
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 16:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA0A3BDA6C
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F24230C619;
	Mon, 27 Oct 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2IonNmH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53A430C60B
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576974; cv=none; b=f1Qe122BxU/+NEuLvRsC5q072l8yX61jTZish9WApVMkHjXyHxPj01It40lV66DpUMhXnjFNHPG/sK058LtGAkK76CUgUgdl19fRwYYPTOWc4Zilq4JMCOlik+Qc+/yjfUmKUp1Ja/yDzF+Hp0hxP/+SnUYbLN1R5XhW/z8Rm1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576974; c=relaxed/simple;
	bh=JQ2Eg/fxzgQwaU0erBgyehxjwvhanKuWBXC39MUZvkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ss6bXrkNsgvWchwmZwYuYhn166+7rIZzcB4DMLfiqfQE0/Gi7lXoxLzrWPS0zv2iLfl+zjQAjika+IRhB3shDaY9kK55xGLXCvteTgeLwouk9dQ9/+BTqANzHNQ/Z8HMIOJPJqWA5bXt1NdmQ4RGXkEPYR1QFC30QNZnauuQzOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2IonNmH; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-780fc3b181aso2951051b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761576970; x=1762181770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8yVMi7V8qTRELGGfV+IcZ9w9BuBp+eY7s7IocvDD4Ig=;
        b=e2IonNmHnm5w6HS+St6D0v35hy7/3yisM8VKUesngmTpdBvpCdCFcV3p52Z0I0Ouam
         USsY9KfytMQ3SV+KK3J/HoGllCTEtT8NBEUaDiY2tw+MaEMhSFkngOejGidqgRWX6a/o
         ZefxMXngBMVtsxPu+W6fBZhnnzBxAndZ+NrmKsoefM7PlzfCXdaRCyg5UiIxddFS/zYO
         f91ppe0YhGMdK8m6IzGwULhtlQldiPRbNFK6z1f5JpC5Ts/E0RAWoh3LT8NhVLSn6Ume
         YHgdSKEKv3HPK2dxLwh4dpdL7tyScNxdN28q9BP+8I9vF0rLPHcid08iLXnEEKZR+mZt
         hslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761576970; x=1762181770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yVMi7V8qTRELGGfV+IcZ9w9BuBp+eY7s7IocvDD4Ig=;
        b=j3+5I6BTQ9enhU8728rET6It0gp3WmC0Lc+g7sSWSLZnrb/yzE1+Ug29AQY7Wg8wrq
         DZ+LleSP6rcEU+8BQn3Hk+VZxbrghFFGAE8k54Mx3GKqzcbuzAY44YsZTz7+2dOgj/9X
         2yQZUtFMcQ+BQTO0QiccjkeQcmobIKmoc31RFO+fOpfNmDWD3tMumhxNJGmiGjt47lsZ
         yUgvH0w/8MQyNJPmhTVHhivwDTDToKtaIdrJvm+S85SRI8q0vjPG2Bcq5CYbwhsqkmO5
         ofkP3KgaDG1xnUhEwDyDIL4jFGOZxezPStbB0K/ZX3rmxPVR0DIGXkyp+Gn6pFq82bpf
         Lksg==
X-Forwarded-Encrypted: i=1; AJvYcCXmNcJ58uIIOqv6NYPtDCOBYPkXp9aFxV+Dql/JPnJng9geeN0oZAo7X73VWAJZ0BiP43OVNp7vxuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDaWDTpf6GMje2v4Yr1ZXB3htVsC7+JGdDxYTY/C4lEtQhEiHK
	8v04JbiP8CK+NmSTmgS7PJt3Td12LEe4/8BQnPFRBrD0NlxF9hwPn5dp
X-Gm-Gg: ASbGncvyIlqhmo0nqAlMyXUD0FS9/DCs9C6Da7rHcb7qU7Rul5cGdxTmv4Shbwg31fr
	Jw0Y7dMgyV4JxlIegryyBtwC5hqWvH0HaTc3VBA9sBBgmV5BVEHEACi1aNJp/Pi/eYuxt9Sihmu
	3hvOClWwR4aC/ftmgVtEtKfadwja2leUWxwTEXRoBBDw1h/oEw8+8LSlweZIRwsicuuhXjqfd5P
	+uW83OZ8w6uQK0XPLgARlL6Nhezn0gO4ct3U85YEWUKZ3b6HOrtnGTUjyqYMVQ3OREqlWaXBss4
	6fx0w8PZxKrkm+QfZC8OBHaN01B1RrniA+LBk1qxr+aIC51AFL+yUIxzrYqu4rzIfcJvhAYqz2N
	dlMtle/MWOmh4WGyjM5P9jOjpGKzwJmkUAxoALm+qCarkQuO7KmePjXH2Z7iwg7v4cJhehMjW+c
	WeWEbKxg6ub8SpHVpE03g=
X-Google-Smtp-Source: AGHT+IFNNRsqOAD0ej4MkP02YIZHAarj1O7wDlGaz+jF0eTKJU0nb26xxgTWECACFe3NIf0baZUBNA==
X-Received: by 2002:a05:6a00:c86:b0:77f:324a:6037 with SMTP id d2e1a72fcca58-7a441b7aa11mr318696b3a.7.1761576970098;
        Mon, 27 Oct 2025 07:56:10 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012b19sm8373372b3a.12.2025.10.27.07.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:56:09 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Hans Zhang <18255117159@163.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 0/2] Add runtime PM support to Rockchip DW PCIe driver
Date: Mon, 27 Oct 2025 20:25:28 +0530
Message-ID: <20251027145602.199154-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce runtime power management support in the Rockchip DesignWare PCIe
controller driver.  These changes allow the PCIe controller to suspend and
resume dynamically, improving power efficiency on supported platforms.

Can Patch 1 can be backpoted to stable? It helps clean shutdown of PCIe.

Clarification: the series is based on

git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
branch : controller/dw-rockchip

Thanks
-Anand

Anand Moon (2):
  PCI: dw-rockchip: Add remove callback for resource cleanup
  PCI: dw-rockchip: Add runtime PM support to Rockchip PCIe driver

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)


base-commit: 7ad31f88429369ada44710176e176256a2812c3f
-- 
2.50.1



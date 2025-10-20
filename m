Return-Path: <linux-pci+bounces-38724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 815DBBF0BF9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 13:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013EC188F103
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 11:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320772FAC17;
	Mon, 20 Oct 2025 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhEOgi5U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA792F83CB
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958703; cv=none; b=G7x5NjUY0v7ljSEF2hPN5NKMEFxfOfENfYTQYaK7GCOdAiFMwsbdQfb0H4ybkJz6ZWdoZkdkAxQgzhCprII6UUWWlsNvmnK+kqSvpRSavgdhh3KXcYqHso4tIHyw2a9+ylRV/1rWsG8gwpNHh8x96PsTyabYAEvmF3pUdDYRWAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958703; c=relaxed/simple;
	bh=/u/sHVZSfi2e7MdgOitq2zS+yVeC+SRdoWU5NFexqrU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Xy3rDPkE1ACCcd7ViimBEnmAB0+CxHZCbyF5JPXHcN8h4J3A++PY7WhLP4cUe3wbRDdxJqqCShccghLJIBbOrTuQKX0U7MwzkqonvRNUriLZlEhXNQvdKXfxBKb9RfO11EzmSR3m1H6exolGVFFBP52pBOk69ogoMlEmfmqmMkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhEOgi5U; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47117f92e32so25748475e9.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 04:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760958698; x=1761563498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1J6WMqH03oILDs2/tT5ntrxwega9iCwgysVz89dOfmY=;
        b=RhEOgi5UXsSU8vNyKz4oBwYPFx1Uzzzf9JTlFu2Dd88WadnggN+nWEI/T3+a3D6eLC
         d0GwMBepUd+UXj7RMdPkiRnX4EKTdsT9dWfKhmXemlBPqdRj5c92UYEC48OyYy89C7PY
         DkNxeN6uPpUX00JOG2niIt6fsxg5IOmXgL/7QX+J8k0NLZm14AYWNr9whKDyTH/csKuG
         Nvk3MQB8LR+f3XUGeKOKvDxWS3WoRb9u92JE+Q0A07o0MWWQsis3FquRfH6UjK6PrS45
         GYkMEiHdhr0A4Fs4trwPxn7LfErpW69Er5PA13bURCu4Mnb7ICobaqdb8fHZZ8Fwv8QF
         fSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958698; x=1761563498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J6WMqH03oILDs2/tT5ntrxwega9iCwgysVz89dOfmY=;
        b=N2tD3dtw2cTJSjLnJ0exwCMg7UCWysjMOJIghPvzTODz11IncECVyMhDBHR3yPRt2E
         8FN7TForo7I9g1ucl8YD7PMIRnTnBa+H9WAY2I4NYpnQB3ZehLtIxbyhq4LlXpmxzHog
         XyXCllY0XL10HD8s8YOtxtQazWWfxPBy0f2z4hM8ZDnYX/CGTdYuw1iVhb3QqLhohiCp
         spcrESzWkENEBPBaO2n6UPVSTi137Z0gGOmM7uJk1fPTKqcKJ5wIik1lWvPGJ/JF5sjQ
         ucOmBE2TCeDwJ1pwPSEi+1SBTG/xfTahiVkoZxS6BiaOLcoDdVJFlYtSpi/GrxhwDodU
         CPQA==
X-Forwarded-Encrypted: i=1; AJvYcCXdqkOovSGWF3/ajzphY+zksXzOfs0MFzluwHXOy3VYg7n3FhEecgZy1wceC1f0qe7oeEe/NX8PNLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrTHrjWCG158WxdiWNlu09NNG/BdXmmdzHE23xegt0H4fOr+3N
	18fYPx3frjibaUH18Zr3I3KKCjV3ykhG/Zi9zQZuOw+QdQb+/pFwPrQn
X-Gm-Gg: ASbGncvCSNlxHmdynYBC8HDJc8PV0toq8ZxkfB9nfyO1AcsuWLBAIc1ESXqqpo66CX1
	kV8nHxf4VW4aujRkkjjbXhSfenpouZa83agsV19TkETIrUdSqcQ7an6l9KhMKbbHVfWvVCtAVYW
	Rno4Z0yaOOZJCbKghQiQ6pfbYdPmjo0Z1qP6nVaQhCsWsUPwX2YiWrIM13EJwR0LUpNfnaz6aZk
	7sTcS95J3UtPFEWqkiICF+OlHFCxwrs+uynj5+f4luP4R0EysKky6wRpi0khBKdhVXqQtScij6S
	4a8qpJw6DSZgmNI2dnlbZp2NeUUn3qa/HRUa9IROgsEs3gL7iP90R3jyEoBvun2kHj9v6sYlVeX
	khSIZMP/cfOnKtHUnqKa9qpRNdSN3jTZHMkrhYftUeFs1XeUFuCqo2kigHHaKs1wdNu1NBHor+R
	yF77ufeXnhVYBYbhmhHctuH/xW4hcKdDWf2L14bBFb1/0=
X-Google-Smtp-Source: AGHT+IHVbG6TZHa2zycGcNFH3hDK5XZiaq2XHp38I80LU/N8i2ztgAzL/k/rCSUQlcdD5KrEG0KaOA==
X-Received: by 2002:a05:600c:3492:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-4711791cadfmr110884785e9.32.1760958697834;
        Mon, 20 Oct 2025 04:11:37 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4283e7804f4sm12692219f8f.10.2025.10.20.04.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:11:37 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v6 0/5] PCI: mediatek: add support AN7583 + YAML rework
Date: Mon, 20 Oct 2025 13:11:04 +0200
Message-ID: <20251020111121.31779-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This little series convert the PCIe GEN2 Documentation to YAML schema
and adds support for Airoha AN7583 GEN2 PCIe Controller.

Changes v6:
- Flags -> quirks
- Align commit title to previous titles
- Drop redundant comment for PCIE_T_PVPERL_MS
- Drop DT merged patch
- Add Review tag from Rob
Changes v5:
- Drop redudant entry from AN7583 patch
- Fix YAML error for AN7583 patch (sorry)
Changes v4:
- Additional fix/improvement for YAML conversion
- Add review tag
- Fix wording on hifsys patch
- Rework PCI driver to flags and improve PBus logic
Changes v3:
- Rework patch 1 to drop syscon compatible
Changes v2:
- Add cover letter
- Describe skip_pcie_rstb variable
- Fix hifsys schema (missing syscon)
- Address comments on the YAML schema for PCIe GEN2
- Keep alphabetical order for AN7583

Christian Marangi (5):
  dt-bindings: PCI: mediatek: Convert to YAML schema
  dt-bindings: PCI: mediatek: Add support for Airoha AN7583
  PCI: mediatek: Convert bool to single quirks entry and bitmap
  PCI: mediatek: Use generic MACRO for TPVPERL delay
  PCI: mediatek: Add support for Airoha AN7583 SoC

 .../bindings/pci/mediatek-pcie-mt7623.yaml    | 164 +++++++
 .../devicetree/bindings/pci/mediatek-pcie.txt | 289 ------------
 .../bindings/pci/mediatek-pcie.yaml           | 438 ++++++++++++++++++
 drivers/pci/controller/pcie-mediatek.c        | 113 +++--
 4 files changed, 683 insertions(+), 321 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-mt7623.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.yaml

-- 
2.51.0



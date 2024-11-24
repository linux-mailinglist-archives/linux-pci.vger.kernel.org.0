Return-Path: <linux-pci+bounces-17252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FBA9D6DCE
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 11:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE31B2811F9
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 10:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27B318BBAC;
	Sun, 24 Nov 2024 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b45hOxDa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593E2189B91
	for <linux-pci@vger.kernel.org>; Sun, 24 Nov 2024 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732445486; cv=none; b=itCei8GWHwmTxdFrgz941VRIhzTo+1y4XTUpPcYH0TYUn0/t+f2FnDawl74o4mjvtmZV29+zjFxOVf/8Cwr/iL9XJd9nVvduQvqIzgixctfuVmnlkbWueM2Y/CPZ9RVReB5BtInNqH6j+StB/Jle4eIyXK6EDsPtvktCX5HjMOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732445486; c=relaxed/simple;
	bh=LzTtR9qa6moX0vX247KB60BeSX5OHtAGxVPxJ2rbGXQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIX0QOzT74wqWGAvHaaaSuttaSU6UM0Z64leQ+TKs8NXhe8YmC9wp1f5GalNvdEki0FJ/k5ES0yEbJsIb+uckQG1hUMYzmNPpJzL+SrbwwnElc227pMyLHCqjw1lFp5zGDyWjn2W+9QWsasrva7CwAb1W/Bqjh1Hdo92N6L/xr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b45hOxDa; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5ceca0ec4e7so4273361a12.0
        for <linux-pci@vger.kernel.org>; Sun, 24 Nov 2024 02:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732445483; x=1733050283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLWrJEtQWYU6sIqTXuJPR1rYvX74a8T1Gz+AvMzyXx8=;
        b=b45hOxDa6W/vUKS/W03ZxuhBpSb2/j7psl1aMFcr3HH0tyKcInd/LC0UOVUcDkdjKy
         AEFOacCVWq4hJzz1DKMLCXk3RThKV3GOwPZbky9c+AbZHMC1KaRHxWPYxvi58L3+UzRx
         1XxMVuZbxzUNLp+DpFXuTs377c1iXWZFrmi6NELe5SW8Vwb5pRikRrxiI1cIwI+rgW5N
         XSbfIgzrPP9GMARl7nh+ihonfcsVzIPKXfdYofOcEamR1uXqYw85aw41RxUThpIjqa3R
         pdjuidAnaPORACKqfSvPPQrnQD7J+Vka6AJW7Shb22wOBBYIYnRxw+L6T3EpXj6ojiDU
         74Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732445483; x=1733050283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLWrJEtQWYU6sIqTXuJPR1rYvX74a8T1Gz+AvMzyXx8=;
        b=pO5A4fr0p0MoXOIPVHP0UnMLCvE8trSKVHaNPaNW0gdnh1h6ufG5AbA/umJVpePZBl
         5G90LAysoVoyWOwrsGMV2Tfhx+xJtQrVWlTJP1UYu/w9pUgqrcEEwF7G4lA1yznHTG/Y
         TMlD6OLhkhYsTEGfgrgvGt0BK5lqFyRTJiChupq66rwT4L4D35N7FAV33zDBVTv++yvA
         qUE47gq9veO0cWBEi5bgmNNnyfTUmAAG0w3yki0C2exlClucZSNGXs/r6B0f4iWeGYjO
         /8BBVXIhG1XEA8VdDOfJIBIpA09mLVb+aUonacSVToFWc7y/D0WETlp9fHE/kCMR/Fk2
         Vmow==
X-Forwarded-Encrypted: i=1; AJvYcCX+FO3RWgAFIUInfjgPKHZwWp6s2+ICJICeIDj5+pN+ujKP1L2KVGtrO2pnbPW4j9UsqAdWpBPGjds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4IYdz0h9411RxJD3+uaHyOjBspsqhyipxbcGJlKkxG1DrJ8Sv
	w25e2oTtvKrJ4ov4lLDGj3bvhpuYDj9HqIv+lUY0wE22frEAzcu5M//hnXayZN4=
X-Gm-Gg: ASbGncsRanVtRiRt4A98jCA1QUzhXYUNIR6sz6nUoJyzkyBrRcK8lCS9VasdaArsPvM
	Z8KNU5WCbWx5vOVvFxb5AXCHphBfquMqLMowEAwv32uh5IEQhsIT4TE9HNWc/Hpy2Df47GZCJEQ
	zmeuqiICwWou4ajqUC1n19puESUYdvQ4txma9yo1z7IeEnvI/3tJE2pOuEJOFIe6WU3DXLfRjGw
	9cnmbFGAmMTLp8u/wZ45AN/d6GrhnegmH+JCJEhzzaMxCcV0aEcbg1TkDgHo1DyPHBzp+42y679
	AYZj5dLtl3uq/4EXrlTE
X-Google-Smtp-Source: AGHT+IF4JCfJCHDj53U5kUX+yj6V0dQb3HAizgGoKIijou+8AljCrGAAKu5WC62xyaqw54638HdB5w==
X-Received: by 2002:a05:6402:4309:b0:5cf:ce86:60a8 with SMTP id 4fb4d7f45d1cf-5d020694058mr6611062a12.23.1732445482660;
        Sun, 24 Nov 2024 02:51:22 -0800 (PST)
Received: from localhost (host-79-49-220-127.retail.telecomitalia.it. [79.49.220.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa544df327bsm79696466b.19.2024.11.24.02.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 02:51:22 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v4 03/10] dt-bindings: pci: Add common schema for devices accessible through PCI BARs
Date: Sun, 24 Nov 2024 11:51:40 +0100
Message-ID: <dbbda55c7cbb14d3f5b269981a946f07b44ff835.1732444746.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1732444746.git.andrea.porta@suse.com>
References: <cover.1732444746.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Common YAML schema for devices that exports internal peripherals through
PCI BARs. The BARs are exposed as simple-buses through which the
peripherals can be accessed.

This is not intended to be used as a standalone binding, but should be
included by device specific bindings.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../devicetree/bindings/pci/pci-ep-bus.yaml   | 58 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-ep-bus.yaml

diff --git a/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml b/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
new file mode 100644
index 000000000000..33479a5b40c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/pci-ep-bus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Properties for PCI MFD EP with Peripherals Addressable from BARs
+
+maintainers:
+  - Andrea della Porta  <andrea.porta@suse.com>
+
+description:
+  Define a generic node representing a PCI endpoint which contains several sub-
+  peripherals. The peripherals can be accessed through one or more BARs.
+  This common schema is intended to be referenced from device tree bindings, and
+  does not represent a device tree binding by itself.
+
+properties:
+  '#address-cells':
+    const: 3
+
+  '#size-cells':
+    const: 2
+
+  ranges:
+    minItems: 1
+    maxItems: 6
+    items:
+      maxItems: 8
+      additionalItems: true
+      items:
+        - maximum: 5  # The BAR number
+        - const: 0
+        - const: 0
+
+patternProperties:
+  '^pci-ep-bus@[0-5]$':
+    type: object
+    description:
+      One node for each BAR used by peripherals contained in the PCI endpoint.
+      Each node represent a bus on which peripherals are connected.
+      This allows for some segmentation, e.g. one peripheral is accessible
+      through BAR0 and another through BAR1, and you don't want the two
+      peripherals to be able to act on the other BAR. Alternatively, when
+      different peripherals need to share BARs, you can define only one node
+      and use 'ranges' property to map all the used BARs.
+
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: simple-bus
+
+    required:
+      - compatible
+
+additionalProperties: true
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index c55d12550246..ccf123b805c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19384,6 +19384,7 @@ RASPBERRY PI RP1 PCI DRIVER
 M:	Andrea della Porta <andrea.porta@suse.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
+F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
 F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
 F:	include/dt-bindings/clock/rp1.h
 F:	include/dt-bindings/misc/rp1.h
-- 
2.35.3



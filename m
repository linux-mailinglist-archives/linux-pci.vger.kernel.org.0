Return-Path: <linux-pci+bounces-43320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE52CCD539
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 20:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6025E3029FEF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 19:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6F932E152;
	Thu, 18 Dec 2025 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bYiAIQjc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89D2DEA9B
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766084803; cv=none; b=pHka4kWlcj4+0dFQIuQGF7z1/Gic7TVCvm61YB8C8fhT48Dy4JF+EHQK7BQ24E8apeznuPA07Jw3clqRiPhPzO0I/txPADznfJtd3Llf50IrWIh95UBuTFUnqSFawtQJRFRfYGu8v5mpnpfVsk4GOpC2jYVshJ6MYejAgUMGFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766084803; c=relaxed/simple;
	bh=WEloQA/XIFfWLUJFGSkNRutlWTf+KyY3iz9RK9E79CE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NaY3wvS+ttmUT6AYaTX/RColzDYFE9mivdcdgtWlMoIApapmQlzzSUd+bBbo/8peswzPbBvfEFQymX77/givgVs0mDaFrTea8zYI0FY0unkgyxC53qIkzsSX1PAIGVteUHdi0ISR4wuCKCaJ7sAwuUWb81bqHDaRVZxaVHBg6mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bYiAIQjc; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b791b5584so1120113a12.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 11:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766084799; x=1766689599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KZxHqu3SzujmiotRlzxJm3UYnzflG11IekQhIfmml9I=;
        b=bYiAIQjcpQ1P7CpNuSphu34YonpaInJhvMH4zNG/Ju2wfcsWOq1om3ZEGsIQsRppd5
         0ef40PPMwlk+gYxR3Hnb2SwHG2hOi3TN6J2JbgtK82RXTuG+ABLidN/jSJSMuWX+LSG+
         xoPkxaPqve+RfiQ0DSfwSGK0Nfz8Ie85I90kUGM3YByfeF/ldylbnybhsoqDF+8u973v
         YKm8+8g0TTLhnOdtvaYQPaMUoHwnwZrUlqU59yZE2L2wmvjfhcp/k5z2rODjQeL7anOe
         +gjzgC4HAsUJuHT46aDvTjAfirDLmOcmjK/kZVQbG61YBTtVJgDpQpTGaIGED4vo0wRG
         hB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766084799; x=1766689599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZxHqu3SzujmiotRlzxJm3UYnzflG11IekQhIfmml9I=;
        b=TeK2LvB3TyffDNu4DfnW2NLku6TkawXs1q1Q8YwRyc26BFpTc0agNrWZLzmwBo4C3b
         msOUpUTTtPlogSrSb1OMz6vENtL67VgAc6tOIM5cljjGGwNwNScdvyZnd18Qixj+uhmn
         GEx/ixC3RmqL+siCmnxxVfKIQST6fauaV2iwlF1Z8URPLmaao0bO+35YlMMFRmD+Y2PX
         HZsd16xJwD+tdUUi6gmMUFmqgV8IufU4Q7wKkQ22AjcbSzIsWza2XGnvEha2fOf15mz3
         YTUK9QIOm2DCFZwOvPJSJtlxXLnh9jJ6jObD9apq8KB/4WMICsH2ZVHFyNNwdDQ/Gs8H
         kIGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBGyZwY/KiKUsZZE3VQZFo96jvxRqQMpYFhGoDzWKcTX7r9j8W3EyT+rRxKJCyNjkpuIhrt/CEHK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxszmMrp/A+dJtujsXYdEmINWHT31hZbIos7k/p++anB3qK5e72
	s1xSpp0DG35kEhY79t+1sHOGLN8ULn+9JyVMduONIn41JoMCSn0bTo3I1SXbuZ27ArU=
X-Gm-Gg: AY/fxX6ijYOvbTJA7Ch6wqShPeUrucr/z0hpv/UsMU7W0uViBKiLoSK7XMDcux+D3W0
	B0HWoiwJdYFtAGChlxEVQhAuQMgIHBqOX1F5Zof7slYrHPpxuD7lCs7OgzYzz8WjMwQRGyAam9N
	e0DrAcGQnecumyIrUzOwidS9YjHnUTdAjE8wHD8IeTKo7iNxt+KvGIQVVbKygpjJXA7nEpp8VA+
	aThA/H0wezRl6XjJBBjiyVnVHwuSkb3KVllTs6Srag+4vOKsqcRHfXskgTKyPr9mfQ4Qb91EdPI
	aRh+8SH9hPli5i25FdJDU+mXNuVM6f7PIO0gdvXpMXZJ50LKuoHT/5gAcH6JFQ2ABbCKl4r7cip
	LJKcw7mE64FP+hAzHZqVbmjV2Su8r9TOBVq/dL8S0hhEJyOaP4yb70LgrhNMebguajLX6KtcDcM
	APbYYw1hFyOxYtKA9VrRuqEOSviDnXWWwStA5DC4HdR+j/DST1OZ1mWw==
X-Google-Smtp-Source: AGHT+IHWG4LHoKaiiruOEBctdxAHnsbItZY+jg4X40WE9oC/dX/aDtGLSsf4UY9Cm0B4WQZVSPvMPw==
X-Received: by 2002:a05:6402:40c9:b0:649:8be7:eda with SMTP id 4fb4d7f45d1cf-64b8e94d0demr435503a12.8.1766084799432;
        Thu, 18 Dec 2025 11:06:39 -0800 (PST)
Received: from localhost (host-79-37-15-246.retail.telecomitalia.it. [79.37.15.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91056731sm173599a12.8.2025.12.18.11.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 11:06:38 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH 0/4] Fix RP1 DeviceTree hierarchy and drop overlay support
Date: Thu, 18 Dec 2025 20:09:05 +0100
Message-ID: <cover.1766077285.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current RP1 implementation is plagued by several issues, as follows:

- the node name for RP1 is too specific and should be generic instead
  (see [1]).

- the fully defined DTS has its PCI hierarchy wrongly described. There
  should be a PCI root port between the root complex and the endpoint
  (see [1]).

- since CONFIG_PCI_DYNAMIC_OF_NODES can be dropped in the future
  becoming an automatically enabled feature, it would be wise to not
  depend on it (see [2]).

- overlay support has led to a lot of confusion. It's not really usable 
  right now and users are not even used to it (see [3]).

This patch aims at solving the aforementioned problems by amending the
PCI topology as follows:

  ...
  pcie@1000120000 {
    ...

    pci@0,0 {
      device_type = "pci";
      reg = <0x00 0x00 0x00 0x00 0x00>;
      ...

      dev@0,0 {
        compatible = "pci1de4,1";
        reg = <0x10000 0x00 0x00 0x00 0x00>;
        ...

        pci-ep-bus@1 {
          compatible = "simple-bus";
          ...

          /* peripherals child nodes */
        }; 
      }; 
    }; 
  }; 

The reg property is important since it permits the binding the OF
device_node structure to the pci_dev, encoding the BDF in the upper
portion of the address.

This patch also drops the overlay support in favor of the fully
described DT while streamlining it as a result.

Links:
[1] - https://lore.kernel.org/all/aTvz_OeVnciiqATz@apocalypse/
[2] - https://lore.kernel.org/all/CAL_JsqJUzB71QdMcxJtNZ7raoPcK+SfTh7EVzGmk=syo8xLKQw@mail.gmail.com/
[3] - https://lore.kernel.org/all/CAL_JsqJUzB71QdMcxJtNZ7raoPcK+SfTh7EVzGmk=syo8xLKQw@mail.gmail.com/

Andrea della Porta (4):
  dt-bindings: misc: pci1de4,1: add required reg property for endpoint
  misc: rp1: drop overlay support
  arm64: dts: broadcom: bcm2712: fix RP1 endpoint PCI topology
  arm64: dts: broadcom: rp1: drop RP1 overlay

 .../devicetree/bindings/misc/pci1de4,1.yaml   |  8 +++-
 arch/arm64/boot/dts/broadcom/Makefile         |  4 +-
 ...-ovl-rp1.dts => bcm2712-rpi-5-b-base.dtsi} |  0
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     | 39 ++++++++++++-------
 arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi   | 14 -------
 arch/arm64/boot/dts/broadcom/rp1.dtso         | 11 ------
 drivers/misc/rp1/Kconfig                      |  6 +--
 drivers/misc/rp1/Makefile                     |  3 +-
 drivers/misc/rp1/rp1-pci.dtso                 | 25 ------------
 drivers/misc/rp1/rp1_pci.c                    | 37 ++----------------
 drivers/pci/quirks.c                          |  1 -
 11 files changed, 40 insertions(+), 108 deletions(-)
 rename arch/arm64/boot/dts/broadcom/{bcm2712-rpi-5-b-ovl-rp1.dts => bcm2712-rpi-5-b-base.dtsi} (100%)
 delete mode 100644 arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi
 delete mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso
 delete mode 100644 drivers/misc/rp1/rp1-pci.dtso

-- 
2.35.3



Return-Path: <linux-pci+bounces-33409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05165B1AC6B
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 04:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188D617F5DA
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 02:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B65199FD0;
	Tue,  5 Aug 2025 02:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="xXwANU0q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1802.securemx.jp [210.130.202.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B40179BD;
	Tue,  5 Aug 2025 02:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754360988; cv=none; b=nkSHGpX0X6iFVVqtx+QlJ1NrWQiWliXx7Ol+hI4kll6KmjnbVLAp+zPGM0fByGT0ZlUPgsFfNE5NuGH5vu24XX5kWyc2f23ygzEHQOW9yQLWY6fug4JCx2x5Ss6tU5pexObK062rDkCcCCkeoMlG3zBPpm75qP/zTN3zsCmkgGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754360988; c=relaxed/simple;
	bh=LcLx+c1Ziwph8MToNFr2L5doRdPKNx1LR2gU7L9kP3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ptCc61EFWOnlJ1ixf4PeaCJEeQOOfWDlSnTBwYfTXgEZyoiLk5b+hr7qBzZsFBcM47OwDWznw7R76ozylIMbQyWXqEnadZVVHCBFVb/TsF+EmHBBz+IQ63akvE59H3sgj+ZCzO9WDeRFgVjzqfVhK6BBtAOqP4Wc3ClFMtAVKds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=xXwANU0q; arc=none smtp.client-ip=210.130.202.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1802) id 5751liSR2855604; Tue, 5 Aug 2025 10:47:44 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1754358430;x=1755568030;bh=Lc
	Lx+c1Ziwph8MToNFr2L5doRdPKNx1LR2gU7L9kP3Q=;b=xXwANU0qR3w75pq4r+CVyOr1lEuaQsZc
	m+RVN1T8bjUVII+BrJSoeITEnKG4I0p5QZqfa/XSqVyi80LNcJSxW5jicbHGr0+3wJ4BUm1x2rRUy
	kOCBWmZgzZtt8f09GEciAzsx1ZsZLR277C2jSyBYlOmElNg0oDdGKmBeIDtK78vFZrUZmM0v6bYui
	A5L8HQ547aY93kRDGdXrSKMdwKepPxJpIhvC3+vj+BqPI/BgR51GYuxIb65Aa2Xt27S8thUyff+yg
	Kqh9cbb9Q3WKaKh0ZNcuI34W94MfEHeDws6bxk34ClA5AqyU6aGR9/mJuntoUiOZDPONi6FmV9DnP
	gQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5751l8oK3492421; Tue, 5 Aug 2025 10:47:08 +0900
X-Iguazu-Qid: 2yAb5t3M3LwiUKK6XA
X-Iguazu-QSIG: v=2; s=0; t=1754358428; q=2yAb5t3M3LwiUKK6XA; m=sRYnrJ4AKvupUhpvGfMA/J8gq0uBVaN6DEO0tu2N3Bc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 5751l74Z3322505
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 5 Aug 2025 10:47:07 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        yuji2.ishikawa@toshiba.co.jp,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v2 0/2] pci: clean up cpu_addr_fixup() for visconti
Date: Tue,  5 Aug 2025 10:46:59 +0900
X-TSB-HOP2: ON
Message-Id: <1754358421-12578-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since
7db02f725df44 PCI: dwc: Use devicetree 'reg[config]' to derive CPU -> ATU addr offset

dwc common code have handled address translate by bus fabric.

1. Correct dts
2. remove cpu_addr_fixup()

dts change need be merge firstly.

Changes from v1:
  Update commit message.
  Fix range.
  Set true to use_parent_dt_ranges.
  move pcie under the dedicated sub-bus.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Frank Li (2):
  arm64: dts: toshiba: Update SoC and PCIe ranges to reflect hardware
    behavior
  PCI: dwc: visconti: Remove cpu_addr_fix() after DTS fix ranges

 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi  | 75 +++++++++++++---------
 drivers/pci/controller/dwc/pcie-visconti.c | 15 +----
 2 files changed, 47 insertions(+), 43 deletions(-)

-- 
2.49.0




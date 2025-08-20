Return-Path: <linux-pci+bounces-34377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA6EB2DB8E
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 13:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6CA164D7E
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 11:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F2D2E5414;
	Wed, 20 Aug 2025 11:47:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ABE2E6127
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690441; cv=none; b=XVKLPkSfehBlaATqb5RtCX+18cUoUQdyFqY1fMVZJY5k0enk2T+LE9zE91D/uteeshu+XcIy+iQY3YEbl+1R5dPh0qsaxKWVX6T/375PYOXiK3rXUHiGDB3Y08pMZJqFT+EUagQMpOEro1iKTDF3ttQlvRouO04BTZYrt/qxiuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690441; c=relaxed/simple;
	bh=isAlfiPFc1m6hdiuAYMbk9EbJ1vVtW8lZkAtwOmmbjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fN7xzXlJeTZaxiGEUFKEL5y7FwHUd8gtd77JVbScJV29PTjNpjYpx6LUMek1hpJE89NnhDo61nB9C2AhSVDtzN0bJjySq3T1fPW1Wjd65lIakfpQ2o5wlqyCBomDGl4tRTe/97nNlTWlQJCeIvg0NBP7eI/5cQ3YyYcauHzRoxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 57KBJ8tP019008
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 19:19:08 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 57KBIqmP018797
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 19:18:52 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Wed, 20 Aug 2025
 19:18:52 +0800
From: Randolph Lin <randolph@andestech.com>
To: <linux-pci@vger.kernel.org>
CC: <ben717@andestech.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
        <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <bhelgaas@google.com>,
        <randolph.sklin@gmail.com>, <tim609@andestech.com>,
        Randolph Lin <randolph@andestech.com>
Subject: [PATCH 1/6] riscv: dts: andes: Define dma-ranges for coherent port
Date: Wed, 20 Aug 2025 19:18:38 +0800
Message-ID: <20250820111843.811481-2-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820111843.811481-1-randolph@andestech.com>
References: <20250820111843.811481-1-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 57KBJ8tP019008

Specify the dma-ranges property to map the coherent port
address space from 0x400000000 to 0x4400000000, ensuring
proper DMA address translation for devices under this port.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 arch/riscv/boot/dts/andes/qilai.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/andes/qilai.dtsi b/arch/riscv/boot/dts/andes/qilai.dtsi
index de3de32f8c39..d78d57b3bc52 100644
--- a/arch/riscv/boot/dts/andes/qilai.dtsi
+++ b/arch/riscv/boot/dts/andes/qilai.dtsi
@@ -126,6 +126,7 @@ soc {
 		interrupt-parent = <&plic>;
 		#address-cells = <2>;
 		#size-cells = <2>;
+		dma-ranges = <0x44 0x00000000 0x4 0x00000000 0x4 0x00000000>;
 
 		plmt: timer@100000 {
 			compatible = "andestech,qilai-plmt", "andestech,plmt0";
-- 
2.34.1



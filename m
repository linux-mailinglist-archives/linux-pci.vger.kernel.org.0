Return-Path: <linux-pci+bounces-34962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80007B3919E
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 04:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7F71BA50B3
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 02:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25EF24678E;
	Thu, 28 Aug 2025 02:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EphEOE94"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D341DD9D3;
	Thu, 28 Aug 2025 02:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756347511; cv=none; b=gEytCX9DrJzy7hltsmiNAtQXfDeFxaAUEkQM0OyS3T7a7k+pd15JLDK3S6oLv440rcYd0BA5Chz2Wnhkx37OSF/OHbaYQvLeayv7JhJNUOk8wjau02wGWZ6xUIulRcyQy1CGaK1UUtfgc/K8F3Tt4GwWpnQT0VFyjojbH+VYGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756347511; c=relaxed/simple;
	bh=2/X0kqXymzl0rSIfFuIwI8HKliLYoWUEKgTpcTzr93w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AcZ8fRL8+ebzpXlCNT8quS0j+JmESJv/3h9o+8BatJMdwlK2D+T6+b7oyc41OwjOXHXRehlc3Vm2+3tJle01bKQy2knYRkEdblMeJ8HnkjsWIF/vGGZhtz1b3LoVlB2KEKFjSekeeMGSgJ+2TzYIsDLGgH2I4/VOaAVFSOKnf1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EphEOE94; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-61bf9ef4cc0so334674eaf.0;
        Wed, 27 Aug 2025 19:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756347509; x=1756952309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0G0wcA4QwYMRGmntWmLFL5l/S4VJ8/gFReFfYA7/kyM=;
        b=EphEOE94Ei+VcQoHTvtSgz8bGwMLj/5sS+caKF7Lmq5u2vc+8OVeLnqDpCN7SknmDg
         IgGQujZV9Mh1OiYRJ2w8FMqqG1aabx0tXafofPgoFU/E/fY1EANoycPnBhQHojvvHy0l
         LyP0nCuS2lZ81R6A7fNaTT2bqzdW7sNqzJdx/tji4xt+bgkDaBZBYiNBhmKwbEhcZZQz
         DTgtsFRDBFismEZOuxrNk87ZoIN0aNew61uLwVKXKtK2M1+AVMiYhvHE0yYQjq6HlVhX
         kMkWz9cxAxLQdhkWjHrUc9ULIlUEyDa1yh31zpwecGaqcGWQc4+oUDiNrUtj3sjM2lcQ
         ZIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756347509; x=1756952309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0G0wcA4QwYMRGmntWmLFL5l/S4VJ8/gFReFfYA7/kyM=;
        b=aCJc+v0ql/hZ3BXN22lG6ACGIwpyjT8a6x5jNGnQeq28sgQ8A0Zkgg5wYSQuEWhLbh
         epv5mKrRak3gSBf3vmDB9tPXxxDkYUlQ22gdVbqtLIVs8DXwTaR1JGdyzg5GIgxLCjzW
         RKbgTUNaGhEFQdOOgjYhkCxNMVNCTqkXvJEAx+QCaF7cXBAmkypGC/Tr7SJKSq3o96nP
         VT5A0LNOvbU4YCd3UF0V3pnfR7p6O62h9u8ygUffuP53QvUWa2hoeSaL3TlOhi/LShjg
         tcDpkddK5ijvOkOXTBhd0eDx70cRG1JcAy2J8yyr4mh/biw6OxG+l1oRTcTpInT6M6Ce
         C3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKYY6EdnwRnPggQTzuKWkMR4EP73/+uE1EnPObzG/XowIUbibzNoNwUH9HulolZRmSfx+GNNtmQbPE@vger.kernel.org, AJvYcCWeOshQ1o9h0hds0TJD0uVwV6wYbI79et3qZKr/z7ImDeBPSx3UOriZOW/EsT0ziHfu9q3JekjHsh+npOt6@vger.kernel.org, AJvYcCX3OhYoQPWUbgaqqdIUPVQuQpBPnE5XVfGQ3w6B0BC8xQ75cRPFVbzivI94BmTXS3sp+tZ4xYNKLM7w@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+AxZmkBtD/aWtvbjuObs69hWlJ1Z3/XqMzHMy0Sk/4J38t8q0
	k5kXeGHWAqjeYNQvazICO5dGrrUOMnvHvN3pIZMz1MHU8W3OtGWr1Su1
X-Gm-Gg: ASbGncsDbxsiR/x6yHQF+6qGenHDZPvnkkcCVr13R/UyPnOcLhgeR+1xr9V5Zh1zzfg
	b13/fVlbu3fjLOtZwtIFWY23KnIfCZU4VPrjiB13vJBVrg/JAR2Ivz/FgSyxU8s/d1mT83S/ZQC
	hwkSyClQ4tNVqREFAhNF5eBLw14zzWoGSI/JU6SMCxtbMYodaBRz/7O33NvR7d+ynnb6PhZUO6M
	UHdpjYRF5QgLr6t79Ue4NpwQ9GFFVEtACCOj4zgJVpwvdZJO46f/OwAeWmuk+0KayMi3r7CyPb6
	LnHly7kGt9zjhrkNYxpZGMcMr3UgUiF2TZKM4KSFOp4zLrDCjs/DgdE8emO/yaLKHiBNONgE63R
	56z7Xc7UZglCIpvWuJPdEXpuvf2r6TALg3hQHzqOxtE4=
X-Google-Smtp-Source: AGHT+IF/5cS+VdOAcxsOTaHXrHFbinFo1G+/jQXnldj08eaTRkfdS8GuJweSxJytLqtORzEjgcBxBQ==
X-Received: by 2002:a05:6808:690c:b0:40c:f220:67fd with SMTP id 5614622812f47-43785196da3mr10882798b6e.9.1756347509153;
        Wed, 27 Aug 2025 19:18:29 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e297684sm3494054a34.19.2025.08.27.19.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 19:18:28 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: kwilczynski@kernel.org,
	u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	arnd@arndb.de,
	bwawrzyn@cisco.com,
	bhelgaas@google.com,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	18255117159@163.com,
	inochiama@gmail.com,
	kishon@kernel.org,
	krzk+dt@kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	s-vadapalli@ti.com,
	tglx@linutronix.de,
	thomas.richard@bootlin.com,
	sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	rabenda.cn@gmail.com,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: [PATCH 5/5] riscv: sophgo: dts: enable pcie for PioneerBox
Date: Thu, 28 Aug 2025 10:18:21 +0800
Message-Id: <3c2fef69e80a3e4dde47a9449b49f679211a0c2e.1756344464.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756344464.git.unicorn_wang@outlook.com>
References: <cover.1756344464.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Enable pcie controllers for PioneerBox, which uses SG2042 SoC.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index ef3a602172b1..6574d8e0b369 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -128,6 +128,18 @@ uart0-rx-pins {
 	};
 };
 
+&pcie_rc0 {
+	status = "okay";
+};
+
+&pcie_rc1 {
+	status = "okay";
+};
+
+&pcie_rc2 {
+	status = "okay";
+};
+
 &sd {
 	pinctrl-0 = <&sd_cfg>;
 	pinctrl-names = "default";
-- 
2.34.1



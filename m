Return-Path: <linux-pci+bounces-22868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDB4A4E5C8
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 17:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD403A40CD
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D97A285405;
	Tue,  4 Mar 2025 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="BiUE35rv"
X-Original-To: linux-pci@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ADD28541E
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103591; cv=fail; b=mmdueI3e7eLKjxvE58R/sjXz/V5Ne7o+w9qejhZuVbyxkfhlgbbRO/FXBhTGfe7ngVvSZEQIRcdJOxIVQe+ValEfHvU/aDogA7g5lg0eRV6/m6ipuZgW5HQiC8Y/15l0WtVK6g8wgB2eC/O0+BpSJVduEbnmMRPJmYOvPT5oeYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103591; c=relaxed/simple;
	bh=R+rL1rMSl+Mj5hgNZeOvm1ty1+wrolZBgvMtTJv71Ok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qn/FMGQR8L7RM/ubb9ik60GlJDfrwRMWzxYMbnrL7Gaxik/c0dNJg3nmRFgrDOeRxKT8Og/VitarY2xzwmTmQlCbe3B0mzRrRuTbdGsn3q1nh5AJyDg18+wP6jsvINpzu6zkhxd6p7/ik/JQoTkhclbYxNV/LOb0yDqZBZwDLOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=BiUE35rv reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id E8A1440CEC94
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 18:53:07 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gCY6vxbzG1bq
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 18:51:37 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 4D28542722; Tue,  4 Mar 2025 18:51:21 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b=BiUE35rv
X-Envelope-From: <linux-kernel+bounces-541676-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b=BiUE35rv
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 998C6423C8
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:11:18 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 4E2F0305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:11:18 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7853116CF97
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0DB20E704;
	Mon,  3 Mar 2025 12:11:06 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C041F542A;
	Mon,  3 Mar 2025 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003863; cv=none; b=jJNJECSQlKAsksUGVSpbKByD61CC+0fV0Y3K3YACwoVuPJkDu9sqlYlIAdmfdQ9e9eai37yp1DUvk43VQZZn6/DB+DZ7UBbhOYjYBJrSD4U6UEhgN75mKzvJRyhEIFCTZa2AsH7NL1eUU05RCQu/pDSg0Crd8f5SrTyGrFe9am0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003863; c=relaxed/simple;
	bh=b7aImQFO+vv4AEKqKZKWMgzQwLwslHy4AIvR8oe7et8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oGROunNhUDgVHUXnHm1GpMJvMlweXNxzweyTB/iMTjlY0A5IT7FV5yhZooSXZ1oXqN65iFt5bRsnA9lDlUu+lJKuBclt2PQxBsazahNzIOsYvRCrumMEmhopXV9Cy5t9dvdCCQjYhsbiSkoKKJdlWBnmowEg+8/fGoOrVyQ2d0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BiUE35rv; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xGRwi
	//d5mFSgNiOHp/4i7d4yZJCrVYLvCULn3+cKsg=; b=BiUE35rvVON2Dk1gnLPCS
	Kfr3GJYbaGs4bh4Hk2QuuSdzwq7QOt8kwhzX1x9G1TfK5utYuyo5DRcoeGb+iJrA
	Ox/4SjEK6woFve2fGRhNkzUS62ypj1aqoWaYWe+044LS4Kc6Q1mQZI+t8NYj2VoJ
	Gwdh+kt+aUVORXHDAOlSrc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAH3eEinMVni5QpPQ--.16783S2;
	Mon, 03 Mar 2025 20:10:12 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: tglx@linutronix.de
Cc: manivannan.sadhasivam@linaro.org,
	kw@linux.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	Frank.Li@nxp.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [v4] genirq/msi: Add the address and data that show MSI/MSIX
Date: Mon,  3 Mar 2025 20:10:08 +0800
Message-Id: <20250303121008.309265-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:_____wAH3eEinMVni5QpPQ--.16783S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF45Ww1fKrWDtryDZF43ZFb_yoW5KrWkpF
	Z0kF47Wr43Jr1UWa1xC3W7u345Ka95tF4Uu3s3uw1fArWDKryvyF1vgFW29FyayFyUKw1U
	A3ZFgF1DuFyDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE1CJDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwwFo2fFm0wbuQAAsy
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gCY6vxbzG1bq
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708308.25067@oFjLcqZrd9fwy/elJ96GYw
X-ITU-MailScanner-SpamCheck: not spam

The debug_show() callback function is implemented in the MSI core code.
And assign it to the domain ops::debug_show() creation.

When debugging MSI-related hardware issues (e.g., interrupt delivery
failures), developers currently need to either:
1. Recompile kernel with dynamic debug for tracing msi_desc.
2. Manually read device registers through low-level tools.

Both approaches become challenging in production environments where
dynamic debugging is often disabled.

This patch proposes to expose MSI address_hi/address_lo and msg_data in
`/sys/kernel/debug/irq/irqs/<msi_irq_num>`. These fields are critical to:
- Verify if MSI configuration matches hardware programming
- Diagnose interrupt routing errors (e.g., mismatched destination ID)
- Validate remapping behavior in virtualized environments

The information is already maintained in msi_desc and irq_data structures=


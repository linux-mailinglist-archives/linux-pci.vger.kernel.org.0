Return-Path: <linux-pci+bounces-17010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77719D0719
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 00:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4811F21A47
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 23:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40801DE2BD;
	Sun, 17 Nov 2024 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sSe5B5HA"
X-Original-To: linux-pci@vger.kernel.org
Received: from sonic305-3.consmr.mail.bf2.yahoo.com (sonic305-3.consmr.mail.bf2.yahoo.com [74.6.133.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A81DE2A7
	for <linux-pci@vger.kernel.org>; Sun, 17 Nov 2024 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731887389; cv=none; b=hZP/pqSIpClPqVi/j/WQwEqt8bgOXBBz7JDZ5BVxKyPIbI5ABNtIvUad9TlhEKQ1zLu2O32eracjF79nN6kNfcysthv9Jx5ANR1hlsV13AWHxHVFXxmOGL+hC0mTosinJTvJj7dXBX01XFsNKQCg44cxpzMAtJ3YUdwwEOhI5Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731887389; c=relaxed/simple;
	bh=ndMRqcn+KKws7ilHoWeDQsHSfQSicttbOP5PIElctZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=l+Wn5QyjSf00HBSS+MGOIS/HUXyIFLIPz606zuUMEJAyd7m0iNuKgO583yWmWdTxYvGHemaMq1fQRSQbnhWtN3D+GgYmM6Z+99aSZgux0bw3bnpNMcXNDEAOQiEu72YaPzcTlRYT9jFG7p2P1CXTg3nNTlpfquMCVPtpTI+cGgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=sSe5B5HA; arc=none smtp.client-ip=74.6.133.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731887387; bh=xMP8ws5QZc+Aa/3fxPa9Sb2qMMeY8KOXEJOvoTPJWsw=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=sSe5B5HABxjlhCVjJiC0oc1sGFkY8YVmM5X1OOv0GtURAaMCCv6c/qh/y2QrNrN55NabVQwYINHTS4POXr4Cx7+vHjIQrDkTmh6wDdWSMl90dbDYet20DwedqOvkzH8Rr6cJVMNZX80F+gCC+XUx1VQ6ELROsjPHlJYWEIuaym0/k0dmqEfOyayTJ0u0IHip5a0ZSW3A64hZBtE99EhST7wExeMn2r3NA+rEbOxc0YFzRn3wXZteHD9dJmH9K/k+z0qASoMHz7f/wpqtA8ZhctjaoFLrU9haVk2pcuf3sJbqYvOCINtu9YM53Z0Q5GlI6UM+eGAsF+IkQ+XeTyLbZg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731887387; bh=MnFfQowYQGiExVazeByQxQ5OXvN+T/J8PwkfZsZxEoj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Iv0kRp7wTnfu4/QW9TgSuVF++49zc/x3WxtiKWxE4y4NSsbq8w2n5RXaEoN7/PooUfbJREPWEIw9232Io1p+8oNtR8+2LWs8bSCmA7Z//WMCYs88wdwY3KbvhIA0dRH/tStjETNP/XmGl8l+sBFs8hjSJS2QQOMYW0/hf2rybkiA3PH66mTzKbW/IMSFap1/WYEOj21Mma7LKUuq3zxcX1C/0riO4EL+ye5EfaIzZxWQNq4N5tvxQEdLygrB5M2lOb0xV7fcB30ePQ8U5Mp8c9u2vzPppEMm3iZygcEkO6PGmZ1uim+GcD3L8/L/ppCLUE5BrodwbOmyzf+vPpPGfQ==
X-YMail-OSG: vBGfsMYVM1kT.k3B43.2F_u.5tJzbLB2mtc_aPLxxxJ.PR29ge3g7ILsxtqYLWY
 a1VkMGlGU9B3PjUlQqpt6Vz78o9E5dD3fbNUVM3IWHC7eCbtH7Ctb2OqAjWe8KC0KF1i44LH3P4N
 ZdJvg5.kU.sg3E8rly_quzQWvC8VaLaApMxk_PbRWBCvGr_Imy2gPpkGI757i4j1a95rbg8uygrF
 wyFIWj_0rFJWbNRyV6MikHlw59yWM.YGGZSGzTpcwxsjtAoyQQC18JZCKSugOZnlvZIYEDl.1_Oi
 Aam4QbWJVP3Ukh9dbvIKkORNtsYwIsF3GEH5KhTamWFLPMnV_NA1onezPEMg39G71_.Xko8rLhNX
 66weYid8WoSuJpfYbxPnIGDlt6WLyzxvVyg3kFwdubUi6HUzfW6fxHSgiRzHKUfNKGTkWZLgbwvc
 vw3oHJFuGZxO5g5YGBG5S6km0hEHOWXM4_.4CiDaJcN5TcSjJsxGkOtyC4Pa53zLXJqJ89xe8w.F
 LP_60x1mim7IvV9cMwwiLmxKRF4sG3_mSKbqUEtdVKMS.n.Iad_GBUAetUUqXtPVyzdth4YUwMbm
 lxGHoMRXwfF7excvY5gRtsYX2DCWvvTRaXQVGXQbPlXpQilZem5OINodIU1hW1UDSllgVvQfK83I
 Zr3QKie2XRC11ulaEvNddFD.4Quc.bTxCmtaWdw7BTOGE2.6_WsK7bWwJ6qcDlMNQ0wukYVDQB6_
 XKXY9fcKRkBy7YDxykiPRp6FpePc38sc38d0n4oq8Yv_pbDTXeh6Nhv9StQWfj4n_NMVxT9r6JEJ
 8yCNRhEF.qGeba56xh_Qm0NpjfkNBL3RCs9rW1X7VBLxh8jGHUOUpGvraxELUcFD8fIz91Rf9cRb
 7SkJihL_h8NmkRVfMcPEJxaIvrmWAG9xMNOBeTeFQjqEL18an4lnlnLSIgYoBux_6tUOq0ava.PG
 aUIDuBQLS7_TYYmeE8MDwQjBE8bR3F4onzusAnApd.7WnlXoJ7tYSOSACuXr9Qw98KlBIzE5kxSp
 vRu55ss.Ak68SmT0x3eu7gQ76_HGrDij0iV4oH1x2c5uix07xK17jmXOYjLH82aR8JdDPGTiabhn
 mts79DA1Ppyp2.eu6Zr11m6jNrDs31Me708h2jbLvtK0_L2D0cnn5EKFf18JW5YLqXA7MqIm8o6w
 GFQ2Kdn5Wr.M2UF9ukTXgmOgYeFr5OdTbgVk4RlC2S4BpAnmVRPw8FDIC4sSF8DHG_IFQtsEgSK1
 W6zH5eKC3uX5CxBhBK.ph0XGPvjvXW4bpplzNzkYj5tBZlh59whrZrfkIGJwSs7izyY6dNSwofRS
 NtqctWZNJ8AsMsGvVUdnbLfHbkn32MrJ4B9fNGxGJGdJ691b8LG2L2UxJy6z3MGXTPJ3b.CvyBAA
 8FgOQ1AAvFyKn2pgGplr8I4PK3epYiv1BhYkgagCeXvJAt41BHnUV9IMCIqBd4RlSDrTRg_i3ju2
 bIE8FgZl7LCldfJJ11TGQD5z3Q0heG1L4sg9ZT4QfRzV8qaKraUiuFu8QrWxLWL1PvMdrQ2QOh_R
 8mh2FRhIcp_Cwldk8ubtPLAlREOeXl6TiPi4A1WNh2Tv7_TGH9ACZ847YPmACaoBTeuFFjiua3UY
 .PgVO6sAR13a_FFKZ0ODLl.hEYgftIGtJtUnDUmCqFUxu9WGPaHWLKjEWoyLUTt4YHrtDqQDYue0
 oJt3zf9t.7fAVMGFIvDBmUgvUHVNImyKeUzpsBgEatGn9F0qpqTNotQ4dbOLwS1QFtsiLmnFkSY8
 eZZ99ZhACi6lplzQZ.y52JrL7hKiU5sqkuw0TVu3hwy3RBpyYmMM60k9l0kyFfF4OY.HQ55sB0ct
 YIgEnCZxXHdIRv50GTXhg51ByS6oB2pzbTk7U4il3obi5tmt6dOcXZaDjrgWNijHhxsrGmzMQsF9
 FGarwdqSltw92GXTh7nbP1B8Wi6aNIIUmXx3iWXgE5CycrosFig2ZWdxjOb8TaSV22xz4H_GkGxI
 DmITz_AwRtLnt8fGslaVI4_PHjqMc3MBG6cNJvV2XYlOLuZK3M_wd4_rPE.1wrcXzAb9CFS1RtB6
 C4df9TMDwcE8SB8C67rPt5UL13MxdtoG13ZkyYd.m1PM4wcCbiybifPOm1zpli.2BdrMn.TH8e6A
 Q7345fUDAIwhQQtfD8mJnpZTSQEWLybtJFEJwcDP6Scy1tWgfIJo0vTLSUt.2y2TD6J5g8hV5mIq
 4W.8Mp_wiFY8Auvr8Vz9Opg5p27L2Ulpkfufum_y8C3lZIU_TqoBt5x6SBf_xenDu9ja.Dic2KC5
 B7U14U6MQLNwn7v.1SLrQGQ--
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: ab5668eb-d683-4a14-8b8b-db984e40147b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sun, 17 Nov 2024 23:49:47 +0000
Received: by hermes--production-ne1-bfc75c9cd-n46s2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c49c6779fa1a016527bc8d82f3fd465e;
          Sun, 17 Nov 2024 23:49:43 +0000 (UTC)
From: dullfire@yahoo.com
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mostafa Saleh <smostafa@google.com>,
	Marc Zyngier <maz@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Jonathan Currier <dullfire@yahoo.com>
Subject: [PATCH 0/2] Fix kernel panic on niu bind
Date: Sun, 17 Nov 2024 17:48:41 -0600
Message-ID: <20241117234843.19236-1-dullfire@yahoo.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20241117234843.19236-1-dullfire.ref@yahoo.com>

From: Jonathan Currier <dullfire@yahoo.com>

Currently, the niu module causes a fatal trap (tested on SPARC system)
when setting up it's MSIX interrupt vectors. A simple write to each
MSIX's vector table entries' ENTRY_DATA register is sufficient to work
around the issue for the current power cycle (note: this means booting a
working kernel, and then rebooting without power cycling will allow a
kernel without this fix to boot and work).

This series implements a struct pci_dev flag indicating ENTRY_DATA must be
written to before reads, and then sets the flag in the niu driver.

This series is based off of and tested on v6.11.5. 

Testing on next-20241115 was also done successfully with the following
caveats: On my test case (SPARC T2),
commit 03cfe0e05650 ("PCI/pwrctl: Ensure that the pwrctl drivers are probed before the PCI client drivers")
prevented all PCIe drivers from binding, including niu.
For my test case I disabled 03cfe0e05650's device_link_add().

Original mailing list discussion:
Link: https://lore.kernel.org/sparclinux/7de14cca-e2fa-49f7-b83e-5f8322cc9e56@yahoo.com/T/

Jonathan Currier (2):
  PCI/MSI: Add MSIX option to write to ENTRY_DATA before any reads
  net/niu: niu requires MSIX ENTRY_DATA fields touch before entry reads

 drivers/net/ethernet/sun/niu.c | 2 ++
 drivers/pci/msi/msi.c          | 2 ++
 include/linux/pci.h            | 2 ++
 3 files changed, 6 insertions(+)


base-commit: 05b1367d372aca98a4e09c1a0e7ff0b9d721b2bc
-- 
2.45.2



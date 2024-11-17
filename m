Return-Path: <linux-pci+bounces-17011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133DB9D0729
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 01:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8F628136B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 00:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFB01DDA00;
	Mon, 18 Nov 2024 00:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Y7VjDx5F"
X-Original-To: linux-pci@vger.kernel.org
Received: from sonic304-10.consmr.mail.bf2.yahoo.com (sonic304-10.consmr.mail.bf2.yahoo.com [74.6.128.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05991D9598
	for <linux-pci@vger.kernel.org>; Sun, 17 Nov 2024 23:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.128.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731888000; cv=none; b=FjuuuvlSBeiI9IKUTBTeeHi7qKO/QcRVRKOMV3JiGZG1lzPygw2POa4JVPdfaXCzjhcGmJTL1aJXOAtsjc66CseimkZ7l20C9QJ4riPDVYpcaciKJhcR+lwVc1NCwkrNcSD5jNj9hSD8pxDs2AUcmvh9fBSJf3sQjEwM/BWAzlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731888000; c=relaxed/simple;
	bh=IvWoevXXpmOe+XQTPhPlMfQe/45LyI5ZKS9WsLqakXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4bkFVLc3FOWmCKkc3UN/u/eXQPRbP2DffVRtOpq65vR6CoLcvtf6ix3Md4hqqCHoOMnOq6fpKVd0ayHV3j54Eh6TG5If4eCsOo2s5RW4kWt9EcBcDL7sLeMZpx168jzTI4wIWA5vJ8hhDAE7W8sXQuuEu2MLqN5sr5kAmHhBL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Y7VjDx5F; arc=none smtp.client-ip=74.6.128.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731887998; bh=r8BNRTgQmSesSBBIr5W5/aasZKD6i/fztbdUkMyjEmU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Y7VjDx5Fna06OZ8oaq3M3mYjc49q3LgvT3mPCYQZADYXFRpkSt06wo4ksBFTKEiuxRcnOLk2a+nYDLsR86lK6YwF5sFfx2UvCn6H5k4sb91N9zNwjRZowu/KpDsTYxinLBlaBOdZbm6UTX32JDAr+gumGKQ+bWTx0bw3GarCMyMnWJ4tvS07ZZ6xY+6nTnxeT5fRbW+PrrisK4xeCrhRC6uObjnNAiQzps8DEkYkeGNdjVKLAHOSImoZDGxmoG1tyna8XjzMLvVtuUx57aI9ivDkGwRGKPEtHwjAN2/cTi2+m/hY/bBsLiJW3BqT4/xomQ49zXCxdnGKaBlmsMNIMw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731887998; bh=4KrstvI9tiz6Ou4Yq4pSQMTQ8r8QGWL2KA2WmHIlx3O=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=a5k5eHz9TFgfxpOouoJ3GDDFu+q1R+tPIF8QsbVALDACLbg6kvP5lK7VNZuSn8w+QdLB7s5MXMgneupohbXf2ksL773jTGQCDwLc0BPThxE+QwEhwt537XZEvO01ArAR82sH83aP8GvtsiLC5ltLzmn5Iq50r6q9ADfvFr5ieiEbI5m5Nhic1tBScknK5VnM1pX87TbxA5qzdOkrxb3EzdRV2S/RAMc+497N+8fb1EfRgOu6uwAnQCS0a9qHCdY+zWaWeI/G++s7mTBZXyJa5sK/vrAgr0mehbFKH/B94RNvtKUhDpQuGv3pl/JQgjz9jgCjC0VHgA/zROXdc6PbBg==
X-YMail-OSG: hSuOfGYVM1ndgg6dhVnOSlwA6.KzLWBotjpHSjuk1xPOH0OKWKseqjxc3MBDm4S
 TuhHzojq1j9YqqQYU_6XmDUxN9PXPs.w_ecyibL4RWm_Wh0gv_3M1glQhe7Z_JaRyGYkq94MSvbK
 uKFeMCfDU8_mUweJpOeBjWSsVgD73g75a8U30JH1Q3jpyqh1EZuM80CJ8GyLH1JSbyIvJorHX8ek
 6_1ghnYtwr6TarJCNbtp0lxHU6_w2OTiDCD1.Fm.ZcAYkbFuiGwAlrGIfir9MsHdPDkFh.BXXd9l
 iLeJlgJqO7gJoy6dhQzBrPiyh1Dq.wil0Sa1N0mkHMfRi40suDBzje9F4UWKyPGQGs8rpNoS3QZi
 7ylU8EcPMOuRoqi3jGe1Q6_0KuqsqnBb2zFjqiPzLhsQn.sYg33VPzfJ4xv6kcknA09.Nmd9dFxG
 gxMecgiRBH7O8rrhNM4XEgpRQIcXABgQImMd4Cf4ALbhJS_robsa9E6yIWuGN00Hipm4RN4c_zGM
 1DBNzlfTYqZ.8C7DdDrcklcu9QfkqVqsXm00nLsOnCYZlJ8YWnVuFLtcqvxSIabGdKfX3JMBHSM5
 wRaPxQNW53l_at3qcRu2ehCZo0WJ2HlGGjXzGk5vdtL_lO_A13xa3ZWchHUxxePyegaK3pM9oh3Z
 eLdHzhZquY1p6.04rHAlh5uoYZkNtOi6Z5c4SI9ga0jbTcxDYJmYg5c2gXSvaXrfBJ4dBjl46bH6
 9VgkA9SsRpZh9WM_mLkhu8ptofihES3Jgvj26muaLCuJ8Kuto6xnSOV3wgIYhRo2_j.YH6YToySc
 6SMHAbqYTFtryg4A7Wc8YZrJJKvPYGqb89s1XmGFGjVeBfbhtGELJRoI7PrXlv_vgpI1nYhhg9kb
 DyVlv0eR8l2eimcYF5RDzKfNPFN0DytAecB3sPKOW3saZYF3HFantMrBt4cz5e89Fw7Poc8Zq2Nc
 .uo0OL7EtOl1P9Ni_jmttlME9DUepogxcfd0X4H3Jb4gqmssZm.vuGGEAvvN1sB0QZM1B3sMIzg7
 JGyl4aUZ2.80YQwW8dpDf59BxbM_eT054HC1zgKbXe7e4PviQinhIiNUA84BuZLal.wXwkDOqo8L
 0Heodkss9z9zN8RIlS9n8A2wytZ6vVWyBj9Z9hpNoMPIjnVINNEQo5dlxb3dU8BlNCrCCbCIhFGP
 g1HxXYCilCFkHFSiWRoDrbuWKJp8ujsQfv7t82BurXJ4yh_DV2Anh0yYdRUZbnOs4kNF0.CyQdEi
 v28qc3ZNl9dbX7cQeCmVtSjvA3NNySTk1HxkzITO7MUh8blx5vF3DCLCocuLYmNRI29EBjsTuNXs
 YJNbMMkcr_7NdR1mmTHi1U9.MasVb74HHZ5eGWzt1KRwaBErOQmSxHmqFNkI7YOwedpW56qTUyNS
 QI7FZmnB5SEql9rruxR0TRD1Kcdoe5NNC7XZsV.dXyQIut7KxCf3bYXAAXxEORyEm7rScfIC.xvQ
 eX9P0omJV8RJD0U..x8OAUrFaVx4HKBE8wfgvvXNPH7mDvF5eExjqjn.HFGYQwHW1TRyC1I1pkYc
 b4FR1t3GmGT_YBEkeKz__TK6jcsXIQH64IJZliLw0bSwkDQBfo0NFezQ4138MuifuSWHYjStFkXf
 JPQjbiuhtCkzzVe7eSwtfu9Guxd8a0jryZtMXo3s6h74aqUCKSK_KfmujwnrsawMbcsfgaJzaKf6
 LxpsU.TmUyo7H0JBbFC6T2NjY.DrfOxwRmT6j6ZW3b0ceI6XrTLsaC5zdgGMuC62QXsGeJQ0NcDC
 s0YqTVOUJkHgmS1cLs2LM7ymwUeY3DCWcl7t1O4EpFsFlScsBW9OVrm6rfdHZ4jizK6hODgTcBag
 IAWVziHyTFeaZdDsrlO5.oDBXgm1S8dAY2JEJYiPjs1bE24Wr8GYURy44JVLqA371MMZyj_I9FsM
 lAGD8BInO9escmlsBtoM9b0DNOCgK_3nTOcVN5uxIpzIXaqyvEkx10XtDAz02qqaKOVJ0FKgLMPA
 8xbPo6woI64XVGwgcebu.zO0f2t51WU1M_k7aHrmjS4J1_g6utr6YTj3rPTWwuTibCCA97_SqnWH
 x7ypaRyx9dfHO8QCoRrBvDx8tcWq1GmJ9uLftNI_diNMnb4jxe2TKzk7lwldKWknkpELA0zGGWCT
 rX4.f3HXLa4pAOE5wUaXJnb9wJC4CO7ft0BSLvNF57vxfdCJPcintJiw9haKO5zU7KjB3XRV.cOn
 a09nwGVVI6h.EcelZy0U4gBaVxvEbAeNvJJ4JlUILX36qM56t7hmZqymFA2Q4sn_drAO2RmWln9K
 cYFgLzC.QaA--
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: 70525826-f25d-4d3f-9322-0992ef71de14
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Sun, 17 Nov 2024 23:59:58 +0000
Received: by hermes--production-ne1-bfc75c9cd-n46s2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c49c6779fa1a016527bc8d82f3fd465e;
          Sun, 17 Nov 2024 23:49:47 +0000 (UTC)
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
Cc: Jonathan Currier <dullfire@yahoo.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] PCI/MSI: Add MSIX option to write to ENTRY_DATA before any reads
Date: Sun, 17 Nov 2024 17:48:42 -0600
Message-ID: <20241117234843.19236-2-dullfire@yahoo.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241117234843.19236-1-dullfire@yahoo.com>
References: <20241117234843.19236-1-dullfire@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Currier <dullfire@yahoo.com>

Commit 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries")
introduces a readl() from ENTRY_VECTOR_CTRL before the writel() to
ENTRY_DATA. This is correct, however some hardware, like the Sun Neptune
chips, the niu module, will cause an error and/or fatal trap if any MSIX
table entry is read before the corresponding ENTRY_DATA field is written
to. This patch adds an optional early writel() in msix_prepare_msi_desc().

Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Currier <dullfire@yahoo.com>
---
 drivers/pci/msi/msi.c | 2 ++
 include/linux/pci.h   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 3a45879d85db..50d87fb5e37f 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -611,6 +611,8 @@ void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
 	if (desc->pci.msi_attrib.can_mask) {
 		void __iomem *addr = pci_msix_desc_addr(desc);
 
+		if (dev->dev_flags & PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST)
+			writel(0, addr + PCI_MSIX_ENTRY_DATA);
 		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 	}
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 37d97bef060f..b8b95b58d522 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -245,6 +245,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
 	/* Device does honor MSI masking despite saying otherwise */
 	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
+	/* Device requires write to PCI_MSIX_ENTRY_DATA before any MSIX reads */
+	PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST = (__force pci_dev_flags_t) (1 << 13),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.45.2



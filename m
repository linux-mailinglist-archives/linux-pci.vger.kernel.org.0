Return-Path: <linux-pci+bounces-9172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EF091447C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 10:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9E41F236B8
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 08:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC44449652;
	Mon, 24 Jun 2024 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="nk2hGmy5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4084AECE
	for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2024 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217138; cv=none; b=R91NLU+lFtrZFfKIM5nKA/qNC1O5UrHVP9dMJZbDHZZdLUa3bDQXGEvZ/JHblcwqAWqm5/Zt5SaJ8TDGbkXpLFvehy4ypE+DtqMkeLlO3xzSrbtWSEGsxJ1+qXB+NmNretmyvk9C4KwO4PJl88isdlwawELeAj7G3sFwNylWVOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217138; c=relaxed/simple;
	bh=myRZ1WzGtVF+5eRnikKNFfYxz/D/CFBKuWmxRIRoysQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDWciJ3bKDmn7v8vVFOaMA9pTyIxXEF7/qnwO6ni1mag2hV+tXmgI7YDKge0fNOe30kyqpSPVpBlRfQieOWjCbEe8ANMt/n15+NbxdfmmrLeyvlhiKzs2Q9j/i2IML8nCcy70ESOBN/EVprgOqpJcMm1cou1Kk2rjggs34sRCLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=nk2hGmy5; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7152e097461so2437429a12.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2024 01:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1719217137; x=1719821937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cwvf9W24UthLlcjVjH4PS05a8L60/p4gOZ+dA+VoDlg=;
        b=nk2hGmy5wqfqdcz39L7zILRWoNtBdpYI4O5X3tcHRe1++mTL1OFaHZH/fMJ2Yr5kJi
         0jWSc5ur9k1imHL5HXsj2u4rsaynY9+mLNCbLJKqTn2lUgfJqWb6QL6RLLKsV1xzWU6p
         ITfe7aAR3npV5cEiIcixv4Csl+tdMhy4DqPrfo8AQ0riVJ9RamYA9I/vvY0+Cci3Y7n2
         cjkqL33hQWZOBJ7y3MjOv0LsbKHncSlOFJ5cY83ICkDgd5SlvzQPzNatUyEv4FwCJi/6
         5Nir5FRPFQZk8guOmFdGxyawES33on/u4Bnp4Mbm16YfhR83lysOcSH7bnPED+wig90f
         LYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719217137; x=1719821937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cwvf9W24UthLlcjVjH4PS05a8L60/p4gOZ+dA+VoDlg=;
        b=OaurNa3zUoA/zZ8CgZ1Kdcq076eH22YPhivErnDVOiSVNX7LEH6gKGDNZ6ZhAAMtWQ
         7BUbaEiJQlerBfe3bqqlf16QwI6l7yej7ii2tWwNzAXR7HE4BjW7uGMEQGOyBa3LZ1Cs
         7x0IHonPrwk4UrWvViBx2C/JWlWnomzHiwl7gC0Skx+hUdCxMOj7/l+33uAAcQU0x8GO
         s3LDJoZpqHRx3X6q9/WSJeM4l0jDL4sGFAvjEFSC3cqBtB2CauweFciST6SDkH3H1zU+
         TPkpTloNyXKl1Rso1XNBNrGNUQVHM6+8uYG7BDaOBQVwHu8vbevHJHuIthxyxJJL+toD
         Z0sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMSgvuGhrF064YBClYFxZMEZqk4/Yi1wXzYzG9DOoHdhzeI6p/rK9IYlxJviMp+yDNauGgogTlZbZ45hyH0QtWNfTEhCR60k+z
X-Gm-Message-State: AOJu0YxPV/BY1rk0BrtrRWC+72X6Jhyt1gATi+s37FPrhazWsdTceBo1
	98xF/VTNTpE001hYies0o1myoH3LC4RjKJ2yzs1cJwLXMm8Nnqgqj+FW+ClMH4U=
X-Google-Smtp-Source: AGHT+IHKpPCbjA9Lpt04pm8JLXalr5L14MoJzaRmUc7pzlkDhUthY4DIreywW2pKD9J9izxAUgoIRA==
X-Received: by 2002:a05:6a20:9782:b0:1bc:b69f:1d93 with SMTP id adf61e73a8af0-1bceccebd90mr5968012637.17.1719217136462;
        Mon, 24 Jun 2024 01:18:56 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-706512fed18sm5634954b3a.181.2024.06.24.01.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:18:56 -0700 (PDT)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v6 2/3] PCI/ASPM: Add notes about enabling PCI-PM L1SS to pci_enable_link_state(_locked)
Date: Mon, 24 Jun 2024 16:17:50 +0800
Message-ID: <20240624081749.10219-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624081108.10143-2-jhp@endlessos.org>
References: <20240624081108.10143-2-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to "PCIe r6.0, sec 5.5.4", add note about D0 requirement in
pci_enable_link_state() kernel-doc.

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
v3:
- Fix as readable comments

v4:
- The same

v5:
- Tweak and simplify the commit message

v6:
- The same

 drivers/pci/pcie/aspm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cee2365e54b8..bd0a8a05647e 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1442,6 +1442,9 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
  * touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  */
@@ -1458,6 +1461,9 @@ EXPORT_SYMBOL(pci_enable_link_state);
  * can't touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  *
-- 
2.45.2



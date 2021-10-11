Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BE342963D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 20:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhJKSDX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 14:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbhJKSDW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 14:03:22 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A09C061570;
        Mon, 11 Oct 2021 11:01:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f21so3085109plb.3;
        Mon, 11 Oct 2021 11:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ac9LXj3z0Aargz2ofBXWx7xZeNNeuttwY96oTD0m/Sk=;
        b=UpndYJVH2kYvgQ5Urq0olbt0Q/fTxH1a2N9PJz1x/BbJNW27uKe02za0ZnD4O3uV8x
         YFIiMi8hdgMC+n1Tfo/PF390u3CxZxjtx6npxQZUEMMhxo1MszeFmbBoKa3C8g/HAiJi
         6q1hHL9b5Xs5weDigUXmr1d80R1XH4E3wwVFtXGZJup+wBXRzN/ORh+klZgF8dSFTwCi
         c2Du7OJmO+39l4z0+o9gdiK2FsW0UHXIX60P7C97Ov4y1/TGassp70S5TnWTe3meFzGD
         n94a7Y+pBkCH6UDpBEWc5u5LfH4c/2rxQdU6dzs/WeYRxbGQ0h1il++ovY47dTcqPZwn
         ZmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ac9LXj3z0Aargz2ofBXWx7xZeNNeuttwY96oTD0m/Sk=;
        b=ZlZt1cBjJ0mRTp7Yzjxe+CnyDIIaDG9EROguFqVMUvfN6X0uqpvK1J3nH7eHcEW2vv
         Cj/FGTeWQVbLTNSkwDKSFSBwCPgQxZGL8izSmNgiAc+66MKCGSrjIaXbi00T9bJGozm4
         Gra4rEp7kdNoZY6JNjCwXF/F83IZjwlh7QkP7bW2eE/pgW+KRvVds7hV7sm923VjfyOO
         +v6I0zwJi9cwpqqsUazzYexZSEq2wyy/xPXnHW+nWpvlmYpBvunwjtH+5Quk0i7sZ+JM
         lrkiEwBsc8i+AaUGAqk/eQ38m4RVcxhOh+hXbtgTWyTbZaVOwnnoLPCUeUxXG7p7o6n2
         LDfg==
X-Gm-Message-State: AOAM531WUb3QVePKtc3SQP0vs0Jnr7pPYAU/HjuPAPWcwnjtwj4fvWVQ
        AtpLNk1+3vtTWv2q+HZR0LlcR6aOEecMuGdh
X-Google-Smtp-Source: ABdhPJw5MHCkS1Q9eMp5sQHWRTrT0swYRsJEFWRTLQ1wt1NrCBy09H9LzFYZ4hCqnvbpODaPwXUvUg==
X-Received: by 2002:a17:90a:8912:: with SMTP id u18mr456538pjn.69.1633975282221;
        Mon, 11 Oct 2021 11:01:22 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id b134sm8820045pga.3.2021.10.11.11.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:01:21 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joyce Ooi <joyce.ooi@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH 11/22] PCI: altera: Use SET_PCI_ERROR_RESPONSE() when device not found
Date:   Mon, 11 Oct 2021 23:30:49 +0530
Message-Id: <8e70c0f96b25e4b30ce4fc261cafe038a025429c.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633972263.git.naveennaidu479@gmail.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use SET_PCI_ERROR_RESPONSE() to set the error response, when a faulty
read occurs.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Compile tested only.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pcie-altera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 2513e9363236..d6c71b5d1ffb 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -511,7 +511,7 @@ static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (!altera_pcie_valid_device(pcie, bus, PCI_SLOT(devfn))) {
-		*value = 0xffffffff;
+		SET_PCI_ERROR_RESPONSE(value);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-- 
2.25.1


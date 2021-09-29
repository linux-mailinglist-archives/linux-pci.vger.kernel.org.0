Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6012D41BBC8
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 02:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243401AbhI2AnE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 20:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242626AbhI2AnD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 20:43:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C7EC06161C;
        Tue, 28 Sep 2021 17:41:23 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g7so2002587edv.1;
        Tue, 28 Sep 2021 17:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=irAkTQ9eHSnLCG+L/2PN01j5WXh7QNbtKnaav0rRkk0=;
        b=JndEPZislozawHCc/jevA+2/3nSCg6TgRI7SfDGXAG+iHI9CivzzutcEjXvL98scJk
         gcrhsLG1tVNHWnPMlTr34b4PAQXhO0DJvcyLrGNNucROwmQC1YwYtAKnv/EUEegzLvWB
         DtQ9E9CV8UT7mzKqc5oGrVrsuCxStdMo8SySaHiUt9pBFSzkabdDyNrRG3zMSGWLAQbv
         rFKVDaI4aJSdOwGwxlczKWVXOWH70Iek5yaPK0ZjLa3crP/5KujNCSqSm0WCBwVQy+Fa
         8jbbvSP6pBZWU9QcHSVPkzMzRZNttWv+bi6wqzw+DcPf7WWhUgFhQGUsKYE4wuuC1m+x
         f9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=irAkTQ9eHSnLCG+L/2PN01j5WXh7QNbtKnaav0rRkk0=;
        b=cujV+xm5g8B+53n+RDC/yba/jT9Fak+s00WBaJULGVZc8WOsBNDynySuhpvuEqtsCu
         xUD3GYTuT0xboaRJbZP3DDFnC/DmlNQOQ9iLEcCfz2u4WCPumPc6Qeq/mr1KSX+zNxYC
         39uqGiyZ+uMvyKD4CiyagZ0AD2A6fSiJ2MZk3R9LJT9Jn/Lsf5OdwE5gEbL5HvnJdw8n
         D+DIjpe07sjyGaQW4ZKR1oZM9svFxGqLukoJYjcNOwk1VnQh05cOBvUxgVZco/Dvb2vb
         pFCA7rrB2GoO+n5BJ4ey7M11xHGsCnUy2tqS/7BhlBEv5c1354SsO/X5YvO//eSe/ZJi
         dthA==
X-Gm-Message-State: AOAM532glS2fIvqHx97TbCHfImEC+XuMfHQTlQkwAlMNLmnZmgDcgrS8
        Ouk8BzDhBjpeREH84bZtqANiZ1iVdY0=
X-Google-Smtp-Source: ABdhPJwfct/OOIAyh/mUgNCC9Q2Vrj7FwFbKi/MHDeAF7nrvHkvH5PMIvrv/Rk2e9hnB6j4dp/Ba6A==
X-Received: by 2002:a17:906:53c8:: with SMTP id p8mr10206897ejo.422.1632876081944;
        Tue, 28 Sep 2021 17:41:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:10f:c9f0:35c7:3af0:a197:61d0])
        by smtp.googlemail.com with ESMTPSA id y1sm372727edv.79.2021.09.28.17.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 17:41:21 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 0/3] PCI/ASPM: Remove struct aspm_latency
Date:   Wed, 29 Sep 2021 02:41:13 +0200
Message-Id: <20210929004116.20650-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

To validate and set link latency capability, `struct aspm_latency` and
related members defined within `struct pcie_link_state` are used.
However, since there are not many access to theses values, it is
possible to directly access and compute these values.

Doing this will also reduce the dependency on `struct pcie_link_state`.

The series removes `struct aspm_latency` and related members within
`struct pcie_link_state`. All latencies are now calculated when needed.



VERSION CHANGES:
- v2:
	- directly access downstream by calling `pci_function_0()`
	  instead of using the `struct pcie_link_state`
- v3(this version):
	- rebase on Linux 5.15-rc2

MERGE NOTICE:
These series are based on 
	'commit e4e737bb5c17 ("Linux 5.15-rc2")'


Saheed O. Bolarinwa (3):
  PCI/ASPM: Remove link latencies cached within struct pcie_link_state
  PCI/ASPM: Remove struct pcie_link_state.acceptable
  PCI/ASPM: Remove struct aspm_latency

 drivers/pci/pcie/aspm.c | 89 ++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 51 deletions(-)

-- 
2.20.1


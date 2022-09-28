Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C7A5EDAE3
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 13:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiI1LBO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 07:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiI1LAs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 07:00:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00237EFE7
        for <linux-pci@vger.kernel.org>; Wed, 28 Sep 2022 03:59:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ok12so281742pjb.4
        for <linux-pci@vger.kernel.org>; Wed, 28 Sep 2022 03:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=fo4HmuLb/yqh2kDNnoKinrIdDSvba5fowzMna9C2QUg=;
        b=SJyC2mJGff3oqgJGbJ2CIG5odbv/+k+1zDOycX2oUS4T2LLeoqU3dGE1ZjN4uoa9Nl
         L1NfMbijmpRASuYUSNvspDxj8CM+rmq+/DcgF1yNslYBahnv7Jb+1k0YpGpi6O/VoXyp
         GCrRgidVi8vWTLkSPgT8qrawa1Xty5l7bByP6CdG/DOYYe0SpUcqP9wk9r9hQ/Ioqxav
         LHNhhGOS8rnJwxzopvjmpsVw3e+VTF33QopJR0QRACOzuMj/kpD0CM6KmvStlb4Og72e
         DEiv3fFrzOIVDxsWfTKuL64jyIYcqAOGQi6b6EG9tMIphMP2u9SnfieVTmst7pefV5rv
         zROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=fo4HmuLb/yqh2kDNnoKinrIdDSvba5fowzMna9C2QUg=;
        b=vaLhjFDH6LY7bEQxt49ja8eR7qGWWRB3HUrqpgBv7GKjYeHcbBMgdEVKfVgx5DJ7Bw
         6ciPFp53l+T4f8OzWk72uEhUvB2Wv6ia2w9tQql/JIPz2agTRiNGycLWbIEHLtBrvrGQ
         Bx0nqKTldw17T7zh+2kq029gCvRT2hPSm3nbpu0Z9mCO45UjGYZGuUJqUtvlMmgprQ6H
         smZJeIJ6fWZI7uL/CqSWeVA/8sdFLWYfnQ9FqOSMkknC5HhLGTJJ79A8KKNS8heGAcmU
         VB1AZn+ZCIyjEjBeisI+I4q8RUujCxSt9lIrjTWazXHe3G6j/TVDD4UFxN3kt4OLAL2Z
         BfaQ==
X-Gm-Message-State: ACrzQf3/IL20K0DDMnA4SK4DV8M6woKKtlMvPp9kU7uKNAi9LtMP/tkk
        7Gjnqp/x0aEOJ8duq4velPmEgg==
X-Google-Smtp-Source: AMsMyM6I8LxP5weTVzsQIxACRMckvsr0iobx2qFTGVa4rjJZfzUFY8aCAwEoIseeeiNOKAkMUe7yDQ==
X-Received: by 2002:a17:90b:38c3:b0:205:d6b5:582d with SMTP id nn3-20020a17090b38c300b00205d6b5582dmr9053345pjb.229.1664362798761;
        Wed, 28 Sep 2022 03:59:58 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d50d00b00177efb56475sm1539524plg.85.2022.09.28.03.59.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2022 03:59:58 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: [PATCH v3 0/9] PCI/AER: Fix and optimize usage of status clearing api
Date:   Wed, 28 Sep 2022 18:59:37 +0800
Message-Id: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello.

Here comes patch v3, which contains some fixes and optimizations of
aer api usage. The v1 and v2 can be found on the mailing list.

v3:
- Modifications to comments proposed by Sathyanarayanan. Remove
  pci_aer_clear_nonfatal_status() call in NTB and improve commit log. 

v2:
- Modifications to comments proposed by Bjorn. Split patch into more
  obvious parts.

Zhuo Chen (9):
  PCI/AER: Add pci_aer_clear_uncorrect_error_status() to PCI core
  PCI/DPC: Use pci_aer_clear_uncorrect_error_status() to clear
    uncorrectable error status
  NTB: Remove pci_aer_clear_nonfatal_status() call
  scsi: lpfc: Change to use pci_aer_clear_uncorrect_error_status()
  PCI/AER: Unexport pci_aer_clear_nonfatal_status()
  PCI/AER: Move check inside pcie_clear_device_status().
  PCI/AER: Use pcie_aer_is_native() to judge whether OS owns AER
  PCI/ERR: Clear fatal error status when pci_channel_io_frozen
  PCI/AER: Refine status clearing process with api

 drivers/ntb/hw/idt/ntb_hw_idt.c |  2 --
 drivers/pci/pci.c               |  7 +++--
 drivers/pci/pci.h               |  2 ++
 drivers/pci/pcie/aer.c          | 45 +++++++++++++++++++--------------
 drivers/pci/pcie/dpc.c          |  3 +--
 drivers/pci/pcie/err.c          | 15 ++++-------
 drivers/pci/pcie/portdrv_core.c |  3 +--
 drivers/scsi/lpfc/lpfc_attr.c   |  4 +--
 include/linux/aer.h             |  4 +--
 9 files changed, 44 insertions(+), 41 deletions(-)

-- 
2.30.1 (Apple Git-130)


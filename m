Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D201F411C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 18:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbgFIQjg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 12:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgFIQjf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 12:39:35 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC83EC05BD1E
        for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2020 09:39:34 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id m32so11718597ede.8
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2020 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y/Rn6P843JcLKvVSPPaYzEvVVEqJRDu8PG/+Ap9EEWE=;
        b=ZrWLsJhnUtq+jx4ANSkCp0Hzin89B93mnCMKpYUdRm5rDV1XO+BYLX0zuWoFY7816M
         O5XbLGNPOmIi5VlEvQG9Bc9wqKblEPpVRQ2RB6O081Z4dqHwN2WzC5w1Nf1KrIcP1ax7
         vDNhwaqk9OWGGOyaR8gP+7RFIYsnxBUqLkt1KOnUX1YaoLeNmfoY1LRW1fZUWzTlfPNa
         FeYFDsRMn5GzQCcBLNbFT1mcmJj/p1VO3Z5VP/qrIXs7X/ZOcuhwCo8IdrpFTdTJJ3S4
         euAzA7SfnlYC5sXLlUUhaZRqPVnIoO4JfccT+TKC/At7ZKmTlR0WKFscvER4JH+qh1bV
         lEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y/Rn6P843JcLKvVSPPaYzEvVVEqJRDu8PG/+Ap9EEWE=;
        b=g+TYkytSPCKXb9u5xsGO8RvQg4ajHEERkbcoVO2oauGetOfdDuVRU+zLefbwz6O8iQ
         o9d5AJwf+w4zpogVuWYSqAOr07TdBVm8W9rprtmTXuHRlsweZZIBLrSKYKzUGPms6CQJ
         KEYgQGQebp79tte12L6ZRjEP+ki0Je7ui+zffjiD1uQ8l42DArF0RBWGIRimKiz7hULc
         uxgQLpSJmauSqP4jLWdqzT4B5ptN3K2e/zN/TiClIMStrSkRwd5tm63q95AMXs4Itmnj
         GKX0SBlWj3TJDL95LwUC61uEV7CZSumvxYBiwd3h8kBFmNVARq1TC5dp6+dGX38vvlWu
         0Ljg==
X-Gm-Message-State: AOAM530r9lFsQB4XR9tJ2NtKoGaRn8SLc21OQ67XqfBpHYMbJNuFu0nM
        6PcY+xPksMGrMzTBUwxFJNw=
X-Google-Smtp-Source: ABdhPJxznGlO+MbDMLfO78Mc5TpdBSO2p73fIvgPKplgvRVowtv2kuZyj8qv52k/IJF9fYK3zVYVNg==
X-Received: by 2002:a05:6402:1767:: with SMTP id da7mr28195744edb.90.1591720773338;
        Tue, 09 Jun 2020 09:39:33 -0700 (PDT)
Received: from net.saheed (0526DA6B.dsl.pool.telekom.hu. [5.38.218.107])
        by smtp.gmail.com with ESMTPSA id ce25sm8822176edb.45.2020.06.09.09.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:39:32 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH 0/8] PCI: Align return value of pcie capability accessors with other accessors
Date:   Tue,  9 Jun 2020 17:39:42 +0200
Message-Id: <20200609153950.8346-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

PATCH 1 to 7:

PCIBIOS_ error codes have positive values and they are passed down the
call heirarchy from accessors. For functions which are meant to return
only a negative value on failure, passing on this value is a bug.

To mitigate this, call pcibios_err_to_errno() before passing on return
value from pcie capability accessors call heirarchy. This function
converts any positive PCIBIOS_ error codes to negative non-PCI generic
error values.

PATCH 8:

The pcie capability accessors can return 0, -EINVAL, or any PCIBIOS_ error
code. The pci accessor on the other hand can only return 0 or any PCIBIOS_
error code.This inconsistency among these accessor makes it harder for
callers to check for errors.

Return PCIBIOS_BAD_REGISTER_NUMBER instead of -EINVAL in all pcie
capability accessors.


Bolarinwa Olayemi Saheed (8):
  PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
  PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
  PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
  PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
  PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
  PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
  PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
  PCI: Align return value of pcie capability accessors with other
    accessors

 drivers/dma/ioat/init.c               |  4 ++--
 drivers/infiniband/hw/hfi1/pcie.c     | 18 +++++++++++++-----
 drivers/pci/access.c                  |  8 ++++----
 drivers/pci/pci.c                     | 10 ++++++++--
 drivers/pci/pcie/aer.c                | 12 ++++++++++--
 drivers/scsi/smartpqi/smartpqi_init.c |  6 +++++-
 6 files changed, 42 insertions(+), 16 deletions(-)

-- 
2.18.2


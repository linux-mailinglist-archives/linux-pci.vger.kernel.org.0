Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2B1201CE6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jun 2020 23:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390611AbgFSVMC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jun 2020 17:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389497AbgFSVMB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2020 17:12:01 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFAAC06174E;
        Fri, 19 Jun 2020 14:12:01 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o15so11591706ejm.12;
        Fri, 19 Jun 2020 14:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KIfMPBwAbPyXpMZbtJoCaGsnNqfMLuSMLpP/STnWlzg=;
        b=LtyiMQyp/FFZubW5+D7Foysbwwy85DTvqClszgRgNmhLcYvR65lWt8fkqGyfDY8Tqa
         VDBkQZ3ADigK7DYgxlj93aUYWUVZnlPrlhP9Lt4lv3AK3SZ+9zoQxf7zu3pUUQMak3Ro
         fUf9nmwlXLRmY3tb4ZXnV03Vh0/JmlzfjyPJcmWGFOEhijyPYte7h0AjlrUXJmgeF0Oo
         rWWi3GdVA8skQgoKRyX3oCVYLxRuI5klFVgEuVJFlc6KRgG5vJNHL0Vs1StzSGYnzHK3
         JvhhEfNVbUnysBFzTnLzB024bU2F55p6VO8WWnpHAsZV8YIIQPvfThIjqt2vFuklQzqj
         0PSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KIfMPBwAbPyXpMZbtJoCaGsnNqfMLuSMLpP/STnWlzg=;
        b=mURiSVGBGeBADQkpicpibHef9x6hj/EwgSgbD4ecZ4JFNi/bV2bWo5sFJFy62MhQC3
         C9aW3BFilo1B66bVSvm2hTC9jnOJPnj4PvLP7pAvfUGlkttA402CBJCR/DrULgoN3iLJ
         zWu0ZaKghTeTmb5tYqve8E5ddrKtFYhNhM6y3qVAVFgmoEiOfCcMFgCNTp3rjpW37wQf
         75/6uIjLiJOwRmMW2adO4QbwTCeYYMjNuD6dflUuUwO3zA8dyFccfRhqHGnsSeBe1+3a
         FGgPV03kS9hUqnWWXZw0FC8jnt8GCOX9XEDGrT1DiBeBJw2CGoCgkosH4U9U0zYCtpC6
         nQSQ==
X-Gm-Message-State: AOAM530TrtBu02B1rLrM4wCeU90ELdr7mVK5cCSNpCKzptPDaKSiOom9
        qVfufyLozfNlKzhhlUmIW8DZAMZ1tDU=
X-Google-Smtp-Source: ABdhPJz6Lh9pbDU8TDSe05ow1YOmWrdksOecxfmIJQTZzGP5k+kRD6mBrTHQAq1DsYbFiHN/vcBdEQ==
X-Received: by 2002:a17:906:adc7:: with SMTP id lb7mr324566ejb.302.1592601120219;
        Fri, 19 Jun 2020 14:12:00 -0700 (PDT)
Received: from net.saheed (54001B7F.dsl.pool.telekom.hu. [84.0.27.127])
        by smtp.gmail.com with ESMTPSA id kt10sm5485833ejb.54.2020.06.19.14.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 14:11:58 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix wrong failure check on pcie_capability_read_*()
Date:   Fri, 19 Jun 2020 22:12:17 +0200
Message-Id: <20200619201219.32126-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On failure, pcie_capabiility_read_*() will set the status value,
its last parameter to 0 and not ~0.
This bug fix checks for the proper value.


Bolarinwa Olayemi Saheed (2):
  PCI/PME: Fix wrong failure check on pcie_capability_read_*()
  PCI: pciehp: Fix wrong failure check on pcie_capability_read_*()

 drivers/pci/hotplug/pciehp_hpc.c | 10 +++++-----
 drivers/pci/pcie/pme.c           |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.18.2


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418782F9BA3
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 10:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387918AbhARJAC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 04:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387909AbhARI77 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jan 2021 03:59:59 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D35EC061573
        for <linux-pci@vger.kernel.org>; Mon, 18 Jan 2021 00:59:19 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id c22so10488090pgg.13
        for <linux-pci@vger.kernel.org>; Mon, 18 Jan 2021 00:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PB6HJRYih/9/P6sORTVGIgjwqf3/DVJJnmXcLRRh/VI=;
        b=HYHj41I/g9gpS3b1IgN6kVxfbxxse10z0jE4GHcwjpdIvLUjqD5GCr+AEXg8e7Tm9S
         wcEem69QbeBvoQbWAiCEd6H7Ro5U5vCDFlGUSUqLZLWU2Y6TIMoreAT3q3FW+slN/oJJ
         eTHb1QM60qmrGrPPDk9Ap1Z7V77jbQbct+wP96gUSozenlkjkBCqoI3GLrQSGvXzlFZJ
         pTY+Vk6ui7mGCmyitflBMoxLqmwY76++RW47ZgwYzF88zkvyULzaWhcg2kMeHqUy1EQF
         FZoMk/skIcNNGLd5FXClvx7LnORyiZ3zHC3GmRPBrjmtUlrEkeciPpFryi6is8rwMrcV
         hcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PB6HJRYih/9/P6sORTVGIgjwqf3/DVJJnmXcLRRh/VI=;
        b=oTivUGCDbzdZtH1N0V0vgLLOcpuRk3fGmXb7CBIkwzvQsXtFZLTNVwkB+opQ5qvnBy
         wKjjW4FUReI3Q7xbtvfYcX4GmjIrdqY1w6MrJFT0iDz/dVV6pjua1UJ/5IGVCq0Ux/CV
         uSsDmkeusTvDyEf12/WWiXVPu887BszsKHNvM6hN1qZJBdkyFF9syAMqBcOAByWwOVQd
         mazmMot2zTNPxKsBkz3QJf7cYyr6z4/vdo3bKEzAYcexueaj5DKxZUFCHsu5WPOUwIv3
         DoeJlKSj1R2hehpO6F8HCXp7XfUUY+8Gl7QNUEL11o3H0viWj4Lw6DhcKh8pdAT0+rS2
         TUow==
X-Gm-Message-State: AOAM530XPMggLH22KVzxLyqUb7aex/NooTVcPit8khod1Rqv0PPlTr6V
        pUR8IkAvw8ekTMiwfsdDCt5dxg==
X-Google-Smtp-Source: ABdhPJyMZZk7uPV7TAQvJCQ4ZZfl8zlPjJ1/kkOJCtzuLPQNpUtS7bo6IYfwyUwY2AYrrd16ph+Bgg==
X-Received: by 2002:a63:720c:: with SMTP id n12mr25340017pgc.97.1610960359143;
        Mon, 18 Jan 2021 00:59:19 -0800 (PST)
Received: from localhost.localdomain ([240e:362:42c:4800:8459:4fa0:20cc:1141])
        by smtp.gmail.com with ESMTPSA id c23sm16087162pgc.72.2021.01.18.00.58.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 00:59:18 -0800 (PST)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, wangzhou1@hisilicon.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2 0/3] PCI: Add a quirk to enable SVA for HiSilicon chip
Date:   Mon, 18 Jan 2021 16:58:33 +0800
Message-Id: <1610960316-28935-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
actually on the AMBA bus. These fake PCI devices have PASID capability
though not supporting TLP.

Add a quirk to set pasid_no_tlp and dma-can-stall for these devices.

v2:
Add a new pci_dev bit: pasid_no_tlp, suggested by Bjorn 
"Apparently these devices have a PASID capability.  I think you should
add a new pci_dev bit that is specific to this idea of "PASID works
without TLP prefixes" and then change pci_enable_pasid() to look at
that bit as well as eetlp_prefix_path."
https://lore.kernel.org/linux-pci/20210112170230.GA1838341@bjorn-Precision-5520/

Zhangfei Gao (3):
  PCI: PASID can be enabled without TLP prefix
  PCI: Add a quirk to set pasid_no_tlp for HiSilicon chip
  PCI: set dma-can-stall for HiSilicon chip

 drivers/pci/ats.c    |  2 +-
 drivers/pci/quirks.c | 27 +++++++++++++++++++++++++++
 include/linux/pci.h  |  1 +
 3 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.7.4


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CBC3E3BDA
	for <lists+linux-pci@lfdr.de>; Sun,  8 Aug 2021 19:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhHHRSf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Aug 2021 13:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhHHRSf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Aug 2021 13:18:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6044AC061760
        for <linux-pci@vger.kernel.org>; Sun,  8 Aug 2021 10:18:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q11so6051142wrr.9
        for <linux-pci@vger.kernel.org>; Sun, 08 Aug 2021 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=g122Pgtid4SDOAools1Lmk6vcXipwf1eMBN2dfSloxI=;
        b=a2YfxIf6co5D461CSB3wYa1PxDUZ2L/Zyk5bIpcANIwoaeEXfonmz6gqvSQtfJR+S4
         0kQyevWCDykJ4fyGbfT2B4D2KIBC83aVRJknVRPJSjycxmFheLTlxHc0bRMslR7mPNfB
         vVRtGDViDIpWlF056AB2EUIgaAUH3gRndwUrYkdmNuQN6F1ma3XvwRF7mJIT5LV8799S
         PjqDJdhcP7AaBeWFTVuAVLzM/9NMy2Tep0h98HCA+uqiBTUT/BEWHC2KuMof3US9trXm
         216MN1gRGlROXDgn0J81lULI5qw5NHV+rawe8jEAqUcss7sO8U9+3dMLicQUXL/KnuTB
         DvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=g122Pgtid4SDOAools1Lmk6vcXipwf1eMBN2dfSloxI=;
        b=IR31UPRyN98VuqILuwgNYLH910mqk3IuHS6Mg9IdIEzQgDO1Y43BrAau+JN8ReWkpG
         yEjD7MgkHdiS0Dp8+WFniHBY5Zk8kP/z1syq5G79pfzk0fbWD9aGp8I865LrqQyhcbbb
         YPZ8QdSk7G0OP8awlSXS2ZUPognwQgjBPa4SQfKUTP4Mwz7oL24kKQecWv7VJdbhOXhj
         6Q7sjcHpZpoSFczp0pToAzjYmKFEgX3tefW/+IcTGrTfuKCPIjGLMSLd4F81HUej/a+F
         Vtwm+eb0kVFqrRBU61xFIBIGk0OUAoA1aO/E7RH4fzIF2t8AUUqh83LkJhxRSHnU1gIO
         u56w==
X-Gm-Message-State: AOAM5335lkggbMjQUdALuMzYtaXDYd7UBFd8JPJK+i3M4MF2XamF2N/V
        7S1dLxAOnZX+Dq3jY/jdMQNxLnh2F0Thmg==
X-Google-Smtp-Source: ABdhPJyIQF9eTiRCxUiyUflox1IQlC7vdIfhSK4ocAtUcb8QY7jt2eSF0kxWeNdFzQrnGqTqfUd48Q==
X-Received: by 2002:adf:ed82:: with SMTP id c2mr21071343wro.19.1628443092723;
        Sun, 08 Aug 2021 10:18:12 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f10:c200:7101:8b48:5eab:cb5f? (p200300ea8f10c20071018b485eabcb5f.dip0.t-ipconnect.de. [2003:ea:8f10:c200:7101:8b48:5eab:cb5f])
        by smtp.googlemail.com with ESMTPSA id m14sm16667928wrs.56.2021.08.08.10.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 10:18:12 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/6] PCI/VPD: Further improvements
Message-ID: <1e61d5dc-824c-e855-01eb-6c7f45c55285@gmail.com>
Date:   Sun, 8 Aug 2021 19:18:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series includes a number of further improvements to VPD handling.

Heiner Kallweit (6):
  PCI/VPD: Move pci_read/write_vpd in the code
  PCI/VPD: Remove struct pci_vpd_ops
  PCI/VPD: Remove member valid from struct pci_vpd
  PCI/VPD: Embed struct pci_vpd member in struct pci_dev
  PCI/VPD: Determine VPD size in pci_vpd_init already
  PCI/VPD: Treat invalid VPD like no VPD capability

 drivers/pci/probe.c |   1 -
 drivers/pci/vpd.c   | 253 ++++++++++++++++----------------------------
 include/linux/pci.h |   9 +-
 3 files changed, 97 insertions(+), 166 deletions(-)

-- 
2.32.0


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482456F4A61
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 21:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjEBTbu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 15:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEBTbt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 15:31:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD41310E5
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 12:31:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b8f32cc8c31so7792831276.2
        for <linux-pci@vger.kernel.org>; Tue, 02 May 2023 12:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683055908; x=1685647908;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ajfu8z1FBKWMH4ZMHsO3r6mlUtE9u+PmnVbE9CkWQ2g=;
        b=T2L08tFswo2Hn5lx61S1dJBFSNwdVk5N34ChvRv2N3F/6NBOjdJv4ucAtPzN7d4fx+
         T2l6F0B+bFbMNCsa37WCn9+i4144gNMU6HxTzrBJPTgXcwefYN/7gK/Mcrl86bRiK6c2
         YJ9jfw4icAVtLFI2ChowYK2abuLXznG6y9g+F3SLiEnUbHgHIICpBEoHRDZrAFLjSbK1
         9dbvpbmNt2VZS/4NzLdiDT1yF4LA4G3OLES56zjCwcnvE60Xe6nW5W9lINTp78espQDj
         /x2+KL1sE9pDahFtffWnrJRBdQKHNqf5x7i5REarfzY/jRMGnd0iDKpkfRJnxvnY/UtX
         PE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683055908; x=1685647908;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ajfu8z1FBKWMH4ZMHsO3r6mlUtE9u+PmnVbE9CkWQ2g=;
        b=NSig5rduWdWdbgyCfrIvfMIlmXLunGk0EmzXaK92XkB8J+FIUbkfVDSd6pFSFcix41
         MwZcDZNZaRaO3AZugv25Uv459y13uBIO8mMfNOsRh2lSqfOmlUf0cievrVoFRLAZFwZF
         SAECMaSXk/lMqd5jPY/5AgN3TO9Fg65g/7r3IE/IOvcwcIzWg5Fwn5bM+I1GiF3Id+eo
         P+dLEhXIbrybatZtDbdeaNhwFhlhi7fLCRXD2zZ5Qj/4p1COSVA6FvSL+x9bwvyPpCIA
         8VED93KjfGHGLOFZfycuIhLMLq5JSwlhy6msMMoNfQArOscT3hUtyxAL3t370LgeVY8T
         E0ig==
X-Gm-Message-State: AC+VfDyM7MoanS67YoNviOvih3UJCkAapsEJucScI2HvFQFPdcuoYR3h
        vaYJAYD0W9MBz1kLnh8rJGIz76yVXdLbHzMWPg==
X-Google-Smtp-Source: ACHHUZ5ZbwPfSLJG22UO+FpkjWSziCr6vtcRkoMqZAdo2opQkjUjNEL3FtQVMbZ5TN9bwQHhn3IBHTNTxpiawJan0Q==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a05:6902:18c4:b0:b99:45a4:3f96 with
 SMTP id ck4-20020a05690218c400b00b9945a43f96mr7744629ybb.5.1683055908032;
 Tue, 02 May 2023 12:31:48 -0700 (PDT)
Date:   Wed,  3 May 2023 01:01:35 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502193140.1062470-1-ajayagarwal@google.com>
Subject: [PATCH v2 0/5] ASPM: aspm_disable/default state handling fixes
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On going through the aspm driver, I found some potential bugs
and opportunities for code cleanup in the way the aspm_disable
and aspm_default states are being handled by the driver.

Changes from v1 to v2:
 - Split the patches into smaller patches
 - Add the patch to rename L1.2 specific functions

Ajay Agarwal (5):
  PCI/ASPM: Disable ASPM_STATE_L1 only when class driver disables L1
    ASPM
  PCI/ASPM: Set ASPM_STATE_L1 only when driver enables L1.0
  PCI/ASPM: Set ASPM_STATE_L1 when driver enables L1ss
  PCI/ASPM: Rename L1.2 specific functions
  PCI/ASPM: Remove unnecessary ASPM_STATE_L1SS check

 drivers/pci/pcie/aspm.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

-- 
2.40.1.495.gc816e09b53d-goog


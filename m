Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5292C3EBE4D
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 00:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbhHMWgo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 18:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbhHMWgo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Aug 2021 18:36:44 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4541C061756
        for <linux-pci@vger.kernel.org>; Fri, 13 Aug 2021 15:36:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a201-20020a1c7fd2000000b002e6d33447f9so371238wmd.0
        for <linux-pci@vger.kernel.org>; Fri, 13 Aug 2021 15:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qzh4Td0s9XE/OuGLJCcHzFTczR9b/gH5Jaed5Ln3pQo=;
        b=nOhruPZ6OoWCtIjMJRLvCrqDJ36EmesOJwUkn3f0nSW0TBuxMjDHhO4fPsSRmFRRg8
         ICT1bxsXL5pNl19jbq3wgwaufbtWBH7l0oQeRuECcRrk97rkK+PEHUcId7RfDFOOCC1y
         7rViMFTz4Yof3RNTbs9IaOdJlB+2sp6aF+F0A2bgr4udUOWZ71R3Agi60E0pz2UJJ7Dk
         6lhxJrGetlJjNqlEGDFuNJNmQfACMVXoHTPh5my+50wywiskF8G6Y82E3eL8TxySITYc
         SHn5BQheBO1ObGZD2sdLtyEI7nlFVk8qd9QCxMsg+k5YywfKVFyha8R9EI68XXjrU0gU
         ytqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qzh4Td0s9XE/OuGLJCcHzFTczR9b/gH5Jaed5Ln3pQo=;
        b=VdXuRN9u3l/jWDko9y4dy7o0G+Ss5FvTm8IpY9oGMnLcj5x/rSu8QxYzlAgL+jt3IO
         zvCBCsdVJo84OxHkWLQ+2Hx2/jsSJOjleBj+dFMac8/n2604rbfOE+kqG15iVvvX4rPS
         cjXkuWIX5w2UIsc1UjQ0mPC0uwNnHNuod/s+11PfJzKdXHUi9MdhBgeMapJ3UEcMnBbR
         YobrKSGIEUd8tcoe+/3nvVjgwEDq4hBy0F12uCli/Kg8jnLru3hsKTPFVLReHbwxkudc
         7q3JGLHcP+tdfIXxMy/otytC8L9LQhJurWvLbhDvX/SYa1/YypakioHSa/DhJW0+Y/tn
         9njw==
X-Gm-Message-State: AOAM533mgvvgnLwKcR2EJMh/0ysb4L8iY6xuj54eR/rfxcEWDZTi0NNz
        dc7fCcJo/eX0rAQw0OoNjLQDaOvkaSctbA==
X-Google-Smtp-Source: ABdhPJwB4ur1kGHAiyUeX//filif6XNEOoSM6oGYG+NW6f77WJQAnLD3uGcAOXK0OpCoSEsMOjaAYg==
X-Received: by 2002:a05:600c:4a29:: with SMTP id c41mr4552975wmp.86.1628894175053;
        Fri, 13 Aug 2021 15:36:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:144:f570:b509:5224:f519:ca15])
        by smtp.googlemail.com with ESMTPSA id 6sm2621028wmk.20.2021.08.13.15.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 15:36:14 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>
Subject: [RFC PATCH 0/3] PCI/ASPM: Remove struct aspm_latency
Date:   Sat, 14 Aug 2021 00:36:06 +0200
Message-Id: <20210813223610.8687-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

These series removes struct aspm_latency and related member with
struct pcie_link_state namely .latency_{up,dw} and .acceptable
All latencies are now calculated when needed. No functional changes
was made.

MERGE NOTE:
[PATCH 3/3] depends on 
[PATCH 2/3] PCI/ASPM: Remove struct pcie_link_state.acceptable

Saheed O. Bolarinwa (3):
  PCI/ASPM: Remove struct pcie_link_state.latency_*
  PCI/ASPM: Remove struct pcie_link_state.acceptable
  PCI/ASPM: Remove struct aspm_latency

 drivers/pci/pcie/aspm.c | 59 +++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 37 deletions(-)

-- 
2.20.1


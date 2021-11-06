Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31BD446F82
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhKFR4k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhKFR4k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:56:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91919C061570;
        Sat,  6 Nov 2021 10:53:58 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r12so44737097edt.6;
        Sat, 06 Nov 2021 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JK9g2yAuDw6DTRhvc8HAnrgyVsmnlkUlQWov9rAZGMk=;
        b=OGiULrfmYwCkRi+lIO7KuaeXGKrT0eN5SUrD2xC54iB31Hf9j/73552OavyTH6Hatc
         6sGOwQ+Il9UfqhMw4sc3SVXTGTi/vEIHCiSZbe5NqH02p60hO0Be3H1L2Yet1DF8tNhb
         R65GOyhmO0+82yWmx+D/EH34QoE7UiDGV2DUQ4WfCRdxjSQ6yJ5EjEDnxJZ2+vqsC+0a
         Er4lLS2HW+4Mzdhz4FUGXGX5Oh3bGl4mmvGc5xaNi2wUaObqnYhnZtlOdTHh5yThMqkO
         MdOp7HK9MClDpcZsDuSIdO49NHow0t/OKOjSfMs8n86nsz9gZrixwwQDo/KlubFevlgX
         vPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JK9g2yAuDw6DTRhvc8HAnrgyVsmnlkUlQWov9rAZGMk=;
        b=nxp+E0TZApFOTMkP7YNKripEdtGv1TsJDAeaDTqtHG44WJZh6l1A3wojsvbAx/FEze
         iO0hmuDDQLov3BGk3KjJfPWSLmEKqZ/heAj7rSGffP44fGsTuK2Aj+FlMDhJgYVtFzR5
         O4WdSwBGRxzTq+Czt4737l0mZXfK7XMX9shICPX0Id6VpCVXJvXcQMMZgxFbQHM74UCI
         +FJlkRQ3Ih3Qk9121T9bCPCWXnEHm7h5Yy4fi5cOZN/gpySqU6cMvOxOJPnify9POwGU
         NON/ZmyxCdks80URGBZy9q+F8Evfgsmw9xtcyP8gU8uq3Mkp9836l0iKWDStvh5Ced0O
         Kx8w==
X-Gm-Message-State: AOAM531GQBFF4gAAgHz3vCtmICRvem+xfVlg9yfae3HcOsGRUu1JeF+s
        INJH6JkJMJwIhNuDY6shHy8=
X-Google-Smtp-Source: ABdhPJzCtAxeyJTURVa+CUU67uhGKoJ5SKlhy0+J0yOYz6JgxHlua0IMzotFMki5trYjLTJvLenSag==
X-Received: by 2002:a17:907:2d20:: with SMTP id gs32mr42366707ejc.270.1636221236917;
        Sat, 06 Nov 2021 10:53:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id m12sm5753494ejj.63.2021.11.06.10.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:53:56 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/6] Remove struct pcie_link_state.aspm_*
Date:   Sat,  6 Nov 2021 18:53:47 +0100
Message-Id: <20211106175353.26248-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

aspm_{enable, support} in struct pcie_link_state do not need to be
stored. This series removes them and creates functions to calculate
them.

MERGE NOTICE:
These series are based on
»       'commit e4e737bb5c17 ("Linux 5.15-rc2")'


Saheed O. Bolarinwa (6):
  PCI/ASPM: Extract out L1SS_CAP calculations
  PCI/ASPM: Extract the calculation of link->aspm_support
  PCI/ASPM: Extract the calculation of link->aspm_enabled
  PCI/ASPM: Don't cache struct pcie_link_state->aspm_support
  PCI/ASPM: Move pcie_aspm_sanity_check() upwards
  PCI/ASPM: Don't cache struct pcie_link_state->aspm_enabled

 drivers/pci/pcie/aspm.c | 291 +++++++++++++++++++++++-----------------
 1 file changed, 170 insertions(+), 121 deletions(-)

-- 
2.20.1


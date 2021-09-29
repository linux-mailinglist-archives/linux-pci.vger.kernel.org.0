Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC9141BBDA
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 02:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbhI2Apt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 20:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243473AbhI2Apq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 20:45:46 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DF5C06161C;
        Tue, 28 Sep 2021 17:44:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ba1so1973918edb.4;
        Tue, 28 Sep 2021 17:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hq2aVNOQlXinVNB6+1OVeXMuoNE+1+eH9lZrxep6mKw=;
        b=c87hG3Lz7DBlx8ZMd++kViMxTs5d257EvILlVAhveRVbZbLb90zkJtU92NLPeZU5n0
         lTXAAd+qav7YPZMXKa8e4iM2qH1riOMJc5zn5HImAtPmv3LzMecKGsaJYOBKKH1ES2l7
         QTlNF297h0VNPT1B1kInJkxKuW9nthuOiHoUcW+IDx3umylkPC38BysiT5FWbiQv8D2P
         MczQw1hf625119rYeGDQx5Sru8GyE2Bi9PnLShgcT31JIIlYUcuvGNwRmRyrcEcBHW9G
         6u91AD/XyaudK6wsAYQ92oxRcC5gxsANRPTMdwHU9VkjC5vasswX5ShRHOaO0PdVi47+
         yKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hq2aVNOQlXinVNB6+1OVeXMuoNE+1+eH9lZrxep6mKw=;
        b=IJRiojchEid/nr9iwmrMv3EBflyo431wPDp9/KnHtksl+kfjFam5DaOXTzrOM/rLIk
         enOqEK7QoLYC7oAt/fIauADGxvTKp413H90GK0XIqqU0d//XHXq4RtMtcgBTkSoT7j+Y
         tkESKLXpc/rmvvGdRLVFKY2Kl+bA6G0pDpmNCmG+1mAIjOy8nWw35mcDXCzcB7bXNpaD
         Twq2kLURo584Syqot9OMEYjLYlB/h9mNh+fe8my25wjj3hZwDlrRk2x66Cp/QCtvowv8
         f+du/ilYjGyGEJo+Z8j8JeyitMi/wZPz/h/txDxm1OKx0PNoQFWc1V4oyyw/1Cczu/fq
         OXVQ==
X-Gm-Message-State: AOAM533pArNbM4+KfhUTne4QxKiUkZA0vmv7QrlKDVtbm9FjNXQg/gRK
        Ek+SPwQiQj16Ad7nIhbI4QOh5tfd58o=
X-Google-Smtp-Source: ABdhPJxkdc0jKqJrlH3iwOBfBDgdG/bOj9i+Jvk6BiYVFk8G+jcf3IkzpH54YcF0qbHsv8NghCSi4A==
X-Received: by 2002:a17:906:94c5:: with SMTP id d5mr10533947ejy.489.1632876244517;
        Tue, 28 Sep 2021 17:44:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:10f:c9f0:35c7:3af0:a197:61d0])
        by smtp.googlemail.com with ESMTPSA id r19sm383578edt.54.2021.09.28.17.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 17:44:04 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/4] Remove struct pcie_link_state.clkpm_*
Date:   Wed, 29 Sep 2021 02:43:56 +0200
Message-Id: <20210929004400.25717-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

These series removes the Clock PM members of the
struct pcie_link_state. Another member is introduced to mark
devices that the kernel has disbled.


MERGE NOTICE:
These series are based on
»       'commit e4e737bb5c17 ("Linux 5.15-rc2")'


Bolarinwa O. Saheed (4):
  [PCI/ASPM:] Remove struct pcie_link_state.clkpm_default
  PCI/ASPM: Remove struct pcie_link_state.clkpm_capable
  PCI/ASPM: Remove struct pcie_link_state.clkpm_enabled
  PCI/ASPM: Remove struct pcie_link_state.clkpm_disable

 drivers/pci/pcie/aspm.c | 95 +++++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 42 deletions(-)

-- 
2.20.1


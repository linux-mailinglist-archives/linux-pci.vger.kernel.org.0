Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DB645A6A1
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 16:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbhKWPlw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 10:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbhKWPlv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 10:41:51 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665CEC061574
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:43 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso2213838wmh.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=II7TnOjvS5CtTkXe+SHzNJQOjS3m0MYW+d5C0dNHj6U=;
        b=an+wdRFP7J7HoVXqu3sd68S1HyvABRTeA8UM4rEAzUbuxo50u+TbMh3vmuWfrMO5eG
         gejllgkj7NwAUP0ZXunFnzI3ekdVP2PGUrh7WPXLnuE0UDxAZ3Pdp9JqHcGkaVXBV2Gk
         EMZrEYiW6zT96Ah/D74ijlCD5SWEXVQU4NWqb6kouoDS2Vi2C+JEl7NVvuy1Ija9wQra
         y+dHCIRmd4BIciTMmJSV8Yrn/O6E/pJlvV18Tj9GaFtCTPXadb2mXsyiusf7yia2hZC9
         xCoqNABBEUUNxhF3AC9HXWHTc0wqfYd+DXgAd9YfNe7fvPLPc/3Qy/vQAkXzaifFbnf6
         jjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=II7TnOjvS5CtTkXe+SHzNJQOjS3m0MYW+d5C0dNHj6U=;
        b=MHyEZAU3jEXG7SDRszevr4Mhr0x8zigAihubL/QfGhAGat7lNeq81YCvr8WI3V06Pe
         5LlEqZJIbBU2lsmhRMzS7qa49TWJqrmmMevq/dVDOXaUe1xxH3gaRa+TEaPbQRCvUcKs
         JHFKAb8BmR8k+9nH9S5vAQZCc/ghMCs/vQl5/sbaOOGM6sFq9rgPEXokEsdfmI7i4xZ+
         DAryrs3dPpS9HlORNfMCUdKZCEtYBmmQXxxgnNMTsehHIp0B1Ek26OAI1NigrpEYDcG7
         oe+R7TfOrwjSoDAKsxPhE2sTes02cfikIuiip/MxrmPxVjkbhUf/eTAvLS0PxFDpkR+H
         XUAw==
X-Gm-Message-State: AOAM530dX03qqGxfBEjZ8E408Bb0gTGqIeU46n4NR7WsY0YCEkDnCDKz
        OPEHzAXTtWmWIdMhM0oRlsKbCK8UOQ/GWQ==
X-Google-Smtp-Source: ABdhPJzS1J0XmFeES6HPqMQanuslDe/mFRMqlEj9fx3i5l8tl6l2DUSrOT41mDTzvYzY78K4TNl3Ng==
X-Received: by 2002:a05:600c:4e51:: with SMTP id e17mr4345669wmq.127.1637681921956;
        Tue, 23 Nov 2021 07:38:41 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c23-b916-4400-b786-57bd-b8fa-4b8b.c23.pool.telefonica.de. [2a01:c23:b916:4400:b786:57bd:b8fa:4b8b])
        by smtp.gmail.com with ESMTPSA id g5sm18281696wri.45.2021.11.23.07.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:38:41 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 0/4] Remove device * in struct
Date:   Tue, 23 Nov 2021 16:38:34 +0100
Message-Id: <cover.1637533108.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove "device *" in structs that refer struct dw_pcie or cdns_pcie. 
Because these two struct contain a "struct device *" already.

Fan Fei (4):
  PCI: j721e: Remove cast of void* type
  PCI: tegra194: Remove device * in struct
  PCI: al: Remove device * in struct
  PCI: j721e: Remove device * in struct

 drivers/pci/controller/cadence/pci-j721e.c |  14 ++-
 drivers/pci/controller/dwc/pcie-al.c       |  10 +-
 drivers/pci/controller/dwc/pcie-tegra194.c | 109 +++++++++++----------
 3 files changed, 69 insertions(+), 64 deletions(-)

-- 
2.25.1


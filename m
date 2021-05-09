Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C140837751A
	for <lists+linux-pci@lfdr.de>; Sun,  9 May 2021 06:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhEIEWY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 May 2021 00:22:24 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:42627 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhEIEUh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 May 2021 00:20:37 -0400
Received: by mail-lf1-f44.google.com with SMTP id c11so18502172lfi.9
        for <linux-pci@vger.kernel.org>; Sat, 08 May 2021 21:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7V+sBnIKbjfVQS3jF+R6AdG0BzhtjMIvdu4ml37T1pw=;
        b=CozUDrCTEd5MOx1ZN9CZqG1+kVhpPaIrrVOdxd2S2BvYIJACEwWlJErVbRucJqoL5p
         OQXAzJT/WdZUSP/wLZL4rhsZhwG9A4rI62rKVmrJsAHlTS/9nVCNRpqHtRBy0uPY1G4c
         DBkQ64qd0hfmCtkLJ+So+cl+3MXvFjqm97NyDaaYGpCdrhvfr0AMzE54hMAye4YrMFfC
         fz0JYx61Pha8bb0TZaRK/9xNJdYuycWbUIzKcW8nGYkQ3h9nRnF6rlHZG31VYcvLR5Y8
         FUq/ROVGSeZ3AxmoSe8YqyKhkWFsu9CoTAxxBYIOQmq1DG9JY1Y9dS49NcNd83dXakkw
         7mRw==
X-Gm-Message-State: AOAM532B9fXRV+y+ED8X6/CJ61HnRXkNnwzMLghfvNkmeUhCJJQYJGnY
        hlsF2LaFup5ODQYsJdSJdJpiMp0GV3I=
X-Google-Smtp-Source: ABdhPJxetlX5bLBZ7QfSJfGE5kP9hRpw9/eY8z2bxJ0IDvr8+YGVnS/UKhb4ZgRP0cGHpelLavfQEA==
X-Received: by 2002:a05:6512:3888:: with SMTP id n8mr12384793lft.407.1620533973734;
        Sat, 08 May 2021 21:19:33 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id 17sm1852269ljz.87.2021.05.08.21.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 21:19:33 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: microchip: Make the struct event_descs static
Date:   Sun,  9 May 2021 04:19:32 +0000
Message-Id: <20210509041932.560340-1-kw@linux.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The struct event_descs does not have any users outside the
pcie-microchip-host.c file, and has no previous declaration,
thus it can be made static.

This resolves the following sparse warning:

  drivers/pci/controller/pcie-microchip-host.c:352:3: warning: symbol 'event_descs' was not declared. Should it be static?

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 89c68c56d93b..fdab8202ae5d 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -341,7 +341,7 @@ static struct event_map local_status_to_event[] = {
 	LOCAL_STATUS_TO_EVENT_MAP(PM_MSI_INT_SYS_ERR),
 };
 
-struct {
+static struct {
 	u32 base;
 	u32 offset;
 	u32 mask;
-- 
2.31.1


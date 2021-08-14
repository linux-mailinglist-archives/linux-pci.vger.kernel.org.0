Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329C63EC4EA
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 22:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhHNUM6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Aug 2021 16:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhHNUM6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Aug 2021 16:12:58 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AC7C061764;
        Sat, 14 Aug 2021 13:12:29 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so26000620pjn.4;
        Sat, 14 Aug 2021 13:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rDgMpLh6S0Ii5yp8lY9fJm3mRqVMT3dMfi+1501R1JI=;
        b=NCEUajufsAyo1s7ZnEpw6RUmDycBnniOaJSu9ckhKicsEydOzYa/gPsNi4VdnTHeV1
         yZop2s2LnbyQWGilcBU+jnWyAXD/n1DucAUth9boji2bp3Yr+RITSK22Gk+i0ifgQ2dU
         7j3wVkm0ZUTp3cqZep8mSOAoPDGT8E5aXYiFU2gpc1LNp9wA/baVEpUR39aplc5umm+k
         ixK6xWErLtqwzCGRqAOOFOfBZlrzVK9tEkZ9K+W2+/z/VuoZaTe8glcuYQxYzEiyNMKT
         IGSyTXzSKvCCe3KeIthNZlMtYIoKTc7ojIy7N2hF5hLgE5lFDLQbRxA6hFcmJUUrB2Db
         8J/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rDgMpLh6S0Ii5yp8lY9fJm3mRqVMT3dMfi+1501R1JI=;
        b=t17jy3i83LM7iyqfG0NW/BAtD2XTkNyUFw8uQHhedxXUrVKIhfndirvcZxQ4CKMVG9
         xTuo98jm/lJbGUt8mh90k1GdcLEgqdQCVWYlsImI8c0Q8KoQ4sE+yd9HFEUaW9vX8CB5
         7hhGFHYaqIuvnQfgg+6dUqJFKehTnVaoRdIhzIeEo8TJEDYLVz6wT6RTAIvzweVMZrRM
         vH5jyb14QJbaQ+cUroBPLf3dwEwzRcFdmS4HRitqj2jjYDLpttsuNvMwvRMnztVbBxHJ
         tLwLjhnV62tmF810WUOwsxDjLut1WLi1RZt8Q1AKW2pMYW09a/q4C4PTSdHVSz/phrbH
         5waQ==
X-Gm-Message-State: AOAM530SFBZ9Pe9FSEB4V4DejPY9+rlqFjFHExxy55C+uIO6Ro4XXt8t
        cHYQGm2JrBhoRi97ehztdvw=
X-Google-Smtp-Source: ABdhPJyHK7onHOgyClk8xU7QGYMvDphzf9FfYKc9Fvr2V2WsHqK9frd9u/OQwSq6N6Kg6xb87SwEQQ==
X-Received: by 2002:a05:6a00:2305:b0:3e1:9cb3:7b77 with SMTP id h5-20020a056a00230500b003e19cb37b77mr76074pfh.80.1628971949070;
        Sat, 14 Aug 2021 13:12:29 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id r14sm6511132pff.106.2021.08.14.13.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 13:12:28 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Shuah Khan <skhan@foundation.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] PCI: Symbolic permissions 'S_IRUGO' are not preferred
Date:   Sun, 15 Aug 2021 01:42:05 +0530
Message-Id: <20773257ec9af9ea2788f1bca9da5dc1e8ec3f4f.1628957100.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628957100.git.aakashhemadri123@gmail.com>
References: <cover.1628957100.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix checkpatch.pl WARNING: Symbolic permissions 'S_IRUGO' are not
preferred. Consider using octal permission '0444'

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/pci/slot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 6ee4ccaf30b3..a9678589ed23 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -86,11 +86,11 @@ static void pci_slot_release(struct kobject *kobj)
 }
 
 static struct pci_slot_attribute pci_slot_attr_address =
-	__ATTR(address, S_IRUGO, address_read_file, NULL);
+	__ATTR(address, 0444, address_read_file, NULL);
 static struct pci_slot_attribute pci_slot_attr_max_speed =
-	__ATTR(max_bus_speed, S_IRUGO, max_speed_read_file, NULL);
+	__ATTR(max_bus_speed, 0444, max_speed_read_file, NULL);
 static struct pci_slot_attribute pci_slot_attr_cur_speed =
-	__ATTR(cur_bus_speed, S_IRUGO, cur_speed_read_file, NULL);
+	__ATTR(cur_bus_speed, 0444, cur_speed_read_file, NULL);
 
 static struct attribute *pci_slot_default_attrs[] = {
 	&pci_slot_attr_address.attr,
-- 
2.32.0


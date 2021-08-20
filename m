Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E533F3686
	for <lists+linux-pci@lfdr.de>; Sat, 21 Aug 2021 00:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbhHTWjB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 18:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbhHTWjB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Aug 2021 18:39:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B308FC061575;
        Fri, 20 Aug 2021 15:38:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d17so6749520plr.12;
        Fri, 20 Aug 2021 15:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NUnIWkyil9TlIibxeGOppyJEEJ5wkYDGUjyoyMGRPV8=;
        b=C5JDN9b81MOBbZHDPpdM8rCcw2swD4uCwRFNdYVUniP6pZz5CbXgk5c/r1ttBRauCX
         aRNvDec44Zhns3NOVEBSY4YKoGeTrCJmBnRvA6r3Oo1/qCkO/4CtqU4vHuS197FLjfoP
         4xDwtC0/wogOpHX9zj7XlMMg9DzA/LBiqgLjXAjbDWF3rnDYV2pY850g1ppHJ0R2jU4X
         PLiStRKK9N5KUjUajcuJbnEmkNBaywuY7G0T+W0+TWlEaeAFWI6jVF4084PPyt1jr6p5
         elNhIaqh0avIWhBqZ8PnOwDng/FtVoZMywkbPHVGqyvgofCyW2uQdRR2nduM/jx9FAiZ
         lMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NUnIWkyil9TlIibxeGOppyJEEJ5wkYDGUjyoyMGRPV8=;
        b=poF73Yd5xDZtU9AuIc+aMqGkDoB+EyZcxhjA0udj0FONu+a4lY3cDqw5KJVfvYnNT8
         Pjad5nLYwqIbyZN5xJD2PB+sAzAGqVO+p8FWnAv6uMLNJna7mBQGarINdqrRjIO4H5tB
         jg0eYFXQlwGemwuk81OK3w3DDGcQaKXmtgebkF6rZjApm1JlaQQn4ALNS25tzNwI6wII
         TRstesudZCdSZRNhZ8vkDvO511RRfjPhdQ+kQ4ZQeq3lGfNkyt9hR7T4XL7d1ZMjcQ4f
         zYd9n2iDdChxqgFSP5DGIns1yKUgPp43jdckGpQDPOAYeHfeMwCdxJq9yp7oWWgGXeuS
         fjFQ==
X-Gm-Message-State: AOAM532/28QjU68dW7SHyL9MiCm31V/66v6Rqz+XMLaa3I2VcMfP3pJ5
        L1sLwlIA5q+0VJ5EW3+9ZlQ=
X-Google-Smtp-Source: ABdhPJyLzYuffz1IgHWesUtfZmF6TPBWkkgMGVQhOKtm5jV/CgwTSIniNr1CfrS6WJj+DxEdqqiuWw==
X-Received: by 2002:a17:90a:2e0e:: with SMTP id q14mr1090277pjd.16.1629499102372;
        Fri, 20 Aug 2021 15:38:22 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8916:5000:a761:e8b4:dc09:1a0e])
        by smtp.gmail.com with ESMTPSA id y12sm8807619pgl.65.2021.08.20.15.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 15:38:21 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     21cnbao@gmail.com, bhelgaas@google.com, corbet@lwn.net
Cc:     Jonathan.Cameron@huawei.com, bilbao@vt.edu,
        gregkh@linuxfoundation.org, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxarm@huawei.com, luzmaximilian@gmail.com,
        mchehab+huawei@kernel.org, schnelle@linux.ibm.com,
        song.bao.hua@hisilicon.com
Subject: [PATCH v2 2/2] Documentation: ABI: sysfs-bus-pci: Add description for IRQ entry
Date:   Sat, 21 Aug 2021 10:37:44 +1200
Message-Id: <20210820223744.8439-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820223744.8439-1-21cnbao@gmail.com>
References: <20210820223744.8439-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

/sys/bus/pci/devices/.../irq has been there for many years but it
has never been documented. This patch is trying to document it.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 793cbb7..8d42385 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -96,6 +96,14 @@ Description:
 		This attribute indicates the mode that the irq vector named by
 		the file is in (msi vs. msix)
 
+What:		/sys/bus/pci/devices/.../irq
+Date:		August 2021
+Contact:	Barry Song <song.bao.hua@hisilicon.com>
+Description:
+		Historically this attribute represent the IRQ line which runs
+		from the PCI device to the Interrupt controller. With MSI and
+		MSI-X, this attribute is the first IRQ number of IRQ vectors.
+
 What:		/sys/bus/pci/devices/.../remove
 Date:		January 2009
 Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
-- 
1.8.3.1


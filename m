Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30CD7200C7
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 13:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjFBLt5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 07:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbjFBLtp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 07:49:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E966A10C6
        for <linux-pci@vger.kernel.org>; Fri,  2 Jun 2023 04:49:16 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-514924b4f8cso2837923a12.3
        for <linux-pci@vger.kernel.org>; Fri, 02 Jun 2023 04:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685706536; x=1688298536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PIsP178Wnb1M5epQp5PS0aVEa7SerWOVU16+rPTld8=;
        b=bX54vfk4QiyIOjgJw96WITCRP//0S5DdbOQqlc5XByX+tAEA0Q3niUHKDrbpHgaKnX
         t4Ey+o8Iyucw9gdqVWfgGZVv+6CbsRvsrOX+Y5IlzmVssOmXmd/gWOzkkw9K423SpYMb
         3Xy1MVuzjhZVvcJMH9oWeszn0WtEjBdNO4bjmT1Y7dc5gRjQJmy9FMzCWxxge7tFdNNa
         jqUgh9yj18SrOtinjF+OuWr2EIxPAnCJLASsXzfsOUk6YwgiQXyCH1q/qFXmjRiMLXP/
         r0mQL4PcLZQa10fF0WiTuNoGVGDfYB7UPAUC7c54kjK4rf1YLDxwRAj0IgPj2fwJZoRx
         SU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685706536; x=1688298536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PIsP178Wnb1M5epQp5PS0aVEa7SerWOVU16+rPTld8=;
        b=N4Pm8ObElleaJw0S6FhjJqsqqo3E9jci7KV7NrrPJ/UVqN1k84MPgRFDLIcgdV9G+Q
         CZNaF48DFIWzf9t3mGzI6bKXE4Gt/wOeT+2/WCwxVhLyftN/Fv4jeQuWxZhrmCGfjxXl
         yoJbavpff6LIEL1I8XuRy75Wz+aNc9RlmncUS+ehbvC1Vh7/qFQqvAbXfcpa3+USVmhl
         ygpHE0Sjg+DhwZxW6l6h690/lGUpAaTWUx306Opz6/FSyQzTDbhnqNDuPMMLe9ll/t25
         ojuaTQwU9+AszR0t2NCFDjbN2xct/r8+rgTG06fMnbhQot3Qdk56niHoNMfG+gAKKPAO
         fgRw==
X-Gm-Message-State: AC+VfDwx19czu1w5ShxS5/l4IqtB3sJ98obhUScaJ2/RgIYGAEiUzliU
        lnQSgp+qm804OqI1ljUVoMWvJmaBBX9nwYQ2mg==
X-Google-Smtp-Source: ACHHUZ53ynAHXabcZM7EkPvDXz3Iy1IWTmpkAvx0BwE7Fn5WGDODOFNc0zh2UxA3JOD/U5gGBwYOAg==
X-Received: by 2002:a17:907:746:b0:96f:98f1:6512 with SMTP id xc6-20020a170907074600b0096f98f16512mr9044597ejb.41.1685706536610;
        Fri, 02 Jun 2023 04:48:56 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.79])
        by smtp.gmail.com with ESMTPSA id qu25-20020a170907111900b00974530bb44dsm658924ejb.183.2023.06.02.04.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:48:56 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dlemoal@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 9/9] MAINTAINERS: Add PCI MHI endpoint function driver under MHI bus
Date:   Fri,  2 Jun 2023 17:17:56 +0530
Message-Id: <20230602114756.36586-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
References: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCI endpoint driver for MHI bus under the MHI bus entry in MAINTAINERS
file.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 07625a47cf08..a4ac2d567334 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13630,6 +13630,7 @@ F:	Documentation/ABI/stable/sysfs-bus-mhi
 F:	Documentation/mhi/
 F:	drivers/bus/mhi/
 F:	drivers/net/mhi_*
+F:	drivers/pci/endpoint/functions/pci-epf-mhi.c
 F:	include/linux/mhi.h
 
 MICROBLAZE ARCHITECTURE
-- 
2.25.1


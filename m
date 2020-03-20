Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8DC18D73B
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 19:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgCTSff (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 14:35:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34667 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbgCTSfe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 14:35:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id i24so8352976eds.1;
        Fri, 20 Mar 2020 11:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vIkIba5yrwVRrMdfHsC9bC4Dc1Q+7/++OIDqihMLycA=;
        b=hCGk/jVYjEZCAOBohOOeMYyoBQDHMGBiV6rI3SVrRO/2gdztYyGdel8i/VU3u/aE3W
         RWOpreqbE2Ko5vsminzQJ6yqceF99d2arHGibdzEYElta+VCpq6ji5xN4ug1JXL/c1cM
         Nl4Y3U4PApwSMzNwVnzKrQm7CSY7f/jKvHBhiZ/8kdjBzSe/tGhnHzqDxy5zUPlSn5gs
         wuVhfWWx9UFcd1wBYuPuEIY+8IKLqxW1lgXInA3qX1rNPQ4oXFkphTANtgOOJc3eyU0p
         xZhnQoCEKM8qyYAG6KSuw0DeK9vj/kGJQ8ChKvfixsS3/1R3bpl3HgcK+YNfRv6JQzrT
         bS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIkIba5yrwVRrMdfHsC9bC4Dc1Q+7/++OIDqihMLycA=;
        b=AB+URw5LvaoCGne5rfepDSOurOXprcwKCJKxXwvVfnCQ5fF21pYclUa/vXzxjSnNAM
         wc7wpSe7Q7tzPv4g37K7ykA1JW3JjTz6Lk7TglU2Jih4XhV3Fl5DzIiZcKv4bX3Z455O
         c6CoghQjfJYYOEOpHxgQLly4tGUjxgsjM+qBs6Dg9wqzSlhaW4EosUzDFYjX1CNonw2m
         67V5wizjRg2r4Ul+t+dbSn/3n8ui/sXEfkvkaj4ByP6eguWBykJv8N54ArGaAR5hF7G6
         hLBHw+zpBpZBrLi4+5GknUySMDko93AY3LutxhQ0zK+C2buncJOh/NYLQmHmPE8JocSH
         HiNA==
X-Gm-Message-State: ANhLgQ2tnlsahq55OQLKCpTtwENHECNvDDnxar5RVjAW+tmwqJcJ2iSB
        h08GtHUtNvatZKsweE9yO62GdvZZw/cU1Q==
X-Google-Smtp-Source: ADFU+vtNjpgtxH+XdaUlqd8Yf60xpBieWuHvqh6Z02I3Ls1eENZsGd+V1t0kMzZabSIyy4GPEv8B7Q==
X-Received: by 2002:aa7:dbd8:: with SMTP id v24mr9658834edt.366.1584729331925;
        Fri, 20 Mar 2020 11:35:31 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host203-232-dynamic.53-79-r.retail.telecomitalia.it. [79.53.232.203])
        by smtp.googlemail.com with ESMTPSA id y13sm172916eje.3.2020.03.20.11.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:35:31 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] devicetree: bindings: pci: add force_gen1 for qcom,pcie
Date:   Fri, 20 Mar 2020 19:34:53 +0100
Message-Id: <20200320183455.21311-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320183455.21311-1-ansuelsmth@gmail.com>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document force_gen1 optional definition to limit pcie
line to GEN1 speed

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 8c1d014f37b0..766876465c42 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -260,6 +260,11 @@
 	Definition: If not defined is 0. In ipq806x is set to 7. In newer
 				revision (v2.0) the offset is zero.
 
+- force_gen1:
+	Usage: optional
+	Value type: <u32>
+	Definition: Set 1 to force the pcie line to GEN1
+
 * Example for ipq/apq8064
 	pcie@1b500000 {
 		compatible = "qcom,pcie-apq8064", "qcom,pcie-ipq8064", "snps,dw-pcie";
-- 
2.25.1


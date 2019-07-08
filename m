Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B00861E79
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2019 14:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbfGHMeB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jul 2019 08:34:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39670 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGHMeA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jul 2019 08:34:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so7552908pfe.6;
        Mon, 08 Jul 2019 05:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M47eeUNCN4SVfJom0OnKhMR7q6xYFkcCTnLQCxdI5ls=;
        b=WFxZsfomA29eOc/Rm/2BZReRzhSvw45FcB4cFwTAjWKoGF8d9mLHcKgTNipt38kg0m
         +CwdcFESFE6YiVHuAM5DM9/S1wBzDe1Z3tZ2Nvi9Gtmuni78moINmU8+2bei2cuCf5tF
         khW2yHX3NeOQe4GYXeaAZvhGS/mcuDvq4ZSG+VP8CPs5ntbOl7lOcucnupCpRuV+aQwf
         GObhIfe+jx1UhCMc1IIi10sJJKXJNBfKQMhxumt3AYah0i8sXn02ifBoetlAQwYH00op
         HRmDL3PAQzoLPy6X4+xClmEwOrz9astlnt+4PmfpvcNrtCOXngZnn+5aRVlj4HeMJloq
         T1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M47eeUNCN4SVfJom0OnKhMR7q6xYFkcCTnLQCxdI5ls=;
        b=SxUz3sU3ye2uxku5tQgUW3D6A/r1kodLbChQKnRZiXusPrHElz4mOrocqbxPs5bJal
         fG0EbuNSYbLZAJedoVhE7rMLwPNRtLydNFEQWdaiFufRQpCUyu40nxmvC06V4Kkr1G1x
         TTbatMHDUhzk5ZF9h60RcXwcFFQNH+NEKohTzQI+14l1/3rnxe1SHIDLXkP2ODHKMmSg
         mxZvo5KCIeq28FvKNpNk6PdRdqVUSqJ3yANvtET9o/MGKQK+lcbZEiGv6HfgTVy3w+cB
         e02u51KlSJOqiJS3e96vJi1zkRYKJNvXHfkOJhJXKkp+PFzE8hDu8UP/P/NDqyvQHXtB
         ODxg==
X-Gm-Message-State: APjAAAXKvWpMmUQ77BJ6t/0vFwtJMcLf6w016AQykIzKxCQkZoq7UVR3
        /n54Tff1PggU/rauoElDt5s=
X-Google-Smtp-Source: APXvYqwT85qiQbjKYhVI6Utl22oZLWmhnzAVfEG2zxIim+b4MbMsEhdmIj6QoWsXZOx3ojsq50zs9g==
X-Received: by 2002:a17:90a:a489:: with SMTP id z9mr24384234pjp.24.1562589240312;
        Mon, 08 Jul 2019 05:34:00 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id i124sm38232388pfe.61.2019.07.08.05.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 05:33:59 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 11/14] PCI: Replace devm_add_action() followed by failure action with devm_add_action_or_reset()
Date:   Mon,  8 Jul 2019 20:33:54 +0800
Message-Id: <20190708123354.12127-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

devm_add_action_or_reset() is introduced as a helper function which 
internally calls devm_add_action(). If devm_add_action() fails 
then it will execute the action mentioned and return the error code.
This reduce source code size (avoid writing the action twice) 
and reduce the likelyhood of bugs.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/pci/controller/pci-host-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index c742881b5061..c8cb9c5188a4 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -43,9 +43,8 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
 		goto err_out;
 	}
 
-	err = devm_add_action(dev, gen_pci_unmap_cfg, cfg);
+	err = devm_add_action_or_reset(dev, gen_pci_unmap_cfg, cfg);
 	if (err) {
-		gen_pci_unmap_cfg(cfg);
 		goto err_out;
 	}
 	return cfg;
-- 
2.11.0


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2E0919393A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 08:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgCZHIB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Mar 2020 03:08:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37966 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgCZHIB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Mar 2020 03:08:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id s1so6399767wrv.5
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2020 00:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=H2TUyOy7hFlU1mihaYKviLCAQGjbqgsYp50LlzLi1G8=;
        b=YV/YEVucTc4tJe8tVRyZyeopa1bFmsBloz1o8vb0870H7+lU3KBrDXwvdLOMqy7+YH
         PE5wla7gtriZfVzj9J+HE2BVnmMQ4nOcQiOLGgQ3anptlmmGu1EQguydcMw1hd6+e2W9
         7PbMRQG5dPaHvtk9Ou+4gszYCAHp6yVusqQsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H2TUyOy7hFlU1mihaYKviLCAQGjbqgsYp50LlzLi1G8=;
        b=IlsH4qjVwKxCHZfFJl3MDVdW/3EeRbzijj+iPmL3YVJwqsQIcaeAOLyd6rl0adlW2j
         EOBqN/rTenJ/x2mP6f8T5JbgsoZi2ryZZYZzefPxgf7oaswhdgRPtVJLdNqBOZI5oF9j
         j+FV4CAj8q7UyKvI4YCGYw73+bwQtkcRvDOjvglS+FnIPfRD4x+CluEM6TCEkZZRRq8N
         0b8sDFmrMYnBPWIZj3XdZEZ/zejmkcGX45aIxGmzVXHAuZlgG8rZJWWM1zLXFjOLvJnI
         UnNZBCU23y/gbyibQUy4tMPnrGmwzRZPmQzpfrtQQBl6VrNR6FC6kz3/ws1MAyHbvtm6
         qz9w==
X-Gm-Message-State: ANhLgQ3H3RY0YXlc/9UYeCfgLFFXexhigZxindbGMblyzUjIfmhJr3f3
        0ahQOh4j6wYlf4lhzGjVEv/Fuw==
X-Google-Smtp-Source: ADFU+vtoVFnc/MkSSn13lthBxGx1jDdqQOH+rCgiBTbCYRQZtgcw9pqUOFvmC34OnQDJ702CVYW4rw==
X-Received: by 2002:a5d:6044:: with SMTP id j4mr7223851wrt.232.1585206479437;
        Thu, 26 Mar 2020 00:07:59 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id u8sm2129446wrn.69.2020.03.26.00.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Mar 2020 00:07:58 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 0/3] PCI: iproc: Add fixes to pcie iproc 
Date:   Thu, 26 Mar 2020 12:37:24 +0530
Message-Id: <1585206447-1363-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series contains fixes and improvements to pcie iproc driver.

This patch set is based on Linux-5.5-rc1.

Bharat Gooty (1):
  PCI: iproc: fix out of bound array access

Roman Bacik (1):
  PCI: iproc: fix invalidating PAXB address mapping

Srinath Mannam (1):
  PCI: iproc: Display PCIe Link information

 drivers/pci/controller/pcie-iproc.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

-- 
2.7.4


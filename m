Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2C032042F
	for <lists+linux-pci@lfdr.de>; Sat, 20 Feb 2021 07:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBTG3Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Feb 2021 01:29:25 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:35556 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhBTG3U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 Feb 2021 01:29:20 -0500
Received: by mail-wm1-f47.google.com with SMTP id n10so9580942wmq.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Feb 2021 22:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0JzuFOhjTPAxCOUJqxrebftEnNwtKMwJNNdlwliQLAw=;
        b=UgxIcNIZh/X2JNFwcocI6SOY9Cc0qgFxFUoBhlBwkv94rrTf9A5CLlZPEToi6t5Tmq
         pdUTZfDH39jNjx1WqFX6cxDXCpQHay/8h8Ml7628tN2eEFGBCDKKbNWAuU3dYteLpkrf
         YqfHgyIBzpzFOID+0Vnhg8FbzNWpaxyTpRXlkS0g2GaxepvrqwQtShs6nRe39yeR/WjJ
         ZveoWsCS7sGQQ88ygzw5b7CmYVy9SIHL/vlRcg5WO3BbEi3/ynj9iEqYxG5rsl5th84U
         YVXStr9QLO9aja6j80c0AsVzGF1R+fD9GYgV/68Pdp5vSIx8RZsu1xK/2ZL9tpR1UDwj
         8JfQ==
X-Gm-Message-State: AOAM530TMdY6s0AsfrnmLNsXacmDy8FSw1v8pInxzC7v2c4NshzZWAyR
        LoblvQSm+Vp1/zbyabEeSgk=
X-Google-Smtp-Source: ABdhPJw+uUyXrQ8LINBtu02Gq0g2VnjEAwORryqjgVZ9pfTUk11xTR+iQl3RwowQQWF2l1anPBVM3g==
X-Received: by 2002:a7b:cf32:: with SMTP id m18mr11236261wmg.53.1613802518720;
        Fri, 19 Feb 2021 22:28:38 -0800 (PST)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y62sm18161262wmy.9.2021.02.19.22.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 22:28:38 -0800 (PST)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI/switchtec: Fix Spectre v1 vulnerability
Date:   Sat, 20 Feb 2021 06:28:37 +0000
Message-Id: <20210220062837.1683159-1-kw@linux.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The "partition" member of the struct switchtec_ioctl_pff_port can be
indirectly controlled from user-space through an IOCTL that the device
driver provides enabling conversion between a PCI Function Framework
(PFF) number and Switchtec logical port ID and partition number, thus
allowing for command-line tooling [1] interact with the device from
user-space.

This can lead to potential exploitation of the Spectre variant 1 [2]
vulnerability since the value of the partition is then used directly
as an index to mmio_part_cfg_all of the struct switchtec_dev to retrieve
configuration from Switchtec for a specific partition number.

Fix this by sanitizing the value coming from user-space through the
available IOCTL before it's then used as an index to mmio_part_cfg_all.

This issue was detected with the help of Smatch:

  drivers/pci/switch/switchtec.c:1118 ioctl_port_to_pff() warn:
  potential spectre issue 'stdev->mmio_part_cfg_all' [r] (local cap)

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [3].

Related commit 46feb6b495f7 ("switchtec: Fix Spectre v1 vulnerability").

1. https://github.com/Microsemi/switchtec-user/blob/master/lib/platform/linux.c
2. https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/spectre.html
3. https://lore.kernel.org/lkml/CAPcyv4gLKYiCtXsKFX2FY+rW93aRtQt9zB8hU1hMsj770m8gxQ@mail.gmail.com/

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/switch/switchtec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index ba52459928f7..bb6957101fc0 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1112,12 +1112,15 @@ static int ioctl_port_to_pff(struct switchtec_dev *stdev,
 	if (copy_from_user(&p, up, sizeof(p)))
 		return -EFAULT;
 
-	if (p.partition == SWITCHTEC_IOCTL_EVENT_LOCAL_PART_IDX)
+	if (p.partition == SWITCHTEC_IOCTL_EVENT_LOCAL_PART_IDX) {
 		pcfg = stdev->mmio_part_cfg;
-	else if (p.partition < stdev->partition_count)
+	} else if (p.partition < stdev->partition_count) {
+		p.partition = array_index_nospec(p.partition,
+						 stdev->partition_count);
 		pcfg = &stdev->mmio_part_cfg_all[p.partition];
-	else
+	} else {
 		return -EINVAL;
+	}
 
 	switch (p.port) {
 	case 0:
-- 
2.30.0


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9FD7E839A
	for <lists+linux-pci@lfdr.de>; Fri, 10 Nov 2023 21:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjKJUTY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 15:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKJUTX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 15:19:23 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E3B3868
        for <linux-pci@vger.kernel.org>; Fri, 10 Nov 2023 12:19:19 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6c431b91b2aso2241766b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Nov 2023 12:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1699647559; x=1700252359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=877Jy/m/x7YTL71XvyVEIgFecU2le8H27gTqlL68z1s=;
        b=NkgkDU3seAfKr/V0kP6mJa5uInvjcrgZmE4Mk68HqMMXmdNiqVZk/QFeXDd3Y+L3WV
         hjDfHBIOcz1Vo8Vdw8nE2VijTXIgf/UZlBNVpOVBECfdIp8DefHkVlUSJdkmWizhOzIq
         yedNleppZ7dUhK9RSeS9ruVP/iQ4xgE2vvDO9qEQZPV5750xYwQytSR1PYjE1kEsI4jp
         GHPMRixhegOaD4umBxR3ylKmZC9Nk7vbY54dvCWRUbztiCHsvjdH/8euJWqpHkr5DcP3
         7SkE39TPY6/SnjleTegnrHxb+b1DpedGHH+xibHkmWeR+BfgvfEoOQJnf1pRcNdtmDuY
         OcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699647559; x=1700252359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=877Jy/m/x7YTL71XvyVEIgFecU2le8H27gTqlL68z1s=;
        b=kosh5SbrPksfZI5SzBx/vXNf3Sr4A3IXMIqcFdOPrkluI7Cz6h/gs3PnbyiHKazUp0
         iKGGUtICCghJoKwKZ3t+DGT27wGOFCzTJEtrwp7e+qW+Ho35fTrnTSxu/T7HjR3X7+0O
         BVjJ+nx/ip6XRDPpOsWuh5gnAoTJ0784qPjUTrg25IljHdzLa47RkbnofaokGRe9bxJ5
         PpIVAHRGXHS4tV9T7qzwg450sik9LR3pMoD2GdZIUyf4LKM3M6E7+xZRn4hzM7fvl5lT
         fatImssuJMfhyfhcTPPQoTtIUkvNrCXzAaMzd4wYNK/4XKWMnquyA0umoiY/xsU3wgxe
         YCUg==
X-Gm-Message-State: AOJu0YyVsBL0eU2rihPOs/bRJs117rYQWPpl0/TYWiWScPHXHGUlrgjq
        4xCKkgLUhXyIPvZxIk350S9p8g==
X-Google-Smtp-Source: AGHT+IE4WzPmieDM4u/N3m65nKNDE4dqzgam6uVwSewTue5dHg2teH6g5IxWJljPuNEU6LLjeAKXBQ==
X-Received: by 2002:a05:6a20:7487:b0:181:1fc8:c5de with SMTP id p7-20020a056a20748700b001811fc8c5demr215814pzd.43.1699647559148;
        Fri, 10 Nov 2023 12:19:19 -0800 (PST)
Received: from dns-msemi-midplane-0.sjc.aristanetworks.com ([74.123.28.18])
        by smtp.gmail.com with ESMTPSA id s18-20020a056a00195200b006c3328c9911sm109547pfk.93.2023.11.10.12.19.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2023 12:19:18 -0800 (PST)
From:   Daniel Stodden <dns@arista.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 0/1] switchtec: Fix stdev_release crash after suprise device loss.
Date:   Fri, 10 Nov 2023 12:19:16 -0800
Message-ID: <20231110201917.89016-1-dns@arista.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello.

Sorry for sending the same set twice in a row, but I found a
typo in yesterday's recipients list.

Here goes a small shell script to crash a kernel in switchtec.ko's
stdev_release.

--snip--
#!/bin/bash -x
# open cdev
exec 3<>/dev/switchtec0
# remove pdev
addr=$(basename $(realpath /sys/class/switchtec/switchtec0/../..))
echo 1 > /sys/bus/pci/devices/$addr/remove
# close cdev
exec 3>&-
--snip--

It worked on v5.10. I believe it has been working ever since. The
problem is that keeping the stdev pinned past the pci_driver removal
will defer the mrpc dma shutdown until way after devres_release_all,
which unmapped stdev->mmio_mrpc. Also, stdev->pdev would be a stale
pointer by then.

Followed-up with a humble proposal how to fix it.

Thanks,
Daniel

Daniel Stodden (1):
  switchtec: Fix stdev_release crash after suprise device loss.

 drivers/pci/switch/switchtec.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

-- 
2.41.0


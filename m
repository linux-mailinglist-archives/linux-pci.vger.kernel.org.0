Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7655B7E8395
	for <lists+linux-pci@lfdr.de>; Fri, 10 Nov 2023 21:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjKJUSV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 15:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKJUSV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 15:18:21 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC888A9
        for <linux-pci@vger.kernel.org>; Fri, 10 Nov 2023 12:18:16 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5b8f68ba4e5so1850219a12.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Nov 2023 12:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1699647496; x=1700252296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=877Jy/m/x7YTL71XvyVEIgFecU2le8H27gTqlL68z1s=;
        b=PrLK3DmdiQFPhQRKwqCEFloq+lqM0OCQPYvYZmgjfI5VRCYZdYDHvZu+bcQNkudQGZ
         BNMOdfz+Xdt34wv4k1Q/o+5WMnZ/96d5sfZmwLQTGDQttIB38kzwduxqChdhh2uiEjaV
         C/cskMq0g6u6Z9Dw0dJpDuwkYMa+ohokM6UosNhGZfeCzrv0EhH0NkH2XPBAh1zRiduf
         Ihj5cQDOYJ3tRLzNU+iA3mK0944NTrA6P4Edkkcx/4zoYHeXFFfLmHYFMWxxGZ7gG6Sw
         +7WDYZioYFGZhy57Yb5ZQLNpDdr8GodhXgGkknpfVJfv8oSPy4fLBxsQP0F+095zHItK
         o+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699647496; x=1700252296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=877Jy/m/x7YTL71XvyVEIgFecU2le8H27gTqlL68z1s=;
        b=vb4MaCfbcluhubl/DornffigbkyHp9rcvLlEY1NQs3ryhyqYsDubfEEC+abD1SUxX9
         1mPbjgGJkyJYE3vNF2maV0NIxWBCsGlaNO6+Xb4ix0egXJnwKsgR5J8zKEfCmiJFF32p
         eQr6L+V0G7CqT14O1VMj2+lwzfWvtenc6kyaM+FVEsqP/qXpMvztAYrSw52q2ssH8UAy
         r6zJpzAXDdRdqavCH3Ka07LRy7ZY4cTV/ec8Y2fs5iSGq4/5mxkLYxnYMKnvLTq/BPEX
         Rssul28PkSJTkT+hTtn4Z3lN0U8REDu7oejEzdk6JxDIBWVoHbUQEkhhdJKXdvi1cX5K
         QAFA==
X-Gm-Message-State: AOJu0Ywj0cuiv9IlLrrhmjbuPqnX3wTNRBqxUWnHUtmt55bHpX7aoO7f
        Vrj4z8B4gkeOgdEeUIbgm2E60NFLURv6gfevedZX2g==
X-Google-Smtp-Source: AGHT+IEO9V/aWQa9tt+0EYZe660iwSHni17qHUC17C4mXYALyl4jslI+Qsz3hgxZj8VK15Ff1lY1bw==
X-Received: by 2002:a17:90b:1c11:b0:280:85a:b425 with SMTP id oc17-20020a17090b1c1100b00280085ab425mr44811pjb.49.1699647496283;
        Fri, 10 Nov 2023 12:18:16 -0800 (PST)
Received: from dns-msemi-midplane-0.sjc.aristanetworks.com ([74.123.28.18])
        by smtp.gmail.com with ESMTPSA id fz10-20020a17090b024a00b00268b439a0cbsm141491pjb.23.2023.11.10.12.18.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2023 12:18:15 -0800 (PST)
From:   Daniel Stodden <dns@arista.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 0/1] switchtec: Fix stdev_release crash after suprise device loss.
Date:   Fri, 10 Nov 2023 12:18:13 -0800
Message-ID: <20231110201814.88997-1-dns@arista.com>
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


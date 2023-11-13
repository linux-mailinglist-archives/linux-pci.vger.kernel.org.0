Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CC17EA56B
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 22:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjKMVWZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Nov 2023 16:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjKMVWY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 16:22:24 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E09AD5F
        for <linux-pci@vger.kernel.org>; Mon, 13 Nov 2023 13:22:18 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6c10f098a27so3792506b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Nov 2023 13:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1699910538; x=1700515338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yB03TM17vbvhZT58Q2SS4TczGT9i9Qi7UUIkyHhWl3M=;
        b=Ldo4Z2pU+waYj5RtdeGrDbvroVPlUq8J8DEnVH0GfzET10oqzBOr/nf6Qo8UEMrh10
         gfyBBaGc79GHRmGawWd4L4Pkln4KKO9iaQrykAnIX/XyQhu2vPI6BbhB722mnmsLbB2L
         VGE86C3OyILzC0luNST/JRy1S+M21m4Qz0aQGFrQmfNa2ojUTPZnyf1kc5ccaRn4U2Rm
         OfYr6UX+0trkqT4XSaGYlC56GX+rYgFFuk9Z6z+zcnbCVk1aT9UGTjsmxwHXICTM5RAX
         za9VLbPs/TZKIqsEg8vhTfv5u+1S5KPuE3WIL5R2Z4D5ZtxmWNHGReWgdGCtOypcnGHT
         Uq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699910538; x=1700515338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yB03TM17vbvhZT58Q2SS4TczGT9i9Qi7UUIkyHhWl3M=;
        b=pqxEIvr0F6QR9sOsT4JdSxo2DhosWmhUOPRR4Ulc1EoThMSgdsBN3SJldZdjbqgzU5
         t3lP5/ji0AjHn/XX9t5H5UCRFdR84zCNVV6aYXSeVF/oD9UVBZu4Is15n8+oej8IuvS9
         y3oCS3xl7obZwHP/sPaEr1dqPKs3Ub+0QcL+wFnyMzngh+mjQd/ZFUy+MrYMEJXwQMH6
         PMsfgqJf1LhBn998Z1zw/PYVlrVmrdsfdGj+5KOA9+2qzZqRvWJorsY1TGvsVjQUiG5n
         eF1zXnZe6SHQxHqe5L7TiQifqc9i/mkBBkfQzRH+lxS3pTnQIJHN/jikr3GJ4NFK9XWG
         2JZQ==
X-Gm-Message-State: AOJu0YxbDVwozg1V7K8mA7tD2U3nrgoyTw+kG4ur95S+CDIPPZO+5DGY
        O28v74yKNYGUCHirXy+MSBS8XA==
X-Google-Smtp-Source: AGHT+IHAexnOpgT0lxSAqBoHrrQk3kG4fyHEKqFXoZeiD6gfuKu33avIXHhES5sba9dXZTo05sZNBA==
X-Received: by 2002:a05:6a00:6c8c:b0:68e:380c:6b15 with SMTP id jc12-20020a056a006c8c00b0068e380c6b15mr6939189pfb.26.1699910537806;
        Mon, 13 Nov 2023 13:22:17 -0800 (PST)
Received: from dns-b876885-0.sjc.aristanetworks.com ([74.123.28.14])
        by smtp.gmail.com with ESMTPSA id k17-20020aa792d1000000b006bc3e8f58besm38794pfa.56.2023.11.13.13.22.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2023 13:22:17 -0800 (PST)
From:   Daniel Stodden <dns@arista.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org
Cc:     Daniel Stodden <dns@arista.com>
Subject: [PATCH v3 0/1] switchtec: Fix stdev_release crash after suprise device loss.
Date:   Mon, 13 Nov 2023 13:21:49 -0800
Message-ID: <20231113212150.96410-1-dns@arista.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello.

Changes since v2:
 * Inline/remove disable_dma_mrpc.
 * Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

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


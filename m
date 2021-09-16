Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D1B40D502
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 10:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbhIPIuy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 04:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbhIPIuy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 04:50:54 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC8EC061574;
        Thu, 16 Sep 2021 01:49:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id q3so13975540edt.5;
        Thu, 16 Sep 2021 01:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RghzY+Kr6ii4zy/l8PSj0jZZ3WiFqsQbVS2VgK2YnCU=;
        b=FTZu4rVpkyKBlyUG3Km0eh5mC1e7ZgAVTEEEJny30aXc/HkndrebRRm6fmjlqK3NwV
         UcicwZa7BSsIbVSblaliDcgdozkaA5kI9M+9ZT+ySuIH8cQG5vTCdYpslo8AIrnGbHpV
         27+5GykYgD3vClydVi05W/VA8W0FTzo/WMAbhooeqwDpzLQQJvtACsZ1dwwcgA36Q4WV
         bjEOWoul3ShyCtPMmquqvkTW5m9CcPSpCKHLusSSbPFHx5v/e8ZwS0820TRfiz1nqqUD
         rh+hlXmOlSx1Yz0Sk/W85LmgjIAiArMOROobrxvu10GXuasK3EDBVfo261PlTKDsCsHc
         1aWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RghzY+Kr6ii4zy/l8PSj0jZZ3WiFqsQbVS2VgK2YnCU=;
        b=rBarTf4e+/v/IDBvMNbmfP2zTRLy55dzzbs3XLPm7VrxKhVCtuFBfSecoRjO/orYCi
         zJD5W1ehx90faxw5oGzx80z8RiSPDftbKZoe/sg5w0RGukKcXIhl50lCHUavOCWXrIJG
         8s9vw961oTxsfqGFfxTbgjrXSJcD+JHV1Kw4i6299Tb9TsRXSX9VY2lu9N0HnOKSyPYS
         HZvaMBl4NdBvFff7VzXV9OuyFdGgdFbviiLGiiTzw2NGjcRjvC5XwH/1brKREmeoHPjS
         BkVvQsYXwnsRUvMNPZ7xji/U9m7guUZkiCbTQNG/XsF7P0gv9HruLJnK79oT9p5QsKoU
         M/Wg==
X-Gm-Message-State: AOAM530qqu2S5GDP1s20ZBOHRP5D+4xbR+z8GAJx2GMTukFj01loQlFk
        JQ+7wL6HlDctdAp3ZVy2jDk=
X-Google-Smtp-Source: ABdhPJw5/UNz2ZEZlE7afoarYctRKgd64tJacrRlyLLIdnI9khDPj2mduIho+XxmxcFNZJAs4T5uOg==
X-Received: by 2002:a17:906:dbf0:: with SMTP id yd16mr5047087ejb.445.1631782172680;
        Thu, 16 Sep 2021 01:49:32 -0700 (PDT)
Received: from localhost.localdomain (catv-176-63-0-115.catv.broadband.hu. [176.63.0.115])
        by smtp.googlemail.com with ESMTPSA id dh16sm1085838edb.63.2021.09.16.01.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 01:49:32 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com
Subject: [RFC PATCH 0/3 v2] PCI/ASPM: Remove struct aspm_latency
Date:   Thu, 16 Sep 2021 10:49:23 +0200
Message-Id: <20210916084926.32614-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

To validate and set link latency capability, `struct aspm_latency` and
related members defined within `struct pcie_link_state` are used.
However, since there are not many access to theses values, it is possible
to directly access and compute these values.
Doing this will also reduce the dependency on `struct pcie_link_state`.

The series removes `struct aspm_latency` and related members within 
`struct pcie_link_state`. All latencies are now calculated when needed.

Changes in this version:
 - directly access downstream by calling `pci_function_0()` instead of
   used the `struct pcie_link_state`

Saheed O. Bolarinwa (3):
  PCI/ASPM: Remove link latencies cached within struct pcie_link_state
  PCI/ASPM: Remove struct pcie_link_state.acceptable
  PCI/ASPM: Remove struct aspm_latency

 drivers/pci/pcie/aspm.c | 89 ++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 51 deletions(-)

-- 
2.20.1


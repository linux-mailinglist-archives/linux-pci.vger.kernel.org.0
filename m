Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A90457722
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 20:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbhKSTmg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 14:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhKSTmZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 14:42:25 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F347C061574;
        Fri, 19 Nov 2021 11:39:23 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v1so13565041edx.2;
        Fri, 19 Nov 2021 11:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2xNNoAi2GIsyk3l3UxgkgmZxFVoCKBDgvYlrq0c7iLM=;
        b=hYo/RTI/s3eBgaG76Z307y4cq5TphEKQjsPtoqUz5gRyXBwnonIGaqckU3hcIcwAy6
         lu/h82xAbX8SE9Pzqw1dhnzQMcNNiUt6UqqpcMffhf3akAwsZuYkm264vE8/0rWtQnXZ
         Xik0HxKR6jt2Xrn47r5XNtiAgOC+TGJI8DZvROiGOE7lvglZC2darTl6t6dic+9u0mRN
         3e7YVil6YBiEHT7jGdISNkL3IiaoXR9akpRQkE5Wf7+0D7cOpyMcrfPyyYQElBtu9+WJ
         IvR/4MqHPIPOlBf4fw+yk/FSAPaLVNIYK6iBAghTZY0l5AK8UJDW+c1kkMiSSYr4T+1E
         sZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2xNNoAi2GIsyk3l3UxgkgmZxFVoCKBDgvYlrq0c7iLM=;
        b=3dduz+e0kkLvvWjshshjlrleCmKWPVyj6lO/FmMVOJnn/QVTBbAsSBitp+72nbQkOr
         KB/rUaXUyc3Hl+sgEI7ndlAA753rWi5KZcQ9G9YczdI5fWkbq9GpszvPt7xZavnqtvPl
         Oho5WpP4IWKgfbTvE5onoKzOoiv8DWuGz4zB+1zi1ZaPi8Uuvwe6UU/1Hz4SRmCx1UF8
         0L+eXpubr+eoCGU7+wUtwHQW6K9uZeMzWJB+ZdvuGKK+5eBbDHT8FMPZqZM7/1f6GQAL
         20S1IIusCdpjhhm6Zvd0fchg3PfHLH77SpdLJUBahCbFmacOZYPCRuCDBeJdEfa+k61d
         p1Mw==
X-Gm-Message-State: AOAM531PidFn5VecY5iSF8lRRIOZ8+iAFrv9zj+G/9LwlNLWREHcbVWT
        jLysmmKEbGPW0JYx01XaSUI=
X-Google-Smtp-Source: ABdhPJwDat8zQQKTl+SsQGumIsyNY9OIbGFSKpXFxEiQVy3Cd+iAk+rXCsXK41mJgJHNjFSzZkRg6Q==
X-Received: by 2002:a50:9510:: with SMTP id u16mr27810395eda.134.1637350761679;
        Fri, 19 Nov 2021 11:39:21 -0800 (PST)
Received: from localhost.localdomain (catv-176-63-2-222.catv.broadband.hu. [176.63.2.222])
        by smtp.googlemail.com with ESMTPSA id sb19sm327521ejc.120.2021.11.19.11.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 11:39:21 -0800 (PST)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, hch@lst.de
Subject: [RFC PATCH v5 0/4] PCI/ASPM: Remove struct aspm_latency
Date:   Fri, 19 Nov 2021 20:37:28 +0100
Message-Id: <20211119193732.12343-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To validate and set link latency capability, `struct aspm_latency` and
related members defined within `struct pcie_link_state` are used.
However, since there are not many access to theses values, it is
possible to directly access and compute these values.

Doing this will also reduce the dependency on `struct pcie_link_state`.

The series removes `struct aspm_latency` and related members within
`struct pcie_link_state`. All latencies are now calculated when needed.


VERSION CHANGES:
- v2:
»       - directly access downstream by calling `pci_function_0()`
»         instead of using the `struct pcie_link_state`
- v3:
»       - rebase on Linux 5.15-rc2
- v4
»       - Create a seprate path to move pci_function_0() upward
- v5
	- shorten long lines as noted in the review

MERGE NOTICE:
These series are based on
»       'commit fa55b7dcdc43 ("Linux 5.16-rc1")'

Reviewed-by: Christoph Hellwig <hch@lst.de>

Bolarinwa O. Saheed (1):
  PCI/ASPM: Move pci_function_0() upward

Saheed O. Bolarinwa (3):
  PCI/ASPM: Do not cache link latencies
  PCI/ASPM: Remove struct pcie_link_state.acceptable
  PCI/ASPM: Remove struct aspm_latency

 drivers/pci/pcie/aspm.c | 95 +++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 51 deletions(-)

-- 
2.20.1


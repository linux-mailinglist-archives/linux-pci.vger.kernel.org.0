Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805D7446F7A
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhKFRz4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbhKFRzz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:55:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC9BC061570;
        Sat,  6 Nov 2021 10:53:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r4so43890395edi.5;
        Sat, 06 Nov 2021 10:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nmb1M9O/JIBM5JUrg6G0Ibis/I8TW93QGKNiMCUrFsM=;
        b=dK/47sibv8Wr60JRe+vl0U19QFJj01MX3+jPN9YGCWYaqlFnJaqAaGb53IiagmbJeF
         GUdExybXDFi+tRldLxTTCG49slMorjaffLMy+swIPeiS5vhV3Dv0m1HDF6/6+iVmPd7S
         yLogCznIi1H2M9Jy25K2DvMUYXJ0x9NUvAE3qfwt/2utUH5YaLQojvrfiY1L0Lq93gSz
         9GNXA3V3muCei7onjWM4Ipdm6erAklN9z+bfaaCNyALf8B5Dsq+71n6pVCgkR+XuyY6U
         i9i2US6s8Bg9n/17iGogixFmCf7R0aDzmLvy9BuivzbY/RUBeMkdURwhCXX2HRD1IeI8
         E+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nmb1M9O/JIBM5JUrg6G0Ibis/I8TW93QGKNiMCUrFsM=;
        b=REp/nYeLURVsSyAXZ4QJG1uk36Jhq03MEMvRnSuwTHX0AO81M+cWaKHSWjBvDkR+V8
         9aHcyrdO/rO/WrZYuXpLW5RB9wAj1ffsQcc1ZogbGB69UvCWeg4lHPR5ZIpNNxuLtn1z
         J3Dson9/QCRuu9/3MLb7LoC6hP0aytbQ5goHe24qMM0Hjmr9Nl4QshY2olCH0s0qcIKX
         P15rz9jd8zIIA7bxu9HvOP2qgkINKJVj/PZyEJZseyvrwr/+s+w/ebi8ARSnJZ/6l3ez
         NceLaZQFHGw6s2HZlZ2qzL5vx79GUZwlkcZbDHHUj3lO737NUQk5anYSqzZrA/GzeJA0
         6YJw==
X-Gm-Message-State: AOAM533xQ6/1UGGmBsgQ2iGmEGfpkgDVBISV/b3uEk7YKEb4t/V056NO
        XdUUQaUwh+3o9uazm3xB4J8=
X-Google-Smtp-Source: ABdhPJzHv10N3qM40sMyShYmNiUwExago3aoXo6D+7aaLg67Y4T0vJ58gBWed3rf3VHs40Wn4Bd0/g==
X-Received: by 2002:a05:6402:5204:: with SMTP id s4mr55795506edd.113.1636221192791;
        Sat, 06 Nov 2021 10:53:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id g10sm6364857edr.56.2021.11.06.10.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:53:12 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 0/4] PCI/ASPM: Remove struct aspm_latency
Date:   Sat,  6 Nov 2021 18:53:01 +0100
Message-Id: <20211106175305.25565-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

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

- v4 (this version)
	- Create a seprate path to move pci_function_0() upward

MERGE NOTICE:
These series are based on
»       'commit e4e737bb5c17 ("Linux 5.15-rc2")'

Saheed O. Bolarinwa (4):
  PCI/ASPM: Move pci_function_0() upward
  PCI/ASPM: Do not cache link latencies
  PCI/ASPM: Remove struct pcie_link_state.acceptable
  PCI/ASPM: Remove struct aspm_latency

 drivers/pci/pcie/aspm.c | 88 +++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 51 deletions(-)

-- 
2.20.1


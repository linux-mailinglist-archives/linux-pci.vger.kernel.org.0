Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C3F3F3681
	for <lists+linux-pci@lfdr.de>; Sat, 21 Aug 2021 00:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhHTWit (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 18:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHTWis (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Aug 2021 18:38:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D36CC061575;
        Fri, 20 Aug 2021 15:38:10 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id m26so9857351pff.3;
        Fri, 20 Aug 2021 15:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0t3/+wgHla4asO76tC2T3DbSJIed/tmO3Dv6nXt2BRs=;
        b=XwHnzh6VBBhPaCDvV4jNRIHc5ZIS5YNrvY21otIRqsNTsls2KlYwyeooImtouH4hOP
         CvpEbYPLskGy8slUEGwAj694fag4YM2b9EMPmCrclDxO5xtIKsxoOXuEAI300kxSIr19
         n4BXgatj5BSzThT0+Pk5OErP7C2my6zzfpnNVg30QU1KoPaE8lupJbu5f5uaP/SJB/A1
         tRoeZduKQrUh0z5YL1+xf+1aTYp+pcHQDs51Q7PfOsR+kXSV7WcsmEquo3UMh7VdQVOI
         z+EDfrhoioHbDI3QoVgjKvNe8P1OKa+fpmBuMYemhjrCcZWQsdKcsZdVFIdDb6UknAiF
         /8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0t3/+wgHla4asO76tC2T3DbSJIed/tmO3Dv6nXt2BRs=;
        b=XmpQYZOpVj/0hXn5Apo9OaFCESS1TBh5YjNHbAoV/OUy08NLLU4yRet9GBqMMZc416
         +qdNGfRBkuzDZ9KRJnnLZLI8/++Ljhho/Wz8zQCx+x/CvgGSVvTryH3uO/okO0BcRc7X
         ql6dnnizfozy3rq7j3gTN8NPpRZ1QAfbxqkTU12qzC30stTEhNdsTuExZDgArbq15ihd
         FBjbDR9ib6akFI6Ve7Nqu3fM9oE/adEN8vZ/j8O3bqtHOEOla8LAcPJw//W2xVfea/53
         eWybkCelwGO0QQBXwOawRm5VoztcQVPP5hSNGRnA0B3JNDgov/ZRBg7lpd+jgsXXjqNu
         tDEQ==
X-Gm-Message-State: AOAM532R88gGnrdeQ0+S6MqYzwDZTtNfUds9LsO9Id0OCR4Q/EvxiNWF
        D0NP2v4/URBEERheyd++WwY=
X-Google-Smtp-Source: ABdhPJwOXHKSeUx0PdJSwy+V/3tz+tSk841hOaPxE6fpRUyNs/eI+elbqM2WFvoPDF1l5qy9lti1vA==
X-Received: by 2002:a05:6a00:228d:b0:3e1:aba4:8e3 with SMTP id f13-20020a056a00228d00b003e1aba408e3mr21945765pfe.49.1629499089926;
        Fri, 20 Aug 2021 15:38:09 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8916:5000:a761:e8b4:dc09:1a0e])
        by smtp.gmail.com with ESMTPSA id y12sm8807619pgl.65.2021.08.20.15.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 15:38:09 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     21cnbao@gmail.com, bhelgaas@google.com, corbet@lwn.net
Cc:     Jonathan.Cameron@huawei.com, bilbao@vt.edu,
        gregkh@linuxfoundation.org, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxarm@huawei.com, luzmaximilian@gmail.com,
        mchehab+huawei@kernel.org, schnelle@linux.ibm.com,
        song.bao.hua@hisilicon.com
Subject: [PATCH v2 0/2] PCI/MSI: Clarify the IRQ sysfs ABI for PCI devices
Date:   Sat, 21 Aug 2021 10:37:42 +1200
Message-Id: <20210820223744.8439-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

/sys/bus/pci/devices/.../irq has been there for many years but it has never
been documented. This patch is trying to document it. Plus, irq ABI is very
confusing at this moment especially for MSI and MSI-x cases. MSI sets irq
to the first number in the vector, but MSI-X does nothing for this though
it saves default_irq in msix_setup_entries(). Weird the saved default_irq
for MSI-X is never used in pci_msix_shutdown(), which is quite different
with pci_msi_shutdown(). Thus, this patch also moves to show the first IRQ
number which is from the first msi_entry for MSI-X. Hopefully, this can
make irq ABI more clear and more consistent.

-v2:
  - split into two patches according to Bjorn's comments;
  - Add Greg's Acked-by, thanks for reviewing!
-v1:
  https://lore.kernel.org/lkml/20210813122650.25764-1-21cnbao@gmail.com/#t

Barry Song (2):
  PCI/MSI: Fix the confusing IRQ sysfs ABI for MSI-X
  Documentation: ABI: sysfs-bus-pci: Add description for IRQ entry

 Documentation/ABI/testing/sysfs-bus-pci | 8 ++++++++
 drivers/pci/msi.c                       | 6 ++++++
 2 files changed, 14 insertions(+)

-- 
1.8.3.1


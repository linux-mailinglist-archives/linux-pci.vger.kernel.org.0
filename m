Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE672A6328
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 12:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgKDLRx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 06:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbgKDLR2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 06:17:28 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BE6C0613D3
        for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2020 03:17:27 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id y12so21608750wrp.6
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2020 03:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QwJRAenGdZ42PlyVXV73a6SJR/jbxK4qTgDqEtZcRKI=;
        b=ZwFav17UiX7OB2VG0aiFLtzFz3I529oV9cElzmWVaa4Fki3EDEYq0iPllVsQgQPmMw
         aepxl/tm88EQ8J5edcxCC1EiBmzWci/DkiJhpUumCiIJq8R4DJGzQubVQBE3eH0oURE1
         zfmemkUAL9P7oo4gnjl3/646srMNRa7nnbkInjO0TAi+FLDq5li9Sf3S+GTbrw4k/jJx
         vNotE/y0ZNZZ6GlIjGOK/LVX0YRmu52LwKEErEcevsAMZRgmtN5JVvEeJU1I6VROaMwH
         Yo9XFaAhz+Ja2x8ENv8aRDaUMCMuVExWvUdKRGk/ONxGSw6p4Z1qS8yrr5ucY+rci7xv
         /rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QwJRAenGdZ42PlyVXV73a6SJR/jbxK4qTgDqEtZcRKI=;
        b=G/0sGBOMMiZJrrPutLPPm15o1v1If1/WhRUTdUlLIDBOFPoigw6qVL+8OVxlpzH8vp
         pPu93iH7JmzM5qm4vOT+ypTaITFPBJ6wCjrlCMgaZg+Z0zfAA1ErOsEAl9XaGEs4B5JL
         gP9itCI7p0xSeEX6N73br3wGdZCOkj84D5QPsO1LeKIueDBIZWTU+MGGW05L04Msjrd6
         VCR5uvQEWROhUc+9ED04iDlWH5bZvT2mEZlyQgUGQwwlGI+wqnBLhoj4P4ONY96DROI4
         j9ZZyRH17iuqjQdGb3nont4a2/uX9qvzMo7yeZp1EZXER7nVriH3+Q8ZymenVdnvN4rL
         H5Xg==
X-Gm-Message-State: AOAM5333j5VH83W3DG/+kTrHaBEUQ+ANON8FsbRB7DUOLabRXi9ph2sw
        0OwCiK67IQ0BZQjBCaY4n5ZNiQ==
X-Google-Smtp-Source: ABdhPJylDyszvDYbcQVFZaKGr+c5qdRrKrG+v/xQYoBbfvNo7aVuD4qNL1hMyV3EIru6EViw62tYGQ==
X-Received: by 2002:a05:6000:4c:: with SMTP id k12mr30555969wrx.278.1604488645803;
        Wed, 04 Nov 2020 03:17:25 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm2090453wro.43.2020.11.04.03.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 03:17:25 -0800 (PST)
Date:   Wed, 4 Nov 2020 11:17:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com, bhelgaas@google.com,
        alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD and x86 due for the v5.11
 merge window
Message-ID: <20201104111723.GC4488@dell>
References: <20201029014449.14955-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201029014449.14955-1-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enjoy!

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-x86-v5.11

for you to fetch changes up to 5ef9998c96b0c99c49c202054586967e609286d2:

  platform/x86: Intel PMT Crashlog capability driver (2020-11-04 11:14:38 +0000)

----------------------------------------------------------------
Immutable branch between MFD and x86 due for the v5.11 merge window

----------------------------------------------------------------
Alexander Duyck (3):
      platform/x86: Intel PMT class driver
      platform/x86: Intel PMT Telemetry capability driver
      platform/x86: Intel PMT Crashlog capability driver

David E. Box (2):
      PCI: Add defines for Designated Vendor-Specific Extended Capability
      mfd: Intel Platform Monitoring Technology support

 Documentation/ABI/testing/sysfs-class-intel_pmt | 119 +++++++++
 MAINTAINERS                                     |   6 +
 drivers/mfd/Kconfig                             |  10 +
 drivers/mfd/Makefile                            |   1 +
 drivers/mfd/intel_pmt.c                         | 223 ++++++++++++++++
 drivers/platform/x86/Kconfig                    |  34 +++
 drivers/platform/x86/Makefile                   |   3 +
 drivers/platform/x86/intel_pmt_class.c          | 297 +++++++++++++++++++++
 drivers/platform/x86/intel_pmt_class.h          |  52 ++++
 drivers/platform/x86/intel_pmt_crashlog.c       | 328 ++++++++++++++++++++++++
 drivers/platform/x86/intel_pmt_telemetry.c      | 160 ++++++++++++
 include/uapi/linux/pci_regs.h                   |   5 +
 12 files changed, 1238 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-intel_pmt
 create mode 100644 drivers/mfd/intel_pmt.c
 create mode 100644 drivers/platform/x86/intel_pmt_class.c
 create mode 100644 drivers/platform/x86/intel_pmt_class.h
 create mode 100644 drivers/platform/x86/intel_pmt_crashlog.c
 create mode 100644 drivers/platform/x86/intel_pmt_telemetry.c

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

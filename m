Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF055295854
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 08:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503648AbgJVG3J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 02:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503633AbgJVG3J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Oct 2020 02:29:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90643C0613CE
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2020 23:29:09 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh6so415076plb.5
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2020 23:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fn7EcRXTiPXrR3fCFPuKVeXnN6edL9iRHKYgvqFBexw=;
        b=sniZa4fM9UMBX9h5eM86Ou5FTdCbhjYoI0ATutjEffufT582S3xlMTGgEI0STl3wBy
         99HmxxzM7tmFAFsBJ6s+42BtZgwrGhoDcg+1p222ZLGEXMSF5RLZJL8870gR8buMYD2u
         SRhn+X+qgzsc6OwdPIhoXchsTODMxYHT+mXhICU0rU44Ur9NURkn+bBsJdx/sr1FoaHq
         K/k3b609gbB8UzqIVuVNsWzcsoCxOmJacAXOMhCXqF8bpnZmtelff3Fp8l2RartmZkX1
         +kmCy33XOa3QCHdRG2AlJjE9xHL0aHMrerCGjeIIXYpR9VPirRMvDn+QNtkBlBK2/iMX
         wD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fn7EcRXTiPXrR3fCFPuKVeXnN6edL9iRHKYgvqFBexw=;
        b=l6nAlFn32mudcfS2Xmel+pAtHUZuZB36pJEUDwU8yoD7FCS7lRWMklT/L0UyfUFsNZ
         pZ3HPE+oCVgy7e/PeHH3Y3JAgznKUYngt0nSqKmCKsRYCLOgiR4mURrDm9NYuFr4LzdX
         Z+EU+i0r0Ai1OyETzFc2AdSW3a0BwfVvxVRqs8ixuMn2KRqUEt64QSZPIXmFxj1RKEFr
         SNLaNrnx3nAkX8XByQz+P/kKCwIKRE/XcKc6Gr8ybHygl0746GXD+5fmaVDUVMeZZwKT
         r3lZQiF8WCCOB/HV43Vy2uFqldND4vEFflA2RLgm/k98NG/ux916unbhpo5CosjOLtis
         29dw==
X-Gm-Message-State: AOAM531MEkUiMvfPcaj5Mfy7Yayjh7m1U5Xr3oowq1+aO5yN4SscuS5g
        9rvc9O1cK86aw1rLFDTBR3s+OA==
X-Google-Smtp-Source: ABdhPJwOA88wBZ7WbrtbBSYM0xztvkxfPu36pKNKV/jex38E67j2BcxXkAw+DkTFPUVzvlToCVD7iQ==
X-Received: by 2002:a17:90a:9904:: with SMTP id b4mr852063pjp.223.1603348149103;
        Wed, 21 Oct 2020 23:29:09 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id q4sm528308pgt.20.2020.10.21.23.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 23:29:08 -0700 (PDT)
From:   Jian-Hong Pan <jhp@endlessos.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Cc:     Jian-Hong Pan <jhp@endlessos.org>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        You-Sheng Yang <vicamo.yang@canonical.com>, linux@endlessm.com
Subject: Re: [PATCH v3] PCI: vmd: Offset Client VMD MSI-X vectors
Date:   Thu, 22 Oct 2020 14:24:53 +0800
Message-Id: <20201022062451.86145-1-jhp@endlessos.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20200914190128.5114-1-jonathan.derrick@intel.com>
References: <20200914190128.5114-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Client VMD platforms have a software-triggered MSI-X vector 0 that will
> not forward hardware-remapped MSI from the sub-device domain. This
> causes an issue with VMD platforms that use AHCI behind VMD and have a
> single MSI-X vector remapped to VMD vector 0. Add a VMD MSI-X vector
> offset for these platforms.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Tested this patch based on latest mainline kernel at commit f804b3159482 ("Merge
tag 'linux-watchdog-5.10-rc1' of git://www.linux-watchdog.org/linux-watchdog").

We have some laptops equipped with Tiger Lake chips and such configuration that
hit the same issue.  They all could be fixed by this patch.

Thank you

Tested-by: Jian-Hong Pan <jhp@endlessos.org>

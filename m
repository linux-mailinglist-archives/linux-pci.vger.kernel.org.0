Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA11467F91
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 22:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353851AbhLCVzy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 16:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbhLCVzx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 16:55:53 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09357C061751
        for <linux-pci@vger.kernel.org>; Fri,  3 Dec 2021 13:52:29 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id n8so3014102plf.4
        for <linux-pci@vger.kernel.org>; Fri, 03 Dec 2021 13:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=qZBZSabmVpVMJlMhIHSKvPqNuRuuyKGfZbUIk3kgfm0=;
        b=rhleK7qheGsItKb6SZxFzzoeXr1uMqV/OMRgj25wk9sVPceFYIln2nx5+eYX5Agnfy
         EhHUXWzsKZzpjY1VZB75V+BZOaXIOnRAzf5ySpaIQIol38NBFNvUxXF2PwwKBDum89tP
         iFTUFoXe3qTDHFqAOsSOwl3KjdYLqoZ8jvIi0CoTctUtc+GU0ZgXs7E5VZ8uiWHsUBXo
         Vnr02NqhXp3RB/LVSg8+pLnKRYuuqzfq1bO8oSvQnjAy6fwHut0zkuZfuBaNU2CsscJP
         SAXaSkpeO6GC3EKlXdH4gxGCAabbuSeKMszLzClFnV6741JPi/2OxF4pCXnWdK9qU14V
         1d6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qZBZSabmVpVMJlMhIHSKvPqNuRuuyKGfZbUIk3kgfm0=;
        b=cTB/N3FDa2czOOjjWFIIoHCCPDngndC7xuWy45Exw2whF+hWHpvdEr+ltycMfCvMaI
         kNTGZ1HwEKpozbOvME3MdWflFC8uGuiHYpElVTkOAsSa1JXN140k9C7MoaE6H4JpXj8/
         wlUGOhsnPgOqMitkNgQVL226pOAiTXE0IP58BOYvhbEIV6h2upsRG+0GaBQGGBuUFSU3
         GOJalRhHWfFWShgK9pZK0e859bPaiyA1tMsnDX92JCVooFPurKxILFBTOFPRg0RXRmEC
         y1AIZdot2VQNVC/Zt9B+pw2L8dqj3/Q39LSXctk5YPS29OzrfYPv+f8E6OI8A+sbFY3l
         1Cbg==
X-Gm-Message-State: AOAM531xYDpb36fTzplmjvk85cpi8zdCoi2qRVuPU2mCdXAoIhq49mg7
        y9fSauz+gJgUCjsjHvLdNAwSpINAPwM6pbdvuLLZZQ==
X-Google-Smtp-Source: ABdhPJyJruIwcpKuFw3KnHAwUYkrH+d1zcMD+o4bTMnt93xzgt3bjIyX4KEMuxzeN8JNpu5v6qF17vuT3ZMNwcaXNWE=
X-Received: by 2002:a17:90b:1b06:: with SMTP id nu6mr17169193pjb.155.1638568348370;
 Fri, 03 Dec 2021 13:52:28 -0800 (PST)
MIME-Version: 1.0
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 3 Dec 2021 13:52:17 -0800
Message-ID: <CAJ+vNU0OZvy4RamHZ18aJ6+AiO3BxXQx-3-sQYop6sF1QRMmwA@mail.gmail.com>
Subject: IMX8MM PCIe performance evaluated with NVMe
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Richard Zhu <hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Greetings,

I'm using PCIe on the IMX8M Mini and testing PCIe performance with a
NVMe constrained to 1 lane. The NVMe in question is a Samsung SSD980
500GB which claims 3500MB/s read speed (with a gen3 x4 link).

My understanding of PCIe performance would give the following
theoretical max bandwidth based on clock and encoding:
pcie gen1 x1 : 2500MT/s*1lane*80% (8B/10B encoding) = 2000Mbps = 250MB/s
pcie gen2 x1 : 5000MT/s*1lane*80% (8B/10B encoding) = 4000Mbps = 500MB/s
pcie gen3 x1 : 8000MT/s*1lane*98.75% (128B/130B encoding) = 7900Mbps = 987.5MB/s
pcie gen3 x4 : 8000MT/s*4lane*98.75% (128B/130B encoding) = 31600Mbps = 3950MB/s

My assumption is an NVMe would have very little data overhead and thus
be a simple way to test PCIe bus performance.

Testing this NVMe with 'dd if=/dev/nvme0n1 of=/dev/null bs=1M
count=500 iflag=nocache' on various systems gives me the following:
- x86 gen3 x4: 2700MB/s (vs theoretical max of ~4GB/s)
- x86 gen3 x1: 840MB/s
- x86 gen2 x1: 390MB/s
- cn8030 gen3 x1: 352MB/s (Cavium OcteonTX)
- cn8030 gen2 x1: 193MB/s (Cavium OcteonTX)
- imx8mm gen2 x1: 266MB/s

The various x86 tests were not all done on the same PC or the same
kernel or kernel config... I used what I had around with whatever
Linux OS was on them just to get a feel for performance and in all
cases but the x4 case lanes 2/3/4 were masked off with kapton tape to
force a 1-lane link.

Why do you think the IMX8MM running at gen2 x1 would have such a lower
than expected performance (266MB/s vs the 390MB/s an x86 gen2 x1 could
get)?

What would a more appropriate way of testing PCIe performance be?

Best regards,

Tim

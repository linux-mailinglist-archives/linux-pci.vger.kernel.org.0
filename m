Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDC235EDF2
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 08:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhDNG6Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 02:58:16 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:38537 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233495AbhDNG5l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Apr 2021 02:57:41 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Apr 2021 02:57:39 EDT
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id C3C2944093E;
        Wed, 14 Apr 2021 09:48:18 +0300 (IDT)
User-agent: mu4e 1.4.15; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Kathiravan T <kathirav@codeaurora.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: qcom/ipq60xx pcie support
Date:   Wed, 14 Apr 2021 09:48:18 +0300
Message-ID: <87a6q1icp9.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kathiravan,

I'm trying to get PCIe working on a IPQ6018 based board with mainline
kernel. Downstream Codeaurora v5.4 kernel PCIe works nicely on that
board. I forward ported the pcie, phy, and DT patches to v5.12-rc7.

For some reason qcom_pcie_init_2_9_0() hangs on first access to dbi_base
registers (specifically PCIE30_GEN3_RELATED_OFF).

Any idea where to look?

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

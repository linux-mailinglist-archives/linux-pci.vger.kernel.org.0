Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7AD59A4E9
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 20:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351140AbiHSRrq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 13:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352062AbiHSRq5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 13:46:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C4B107AE4
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 10:13:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED806B82854
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 17:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7A7C433D6;
        Fri, 19 Aug 2022 17:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660929184;
        bh=Dd2HUsH0MI86l6T258D7rios4LMDmzA41/wv22GexTU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZRxjlzBQKCqqK9sB1Bwd8e+ZcO9mGxc6NQHL+TB5ivtraKu/zSV9gjU5IwzkZSNEI
         FCuQOgFd6v2fqCMBtStpiqL8x+sIKD43Tb5fjlL95LKzETSzOtURVo2Z3uK62pGktv
         97+f7WM7ELlxrKXe/dNx0xblsoUYFHf3KyUdXQWfA/unBQcIZIeA1/zad4unU0KEmp
         NYuPciw8K7dpFAJ35U4ccfnrGvS8FWpFVO/gSssY3oqqeSu9Zt2UQKx/ATgYPzXtnu
         iS/ETwld7SMxtZleVt5WyMvDHoXxiBSxQc6DeCgC4ZCIDdhLKJNN1hF1GDYgQ5GTzW
         OSRAkgA846i3w==
Date:   Fri, 19 Aug 2022 12:13:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tom Seewald <tseewald@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Tom Seewald <tseewald@gmail.com>, Stefan Roese <sr@denx.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        regressions@lists.linux.dev, linux-pci@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Xinhui Pan <Xinhui.Pan@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>
Subject: Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
Message-ID: <20220819171303.GA2491617@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818203812.GA2381243@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 18, 2022 at 03:38:12PM -0500, Bjorn Helgaas wrote:
> [Adding amdgpu folks]
> 
> On Wed, Aug 17, 2022 at 11:45:15PM +0000, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=216373
> > 
> >             Bug ID: 216373
> >            Summary: Uncorrected errors reported for AMD GPU
> >     Kernel Version: v6.0-rc1
> >         Regression: No

Tom, thanks for trying out "pci=noaer".  Hopefully we won't need the
workaround for long.

Could I trouble you to try the debug patch below and see if we get any
stack trace clues in dmesg when the error happens?  I'm sure the
experts would have a better approach, but I'm amdgpu-illiterate, so 
this is all I can do :)

Bjorn

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c4a6fe3070b6..fc34c66776bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -130,6 +130,14 @@ const char *amdgpu_asic_name[] = {
 	"LAST",
 };
 
+void check_write(uint32_t v, void __iomem *base, uint32_t offset)
+{
+	if (offset == 0x7f000) {
+		pr_err("** writing %#010x to %px\n", v, base + offset);
+		dump_stack();
+	}
+}
+
 /**
  * DOC: pcie_replay_count
  *
@@ -512,9 +520,10 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
 
-	if (offset < adev->rmmio_size)
+	if (offset < adev->rmmio_size) {
+		check_write(value, adev->rmmio, offset);
 		writeb(value, adev->rmmio + offset);
-	else
+	} else
 		BUG();
 }
 
@@ -542,6 +551,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 			amdgpu_kiq_wreg(adev, reg, v);
 			up_read(&adev->reset_domain->sem);
 		} else {
+			check_write(v, adev->rmmio, reg * 4);
 			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 		}
 	} else {
@@ -574,6 +584,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 	} else if ((reg * 4) >= adev->rmmio_size) {
 		adev->pcie_wreg(adev, reg * 4, v);
 	} else {
+		check_write(v, adev->rmmio, reg * 4);
 		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 	}
 }
@@ -689,6 +700,7 @@ u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev,
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
 	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
 
+	check_write(reg_addr, adev->rmmio, pcie_index * 4);
 	writel(reg_addr, pcie_index_offset);
 	readl(pcie_index_offset);
 	r = readl(pcie_data_offset);
@@ -721,10 +733,12 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev,
 	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
 
 	/* read low 32 bits */
+	check_write(reg_addr, adev->rmmio, pcie_index * 4);
 	writel(reg_addr, pcie_index_offset);
 	readl(pcie_index_offset);
 	r = readl(pcie_data_offset);
 	/* read high 32 bits */
+	check_write(reg_addr + 4, adev->rmmio, pcie_index * 4);
 	writel(reg_addr + 4, pcie_index_offset);
 	readl(pcie_index_offset);
 	r |= ((u64)readl(pcie_data_offset) << 32);
@@ -755,8 +769,10 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
 	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
 
+	check_write(reg_addr, adev->rmmio, pcie_index * 4);
 	writel(reg_addr, pcie_index_offset);
 	readl(pcie_index_offset);
+	check_write(reg_data, adev->rmmio, pcie_data * 4);
 	writel(reg_data, pcie_data_offset);
 	readl(pcie_data_offset);
 	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
@@ -785,13 +801,17 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
 	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
 
 	/* write low 32 bits */
+	check_write(reg_addr, adev->rmmio, pcie_index * 4);
 	writel(reg_addr, pcie_index_offset);
 	readl(pcie_index_offset);
+	check_write((u32)(reg_data & 0xffffffffULL), adev->rmmio, pcie_data * 4);
 	writel((u32)(reg_data & 0xffffffffULL), pcie_data_offset);
 	readl(pcie_data_offset);
 	/* write high 32 bits */
+	check_write(reg_addr + 4, adev->rmmio, pcie_index * 4);
 	writel(reg_addr + 4, pcie_index_offset);
 	readl(pcie_index_offset);
+	check_write((u32)(reg_data >> 32), adev->rmmio, pcie_data * 4);
 	writel((u32)(reg_data >> 32), pcie_data_offset);
 	readl(pcie_data_offset);
 	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 9be57389301b..b552d7c27ec0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -36,6 +36,8 @@
 #include "soc15.h"
 #include "nv.h"
 
+extern void check_write(uint32_t v, void __iomem *base, uint32_t offset);
+
 #define POPULATE_UCODE_INFO(vf2pf_info, ucode, ver) \
 	do { \
 		vf2pf_info->ucode_info[ucode].id = ucode; \
@@ -900,11 +902,15 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
 
 	if (offset == reg_access_ctrl->grbm_cntl) {
 		/* if the target reg offset is grbm_cntl, write to scratch_reg2 */
+		check_write(v, adev->rmmio, 4 * reg_access_ctrl->scratch_reg2);
 		writel(v, scratch_reg2);
+		check_write(v, adev->rmmio, offset * 4);
 		writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
 	} else if (offset == reg_access_ctrl->grbm_idx) {
 		/* if the target reg offset is grbm_idx, write to scratch_reg3 */
+		check_write(v, adev->rmmio, 4 * reg_access_ctrl->scratch_reg3);
 		writel(v, scratch_reg3);
+		check_write(v, adev->rmmio, offset * 4);
 		writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
 	} else {
 		/*
@@ -913,10 +919,14 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
 		 * SCRATCH_REG1[19:0]	= address in dword
 		 * SCRATCH_REG1[26:24]	= Error reporting
 		 */
+		check_write(v, adev->rmmio, 4 * reg_access_ctrl->scratch_reg0);
 		writel(v, scratch_reg0);
+		check_write(offset | flag, adev->rmmio, 4 * reg_access_ctrl->scratch_reg1);
 		writel((offset | flag), scratch_reg1);
-		if (reg_access_ctrl->spare_int)
+		if (reg_access_ctrl->spare_int) {
+			check_write(1, adev->rmmio, 4 * reg_access_ctrl->spare_int);
 			writel(1, spare_int);
+		}
 
 		for (i = 0; i < timeout; i++) {
 			tmp = readl(scratch_reg1);

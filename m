Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C587D65CADB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 01:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbjADAa7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 19:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238710AbjADAax (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 19:30:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94F0FC9;
        Tue,  3 Jan 2023 16:30:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77A48B81148;
        Wed,  4 Jan 2023 00:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBC3C433EF;
        Wed,  4 Jan 2023 00:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672792248;
        bh=vPbM3MhxjTKcTYkM78QgHrZQnd1wrvAN9sUL799de7s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EjURtQAkGUHOd0HLunHfmoyKHbBYo3KyfFxjhXljTqU9HH/BIRCk+OKQ9BbMK4z6J
         8urdFg6IlNt4S9Zg92q+Gk8Ay806XFsbxl9CPx00vzpSeAMUshNnBn2cW6RX76fzxJ
         r6tdAwIfSZvdJhEqBhGRWiGjUvDcCstotzRD3p+38QIGP9brM32uvzkdZbNaar/JXu
         7mH69MiDZ61XhH8HKBidnNoRM61wU2ZNRUFyughkcIjMDJFcRKXQqT2zgny5eKsKZb
         fXuLImpYATNCRZZb4Q/ezZFvzPnSp/XbZ1o5swEJB2gCvJBxc9qDrr9d2oaxlT02o1
         djnz9xSclnFMQ==
Date:   Tue, 3 Jan 2023 18:30:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Thomas Witt <kernel@witt.link>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [Bug 216877] New: Regression in PCI powermanagement breaks
 resume after suspend
Message-ID: <20230104003046.GA1032131@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102171516.GA783946@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 02, 2023 at 11:15:16AM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 02, 2023 at 02:02:51PM +0000, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=216877
> > 
> >             Bug ID: 216877
> >            Summary: Regression in PCI powermanagement breaks resume after
> >                     suspend
> >     Kernel Version: 6.0.0-rc1
> > 
> > Created attachment 303512
> >   --> https://bugzilla.kernel.org/attachment.cgi?id=303512&action=edit
> > output of git bisect log
> > 
> > After commit 5e85eba6f50dc288c22083a7e213152bcc4b8208 "PCI/ASPM:
> > Refactor L1 PM Substates Control Register programming" my Laptop
> > does not resume PCI devices back from suspend.

Thomas, could you try the debug patch below on top of v6.2-rc1?

Prior to 5e85eba6f50d, aspm_calc_l1ss_info() did these config writes:

    if (enables)
 a    child  clear L1SS_CTL1  PCIPM_L1_2 ASPM_L1_2	# disable L1.2
 b    parent clear L1SS_CTL1  PCIPM_L1_2 ASPM_L1_2	# disable L1.2
    /* T_POWER_ON in both */
 c  parent write L1SS_CTL2  T_POWER_ON
 d  child  write L1SS_CTL2  T_POWER_ON
    /* Common_Mode_Restore_Time in parent (rsvd in child) */
 e  parent write L1SS_CTL1  CM_RESTORE_TIME | LTR_L12_TH # clear CM_REST_TIME 
    /* LTR_L1.2_THRESHOLD in both */
 f  parent write L1SS_CTL1  CM_RESTORE_TIME | LTR_L12_TH # clear LTR_L2_TH
 g  child  write L1SS_CTL1  CM_RESTORE_TIME | LTR_L12_TH # CM_REST_TIME rsvd?
    if (enables)
 h    parent write L1SS_CTL1  PCIPM_L1_2 ASPM_L1_2
 i    child  write L1SS_CTL1  PCIPM_L1_2 ASPM_L1_2

After 5e85eba6f50d, we do these:

 A  parent write L1SS_CTL2  T_POWER_ON
 B  parent write L1SS_CTL1  (CM_RESTORE_TIME | LTR_L12_TH) & ~(PCIPM_L1_2 ASPM_L1_2)
    if (enable)
 C    parent write L1SS_CTL1  PCIPM_L1_2 ASPM_L1_2

 D  child  write L1SS_CTL2  T_POWER_ON
 E  child  write L1SS_CTL1  (CM_RESTORE_TIME | LTR_L12_TH) & ~(PCIPM_L1_2 ASPM_L1_2)
    if (enable)
 F    child  write L1SS_CTL1  PCIPM_L1_2 ASPM_L1_2

Notes:

  - Before 5e85eba6f50d, we disable L1.2 at (a,b) before writing
    T_POWER_ON, CM_RESTORE_TIME, and LTR_L12_TH at (c,d,e,f,g).

    After 5e85eba6f50d, we write T_POWER_ON, CM_RESTORE_TIME, and
    LTR_L12_TH at (A,B) without disabling L1.2.  Sec 5.5.4 suggests
    this may be a problem.

  - Even before 5e85eba6f50d, we write CM_REST_TIME for the child at
    (g), which is reserved per spec.

  - Before 5e85eba6f50d, the write at (e) inserts the new CMRT value,
    but ORs in the LTR_L12_TH values without clearing what was there
    before.  The write at (f) inserts LTR_L12_TH correctly, so the
    result is probably correct, but it's messy.  I think 5e85eba6f50d
    does this better.


commit 98248ea220c8 ("debug https://bugzilla.kernel.org/show_bug.cgi?id=216877")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Jan 3 18:15:11 2023 -0600

    debug https://bugzilla.kernel.org/show_bug.cgi?id=216877
    

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 53a1fa306e1e..398c817858ac 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -552,6 +552,11 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	    ctl2 == pctl2 && ctl2 == cctl2)
 		return;
 
+	pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
+				PCI_L1SS_CTL1_L1_2_MASK, 0);
+	pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				PCI_L1SS_CTL1_L1_2_MASK, 0);
+
 	pctl1 &= ~(PCI_L1SS_CTL1_CM_RESTORE_TIME |
 		   PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
 		   PCI_L1SS_CTL1_LTR_L12_TH_SCALE);

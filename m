Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A603611DB26
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 01:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbfLMAck (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Dec 2019 19:32:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731342AbfLMAcj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Dec 2019 19:32:39 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA10D2073B;
        Fri, 13 Dec 2019 00:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576197159;
        bh=acTKaWoVcvywt0spaT133PNvy41sRxS9SaBK9U3EDXU=;
        h=Date:From:To:Cc:Subject:From;
        b=YFDlAjeWIOLK1gCctzHW6f5B70wPUvFCw5lHAPkP1dJ2c0H4VCym3LVDsjj6oMaxb
         jCf3rJbutKD9z6Gl726KysNnD8FtLjYC8VHkmKubeWHdoytYdM4CYjb6f4pPqUBLJu
         7xEvaUHiMJFsnXK7Cbg5Duj8Eo0VU6m0Rg21tEcg=
Date:   Thu, 12 Dec 2019 18:32:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: imx6 and keystone PCIe abort handling
Message-ID: <20191213003236.GA43783@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi folks,

Why are ks_pcie_fault() and imx6q_pcie_abort_handler() different?  I
think they're doing the same thing, and the "instr & 0x0e100090" part
is the same, but only imx6 has the "instr & 0x0c100000" part.  And the
return values are different in some cases.

Could/should these be shared somehow?  They're both under #ifdef
CONFIG_ARM, so maybe it could be provided by arch/arm?

  static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
			   struct pt_regs *regs)
  {
	  unsigned long instr = *(unsigned long *) instruction_pointer(regs);

	  if ((instr & 0x0e100090) == 0x00100090) {
		  int reg = (instr >> 12) & 15;

		  regs->uregs[reg] = -1;
		  regs->ARM_pc += 4;
	  }

	  return 0;
  }

  static int imx6q_pcie_abort_handler(unsigned long addr,
		  unsigned int fsr, struct pt_regs *regs)
  {
	  unsigned long pc = instruction_pointer(regs);
	  unsigned long instr = *(unsigned long *)pc;
	  int reg = (instr >> 12) & 15;

	  /*
	   * If the instruction being executed was a read,
	   * make it look like it read all-ones.
	   */
	  if ((instr & 0x0c100000) == 0x04100000) {
		  unsigned long val;

		  if (instr & 0x00400000)
			  val = 255;
		  else
			  val = -1;

		  regs->uregs[reg] = val;
		  regs->ARM_pc += 4;
		  return 0;
	  }

	  if ((instr & 0x0e100090) == 0x00100090) {
		  regs->uregs[reg] = -1;
		  regs->ARM_pc += 4;
		  return 0;
	  }

	  return 1;
  }


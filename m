Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2AE211DB4A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 01:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLMAvU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Dec 2019 19:51:20 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38554 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfLMAvU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2019 19:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U/yCdrBeS8qawSt8fr5/pTCJsSZppXePjAIJbFodjBQ=; b=iJas9yV+XFfPNDfDe0uRBgXIk
        5852wR2mDlLu5V3p4b3Qd+Up1xJUaxRvzW6vXlAd+do+YglPFoDxk8vSlh6EDK59S6nKviQWbK5Lc
        yxjqInJezBx2k1i5Zon1Vf/5r6q+oIvDx/OFCegSTYnzy/AODOI4UuwTNYE2nAEPGLvTc5WPEfE/2
        rc1gkljsvGP62aDUII1iUft3deErCXCNL7W6EoM1L6MWkFPqy+2oh5yOD5G7QOJf8uIMvNU2ZILYM
        qGvqL4bGRwACIYcyEsrZmc4PhP1srYqu8Vp6UEECku4SNqhkWMCY/uhjYl4TuWu4W2SMK/Ghy1dD3
        gSud7uyDA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52224)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ifZAl-0001dm-EJ; Fri, 13 Dec 2019 00:51:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ifZAj-0007Ls-Bb; Fri, 13 Dec 2019 00:51:09 +0000
Date:   Fri, 13 Dec 2019 00:51:09 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Murali Karicheri <m-karicheri2@ti.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: imx6 and keystone PCIe abort handling
Message-ID: <20191213005109.GP25745@shell.armlinux.org.uk>
References: <20191213003236.GA43783@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213003236.GA43783@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 12, 2019 at 06:32:36PM -0600, Bjorn Helgaas wrote:
> Hi folks,
> 
> Why are ks_pcie_fault() and imx6q_pcie_abort_handler() different?  I
> think they're doing the same thing, and the "instr & 0x0e100090" part
> is the same, but only imx6 has the "instr & 0x0c100000" part.  And the
> return values are different in some cases.

Here's the opcodes for the three different types of loads that would
be interesting.

   0:   e5910000        ldr     r0, [r1] ; 32-bit
   4:   e5d10000        ldrb    r0, [r1] ; 8-bit
   8:   e1d100b0        ldrh    r0, [r1] ; 16-bit

So, (instr & 0x0e100090) == 0x00100090 is trie for the ldrh case.
(instr & 0x0c100000) == 0x04100000 is true for the ldr and ldrb case.

So, the keystone version only traps ldrh instructions, whereas the
imx6 traps them all.

> Could/should these be shared somehow?  They're both under #ifdef
> CONFIG_ARM, so maybe it could be provided by arch/arm?
> 
>   static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
> 			   struct pt_regs *regs)
>   {
> 	  unsigned long instr = *(unsigned long *) instruction_pointer(regs);
> 
> 	  if ((instr & 0x0e100090) == 0x00100090) {
> 		  int reg = (instr >> 12) & 15;
> 
> 		  regs->uregs[reg] = -1;
> 		  regs->ARM_pc += 4;
> 	  }
> 
> 	  return 0;
>   }
> 
>   static int imx6q_pcie_abort_handler(unsigned long addr,
> 		  unsigned int fsr, struct pt_regs *regs)
>   {
> 	  unsigned long pc = instruction_pointer(regs);
> 	  unsigned long instr = *(unsigned long *)pc;
> 	  int reg = (instr >> 12) & 15;
> 
> 	  /*
> 	   * If the instruction being executed was a read,
> 	   * make it look like it read all-ones.
> 	   */
> 	  if ((instr & 0x0c100000) == 0x04100000) {
> 		  unsigned long val;
> 
> 		  if (instr & 0x00400000)
> 			  val = 255;
> 		  else
> 			  val = -1;
> 
> 		  regs->uregs[reg] = val;
> 		  regs->ARM_pc += 4;
> 		  return 0;
> 	  }
> 
> 	  if ((instr & 0x0e100090) == 0x00100090) {
> 		  regs->uregs[reg] = -1;
> 		  regs->ARM_pc += 4;
> 		  return 0;
> 	  }
> 
> 	  return 1;
>   }
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

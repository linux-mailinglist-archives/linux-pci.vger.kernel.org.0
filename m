Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDBE51321F
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 13:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbiD1LMu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 07:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiD1LMt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 07:12:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4ADD5BE32
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 04:09:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11D6D1474;
        Thu, 28 Apr 2022 04:09:35 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.14.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6745B3F774;
        Thu, 28 Apr 2022 04:09:33 -0700 (PDT)
Date:   Thu, 28 Apr 2022 12:09:26 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 04/18] PCI: Add PCI_EXP_SLTCAP_*_SHIFT macros
Message-ID: <20220428110926.GA32469@lpieralisi>
References: <20220220193346.23789-1-kabel@kernel.org>
 <20220220193346.23789-5-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220220193346.23789-5-kabel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 20, 2022 at 08:33:32PM +0100, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> These macros allows to easily compose and extract Slot Power Limit and
> Physical Slot Number values from Slot Capability Register.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>  include/uapi/linux/pci_regs.h | 3 +++
>  1 file changed, 3 insertions(+)

This patch can be dropped, correct ?

Thanks,
Lorenzo

> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index bee1a9ed6e66..d825e17e448c 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -591,10 +591,13 @@
>  #define  PCI_EXP_SLTCAP_HPS	0x00000020 /* Hot-Plug Surprise */
>  #define  PCI_EXP_SLTCAP_HPC	0x00000040 /* Hot-Plug Capable */
>  #define  PCI_EXP_SLTCAP_SPLV	0x00007f80 /* Slot Power Limit Value */
> +#define  PCI_EXP_SLTCAP_SPLV_SHIFT	7  /* Slot Power Limit Value shift */
>  #define  PCI_EXP_SLTCAP_SPLS	0x00018000 /* Slot Power Limit Scale */
> +#define  PCI_EXP_SLTCAP_SPLS_SHIFT	15 /* Slot Power Limit Scale shift */
>  #define  PCI_EXP_SLTCAP_EIP	0x00020000 /* Electromechanical Interlock Present */
>  #define  PCI_EXP_SLTCAP_NCCS	0x00040000 /* No Command Completed Support */
>  #define  PCI_EXP_SLTCAP_PSN	0xfff80000 /* Physical Slot Number */
> +#define  PCI_EXP_SLTCAP_PSN_SHIFT	19 /* Physical Slot Number shift */
>  #define PCI_EXP_SLTCTL		0x18	/* Slot Control */
>  #define  PCI_EXP_SLTCTL_ABPE	0x0001	/* Attention Button Pressed Enable */
>  #define  PCI_EXP_SLTCTL_PFDE	0x0002	/* Power Fault Detected Enable */
> -- 
> 2.34.1
> 

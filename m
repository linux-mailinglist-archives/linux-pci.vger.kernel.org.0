Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5BE778406
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 01:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjHJXQq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 19:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjHJXQp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 19:16:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0A82D44;
        Thu, 10 Aug 2023 16:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D97C760C5B;
        Thu, 10 Aug 2023 23:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1FEC433C7;
        Thu, 10 Aug 2023 23:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691709404;
        bh=ZmrWlyLDwcmwi9hUwauGbIn2pC+uqr3wNk2fOa0Tmtc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SAQglvG+C+UjhCWhv1P2LHig050JiUg/j9MWLFVK7hj/7mnBjMFPkSx3X1+Idlcyg
         QIMjHYxCCTUwVrso10FiV0kAgIMUzJ42bV+ca6NDs7NdHwhxYGQj8x6iBfaFl2cRG1
         XleuAEM/5LZlE7noiElqHs04GtNmocgk2R146bojaFK6ezYM5KXep2tZrdG/kenI6D
         QXcD5JAT3G5jFgHAbLGmy7RZc/aAV7R98EntmgFz3xT2nGQLwtH+mJmPYcBMJt1t00
         A0Wq9he4ONcMxtxl+6gmV7HNhz6pR8vAY73AyftNFcj2cVLf6cicQtJi6abjZdd6H9
         ZpXHJtoll7FEQ==
Date:   Thu, 10 Aug 2023 18:16:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc:     lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, bhelgaas@google.com, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Subject: Re: [PATCH v3 3/5] PCI: Add PCIe to PCI/PCI-X Bridge AER fields
Message-ID: <20230810231642.GA50403@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704120530.1322257-1-LeoLiu-oc@zhaoxin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 04, 2023 at 08:05:30PM +0800, LeoLiu-oc wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> Define Secondary Uncorrectable Error Mask Register, Secondary
> Uncorrectable Error Severity Register and Secondary Error Capabilities and
> Control Register bits in AER capability for PCIe to PCI/PCI-X Bridge.
> Please refer to PCIe to PCI/PCI-X Bridge Specification, sec 5.2.3.2,
> 5.2.3.3 and 5.2.3.4.
> 
> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
> ---
>  include/uapi/linux/pci_regs.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e5f558d964939..28e20c4d0afc3 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -800,6 +800,9 @@
>  #define  PCI_ERR_ROOT_FATAL_RCV		0x00000040 /* Fatal Received */
>  #define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
>  #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
> +#define PCI_ERR_UNCOR_MASK2		0x30	/* PCIe to PCI/PCI-X Bridge */
> +#define PCI_ERR_UNCOR_SEVER2	0x34	/* PCIe to PCI/PCI-X Bridge */
> +#define PCI_ERR_CAP2			0x38	/* PCIe to PCI/PCI-X Bridge */

These need to line up with the offsets above, i.e.,
PCI_ERR_ROOT_ERR_SRC.

I think these should be named:

  PCI_ERR_SEC_UNCOR_MASK
  PCI_ERR_SEC_UNCOR_SEVER
  PCI_ERR_SEC_ERR_CAP

because "Secondary" in this context doesn't have anything to do with
"2"; it just means the secondary (downstream) interface of the bridge.

Bjorn

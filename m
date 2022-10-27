Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BFD6104E1
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 23:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiJ0V4s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 17:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiJ0V4r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 17:56:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24740900F7;
        Thu, 27 Oct 2022 14:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B537462521;
        Thu, 27 Oct 2022 21:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE66C433D6;
        Thu, 27 Oct 2022 21:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666907806;
        bh=ejwdQUPGbamg43pbRin0jcwr6MfLouQO3nxsVDdp1bI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YJgE1gwXtxAvtHgchp1pnusC8/HhXp2bvBD8j/azadbQFsN997JU3vFv3F3frp7uh
         Vyv86kEM3Jk6brzKSdP6553i9KD9aaAoJLN+2gCQby2iBAUA4yk1WUqTJFtcRqTSiI
         K6c2mmd7LmGdj10qcmpIMzUYn2P1e4CNcCYqt/xU9rytLUMzWfMO4+mDPrILU3+6og
         snIz75cIFK8MWQ3FoU4TlyWGnC/hJUvQpyP8DXB0poi2u3M35xlelTuDcfb4W4hZ11
         NVSfchwbYv/bZ6mR7vheshD7rSUouOpuQr6lx/Nbh2gNVIqC7qvpnBlEzOI6VMGppr
         pjz58/9Cw5faQ==
Date:   Thu, 27 Oct 2022 16:56:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
        ying.huang@intel.com, rdunlap@infradead.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com
Subject: Re: [PATCH 3/5] ACPI/PCI: Add AER bits #defines for PCIE/PCI-X
 bridges
Message-ID: <20221027215644.GA844326@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027031554.2856036-1-LeoLiu-oc@zhaoxin.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 27, 2022 at 11:15:54AM +0800, LeoLiu-oc wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> Define PCI Express Advanced Error Reporting Extended Capabilities bits.
> 
> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
> ---
>  include/uapi/linux/pci_regs.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 57b8e2ffb1dd..3662106fd8dc 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -799,6 +799,11 @@
>  #define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
>  #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
>  
> +/* PCI Express Advanced Error Reporting Extended Capabilities for Bridges */
> +#define PCI_ERR_UNCOR_MASK2		0x30	/* Secondary Uncorrectable Error Mask */
> +#define PCI_ERR_UNCOR_SEVER2	0x34	/* Secondary Uncorrectable Error Severit */
> +#define PCI_ERR_CAP2			0x38	/* Secondary Advanced Error Capabilities */

Can you include a spec reference for these?  I'm looking at PCIe r6.0,
sec 7.8.4, and I don't see anything I can match up with these.

Bjorn

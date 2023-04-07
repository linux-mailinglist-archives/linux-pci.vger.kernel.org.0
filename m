Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537386DB71B
	for <lists+linux-pci@lfdr.de>; Sat,  8 Apr 2023 01:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDGXWZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 19:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDGXWY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 19:22:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9752683C6;
        Fri,  7 Apr 2023 16:22:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 318396544B;
        Fri,  7 Apr 2023 23:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5915EC433D2;
        Fri,  7 Apr 2023 23:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680909742;
        bh=EcxiF2UXwEWR7VpQjbAAVUwoAR1kiJZYatKMeEE79sI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=THQlngYYhxla3VzVFIKXsOkEFrR5vrsA3ZE8Y1dvYZBKAa6gqziTZ56bSwQyyCdcI
         EwFQWmyTFrUBFtHkrUp0Moi1TpSh1FYS7cSekX2DS9AQOttmeXM89Q6l41EzTjvBoS
         CQ5GXSLpoX5btrpDd8jFvLFO9pD/TEZnnKChb5ot25wgw/831OH3fvvtk3KXXaFxJH
         ASI07gaCPd05jorEzihVdwpZkshyb3KVRdddNUbhglHcsmwKAApDiyicH9/rFvFRt8
         ESUMnzSzN5MvPdiR/y4ajNBbt12uzismyNJRoXfFcNcsS5ZEtZhXm/QnDnGKznLEx/
         Ho5GvgHq9zYxg==
Date:   Fri, 7 Apr 2023 18:22:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
        ying.huang@intel.com, rdunlap@infradead.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com
Subject: Re: [PATCH v2 3/5] ACPI/PCI: Add AER bits #defines for PCIe to
 PCI/PCI-X Bridge
Message-ID: <20230407232220.GA3830804@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115031244.1667093-1-LeoLiu-oc@zhaoxin.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since this patch has nothing to do with ACPI, update subject line to:

  PCI: Add PCIe to PCI/PCI-X Bridge AER fields

On Tue, Nov 15, 2022 at 11:12:44AM +0800, LeoLiu-oc wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> Define secondary uncorrectable error mask register, secondary
> uncorrectable error severity register and secondary error capabilities and
> control register bits in AER capability for PCIe to PCI/PCI-X Bridge.
> Please refer to PCIe to PCI/PCI-X Bridge Specification, sec 5.2.3.2,
> 5.2.3.3 and 5.2.3.4.

Capitalize register names to match the spec usage.

> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>

Assuming this goes along with a patch series that adds uses of these
definitions:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/uapi/linux/pci_regs.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 57b8e2ffb1dd..37f3baa336d7 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -799,6 +799,11 @@
>  #define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
>  #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
>  
> +/* PCIe advanced error reporting extended capabilities for PCIe to PCI/PCI-X Bridge */
> +#define PCI_ERR_UNCOR_MASK2		0x30	/* Secondary Uncorrectable Error Mask */
> +#define PCI_ERR_UNCOR_SEVER2	0x34	/* Secondary Uncorrectable Error Severit */
> +#define PCI_ERR_CAP2			0x38	/* Secondary Advanced Error Capabilities */

Please squash these right up next to the other PCI_ERR_* definitions
so it's obvious that they overlap PCI_ERR_ROOT_STATUS and
PCI_ERR_ROOT_ERR_SRC (which is fine since one device can't have both),
e.g.,

  #define PCI_ERR_ROOT_STATUS     0x30
  #define  PCI_ERR_ROOT_COR_RCV           0x00000001 /* ERR_COR Received */
  ...
  #define PCI_ERR_ROOT_ERR_SRC    0x34    /* Error Source Identification */
  #define PCI_ERR_UNCOR_MASK2     0x30    /* PCIe to PCI/PCI-X bridge */
  #define PCI_ERR_UNCOR_SEVER2    0x34    /* PCIe to PCI/PCI-X bridge */
  #define PCI_ERR_CAP2            0x38    /* PCIe to PCI/PCI-X bridge */

>  /* Virtual Channel */
>  #define PCI_VC_PORT_CAP1	0x04
>  #define  PCI_VC_CAP1_EVCC	0x00000007	/* extended VC count */
> -- 
> 2.20.1
> 

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F9A4C36B1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 21:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiBXUOU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 15:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiBXUOT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 15:14:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1629C15F370;
        Thu, 24 Feb 2022 12:13:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD1F5B82684;
        Thu, 24 Feb 2022 20:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0B1C340F9;
        Thu, 24 Feb 2022 20:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645733626;
        bh=wGKXt/NGcVyJAQ2PEnwWJoT6s11nK9r3LQji5pUqHsA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UUFt3HU6Z93lQ90O1SlI/i7Ftj/LxnOsdVYflFXSOv6WVbidCurFrOphhTRRkDFj3
         d2BZGvMg1IOL8MGMOwD9UW5OxA5lurMbdNYD/KxvDecaScdg5h3DCFhmROlnVJZ+KK
         6R0VnXihwXrmnKCUlRj0V4+7otfnQcNi6gJV2X8PP+52Zpgk9tIXdNaNx7bcPFJ74J
         jYqi1vkJGJ91JZBN2urOf4C0hzuAc9A06IcBLL+W8r/toROdEQnkmEOGkuByDC5QeD
         8gaEF52qBf7CyPN9RY1z/gvzw/nDZIrHJ48hwRFIMQThbcNp5g4iy9EtBBJOeX4PXE
         hCEuic8/2s6Pg==
Date:   Thu, 24 Feb 2022 14:13:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] PCI: Add PCI_EXP_SLTCTL_ASPL_DISABLE macro
Message-ID: <20220224201344.GA291052@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220222163158.1666-2-pali@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 22, 2022 at 05:31:53PM +0100, Pali Rohár wrote:
> Add macro defining Auto Slot Power Limit Disable bit in Slot Control
> Register.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/uapi/linux/pci_regs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index bee1a9ed6e66..108f8523fa04 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -616,6 +616,7 @@
>  #define  PCI_EXP_SLTCTL_PWR_OFF        0x0400 /* Power Off */
>  #define  PCI_EXP_SLTCTL_EIC	0x0800	/* Electromechanical Interlock Control */
>  #define  PCI_EXP_SLTCTL_DLLSCE	0x1000	/* Data Link Layer State Changed Enable */
> +#define  PCI_EXP_SLTCTL_ASPL_DISABLE	0x2000 /* Auto Slot Power Limit Disable */
>  #define  PCI_EXP_SLTCTL_IBPD_DISABLE	0x4000 /* In-band PD disable */
>  #define PCI_EXP_SLTSTA		0x1a	/* Slot Status */
>  #define  PCI_EXP_SLTSTA_ABP	0x0001	/* Attention Button Pressed */
> -- 
> 2.20.1
> 

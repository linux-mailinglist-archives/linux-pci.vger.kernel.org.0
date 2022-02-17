Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A384BAB90
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 22:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbiBQVL4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 16:11:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiBQVLz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 16:11:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9A310FF4;
        Thu, 17 Feb 2022 13:11:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BBB9B824C4;
        Thu, 17 Feb 2022 21:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEAEC340E8;
        Thu, 17 Feb 2022 21:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645132296;
        bh=CzdKQukUPaQ8IcMbLnou9OTW4H72Tf7SKjxZcmHGj9E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a3BHLJELWH/c1d0oC/ubykhYkMmGYhinD4mFYBoruFJ5Yz7VJcf++0Jf9P8gvrUSt
         cpWHAB/yNlPC0EBatdEtekOEW9BLmahyBElhmjqhnbsTPaAhZJyFIZOs1u2CmTGBIS
         o78u91m/r3NNqpEqrIiGfTMUKLDtIALkH8ps6oGMIDOpD90PzZjA50nZ0ct97sWtgT
         dDkpHwu3RQYN8UcvjhYbE0SL1HqA5zeX+pMFWaduOSsKZm/K9JE1+3FWu+/IrZ//fW
         UaDVMNGNOBswwhUHwKHGxIQWNzMOXA7gV4uSV5RfSO3u4uHemKwSJJVRieCMn0g2dL
         Fc7KrPYZWFyAQ==
Date:   Thu, 17 Feb 2022 15:11:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 1/2] PCI: Add defines for normal and
 subtractive PCI bridges
Message-ID: <20220217211134.GA305475@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214114109.26809-1-pali@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 14, 2022 at 12:41:08PM +0100, Pali Rohár wrote:
> Add following two new PCI class codes defines into pci_ids.h include file:
> 
>   PCI_CLASS_BRIDGE_PCI_NORMAL
>   PCI_CLASS_BRIDGE_PCI_SUBTRACTIVE
> 
> And use these defines in all kernel code for describing PCI class codes for
> normal and subtractive PCI bridges.

Looks good; is this another case?

  drivers/pci/controller/pci-mvebu.c:     dev_rev |= (PCI_CLASS_BRIDGE_PCI << 8) << 8;

>  static void quirk_sb1250_ht(struct pci_dev *dev)
>  {
> -	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> +	dev->class = PCI_CLASS_BRIDGE_PCI_NORMAL;

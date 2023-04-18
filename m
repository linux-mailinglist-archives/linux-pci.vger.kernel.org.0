Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8C66E6C44
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 20:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjDRSkH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 14:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjDRSkG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 14:40:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36AE83F7;
        Tue, 18 Apr 2023 11:40:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D8E463664;
        Tue, 18 Apr 2023 18:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2984C433D2;
        Tue, 18 Apr 2023 18:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681843204;
        bh=MRs4OuuRPjwuAA/j/6wNgv/n7ZileduB/sqKzknPRDc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fJfNQ/ZalDa6qqwcMj4QDtO94py/zNjALGURUlVXqCh6pRglJCGXOq78050+QFdps
         Gxu78ZF4oEXWJgMMj/4coWyD9PPnfnTvyd8Ooy0qoh++1V4x5yuygekYP2DtAgHkDL
         Xq5Qgxr/JasGpSKigm93nIjk6LpF300mU718CzipQJ9xtkt/qc1NmViFBm3iv/WojF
         dAz13/v/yeZ7+6wSc8eCtwJdIFwxnyfchKkJNBPYGlcu738g8FNp2MYToKE5Lvv/4G
         hOODbYPS00tLqCSwqcy7aJ6qgKJ3CfExu/hpykcD7ZXLFt+TQIxiX4KtAvL4r5D/az
         JSTjLONy3foGA==
Date:   Tue, 18 Apr 2023 13:40:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Yue Wang <yue.wang@Amlogic.com>
Subject: Re: [PATCH 1/7] PCI: meson: Add 'Amlogic' to Kconfig prompt
Message-ID: <20230418184002.GA148053@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdcd04e2-13dc-3dac-daf5-ea784af75467@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 11:10:39AM -0700, Florian Fainelli wrote:
> On 4/18/23 10:43, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Add the "Amlogic" vendor name to the CONFIG_PCI_MESON Kconfig prompt to
> > match other PCIe drivers.  Capitalize "Meson" to match other Meson Kconfig
> > prompts.
> 
> Did you mean, do not capitalize "Meson" or did you intend to preserve the
> previous hunk that had "Meson" capitalized?

I made it match other Meson prompts:

  arch/arm/mach-meson/Kconfig-    bool "Amlogic Meson6 (8726MX) SoCs support"
  drivers/char/hw_random/Kconfig- tristate "Amlogic Meson Random Number Generator support"
  drivers/clk/meson/Kconfig-      bool "Meson8 SoC Clock controller support"
  drivers/gpu/drm/meson/Kconfig-  tristate "DRM Support for Amlogic Meson Display Controller"
  drivers/i2c/busses/Kconfig-     tristate "Amlogic Meson I2C controller"
  drivers/iio/adc/Kconfig-        tristate "Amlogic Meson SAR ADC driver"
  drivers/media/cec/platform/Kconfig-     tristate "Amlogic Meson AO CEC driver"

So I guess could have described as "style Meson with initial cap only
instead of all caps" or something.

Bjorn

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD3172851F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 18:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbjFHQeu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 12:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjFHQeh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 12:34:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1DE3596;
        Thu,  8 Jun 2023 09:33:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E421364F0E;
        Thu,  8 Jun 2023 16:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26A4C433EF;
        Thu,  8 Jun 2023 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686242028;
        bh=kp2D3wniyS6MSwZP3nNGR6ZTZAnV62gf4ioxemSH1c4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FpvdDBI5enmuyxzxLPXViQvT79KftAY2Lyu6j8y++ezQRGK/fAUHsbtVX1IeT3wZM
         gaF4yTxCo0SXO9gZNpDDnjmAjErFhqTQnsC0frEjN8OR62fGfzuV8zndhkP8Qv9xHn
         0VC90MJOi1SUPsd5pgxbwd9HmT9jRVewqRmAL1+X9cP9C2FI1ybKIe/cFFTFJQlp0q
         JOArXv1D8dyqtUoqB+E9iY7wMYdj7aASW1GY0akJohmx2NXilplhXj2KYld5T5Kqa3
         9DJPz9w2HZauPi6mSJBcMJ+c+fmtUbRjih4gTHyeSpZpwPFMoecXxKgACGxO4CD++Y
         YZAw/EQ2kpRyw==
Date:   Thu, 8 Jun 2023 11:33:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, Sergey.Semin@baikalelectronics.ru,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] Revert "PCI: tegra194: Enable support for 256 Byte
 payload"
Message-ID: <20230608163346.GA1204586@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608093652.1409485-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 08, 2023 at 03:06:52PM +0530, Vidya Sagar wrote:
> This reverts commit 4fb8e46c1bc4 ("PCI: tegra194: Enable
> support for 256 Byte payload")
> 
> Consider a PCIe hierarchy with a PCIe switch and a device connected
> downstream of the switch that has support for MPS which is the minimum
> in the hierarchy, and root port programmed with an MPS in its DevCtl
> register that is greater than the minimum. In this scenario, the default
> bus configuration of the kernel i.e. "PCIE_BUS_DEFAULT" doesn't
> configure the MPS settings in the hierarchy correctly resulting in the
> device with support for minimum MPS in the hierarchy receiving the TLPs
> of size more than that. Although this can be addresed by appending
> "pci=pcie_bus_safe" to the kernel command line, it doesn't seem to be a
> good idea to always have this commandline argument even for the basic
> functionality to work.
> Reverting commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256
> Byte payload") avoids this requirement and ensures that the basic
> functionality of the devices irrespective of the hierarchy and the MPS of
> the devices in the hierarchy.
> To reap the benefits of having support for higher MPS, optionally, one can
> always append the kernel command line with "pci=pcie_bus_perf".

Please add blank lines between paragraphs and wrap to fill 75 columns.
Also add a period at the end of the very first sentence.

s/addresed/addressed/

I guess that without 4fb8e46c1bc4, Linux configured everything with
128 byte MPS, and 4fb8e46c1bc4 was intended as an optimization to
allow 256 byte MPS.

If the Root Port advertises Max_Payload_Size Supported as 256 bytes in
DevCap, and the PCI core doesn't configure MPS=256 when possible, I'd
argue that should be fixed in the PCI core without a driver change
like this.

Bjorn

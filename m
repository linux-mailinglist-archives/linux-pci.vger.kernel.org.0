Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC51957E24A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 15:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiGVN0o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 09:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiGVN0n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 09:26:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16B789E86;
        Fri, 22 Jul 2022 06:26:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D4F261FF6;
        Fri, 22 Jul 2022 13:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B03C341C7;
        Fri, 22 Jul 2022 13:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658496401;
        bh=0fEpwrFuBVipvDIIa4cpMulMIC3/18dhlWmRDEqu14o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCGKDLNtShFVXV/NyAVsR2qgDB5CxWb4UZ6VBAmwpbwH6O3W4RBWhh17afWT2ibN5
         N5DIcmwmEDuRbFQhaPrqC8y75ZLlAGPU6aEudhGbuHd5kDlQGP2TfwUt0VeUi2li5f
         VoQrEexd0chqnbaABj0wkzsPmyINbumU1YTuTBVoN4xph6i40MT+0oLMGYVDz8Yrs/
         QvV23OzcANOPhL/BnjcXRJvShQ5KNT3LbMve9e34tflZfA/1cHCjmP7PVdF69iOdIC
         S96eTLwwC5f5NTpF+CtaTY0CuUsbyaBUZxC9XmBPHCbBzO64DMLyFdbvluPBgI1xsP
         KBrcm1InZGvjA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oEsg0-0000mm-LM; Fri, 22 Jul 2022 15:26:44 +0200
Date:   Fri, 22 Jul 2022 15:26:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-pci@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Why set .suppress_bind_attrs even though .remove() implemented?
Message-ID: <YtqllIHY/R/BbR3V@hovoldconsulting.com>
References: <20220721204607.xklzyklbgwcgepjm@pali>
 <20220721222122.GA1754784@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220721222122.GA1754784@bhelgaas>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 21, 2022 at 05:21:22PM -0500, Bjorn Helgaas wrote:
> [+to Johan for qcom]
> [-cc Tom, email bounces]
> 
> On Thu, Jul 21, 2022 at 10:46:07PM +0200, Pali Rohár wrote:
> > On Thursday 21 July 2022 14:54:33 Bjorn Helgaas wrote:

> With suppress_bind_attrs, the user can't manually unbind a device, so
> we can't get to mvebu_pcie_remove() that way, but since mvebu is a
> modular driver, I assume we can unload the module and *that* would
> call mvebu_pcie_remove().  Right?

Correct.

> qcom is a DWC driver, so all the IRQ stuff happens in
> dw_pcie_host_init().  qcom_pcie_remove() does call
> dw_pcie_host_deinit(), which calls irq_domain_remove(), but nobody
> calls irq_dispose_mapping().
> 
> I'm thoroughly confused by all this.  But I suspect that maybe I
> should drop the "make qcom modular" patch because it seems susceptible
> to this problem:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ctrl/qcom&id=41b68c2d097e

That should not be necessary.

As you note above, interrupt handling is implemented in dwc core so if
there are any issue here at all, which I doubt, then all of the dwc
drivers that currently can be built as modules would all be broken and
this would need to be fixed in core.

I've been using the modular pcie-qcom patch for months now, unloading
and reloading the driver repeatedly to test power sequencing, without
noticing any problems whatsoever.

Johan

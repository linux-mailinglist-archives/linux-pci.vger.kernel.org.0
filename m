Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A6A75B403
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 18:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjGTQUb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 12:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjGTQUb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 12:20:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562AF9E;
        Thu, 20 Jul 2023 09:20:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8FFF61B5F;
        Thu, 20 Jul 2023 16:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10097C433C8;
        Thu, 20 Jul 2023 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689870029;
        bh=pOFUaQTLHFO4dGld1P/bsoc75HqYdjzgZCqUvQTq3bU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WrU6CN3wSIaR+XSqSUU6ICevbrO1rjEyiZlAQ632RHiN9jHdLkXL5wngNkcZWEiEf
         9mxjulCjKP5rMBYZlLwIhs8FJmLe2wn4p7KyJeF3VuPoFOGZcN7xwBhxZZpjjzPxh0
         DXcZcO65iqjDEPdFVYbtoa5Ynhzv1ieMHTqtFPP2LxXQyxV1L6W7p7G0H1/3r9BUEo
         e3gK2PnnugeYBDbsXr2v3Gf2LC/REZ+oNAgKdLNdGvQSLb8NaxoSCEqyh48pjqHGM0
         tCQDMqhY2UhvIbiqBmBlYPBWIhY3dZ+A4iCl4fhEsOmWjEUrm+gWgKCnS5iPBdZyhU
         4XZcowL5ejdWw==
Date:   Thu, 20 Jul 2023 11:20:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Frank Li <Frank.li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        imx@lists.linux.dev, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <20230720162027.GA527307@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720160738.GC48270@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 20, 2023 at 09:37:38PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jul 20, 2023 at 10:37:36AM -0400, Frank Li wrote:
> > On Thu, Jul 20, 2023 at 07:55:09PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Jul 18, 2023 at 03:34:26PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Jul 17, 2023 at 02:36:19PM -0400, Frank Li wrote:
> > > > > On Mon, Jul 17, 2023 at 10:15:26PM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Wed, Apr 19, 2023 at 12:41:17PM -0400, Frank Li wrote:
> > > > > > > Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> > > > > > > Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.
> > > > > > > 
> > > > > > > Typical L2 entry workflow:
> > > > > > > 
> > > > > > > 1. Transmit PME turn off signal to PCI devices.
> > > > > > > 2. Await link entering L2_IDLE state.
> > > > > > 
> > > > > > AFAIK, typical workflow is to wait for PME_To_Ack.
> > > > > 
> > > > > 1 Already wait for PME_to_ACK,  2, just wait for link actual enter L2.
> > > > > I think PCI RC needs some time to set link enter L2 after get ACK from
> > > > > PME.
> > > 
> > > One more comment. If you transition the device to L2/L3, then it
> > > can lose power if Vaux was not provided. In that case, can all
> > > the devices work after resume?  Most notably NVMe?
> > 
> > I have not hardware to do such test, NVMe driver will reinit
> > everything after resume if no L1.1\L1.2 support. If there are
> > L1.1\L1.2, NVME expect it leave at L1.2 at suspend to get better
> > resume latency.
> 
> To be precise, NVMe driver will shutdown the device if there is no
> ASPM support and keep it in low power mode otherwise (there are
> other cases as well but we do not need to worry).
> 
> But here you are not checking for ASPM state in the suspend path,
> and just forcing the link to be in L2/L3 (thereby D3Cold) even
> though NVMe driver may expect it to be in low power state like
> ASPM/APST.
> 
> So you should only put the link to L2/L3 if there is no ASPM
> support. Otherwise, you'll ending up with bug reports when users
> connect NVMe to it.

Can you point me to the NVMe code that shuts down the device if
there's no ASPM support?  That sounds interesting and of interest to
other drivers that want to do suspend.

Bjorn

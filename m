Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4C975B3D2
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 18:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjGTQIE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 12:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbjGTQID (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 12:08:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA3ECE;
        Thu, 20 Jul 2023 09:07:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60EFB612CA;
        Thu, 20 Jul 2023 16:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07552C433C8;
        Thu, 20 Jul 2023 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689869275;
        bh=Ou2Mh5nraWXlzNwKruRqfrLeoeDKp8beV04BRuHhYwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QDPRzplSB7rDPnYbyMPv7JcU43dmdgPKHwR+inxmoJlN/LC+4kmsPvpf8Knct6shU
         sCOH6u11Hx9i/jQ2yC4biJjDAzRXm5N8sqvIwdD4VEWrj/C4+YWp7EsyQpdfxpT6ET
         tzeaLBWvvINiKVnxRMtgpdevhG222aUIR+jswm5aaKFNKFPVn0GiCjEoHjmol1oReF
         I+gfEBo9fvPHIYRqyQdoo26D7Hm05LZYqdQctEY8AmxDINlc1Ndus9EtZSsuf2xrcd
         zWHtOCKOf76wMwe+Fm2eio8zTnhLH4lMCKp6zTr3VlFwhJ88+I6HjXJjBmaL7m6z5x
         ddQTciqQJmiKg==
Date:   Thu, 20 Jul 2023 21:37:38 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        helgaas@kernel.org, imx@lists.linux.dev, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <20230720160738.GC48270@thinkpad>
References: <20230419164118.596300-1-Frank.Li@nxp.com>
 <20230717164526.GC35455@thinkpad>
 <ZLWKI1lRqxejfUgK@lizhi-Precision-Tower-5810>
 <20230718100400.GB4771@thinkpad>
 <20230720142509.GB48270@thinkpad>
 <ZLlGsM/D/b+udmAD@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLlGsM/D/b+udmAD@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 20, 2023 at 10:37:36AM -0400, Frank Li wrote:
> On Thu, Jul 20, 2023 at 07:55:09PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jul 18, 2023 at 03:34:26PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Jul 17, 2023 at 02:36:19PM -0400, Frank Li wrote:
> > > > On Mon, Jul 17, 2023 at 10:15:26PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Wed, Apr 19, 2023 at 12:41:17PM -0400, Frank Li wrote:
> > > > > > Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> > > > > > Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.
> > > > > > 
> > > > > > Typical L2 entry workflow:
> > > > > > 
> > > > > > 1. Transmit PME turn off signal to PCI devices.
> > > > > > 2. Await link entering L2_IDLE state.
> > > > > 
> > > > > AFAIK, typical workflow is to wait for PME_To_Ack.
> > > > 
> > > > 1 Already wait for PME_to_ACK,  2, just wait for link actual enter L2.
> > > > I think PCI RC needs some time to set link enter L2 after get ACK from
> > > > PME.
> > > > 
> > 
> > One more comment. If you transition the device to L2/L3, then it can loose power
> > if Vaux was not provided. In that case, can all the devices work after resume?
> > Most notably NVMe?
> 
> I have not hardware to do such test, NVMe driver will reinit everything after
> resume if no L1.1\L1.2 support. If there are L1.1\L1.2, NVME expect it leave
> at L1.2 at suspend to get better resume latency.
> 

To be precise, NVMe driver will shutdown the device if there is no ASPM support
and keep it in low power mode otherwise (there are other cases as well but we do
not need to worry).

But here you are not checking for ASPM state in the suspend path, and just
forcing the link to be in L2/L3 (thereby D3Cold) even though NVMe driver may
expect it to be in low power state like ASPM/APST.

So you should only put the link to L2/L3 if there is no ASPM support. Otherwise,
you'll ending up with bug reports when users connect NVMe to it.

- Mani

> This API help remove duplicate codes and it can be improved gradually.
> 
> 
> > 
> > - Mani
> > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

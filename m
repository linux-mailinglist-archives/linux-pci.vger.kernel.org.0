Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DE272A0C3
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 18:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjFIQ6a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 12:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjFIQ6a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 12:58:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6657C3A97;
        Fri,  9 Jun 2023 09:58:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02C7561B83;
        Fri,  9 Jun 2023 16:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FDFC433D2;
        Fri,  9 Jun 2023 16:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686329908;
        bh=pjgfKaWVMdeYyIMbBJD5Sg5A3ohhPxW0Ef13dCshItk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XkkmdBfZIksnouDINNBR5DFTz+0ZxdelPRUY8ugmfCzWI9Nwhi8gDqycIXeRQN+sh
         ATOoTwDhBPpwlQ7/H1WDLoaTe/OusGTzdDPKv1i3vBs+SS9qY8QWCRNuKAAJdmOS4y
         T5e+Exwirlj3rZLHELNMgPuNq4hM/MDyiRywXvAkSrk2HMur+ZmGXWUDDsesJAqmL6
         dYdnBRTFNALe7Pd8ekA798iIIrZ3pS/9jWhCK3bbItBiA6Ku4LZjo3wzp6etVX7wKa
         VUnEGpJjYx/SzUJb0ApVA6RDkPSWdvKbWgeBkS6NP/gFpmquO5p0MhCvt0eicXGd3I
         jqbJAMVxxESNA==
Date:   Fri, 9 Jun 2023 11:58:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, quic_vbadigan@quicinc.com,
        quic_ramkri@quicinc.com, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-pci@vger.kernel.org>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] PCI: qcom-ep: Add ICC bandwidth voting support
Message-ID: <20230609165826.GA1251610@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33098c17-ea24-f26c-2d37-707f13ce9716@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 09, 2023 at 05:22:00PM +0530, Krishna Chaitanya Chundru wrote:
> On 6/7/2023 10:13 PM, Bjorn Helgaas wrote:
> > On Wed, Jun 07, 2023 at 09:48:07PM +0530, Krishna chaitanya chundru wrote:
> > > Add support to vote for ICC bandwidth based on the link
> > > speed and width.

> > This plus the pcie_ep->icc init below is basically identical to
> > qcom_pcie_icc_init() in pcie_qcom.c.  Why not use the same structure
> > here, with a qcom_pcie_icc_init() function?  It's better to be the
> > same than different (when possible, of course).
> 
> In pcie_qcom.c driver the resources will be turned on the probe itself.
> 
> But in pcie-qcom-ep.c driver will wait for the host to toggle the perst to
> enable all the resources
> 
> that is reason it is different here.

Understood, differences like this do make sense.  It's not always
possible, but when it is, it's helpful to use similar structure and
function names because it makes it easier to understand and easier to
see opportunities for refactoring.

Bjorn

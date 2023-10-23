Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6A97D41A1
	for <lists+linux-pci@lfdr.de>; Mon, 23 Oct 2023 23:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjJWV0e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Oct 2023 17:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjJWV0d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2023 17:26:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34768110;
        Mon, 23 Oct 2023 14:26:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F27C433C8;
        Mon, 23 Oct 2023 21:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698096390;
        bh=ExpyHr72oVSoyPF5INR0ia4PkeXikfJXxCfcnjjlr98=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UrjjYBaIRfKW39VLUzHGFB3VLQDZ6lZYoUVDsV3MWZpz2pbLJvx26RkNzCyx/AfTq
         3UZdDmYme2s6tAvuqV1K0m91AkfqbeCV3tRz1qruwOkTiGLuv27/i+g8csGUROaDFk
         V2SL8hxYNSWzYzAderc8NJhCiOENUvJDD8cDDSSeXboqF2q4euHcWbUo99BtD6uMO5
         0a/9t8uBzwBLEIElfK1Ke+OnY1zpkvFVTB8pMk8DeJ66kNpRj3doNtyL2G7+OyGlGZ
         VABC0GImvrN/vyzQ46/eS4Mjg9+Mho4PfhIg0SFlCODVK5s2xxz2HeqmqPsL+EK9PM
         e2AteBWB15O4Q==
Date:   Mon, 23 Oct 2023 16:26:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        r-gunasekaran@ti.com, srk@ti.com
Subject: Re: [PATCH v3] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <20231023212628.GA1627567@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <499a2f6c-3104-492c-be34-3ad286cdf069@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 23, 2023 at 05:05:30PM +0530, Siddharth Vadapalli wrote:
> On 23/10/23 16:12, Serge Semin wrote:
> 
> ...
> 
> > Siddharth, if it won't be that much bother and you have an access to
> > the v3.65-based Keystone PCIe device, could you please have a look
> > whether it's possible to implement what Bjorn suggested?
> 
> Unfortunately I don't have any SoC/Device with me that has the v3.65 PCIe
> controller, so I will not be able to test Bjorn's suggestion.

Huh.  57e1d8206e48 ("MAINTAINERS: move Murali Karicheri to credits")
removed the maintainer for pci-keystone.c, so the driver hasn't had a
maintainer for over two years.

Given the fact that there's no maintainer, I'm more than happy to take
a patch to move this code to somewhere in the host_init() callback,
even if you don't have the hardware to test it.

Bjorn

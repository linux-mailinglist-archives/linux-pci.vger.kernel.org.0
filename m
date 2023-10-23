Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62357D3D82
	for <lists+linux-pci@lfdr.de>; Mon, 23 Oct 2023 19:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjJWR0p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Oct 2023 13:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjJWR0o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2023 13:26:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EB8A2;
        Mon, 23 Oct 2023 10:26:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCECC433C8;
        Mon, 23 Oct 2023 17:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698082002;
        bh=UXLXOgLp4A7hZSNzIK7YG2ywhifFJfdLP5yoj/6tdrs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MVhuiS5S5OGjc7iMqaJUucGRWk4Q85x8n/ufPVBEs+RF0WIWIjoLpdt1T2APwV01q
         VCo2J/NdLK99dyyEX4dTHL7OIZb9LSuUAmDCs0SWnyIS3IfDcYH4f2UiEJ9/BUUadX
         KCy74KHesFjb9mv6wcLt/npGb9xJ68yNCd9U74LGzuLPoFwxrcLTj8ErLjOyoHmrVq
         psk59i8ZuWtk6t95JrxLulyX+vwnNna+FBrmnk1iD1TQWBSJDzILtxhj/t5WH36vG6
         sdoZJ8CKa9C8EuHp9kovonQCBq2KbtKeLbtJ7n08/oUMLfKsmAXad1BI6+5dNyv9ov
         JwMtMnYDI2fNQ==
Date:   Mon, 23 Oct 2023 12:26:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: Re: [PATCH v5 RESEND 0/4] increase ecam size value to discover 256
 buses during
Message-ID: <20231023172530.GA1602129@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB7201A57631FB1E0FB60A9BC08BDBA@SN7PR12MB7201.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 20, 2023 at 10:35:46AM +0000, Havalige, Thippeswamy wrote:
> Hi Bjorn,
> 
> Can you please provide an update on this patch series.

As with your Xilinx XDMA Soft IP series, I hope to get this merged for
v6.7.

Would you take a quick look at patchwork here:
https://patchwork.kernel.org/project/linux-pci/list/?submitter=207519
to make sure that everything you're waiting on is listed there?

I cleaned out things that appeared to be older versions of the
"Increase ECAM size" and the "Add support for Xilinx XDMA Soft IP"
series, but the subject lines didn't always match exactly, so it's
possible I incorrectly marked something as "superseded".

Bjorn

> > -----Original Message-----
> > From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > Sent: Monday, October 16, 2023 10:41 AM
> > To: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> > robh@kernel.org; krzysztof.kozlowski+dt@linaro.org; colnor+dt@kernel.org;
> > Havalige, Thippeswamy <thippeswamy.havalige@amd.com>; Simek, Michal
> > <michal.simek@amd.com>; Gogada, Bharat Kumar
> > <bharat.kumar.gogada@amd.com>
> > Subject: [PATCH v5 RESEND 0/4] increase ecam size value to discover 256
> > buses during
> > 
> > Current driver is supports up to 16 buses. The following code fixes to support
> > up to 256 buses.
> > 
> > update "NWL_ECAM_VALUE_DEFAULT " to 16  can access up to 256MB ECAM
> > region to detect 256 buses.
> > 
> > Update ecam size to 256MB in device tree binding example.
> > 
> > Remove unwanted code.
> > 
> > Thippeswamy Havalige (4):
> >   PCI: xilinx-nwl: Remove unnecessary code which updates primary,
> >     secondary and sub-ordinate bus numbers
> >   dt-bindings: PCI: xilinx-nwl: Modify ECAM size in example
> >   PCI: xilinx-nwl: Rename ECAM size default macro
> >   PCI: xilinx-nwl: Increase ECAM size to accommodate 256 buses
> > 
> >  .../devicetree/bindings/pci/xlnx,nwl-pcie.yaml |  2 +-
> >  drivers/pci/controller/pcie-xilinx-nwl.c       | 18 +++---------------
> >  2 files changed, 4 insertions(+), 16 deletions(-)
> > 
> > --
> > 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

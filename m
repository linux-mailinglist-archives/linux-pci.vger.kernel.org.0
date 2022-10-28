Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544FA6115E1
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 17:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiJ1Pbi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 11:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiJ1PbX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 11:31:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD131D79A7;
        Fri, 28 Oct 2022 08:31:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65DBA62909;
        Fri, 28 Oct 2022 15:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DF3C433D6;
        Fri, 28 Oct 2022 15:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666971081;
        bh=o+0VxdeJq/RrjjyfIgZtufz0J9g1ssl2n7lLNfU1zXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kv5tY/oJZ7o4kVBbnvIlQva20qfJo6UMxlFlo65R879C6o5OGVtVvIDiYCgNlicNV
         tADg6W0Thkl41z6xDB6xGueHoNydEkPbLsZUkegUGE/6KgXalH5kd0db9qZDImUjR8
         99LY8vI77AKFye7RHI0vCj+em/L2J+6YLQCN5Fp4tuu4neq6xsPfWnk0u0ciL1RwBz
         cavZWLrLOXhWGETw52z9qEInzx3H8Otl5odYPnIKoivVdxaFaXSs/mdtCfw0Q0o8Hn
         2OZTxkUE20pycBloaf+OsRUNc1lNK5WaCyut690DcIVUATtStSfGy+0PpqkozycaHO
         kyNDovOmuvRmA==
Date:   Fri, 28 Oct 2022 10:31:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Cc:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
        ying.huang@intel.com, rdunlap@infradead.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com
Subject: Re: [PATCH 3/5] ACPI/PCI: Add AER bits #defines for PCIE/PCI-X
 bridges
Message-ID: <20221028153120.GA891635@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8472b248-11ac-2148-e39f-12647044332b@zhaoxin.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 28, 2022 at 07:56:43PM +0800, LeoLiuoc wrote:
> 在 2022/10/28 5:56, Bjorn Helgaas 写道:
> > On Thu, Oct 27, 2022 at 11:15:54AM +0800, LeoLiu-oc wrote:
> > > From: leoliu-oc <leoliu-oc@zhaoxin.com>
> > > 
> > > Define PCI Express Advanced Error Reporting Extended Capabilities bits.
> > > 
> > > Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
> > > ---
> > >   include/uapi/linux/pci_regs.h | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > > index 57b8e2ffb1dd..3662106fd8dc 100644
> > > --- a/include/uapi/linux/pci_regs.h
> > > +++ b/include/uapi/linux/pci_regs.h
> > > @@ -799,6 +799,11 @@
> > >   #define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
> > >   #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
> > > +/* PCI Express Advanced Error Reporting Extended Capabilities for Bridges */
> > > +#define PCI_ERR_UNCOR_MASK2		0x30	/* Secondary Uncorrectable Error Mask */
> > > +#define PCI_ERR_UNCOR_SEVER2	0x34	/* Secondary Uncorrectable Error Severit */
> > > +#define PCI_ERR_CAP2			0x38	/* Secondary Advanced Error Capabilities */
> > 
> > Can you include a spec reference for these?  I'm looking at PCIe r6.0,
> > sec 7.8.4, and I don't see anything I can match up with these.
> > 
> Please refer to PCI Express to PCI/PCI-X Bridge Specification, sec 5.2.3.2,
> 5.2.3.3 and 5.2.3.4.

Thanks, I had forgotten about that spec from 2003 :)  I wish they had
incorporated the material, or at least a reference to it, into the
PCIe base spec like they did with a lot of other similar material.

Please include a short comment in the header file, e.g.,

  /* PCIe-to-PCI/PCI-X Bridge Spec r1.0, sec 5.2.3 */

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853F472A6F2
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jun 2023 02:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjFJALD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 20:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjFJALB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 20:11:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552AF3594;
        Fri,  9 Jun 2023 17:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686355860; x=1717891860;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=DHh0LmJ+ew1mxuheRvkVBLZVY6yVktBE7TVVxuvmOWI=;
  b=K5I2b9f6/YFfX3QKwu+856tAq1Cq5hBtbUS+ybAD1573QRF7vIJRIzbR
   YM4NOpy4IHr7o5tl2zvRljV8XgJ8/35pBU96mBbStcb8+GVamN1ujKPdW
   xXRe1bdVKAzv0Jzc3onFUvM7tsFvMllyGLzUA95POlbOiCBXY31mOmxjt
   LpJ+cHxHRenMQq3Gr7pBk6TVAWZDpUeSQm65BZCRVIO2tOENwFUdTawlR
   Xbi4Z5FSY6CURv5NnhYXWEL3kYdcpv6Kyda7G83NZKO9a5a2O9v/PTMQO
   uytu/Kz5O0fwwhYrKxUIPYp55FBueduY7qB23An547bd/OZbGWFTDGfCj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="386079264"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="386079264"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 17:09:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="957325991"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="957325991"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jun 2023 17:09:53 -0700
Received: from ralawler-mobl1.amr.corp.intel.com (unknown [10.209.72.97])
        by linux.intel.com (Postfix) with ESMTP id AB614580109;
        Fri,  9 Jun 2023 17:09:52 -0700 (PDT)
Message-ID: <1f3debbc0956a6a83511b0d90ffc67611cd912b3.camel@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH V2] PCI: Move VMD ASPM/LTR fix to PCI quirk
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     me@adhityamohan.in, kw@linux.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, linux-pci@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        jonathan.derrick@linux.dev, bhelgaas@google.com,
        nirmal.patel@linux.intel.com, michael.a.bottini@intel.com
Date:   Fri, 09 Jun 2023 17:09:52 -0700
In-Reply-To: <20230609224637.GA1267887@bhelgaas>
References: <20230609224637.GA1267887@bhelgaas>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2023-06-09 at 17:46 -0500, Bjorn Helgaas wrote:
> On Fri, Jun 09, 2023 at 03:09:26PM -0700, David E. Box wrote:
> > Hi Bjorn,
> >=20
> > On Thu, 2023-06-08 at 15:52 -0500, Bjorn Helgaas wrote:
> > > On Tue, Apr 11, 2023 at 02:33:23PM -0700, David E. Box wrote:
> > > > In commit f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM=
 and
> > > > LTR") the VMD driver calls pci_enabled_link_state as a callback fro=
m
> > > > pci_bus_walk. Both will acquire the pci_bus_sem lock leading to a
> > > > lockdep
> > > > warning. Instead of doing the pci_bus_walk, move the fix to quirks.=
c
> > > > using
> > > > DECLARE_PCI_FIXUP_FINAL.
>=20
> > > > +#define VMD_DEVICE_LTR=C2=A00x1003=C2=A0=C2=A0/* 3145728 ns */
> > >=20
> > > It would be nice to know how this value was derived.=C2=A0 But I know=
 we
> > > had this hard-coded value before, so it's not new with this patch.
> >=20
> > Do you mean to show the multiplier that determines that value or to
> > say why this particular number was chosen? For the latter, it the
> > largest that could be set (given the multipier options) that will
> > allow the SoC to get to it's lowest power state. And it's the same
> > so far on all the SoCs covered by the VMD driver.
>=20
> Oh, sorry, I meant "why this number was chosen".=C2=A0 PCIe r6.0, sec
> 7.8.2, says this capability allows software to provide "platform
> latency information," so I assume this is somehow dependent on
> platform, but I really don't understand the details of how LTR works,
> and we didn't have an explanation before, so this was just a "if you
> happen to know, it might be useful here" comment.

Sure.

>=20
> > > > +static void quirk_intel_vmd(struct pci_dev *pdev)
> > >=20
> > > I think this quirk could possibly stay in
> > > drivers/pci/controller/vmd.c, couldn't it?=C2=A0 It has a lot of
> > > VMD-specific knowledge that it would nice to contain in vmd.c.
> >=20
> > I may have misunderstood your comment on V1 then. But you suggested
> > that this would be typically done as PCI_FIXUP so that the PCI core
> > could call it and we could avoid the locking issue that was seen
> > while walking the bus in vmd.c.
>=20
> Right, I think it makes sense to be a DECLARE_PCI_FIXUP_CLASS_FINAL(),
> but I was thinking that it could be implemented in vmd.c and still be
> called by the PCI core.
>=20
> But now I'm uncertain since vmd.c can be compiled as a module, and I'm
> not sure how that could work, since pci_fixup_device() calls things in
> the __start_pci_fixups_final[] table, and I don't see how loading a
> module would insert the fixup entry into that table.
>=20
> So maybe it needs to be in quirks.c after all.

Okay.

>=20
> I think my only remaining questions here are about how to identify
> devices below VMD and the order of enabling ASPM states vs setting
> LTR.

Agree on setting the LTR first. I'll also look at other ways to identify de=
vices
below VMD.

David


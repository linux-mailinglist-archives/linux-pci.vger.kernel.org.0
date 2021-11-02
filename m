Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F9E4434C0
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 18:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbhKBRq4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 13:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234734AbhKBRq4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Nov 2021 13:46:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA5F761050;
        Tue,  2 Nov 2021 17:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635875061;
        bh=iahJFRZcx1MxL+M2Ajyus8wDKsnumh0QcA3DdNHQiCI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vvh2zW9D1d2AV+xkYpTnJ9L4N5nmpPTswlC/i1On5byzt10F8fzkqYN0NxBTrZN+j
         EK34IU6acfGRKyziVzs/qgIgdiAYf7Wo5PN+bmve/h480BHGum/BiCrN2xAMYkGb9p
         mUksj0v1L6DBHs4f2oFGlxEeq0wh69PDlllBkflbjyeCwB7Kk9Sx15fTNlKXDCYT2e
         tWUR0Pgtn+CNCdN8UHW/cxBAS90IrKYOSkCXki6UIBDp4Q/YY/N+dbrlKqcSPEmIkw
         +QFHyW/dGz7VfTDCbm92jbcMgp4E5vsGXX7WTsgKSUVKISCUFRBXQRCUB/L6foINOC
         wo2Xq2hDG8Vng==
Date:   Tue, 2 Nov 2021 17:44:15 +0000
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v15 04/13] PCI: kirin: Add support for bridge slot DT
 schema
Message-ID: <20211102174415.58cd3d4f@sal.lan>
In-Reply-To: <20211102160612.GA612467@bhelgaas>
References: <bb391a0e0f0863b66e645048315fab1a4f63f277.1634812676.git.mchehab+huawei@kernel.org>
        <20211102160612.GA612467@bhelgaas>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Em Tue, 2 Nov 2021 11:06:12 -0500
Bjorn Helgaas <helgaas@kernel.org> escreveu:

> > +
> > +	/* Per-slot clkreq */
> > +	int		n_gpio_clkreq;
> > +	int		gpio_id_clkreq[MAX_PCI_SLOTS];
> > +	const char	*clkreq_names[MAX_PCI_SLOTS];  
> 
> I think there's been previous discussion about this, but I didn't
> follow it, so I'm just double-checking that this is what we want here.
> 
> IIUC, this (MAX_PCI_SLOTS, "hisilicon,clken-gpios") applies to an
> external PEX 8606 bridge, which seems a little strange to be
> hard-coded into the kirin driver this way.
> 
> I see that "hisilicon,clken-gpios" is optional, but what if some
> platform connects all 6 lanes?  What if there's a different bridge
> altogether?
> 
> I'll assume this is actually the way we want thing unless I hear
> otherwise.

Yes, there was past discussions about that with Rob, with regards
to how the DT would represent it, which got reflected at the code.
At the end, it was decided to just add a single property inside PCIe:


		pcie@f4000000 {
                        compatible = "hisilicon,kirin970-pcie";
...
                        hisilicon,clken-gpios = <&gpio27 3 0>, <&gpio17 0 0>,
                                                <&gpio20 6 0>;

I don't think this is a problem, as, if some day another bridge would
need a larger number of slots, it is just a matter of changing the
number at the MAX_PCI_SLOTS, as this controls only the size of the array
(and the check for array overflow when parsing the properties).

Regards,
Mauro

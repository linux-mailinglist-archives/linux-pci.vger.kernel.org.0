Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F483E9FBE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 09:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhHLHsi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 03:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232348AbhHLHsh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Aug 2021 03:48:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C84D6044F;
        Thu, 12 Aug 2021 07:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628754492;
        bh=CyN2mPCfM3j2Hf8s0RQ6ZOCusox6Uwiz3cxbwisUK9Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=goj28NmLw6K0aBCSpjhlakd71Ui8aT3P15TAEq2tRX5UTYN1tRSFfRaYn+K3GgStT
         4RCKyHlC+KxRt7hGwtV1Te26766lX1BlM/gtI9qrzdMXx1rCF1Um0+q4Fezf3EZZZo
         sV0jKC5L50UdUuf9eI1zsomfFO3gUUDK1G9GDdw74dWM2DgZmPbbgOVdDBGk//ZBf0
         Pda/nW3TK7tqoreMNpQN1rCoAeLYP1AqX8RRZcwwyAtHwvMfI8Po920ZltkkibORwj
         pKPSojrC05WkoRuMAzby2Bf3wmHJ0eKHK0DpOMAz6flMtpvrW1+KWkE9jjcSP1T+gs
         c/bXmY0z6piiw==
Date:   Thu, 12 Aug 2021 09:48:06 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 0/4] DT schema changes for HiKey970 PCIe hardware to
 work
Message-ID: <20210812094806.3a6de2a5@coco.lan>
In-Reply-To: <CAL_JsqLg-jD1P3oGDocMaeHWQc+9kLr3gEdantRNUScUq5xsQw@mail.gmail.com>
References: <cover.1627965261.git.mchehab+huawei@kernel.org>
        <CAL_JsqLjw=+szXWJjGe86tMc51NA-5j=jVSXUAWuKeZRuJNJUg@mail.gmail.com>
        <20210804085045.3dddbb9c@coco.lan>
        <YQrARd7wgYS1nywt@robh.at.kernel.org>
        <20210805094612.2bc2c78f@coco.lan>
        <20210805095848.464cf85c@coco.lan>
        <CAL_JsqKso=z8LG3ViaggyS1k+1T2F5aAhP3_RNhumQoUUD+bbg@mail.gmail.com>
        <20210810114211.01df0246@coco.lan>
        <CAL_JsqKtXoFeJO6_13U+VsSXNGX_1TQvwOyQYRk5JUgBhvQChA@mail.gmail.com>
        <20210810162054.1aa84b84@coco.lan>
        <CAL_JsqL-R=kTugNAC-C1gfSm6Xnb0Nw_iLcRki8aQMNQjcLN6A@mail.gmail.com>
        <20210811084648.66ddff29@coco.lan>
        <CAL_JsqLg-jD1P3oGDocMaeHWQc+9kLr3gEdantRNUScUq5xsQw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 11 Aug 2021 22:13:32 -0500
Rob Herring <robh@kernel.org> escreveu:

> On Wed, Aug 11, 2021 at 1:46 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Em Tue, 10 Aug 2021 11:13:48 -0600
> > Rob Herring <robh@kernel.org> escreveu:
> >  
> > > > > >                                         compatible = "pciclass,0604";
> > > > > >                                         device_type = "pci";
> > > > > >                                         #address-cells = <3>;
> > > > > >                                         #size-cells = <2>;
> > > > > >                                         ranges;
> > > > > >                                 };
> > > > > >                                 pcie@1,0 { // Lane 4: M.2  
> > > > >
> > > > > These 3 nodes (1, 5, 7) need to be child nodes of the above node.  
> > >
> > > This was the main issue.  
> >
> > Ok, placing 1, 5, 7 as child nodes of 0 worked, with the attached
> > DT schema:
> >
> >
> >         $ ls -l $(find /sys/devices/platform/soc/f4000000.pcie/ -name of_node)
> >         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/of_node -> ../../../../firmware/devicetree/base/soc/pcie@f4000000
> >         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:01.0/of_node -> ../../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@1,0
> >         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:01.0/pci_bus/0000:03/of_node -> ../../../../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@1,0
> >         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:05.0/of_node -> ../../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@5,0
> >         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:05.0/pci_bus/0000:05/of_node -> ../../../../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@5,0
> >         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:07.0/of_node -> ../../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@7,0
> >         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:07.0/pci_bus/0000:06/of_node -> ../../../../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@7,0
> >         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/of_node -> ../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/pcie@0,0
> >         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/pci_bus/0000:02/of_node -> ../../../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/pcie@0,0
> >         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/of_node -> ../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0
> >         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/pci_bus/0000:01/of_node -> ../../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0
> >         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/pci_bus/0000:00/of_node -> ../../../../../../../firmware/devicetree/base/soc/pcie@f4000000  
> 
> This all looks right to me, but...
> 
> > The logs also seem OK on my eyes:
> >
> >         [    3.911082]  (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
> >         [    4.001104] pci 0000:00:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000
> >         [    4.043609] pci_bus 0000:01: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
> >         [    4.076756] pci 0000:01:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
> >         [    4.120652] pci_bus 0000:02: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
> >         [    4.150766] pci 0000:02:01.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
> >         [    4.196413] pci 0000:02:04.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
> >         [    4.238896] pci 0000:02:05.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
> >         [    4.280116] pci 0000:02:07.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
> >         [    4.309821] pci 0000:02:09.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0  
> 
> ...these do not.

For the above:

	s/of_node:/BUS of_node:/

The debug printk is misleading. It is actually printing the BUS of_node:

	void pci_set_of_node(struct pci_dev *dev)
	{
		dev_dbg(&dev->dev, "%s: of_node: %pOF\n",
			__func__, dev->bus->dev.of_node);

		if (!dev->bus->dev.of_node)
			return;
	...

If I move it to the right place, e. g.:

	void pci_set_of_node(struct pci_dev *dev)
	{
		if (!dev->bus->dev.of_node) {
			dev_dbg(&dev->dev, "%s: BUS of_node is null\n",
				__func__, dev->bus->dev.of_node);
			return;
		}
		dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
							    dev->devfn);
		if (dev->dev.of_node)
			dev->dev.fwnode = &dev->dev.of_node->fwnode;

		dev_dbg(&dev->dev, "%s: of_node: %pOF\n",
			__func__, dev->dev.of_node);
	}

It will produce:

	[    4.155771]  (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
	[    4.208740] pci 0000:00:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
	[    4.236759] pci_bus 0000:01: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
	[    4.257899] pci 0000:01:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
	[    4.310350] pci_bus 0000:02: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
	[    4.337784] pci 0000:02:01.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@1,0
	[    4.370998] pci 0000:02:04.0: pci_set_of_node: of_node: (null)
	[    4.391459] pci 0000:02:05.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@5,0
	[    4.415378] pci 0000:02:07.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@7,0
	[    4.439420] pci 0000:02:09.0: pci_set_of_node: of_node: (null)
	[    4.494288] pci_bus 0000:03: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@1,0
	[    4.511394] pci_bus 0000:04: pci_set_bus_of_node: of_node: (null)
	[    4.525084] pci_bus 0000:05: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@5,0
	[    4.542173] pci_bus 0000:06: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@7,0
	[    4.578575] pci 0000:06:00.0: pci_set_of_node: of_node: (null)
	[    4.612159] pci_bus 0000:07: pci_set_bus_of_node: of_node: (null)

Which reflects the PCIe topology.

Thanks,
Mauro

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2733E8A5F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 08:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhHKGrV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 02:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234760AbhHKGrS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Aug 2021 02:47:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B30CD6056C;
        Wed, 11 Aug 2021 06:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628664415;
        bh=cQZ5Ceo92fMCjMoNepYyMcCXXNTel21pdVZSy1necE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qdv/OdiGLopkL3HLUtMTkU/J55Jq5uVtPc+rOe2OqCI1vFdaj/fWhCo0PlrudoKyS
         mn4T/GtTI6Mmu2FZSuwSez46llplA0WUkMZA+fdPH4dz0nA5YInlnFjNa+83qPleBa
         dXa0/YgrSV/HsXseq7ianHJbfDxkTR5o5ItPHvnf/8sPWw8zqJ0CXb0HOG6+3wyoqM
         E9YLbZmUrB/4kiYoBV4647gUoHq7TZkT//rMo68UMFhNc+Sv504DDZUFMDg6HMabMA
         JMS/rlWHXtPuGbOj5bB+LQUu6Q+WO9ciKe3H9/WpZFB2CLLJNJkBw54osbhbassMD0
         1QIWqV2SXli+A==
Date:   Wed, 11 Aug 2021 08:46:48 +0200
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
Message-ID: <20210811084648.66ddff29@coco.lan>
In-Reply-To: <CAL_JsqL-R=kTugNAC-C1gfSm6Xnb0Nw_iLcRki8aQMNQjcLN6A@mail.gmail.com>
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
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Tue, 10 Aug 2021 11:13:48 -0600
Rob Herring <robh@kernel.org> escreveu:

> > > >                                         compatible = "pciclass,0604";
> > > >                                         device_type = "pci";
> > > >                                         #address-cells = <3>;
> > > >                                         #size-cells = <2>;
> > > >                                         ranges;
> > > >                                 };
> > > >                                 pcie@1,0 { // Lane 4: M.2  
> > >
> > > These 3 nodes (1, 5, 7) need to be child nodes of the above node.  
> 
> This was the main issue.

Ok, placing 1, 5, 7 as child nodes of 0 worked, with the attached
DT schema:


	$ ls -l $(find /sys/devices/platform/soc/f4000000.pcie/ -name of_node)
	lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/of_node -> ../../../../firmware/devicetree/base/soc/pcie@f4000000
	lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:01.0/of_node -> ../../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@1,0
	lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:01.0/pci_bus/0000:03/of_node -> ../../../../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@1,0
	lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:05.0/of_node -> ../../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@5,0
	lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:05.0/pci_bus/0000:05/of_node -> ../../../../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@5,0
	lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:07.0/of_node -> ../../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@7,0
	lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:07.0/pci_bus/0000:06/of_node -> ../../../../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@7,0
	lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/of_node -> ../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/pcie@0,0
	lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/pci_bus/0000:02/of_node -> ../../../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/pcie@0,0
	lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/of_node -> ../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0
	lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/pci_bus/0000:01/of_node -> ../../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0
	lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f4000000.pcie/pci0000:00/pci_bus/0000:00/of_node -> ../../../../../../../firmware/devicetree/base/soc/pcie@f4000000

The logs also seem OK on my eyes:

	[    3.911082]  (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
	[    4.001104] pci 0000:00:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000
	[    4.043609] pci_bus 0000:01: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
	[    4.076756] pci 0000:01:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
	[    4.120652] pci_bus 0000:02: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
	[    4.150766] pci 0000:02:01.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
	[    4.196413] pci 0000:02:04.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
	[    4.238896] pci 0000:02:05.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
	[    4.280116] pci 0000:02:07.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
	[    4.309821] pci 0000:02:09.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
	[    4.370830] pci_bus 0000:03: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@1,0
	[    4.382345] pci_bus 0000:04: pci_set_bus_of_node: of_node: (null)
	[    4.411966] pci_bus 0000:05: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@5,0
	[    4.439898] pci_bus 0000:06: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@7,0
	[    4.491616] pci 0000:06:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@7,0
	[    4.519907] pci_bus 0000:07: pci_set_bus_of_node: of_node: (null)

Thanks,
Mauro


		pcie@f4000000 {
			compatible = "hisilicon,kirin970-pcie";
			reg = <0x0 0xf4000000 0x0 0x1000000>,
			      <0x0 0xfc180000 0x0 0x1000>,
			      <0x0 0xf5000000 0x0 0x2000>;
			reg-names = "dbi", "apb", "config";
			bus-range = <0x00 0xff>;
			#address-cells = <3>;
			#size-cells = <2>;
			device_type = "pci";
			phys = <&pcie_phy>;
			ranges = <0x02000000 0x0 0x00000000
				  0x0 0xf6000000
				  0x0 0x02000000>;
			num-lanes = <1>;
			#interrupt-cells = <1>;
			interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
			interrupt-names = "msi";
			interrupt-map-mask = <0 0 0 7>;
			interrupt-map = <0x0 0 0 1
					 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
					<0x0 0 0 2
					 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
					<0x0 0 0 3
					 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
					<0x0 0 0 4
					 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
			reset-gpios = <&gpio7 0 0>;
			hisilicon,clken-gpios = <&gpio27 3 0>, <&gpio17 0 0>,
						<&gpio20 6 0>;
			pcie@0,0 { // Lane 0: PCIe switch: Bus 1, Device 0
				reg = <0x80 0 0 0 0>;
				compatible = "pciclass,0604";
				device_type = "pci";
				#address-cells = <3>;
				#size-cells = <2>;
				ranges;
				bus-range = <0x01 0xff>;
				msi-parent = <&its_pcie>;

				pcie@0,0 { // Lane 0: upstream
					reg = <0x010000 0 0 0 0>;
					compatible = "pciclass,0604";
					device_type = "pci";
					#address-cells = <3>;
					#size-cells = <2>;
					ranges;

					pcie@1,0 { // Lane 4: M.2
						reg = <0x010800 0 0 0 0>;
						compatible = "pciclass,0604";
						device_type = "pci";
						reset-gpios = <&gpio3 1 0>;
						#address-cells = <3>;
						#size-cells = <2>;
						ranges;
					};

					pcie@5,0 { // Lane 5: Mini PCIe
						reg = <0x012800 0 0 0 0>;
						compatible = "pciclass,0604";
						device_type = "pci";
						reset-gpios = <&gpio27 4 0 >;
						#address-cells = <3>;
						#size-cells = <2>;
						ranges;
					};

					pcie@7,0 { // Lane 6: Ethernet
						reg = <0x013800 0 0 0 0>;
						compatible = "pciclass,0604";
						device_type = "pci";
						reset-gpios = <&gpio25 2 0 >;
						#address-cells = <3>;
						#size-cells = <2>;
						ranges;
					};
				};
			};
		};

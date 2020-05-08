Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A7B1CB5F5
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 19:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgEHR26 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 13:28:58 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17722 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726825AbgEHR25 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 May 2020 13:28:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588958908; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=GAZYMCwEX6Ta3VOF8gLOTnkXSnfC9NYk5BnySQRKU1221ge5QEim75BZLU3ZQlIcfCRUIkfYr/ZSuwWtJlT0b1WWs4Iykx36Do2MkZH6vvv3/I7rhbKcLJ9m2PKKXHcHtTSdNp0LwsnT/R0XhTSi0uVViOKW2gQ5NbFxKbqyGDA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1588958908; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=4lyVxh+3G0rTYVCcipn3Y5SgXllyr4eDc6eiR7gUy7g=; 
        b=NdptlRstKDYgbhQSotyvFFDVpbMCqx6fBRDmz9F8xaGI4xmNdYcBqZYDKC3VNQDjdYLUAj/QFdqzdi9nRwUq2ZDDbDxwDlM+PsVqR1zyL/iqnuAhPin89qG/gMPCITB+VwIkHZs/Ic9ozEnESUJeVaP6BS0RhVQnH4y6F2GMm3A=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=flygoat.com;
        spf=pass  smtp.mailfrom=jiaxun.yang@flygoat.com;
        dmarc=pass header.from=<jiaxun.yang@flygoat.com> header.from=<jiaxun.yang@flygoat.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1588958908;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=Date:From:To:CC:Subject:Reply-to:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=4lyVxh+3G0rTYVCcipn3Y5SgXllyr4eDc6eiR7gUy7g=;
        b=dk7U8xDgEzi4JR9eNw+mgnzl6aQYbzn1y9MUfy8ISYV3EecZ9ataENObc3nbD7xO
        UyNI7cVL5LdtycpFL7mc2JjaQqqzuvF2PF5i+oyCcTTBK/oTT2B6/i5xjkBLAiKURnw
        UA/R3SSbPYU1RYtAFbEjPS5EaDAYhbWZCKCA4kvw=
Received: from [127.0.0.1] (114.87.80.20 [114.87.80.20]) by mx.zoho.com.cn
        with SMTPS id 1588958906815418.26657766614665; Sat, 9 May 2020 01:28:26 +0800 (CST)
Date:   Sat, 09 May 2020 01:28:24 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     maz@kernel.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v8 2/5] PCI: Add Loongson PCI Controller support
User-Agent: K-9 Mail for Android
Reply-to: jiaxun.yang@flygoat.com
In-Reply-To: <20200508171730.GA77036@bjorn-Precision-5520>
References: <20200508171730.GA77036@bjorn-Precision-5520>
Message-ID: <2C23FC3E-6BBF-47EB-8EE6-89EAC5A28104@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B45=E6=9C=889=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=881:=
17:30, Bjorn Helgaas <helgaas@kernel=2Eorg> =E5=86=99=E5=88=B0:
>On Fri, May 08, 2020 at 07:34:02PM +0800, Jiaxun Yang wrote:
>> This controller can be found on Loongson-2K SoC, Loongson-3
>> systems with RS780E/LS7A PCH=2E
>>=20
>> The RS780E part of code was previously located at
>> arch/mips/pci/ops-loongson3=2Ec and now it can use generic PCI
>> driver implementation=2E
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>> Reviewed-by: Rob Herring <robh@kernel=2Eorg>
>
>> +static void system_bus_quirk(struct pci_dev *pdev)
>> +{
>> +	u16 tmp;
>> +
>> +	/*=20
>> +	 * System buses on Loongson system contain garbage in BARs
>> +	 * but their decoding need to be enabled to ensure devices
>> +	 * under system buses are reachable=2E In most cases it should
>> +	 * be done by the firmware=2E
>
>This isn't a very satisfying explanation because devices that have
>decoding enabled can interfere with other devices in the system, and I
>can't tell whether that's a problem here=2E
>
>What happens when you turn on MEM/IO decoding below?  Does the device
>decode any address space?  How do we know what it is?  Is it related
>to the BAR contents?
>
>I'm a little dubious about the need for the PCI_COMMAND write because
>the previous version didn't do it (since it incorrectly wrote to
>PCI_STATUS), and I assume that version worked=2E

Hi,
Sorry, but that's all I can tell from the chips manual as I'm not a employ=
ee
of the vendor=2E

My assumption is these BAR contains the address of those system components
that already configured by firmware and we shouldn't touch it=2E

In fact according to my tests if we let Kernel probe these BAR then the
system will hang immediately=2E

Chip manual suggested OS to ensure decoding is enabled
so I'm doing like this=2E But without this system can also work=2E

Do you think I should drop it until figure out what was it actually doing?

>
>> +	pdev->mmio_always_on =3D 1;
>> +	pdev->non_compliant_bars =3D 1;
>> +	/* Enable MEM & IO Decoding */
>> +	pci_read_config_word(pdev, PCI_COMMAND, &tmp);
>> +	tmp |=3D PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
>> +	pci_write_config_word(pdev, PCI_COMMAND, tmp);
>
>
>> +}
>> +
>
>Omit this blank line=2E

Ack

>
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>> +			DEV_LS2K_APB, system_bus_quirk);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>> +			DEV_LS7A_CONF, system_bus_quirk);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>> +			DEV_LS7A_LPC, system_bus_quirk);
>> +
>> +static void loongson_mrrs_quirk(struct pci_dev *dev)
>> +{
>> +	struct pci_bus *bus =3D dev->bus;
>> +	struct pci_dev *bridge;
>> +	static const struct pci_device_id bridge_devids[] =3D {
>> +		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
>> +		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
>> +		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
>> +		{ 0, },
>> +	};
>> +
>> +
>
>Remove one of these blank lines=2E

Ack

>
>> +	/* look for the matching bridge */
>> +	while (!pci_is_root_bus(bus)) {
>> +		bridge =3D bus->self;
>> +		bus =3D bus->parent;
>> +		/*
>> +		 * Some Loongson PCIe ports have a h/w limitation of
>> +		 * 256 bytes maximum read request size=2E They can't handle
>> +		 * anything larger than this=2E So force this limit on
>> +		 * any devices attached under these ports=2E
>> +		 */
>> +		if (pci_match_id(bridge_devids, bridge)) {
>> +			if (pcie_get_readrq(dev) > 256) {
>> +				pci_info(dev, "limiting MRRS to 256\n");
>> +				pcie_set_readrq(dev, 256);
>> +			}
>> +			break;
>> +		}
>> +	}
>> +}
>> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
>
>> +void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int d=
evfn,
>> +			       int where)
>> +{
>> +	unsigned char busnum =3D bus->number;
>> +	struct pci_host_bridge *bridge =3D pci_find_host_bridge(bus);
>> +	struct loongson_pci *priv =3D  pci_host_bridge_priv(bridge);
>> +
>> +	/*
>> +	 * Do not read more than one device on the bus other than
>> +	 * the host bridge=2E
>
>s/host bridge/root bus/ ?
>
>IIUC, the test below assumes the root bus is bus 0, which is not
>necessarily the case=2E  Many other =2E*_map_bus() implementations have
>similar tests for devices on the root bus:

Ack

>
>  al_pcie_map_bus(=2E=2E=2E)
>  {
>    if (bus->number =3D=3D cfg->busr=2Estart) {
>
>> +	if (priv->flags & FLAG_DEV_FIX && bus->primary !=3D 0 &&
>> +		PCI_SLOT(devfn) > 0)
>> +		return NULL;

Thanks!

--=20
Jiaxun Yang

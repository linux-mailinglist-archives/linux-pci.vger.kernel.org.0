Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853C31D0445
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 03:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgEMBUr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 May 2020 21:20:47 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17766 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731604AbgEMBUr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 May 2020 21:20:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589332815; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=cjRqHgQoFQcF9dXuptd75t76dh9Ox5nQ6TBCswsAIE4vmMvZMewIFAKPRRPZe/PJS2bY6Znhx+4w0WAA5Mc10//xuHcGOXibicDt0DNxz/yqmBq9jqQYI0HOJKQZLeRu97PeXH0+eg7Wh7IEp7qIfK2cgzhh49fR11LSI9OmNkM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1589332815; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=UUH9TBEsGZClV0UvQJYkiGlyJwxsXutgInjbHM/99OA=; 
        b=UeVNz+dMSImscqxWTjoQW6hcrDNWN8PeWNk2/x2Z7sWF8rnNDKBCow+UF1rwxfp6prWwIgTltl1mXREQhk3JzzzL9uRc8V36S/nmjqTuPp8mHYV/KUcZasCsX1zXsKb+mm4yvqUoOl5SfBFRA/dS2EfEd67YRPZXmbW7VWWx9bw=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=flygoat.com;
        spf=pass  smtp.mailfrom=jiaxun.yang@flygoat.com;
        dmarc=pass header.from=<jiaxun.yang@flygoat.com> header.from=<jiaxun.yang@flygoat.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1589332815;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=Date:From:To:CC:Subject:Reply-to:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=UUH9TBEsGZClV0UvQJYkiGlyJwxsXutgInjbHM/99OA=;
        b=bcpCCd4IolU5WLkjKiiyehRsPV+/qDkYcYvv6kgawo3IpvNaL0dpUfqw1G/bJJ3B
        hTpUDBXWRJAWXQfNpXFhEmkx6v6tDlprHuJHAJtFK56CoaoP5V9/naZuiG0Yo92b7Hd
        2ymduufrqGSTuebNjO6jnOS0hJEjt+PQJZIAEou0=
Received: from [127.0.0.1] (223.104.5.223 [223.104.5.223]) by mx.zoho.com.cn
        with SMTPS id 1589332811518609.5936666834109; Wed, 13 May 2020 09:20:11 +0800 (CST)
Date:   Wed, 13 May 2020 09:20:08 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v9 2/5] PCI: Add Loongson PCI Controller support
User-Agent: K-9 Mail for Android
Reply-to: jiaxun.yang@flygoat.com
In-Reply-To: <20200512180602.GA273658@bjorn-Precision-5520>
References: <20200512180602.GA273658@bjorn-Precision-5520>
Message-ID: <08C2301A-7349-4044-80F4-0B0520780DB9@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B45=E6=9C=8813=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=882=
:06:02, Bjorn Helgaas <helgaas@kernel=2Eorg> =E5=86=99=E5=88=B0:
>On Tue, May 12, 2020 at 03:43:56PM +0800, Jiaxun Yang wrote:
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
>> +	 * These devices are not sharing resouces with rest of devices
>> +	 * on host bus and firmware will ensure their BARs are placed
>> +	 * in safe ranges=2E Also there might be some config registers
>> +	 * in their config space so kernel shouldn't ignore them=2E
>
>"Firmware ensuring BARs are placed in 'safe' ranges" is not a
>sufficient answer=2E  As I said before, Linux needs to know both the
>ADDRESS and the SIZE of whatever non-standard BARs these are=2E
>Otherwise, we're liable to assign that space to a different device=2E

The address assigned to these devices will never be a part of resources
belongs to the host bridge=2E That's enforced by hardware and firmware,
so address conflict would never happen=2E

I'm doing like this to ensure kernel will discover this device but do noth=
ing
about assignment of resources to it=2E

>
>If you have to hard-code the size, so be it=2E  That would mean the
>hardware is completely broken, but at least we could make Linux deal
>with it=2E  If the hardware consumes address space we don't know about,
>we can't deal with that=2E
>
>> +	 */
>> +	pdev->mmio_always_on =3D 1;
>> +	pdev->non_compliant_bars =3D 1;
>> +}
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
>> +	 * the host bus 0=2E
>> +	 */
>
>If the hardware is restricted such that the root bus number must be
>zero, pleae say that explicitly here=2E  Otherwise, it just looks like
>a bug=2E
>
>> +	if (priv->flags & FLAG_DEV_FIX && busnum !=3D 0 &&
>> +		PCI_SLOT(devfn) > 0)
>> +		return NULL;
>> +
>> +	/* CFG0 can only access standard space */
>> +	if (where < PCI_CFG_SPACE_SIZE && priv->cfg0_base)
>> +		return cfg0_map(priv, busnum, devfn, where);
>> +
>> +	/* CFG1 can access extended space */
>> +	if (where < PCI_CFG_SPACE_EXP_SIZE && priv->cfg1_base)
>> +		return cfg1_map(priv, busnum, devfn, where);
>> +
>> +	return NULL;
>> +}

--=20
Jiaxun Yang

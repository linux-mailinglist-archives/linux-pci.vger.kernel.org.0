Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB4577FC0
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 12:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiGRKeb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 06:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiGRKeb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 06:34:31 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D15BF584;
        Mon, 18 Jul 2022 03:34:28 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 898BC1BF213;
        Mon, 18 Jul 2022 10:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1658140463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1lqJZ9DNNSoJTbftea7WtGsRy5Q9ZGtnWZ4Y0cfLY+A=;
        b=lGKgx5Nf78B5wKkeuRyvCSpoFrWu/7f2I03CPhtv7JAzzr5kTEE9wh0C9pzvo2KMNdHDhz
        yM3UGQQ022Y3RhGZgNErDcunq0moN5f25NZVgM7Swz4f1Obz67K5EReFKDb6VrrXhpCMTF
        X7HwBGo15J96GP9oMFoN8uT9JaiyYSU878i9NmxQLJKA7taQGOLfdNPqMixRyVeex5Sm0W
        Fa1dkg3ZQPI3FdxHY4/cpaMKdZUEEORyf16dnQ4fYKq3rvZ7+j+A9Nms/U7i8md5KEfIvD
        3NV7tiMf2341QbcfJx8iDL6XfRMtSUDVFAcSXymBt4m3Akp/sVfkh1xdoOvPGA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: Marvell: Update PCIe fixup
In-Reply-To: <20220219143006.bsr6wdagf5ytynxu@pali>
References: <20211101150405.14618-1-pali@kernel.org>
 <20211102171259.9590-1-pali@kernel.org>
 <20220219143006.bsr6wdagf5ytynxu@pali>
Date:   Mon, 18 Jul 2022 12:34:19 +0200
Message-ID: <8735eyso9g.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> PING, Gente reminder for patch 1/2.

Applied on mvebu/arm, it was waiting too long.

Thanks,

Gregory

>
> On Tuesday 02 November 2021 18:12:58 Pali Roh=C3=A1r wrote:
>> - The code relies on rc_pci_fixup being called, which only happens
>>   when CONFIG_PCI_QUIRKS is enabled, so add that to Kconfig. Omitting
>>   this causes a booting failure with a non-obvious cause.
>> - Update rc_pci_fixup to set the class properly, copying the
>>   more modern style from other places
>> - Correct the rc_pci_fixup comment
>>=20
>> This patch just re-applies commit 1dc831bf53fd ("ARM: Kirkwood: Update
>> PCI-E fixup") for all other Marvell ARM platforms which have same buggy
>> PCIe controller and do not use pci-mvebu.c controller driver yet.
>>=20
>> Long-term goal for these Marvell ARM platforms should be conversion to
>> pci-mvebu.c controller driver and removal of these fixups in arch code.
>>=20
>> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: stable@vger.kernel.org
>>=20
>> ---
>> Changes in v2:
>> * Move MIPS change into separate patch
>> * Add information that this patch is for platforms which do not use pci-=
mvebu.c
>> ---
>>  arch/arm/Kconfig              |  1 +
>>  arch/arm/mach-dove/pcie.c     | 11 ++++++++---
>>  arch/arm/mach-mv78xx0/pcie.c  | 11 ++++++++---
>>  arch/arm/mach-orion5x/Kconfig |  1 +
>>  arch/arm/mach-orion5x/pci.c   | 12 +++++++++---
>>  5 files changed, 27 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index fc196421b2ce..9f157e973555 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -400,6 +400,7 @@ config ARCH_DOVE
>>  	select GENERIC_IRQ_MULTI_HANDLER
>>  	select GPIOLIB
>>  	select HAVE_PCI
>> +	select PCI_QUIRKS if PCI
>>  	select MVEBU_MBUS
>>  	select PINCTRL
>>  	select PINCTRL_DOVE
>> diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
>> index ee91ac6b5ebf..ecf057a0f5ba 100644
>> --- a/arch/arm/mach-dove/pcie.c
>> +++ b/arch/arm/mach-dove/pcie.c
>> @@ -135,14 +135,19 @@ static struct pci_ops pcie_ops =3D {
>>  	.write =3D pcie_wr_conf,
>>  };
>>=20=20
>> +/*
>> + * The root complex has a hardwired class of PCI_CLASS_MEMORY_OTHER, wh=
en it
>> + * is operating as a root complex this needs to be switched to
>> + * PCI_CLASS_BRIDGE_HOST or Linux will errantly try to process the BAR'=
s on
>> + * the device. Decoding setup is handled by the orion code.
>> + */
>>  static void rc_pci_fixup(struct pci_dev *dev)
>>  {
>> -	/*
>> -	 * Prevent enumeration of root complex.
>> -	 */
>>  	if (dev->bus->parent =3D=3D NULL && dev->devfn =3D=3D 0) {
>>  		int i;
>>=20=20
>> +		dev->class &=3D 0xff;
>> +		dev->class |=3D PCI_CLASS_BRIDGE_HOST << 8;
>>  		for (i =3D 0; i < DEVICE_COUNT_RESOURCE; i++) {
>>  			dev->resource[i].start =3D 0;
>>  			dev->resource[i].end   =3D 0;
>> diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
>> index 636d84b40466..9362b5fc116f 100644
>> --- a/arch/arm/mach-mv78xx0/pcie.c
>> +++ b/arch/arm/mach-mv78xx0/pcie.c
>> @@ -177,14 +177,19 @@ static struct pci_ops pcie_ops =3D {
>>  	.write =3D pcie_wr_conf,
>>  };
>>=20=20
>> +/*
>> + * The root complex has a hardwired class of PCI_CLASS_MEMORY_OTHER, wh=
en it
>> + * is operating as a root complex this needs to be switched to
>> + * PCI_CLASS_BRIDGE_HOST or Linux will errantly try to process the BAR'=
s on
>> + * the device. Decoding setup is handled by the orion code.
>> + */
>>  static void rc_pci_fixup(struct pci_dev *dev)
>>  {
>> -	/*
>> -	 * Prevent enumeration of root complex.
>> -	 */
>>  	if (dev->bus->parent =3D=3D NULL && dev->devfn =3D=3D 0) {
>>  		int i;
>>=20=20
>> +		dev->class &=3D 0xff;
>> +		dev->class |=3D PCI_CLASS_BRIDGE_HOST << 8;
>>  		for (i =3D 0; i < DEVICE_COUNT_RESOURCE; i++) {
>>  			dev->resource[i].start =3D 0;
>>  			dev->resource[i].end   =3D 0;
>> diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconf=
ig
>> index e94a61901ffd..7189a5b1ec46 100644
>> --- a/arch/arm/mach-orion5x/Kconfig
>> +++ b/arch/arm/mach-orion5x/Kconfig
>> @@ -6,6 +6,7 @@ menuconfig ARCH_ORION5X
>>  	select GPIOLIB
>>  	select MVEBU_MBUS
>>  	select FORCE_PCI
>> +	select PCI_QUIRKS
>>  	select PHYLIB if NETDEVICES
>>  	select PLAT_ORION_LEGACY
>>  	help
>> diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
>> index 76951bfbacf5..5145fe89702e 100644
>> --- a/arch/arm/mach-orion5x/pci.c
>> +++ b/arch/arm/mach-orion5x/pci.c
>> @@ -509,14 +509,20 @@ static int __init pci_setup(struct pci_sys_data *s=
ys)
>>  /**********************************************************************=
*******
>>   * General PCIe + PCI
>>   **********************************************************************=
******/
>> +
>> +/*
>> + * The root complex has a hardwired class of PCI_CLASS_MEMORY_OTHER, wh=
en it
>> + * is operating as a root complex this needs to be switched to
>> + * PCI_CLASS_BRIDGE_HOST or Linux will errantly try to process the BAR'=
s on
>> + * the device. Decoding setup is handled by the orion code.
>> + */
>>  static void rc_pci_fixup(struct pci_dev *dev)
>>  {
>> -	/*
>> -	 * Prevent enumeration of root complex.
>> -	 */
>>  	if (dev->bus->parent =3D=3D NULL && dev->devfn =3D=3D 0) {
>>  		int i;
>>=20=20
>> +		dev->class &=3D 0xff;
>> +		dev->class |=3D PCI_CLASS_BRIDGE_HOST << 8;
>>  		for (i =3D 0; i < DEVICE_COUNT_RESOURCE; i++) {
>>  			dev->resource[i].start =3D 0;
>>  			dev->resource[i].end   =3D 0;
>> --=20
>> 2.20.1
>>=20

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

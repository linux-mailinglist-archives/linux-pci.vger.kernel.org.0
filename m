Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DB53ED2FE
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 13:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbhHPLTD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Aug 2021 07:19:03 -0400
Received: from ni.piap.pl ([195.187.100.5]:46120 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231143AbhHPLTD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Aug 2021 07:19:03 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 3498FC3F2A57;
        Mon, 16 Aug 2021 13:18:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 3498FC3F2A57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1629112710; bh=jom1m2zV0A64UbIJZMq9VLdri6bu1FYEMPAJTzg5Phg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dYvD/qzboATUDqZDtrhBSDNnQV6eV9SgQUQU8sIg5yw2TjlndYDs1E49SdciIru6+
         I6bfUznjxZB8z7nFJF1avTVkyQqVfFumLpYf0cjiwvZa17VY4myCm9ZM9tyKD+NKz3
         22q9yeLlaPr5JLCCmUpDZarcon8kRlJ2622gOtGE=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84s?= =?utf-8?Q?ki?= 
        <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Artem Lapkin <email2tema@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCIe: limit Max Read Request Size on i.MX to 512 bytes
References: <20210813192254.GA2604116@bjorn-Precision-5520>
        <m3wnomynkm.fsf@t19.piap.pl>
        <VI1PR04MB5853728C0FD18D19901138048CFD9@VI1PR04MB5853.eurprd04.prod.outlook.com>
Sender: khalasa@piap.pl
Date:   Mon, 16 Aug 2021 13:18:30 +0200
In-Reply-To: <VI1PR04MB5853728C0FD18D19901138048CFD9@VI1PR04MB5853.eurprd04.prod.outlook.com>
        (Richard Zhu's message of "Mon, 16 Aug 2021 07:49:52 +0000")
Message-ID: <m3o89xzlh5.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 165577 [Aug 16 2021]
X-KLMS-AntiSpam-Version: 5.9.20.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Info: LuaCore: 454 454 39c6e442fd417993330528e7f9d13ac1bf7fdf8c, {Tracking_marketers, three}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;piap.pl:7.1.1;t19.piap.pl:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2021/08/16 10:32:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2021/08/15 23:54:00 #17042267
X-KLMS-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Richard,

Please correct me if I got something wrong:

> Regarding my understanding, that there should be decomposition operations=
 if the
>  Max_Read_Request_Size is larger than the Max_Payload_size specified
>  by RC port.

I think this means that, for example, a memory read request (a single
short physical TLP packet on PCIe, from the peripheral device to the
CPU) can request more data than Max_Payload_size (128 bytes on i.MX6).
In such case, up to 4 "completion" physical TLP packets are returned by
the CPU (up to 512 bytes, with each individual TLP up to 128 bytes as
per Max_Payload_size).

The device can't request more than 512 bytes, though - the CPU would not
service such request.

> The bit0 of AMBA Multiple Outbound Decomposed NP Sub-Requests Control Reg=
ister(Offset:0x700 + 0x24)
>  had been set to be 1b1 in default.
>
> Note: The description of this bit.
> Enable AMBA Multiple Outbound Decomposed NP Sub- Requests.
> This bit when set to '0' disables the possibility of having multiple outs=
tanding non-posted requests that
> were derived from decomposition of an outbound AMBA request. See Supporte=
d AXI Burst Operations for
> more details.

I think the above means that - when I disable the bit in question - I
can't issue memory read requests longer than 128 bytes (max payload
size).

This is not exactly clear to me:

> You should not clear this register unless your application master is
> requesting an amount of read data greater than Max_Read_Request_Size,
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Is "completing" such a request at all possible?
The device shouldn't request more data than its (not CPU's)
Max_Read_Request_Size. I. e. if 512 is written to RTL8111's
Max_Read_Request_Size, then the Realtek chip will request max 512 bytes
at a time.

> and the remote device (or switch) is reordering completions that have
> different tags

Fortunately, such completions don't seem to be reordered.

However, I'm not sure how setting a bit in the CPU registers could help
here. I think the only way *IF* the completions were reordered would be
setting MRRS =3D MPS (=3D 128 bytes on i.MX6) - so there is nothing that
could be reordered.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa

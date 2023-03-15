Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FB06BABDA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 10:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjCOJOF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 05:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjCOJN3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 05:13:29 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09B520543
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 02:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678871596; x=1710407596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ynUyFtPJe+8qjzMq2dP0OfMsuwyEwaqT9RTkOz0XYsQ=;
  b=Vk0fkToXIvBq0IX7FzFDDYhbhkXRGqXfuvk4LdyRT0BXzRltXeL0lsWS
   ZsSsaDz25jCpxA5KN8JWB/pyOxmLGqyMtjmwIQ7noFyX2rTRiNM/DTv4T
   AvFNhtqtk1Lfmbu21m72S3/RG1UMzNFq5sObb3+f1gZjNkUBzLdu2aqJA
   ALmT6BXylDr18JZKgg1WBHVxY8b1bQWAqIA4DMEGf6KMt0HlfUgvG40Qy
   OyY6LxssiFW8AGQIKL5SNkm5yWMv4078cfDN6bceFD57ed/uAG+GVQF1Z
   URG9nC/GCyNVdzQnedSD07sGrI4/Q3zmyZyUatRV36VkAPRpTsW6J7yLG
   w==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="225463461"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 17:12:54 +0800
IronPort-SDR: l0/afbWCICvLhWl2bxhx1fxr+mBO1IDYRZgBUgveH8k52KFtZTls30c/XORDN2cDGYCSR/faSz
 oGDOne2U9tjkQt0exn/nrtdsPEAg/iuzulGr8HebQf4/S+5QVf1gIeoeq/LeQfVGTnNNR4fCvA
 IPZdxyWgqNeZ5pxNbISInPnc7boj6Fa/GX2ojx4N36/1SEjm9L2jOwKYQ8WlB0QbwJ6Y2O5ftS
 zKdxGgpCvXUmb0jUx1CjyDosC0F3GHh32h/YlgjOfieHNAdmmdxxNj2PlV4Jnp8eJrfbhBn+I9
 Yfs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 01:23:40 -0700
IronPort-SDR: W2TtUmDIZIZRKe/jijIdjsGTqNEw5tbbbpk//gqb/l8WugacIBWK8L0Yn9VkSHAerMr/W4qVqa
 Gn4bafeyzNQDCUdxKe52Bsiq7K6UK36df46SGz/hzn1V/QrlNf/Slvm0OL/elt2V+Fnw2Q7kki
 AXcSSV/6fCkCbZwAkl2XF240HNGYnyLSkgI1w5Ylmhg4JXd0wIkVhrdNto74zdkDfO5s2nzNNf
 GEgu32OzJ11Rqxe438ZvWnYArpF94Oym9Sd13rs/6A8SiWzTb0WA0BUVLKgw8WrBUFh6xyNwmy
 1fI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 02:12:55 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pc4Rn6wy8z1RtW0
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 02:12:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678871572; x=1681463573; bh=ynUyFtPJe+8qjzMq2dP0OfMsuwyEwaqT9RT
        kOz0XYsQ=; b=XrebnydX6PPijQC6+48JvZDwc6+oPA9n2SNcXSDTRknZL6dEkKL
        LB/LxIv/oTLZF9AgMtKzNG7a+7NuMz8Ez+3Af2P1El6FUUhXBZSv/2ZxPj6i1nGr
        OwsjmwkcBgtDZl8L5WSONyXBkrwK1mAFeooOqU4jJBSMl88QXAGyzd671lnzh4+I
        08o3xpGEj1NE2F+cmES7I+rxMxZZcfUaQtVPFQLB8X5jk19i87A6gBnIA1tX92y5
        XNFjxMsrjGw8MB7mUanHURNAlj8Q4tfFARg5twRq2S366pDjcwUTCqGtD/NIRpNw
        0utgHvH5gXDm4IcQgim9OdY9HSOj1cMBmuA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cso9NMSHNbkN for <linux-pci@vger.kernel.org>;
        Wed, 15 Mar 2023 02:12:52 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pc4Rk0Ng0z1RtVm;
        Wed, 15 Mar 2023 02:12:49 -0700 (PDT)
Message-ID: <c7315ca2-3ebf-7f3b-da64-9a74a995b0ae@opensource.wdc.com>
Date:   Wed, 15 Mar 2023 18:12:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 02/38] ata: add HAS_IOPORT dependencies
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-ide@vger.kernel.org
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-3-schnelle@linux.ibm.com>
 <CAMuHMdVry2YViJ5oFgo9i+uStWbhy7mXKWdWvCX=qgAu1-_Y1w@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAMuHMdVry2YViJ5oFgo9i+uStWbhy7mXKWdWvCX=qgAu1-_Y1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/15/23 17:39, Geert Uytterhoeven wrote:
> Hi Niklas,
>=20
> On Tue, Mar 14, 2023 at 1:12=E2=80=AFPM Niklas Schnelle <schnelle@linux=
.ibm.com> wrote:
>> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and frien=
ds
>> not being declared. We thus need to add HAS_IOPORT as dependency for
>> those drivers using them.
>>
>> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>=20
> Thanks for your patch!
>=20
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -342,6 +342,7 @@ endif # HAS_DMA
>>
>>  config ATA_SFF
>>         bool "ATA SFF support (for legacy IDE and PATA)"
>> +       depends on HAS_IOPORT
>>         default y
>>         help
>>           This option adds support for ATA controllers with SFF
>=20
> ATA_SFF is a dependency for lots of (S)ATA drivers.
> (at least) The following don't use I/O port access:
>=20
>     CONFIG_SATA_RCAR (arm/arm64)
>     CONFIG_PATA_FALCON (m68k/atari and m68k/q40)
>     CONFIG_PATA_GAYLE (m68k/amiga)
>     CONFIG_PATA_BUDDHA (m68k/amiga)
>=20
> (at least) The following can use either MMIO or I/O port accesses:
>=20
>     CONFIG_PATA_PLATFORM (m68k/mac)

But for these arch/platforms, would there be any reason to not have HAS_I=
OPORT ?
It is supported right now, so we should have HAS_IOPORT for them.

>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20

--=20
Damien Le Moal
Western Digital Research


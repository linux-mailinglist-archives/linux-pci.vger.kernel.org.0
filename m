Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EEB6BC1ED
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 00:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjCOX6o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 19:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjCOX6k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 19:58:40 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06101580C4
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 16:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678924701; x=1710460701;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Kgkn81sm7NRXOWlx9WugG0VfUhPksFZvAliPQZFpRVQ=;
  b=M4/fWoYxVkMn7zT9Z82A4zv1j/8AQ5hrOCpLNA5jIQD1rGTdGRWTFg51
   sTm744AZ4SxKaxrieAbTfAibWOGpwUL2LpsMvUJHFy0mNZVX+eY8rogZo
   ZBMXDtZmT4scqIrjuloJuJgxcIPTE4P+8SJyvdNjK6/KRz8pFO4quteDM
   j0oaMRr3vk0c7Z7RMxSQFxcgiuTLsNGRUqrBRqKHRt+KYFw7Qepw0r8AL
   u228eU0DTN6ftsfVnD4QU1U4tuqTeaOsk2hM2yk/mf7a+MNZJ5BafDipu
   y1gksNS+pMpzMqYqI2s2UwYfjIjHxr/4Bc5ImiEBMzo42pHkdd6sdMgSd
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="230684076"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2023 07:57:46 +0800
IronPort-SDR: CcCb9npsXSt6M7iYLBGZdHlzZ+qeBQuTp7oR3krFq6h9wuMku5fNqSfvYPx3JsxI48r4bXCenW
 F4DLUde5L9E7Zb8sv4hgGsAacAilfSQn2LF0NuYHhyBWVQNyZXa5QJs/o0jXFetDrMBVREhuDN
 EFkeio81xTsiriNRgUZA9eMM/QsibyT5+PcXkv1HgbHABGvXK+eoBgKbZbzpnvqCHSr/tZ0iNo
 xXhVJPwzYMlEmFF1u7mWVU+pPlmU2fBd8Xgq0UzsPcyXL0BKCZICmomJHls3eBAECKbFNi7iJG
 NiA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 16:14:12 -0700
IronPort-SDR: 2i1OHvCEthy2fw9alpboi3SVgVijdiAq8YD0+iv9yFA1Cs1dtz+TUL4VR0JHflSRBxptOuarQL
 eAjQsKexyPzbJMOnlXivqWzVBoN6suOxrZxUAPBFhtqHWwEbhX0dSGugb6eL61U69tdwk5xBdM
 d1ZKTxiL/VRHaZIbnspPkEEKah6tgbawkFuQN3yn1BauDN+05CwT8Q6qIMrsII4sJwykfkAZsq
 xkVfKM+clLWVoWTFhJy8oPXjdPCn+porwZva/YbOEFM+BZ4Lu1KJuUrRO5NnzRcgyVdA8KbvMt
 mJ4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 16:57:47 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PcS4n6MlTz1RtW0
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 16:57:45 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678924664; x=1681516665; bh=Kgkn81sm7NRXOWlx9WugG0VfUhPksFZvAli
        PQZFpRVQ=; b=IJtu4gmgw/ynZRHEPjr86PzZEB+9IZ6sFhO3BWek4topABF4AL6
        v3GWhfKBe54UfpGLOFp+QZ0207SarBzrk31qIPDeSsCcTa1sVE9ZQ2bmJGtFKrQD
        FTxO22grvCPJxXI7W2DeuOYT8tAJsT0Ehs3tnsW/CNixYYLG4uGJQYpmZPWIICSm
        jZ/bMPo0r6g5G1+7XnM0IvrxSu5M39QdCyQrQKQ7lNJQd6/WQ/pI30xDh1byrzFN
        HtEWyRNwRo0z0eh3wHvYGoB+TqsYLrPr0WwsolzG75dRQ5uqCaymbGeWw1+QmoEM
        kajt4jFnk5yN3q/hsvMJwI3BTonbXZ3jdig==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g6xRVuAeY9eO for <linux-pci@vger.kernel.org>;
        Wed, 15 Mar 2023 16:57:44 -0700 (PDT)
Received: from [10.89.80.69] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.80.69])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PcS4k216nz1RtVm;
        Wed, 15 Mar 2023 16:57:42 -0700 (PDT)
Message-ID: <9a1c49b0-2271-53c7-7f48-039f83d39e82@opensource.wdc.com>
Date:   Thu, 16 Mar 2023 08:57:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 02/38] ata: add HAS_IOPORT dependencies
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
 <c7315ca2-3ebf-7f3b-da64-9a74a995b0ae@opensource.wdc.com>
 <CAMuHMdVajEYsw8HrKw0GwV+09gbtkhjVMuKZ6RSBvq6got=jAg@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAMuHMdVajEYsw8HrKw0GwV+09gbtkhjVMuKZ6RSBvq6got=jAg@mail.gmail.com>
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

On 2023/03/15 20:36, Geert Uytterhoeven wrote:
> Hi Damien,
>=20
> On Wed, Mar 15, 2023 at 10:12=E2=80=AFAM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>> On 3/15/23 17:39, Geert Uytterhoeven wrote:
>>> On Tue, Mar 14, 2023 at 1:12=E2=80=AFPM Niklas Schnelle <schnelle@lin=
ux.ibm.com> wrote:
>>>> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and fri=
ends
>>>> not being declared. We thus need to add HAS_IOPORT as dependency for
>>>> those drivers using them.
>>>>
>>>> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
>>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>>
>>> Thanks for your patch!
>>>
>>>> --- a/drivers/ata/Kconfig
>>>> +++ b/drivers/ata/Kconfig
>>>> @@ -342,6 +342,7 @@ endif # HAS_DMA
>>>>
>>>>  config ATA_SFF
>>>>         bool "ATA SFF support (for legacy IDE and PATA)"
>>>> +       depends on HAS_IOPORT
>>>>         default y
>>>>         help
>>>>           This option adds support for ATA controllers with SFF
>>>
>>> ATA_SFF is a dependency for lots of (S)ATA drivers.
>>> (at least) The following don't use I/O port access:
>>>
>>>     CONFIG_SATA_RCAR (arm/arm64)
>>>     CONFIG_PATA_FALCON (m68k/atari and m68k/q40)
>>>     CONFIG_PATA_GAYLE (m68k/amiga)
>>>     CONFIG_PATA_BUDDHA (m68k/amiga)
>>>
>>> (at least) The following can use either MMIO or I/O port accesses:
>>>
>>>     CONFIG_PATA_PLATFORM (m68k/mac)
>>
>> But for these arch/platforms, would there be any reason to not have HA=
S_IOPORT ?
>> It is supported right now, so we should have HAS_IOPORT for them.
>=20
> That's the point: on Amiga and Atari, HAS_IOPORT is optional, and
> not related to IDE support. On Mac, it is never present.

Ah. OK. I see now. So indeed, applying the dependency on the entire ATA_S=
FF
group of drivers is very coarse.

Niklas,

Can you change this to apply the dependency per driver ?


--=20
Damien Le Moal
Western Digital Research


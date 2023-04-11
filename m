Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE9E6DDF9B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 17:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjDKP0f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 11:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjDKP0Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 11:26:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7550461B7;
        Tue, 11 Apr 2023 08:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1681226748; i=deller@gmx.de;
        bh=Wot2htN65pbIUsBwaKdvp7Q73WtMX1vVsGGvd6Rr4+A=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=OeNP3IYRJ5e68Wd6JAVzEFB0jyLgQ1CjOW2uGEjoJxkq++FEubmxfDc2z/Nr6kxnW
         fpESzhm+p9QvyQVw/cSVdVhV8fd4LQ51M3PQPKyBW0bjGLVfHztVgq+P/n/K1TDKGd
         xtrgHIKWGoQqOH4c72eP1py/aKflLZW66DEv8POqMO4XZ7Axp6e8Ps0VtuugIq1mQB
         /VEX+WBboG+5pX+WWvBdsM0FZejsGZu3YP3WHjgrabt9xhhsR/qFnwswTXH8Ty+jiR
         YoCV6DTa4/cCS+5lX+d4aJQyx16tCxcF2bhLfRzKu1OPQn4Un6WG+zN14gkJENGyqo
         CoYeZdWJU12Sg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.155.12]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGNC-1q3ElO2diI-00JHXo; Tue, 11
 Apr 2023 17:25:48 +0200
Message-ID: <83acd60f-4a42-25a9-afee-ca7919ee42a9@gmx.de>
Date:   Tue, 11 Apr 2023 17:25:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 2/9] video/aperture: use generic code to figure out the
 vga default device
Content-Language: en-US
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
        daniel.vetter@ffwll.ch, patrik.r.jakobsson@gmail.com,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-fbdev@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
References: <20230406132109.32050-1-tzimmermann@suse.de>
 <20230406132109.32050-3-tzimmermann@suse.de>
 <85282243-33a6-a311-0b50-a7edfc4c4c6e@gmx.de>
 <ZDVwa44NvIXWKWrv@phenom.ffwll.local>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <ZDVwa44NvIXWKWrv@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wNk8ymIJSnVUrrqOZhsgajV/p+XgewfUYGi4BYlBes3eXTxJ6JD
 3aW3iyQpEElp8WZw0lfO8er5i+WeW0pZMxOVQYmEnw23WyqZp9pWgKmYRq94o70W5CkPvFL
 frwMCORlSD7WsvrY1MLyYUVC2KV4P2Njd8Kk7hVu0loqaL5jI3gMkqcnWB73GBlrU9DQXMf
 Z7GjRHTED3tOBCsI8smqw==
UI-OutboundReport: notjunk:1;M01:P0:Kl8LYog+ef0=;yv+I94+n3Xs+A96TwW2Va34/QX0
 P+hHhnccnHj2FpuogIbSMU7F+kQHxX04OYc+Doarg6lYazKQ/cyciCqzYq5Zn4i/xMugevjuU
 KfAV2R1Pp6esI5x2O3mj0xWiHVoiVOYLItVn/L9QbU8mwGHZWHhfGPG586C7Jx/lYaE+dZE5f
 tCK1ci8uIWN0ulUzOWI58Qv78RFZ8kPYV10uf/tYmHyoqblBg2vvG+JqVeFxvCkof4QP1Ol1E
 8/jJvrqCqSOc+sJAFQiVYg6a39HPq5fSxoXQRnqbfFedm4D2fVzmuYMH00jXzgNNHHRGJmMvA
 8nWUVgyEX6NkEU5bTXzOOglTOBPaaShxPDS4O1B2NmSJvPGFE0CKnPGCn5L/RTmVw/ebcwgKY
 YwG3W8btksDSk7aaI2doBUd0NEgkblD5qMfqbgcN8Zm6mNXPVv3Iqhr4ihfKQrGfvcUTXinfF
 hiTPuhlIi4ieHU+iLtvyWeBTmCyj4k0Bz7yeECJrNFuV2zMB2TBzcb74OXnwNaJS2j7iZTMMb
 NohVPUvsmDaxq5EuCKIi8lnspvkUBxS2kTogB41gDT0kbBjV37W664UHY8O8pjcyOpM060LCB
 38gjTx074myGrDanZ+06POTTNNeUOu21WetLckErqL0Q/UTtFjOIBRe/HELTxnoyOHt63olGi
 1RjTGvPAEJcgvKkdKW4XVAG0uOtg2T0mImcorne8EosTBpFYdYeyB/yKGWHu3A9SpPZZsmI6f
 luZ/RQl0sKs/HAAmx5ZkJKLZBEkxGWuISgEnZo1zSL/1lxvXGaXmgeCFkx9nOCT2bjKMjSeZN
 WEpMehtBNW+9+pKDaMjZ8UaEhc6w2tOIRkPgB7OBTSCJMjfjQv2vKA2HQv7K6nQrXvQa/kEy7
 5y08qsBZXwrF8myL0T49LmqWYSn86S8xuyOBO8ns91Z24RY6VPcZuxtBOAWjwQbk+WejNmhZk
 H+ptpw==
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/11/23 16:36, Daniel Vetter wrote:
> On Fri, Apr 07, 2023 at 10:54:00PM +0200, Helge Deller wrote:
>> On 4/6/23 15:21, Thomas Zimmermann wrote:
>>> From: Daniel Vetter <daniel.vetter@ffwll.ch>
>>>
>>> Since vgaarb has been promoted to be a core piece of the pci subsystem
>>> we don't have to open code random guesses anymore, we actually know
>>> this in a platform agnostic way, and there's no need for an x86
>>> specific hack. See also commit 1d38fe6ee6a8 ("PCI/VGA: Move vgaarb to
>>> drivers/pci")
>>>
>>> This should not result in any functional change, and the non-x86
>>> multi-gpu pci systems are probably rare enough to not matter (I don't
>>> know of any tbh). But it's a nice cleanup, so let's do it.
>>>
>>> There's been a few questions on previous iterations on dri-devel and
>>> irc:
>>>
>>> - fb_is_primary_device() seems to be yet another implementation of
>>>     this theme, and at least on x86 it checks for both
>>>     vga_default_device OR rom shadowing. There shouldn't ever be a cas=
e
>>>     where rom shadowing gives any additional hints about the boot vga
>>>     device, but if there is then the default vga selection in vgaarb
>>>     should probably be fixed. And not special-case checks replicated a=
ll
>>>     over.
>>>
>>> - Thomas also brought up that on most !x86 systems
>>>     fb_is_primary_device() returns 0, except on sparc/parisc. But thes=
e
>>>     2 special cases are about platform specific devices and not pci, s=
o
>>>     shouldn't have any interactions.
>>
>> Nearly all graphics cards on parisc machines are actually PCI cards,
>> but the way we handle the handover to graphics mode with STIcore doesn'=
t
>> conflicts with your planned aperture changes.
>> So no problem as far as I can see for parisc...
>
> Ah I thought sticore was some very special bus, if those can be pci card=
s

STI stands for "Standard Text Interface" [1], which is a API of ROM functi=
ons
to output text chars on a console. It's comparable to the text output func=
tions
in a PC-BIOS on x86 and dependend on the ROM it drives any supported card =
which has
a parisc ROM. So, STI supports cards on PCI & AGP busses, as well on older=
 GSC busses.
[1] https://parisc.wiki.kernel.org/images-parisc/e/e3/Sti.pdf

> underneath then I guess some cleanup eventually might be a good idea? Fo=
r
> anything with a pci bus it's rather strange when vgaarb and
> fb_is_primary_device() aren't a match ...

There is no VGA on parisc, so there is no conflict. Cards come either with
a parisc STI ROM to support text mode, or they will only be used as second=
ary
cards only.  The graphics mode is only done in userspace by specific drive=
rs, e.g.
by the X11 server in HP-UX.
Even on x86 the BIOS will only show text output if the graphics card comes
with a VGA-compatible BIOS.

Helge

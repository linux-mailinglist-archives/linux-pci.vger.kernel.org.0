Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE0B3B01EC
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 12:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhFVK7n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 22 Jun 2021 06:59:43 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:53049 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230002AbhFVK7m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jun 2021 06:59:42 -0400
Received: from [77.244.183.192] (port=61762 helo=[192.168.178.41])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lve5s-000E1s-5i; Tue, 22 Jun 2021 12:57:24 +0200
Subject: Re: [PATCH v2] PCI: dra7xx: Fix reset behaviour
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20210531090540.2663171-1-luca@lucaceresoli.net>
 <20210531133211.llyiq3jcfy25tmz4@pali>
 <8ff1c54f-bb29-1e40-8342-905e34361e1c@lucaceresoli.net>
 <9fdbada4-4902-cec1-f283-0d12e1d4ac64@ti.com>
 <20210531162242.jm73yzntzmilsvbg@pali>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <8207a53c-4de9-d0e5-295a-c165e7237e36@lucaceresoli.net>
Date:   Tue, 22 Jun 2021 12:57:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210531162242.jm73yzntzmilsvbg@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 31/05/21 18:22, Pali Rohár wrote:
> Hello Kishon!
> 
> On Monday 31 May 2021 21:30:30 Kishon Vijay Abraham I wrote:
>> I had given the timing mentioned in the specification here
>> https://lore.kernel.org/r/023c9b59-70bb-ed8d-a4c0-76eae726b574@ti.com
>>
>> The PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION defines the Power
>> Sequencing and Reset Signal Timings in Table 2-4. Please also refer Figure
>> 2-10: Power Up of the CEM.
>>
>> ╔═════════════╤══════════════════════════════════════╤═════╤═════╤═══════╗
>> ║ Symbol      │ Parameter                            │ Min │ Max │ Units ║
>> ╠═════════════╪══════════════════════════════════════╪═════╪═════╪═══════╣
>> ║ T PVPERL    │ Power stable to PERST# inactive      │ 100 │     │ ms    ║
>> ╟─────────────┼──────────────────────────────────────┼─────┼─────┼───────╢
>> ║ T PERST-CLK │ REFCLK stable before PERST# inactive │ 100 │     │ μs    ║
>> ╟─────────────┼──────────────────────────────────────┼─────┼─────┼───────╢
>> ║ T PERST     │ PERST# active time                   │ 100 │     │ μs    ║
>> ╟─────────────┼──────────────────────────────────────┼─────┼─────┼───────╢
>> ║ T FAIL      │ Power level invalid to PERST# active │     │ 500 │ ns    ║
>> ╟─────────────┼──────────────────────────────────────┼─────┼─────┼───────╢
>> ║ T WKRF      │ WAKE# rise – fall time               │     │ 100 │ ns    ║
>> ╚═════════════╧══════════════════════════════════════╧═════╧═════╧═══════╝
>>
>> The de-assertion of #PERST is w.r.t both power stable and refclk stable.
> 
> I think this does not fully answer this problematic question. One thing
> is initial power on and second thing is warm reset (when both power and
> clock is stable).
> 
> On more ARM boards, power is not SW controllable and is automatically
> enabled when powering board on. So Tₚᵥₚₑᵣₗ is calculated since
> bootloader and therefore not needed to take into account in kernel.
> 
> Tₚₑᵣₛₜ₋cₗₖ is only 100 µs and experiments proved that 100 µs not enough
> for toggling PERST# GPIO. At least one 1 ms is needed and for some cards
> at least 10 ms. Otherwise cards are not detected.
> 
> So when you have both power and clock stable and you want to reset card
> via PERST# signal, above table does not say how long it is needed to
> have PERST# in reset state.

Nothing happened after a few weeks... I understand that knowing the
correct reset timings is relevant, but unfortunately I cannot help much
in finding out the correct values.

However I'm wondering what should happen to this patch. It *does* fix a
real bug, but potentially with an incorrect or non-optimal usleep range.
Do we really want to ignore a bugfix because we are not sure about how
long this delay should be?

-- 
Luca


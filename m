Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6798B286D8A
	for <lists+linux-pci@lfdr.de>; Thu,  8 Oct 2020 06:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgJHEVH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 8 Oct 2020 00:21:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42382 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgJHEVH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2020 00:21:07 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kQNQO-0003wP-7f
        for linux-pci@vger.kernel.org; Thu, 08 Oct 2020 04:21:04 +0000
Received: by mail-pg1-f200.google.com with SMTP id k9so2880688pgq.19
        for <linux-pci@vger.kernel.org>; Wed, 07 Oct 2020 21:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9WrfU3tD/2sz19xzeRMvClpPRoDMrhHRfoBQbFQDd04=;
        b=TLO04Kg5FlOiTcRTa8DZS80B6ydMqjkGv2ufvimYMKgd0DKLEwxhtEa0uDja19gS38
         YF79ZYkDFhbvFkEakSEBL12h/ugsxMJBTW7a/UxxvRqDK5mbVOn14LycEn2GF1+8Picq
         PooD9kJkNiebqcVgnN8IrAtw8+dXyCO6c8ppRGpMd/FlSudb1VfJ6oPayzP7nOBWgIHj
         5XmkFHGW/c2JhslkeGGjF9IoqvxQ5Mtf2ZNtGVIaNrL2H0WcR7S9dM9W1chNyXIZSKt1
         IgJKwfWcsytUF02vRsvql94QnjIQ8dtRWaxhe3LtvQfkGhSSIWijjrSda//r3iMPxv2v
         Uteg==
X-Gm-Message-State: AOAM532NvP01xt/FTQ+KlhUFbgEHW96jr4ha2QZVm69Dn16v6jJTRBRp
        LNaMqlF1tCTDVJXgvrbTEOE0xOoBOj65JXiCqIeR2gPX2R4LKRN4oiljE7TA3IDL6AxjdZxXj4h
        w3JI46aANkHvqL6ow7XrGA+VLutoHhpvjQPzfAg==
X-Received: by 2002:a63:e813:: with SMTP id s19mr5858485pgh.33.1602130862724;
        Wed, 07 Oct 2020 21:21:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtMAbxmypCoouxiXHmPIv8hogIZKUu+phcGHtvFiG9RJ8xsAUSXLOZbkcoU6iz2mmEGzhRFQ==
X-Received: by 2002:a63:e813:: with SMTP id s19mr5858467pgh.33.1602130862384;
        Wed, 07 Oct 2020 21:21:02 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id v1sm4880573pjd.7.2020.10.07.21.21.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2020 21:21:01 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] Use maximum latency when determining L1 ASPM
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20201007132808.647589-1-ian.kumlien@gmail.com>
Date:   Thu, 8 Oct 2020 12:20:59 +0800
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        refactormyself@gmail.com, puranjay12@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <C9C756B8-6AA8-4E76-B42D-1A5013C81067@canonical.com>
References: <20201007132808.647589-1-ian.kumlien@gmail.com>
To:     Ian Kumlien <ian.kumlien@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Oct 7, 2020, at 21:28, Ian Kumlien <ian.kumlien@gmail.com> wrote:
> 
> Make pcie_aspm_check_latency comply with the PCIe spec, specifically:
> "5.4.1.2.2. Exit from the L1 State"
> 
> Which makes it clear that each switch is required to initiate a
> transition within 1μs from receiving it, accumulating this latency and
> then we have to wait for the slowest link along the path before
> entering L0 state from L1.
> 
> The current code doesn't take the maximum latency into account.
> 
> From the example:
>   +----------------+
>   |                |
>   |  Root complex  |
>   |                |
>   |    +-----+     |
>   |    |32 μs|     |
>   +----------------+
>           |
>           |  Link 1
>           |
>   +----------------+
>   |     |8 μs|     |
>   |     +----+     |
>   |    Switch A    |
>   |     +----+     |
>   |     |8 μs|     |
>   +----------------+
>           |
>           |  Link 2
>           |
>   +----------------+
>   |    |32 μs|     |
>   |    +-----+     |
>   |    Switch B    |
>   |    +-----+     |
>   |    |32 μs|     |
>   +----------------+
>           |
>           |  Link 3
>           |
>   +----------------+
>   |     |8μs|      |
>   |     +---+      |
>   |   Endpoint C   |
>   |                |
>   |                |
>   +----------------+
> 
> Links 1, 2 and 3 are all in L1 state - endpoint C initiates the
> transition to L0 at time T. Since switch B takes 32 μs to exit L1 on
> it's ports, Link 3 will transition to L0 at T+32 (longest time
> considering T+8 for endpoint C and T+32 for switch B).
> 
> Switch B is required to initiate a transition from the L1 state on it's
> upstream port after no more than 1 μs from the beginning of the
> transition from L1 state on the downstream port. Therefore, transition from
> L1 to L0 will begin on link 2 at T+1, this will cascade up the path.
> 
> The path will exit L1 at T+34.
> 
> On my specific system:
> lspci -PP -s 04:00.0
> 00:01.2/01:00.0/02:04.0/04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device 816e (rev 1a)
> 
> lspci -vvv -s 04:00.0
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
> ...
> 		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
> ...
> 
> Which means that it can't be followed by any switch that is in L1 state.
> 
> This patch fixes it by disabling L1 on 02:04.0, 01:00.0 and 00:01.2.
> 
>                                                    LnkCtl    LnkCtl
>           ------DevCap-------  ----LnkCap-------  -Before-  -After--
>  00:01.2                                L1 <32us       L1+       L1-
>  01:00.0                                L1 <32us       L1+       L1-
>  02:04.0                                L1 <32us       L1+       L1-
>  04:00.0  L0s <512 L1 <64us             L1 <64us       L1+       L1-
> 
> Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>

Solves an issue that enabling ASPM on Dell Latitude 5495 causes system freeze.

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
> drivers/pci/pcie/aspm.c | 23 +++++++++++++++--------
> 1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 253c30cc1967..893b37669087 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
> 
> static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> {
> -	u32 latency, l1_switch_latency = 0;
> +	u32 latency, l1_max_latency = 0, l1_switch_latency = 0;
> 	struct aspm_latency *acceptable;
> 	struct pcie_link_state *link;
> 
> @@ -456,10 +456,14 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> 		if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
> 		    (link->latency_dw.l0s > acceptable->l0s))
> 			link->aspm_capable &= ~ASPM_STATE_L0S_DW;
> +
> 		/*
> 		 * Check L1 latency.
> -		 * Every switch on the path to root complex need 1
> -		 * more microsecond for L1. Spec doesn't mention L0s.
> +		 *
> +		 * PCIe r5.0, sec 5.4.1.2.2 states:
> +		 * A Switch is required to initiate an L1 exit transition on its
> +		 * Upstream Port Link after no more than 1 μs from the beginning of an
> +		 * L1 exit transition on any of its Downstream Port Links.
> 		 *
> 		 * The exit latencies for L1 substates are not advertised
> 		 * by a device.  Since the spec also doesn't mention a way
> @@ -469,11 +473,14 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> 		 * L1 exit latencies advertised by a device include L1
> 		 * substate latencies (and hence do not do any check).
> 		 */
> -		latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> -		if ((link->aspm_capable & ASPM_STATE_L1) &&
> -		    (latency + l1_switch_latency > acceptable->l1))
> -			link->aspm_capable &= ~ASPM_STATE_L1;
> -		l1_switch_latency += 1000;
> +		if (link->aspm_capable & ASPM_STATE_L1) {
> +			latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> +			l1_max_latency = max_t(u32, latency, l1_max_latency);
> +			if (l1_max_latency + l1_switch_latency > acceptable->l1)
> +				link->aspm_capable &= ~ASPM_STATE_L1;
> +
> +			l1_switch_latency += 1000;
> +		}
> 
> 		link = link->parent;
> 	}
> -- 
> 2.28.0
> 


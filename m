Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E0D325936
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 23:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhBYWDv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Feb 2021 17:03:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhBYWDt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Feb 2021 17:03:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53FB2614A7;
        Thu, 25 Feb 2021 22:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614290587;
        bh=YFZwtD6FrV0qBTXc2bSi1bgS+z2YqxJwIqbfzl/PfDc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N3NZvOkUW3pAtoquqifCAylAkQnkBVYeLDgyFBAuiLePcizQ/+bvtZ5rAv06P858j
         brelKf9chwCC81Uggc6yImU9nR9mypS1Y09YP340RTBp0Ca4hD3LQzQesFHxoI4rwF
         i9+eCqzNFOSG3wRHrLXaJPHKtZyy3oJggOI77o8dUj6G5NRk4T4SaOl0F5B/9M2/HL
         O65RLd6ofDHD68Se2F7RBn8yPAxLlrNxy/npOWQUsR75wWPvY80P2mPGI0Pcm+vtkU
         gW5WNJWQdC2v+m7cpvAvbK96nQhYX6r1kg9OPTLXHwn9KVSu1Psl7ZWXUmY/zz+WnI
         C2f2oVMyIeWAg==
Date:   Thu, 25 Feb 2021 16:03:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH 1/3] PCI/ASPM: Use the path max in L1 ASPM latency check
Message-ID: <20210225220305.GA35159@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA85sZuSZck+mTnCTkGikuxQpmNyiShmrbhUUtv91rZARL5Jsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 24, 2021 at 11:19:55PM +0100, Ian Kumlien wrote:
> On Thu, Jan 28, 2021 at 1:41 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> >
> > Sorry about the late reply, been trying to figure out what goes wrong
> > since this email...
> >
> > And yes, I think you're right - the fact that it fixed my system was
> > basically too good to be true =)
> 
> So, finally had some time to look at this again...
> 
> I played some with:
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index ac0557a305af..fdf252eee206 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -392,13 +392,13 @@ static void pcie_aspm_check_latency(struct
> pci_dev *endpoint)
> 
>         while (link) {
>                 /* Check upstream direction L0s latency */
> -               if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
> -                   (link->latency_up.l0s > acceptable->l0s))
> +               if ((link->aspm_capable & ASPM_STATE_L0S_UP) /* &&
> +                   (link->latency_up.l0s > acceptable->l0s)*/)
>                         link->aspm_capable &= ~ASPM_STATE_L0S_UP;
> 
>                 /* Check downstream direction L0s latency */
> -               if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
> -                   (link->latency_dw.l0s > acceptable->l0s))
> +               if ((link->aspm_capable & ASPM_STATE_L0S_DW) /* &&
> +                   (link->latency_dw.l0s > acceptable->l0s)*/)
>                         link->aspm_capable &= ~ASPM_STATE_L0S_DW;
>                 /*
>                  * Check L1 latency.
> ---
> 
> Which does perform better but doesn't solve all the issues...
> 
> Home machine:
> Latency:       3.364 ms
> Download:    640.170 Mbit/s
> Upload:      918.865 Mbit/s
> 
> My test server:
> Latency:       4.549 ms
> Download:    945.137 Mbit/s
> Upload:      957.848 Mbit/s
> 
> But iperf3 still gets bogged down...
> [  5]   0.00-1.00   sec  4.66 MBytes  39.0 Mbits/sec    0   82.0 KBytes
> [  5]   1.00-2.00   sec  4.60 MBytes  38.6 Mbits/sec    0   79.2 KBytes
> [  5]   2.00-3.00   sec  4.47 MBytes  37.5 Mbits/sec    0   56.6 KBytes
> 
> And with L1 ASPM disabled as usual:
> [  5]   0.00-1.00   sec   112 MBytes   938 Mbits/sec  439    911 KBytes
> [  5]   1.00-2.00   sec   109 MBytes   912 Mbits/sec  492    888 KBytes
> [  5]   2.00-3.00   sec   110 MBytes   923 Mbits/sec  370   1.07 MBytes
> 
> And just for reference, bredbandskollen again with L1 ASPM disabled:
> Latency:       2.281 ms
> Download:    742.136 Mbit/s
> Upload:      938.053 Mbit/s
> 
> Anyway, we started to look at the PCIe bridges etc, but i think it's
> the network card that is at fault, either with advertised latencies
> (should be lower) or some bug since other cards and peripherals
> connected to the system works just fine...
> 
> So, L0s actually seems to have somewhat of an impact - which I found
> surprising sice both machines are ~6 hops away - however latency
> differs (measured with tcp)
> 
> Can we collect L1 ASPM latency numbers for:
> Ethernet controller: Intel Corporation I211 Gigabit Network Connection (rev 03)

I think the most useful information would be the ASPM configuration of
the tree rooted at 00:01.2 under Windows, since there the NIC should
be supported and have good performance.

Bjorn

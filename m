Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3842207BB
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 10:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgGOIsB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 04:48:01 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:54580 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729377AbgGOIsB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2020 04:48:01 -0400
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.50.144])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5ED8A20055;
        Wed, 15 Jul 2020 08:48:00 +0000 (UTC)
Received: from us4-mdac16-74.at1.mdlocal (unknown [10.110.50.192])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5D39C800A4;
        Wed, 15 Jul 2020 08:48:00 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.50.12])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 19C344004D;
        Wed, 15 Jul 2020 08:47:54 +0000 (UTC)
Received: from webmail.solarflare.com (uk.solarflare.com [193.34.186.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id BD51C4005B;
        Wed, 15 Jul 2020 08:47:53 +0000 (UTC)
Received: from [10.17.20.203] (10.17.20.203) by ukex01.SolarFlarecom.com
 (10.17.10.4) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 15 Jul
 2020 09:47:46 +0100
Subject: Re: [renesas-drivers:master 69/80]
 drivers/net/ethernet/sfc/efx_common.c:1232:19: sparse: sparse: incompatible
 types for operation (==):
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     <kbuild-all@lists.01.org>, <linux-renesas-soc@vger.kernel.org>,
        "Luc Van Oostenryck" <luc.vanoostenryck@gmail.com>,
        <linux-pci@vger.kernel.org>
References: <20200714185622.GA408711@bjorn-Precision-5520>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <a18d4e1e-2ecb-21dc-2547-fa7529e76edd@solarflare.com>
Date:   Wed, 15 Jul 2020 09:47:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200714185622.GA408711@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.203]
X-ClientProxiedBy: ocex03.SolarFlarecom.com (10.20.40.36) To
 ukex01.SolarFlarecom.com (10.17.10.4)
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.6.1012-25542.003
X-TM-AS-Result: No-3.164200-8.000000-10
X-TMASE-MatchedRID: scwq2vQP8OEKZODMWRxkSfZvT2zYoYOwC/ExpXrHizxjjMm9SMavFZz/
        bBwW32ikmWqGYs6oIWaSLFcga7P5vI+eiI05y0fpiVJZi91I9JjLRD51bz5RZC6Zl5fVYhDwSHg
        UVMoIv2GqUwBa6QrA8isHa8EBpdHXDIaTPs5YLz8olijkrg/WpBlKjo8zguyKzP9LEqj2Ynh6xL
        6D9mrQLm6lKwpaJzZc9cmyfKQ9I/wM8jMXjBF+sIMbH85DUZXyYxU/PH+vZxv6C0ePs7A07Y6HM
        5rqDwqt/ICtW1gi3HFB2fMeLDfXVVPQd5RFlm6GYSut6mdoDxMF1eYA3tJgpxL8boLqOA9d6imA
        JlIiDRcE4FNL3+X8n6eXsYmSOazI4vn0zMfSmjYrbLOj1GuP3A+hgLflG6KEo9QjuF9BKnl4IFx
        QIbVomJRMZUCEHkRt
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.164200-8.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.6.1012-25542.003
X-MDID: 1594802874-AYUraoqgDHcT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/07/2020 19:56, Bjorn Helgaas wrote:
> [+cc Luc, linux-pci]
>
> I think what's necessary here is to replace "enum pci_channel_state
> state" with "pci_channel_state_t state", as in 16d79cd4e23b ("PCI: Use
> 'pci_channel_state_t' instead of 'enum pci_channel_state'"):
>
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=16d79cd4e23b
>
> This change should be safe even without 16d79cd4e23b, so there won't
> be a revlock if you make it in the renesas-drivers tree.
This is presumably goingto happen in any tree that pulls both net-next
 and pci/next.  So shouldn't we make the change in net-next, rather than
 in a renesas tree that really has little to do with it other than being
 the first place the problem showed up?
Apart from that question, the fix you describe sounds reasonable afaict,
 and I'll happily Ack a patch.

-ed

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539DD220822
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 11:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgGOJEy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 05:04:54 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:39384 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730476AbgGOJEx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2020 05:04:53 -0400
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.65.61])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5E3EF60054;
        Wed, 15 Jul 2020 09:04:52 +0000 (UTC)
Received: from us4-mdac16-71.ut7.mdlocal (unknown [10.7.64.190])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5BC808009E;
        Wed, 15 Jul 2020 09:04:52 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.65.175])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E622780051;
        Wed, 15 Jul 2020 09:04:51 +0000 (UTC)
Received: from webmail.solarflare.com (uk.solarflare.com [193.34.186.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 95940700066;
        Wed, 15 Jul 2020 09:04:51 +0000 (UTC)
Received: from [10.17.20.203] (10.17.20.203) by ukex01.SolarFlarecom.com
 (10.17.10.4) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 15 Jul
 2020 10:04:45 +0100
Subject: Re: [renesas-drivers:master 69/80]
 drivers/net/ethernet/sfc/efx_common.c:1232:19: sparse: sparse: incompatible
 types for operation (==):
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <kbuild-all@lists.01.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>
References: <20200714185622.GA408711@bjorn-Precision-5520>
 <a18d4e1e-2ecb-21dc-2547-fa7529e76edd@solarflare.com>
 <CAMuHMdVDha=xAAHjKma4pm1bgNt=go0HgUMyCrc3H87cF0f5SA@mail.gmail.com>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <4106f92f-d3c4-a997-12bf-33ac6fc01758@solarflare.com>
Date:   Wed, 15 Jul 2020 10:04:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVDha=xAAHjKma4pm1bgNt=go0HgUMyCrc3H87cF0f5SA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.203]
X-ClientProxiedBy: ocex03.SolarFlarecom.com (10.20.40.36) To
 ukex01.SolarFlarecom.com (10.17.10.4)
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.6.1012-25542.003
X-TM-AS-Result: No-8.638400-8.000000-10
X-TMASE-MatchedRID: oTBA/+sdKaYKZODMWRxkSR/zUsdHHUMC69aS+7/zbj+qvcIF1TcLYCer
        McSBDjG8iAkcECWBvUjofKne0t7ekAAnYruoVDk5Lyz9QvAyHjriXOoSlo9AtSNGK7UC7ElMj8L
        84PT++yGeQY1Vr13M6wHf5fAqYn8kwSIue2XwlRa7B1QwzOcQDxrZv1sbkSoy4PdcWsl+C/MbAG
        SiqJr2FsJ2728pYeUdDfRUKk+cPENLRWiuDIex7p4CIKY/Hg3AnCGS1WQEGtDGr09tQ7Cw/1BIV
        svVu9ABec3QM3secWb6Dt7X/JKpm+9N2BOaiFeP02I279sgQqBWoZ1Cqxvf7quauxDtMNFIlExl
        QIQeRG0=
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.638400-8.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.6.1012-25542.003
X-MDID: 1594803892-iieVUyQibw1t
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15/07/2020 09:55, Geert Uytterhoeven wrote:
> Indeed, it should be fixed at the core, not in an integration testing tree.
> BTW, did it show up in linux-next, too, or have I done a bad merge conflict
> resolution?
Looking at linux-next, it appears tha|t efx_io_error_detected()||there
|| takes a pci_channel_state_t, so Bjorn's fix has already been applied
 there, probably by way of merging pci/next (which applies a conjugate
 fix to efx.c:||efx_io_error_detected()) and net-next (which moves the
 function to efx_common.c).
For whatever reason renesas must've come up with a different merge
 resolution, hence why they're seeing this.

-ed
|||||||||||||

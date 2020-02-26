Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7766116F6BE
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 06:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgBZFEy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 00:04:54 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42976 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgBZFEy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2020 00:04:54 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01Q54jdP108863;
        Tue, 25 Feb 2020 23:04:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582693485;
        bh=lqo6WX/964Fl5gY3pdCYG1dMDaUlkKD2Xu8LIxhgs0s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WAIm8ZxSz+Ibq4sKWxexlByz1bt0/I3srvNikSmCtzyskb5k83CDW+wt+z1WsZ3TG
         U48FG6kcMGrLPncbRgTqYzWlGgAuFbeCKDNW70VNBvPmJW7MuiMeyZKeKlsfael7gh
         SQxkoLjsj2hADTMCzJjrPqlW9G7+hQvXg3dZD86w=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01Q54jP5071349;
        Tue, 25 Feb 2020 23:04:45 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 25
 Feb 2020 23:04:45 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 25 Feb 2020 23:04:45 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01Q54gcf045552;
        Tue, 25 Feb 2020 23:04:43 -0600
Subject: Re: [PATCH 1/5] PCI: endpoint: functions/pci-epf-test: Add DMA
 support to transfer data
To:     Alan Mikhak <alan.mikhak@sifive.com>
CC:     <amurray@thegoodpenguin.co.uk>, <arnd@arndb.de>,
        <bhelgaas@google.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <lorenzo.pieralisi@arm.com>
References: <20200225091130.29467-1-kishon@ti.com>
 <1582665067-20462-1-git-send-email-alan.mikhak@sifive.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7e1202a3-037b-d1f3-f2bf-1b8964787ebd@ti.com>
Date:   Wed, 26 Feb 2020 10:39:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582665067-20462-1-git-send-email-alan.mikhak@sifive.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alan,

On 26/02/20 2:41 am, Alan Mikhak wrote:
> @@ -380,6 +572,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>         int bar;
> 
>         cancel_delayed_work(&epf_test->cmd_handler);
> +       pci_epf_clean_dma_chan(epf_test);
>         pci_epc_stop(epc);
>         for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>                 epf_bar = &epf->bar[bar];
> @@ -550,6 +743,12 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>                 }
>         }
> 
> +       epf_test->dma_supported = true;
> +
> +       ret = pci_epf_init_dma_chan(epf_test);
> +       if (ret)
> +               epf_test->dma_supported = false;
> +
>         if (linkup_notifier) {
>                 epf->nb.notifier_call = pci_epf_test_notifier;
>                 pci_epc_register_notifier(epc, &epf->nb);
> 
> Hi Kishon,
> 
> Looking forward to building and trying this patch series on
> a platform I work on.
> 
> Would you please point me to where I can find the patches
> which add pci_epf_init_dma_chan() and pci_epf_clean_dma_chan()
> to Linux PCI Endpoint Framework?

I've added these functions in pci-epf-test itself instead of adding in
the core files. I realized adding it in core files may not be helpful if
the endpoint function decides to use more number of DMA channels etc.,

Thanks
Kishon

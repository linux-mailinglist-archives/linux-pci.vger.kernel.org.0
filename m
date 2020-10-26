Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674D42992F3
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 17:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786540AbgJZQwR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 12:52:17 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:33868 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786537AbgJZQvz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2020 12:51:55 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 12:51:54 EDT
Received: from localhost (ip-94-112-194-201.net.upcbroadband.cz [94.112.194.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 8DE83400064;
        Mon, 26 Oct 2020 17:42:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1603730541;
        bh=Cyny4Y4Fl6S61Y9NmpnBF2i5HrbyvnoX6jqO7XGt42c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GFQ1wS+uqfgzj4abuJM8J+D5u2+8/ien4GPexCEBf/1fYWmhBkCtKmTi+5KATtliA
         vAP7KW/Jvuauhr+K3pCp3HgsqX47JDrmq562SojNlbjUqfYSBeFtXWKQ7J8AF42X2s
         XuKsDWuJKYpRcveplnxFcmo3ZLwanEu+qc32oKtQkHtDZ5wAkAGOozIicwF46sNb7j
         JWszB66F1ozKH0ip/OTWNBbQioNq9SiedQytZNNKGw5iJFPjUiM9HyJ1rYiSFyF1ml
         tiyQELO5G9ioHuby8kE9pE+a0KsQDT63mAHLFtyPwhkMYAQ9IaSucD/neG0Oyss0DN
         2avJ97rAbjEVA==
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     <vtolkm@googlemail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] PCI: mvebu: Fix duplicate resource requests
Date:   Mon, 26 Oct 2020 17:42:20 +0100
MIME-Version: 1.0
Message-ID: <99b7f3bf-2017-4ad5-b9be-99f356b076c5@cesnet.cz>
In-Reply-To: <20201023145252.2691779-1-robh@kernel.org>
References: <20201023145252.2691779-1-robh@kernel.org>
Organization: CESNET
User-Agent: Trojita/unstable-2020-07-06; Qt/5.14.2; xcb; Linux; 
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On p=C3=A1tek 23. =C5=99=C3=ADjna 2020 16:52:52 CEST, Rob Herring wrote:
> With commit 669cbc708122 ("PCI: Move DT resource setup into
> devm_pci_alloc_host_bridge()"), the DT 'ranges' is parsed and populated
> into resources when the host bridge is allocated. The resources are
> requested as well, but that happens a 2nd time for the mvebu driver in
> mvebu_pcie_parse_request_resources(). We should only be requesting the
> additional resources added in mvebu_pcie_parse_request_resources().
> These are not added by default because the use custom properties rather
> than standard DT address translation.
>
> Also, the bus ranges was also populated by default, so we can remove
> it from mvebu_pci_host_probe().
>
> Fixes: 669cbc708122 ("PCI: Move DT resource setup into=20
> devm_pci_alloc_host_bridge()")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D209729
> Reported-by: vtolkm@googlemail.com
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Without this patch, 5.9.1 won't find the eMMC card on Clearfog Base for me,=20=

so:

Tested-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>

Thanks for the fix,
Jan

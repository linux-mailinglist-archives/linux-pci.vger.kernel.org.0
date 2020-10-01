Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E54280434
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 18:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbgJAQq6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 12:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732107AbgJAQqz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 12:46:55 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A197C0613D0
        for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2020 09:46:55 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6131C22F99;
        Thu,  1 Oct 2020 18:46:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1601570811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SUlIC2qg+S8tqNWZ4hKY5u/wUrtwXqRGM3IktJxX77U=;
        b=eSnTM3IChuDzLyHwrw9AlCth3cEBefgDJrW6fRp9/IJYcbbPTzhJtb6p79i3hLZeG4y2Lt
        UL4dW5BvC1otmA9MY957c5zKzKUSvBw/CKFsLbicMWNXwDHYlmsmj0cQkfra4fK1qZZjSM
        HJA/VRxWo3CQxVHpl5ipQI/rMKlU+9A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Oct 2020 18:46:51 +0200
From:   Michael Walle <michael@walle.cc>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
In-Reply-To: <67ac959f-561e-d1a0-2d89-9a85d5f92c72@ti.com>
References: <20200916054130.8685-1-Zhiqiang.Hou@nxp.com>
 <CAL_JsqJwgNUpWFTq2YWowDUigndSOB4rUcVm0a_U=FEpEmk94Q@mail.gmail.com>
 <HE1PR0402MB3371F8191538F47E8249F048843F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <CAL_JsqLdQY_DqpduaTv4hMDM_-cvZ_+s8W+HdOuZVVYjTO4yxw@mail.gmail.com>
 <HE1PR0402MB337180458625B05D1529535384390@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <20200928093911.GB12010@e121166-lin.cambridge.arm.com>
 <HE1PR0402MB33713A623A37D08AE3253DEB84320@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <DM5PR12MB1276D80424F88F8A9243D5E2DA320@DM5PR12MB1276.namprd12.prod.outlook.com>
 <CAL_JsqJJxq2jZzbzZffsrPxnoLJdWLLS-7bG-vaqyqs5NkQhHQ@mail.gmail.com>
 <9ac53f04-f2e8-c5f9-e1f7-e54270ec55a0@ti.com>
 <CAL_JsqJEp8yyctJYUjHM4Ti6ggPb4ouYM_WDvpj_PiobnAozBw@mail.gmail.com>
 <67ac959f-561e-d1a0-2d89-9a85d5f92c72@ti.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <99d24fe08ecb5a6f5bba7dc6b1e2b42b@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 2020-10-01 15:32, schrieb Kishon Vijay Abraham I:

> Meanwhile would it be okay to add linkup check atleast for DRA7X so 
> that
> we could have it booting in linux-next?

Layerscape SoCs (at least the LS1028A) are also still broken in 
linux-next,
did I miss something here?

-michael

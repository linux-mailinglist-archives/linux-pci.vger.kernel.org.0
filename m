Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7108326FB32
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 13:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgIRLOZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 07:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIRLOZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2020 07:14:25 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA005C06174A;
        Fri, 18 Sep 2020 04:14:24 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5087022EEB;
        Fri, 18 Sep 2020 13:14:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1600427660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+q2FbH/6HLJq2ZY1omvh24W3dfvOqburdvJY0MvQ/JE=;
        b=JZRKyXdPsyE0atHA8l+5b9oWb9t3hrGfZ2oqKUuV9l0BgHin3YtMVzV9Zl1+0T2CRTLnYs
        zpsaVuHUihejlte2Oj7GLfHq5FtQn1Y4vv89ycCTtuoH/Q9ONZce3P0JepKBBPSAGpi/5X
        L6g0CaMF0rtvpIM1srpjTP50my974js=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Sep 2020 13:14:20 +0200
From:   Michael Walle <michael@walle.cc>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
In-Reply-To: <HE1PR0402MB3371F8191538F47E8249F048843F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <20200916054130.8685-1-Zhiqiang.Hou@nxp.com>
 <CAL_JsqJwgNUpWFTq2YWowDUigndSOB4rUcVm0a_U=FEpEmk94Q@mail.gmail.com>
 <HE1PR0402MB3371F8191538F47E8249F048843F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <cb8b32463679c208b394879636451c77@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Zhiqiang,

> So the alternative solution seems to correct the PCIe enumeration, I 
> will submit
> a patch to let the first access only read the Vendor ID.

Please put me on CC of that patch.

Thanks,
-michael

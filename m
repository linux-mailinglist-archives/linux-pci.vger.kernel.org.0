Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8927E2310
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 14:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjKFNI1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 08:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjKFNI0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 08:08:26 -0500
Received: from smtp.missinglinkelectronics.com (smtp.missinglinkelectronics.com [162.55.135.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B032F1;
        Mon,  6 Nov 2023 05:08:23 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp.missinglinkelectronics.com (Postfix) with ESMTP id 578D32041E;
        Mon,  6 Nov 2023 14:08:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at missinglinkelectronics.com
Received: from smtp.missinglinkelectronics.com ([127.0.0.1])
        by localhost (mail.missinglinkelectronics.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pIimg11ZvbfH; Mon,  6 Nov 2023 14:08:22 +0100 (CET)
Received: from nucnuc.mle (ppp-88-217-64-136.dynamic.mnet-online.de [88.217.64.136])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: david)
        by smtp.missinglinkelectronics.com (Postfix) with ESMTPSA id 2D14E20267;
        Mon,  6 Nov 2023 14:08:21 +0100 (CET)
Date:   Mon, 6 Nov 2023 14:08:19 +0100
From:   David Epping <david.epping@missinglinkelectronics.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Dinh Nguyen <dinguyen@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Zhichang Yuan <yuanzhichang@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Joyce Ooi <joyce.ooi@intel.com>
Subject: Re: arm: mach-socfpga: PCIe Root IO TLP support for Cyclone V
Message-ID: <ZUjlQ1j+lvAqqPcs@nucnuc.mle>
References: <ZUDd04c7FXUeusxK@nucnuc.mle>
 <20231103184348.GA162150@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103184348.GA162150@bhelgaas>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 03, 2023 at 01:43:48PM -0500, Bjorn Helgaas wrote:
> I don't understand INDIRECT_PIO very well, but does it help with this
> at all?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/Kconfig?id=v6.6#n92
> https://git.kernel.org/linus/031e3601869c

Hi Bjorn,
thanks a lot for these links. They look very promising and I'll check how they can be combined with the socfpga / Altera Root Complex driver.
Best regards, David

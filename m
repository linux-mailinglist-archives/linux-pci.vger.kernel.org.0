Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 460C435124
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 22:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfFDUi6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 16:38:58 -0400
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:54294 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfFDUi6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 16:38:58 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jun 2019 16:38:57 EDT
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id B0D4C2823A8; Tue,  4 Jun 2019 22:31:46 +0200 (CEST)
Date:   Tue, 4 Jun 2019 22:31:46 +0200
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] lspci: Add PCIe 5.0 data rate (32 GT/s) support
Message-ID: <mj+md-20190604.203135.56338.nikam@ucw.cz>
References: <ed2a31df07262f5776c92c538da3079bb22aa9bf.1559665071.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed2a31df07262f5776c92c538da3079bb22aa9bf.1559665071.git.gustavo.pimentel@synopsys.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> This enables "lspci" to show PCIe 5.0 data rate (32 GT/s) properly
> according to the contents in register PCI_EXP_LNKCAP, PCI_EXP_LNKSTA
> and PCI_EXP_LNKCTL2.

Thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
"It's a lemon tree, my dear Watson." -- Sherlock Holmes (?)

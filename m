Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88873465735
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 21:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhLAUho (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 15:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352801AbhLAUhn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 15:37:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394CAC061574;
        Wed,  1 Dec 2021 12:34:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 89776CE2102;
        Wed,  1 Dec 2021 20:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B13FC53FCC;
        Wed,  1 Dec 2021 20:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638390857;
        bh=6NOinzYFzbZL4PNPczSZEVz8JiUmWYrhavAdCD/iGjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XRpTo1M7LfUCBgPqQjJSQ8v71IPx0pRjTGTrE/OqLbXiUHcr8DvsAZtfFBs6D/eu7
         lZz3Q2cU/iYr25Fh82ist3V4N2cvzpLcGU0iD4tknSijM8XdvoxeUqGYIdnrgi5hCC
         Z8hOyfhd0CggKrXmj7vRO8ySElsVqV9H6pJP0A29zgQGn2VFYKU413VC3WnQRAG3HS
         vOzYWF8r1ENT42Q7C/Z1/W8wHuq0XP8JJW9bcRwHe/zX8pFT3+ghYcjU/WsejESlQL
         Eaix5g5Y9yjP4ZUM9/NByh3BThNqcWhLnPvAT72gtw57aA87sQ90ucOreshWU4c/b/
         H/udlFWCJ/6tg==
Date:   Wed, 1 Dec 2021 14:34:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>
Subject: Re: ERROR: modpost: "mips_cm_unlock_other"
 [drivers/pci/controller/pcie-mt7621.ko] undefined!
Message-ID: <20211201203416.GA2839776@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H8TA0S23FjSRKGKeKAWWdUxET6YnivLQoFuy_fSVJOPXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 19, 2021 at 07:26:02AM +0100, Sergio Paracuellos wrote:

> [0]: https://lore.kernel.org/linux-mips/CAMhs-H8ShoaYiFOOzJaGC68nZz=V365RXN_Kjuj=fPFENGJiiw@mail.gmail.com/T/#t
> [1]: https://marc.info/?l=linux-pci&m=163696011110084&w=3

FWIW, prefer https://lore.kernel.org/... URLs when possible.  Better
archive and more likely to last.

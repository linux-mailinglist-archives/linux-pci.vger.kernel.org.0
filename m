Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7FA4D5186
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 20:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbiCJSXA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 13:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243906AbiCJSWt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 13:22:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C87014F28A;
        Thu, 10 Mar 2022 10:21:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E51AEB82793;
        Thu, 10 Mar 2022 18:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415CAC340E8;
        Thu, 10 Mar 2022 18:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646936505;
        bh=W4sOM9+B6L0c9LMgUrEbfgUrd76UKZTBgCwuqk0HzAE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=S/ra8oHP+rm+AWgS1iMavypZJ1MSEHgYve723Y7dEigN2WLgCCN+A2331kYtctj0n
         YkE+1KXYooU4r8d8lWLN5i8XR3sLJymAvzVQu7f+8HzKMwU3xQ/lT4IB00NRC9YGEw
         RzylTbxWCH1RDLP36ULbTaY65VJXT8ZErq0ksK6pEPUsk02M9rK0zgn1435HMbrzfE
         YPVnb0BREfPf0KsQzHb7tqiWomCWyaI2gJYyqoEUljMGHLayed5glbj+kMp1Sa/DUK
         QtmdEjPj9RgCtZ20P6/2SdaJBUkqBhkuxQrC4d/V5a+OyEGT+ANVadV9x2/3ewKtA4
         wrXWoY8VR3G/A==
Date:   Thu, 10 Mar 2022 12:21:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "alex@ghiti.fr" <alex@ghiti.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Toan Le <toan@os.amperecomputing.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v8 01/14] sizes.h: Add SZ_1T macro
Message-ID: <20220310182143.GA170924@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <969d885d-dcff-61b9-50cd-cdaf511505ab@csgroup.eu>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 10, 2022 at 06:09:51PM +0000, Christophe Leroy wrote:
> 
> 
> Le 10/03/2022 à 17:52, Bjorn Helgaas a écrit :
> > On Wed, Mar 09, 2022 at 06:44:35PM +0100, Christophe Leroy wrote:
> >> Today drivers/pci/controller/pci-xgene.c defines SZ_1T
> >>
> >> Move it into linux/sizes.h so that it can be re-used elsewhere.
> >>
> >> Link: https://lore.kernel.org/r/575cb7164cf124c75df7cb9242ea7374733942bf.1642752946.git.christophe.leroy@csgroup.eu
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> >> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: Toan Le <toan@os.amperecomputing.com>
> >> Cc: linux-pci@vger.kernel.org
> >> ---
> >>   This patch is already in linux-next but not in Linus' tree yet
> > 
> > What would you like me to do about this?  It's in linux-next, which
> > means it will go to Linus' tree during the next merge window.
> > 
> > But this is 01/14; are there other patches that I should be looking
> > at?  Do I need to coordinate this with other patches that depend on
> > it?
> 
> Yes sorry I should have said it. Patch 14/14 depends on it.
> 
> Don't know yet what's the merge strategy for this series, there as not 
> been any changes since v6 mid December and core parts are acked/reviewed 
> so I would be happy if at least core mm parts could go this cycle. I 
> sent a question to Michael and Andrew about it.

Since PCI is only minimally affected in this series, it would probably
make more sense for it to be merged along with the rest of the series
via a non-PCI tree.

It has my ack, so this can certainly happen.  If it does, I can easily
drop it from the PCI tree.

Bjorn

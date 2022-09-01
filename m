Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52C35A9032
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 09:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbiIAH0s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 03:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiIAHZs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 03:25:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528821144B;
        Thu,  1 Sep 2022 00:24:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91BA361D0B;
        Thu,  1 Sep 2022 07:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC12FC433D6;
        Thu,  1 Sep 2022 07:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662017093;
        bh=stL9+yzK0zgdLie5xf0hjyraAlajedBKEBb65rMMvRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Deo+YD+Qtg4Ei+JHnT2yXSe+uKnWw8TmyJIetCBkvgsk1Q7LlzsyoYoLTsOfoIi9H
         OwhDTSuHW6wmK1UEXZdoB3V1y6jPaa6Gnl+RYAHD8O9Y3LVX5IfL7CRFiOeksw36Wm
         EYmdTybxXyum1jTy27Dch3Ul5cE/l8TcGSQ6IV0XZkNiYbEcW7Nus1P8ePSG+R584J
         ytYy7VQ/lm2hstwOzR4PGDiapbPxiRVClotXRc2TZgKCgbQB6oL7YeI8VElF+RKMDD
         D5IhD/lqXpNx9SApSSGxj9pQdWDifYzzwY17Ei+NamHJpcHkmogcZb4K3wswvbiX13
         GO2I5M6b6Bowg==
Received: by pali.im (Postfix)
        id E3E127B8; Thu,  1 Sep 2022 09:24:49 +0200 (CEST)
Date:   Thu, 1 Sep 2022 09:24:49 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pci: Enable PCI domains in /proc when PCI bus
 numbers are not unique
Message-ID: <20220901072449.hswlq5fpnqrhgvcf@pali>
References: <20220820115113.30581-1-pali@kernel.org>
 <878rnclq47.fsf@mpe.ellerman.id.au>
 <20220825083713.4glfivegmodluiun@pali>
 <87wnanu4vf.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnanu4vf.fsf@mpe.ellerman.id.au>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 01 September 2022 13:53:56 Michael Ellerman wrote:
> Pali Rohár <pali@kernel.org> writes:
> > On Thursday 25 August 2022 17:49:28 Michael Ellerman wrote:
> >> Pali Rohár <pali@kernel.org> writes:
> >> > On 32-bit powerpc systems with more PCIe controllers and more PCI domains,
> >> > where on more PCI domains are same PCI numbers, when kernel is compiled
> >> > with CONFIG_PROC_FS=y and CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT=y
> >> > options, kernel prints "proc_dir_entry 'pci/01' already registered" error
> >> > message.
> >> 
> >> Thanks, I'll pick this up.
> >> 
> >> > This regression started appearing after commit 566356813082 ("powerpc/pci:
> >> > Add config option for using all 256 PCI buses") in case in each mPCIe slot
> >> > is connected PCIe card and therefore PCI bus 1 is populated in for every
> >> > PCIe controller / PCI domain.
> >> >
> >> > The reason is that PCI procfs code expects that when PCI bus numbers are
> >> > not unique across all PCI domains, function pci_proc_domain() returns true
> >> > for domain dependent buses.
> >> >
> >> > Fix this issue by setting PCI_ENABLE_PROC_DOMAINS and PCI_COMPAT_DOMAIN_0
> >> > flags for 32-bit powerpc code when CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
> >> > is enabled. Same approach is already implemented for 64-bit powerpc code
> >> > (where PCI bus numbers are always domain dependent).
> >> 
> >> We also have the same in ppc4xx_pci_find_bridges().
> >> 
> >> And if we can eventually make CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
> >> the standard behaviour on 32-bit then everything would behave the same
> >> and we could simplify pci_proc_domain() to match what other arches do.
> >
> > I sent two patches which do another steps to achieve it:
> > https://lore.kernel.org/linuxppc-dev/20220817163927.24453-1-pali@kernel.org/t/#u
> >
> > Main blocker is pci-OF-bus-map which is in direct conflict with
> > CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT and which used on chrp and pmac.
> > And I have no idea if pci-OF-bus-map is still needed or not.
> 
> Yeah thanks, I saw those patches.
> 
> I can't find any code that refers to pci-OF-bus-map, so I'm inclined to
> remove it entirely.
> 
> But I'll do some more searching to see if I can find any references to
> it in old code.
> 
> cheers

From the code itself I have feeling that some external programs or maybe
some firmware can access or use this property. But I have really no idea.

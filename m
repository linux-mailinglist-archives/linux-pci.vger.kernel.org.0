Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676AB6075F3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Oct 2022 13:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJULTm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Oct 2022 07:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJULTm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2022 07:19:42 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFD332050;
        Fri, 21 Oct 2022 04:19:37 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id CF23930027A15;
        Fri, 21 Oct 2022 13:19:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B9D0519F8A; Fri, 21 Oct 2022 13:19:35 +0200 (CEST)
Date:   Fri, 21 Oct 2022 13:19:35 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     bhelgaas@google.com, Rajat Jain <rajatja@google.com>,
        Vidya Sagar <vidyas@nvidia.com>, upstream@semihalf.com,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Intel Apollolake: PCIe bridge "loses" capabilities after
 entering D3Cold state
Message-ID: <20221021111935.GB28729@wunner.de>
References: <CAFJ_xbq0cxcH-cgpXLU4Mjk30+muWyWm1aUZGK7iG53yaLBaQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFJ_xbq0cxcH-cgpXLU4Mjk30+muWyWm1aUZGK7iG53yaLBaQg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 21, 2022 at 12:17:35PM +0200, Lukasz Majczak wrote:
> While working with Vidya???s patch I have noticed that after
> suspend/resume cycle on my Chromebook (Apollolake) PCIe bridge loses
> its capabilities - the missing part is:
> 
> Capabilities: [200 v1] L1 PM Substates
> L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>   PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
> L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>    T_CommonMode=40us LTR1.2_Threshold=98304ns
> L1SubCtl2: T_PwrOn=60us
> 
> Digging more I???ve found out that entering D3Cold state causes this

You mean the capability is gone from lspci after D3cold?

My understanding is that BIOS is responsible for populating config space.
So this sounds like a BIOS bug.  What's the BIOS vendor and version?
(dmesg | grep DMI)

Thanks,

Lukas

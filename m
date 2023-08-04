Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2BE77093B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 21:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjHDT6e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 15:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjHDT6b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 15:58:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A92E6E;
        Fri,  4 Aug 2023 12:58:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D262A62120;
        Fri,  4 Aug 2023 19:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C721C433C7;
        Fri,  4 Aug 2023 19:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691179109;
        bh=srCNtIWmh1OVN6LndgDpMt38s8ZmUbmZ0TwLiA4/tN4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Uc7FIfUDS5aFyyYwOPSc5oa68vxp7d4DZiJxjDUIaRuLG/OOVmwOR+A58U71YZLcY
         qz9Pr7lRnf0JHiPv46v1hKUN1dgcgSLrgpyR3ivxW1NTq5F6YDjcyzIzG6ViklHib1
         t0d+6OGQRAc1MtwHFXQ2VR9gflI05rE91JYVeGjsJ1zg/8NAopVf8kafNuHF2KC8Id
         3Fow+x4iMMHbHy1qeOyLK1OlceQ5SfEp3AlG5JTroq1oiaBwYErpO2fLwkUTfK6Drv
         fPl2IcVW/+fNusKAKobjIol7C18F6MYO3BcAEJacsiBawdL1VHMAwweqGncLbvTvvL
         /UVaknXDuNuhQ==
Date:   Fri, 4 Aug 2023 14:58:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] PCI: xilinx-nwl: Remove unnecessary code and updating
 ecam default value.
Message-ID: <20230804195827.GA159466@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB72014E79448FE6C7A47718E28B09A@SN7PR12MB7201.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 04, 2023 at 07:05:30PM +0000, Havalige, Thippeswamy wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > On Thu, Aug 03, 2023 at 05:20:16PM +0530, Thippeswamy Havalige wrote:
> > > Remove reduntant code.
> > > Change NWL_ECAM_VALUE_DEFAULT to 16 to support maximum 256
> > > buses.
> > 
> > Remove period from subject line.
> > 
> > Please mention the most important part first in the subject -- the
> > ECAM change sounds more important than removing redundant code.
> > 
> > s/ecam/ECAM/
> > s/reduntant/redundant/
> > 
> > Please elaborate on why this code is redundant.  What makes it
> > redundant?  Apparently the bus number registers default to the correct
> > values or some other software programs them?
> 
>  - Yes, The  Primary,Secondary and sub-ordinate bus number registers
>  are programmed/updated as part of linux enumeration so updating
>  these registers are redundant.

Ah, so the Linux PCI core can handle updating these from whatever the
power-up values are.  Good material for the revised commit log.

> > "ECAM_VALUE" is not a very informative name.  I don't know what an
> > "ECAM value" would be.  How is the value 16 related to a maximum of
> > 256 buses?  We only need 8 bits to address 256 buses, so it must be
> > something else.  The bus number appears at bits 20-27
> > (PCIE_ECAM_BUS_SHIFT) in a standard ECAM address, so probably not the
> > bit location?
>
> Yes, Agreed I'll modify ECAM_VALUE as ECAM_SIZE here and it is not
> related to a maximum 256 buses.

Well, it sounds like this value *does* determine the size of the ECAM
region, which does constrain the number of buses you can address via
ECAM.

> > Does this fix a problem?
> 
> - Yes, It is fixing a problem. Our controller is expecting ECAM size
> to be programmed by software.  By programming
> "NWL_ECAM_VALUE_DEFAULT  12" controller can access upto 16MB ECAM
> region which is used to detect 16 buses so by updating
> "NWL_ECAM_VALUE_DEFAULT " to 16 controller can access upto 256 Mb
> ECAM region to detect 256 buses.
> 
> 2^(ecam_size_offset+ecam_size) 
> 
> Here (ecam_size_offset=12 and ecam_size=16) --> 256Mb

More good material for the commit log.  (1) Change in ECAM region
size, (2) previously could only address 16 buses, now can address 256
buses.

Is there any impact on DT from the address map change?

Bjorn

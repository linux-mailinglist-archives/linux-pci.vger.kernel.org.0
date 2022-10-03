Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A55E5F357E
	for <lists+linux-pci@lfdr.de>; Mon,  3 Oct 2022 20:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJCSV4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Oct 2022 14:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJCSVy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Oct 2022 14:21:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE894DF83;
        Mon,  3 Oct 2022 11:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F280B81205;
        Mon,  3 Oct 2022 18:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F10C433C1;
        Mon,  3 Oct 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664821311;
        bh=fAj+g9SbF66P5R+DbPuZP8fh8Mob0CfnwzQ0Qn/TP7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IkB7q/DCsAAZ23yI0jUQlTAvUoLoYjwOnizq91SMfhEXL4eacXEHN5L4bza/ANR2Y
         wDGNF1/eLmYkCRdBTjNOSU1/Q/lkXNupti+tF+XwHjBxxypJlN7QcfSp78nB7dc9Dt
         bKgQGL3uD26oBPJk0j4/nuWZ40E4wLDWs5k4eKgSnQ3S6cgN2J0NKxXVz8m8K+b+xz
         /maJDdZeaaxf5F6OvcRu/z1M5alT+t0TiTp5qzQVH+HtckOeMpB5SeLMlX0e5b2RWf
         erGgRFc//rgUHW1elFJRt8MwyZ7BZFNIiG2CyxubvW2/wZt+BbhH3Mujlls2Q1/S91
         AID9dBN3qS7/A==
Received: by pali.im (Postfix)
        id 03D56742; Mon,  3 Oct 2022 20:21:47 +0200 (CEST)
Date:   Mon, 3 Oct 2022 20:21:47 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>,
        Vidya Sagar <vidyas@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, jszhang@kernel.org,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH V1 0/4] GPIO based PCIe Hot-Plug support
Message-ID: <20221003182147.jp5gn2jpnf4gucdl@pali>
References: <2a465222-342a-418b-95af-9948f6ce9065@linux.dev>
 <20221003180949.GA2104321@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221003180949.GA2104321@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 03 October 2022 13:09:49 Bjorn Helgaas wrote:
> On Sat, Oct 01, 2022 at 05:50:07PM -0600, Jonathan Derrick wrote:
> > On 10/1/2022 10:20 AM, Pali Rohár wrote:
> > ...
> 
> > > Would not it better to rather synthesise PCIe Slot Capabilities support
> > > in your PCIe Root Port device (e.g. via pci-bridge-emul.c) and then let
> > > existing PCI hotplug code to take care for hotplugging? Because it
> > > already implements all required stuff for re-scanning, registering and
> > > unregistering PCIe devices for Root Ports with Slot Capabilities. And I
> > > think that there is no need to have just another (GPIO based)
> > > implementation of PCI hotplug.
> >
> > I did that a few years ago (rejected), but can attest to the robustness of
> > the pcie hotplug code on non-hotplug slots.
> > https://lwn.net/Articles/811988/
> 
> I think the thread is here:
> https://lore.kernel.org/linux-pci/1581120007-5280-1-git-send-email-jonathan.derrick@intel.com/
> and I'm sorry that my response came across as "rejected".  I intended
> it as "this is good ideas and good work and we should keep going".
> 
> Bjorn

Nice! So we have consensus that this is a good idea. Anyway, if you need
help with designing something here, please let me know as I have good
understanding of all (just two) consumers of pci-bridge-emul.c driver.

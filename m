Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B1D64118D
	for <lists+linux-pci@lfdr.de>; Sat,  3 Dec 2022 00:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiLBXfw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Dec 2022 18:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbiLBXfw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2022 18:35:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92111F930C
        for <linux-pci@vger.kernel.org>; Fri,  2 Dec 2022 15:35:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D3D2B82213
        for <linux-pci@vger.kernel.org>; Fri,  2 Dec 2022 23:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9961DC433C1;
        Fri,  2 Dec 2022 23:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670024148;
        bh=OOGYBIHIJJzCB/80v1XUdwxZizlv5oj+K/Vn7SIiQeQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bF8YtucA/bMTNqvX0JfmCh4IjnQ72TgRLpFeEAGblcLon4kVr7IWeVM55qiXHkxfE
         62bkyPyfeB1QE745enAic9gzcWeZ6+svEyGwFcQCWBTui6DIzrYeBLq0pALm36RBdK
         NuVYeIWJZifW1dBL3mN0isi6OlpLwlt+xgRB/pEM39t5WgOdTNnUJj+QMBWGQTtcY+
         h90JUX+ZXZQbEQUYIuw0Q7txmbEEiY+FEwGaGENxB9bakojamC5RcQPYoXHmTmJv3V
         iXP50KLHPiXQ6q5jCxn9vOx7cjDobAfOXRUs/E2BzYgkir93Ct88F7OCpXCrWY3ZuC
         a1GpooXCe358g==
Date:   Fri, 2 Dec 2022 17:35:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Take other bus devices into account when
 distributing resources
Message-ID: <20221202233547.GA1073190@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202174513.000000e1@Huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 02, 2022 at 05:45:13PM +0000, Jonathan Cameron wrote:
> On Wed, 30 Nov 2022 13:22:20 +0200
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> >  	if (hotplug_bridges + normal_bridges == 1) {
> > -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > -		if (dev->subordinate)
> > -			pci_bus_distribute_available_resources(dev->subordinate,
> > -				add_list, io, mmio, mmio_pref);
> > +		bridge = NULL;
> > +
> > +		/* Find the single bridge on this bus first */
> 
> > +		for_each_pci_bridge(dev, bus) {
> 
> We could cache this a few lines up where we calculate the
> number of bridges. Perhaps not worth bothering though other
> than it letting you get rid of the WARN_ON_ONCE. 

Sorry for repeating this; I saw your response, but it didn't sink in
before I responded.

Bjorn

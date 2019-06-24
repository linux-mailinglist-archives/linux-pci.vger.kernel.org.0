Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 269F5504F7
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 10:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfFXI4s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 04:56:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:42501 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfFXI4s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 04:56:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5O8uh82023389;
        Mon, 24 Jun 2019 03:56:44 -0500
Message-ID: <5a259297eeca3484565faf3166b2e4019047b478.camel@kernel.crashing.org>
Subject: Re: Question about call to pci_assign_unassigned_bus_resources in
 amdgpu
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date:   Mon, 24 Jun 2019 18:56:42 +1000
In-Reply-To: <ea9f770c373ad9c6a998edbd603972014e4b7fea.camel@kernel.crashing.org>
References: <ed3d3e4e87b54fa4d0d8e68abeebb7be6711b82a.camel@kernel.crashing.org>
         <71904c98-be86-2807-d5c9-4b90c7387f6f@amd.com>
         <ea9f770c373ad9c6a998edbd603972014e4b7fea.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2019-06-24 at 18:47 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2019-06-24 at 08:42 +0000, Koenig, Christian wrote:
> > Then we resize the VRAM BAR by calling pci_resize_resource(). That in 
> > turn tries to resize and shuffle around the parent bridge resources 
> > using pci_reassign_bridge_resources().
> > 
> > But pci_reassign_bridge_resources() does not assign any device 
> > resources, it just tries to make sure the upstream bridges have enough 
> > space to fit everything in.

Hrm... are you sure of this ? Maybe it has changed... or I'm missing
something. Because right in the middle of it I see:


 	__pci_bus_size_bridges(bridge->subordinate, &added);
	__pci_bridge_assign_resources(bridge, &added, &failed);

Now the second of these will call __pci_bus_assign_resources() on the
bridge->subordinate, which will recursively assign all devices below
the bridge.

Or am I overlooking something ?

It could be that if it fails, then you need to restore your device
resources indeed... but the normal case should work from my reading of
the code.

Cheers,
Ben.


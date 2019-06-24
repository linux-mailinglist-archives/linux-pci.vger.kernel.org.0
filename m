Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C851508E1
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 12:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfFXK16 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 06:27:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:43624 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbfFXK16 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 06:27:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5OARqGN028142;
        Mon, 24 Jun 2019 05:27:53 -0500
Message-ID: <10cafe60fa12d3801d8645046be02771e8af7619.camel@kernel.crashing.org>
Subject: Re: Question about call to pci_assign_unassigned_bus_resources in
 amdgpu
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date:   Mon, 24 Jun 2019 20:27:49 +1000
In-Reply-To: <0680ee65-5960-18b8-d7a2-eb87ec2056ef@amd.com>
References: <ed3d3e4e87b54fa4d0d8e68abeebb7be6711b82a.camel@kernel.crashing.org>
         <71904c98-be86-2807-d5c9-4b90c7387f6f@amd.com>
         <ea9f770c373ad9c6a998edbd603972014e4b7fea.camel@kernel.crashing.org>
         <f4cb8429-a32d-d3af-dee0-0bae1935cb47@amd.com>
         <b873931988c7e6ccf61010e8ad03cf2d7f3e4b09.camel@kernel.crashing.org>
         <0680ee65-5960-18b8-d7a2-eb87ec2056ef@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2019-06-24 at 09:42 +0000, Koenig, Christian wrote:
> 
> > Ok, Ill plumb it that way in my branch, I'll let you know when it's
> > worth testing. BTW. Which GPUs typically are affected ? I'm pretty
> > sure
> > my old R9 290 isn't :-) But I was thinking of upgrading so...
> 
> Well in theory we have the functionality 10+ years now, but only 
> activated it in all hardware versions recently.
> 
> Polaris and Vega should definitely have it, older hardware most
> likely not.
> 
> You can check the PCI capabilities and look for #15, if it's present 
> then that should be supported.

Ok, well, we'll see if I decide to get myself a Navi when it comes out,
otherwise I'll rely on your testing :)

That said, I'm keen on having a discussion about our resource
assignment code at Plumbers with whoever can make it. The current
situation is rather horrible, it would be good to ensure at least that
we all understand and agree on what it's trying to do, what it's
actually doing, and what we want to do, which the more I stare at it
I'm reasonably sure are very different things depending on the
context...

Cheers,
Ben.



Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1684322C8BE
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 17:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgGXPGn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 11:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgGXPGn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 11:06:43 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B81120714;
        Fri, 24 Jul 2020 15:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595603202;
        bh=d/lHftCugyAGXbmWZxAljFlvx4t6XIizbWGk9XJGek8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YsjxJOVkT3utZoAopAiM9AzCy9/gsq8e90vIYnS8HCmi3TKoHyfjf4ovxvridIluu
         oK0BfZXwVAPelnhcd/bQh4flU8Kxyvq1XaJ5KmGJEvPaAPjLA+qA8kgJPKYnLQdIfr
         rDiTawY8yno4O21e5vcgirMSF5vKuAezym4//HAk=
Date:   Fri, 24 Jul 2020 10:06:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Andrew Maier <andrew.maier@eideticom.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] PCI/P2PDMA: Add AMD Zen 2 root complex to the list of
 allowed bridges
Message-ID: <20200724150641.GA1518875@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89d853d1-9e45-1ba5-5be7-4bbce79c7fb8@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 23, 2020 at 02:10:52PM -0600, Logan Gunthorpe wrote:
> On 2020-07-23 1:57 p.m., Bjorn Helgaas wrote:
> > On Thu, Jul 23, 2020 at 02:01:17PM -0400, Alex Deucher wrote:
> >> On Thu, Jul 23, 2020 at 1:43 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> >>>
> >>> The AMD Zen 2 root complex (Starship/Matisse) was tested for P2PDMA
> >>> transactions between root ports and found to work. Therefore add it
> >>> to the list.
> >>>
> >>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >>> Cc: Christian König <christian.koenig@amd.com>
> >>> Cc: Huang Rui <ray.huang@amd.com>
> >>> Cc: Alex Deucher <alexdeucher@gmail.com>
> >>
> >> Starting with Zen, all AMD platforms support P2P for reads and writes.
> > 
> > What's the plan for getting out of the cycle of "update this list for
> > every new chip"?  Any new _DSMs planned, for instance?
> 
> Well there was an effort to add capabilities in the PCI spec to describe
> this but, as far as I know, they never got anywhere, and hardware still
> doesn't self describe with this.

Any idea what happened?  Is there hope for the future?  I'm really not
happy about signing up for open-ended device-specific patches like
this.  It's certainly not in the plug and play spirit that has made
PCI successful.  I know, preaching to the choir here.

Bjorn

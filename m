Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A01FBC96F8
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2019 05:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfJCDdz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Oct 2019 23:33:55 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:49331 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfJCDdz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Oct 2019 23:33:55 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id A3F072802D270;
        Thu,  3 Oct 2019 05:33:52 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5C045351CB; Thu,  3 Oct 2019 05:33:52 +0200 (CEST)
Date:   Thu, 3 Oct 2019 05:33:52 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     "Alex G." <mr.nuke.me@gmail.com>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: pciehp: Do not turn off slot if presence comes
 up after link
Message-ID: <20191003033352.d5ywkrskpkhafvc4@wunner.de>
References: <20191001211419.11245-1-stuart.w.hayes@gmail.com>
 <20191002041315.6dpqpis5zikosyyc@wunner.de>
 <c494a7c4-8323-e75f-6a3f-5f342ce7b1c7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c494a7c4-8323-e75f-6a3f-5f342ce7b1c7@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 02, 2019 at 05:13:58PM -0500, Alex G. wrote:
> On 10/1/19 11:13 PM, Lukas Wunner wrote:
> > On Tue, Oct 01, 2019 at 05:14:16PM -0400, Stuart Hayes wrote:
> > > This patch set is based on a patch set [1] submitted many months ago by
> > > Alexandru Gagniuc, who is no longer working on it.
> > 
> > I'm not sure if it's appropriate to change the author and
> > omit Alex' Signed-off-by.
> 
> Legally Dell owns the patches. I have no objection on my end.

From a kernel community POV, I don't think it matters (in this case)
who legally owns the copyright to the contributed code.  It's just that
we go to great lengths to provide proper attribution even for small
contributions (e.g. Tested-by).

The benefit to the community is that we know who to cc if that portion
of the code is changed again and someone knowledgable should take a look.

The benefit to contributors is that they can change jobs and their past
contributions are still visible in the git history and attributed to
their names.  By contrast, if you've worked on closed source code and
changed jobs, that work isn't visible to future employers or even yourself,
and it may happen that someone else takes credit for your past work
without you even knowing about it or being able to stop that.
(I've seen it before.)

In this case, there should be a S-o-b line for Alex preceding that
for Stuart, and the author of the commit should be Alex unless a
significant portion of the patch was changed.

Thanks,

Lukas

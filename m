Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B119D42524B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 13:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbhJGLx6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 07:53:58 -0400
Received: from foss.arm.com ([217.140.110.172]:48536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhJGLx5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 07:53:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C6E16D;
        Thu,  7 Oct 2021 04:52:04 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 264673F66F;
        Thu,  7 Oct 2021 04:52:03 -0700 (PDT)
Date:   Thu, 7 Oct 2021 12:51:57 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 09/13] PCI: aardvark: Implement re-issuing config
 requests on CRS response
Message-ID: <20211007115157.GA19256@lpieralisi>
References: <20211006162934.GA12073@lpieralisi>
 <20211006201305.GA1172706@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006201305.GA1172706@bhelgaas>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 06, 2021 at 03:13:05PM -0500, Bjorn Helgaas wrote:

[...]

> > We need a way for those PCI controllers to communicate to SW that
> > they actually received a CRS completion (and that they don't retry
> > in HW).
> 
> AFAICT this would be controller-dependent.  I think some controllers
> have registers that control the number of retries, but of course
> that's completely controller-dependent, too.
> 
> > By implementing the logic in the aardvark controller that platform
> > information is there so to the best of my knowledge this patch
> > is sound.
> > 
> > I assume that the HW retry is in the specs because there is no
> > architected way if CRS Software Visibility is not enabled/present to
> > report CRS completion in an architected PCI manner but I just
> > don't know the entire background behind this.
> 
> I assume an error bit would be set in the Status or Secondary Status
> register when a PCIe transaction fails.  I'm not sure anybody *looks*
> at those, though.
> 
> This still looks like a PCI controller band-aid for a device or driver
> problem that will likely still exist on other platforms.

Yes that's true. I believe we can merge this patch (?) but it would
also be good if Pali/Marek have time to test on other HW and
maybe generalize the concept.

Lorenzo

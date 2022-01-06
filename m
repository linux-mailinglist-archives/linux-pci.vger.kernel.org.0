Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC70486951
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 19:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242481AbiAFSAd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 13:00:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52790 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242478AbiAFSAa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 13:00:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CA7761CF7;
        Thu,  6 Jan 2022 18:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992D8C36AEB;
        Thu,  6 Jan 2022 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641492028;
        bh=DYydbgnS2Q5LXHtJFrES1pqwbao4Pez939AcN9KBnvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EOsILy3tM+xI/hjivi2NyurzDUrBiXloFSZzBXiTaFxplMSJHHuDMSw/uveKJpPko
         xjglSC2viJAaYds5RhVnMvlQi7OtPw91HxCXBINDMvmOyXmKm9OuBe0RMU4El8CPcs
         aZJS+/6iNnuhH2bqTohmg8FJXELmIs30dp76K1eOAVtk4kdA60kk0nAWbP1sD6ayvM
         4XwHnnprTyOy+QtE3YtAMpyGLvuIud1axMj4fnNUzmjMQ6E7U+nxwL4vSKykxHf+E6
         qknivFyA+YuMfvPPyLbpbW4q/MSHCr4JSWIKIVHjKnSkuzkLlfvOKSlLrvJBMA2QNA
         AEUBfAQuLA//Q==
Date:   Thu, 6 Jan 2022 12:00:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Ray Jui <ray.jui@broadcom.com>,
        Roman Bacik <roman.bacik@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: iproc: Set all 24 bits of PCI class code
Message-ID: <20220106180026.GA295674@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220105181306.mkratasqg36tjf4e@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 05, 2022 at 07:13:06PM +0100, Pali Rohár wrote:
> On Wednesday 05 January 2022 09:51:48 Ray Jui wrote:
> > On 1/5/2022 1:35 AM, Pali Rohár wrote:

> > 2. I suppose 'PCI_CLASS_BRIDGE_PCI_NORMAL' is defined in some common PCI
> > header in a separate patch as described in the commit message. Then how
> > come these patches are not constructed with a patch series?
> 
> Yes, PCI_CLASS_BRIDGE_PCI_NORMAL is a new constant for common pci header
> file defined in patch linked in commit message.
> https://lore.kernel.org/linux-pci/20211220145140.31898-1-pali@kernel.org/
> 
> Originally I included this change in v1 of linked patch in December but
> I realized that it does not match standard PCI config space (different
> offset 0x43c vs 0x08 and also different shift 0x8 vs 0x0) and probably
> there is something either incorrect or really non-standard. So later in
> December I dropped iproc_pcie_check_link() change in v2 of the linked
> patch where is introduced PCI_CLASS_BRIDGE_PCI_NORMAL and now sent new
> change for iproc_pcie_check_link() separately.
> 
> Technically, linked patch in commit message is just extracting code into
> the common macros without any functional changed. But change in this
> iproc_pcie_check_link() has also functional change as now also lower 8
> bits of class code are changed. So in my opinion this patch should be
> really separate of linked patch.
> 
> I hope that Lorenzo and Bjorn take patches in correct order...

If patches are not sent together in a series, you can't assume
anything about the order they'll be applied in.  Adding a note about
"this patch depends patch X" helps a little but adds a fair amount of
friction to the process.

Bjorn

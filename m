Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CDC42988A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 22:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhJKVAy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 17:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhJKVAx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Oct 2021 17:00:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2308460F3A;
        Mon, 11 Oct 2021 20:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633985933;
        bh=3S7KAhBXStoG0txA9L04ww+UIn9ld22/dubCt2F+9QM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ANYuowkTyP51tmq1H6bdvejfwe0Nluahh+I61IZvjCffX8XbaKkwC9Uml2y35LYZC
         V/9qN6jfPP0e3Dl4rPy19VE2fHPsHZWLc3NC6yHhGVYJr2BfPYqNd1KY6oehvVpAQU
         sPRPaPKS65gwtMdofAneD5FT9X4pz04osaIvTgwjhewaj8sSiFSuhvR3QZ6X5DLaRO
         PYjNqi0+OulwbII/Jnx5dXu3s02fQVnCUjtswrXHTan/n33y4b3VSI2CdDOviv4/aw
         Lx59soZrwSXJNrWwthnY4/a+9Z848F8EcTS9AU5pnDAD8z0GXq4vRnEYkTOCP7FCEx
         tS3P0kDp7L+HA==
Date:   Mon, 11 Oct 2021 15:58:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: Usage of PCBIOS_* macros (Was: Re: [PATCH 09/13] PCI: aardvark:
 Implement re-issuing config requests on CRS response)
Message-ID: <20211011205851.GA1690395@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211011181553.gnonl5lsa5bb7os3@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 11, 2021 at 08:15:53PM +0200, Pali Rohár wrote:
> On Wednesday 06 October 2021 00:45:31 Marek Behún wrote:
> > PS: Btw, looking at the code, why do we use these PCIBIOS_* macros? And 
> > then sometimes convert them to error codes with pcibios_err_to_errno()? 
> > Is this some legacy thing? Should this be converted to errno?
> 
> Hello! I would like to remind this Marek's PS. Do you know why config
> read and write functions return these PCIBIOS_* macros and not standard
> linux errno codes?

I don't know.  The PCIBIOS_SUCCESSFUL..PCIBIOS_BUFFER_TOO_SMALL codes
are actually still in the latest PCI Firmware Spec, r3.3, of
1/20/2021, sec 2.9, but are clearly x86-specific.

I think it would be nicer if their usage were confined to arch/x86,
but they've leaked out somewhat.

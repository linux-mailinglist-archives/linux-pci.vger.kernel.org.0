Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A767242BFC3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 14:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhJMMWZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 08:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhJMMWY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Oct 2021 08:22:24 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E99EC061570
        for <linux-pci@vger.kernel.org>; Wed, 13 Oct 2021 05:20:21 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 665DF3002AD66;
        Wed, 13 Oct 2021 14:20:19 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 52E72184F9A; Wed, 13 Oct 2021 14:20:19 +0200 (CEST)
Date:   Wed, 13 Oct 2021 14:20:19 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Naveen Naidu <naveennaidu479@gmail.com>, bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH 16/22] PCI: pciehp: Use RESPONSE_IS_PCI_ERROR() to check
 read from hardware
Message-ID: <20211013122019.GA17324@wunner.de>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
 <36c7c3005c4d86a6884b270807d84433a86c0953.1633972263.git.naveennaidu479@gmail.com>
 <20211011194740.GA14357@wunner.de>
 <20211012160505.3dov6gjnmxdq5lz6@theprophet>
 <20211012231201.xj7fvfgvpde5wwrl@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211012231201.xj7fvfgvpde5wwrl@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 13, 2021 at 01:12:01AM +0200, Pali Rohár wrote:
> > On 11/10, Lukas Wunner wrote:
> > > On Mon, Oct 11, 2021 at 11:37:33PM +0530, Naveen Naidu wrote:
> > > > An MMIO read from a PCI device that doesn't exist or doesn't respond
> > > > causes a PCI error.  There's no real data to return to satisfy the
> > > > CPU read, so most hardware fabricates ~0 data.
> > > > 
> > > > Use RESPONSE_IS_PCI_ERROR() to check the response we get when we read
> > > > data from hardware.
> > > 
> > > Actually what happens is that PCI read transactions *time out*,
> > > so the host controller fabricates a response.
> 
> This is not fully correct. 0xffffffff is returned when some error
> happens. It does not have to be timeout error. Errors like Unsupported
> Request, Completer Abort or Configuration Request Retry Status (when
> CRSSVE bit is disabled) are also reported as 0xffffffff and they do not
> represent timeout. For example Unsupported Request is returned when you
> try to read from non-existent device behind some PCIe switch.

This particular patch concerns pciehp and in that context,
"all ones" responses are predominantly timeouts caused by
hot-removed devices.

Thanks,

Lukas

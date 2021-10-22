Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E1443727A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 09:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhJVHEH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 03:04:07 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:51733 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhJVHEG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Oct 2021 03:04:06 -0400
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Oct 2021 03:04:06 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id A42C028005312;
        Fri, 22 Oct 2021 09:01:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 979BF16E5C7; Fri, 22 Oct 2021 09:01:48 +0200 (CEST)
Date:   Fri, 22 Oct 2021 09:01:48 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH v3 18/25] PCI: pciehp: Use RESPONSE_IS_PCI_ERROR() to
 check read from hardware
Message-ID: <20211022070148.GB17656@wunner.de>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
 <c21290fe02a7a342a8b93c692586b6a2b6cde9e0.1634825082.git.naveennaidu479@gmail.com>
 <20211021152253.pqc6xp3vnv5fpczj@theprophet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021152253.pqc6xp3vnv5fpczj@theprophet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 21, 2021 at 08:52:53PM +0530, Naveen Naidu wrote:
> Lukas, I have not added your Acked-by tag from the v1 [1] of the patch 
> series, since the RESPONSE_IS_PCI_ERROR macro definition slightly 
> changed. I hope this was the right thing to do.
[...]
> If that is not the case please let me know. But I am not sure what to
> do here? If RESPONSE_IS_PCI_ERROR does not fit here, should the right
> option would be to revert/remove this patch from the series?

My Acked-by still stands.  As for the macro name, I'm fine with
whatever Bjorn and the community settle on. :)

Thanks,

Lukas

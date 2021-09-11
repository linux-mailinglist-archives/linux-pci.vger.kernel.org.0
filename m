Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3077240789C
	for <lists+linux-pci@lfdr.de>; Sat, 11 Sep 2021 16:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbhIKOEn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Sep 2021 10:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235899AbhIKOEn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Sep 2021 10:04:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8528A61026;
        Sat, 11 Sep 2021 14:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631369010;
        bh=y0rQcelXIZrYr4RAjfPK8ZGgHS2/Rf/GdQC94eaJxwQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sj7yq44HpjoMzHx+JkkMQX+LLfKA0/JkK7ZMcD2aKmUygniadb2ghCDOW4HoVOS0U
         ktnbius6VD/sP2kHZwjRKtaGU7S5uvNlrrsuARnw/ROkoZP9cPDiHEgrERaaIvVeiM
         ZQ2st6UfO+5ormyQuA+w6hdfNsPAk9gMICnfbljrZrgqHmkeJRp4Glf3hsJzkIVR0J
         lXCUGUCLheGCyh6oAMLwi8q+BTcwZEw4jTfm/Uadh0BbCvmYeiV7pxKi5PmWulFtAW
         Z9JSKuKYVehhNyniGLuI2P8xlsQHo1MhG8tdJEuOx7FcNYWd5wXDvNGgG6w1ooxMMZ
         ulj8vLHIbNHBw==
Date:   Sat, 11 Sep 2021 09:03:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stanislav Spassov <stanspas@amazon.com>
Cc:     linux-pci@vger.kernel.org, Stanislav Spassov <stanspas@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan H =?iso-8859-1?Q?=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@kernel.org>, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4 3/3] PCI: Add CRS handling to pci_dev_wait()
Message-ID: <20210911140329.GA1202813@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200307172044.29645-4-stanspas@amazon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I apologize for completely dropping the ball on this one.  I don't
remember why, but I *do* remember one issue that we should clear up:

On Sat, Mar 07, 2020 at 06:20:44PM +0100, Stanislav Spassov wrote:
> From: Stanislav Spassov <stanspas@amazon.de>
> 
> The PCI Express specification dictates minimal amounts of time that the
> host needs to wait after triggering different kinds of resets before it
> is allowed to attempt accessing the device. After this waiting period,
> devices are required to be responsive to Configuration Space reads.
> However, if a device needs more time to actually complete the reset
> operation internally, it may respond to the read with a Completion
> Request Retry Status (CRS), and keep doing so on subsequent reads
> for as long as necessary. If the device is broken, it may even keep
> responding with CRS indefinitely.
> 
> The specification also mandates that any Root Port that supports CRS
> and has CRS Software Visibility (CRS SV) enabled will synthesize the
> special value 0x0001 for the Vendor ID and set any other bits to 1
> upon receiving a CRS Completion for a Configuration Read Request that
> includes both bytes of the Vendor ID (offset 0).
> 
> If CRS SV is disabled or a different register (not Vendor ID) is being
> read, the request is retried autonomously by the Root Port.
> Platform-specific configuration registers may exist to limit the number
> of or time taken by such retries.

I think the Root Complex may eventually complete the transaction as
failed *regardless* of whether CRS SV is enabled.  This is unclear in
PCIe r5.0, sec 2.3.2, because the text formatting was broken between
r4.0 and r5.0.  The r4.0 text is formatted like this:

  Root Complex handling of a Completion with Configuration Request
  Retry Status for a Configuration Request is implementation specific,
  except for the period following system reset (see Section 6.6). For
  Root Complexes that support CRS Software Visibility, the following
  rules apply:

    * If CRS Software Visibility is not enabled, the Root Complex must
      re-issue the Configuration Request as a new Request.

    * If CRS Software Visibility is enabled (see below):

      - For a Configuration Read Request that includes both bytes of
        the Vendor ID field of a device Function’s Configuration Space
        Header, the Root Complex must complete the Request to the host
        by returning a read-data value of 0001h for the Vendor ID
        field and all ‘1’s for any additional bytes included in the
        request. This read-data value has been reserved specifically
        for this use by the PCI-SIG and does not correspond to any
        assigned Vendor ID.

      - For a Configuration Write Request or for any other
        Configuration Read Request, the Root Complex must re-issue the
        Configuration Request as a new Request.

  A Root Complex implementation may choose to limit the number of
  Configuration Request/CRS Completion Status loops before determining
  that something is wrong with the target of the Request and taking
  appropriate action, e.g., complete the Request to the host as a
  failed transaction.

I reported this to the PCI-SIG, and I think the formatting did get
fixed for the upcoming PCIe r6 spec, so the meaning will be the same
as r4.0

Probably doesn't affect this patch, but we can clarify some of the
commentary.

Bjorn

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A41D6A7AC2
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 07:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfIDFf0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 01:35:26 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:45307 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfIDFf0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 01:35:26 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6318A101C0753;
        Wed,  4 Sep 2019 07:35:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0BD23CDF; Wed,  4 Sep 2019 07:35:24 +0200 (CEST)
Date:   Wed, 4 Sep 2019 07:35:23 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, rafael.j.wysocki@intel.com,
        keith.busch@intel.com
Subject: Re: [PATCH 2/2] PCI: Unify pci_dev_is_disconnected() and
 pci_dev_is_inaccessible()
Message-ID: <20190904053523.7lmuoo5zempxtsdq@wunner.de>
References: <20190904043633.65026-1-skunberg.kelsey@gmail.com>
 <20190904043633.65026-3-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904043633.65026-3-skunberg.kelsey@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 03, 2019 at 10:36:35PM -0600, Kelsey Skunberg wrote:
> Change pci_dev_is_disconnected() call inside pci_dev_is_inaccessible() to:
> 
> 	pdev->error_state == pci_channel_io_perm_failure
> 
> Change remaining pci_dev_is_disconnected() calls to
> pci_dev_is_inaccessible() calls.

I don't think that's a good idea because it introduces a config space read
(for the vendor ID) in places where we don't want that.  E.g., after the
check of pdev->error_state, a regular config space read may take place and
if that returns all ones, we may already be able to determine that the
device is inaccessible, obviating the need for a vendor ID check.
Config space reads aren't for free.

Thanks,

Lukas

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF3EC134EC6
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 22:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgAHVXt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 16:23:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbgAHVXt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jan 2020 16:23:49 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C99A3206DA;
        Wed,  8 Jan 2020 21:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578518629;
        bh=3o5eOcLo/avT4KVRkLtp/ebecyBmOIz2OoTMExZnZ9U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GAX6U5ZBSBhfL3of/JrrGOM3VkfXHC0Ss6T3n1cfux8OJShjKueO2kB2yRotSJ2JG
         cb/qlF+pkp5jeUvFR4uziYwmdoHfZyAFTpJviZDePo0wo7AHQNa59J4DlnuNq9uotN
         Yw8F3fAQ3mX05uPqYGK3D5g1xAVNsdzVmFzMwXB8=
Date:   Wed, 8 Jan 2020 15:23:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>
Subject: Re: [PATCH 09/12] PCI/switchtec: Add gen4 support in struct
 flash_info_regs
Message-ID: <20200108212347.GA207738@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106190337.2428-10-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 06, 2020 at 12:03:34PM -0700, Logan Gunthorpe wrote:
> From: Kelvin Cao <kelvin.cao@microchip.com>
> 
> Add a union with gen3 and gen4 flash_info structs.

This does a lot more than add a union :)

I think this looks reasonable, but I would like it even better if this
and related patches could be split up a little bit differently:

  - Rename SWITCHTEC_CFG0_RUNNING to SWITCHTEC_GEN3_CFG0_RUNNING, etc
    (purely mechanical change, so trivial and obvious).

  - Add switchtec_gen and the tests where it's needed, but with only
    SWITCHTEC_GEN3 cases for now.

  - Refactor ioctl_flash_part_info() (still only supports GEN3).
    Maybe adds struct flash_info_regs and union, but only with gen3.

  - Add GEN4 support (patch basically contains only GEN4-related
    things and doesn't touch GEN3 things at all).  Maybe it would
    still make sense to split the GEN4 support into multiple patches
    (as in this series), or maybe they could be squashed into a single
    GEN4 patch?

  - It seems like at least the aliasing quirk and the driver device ID
    update could/should be squashed since they contain the same
    constants.

Bjorn

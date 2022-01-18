Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29A2491F50
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 07:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbiARGQp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jan 2022 01:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiARGQp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jan 2022 01:16:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A72C061574;
        Mon, 17 Jan 2022 22:16:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B11CD611ED;
        Tue, 18 Jan 2022 06:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2160FC00446;
        Tue, 18 Jan 2022 06:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642486604;
        bh=0Rn0IkkQ4B47dDn5jDXXBcK5X/wRnR0ECfiVjnMdYkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LY2Rizf6BcW3RcZcctLr7wR+zJVgMvo5wOhFSGhnzG7gufhb5dNJS1z5SqMLrHXuF
         I56uMcYTIWwPFlRDOQWjSQgtJSvynNF+DIQf+EfbMb0h+5bE/K5EMyc0bHht87izAa
         DODroLx25pgnfAsVfeLXYBR8HeWTVKrUpFktoY+A=
Date:   Tue, 18 Jan 2022 07:16:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <kbusch@kernel.org>, kw@linux.com,
        mariusz.tkaczyk@linux.intel.com, helgaas@kernel.org,
        lukas@wunner.de, pavel@ucw.cz, linux-cxl@vger.kernel.org,
        martin.petersen@oracle.com, James.Bottomley@hansenpartnership.com,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/3] Add support for seven more indicators in
 enclosure driver
Message-ID: <YeZbSGPqHaSnNurq@kroah.com>
References: <cover.1642460765.git.stuart.w.hayes@gmail.com>
 <de41441fa835af52ac53a08013534e0cdd448aa9.1642460765.git.stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de41441fa835af52ac53a08013534e0cdd448aa9.1642460765.git.stuart.w.hayes@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 17, 2022 at 10:17:56PM -0600, Stuart Hayes wrote:
> This patch adds support for seven additional indicators (ok, rebuild,
> prdfail, hotspare, ica, ifa, disabled) to the enclosure driver, which
> currently only supports three (fault, active, locate). It also reduces
> duplicated code for the set and show functions for the sysfs attributes
> for all of the indicators, and allows users of the driver to provide
> common get_led and set_led callbacks to control all indicators (though
> it continues to support the existing callbacks for the three currently
> supported indicators, so it does not require any changes to code that
> already uses the enclosure driver).
> 
> This will be used by the pcie_em driver.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
>  drivers/misc/enclosure.c  | 189 ++++++++++++++++++++++----------------
>  include/linux/enclosure.h |  22 +++++
>  2 files changed, 133 insertions(+), 78 deletions(-)

You did not document your new sysfs files in Documentation/ABI/ anywhere
:(


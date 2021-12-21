Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5591847BCC2
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 10:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhLUJUN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 04:20:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42588 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbhLUJUM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 04:20:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51B02B8122D;
        Tue, 21 Dec 2021 09:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C04C36AE2;
        Tue, 21 Dec 2021 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640078410;
        bh=P1yCCErD4lYWu0EijWCZ4FDcQAXFbefAwLxWZZoGCyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hs9Q/TkC/LQxeWIhrP+QGH0wT//ifVTvZ8zutDvv/3S0EFcP3/b91tttMUGsxDwgF
         2sg0bnBwJfURz6LbptKTJX7t+jbuZaOpHg52F4OKK9vc2QHpWpCRn98/qqN7mZw0+b
         5ab3vh9tZCWkCwKNk0ADZG9pZj1dhmT4td6xi1eU=
Date:   Tue, 21 Dec 2021 10:20:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH V4 2/6] driver core: auxiliary bus: Add driver data
 helpers
Message-ID: <YcGcR7dLDD7avsnn@kroah.com>
References: <20211216023146.2361174-1-david.e.box@linux.intel.com>
 <20211216023146.2361174-3-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216023146.2361174-3-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 15, 2021 at 06:31:42PM -0800, David E. Box wrote:
> Adds get/set driver data helpers for auxiliary devices.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Mark Gross <markgross@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

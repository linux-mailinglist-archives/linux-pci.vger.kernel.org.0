Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A84F41E828
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 09:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352439AbhJAHRS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 03:17:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352455AbhJAHRS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 03:17:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D1D761A78;
        Fri,  1 Oct 2021 07:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633072534;
        bh=7tLksBjLHIjOYFk7RpbenN4oSlWAYWTt2/vJy5WXE7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oi8qdVkPGlLauTw+oOIdq8+yDeCROhHRFVqlgL1G/LQ1PotMKTmqoMWGaUONMOEaG
         uTEL6xHBJA3TFsRm01BFz1VLKhu6uEAG0PyeO4Rf45yAseu7+LlP/oQKoOhNIG4Idb
         02h515OkbKv5dWUk2WyPPuy/iClgE+SYbnNpgIq4=
Date:   Fri, 1 Oct 2021 09:15:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <YVa1k/SsJ4GQN6bp@kroah.com>
References: <20211001012815.1999501-1-david.e.box@linux.intel.com>
 <20211001012815.1999501-6-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001012815.1999501-6-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 06:28:15PM -0700, David E. Box wrote:
> @@ -0,0 +1,28 @@
> +What:		/sys/class/misc/isdsi-<x>

Shouldn't that be:
			/sys/class/misc/idsi-X
?

Also, why the "-"?  What needs that?

thanks,

greg k-h

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBDB458947
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 07:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhKVGY4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 01:24:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhKVGYz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Nov 2021 01:24:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AD5560E08;
        Mon, 22 Nov 2021 06:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637562109;
        bh=fzsRN4izc+0jRBS7aC+AnWDJdXqUSKg6OSnIdhhFAxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1neIeXxphTLVqAMO4AQgvcHh8s03h+MeFaPz/RpjL2BobhAbGpta6xGAkP7grzRl
         MEmsMHSHhsCd0I4/E6EYJvVYv4QZIdLaV1mtJlafgIz/xhloLSeBq1PWbyLTgOt2Er
         LdfnBC3V6VXeePIONb7cClfQkrFCIAyws4oWKNiA=
Date:   Mon, 22 Nov 2021 07:21:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <YZs28g87GE3XgAKk@kroah.com>
References: <20211120231705.189969-1-david.e.box@linux.intel.com>
 <20211120231705.189969-5-david.e.box@linux.intel.com>
 <YZo8HUxx8LNgOMeK@kroah.com>
 <4d8ba355de09a4a806b6075305ca8d7156dc70ef.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8ba355de09a4a806b6075305ca8d7156dc70ef.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 21, 2021 at 09:18:25AM -0800, David E. Box wrote:
> > These sysfs attributes are crazy.  Who has audited them to be correct
> > and work properly? It feels like there are just buffer overflows
> > waiting to be exploited in them due to the reading/writing of raw memory
> > buffers all over the place.
> 
> Agree with the concern. I can submit the tests that were used. Is selftests the
> best place?

Yes.

> > Where is the userspace tool that uses these files?
> 
> The tool will be published in the same github repo as the spec once the driver
> is ready.

Isn't the driver "ready" if you are asking for it to be accepted
here?  Why isn't it published already so we can see if it actually is
tested?

thanks,

greg k-h

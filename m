Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7A0419D0D
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 19:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbhI0Rjz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 13:39:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238738AbhI0RiQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Sep 2021 13:38:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F66860F46;
        Mon, 27 Sep 2021 17:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632764198;
        bh=cP3s6aDUKuJ74VUE2WurSFHqrO+qVFHHxo5OhXp17R4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MctZJzQgcuxlGwAs8FLPaxQ7FBicQIe0pm6Rzbh5NhzW/KR3M13WYt6x8sT9zsuvS
         1ri6rDbQ1SHtnYf8p1bJz1kypnaDlueV1kqm9zcSua8Qx3hN4WT6VMPDyngLtIEmT6
         JskxNOb2ykkg8F9smUzKNFUqHG6c+0s8EEOCkk/w=
Date:   Mon, 27 Sep 2021 19:36:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, bhelgaas@google.com,
        andy.shevchenko@gmail.com, mgross@linux.intel.com,
        srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/5] MFD: intel_pmt: Support non-PMT capabilities
Message-ID: <YVIBI6TQrD/rehli@kroah.com>
References: <20210922213007.2738388-1-david.e.box@linux.intel.com>
 <20210922213007.2738388-3-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922213007.2738388-3-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 22, 2021 at 02:30:04PM -0700, David E. Box wrote:
> Intel Platform Monitoring Technology (PMT) support is indicated by presence
> of an Intel defined PCIe DVSEC structure with a PMT ID. However DVSEC
> structures may also be used by Intel to indicate support for other
> capabilities unrelated to PMT.  OOBMSM is a device that can have both PMT
> and non-PMT capabilities. In order to support these capabilities it is
> necessary to modify the intel_pmt driver to handle the creation of platform
> devices more generically.

I said this on your other driver submission, but why are you turning a
PCIe device into a set of platform devices and craming it into the MFD
subsystem?

PCIe devices are NOT platform devices.

Why not use the auxiliary bus for this thing if you have individual
drivers that need to "bind" to the different attributes that this single
PCIe device is exporting.

Or why not just fix the hardware to report individual PCIe devices, like
a sane system would do?  Has this shipped in any devices yet?  If not,
can that be fixed first?  It's just a firmware change, right?

thanks,

greg k-h

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1198727A543
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 03:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgI1BrP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 21:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgI1BrP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 21:47:15 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00F2D23A33;
        Mon, 28 Sep 2020 01:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601257634;
        bh=wl9uadR/O5hDseMDXPYnhwPCJojmECIbpMp6D1e2udM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=2lh1duhWFfmHf4NlNWF5s1sBothSPDiDnXOIV05ed6sS2F4L1+EV9Z1bw/fotNr03
         /Kqsip5Z0Ud9FPrO+RpeSA9OQoyLEt8awlo40L4Hau3C32yoaRtNVTdAHoBl59f4ku
         N7ULaS+CMARBTW9dBIQLiIJ5dLAvGqEP5uA720cM=
Date:   Sun, 27 Sep 2020 20:47:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <seanvk.dev@oregontracks.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: Re: [PATCH v6 07/10] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Message-ID: <20200928014711.GA2475864@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927234545.GA2470139@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 27, 2020 at 06:45:45PM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 22, 2020 at 02:38:56PM -0700, Sean V Kelley wrote:
> > From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

> >  	pci_dbg(dev, "broadcast error_detected message\n");
> >  	if (state == pci_channel_io_frozen) {
> > -		pci_bridge_walk(bridge, report_frozen_detected, &status);
> > +		pci_bridge_walk(bridge, dev, report_frozen_detected, &status);
> >  		if (type == PCI_EXP_TYPE_RC_END) {
> > +			/*
> > +			 * The callback only clears the Root Error Status
> > +			 * of the RCEC (see aer.c).
> > +			 */
> > +			if (bridge)
> > +				reset_subordinate_devices(bridge);
> 
> It's unfortunate to add yet another special case in this code, and I'm
> not thrilled about the one in aer_root_reset() either.  It's just not
> obvious why they should be there.  I'm sure if I spent 30 minutes
> decoding things, it would all make sense.  Guess I'm just griping
> because I don't have a better suggestion.

I'm sorry, this was unkind of me.  If I don't have a constructive
idea, there's no reason for me to complain about this.  I apologize.

Bjorn

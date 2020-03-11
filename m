Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47AD618246A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 23:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgCKWFf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 18:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbgCKWFf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 18:05:35 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E0E820739;
        Wed, 11 Mar 2020 22:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583964335;
        bh=ycz1YvJMQ8Djb+Q4YGZvnbsSd5DxIIjDJvR0r4AEbac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HZRZE7SLa+VlCrTowruUOD6ZZLZ9oC+Z0wksNaUGoxSRAG+oNNxNQ8n0LNh/4R0oX
         YU6hWt/vqCumtq3KNLfMf/QYqXJQryQI9CSXvaGfUOOs0KxqOVPaYSKpV6172MSk8Q
         UPBAwRyK0+mfSlgtmShwfYs2ouICUKdO9Wdpkt3c=
Date:   Wed, 11 Mar 2020 17:05:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Austin.Bolen@dell.com
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Message-ID: <20200311220533.GA196637@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38277b0f6c2e4c5d88e741b7354c72d1@AUSX13MPC107.AMER.DELL.COM>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 10, 2020 at 08:06:21PM +0000, Austin.Bolen@dell.com wrote:
> On 3/10/2020 2:33 PM, Bjorn Helgaas wrote:

> > If that's possible, it would be nice to update the metadata for the
> > "Downstream Port Containment related Enhancements" ECN as well.  That
> > one currently says "ECR - CardBus Header Proposal", which means that's
> > what's in the window title bar and icons in the panel.
> 
> Sure, I'll check.

FWIW, the PCI Firmware Specification, Rev 3.2, dated "Final - Jan 28,
2019" also has the same metadata problem.

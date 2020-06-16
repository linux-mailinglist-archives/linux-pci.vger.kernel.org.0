Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2E71FABDF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 11:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgFPJHl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 05:07:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:2617 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgFPJHk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 05:07:40 -0400
IronPort-SDR: ORynIPXiuOq7oa4qOgs/KQ6t5Qy3jcQwdkPfUL/B6IlXl78m5q97s8VkbP+gQ/rm5j1dI47jHG
 28fmSYgLOo3Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 02:07:38 -0700
IronPort-SDR: TQ1XfkGEeoeoG4hDHkgXQaJRHgshwos39SDaXXPyBzCZNxU7kRC1aXIkgF7e87jzOUFOtjhI6l
 rgry9sdwiD5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="382814431"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 16 Jun 2020 02:07:31 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 16 Jun 2020 12:07:30 +0300
Date:   Tue, 16 Jun 2020 12:07:30 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com
Subject: Re: [PATCH 2/4] pci: set "untrusted" flag for truly external devices
 only
Message-ID: <20200616090730.GF2795@lahna.fi.intel.com>
References: <20200616011742.138975-1-rajatja@google.com>
 <20200616011742.138975-2-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616011742.138975-2-rajatja@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 15, 2020 at 06:17:40PM -0700, Rajat Jain wrote:
> The "ExternalFacing" devices (root ports) are still internal devices
> that sit on the internal system fabric and thus trusted. Currently they
> were being marked untrusted - likely as an unintended border case.

It was actually intentional :) At the time this was added we did not see
benefits from doing this and even with this you actually are going to
still miss things like a TBT chip that is soldered on the motherboard, I
guess that can be though as an internal device as well.

No objections to this patch, though.

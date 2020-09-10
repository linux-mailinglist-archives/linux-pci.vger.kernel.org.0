Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B092652A1
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 23:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgIJVVd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 17:21:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:40121 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731119AbgIJOYb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 10:24:31 -0400
IronPort-SDR: jmOscCHg/TTvf8rIDBO7t2S+m+u1jNu+XnYmxlE9EqyNkDqrcDXC9qIqJ7h4NvwyHIZpTlY9jb
 sPgdGI5JgBMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="138055053"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="138055053"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 07:24:09 -0700
IronPort-SDR: WET8H64c4x7IEXx5V/iUqRZ9bvP3XNfbc3hHzyckkiJ3Ve90l304dNL5sJr90s1Fyd1Ar35rcb
 LzWXf96Ouy/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="407773045"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 10 Sep 2020 07:24:06 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 10 Sep 2020 17:24:05 +0300
Date:   Thu, 10 Sep 2020 17:24:05 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Patrick Volkerding <volkerdi@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Ben Skeggs <bskeggs@redhat.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add a quirk to skip 1000 ms default link activation
 delay on some devices
Message-ID: <20200910142405.GO2495@lahna.fi.intel.com>
References: <20200907084349.GZ2495@lahna.fi.intel.com>
 <20200910010026.GA743553@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910010026.GA743553@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Sep 09, 2020 at 08:00:26PM -0500, Bjorn Helgaas wrote:
> Can you please ask them again?

I pinged them again and this time got confirmation that it is known
issue in Alpine Ridge and Titan Ridge, and beyond. They are looking for
a firmware fix for the next controller which could then be backported to
Alpine and Titan Ridge firmwares.

So let's hold this patch for now.

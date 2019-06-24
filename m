Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3813750976
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 13:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfFXLJx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 07:09:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:29468 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbfFXLJx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 07:09:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 04:09:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,411,1557212400"; 
   d="scan'208";a="182614778"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 24 Jun 2019 04:09:50 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 24 Jun 2019 14:09:49 +0300
Date:   Mon, 24 Jun 2019 14:09:49 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Logan Gunthorpe <logang@deltatee.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] PCI: Simplify
 pci_bus_distribute_available_resources()
Message-ID: <20190624110949.GI2640@lahna.fi.intel.com>
References: <20190622210310.180905-1-helgaas@kernel.org>
 <20190622210310.180905-2-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622210310.180905-2-helgaas@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 22, 2019 at 04:03:10PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Reorder pci_bus_distribute_available_resources() to group related code
> together.  No functional change intended.
> 
> Link: https://lore.kernel.org/r/PS2P216MB0642C7A485649D2D787A1C6F80000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
> Based-on-patch-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> [bhelgaas: extracted from larger patch]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

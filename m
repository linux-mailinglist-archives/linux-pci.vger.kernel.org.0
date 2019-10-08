Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82498CF5D0
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 11:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfJHJQA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 05:16:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:25437 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730163AbfJHJP7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Oct 2019 05:15:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 02:15:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="206604584"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 08 Oct 2019 02:15:54 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 08 Oct 2019 12:15:53 +0300
Date:   Tue, 8 Oct 2019 12:15:53 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] thunderbolt: Fixes for few reported issues
Message-ID: <20191008091553.GZ2819@lahna.fi.intel.com>
References: <20191001102905.21680-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001102905.21680-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 01, 2019 at 01:29:02PM +0300, Mika Westerberg wrote:
> Mika Westerberg (3):
>   thunderbolt: Read DP IN adapter first two dwords in one go
>   thunderbolt: Fix lockdep circular locking depedency warning
>   thunderbolt: Drop unnecessary read when writing LC command in Ice Lake

Applied to thunderbolt.git/fixes.

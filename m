Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B22DD08EF
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 09:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfJIH4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 03:56:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:11372 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfJIH4z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Oct 2019 03:56:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 00:56:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; 
   d="scan'208";a="206825677"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 09 Oct 2019 00:56:51 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 09 Oct 2019 10:56:50 +0300
Date:   Wed, 9 Oct 2019 10:56:50 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     AceLan Kao <acelan@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 205119] New: It takes
 long time to wake up from s2idle on Dell XPS 7390 2-in-1]
Message-ID: <20191009075650.GM2819@lahna.fi.intel.com>
References: <20191008164232.GA173643@google.com>
 <20191009040534.GL2819@lahna.fi.intel.com>
 <CAMz9Wg_8ZYkw1f3MyqcqNMBajJ_Q+qwojQhg8WqiPTPeUSNXZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMz9Wg_8ZYkw1f3MyqcqNMBajJ_Q+qwojQhg8WqiPTPeUSNXZQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 09, 2019 at 03:50:25PM +0800, AceLan Kao wrote:
> Right, the issue happens after we backport some ICL thunderbolt
> patches to 5.3 kernel.

Does it happen only with backported patches or does it also happen with
the mainline?

> There is a new BIOS v1.0.13 on dell website, but it requires windows
> to upgrade it, I'll try it later.

OK, thanks.

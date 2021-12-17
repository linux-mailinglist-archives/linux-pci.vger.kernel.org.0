Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5091478924
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 11:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhLQKoz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Dec 2021 05:44:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:34276 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231860AbhLQKoz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Dec 2021 05:44:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="227016471"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="227016471"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 02:44:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="466462281"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga006.jf.intel.com with SMTP; 17 Dec 2021 02:44:52 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 17 Dec 2021 12:44:51 +0200
Date:   Fri, 17 Dec 2021 12:44:51 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: [REGRESSION] 527139d738d7 ("PCI/sysfs: Convert "rom" to static
 attribute")
Message-ID: <YbxqIyrkv3GhZVxx@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

The pci sysfs "rom" file has disappeared for VGA devices.
Looks to be a regression from commit 527139d738d7 ("PCI/sysfs:
Convert "rom" to static attribute").

Some kind of ordering issue between the sysfs file creation 
vs. pci_fixup_video() perhaps?

-- 
Ville Syrjälä
Intel

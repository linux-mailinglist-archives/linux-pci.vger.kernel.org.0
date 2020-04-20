Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C75B1B0C82
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 15:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgDTNWl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 09:22:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:42051 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgDTNWk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 09:22:40 -0400
IronPort-SDR: lhDEE8klMqhLTr3TPKT0D9gW2uRny0wY8aBwd/abA8vOJQP7+H6svKgT+KEDY+qJti/AnTzbB1
 OficZgfvJZOQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 06:22:40 -0700
IronPort-SDR: PeGJZA2MzhkNRfrAVh8yjEp+463QXYYvePMXLZMrN51m4X7nA5DJF4mpnLi6I4xGnE4vOdDj/W
 oiXpXRMmmfLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="365001566"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 20 Apr 2020 06:22:37 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 20 Apr 2020 16:22:36 +0300
Date:   Mon, 20 Apr 2020 16:22:36 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Ani Sinha <ani@anisinha.ca>
Cc:     linux-kernel@vger.kernel.org, ani@anirban.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Denis Efremov <efremov@linux.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: remove unused EMI() macro
Message-ID: <20200420132236.GB2586@lahna.fi.intel.com>
References: <1587387114-38475-1-git-send-email-ani@anisinha.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587387114-38475-1-git-send-email-ani@anisinha.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 20, 2020 at 06:21:41PM +0530, Ani Sinha wrote:
> EMI() macro seems to be unused. So removing it. Thanks
> Mika Westerberg <mika.westerberg@linux.intel.com> for
> pointing it out.
> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

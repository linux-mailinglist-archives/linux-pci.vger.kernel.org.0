Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E9126E28E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 19:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIQRgH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 13:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgIQRgD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 13:36:03 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32EE120872;
        Thu, 17 Sep 2020 17:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600364162;
        bh=pQ2d3xUG+lg0YXCMHik9NNJ6W4wrVHGbWlacbW7wfhM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=G/dz3TtBCB4ml2y3c1cQdks3tzzx9CMDDZyfF7dqp1AXfg4TmcPaWCzoRq0O4UUrg
         gn4hdMB8L3fG7t542Qu8V66oCaGceHZOJey19hFduv9nOKxbrQ/qnefx7L/fnGm9Jt
         Pn6STyRi2yEORXtjb0SmIIHm1YglnC6KDywsMBKU=
Date:   Thu, 17 Sep 2020 12:36:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@intel.com>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 00/10] Add RCEC handling to PCI/AER
Message-ID: <20200917173600.GA1706067@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917162548.2079894-1-sean.v.kelley@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 17, 2020 at 09:25:38AM -0700, Sean V Kelley wrote:
> Changes since v3 [1]:

This series claims "V4 00/10", i.e., there should be this cover letter
plus 10 patches, but I only got 3 patches.  I don't know if some got
lost, or if only those 3 patches were updated, or what?  If it's the
latter, it's too hard for me to collect the right versions of
everything into a single series.

Either way, can you resend the entire series as a V5?

Bjorn

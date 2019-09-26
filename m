Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57B0BBFB21
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 23:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfIZVrs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 17:47:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfIZVrs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Sep 2019 17:47:48 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B47920835;
        Thu, 26 Sep 2019 21:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569534467;
        bh=CUtsMY/ddf2XOeF3tW6tq3ghiSZNTVgm3jplb/AVHwE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=k/n+pnRCzo1G659Oh9iStjKnDfg+UEvprDF4XgnVGkQKEbrXuflHppJ1zGUE7V0yL
         Yh72L6y8M6qIfVF0XLM8UscC80T4NxH/DOvbqDfUNS7vE2sA+/LDhI4D4OeOk4P7uK
         j4Qaqp6VEkp3DOQ4AXmpyC89WH5QhLEnKNfmwQYQ=
Date:   Thu, 26 Sep 2019 16:47:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Megha Dey <megha.dey@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pci@vger.kernel.org, maz@kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, hpa@zytor.com,
        alex.williamson@redhat.com, jgg@mellanox.com, ashok.raj@intel.com,
        megha.dey@intel.com, jacob.jun.pan@intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Subject: Re: [RFC V1 7/7] ims: Add the set_desc callback
Message-ID: <20190926214746.GA197766@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568338328-22458-8-git-send-email-megha.dey@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 12, 2019 at 06:32:08PM -0700, Megha Dey wrote:
> Add the set_desc callback to the ims domain ops.

Elsewhere you capitalize "IMS" when it's an initialism.

Generally you capitalized "IRQ" and "MSI" in similar situations, but
there are a couple exceptions (in other commit logs).

> The set_desc callback is used to find a unique hwirq number from a given
> domain.
> 
> Each mdev can have a maximum of 2048 IMS interrupts.

Maybe you could mention where this limit comes from and whether it's
related to any #define in these patches?

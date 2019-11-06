Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFD3DF1E23
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 20:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731983AbfKFTCx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 14:02:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:48228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbfKFTCx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 14:02:53 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7E5220869;
        Wed,  6 Nov 2019 19:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573066972;
        bh=+8TaTPP+s7V+bVyZM+p1huKbxLpHumxhlcmvA+KgfoI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RH9E3HRrbnyNisCfWjcCsSlXQculBNgWbDTA88JGU+YwV6938EzsZVUAa+IJEoLm+
         +O8E3ykFBgKavdcmMSG6KxkkC+19KeuEmT6fYTLk6WF1EYNHA9PZej8CoAkdkSkiTH
         Wjp72nedyML4MlaBk+CZ1+SCws9FcDPTRu0CGI5Y=
Date:   Wed, 6 Nov 2019 13:02:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/5] PCI: PM: Cleanups related to power state changes
Message-ID: <20191106190250.GA238633@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2771503.n70vfTtcVb@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 05, 2019 at 11:11:57AM +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> This series rearranges some PCI power management code to make it somewhat
> easier to follow and explicitly consolidate the power-up (transitions to
> D0) code path.
> 
> It is not intended to change the functionality of the code.

Applied with Mika's reviewed-by to pci/pm for v5.5, thanks!

Thanks for the git tips, too!

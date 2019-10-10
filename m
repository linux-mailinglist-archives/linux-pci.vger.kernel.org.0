Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 625DAD2E65
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 18:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfJJQOV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Oct 2019 12:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfJJQOV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Oct 2019 12:14:21 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44118208C3;
        Thu, 10 Oct 2019 16:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570724060;
        bh=FAVk8gKLODf5YWnYfPHlctJQwGl0YhqkTGhjRC/RqsU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uQtOtVeF2sLlaukbORqJxciQvRrLcp3kWiz/Sz6arfB4ukY5c1rhpODOSHY9kbUbO
         sXvmB8z8UuCDA4ly22WRfROejwODMbrh/c+fuw3WM6I1LDfEksb/iwm4PRFceuyT1K
         RcP8aYPKlkFKiFjoVyWKd17mpeYjBBUP8HdrJlUM=
Date:   Thu, 10 Oct 2019 11:14:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajat Jain <rajatja@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/1] PCI/ASPM: Remove pcie_aspm_enabled() unnecessary
 locking
Message-ID: <20191010161417.GA14520@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010140121.GA31701@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 10, 2019 at 04:01:21PM +0200, Christoph Hellwig wrote:
> On Thu, Oct 10, 2019 at 07:47:46AM -0500, Bjorn Helgaas wrote:
> > +	return bridge->link_state ? !!bridge->link_state->aspm_enabled : false;
> 
> Can we unobsfucated this while we're at it?
> 
> 	if (!bridge->link_state)
> 		return false;
> 	return bridge->link_state->aspm_enabled;

Yep, after some of the follow-up patches from Heiner, it looks like
this:

  bool pcie_aspm_enabled(struct pci_dev *pdev)
  {
	  struct pcie_link_state *link = pcie_aspm_get_link(pdev);

	  if (!link)
		  return false;

	  return link->aspm_enabled;
  }


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A73B01969B6
	for <lists+linux-pci@lfdr.de>; Sat, 28 Mar 2020 22:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgC1V7h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Mar 2020 17:59:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbgC1V7g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Mar 2020 17:59:36 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CE5D20716;
        Sat, 28 Mar 2020 21:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585432776;
        bh=TJQNNNUrxwxkezcw+o1TImgPX2h+TQZnX0XsTPVXzH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eTQB6swGvhP3Yhfxa/oUg/sQ2yH0VWbH9leNAJ0j4qMfdwJxdpqg6jkOpjwoam2Wm
         zNEsAPfcq/HkldKoYNVr/+AYfgKj4o+vzrCjEd2uC7EdH1sTUFem60THbJ6/GeFuHZ
         cQ9JM5gY7Mv5zfR/PZXrDoQOdwviPK6J9BgT7Sec=
Date:   Sat, 28 Mar 2020 16:59:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Raymond Pang <RaymondPang-oc@zhaoxin.com>
Cc:     linux-pci@vger.kernel.org, TonyWWang-oc@zhaoxin.com,
        linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/3] Add ACS quirk for Zhaoxin
Message-ID: <20200328215934.GA132824@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327091148.5190-1-RaymondPang-oc@zhaoxin.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex]

On Fri, Mar 27, 2020 at 05:11:45PM +0800, Raymond Pang wrote:
> Lots of Zhaoxin PCIe components have no ACS Capability Structure,
> but do have ACS-like capability which ensures DMA isolation.
> This patch makes isolated devices could be directly assigned to
> different VMs through IOMMU.
> 
> Raymond Pang (3):
>   PCI: Add Zhaoxin Vendor ID
>   PCI: Add ACS quirk for Zhaoxin's multi-function devices
>   PCI: Add ACS quirk for Root/Downstream Ports
> 
>  drivers/pci/quirks.c    | 30 ++++++++++++++++++++++++++++++
>  include/linux/pci_ids.h |  2 ++
>  2 files changed, 32 insertions(+)

Applied to pci/virtualization for v5.7, thanks!

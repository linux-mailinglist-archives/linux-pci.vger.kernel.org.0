Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102B8301A3B
	for <lists+linux-pci@lfdr.de>; Sun, 24 Jan 2021 07:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbhAXGiO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Jan 2021 01:38:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbhAXGh7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 24 Jan 2021 01:37:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E147E22C7E;
        Sun, 24 Jan 2021 06:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611470238;
        bh=d6qvR+/rxa5xe/EYKj1H8t2pZktQ0bAYGIOrwlTg0Lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YJTAL3WQMBotzhsJNFxTgxc/BD1MjoapwcYftt+7qhibK4Kcw6gorfKI83LqXni6Q
         DB0KXN+Xh0u1WDKAc8x9DZkONfhBDlpZ1B2eDHcAxmlX+2Y5lWEFc+aRdr1WLOh4L/
         fA4mLf7+kzbJWgZ9Tjp0DMT0lRTLK2Cak2e8hYi3m88sqJ8y8LsKHfViDVytdVTn94
         zxwumAx5EaTjpp56Ie9DN8GoGbp7KR3+O6II+zUCsLWaHxem9sVPZzHpBRcxl9fqoN
         yfhUA1yLdqMgU31DyWM9KN2nhj+rn2+/Kd/U9xn2v5loRUSDh/xLdhUVX0c8HPoqit
         GCGAifKBnPn8Q==
Date:   Sun, 24 Jan 2021 07:39:12 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: free of node in pci_scan_device's error path
Message-ID: <20210124053912.GA4742@unreal>
References: <20210123005838.3623618-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123005838.3623618-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 23, 2021 at 03:58:38AM +0300, Dmitry Baryshkov wrote:
> In the pci_scan_device() if pci_setup_device() fails for any reason, the
> code will not release device's of_node by calling pci_release_of_node().
> Fix that by calling the release function.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: 98d9f30c820d ("pci/of: Match PCI devices to OF nodes dynamically")

Fixes should come before your SOB, otherwise many static checkers will
report the current format as an error.

Thanks

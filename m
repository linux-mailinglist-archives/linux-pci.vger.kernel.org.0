Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0CC466936
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 18:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242172AbhLBRgT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 12:36:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57480 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbhLBRgT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 12:36:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4A0762751
        for <linux-pci@vger.kernel.org>; Thu,  2 Dec 2021 17:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A937EC00446;
        Thu,  2 Dec 2021 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638466376;
        bh=QyQJtSXxM+TYjlQf7lICsGPa6sN8ZRNbRCAzNpdhP0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WwPrC587VW9GaNqe5a0rft4PHTf5J3AH92GubuTNe55kAfgOC/KagI+6vMYkujeJU
         Jw+XHpOO6kNByb+uBBhq4mwJD/YuWib8lclf881am+o09YFcHV4AIfk1503LVo3KsS
         l2PCwcGdTZWGjO9FQVg4gEuScgg+3zN4NAtRtr+yctzb3m6Oa8OOw26M59frTj6FFJ
         pwUQOKGm7Hz7jHaG1RNTiBZwgF+Nb20IKXgYmNpS8UF5ny2gD6NtgxAMKUpntfU0ql
         tnJtZ8sj5431VH/0X66OZP8oCR66cq8SMioiyEYg8L8Xc0h6GpPEtYSFlSzubPZ7lW
         Hy6WqGR6dV8cQ==
Date:   Thu, 2 Dec 2021 09:32:53 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     lorenzo.pieralisi@arm.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        jonathan.derrick@linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI: vmd: Clean up domain before enumeration
Message-ID: <20211202173253.GB3836713@dhcp-10-100-145-180.wdc.com>
References: <20211116221136.85134-1-nirmal.patel@linux.intel.com>
 <d3fdae61-1151-22f3-31f5-45f29ce2f24e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3fdae61-1151-22f3-31f5-45f29ce2f24e@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 02, 2021 at 09:38:26AM -0700, Patel, Nirmal wrote:
> Gentle ping. Please let me know if you are okay with these changes (with Jon's Reviewed-by). Thanks.

Your patch is already staged for the next merge window here:

  https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?h=pci/vmd&id=6aab5622296b990024ee67dd7efa7d143e7558d0
